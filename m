Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09FB52222B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbiEJRWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347876AbiEJRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:22:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E374322386D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652203123; x=1683739123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ljmq8HUFYZ6GA+tSSAa18YvTdl9NI5PPjwKlwvCCJrY=;
  b=cROMnquZU6qdzaFh/b9Qf/6Mg0fNO41txQV36MUMPJzqtg6U+/0N0cWZ
   SPlRpE8+laOVODAPYHTuBgE3QJTmNkZPsYYZErXfFBPQIgoKwx8kdlf49
   MJ2N054BJEfbMw2kB+wFhZahR1iM66cv0nkHTtCTZjR+eQ/V9fcMxDK8K
   9Gr+mOSYPX0Jj9zKvW2uNkZ1FPGZ/ti3YFqhM6WUuPupnqLMHHO1pVYJL
   R09L/kSGZESQshN2z0ETYgf6FVj50GfrqnXW6fUKpdP9RFfjcgfz929Ob
   rxTqx0lSUmbaAkleInQJOoPySYh9O6sYh6elGOlQrMQryUKCwmf7xO3nz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251494862"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="251494862"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:18:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="697188538"
Received: from ticela-or-037.amr.corp.intel.com (HELO localhost) ([10.209.191.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:18:25 -0700
Date:   Tue, 10 May 2022 10:18:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 08/44] Documentation/pkeys: Add initial PKS
 documentation
Message-ID: <YnqeYBzvatHL1XYZ@iweiny-desk3>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-9-ira.weiny@intel.com>
 <202205091501.132944B2C7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205091501.132944B2C7@keescook>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:03:48PM -0700, Kees Cook wrote:
> On Tue, Apr 19, 2022 at 10:06:13AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Add initial overview and configuration information about PKS.
> > 
> > Cc: "Moger, Babu" <Babu.Moger@amd.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes for V9
> > 	Feedback from Dave Hansen
> > 		Remove overview and move relevant text to the main pkey
> > 		overview which covers both user ans kernel keys.
> > 		Add an example of using Kconfig
> > 		Move MSR details to later patches
> > ---
> >  Documentation/core-api/protection-keys.rst | 43 ++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
> > index bf28ac0401f3..13eedb0119e1 100644
> > --- a/Documentation/core-api/protection-keys.rst
> > +++ b/Documentation/core-api/protection-keys.rst
> > @@ -13,6 +13,11 @@ Pkeys Userspace (PKU) is a feature which can be found on:
> >          * Intel client CPUs, Tiger Lake (11th Gen Core) and later
> >          * Future AMD CPUs
> >  
> > +Protection Keys Supervisor (PKS) is a feature which can be found on:
> > +        * Sapphire Rapids (and later) "Scalable Processor" Server CPUs
> > +        * Future non-server Intel parts.
> > +        * qemu: https://www.qemu.org/2021/04/30/qemu-6-0-0/
> 
> It looks like QEMU has pass-through support, but not emulation?

I'm not an expert on qemu but I believe the support is emulated with TCG.

"TCG can emulate the PKS feature (protection keys for supervisor pages)."
	-- https://wiki.qemu.org/ChangeLog/6.0

> It'd be
> really nice to have this feature emulated so it would be possible to
> test the code. (Or I need to find a machine that supports this...)

Both Rick and I have been able to run with the following options to qemu:

qemu-system-x86_64 ... -machine accel=tcg -cpu qemu64,+pks ...

Ira
