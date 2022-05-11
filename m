Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07353523812
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiEKQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiEKQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:04:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B81CE60C;
        Wed, 11 May 2022 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652285088; x=1683821088;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DdgW529vfrzUdK200xAyqlK8chpMkKRWAWDKnvN+xwU=;
  b=n/CoXh9Go0iybYnUG27b1a3hP3k/avkGPZonqwWtrkrN7K5m3OHChXVn
   c7z/BACU6zTcM0yjnYpee1POSZyj642aXVxaYM70LpyoAtOOUIYyDfCjO
   YLw7ZpVgA8+W7jPhid0NFF5SMGiiwCoMyKEZOxNlUExYBddAivsTPbPux
   KFN1Q9zFMF9PwB6rvxzs6tAai3dziwvM9LJQQLcOXBFmO7cNWEvmHybPk
   4gUNjD/J5taec7USjt07jDZQYQN2uJbQ5Ja6VEBOdGNyhddxawtg5ED/+
   erBdZ319BuMI3tAqAzT7xRs43sCClDi/A9GMH/wW8rgzsGTqJ3pvLxb7F
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="294982389"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="294982389"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:04:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="739283010"
Received: from abynum-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.66.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:04:47 -0700
Message-ID: <7481e4eb79a1eabb7389b3d74d132c111be36477.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Display error on
 turbo mode disabled
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 11 May 2022 09:04:47 -0700
In-Reply-To: <e2f85541-3e7b-6120-1c44-70ec4447291c@redhat.com>
References: <20220510023421.3930540-1-srinivas.pandruvada@linux.intel.com>
         <e2f85541-3e7b-6120-1c44-70ec4447291c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, 2022-05-11 at 17:56 +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/10/22 04:34, Srinivas Pandruvada wrote:
> > For Intel SST turbo-freq feature to be enabled, the turbo mode on
> > the
> > platform must be enabled also. If turbo mode is disabled, display
> > error
> > while enabling turbo-freq feature.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > Since this is a trivial patch, I am not sending a PULL request.
> 
> Note not related to this patch, but when test building intel-speed-
> select
> I got the following compiler warning:
> 
>   CC      hfi-events.o
> In function ‘process_hfi_event’,
>     inlined from ‘handle_event’ at hfi-events.c:220:5:
> hfi-events.c:184:9: warning: ‘perf_cap.cpu’ may be used uninitialized
> [-Wmaybe-uninitialized]
>   184 |         process_level_change(perf_cap->cpu);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hfi-events.c: In function ‘handle_event’:
> hfi-events.c:193:25: note: ‘perf_cap.cpu’ was declared here
>   193 |         struct perf_cap perf_cap;
>       |                         ^~~~~~~~
> 
> 
Let me send a patch to fix. In reality this will not happen as HFI
message will always have a CPU.

Thanks,
Srinivas


> Regards,
> 
> Hans
> 
> 
> 
> > 
> >  tools/power/x86/intel-speed-select/isst-config.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/power/x86/intel-speed-select/isst-config.c
> > b/tools/power/x86/intel-speed-select/isst-config.c
> > index 060390e88e37..9d35614995ee 100644
> > --- a/tools/power/x86/intel-speed-select/isst-config.c
> > +++ b/tools/power/x86/intel-speed-select/isst-config.c
> > @@ -1892,6 +1892,12 @@ static void set_fact_for_cpu(int cpu, void
> > *arg1, void *arg2, void *arg3,
> >         int ret;
> >         int status = *(int *)arg4;
> >  
> > +       if (status && no_turbo()) {
> > +               isst_display_error_info_message(1, "Turbo mode is
> > disabled", 0, 0);
> > +               ret = -1;
> > +               goto disp_results;
> > +       }
> > +
> >         ret = isst_get_ctdp_levels(cpu, &pkg_dev);
> >         if (ret) {
> >                 isst_display_error_info_message(1, "Failed to get
> > number of levels", 0, 0);
> 

