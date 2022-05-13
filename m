Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25FF526D64
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiEMXOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiEMXOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:14:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A093320CB5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652483661; x=1684019661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wjfqOqIYe6TZTMHFU68r4+WktU+l0Y6oPd5aHItbaM=;
  b=Mah62wU8ASEQE1z70AZpSnzFUBLvtPJuqVJ3Mt1gQrhJ0/84a7PfWviq
   Z/PSEKxIFaRpTOhB0xC5aLD03avu4vapzKtH79L4cD1wh/t3ZnrSgQ0rP
   v45JYY77S8659Q+VqAMwPf/+bAs+/6Li/f2cAYa5GfWX5OnILlnGJffFh
   00ZcySfLIbavc65EiwxIlsF99jcxopppAk5zo4b8gO1ax9AdUwIMgqARZ
   7f6TSfcLqohQjZgg/tBnxCVy7jorN7GYBiW6r+2CamyYfi8PXEc2/3fyO
   its2hLyPXkNvRBXEt0whNg4jnnjGctQJbR+fQ/hcNlOeLmuJBAZxITPTe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="356855218"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="356855218"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 16:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="815594245"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2022 16:14:19 -0700
Date:   Fri, 13 May 2022 16:17:54 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 24/29] watchdog/hardlockup: Use parse_option_str() to
 handle "nmi_watchdog"
Message-ID: <20220513231754.GB9074@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-25-ricardo.neri-calderon@linux.intel.com>
 <1652179333.fnu2fjiffn.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652179333.fnu2fjiffn.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:46:41PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> > Prepare hardlockup_panic_setup() to handle a comma-separated list of
> > options. Thus, it can continue parsing its own command-line options while
> > ignoring parameters that are relevant only to specific implementations of
> > the hardlockup detector. Such implementations may use an early_param to
> > parse their own options.
> 
> It can't really handle comma separated list though, until the next
> patch. nmi_watchdog=panic,0 does not make sense, so you lost error
> handling of that.

Yes that is true. All possible combinations need to be checked.

> 
> And is it kosher to double handle options like this? I'm sure it
> happens but it's ugly.
> 
> Would you consider just add a new option for x86 and avoid changing
> this? Less code and patches.

Sure, I can not modify this code and add a x86-specific command-line
option.

Thanks and BR,
Ricardo
