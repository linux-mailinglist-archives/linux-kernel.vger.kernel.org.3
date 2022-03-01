Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B014C8F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiCAPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiCAPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:39:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF492A9E24
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646149143; x=1677685143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9B/nSIhnKpaShmw0MZ4KZdnrjCBOGcE0PdYVSUSa3e4=;
  b=W3pA5syJg6ZytglhDpIQUB0z0g0vg1Rmxgx9BPoNOb9IkP8/xbEfGUaP
   N2K8m45Dqo53K4PqVQqzmKG5Q2EsFTOFfrGlzi2hGP18ze8At2mz8oJM5
   3gOLE3eJcL8bcONiex+s5BSq71vKjTQSOYKCxyjzp4o/s0MyJgzhVQhOk
   s4fjWXrVL3RapaLMAg78q+uHdrbQB8TToZMHY4RzaAg/f8LJ5mWQ7WXw/
   Eu2JW9gR79fif9Rj1iidwUgoMcjdjQJ2X8OtL/g/hYgokg3oeQgakbjVg
   DJmbBpbyFS4B5RW4WkLEkYNyA7kTXy/TUs+oDnrhU1KqElAZ44fAT5P2m
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252889562"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252889562"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:39:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630050458"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:39:02 -0800
Date:   Tue, 1 Mar 2022 07:39:02 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 30/44] mm/pkeys: Test setting a PKS key in a custom
 fault callback
Message-ID: <Yh4+Fjs2yhbWux9C@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-31-ira.weiny@intel.com>
 <20abc6a0b79e4fe9f60b16a1f3371f0676e77b82.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20abc6a0b79e4fe9f60b16a1f3371f0676e77b82.camel@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:55:47PM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > Add a test which does this.
> >
> >         $ echo 5 > /sys/kernel/debug/x86/run_pks
> >         $ cat /sys/kernel/debug/x86/run_pks
> >         PASS
> 
> Hmm, when I run this on qemu TCG, I get:
> 
> root@(none):/# echo 5 > /sys/kernel/debug/x86/run_pks
> [   29.438159] pks_test: Failed to see the callback
> root@(none):/# cat /sys/kernel/debug/x86/run_pks
> FAIL
> 
> I think it's a problem with the test though. The generated code is not
> expecting fault_callback_ctx.callback_seen to get changed in the
> exception. The following fixed it for me:
> 
> diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
> index 1528df0bb283..d979d2afe921 100644
> --- a/lib/pks/pks_test.c
> +++ b/lib/pks/pks_test.c
> @@ -570,6 +570,7 @@ static bool run_fault_clear_test(void)
>         /* fault */
>         memcpy(test_page, ctx->data, 8);
> 
> +       barrier();
>         if (!fault_callback_ctx.callback_seen) {
>                 pr_err("Failed to see the callback\n");
>                 rc = false;
> 
> But, I wonder if volatile is also needed on the read to be fully
> correct. I usually have to consult the docs when I deal with that
> stuff...

I was not able to reproduce this.  However, I've done a lot of reading and I
think you are correct that the barrier is needed.  I thought WRITE_ONCE was
sufficient and I had used it in other calls but I missed it here.

As part of the test rework I've added a call to barrier() for all the tests.
In addition I've simplified, and hopefully clarified, which variables are
being shared with the fault handler.

Thanks for the testing and review!
Ira
