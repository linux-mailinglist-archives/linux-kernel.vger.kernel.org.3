Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6C5B18D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIHJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIHJfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:35:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA944D1E07
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:35:53 -0700 (PDT)
Received: from jpiotrowski-Surface-Book-3 (ip-095-223-044-056.um35.pools.vodafone-ip.de [95.223.44.56])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1E40220B929C;
        Thu,  8 Sep 2022 02:35:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E40220B929C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662629753;
        bh=Uu9G6M7jErPzs/ZBk4bpt1WdY0clJMcBRRY/isbTH5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgVYwlFCMDbV7U4XS75YGtkKE/r8LzUUM4665h3/XUntcFyiIwoZuXJaGJfSQvnQI
         3jj7Y+fFbT/l82qZCYsOEQsfLcqye2zSHwwaYIQradH/GqTwRxqDSrMZNWjbCt6Aer
         WEi9M6XKjk666js2s/YQJ6xf3TqFjVVLeIhrCGqY=
Date:   Thu, 8 Sep 2022 11:35:46 +0200
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>, LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: Re: [Regression v5.19-rc1] kernel fails to boot, no console output
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <Yxm3clMvSK8uLKju@jpiotrowski-Surface-Book-3>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <Yvuo2rtootBSlpfQ@jpiotrowski-Surface-Book-3>
 <20220816150637.lyfeirdebb7eetgf@amd.com>
 <YvypiOgn94y21nru@jpiotrowski-Surface-Book-3>
 <20220822163933.b5hee76fsis376ji@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822163933.b5hee76fsis376ji@amd.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 11:39:33AM -0500, Michael Roth wrote:
> On Wed, Aug 17, 2022 at 10:40:40AM +0200, Jeremi Piotrowski wrote:
> > On Tue, Aug 16, 2022 at 10:06:37AM -0500, Michael Roth wrote:
> > > And if that does not avoid the issue, can you retry with the below change
> > > (without the above change in place)?
> > > 
> > >   diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > >   index 7b668f91c9ab..0b430f98e053 100644
> > >   --- a/arch/x86/kernel/sev.c
> > >   +++ b/arch/x86/kernel/sev.c
> > >   @@ -2073,10 +2073,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> > >           struct cc_blob_sev_info *cc_info;
> > >   
> > >           /* Boot kernel would have passed the CC blob via boot_params. */
> > >   +#if 0
> > >           if (bp->cc_blob_address) {
> > >                   cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
> > >                   goto found_cc_info;
> > >           }
> > >   +#endif
> > >   
> > >           /*
> > >            * If kernel was booted directly, without the use of the
> > >   @@ -2087,7 +2089,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> > >           if (!cc_info)
> > >                   return NULL;
> > >   
> > >   -found_cc_info:
> > >   +//found_cc_info:
> > >           if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> > >                   snp_abort();
> > > 
> > > Trying to see if you're hitting a separate issue or not.
> > 
> > This version boots correctly.
> 
> Hi Jeremi,
> 
> Still haven't been able to reproduce this on my systems, but it looks like
> it's either an issue dereferencing boot_params, or bp->cc_blob_address is
> pointing to garbage, so the cc_info->magic check fails. The latter seems
> more likely, since sme_enable() previously made use of the same boot_params
> pointer without any issues.
> 
> To confirm, please give the below fix a try:
> 
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 52f989f6acc2..dd6cd0d7c740 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -392,6 +392,13 @@ bool snp_init(struct boot_params *bp)
>         if (!bp)
>                 return false;
> 
> +       /*
> +        * bp->cc_blob_address should only be set by boot/compressed kernel.
> +        * Initialize it to 0 to ensure that uninitialized values from
> +        * buggy bootloaders aren't propagated.
> +        */
> +       bp->cc_blob_address = 0;
> +
>         cc_info = find_cc_blob(bp);
>         if (!cc_info)
>                 return false;
> 

Sorry, couldn't get back to you sooner.
I tested the patch https://lore.kernel.org/lkml/20220823160734.89036-1-michael.roth@amd.com/
and it solves the issue.

Thanks for looking into this
Jeremi

> Thanks!
> 
> -Mike
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > Mike
> > > 
> > > 
