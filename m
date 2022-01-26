Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7D49CC81
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiAZOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiAZOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:39:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD17C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:39:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ACBF60ACD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F04C340E3;
        Wed, 26 Jan 2022 14:39:19 +0000 (UTC)
Date:   Wed, 26 Jan 2022 09:39:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Tom Zanussi <zanussi@kernel.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/trace_events_hist.c:6174
 event_hist_trigger_parse() error: we previously assumed 'glob' could be
 null (see line 6166)
Message-ID: <20220126093918.268d0e42@gandalf.local.home>
In-Reply-To: <202201250054.975KVd1O-lkp@intel.com>
References: <202201250054.975KVd1O-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 13:14:22 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
> commit: 9ec5a7d16899ed9062cc4c3dd3a13e1771411ab3 tracing: Change event_command func() to parse()
> config: x86_64-randconfig-m001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250054.975KVd1O-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> kernel/trace/trace_events_hist.c:6174 event_hist_trigger_parse() error: we previously assumed 'glob' could be null (see line 6166)
> 
> vim +/glob +6174 kernel/trace/trace_events_hist.c
> 
> 9ec5a7d16899ed Tom Zanussi             2022-01-10  6149  static int event_hist_trigger_parse(struct event_command *cmd_ops,
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6150  				    struct trace_event_file *file,
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6151  				    char *glob, char *cmd, char *param)
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6152  {
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6153  	unsigned int hist_trigger_bits = TRACING_MAP_BITS_DEFAULT;
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6154  	struct event_trigger_data *trigger_data;
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6155  	struct hist_trigger_attrs *attrs;
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6156  	struct event_trigger_ops *trigger_ops;
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6157  	struct hist_trigger_data *hist_data;
> 4b147936fa5096 Tom Zanussi             2018-01-15  6158  	struct synth_event *se;
> 4b147936fa5096 Tom Zanussi             2018-01-15  6159  	const char *se_name;
> 30350d65ac5676 Tom Zanussi             2018-01-15  6160  	bool remove = false;
> c5eac6ee8bc5d3 Kalesh Singh            2021-10-25  6161  	char *trigger, *p, *start;
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6162  	int ret = 0;
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6163  
> 0e2b81f7b52a1c Masami Hiramatsu        2018-11-05  6164  	lockdep_assert_held(&event_mutex);
> 0e2b81f7b52a1c Masami Hiramatsu        2018-11-05  6165  
> f404da6e1d46ce Tom Zanussi             2018-01-15 @6166  	if (glob && strlen(glob)) {

I just reviewed the code, and it looks like the logic should keep glob from
ever being NULL.

I guess the solution could simply be to remove glob here, and perhaps add:

	WARN_ON(!glob);

-- Steve


> 
> Check for NULL
> 
> f404da6e1d46ce Tom Zanussi             2018-01-15  6167  		hist_err_clear();
> a1a05bb40e229d Tom Zanussi             2019-03-31  6168  		last_cmd_set(file, param);
> f404da6e1d46ce Tom Zanussi             2018-01-15  6169  	}
> f404da6e1d46ce Tom Zanussi             2018-01-15  6170  
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6171  	if (!param)
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6172  		return -EINVAL;
> 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6173  
> 30350d65ac5676 Tom Zanussi             2018-01-15 @6174  	if (glob[0] == '!')
> 
> Unchecked dereference
> 
> 30350d65ac5676 Tom Zanussi             2018-01-15  6175  		remove = true;
> 30350d65ac5676 Tom Zanussi             2018-01-15  6176  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

