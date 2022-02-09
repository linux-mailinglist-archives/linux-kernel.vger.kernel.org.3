Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAD4B0285
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiBJBz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:55:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiBJBzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:55:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B92B6BF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644457683; x=1675993683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BLre5/OKQreEUzM09SlpEwYktEpXzat0t85VCB8h+zE=;
  b=HWE31+xIN3hBrpOoTG+u6o73p2ZzARHB87vRVJJL7ExoGsw4R2pKbLPr
   Ws4/9FtrvJX9EI32u6X7mWN6Ar3yjacQtRTE94q43UG453ddZIx6KZtvL
   fyHkxXOD24gprLdVtmskMtKdnG+KRiVpILrkGci82oThPu77gYLZHOvwu
   iiLIl6ke4ZVsaKiVMBgARmQJcELK1Wx2hWQC1F3b9oUwkfEbsKcy3ZRbb
   w36w1JL+ylr1Pgq2dUoSy3IdL/8h/UqT9ytbPRwIhSspSviAyqgtTbQoT
   MGT81WCqyEbdqhPKRSJlK+VUdbgHu3+092WPSJPMFUay++VnlbywR6oRI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="246950848"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="246950848"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:44:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="526228822"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:44:41 -0800
Date:   Wed, 9 Feb 2022 15:44:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 13/44] mm/pkeys: Add initial PKS Test code
Message-ID: <20220209234441.GO785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-14-ira.weiny@intel.com>
 <1ac1daf90285869ddfdf52daa8d39bc462253883.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac1daf90285869ddfdf52daa8d39bc462253883.camel@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:30:14AM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > +static void crash_it(void)
> > +{
> > +       struct pks_test_ctx *ctx;
> > +       void *ptr;
> > +
> > +       pr_warn("     ***** BEGIN: Unhandled fault test *****\n");
> > +
> > +       ctx = alloc_ctx(PKS_KEY_TEST);
> > +       if (IS_ERR(ctx)) {
> > +               pr_err("Failed to allocate context???\n");
> > +               return;
> > +       }
> > +
> > +       ptr = alloc_test_page(ctx->pkey);
> > +       if (!ptr) {
> > +               pr_err("Failed to vmalloc page???\n");
> > +               return;
> > +       }
> > +
> > +       /* This purposely faults */
> > +       memcpy(ptr, ctx->data, 8);
> > +
> > +       /* Should never get here if so the test failed */
> > +       last_test_pass = false;
> > +
> > +       vfree(ptr);
> > +       free_ctx(ctx);
> 
> So these only gets cleaned up if the test fails? Could you clean them
> up in pks_release_file() like the later test patch?

Not a bad idea.  Although if someone is running this they are most likely not
concerned with it.

> 
> > +}
> 
> snip
> 
> > +
> > +static void __exit pks_test_exit(void)
> > +{
> > +       debugfs_remove(pks_test_dentry);
> > +       pr_info("test exit\n");
> > +}
> 
> How does this get called?

Left over from when this was a module.  Thanks for catching.

Ira
