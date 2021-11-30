Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E809462BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 06:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhK3FFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 00:05:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:26850 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhK3FFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:05:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234868487"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="234868487"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 21:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="609001861"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2021 21:02:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrvHh-000ClU-IX; Tue, 30 Nov 2021 05:02:29 +0000
Date:   Tue, 30 Nov 2021 13:02:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 2/5] tracing: Disable preemption when using the filter
 buffer
Message-ID: <202111301209.GarWNR3z-lkp@intel.com>
References: <20211130024318.880190623@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130024318.880190623@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on linux/master hnaz-mm/master linus/master v5.16-rc3 next-20211129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Steven-Rostedt/tracing-Various-updates/20211130-104342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211130/202111301209.GarWNR3z-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1ac91c8764ae50601cd41dceb620205607ab59f6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Steven-Rostedt/tracing-Various-updates/20211130-104342
        git checkout 1ac91c8764ae50601cd41dceb620205607ab59f6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'trace_event_buffer_lock_reserve':
>> kernel/trace/trace.c:2769:21: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
    2769 |                 if (entry = __this_cpu_read(trace_buffered_event)) {
         |                     ^~~~~
   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3820:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3820 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3887:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3887 |                 trace_seq_vprintf(&iter->seq, p, ap);
         |                 ^~~~~~~~~~~~~~~~~


vim +2769 kernel/trace/trace.c

  2736	
  2737	struct ring_buffer_event *
  2738	trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
  2739				  struct trace_event_file *trace_file,
  2740				  int type, unsigned long len,
  2741				  unsigned int trace_ctx)
  2742	{
  2743		struct ring_buffer_event *entry;
  2744		struct trace_array *tr = trace_file->tr;
  2745		int val;
  2746	
  2747		*current_rb = tr->array_buffer.buffer;
  2748	
  2749		if (!tr->no_filter_buffering_ref &&
  2750		    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
  2751			preempt_disable_notrace();
  2752			/*
  2753			 * Filtering is on, so try to use the per cpu buffer first.
  2754			 * This buffer will simulate a ring_buffer_event,
  2755			 * where the type_len is zero and the array[0] will
  2756			 * hold the full length.
  2757			 * (see include/linux/ring-buffer.h for details on
  2758			 *  how the ring_buffer_event is structured).
  2759			 *
  2760			 * Using a temp buffer during filtering and copying it
  2761			 * on a matched filter is quicker than writing directly
  2762			 * into the ring buffer and then discarding it when
  2763			 * it doesn't match. That is because the discard
  2764			 * requires several atomic operations to get right.
  2765			 * Copying on match and doing nothing on a failed match
  2766			 * is still quicker than no copy on match, but having
  2767			 * to discard out of the ring buffer on a failed match.
  2768			 */
> 2769			if (entry = __this_cpu_read(trace_buffered_event)) {
  2770				int max_len = PAGE_SIZE - struct_size(entry, array, 1);
  2771	
  2772				val = this_cpu_inc_return(trace_buffered_event_cnt);
  2773	
  2774				/*
  2775				 * Preemption is disabled, but interrupts and NMIs
  2776				 * can still come in now. If that happens after
  2777				 * the above increment, then it will have to go
  2778				 * back to the old method of allocating the event
  2779				 * on the ring buffer, and if the filter fails, it
  2780				 * will have to call ring_buffer_discard_commit()
  2781				 * to remove it.
  2782				 *
  2783				 * Need to also check the unlikely case that the
  2784				 * length is bigger than the temp buffer size.
  2785				 * If that happens, then the reserve is pretty much
  2786				 * guaranteed to fail, as the ring buffer currently
  2787				 * only allows events less than a page. But that may
  2788				 * change in the future, so let the ring buffer reserve
  2789				 * handle the failure in that case.
  2790				 */
  2791				if (val == 1 && likely(len <= max_len)) {
  2792					trace_event_setup(entry, type, trace_ctx);
  2793					entry->array[0] = len;
  2794					/* Return with preemption disabled */
  2795					return entry;
  2796				}
  2797				this_cpu_dec(trace_buffered_event_cnt);
  2798			}
  2799			/* __trace_buffer_lock_reserve() disables preemption */
  2800			preempt_enable_notrace();
  2801		}
  2802	
  2803		entry = __trace_buffer_lock_reserve(*current_rb, type, len,
  2804						    trace_ctx);
  2805		/*
  2806		 * If tracing is off, but we have triggers enabled
  2807		 * we still need to look at the event data. Use the temp_buffer
  2808		 * to store the trace event for the trigger to use. It's recursive
  2809		 * safe and will not be recorded anywhere.
  2810		 */
  2811		if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
  2812			*current_rb = temp_buffer;
  2813			entry = __trace_buffer_lock_reserve(*current_rb, type, len,
  2814							    trace_ctx);
  2815		}
  2816		return entry;
  2817	}
  2818	EXPORT_SYMBOL_GPL(trace_event_buffer_lock_reserve);
  2819	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
