Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506E7596B82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiHQIkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiHQIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:40:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0D0D7A518
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:40:49 -0700 (PDT)
Received: from jpiotrowski-Surface-Book-3 (ip-095-223-044-032.um35.pools.vodafone-ip.de [95.223.44.32])
        by linux.microsoft.com (Postfix) with ESMTPSA id 26DF1213B636;
        Wed, 17 Aug 2022 01:40:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26DF1213B636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660725649;
        bh=iWYAsgG06kUoC+Wz3E9PT0caGnweixu9+1XX4a4kmPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGAyksiDBQhNZlC36Y6mqlaYKQjrsUbEuTcdrfGURQ4er8H5iyJPB/g/rV+ieb4oY
         DAsroz+TlPKNFsEz10Lu5IrahmVY655MVUYzJcLEXG/C4oMYM3BD1ALhAl3FDv4Pbg
         AGsPVx3Uk1QekqMXm8shmk02AzsLyxhUt/IDrcG8=
Date:   Wed, 17 Aug 2022 10:40:40 +0200
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>, LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: Re: [Regression v5.19-rc1] kernel fails to boot, no console output
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <YvypiOgn94y21nru@jpiotrowski-Surface-Book-3>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <Yvuo2rtootBSlpfQ@jpiotrowski-Surface-Book-3>
 <20220816150637.lyfeirdebb7eetgf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220816150637.lyfeirdebb7eetgf@amd.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:06:37AM -0500, Michael Roth wrote:
> On Tue, Aug 16, 2022 at 04:25:30PM +0200, Jeremi Piotrowski wrote:
> > On Fri, Jun 24, 2022 at 12:44:52AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> > > I found crash kexec fails to boot the 2nd kernel since v5.19-rc1 and
> > > git bisect points to this as a bad commit:
> > > 
> > >   commit b190a043c49af4587f5e157053f909192820522a
> > >   Author: Michael Roth <michael.roth@amd.com>
> > >   Date:   Thu Feb 24 10:56:18 2022 -0600
> > > 
> > >     x86/sev: Add SEV-SNP feature detection/setup
> > > 
> > >     Initial/preliminary detection of SEV-SNP is done via the Confidential
> > >     Computing blob. Check for it prior to the normal SEV/SME feature
> > >     initialization, and add some sanity checks to confirm it agrees with
> > >     SEV-SNP CPUID/MSR bits.
> > > 
> > 
> > Hi Michael,
> > 
> > I too have bisected an issue to this commit and my issue is not fixed by
> > b57feed2cc2622ae14b2fa62f19e973e5e0a60cf. I have a Dell R6515 with AMD EPYC
> > 7513 that is supposed to act as an SNP host, but after v5.19-rc1 I don't get
> > any console output and the machine resets shortly after grub loads the
> > kernel.
> > 
> > The bisect was done on 5.18+SNP patches that were merged into 5.19-rc1, this
> > is the full patch list:
> > 
> >   git log --oneline v5.18-rc1..eb39e37d5cebdf0f63ee2a315fc23b035d81b4b0^2
> > 
> > If I comment out the following lines, the machine boots correctly and if I also
> > have the SNP host patches applied SNP guests work correctly. Applying
> 
> Hi Jeremi,
> 
> Can you retry with earlyprintk enabled via kernel cmdline? I'm trying to see
> if you're getting these messages and making it past the boot/compressed kernel
> (which has its own snp_init()):
> 
>   EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path^M
>   early console in extract_kernel^M
>   input_data: 0x00000000352fd4cc^M
>   input_len: 0x0000000000c5adcb^M
>   output: 0x0000000033000000^M
>   output_len: 0x0000000002f07ec4^M
>   kernel_total_size: 0x000000000242c000^M
>   needed_size: 0x0000000003000000^M
>   trampoline_32bit: 0x000000000009d000^M
>   Physical KASLR using RDRAND RDTSC...^M
>   Virtual KASLR using RDRAND RDTSC...^M
>   ^M
>   Decompressing Linux... Parsing ELF... Performing relocations... done.^M
>   Booting the kernel.
>   [    0.000000] Linux version ...
> 

Ok, I was missing CONFIG_X86_VERBOSE_BOOTUP=y. With that added, when the kernel
doesn't boot this is the output:

  Loading Linux 5.18.0-snp-host-dev+ ...
  Loading initial ramdisk ...
  early console in extract_kernel
  input_data: 0x00000000068824cc
  input_len: 0x000000000092cb45
  output: 0x0000000004200000
  output_len: 0x0000000002f5eff4
  kernel_total_size: 0x0000000002430000
  needed_size: 0x0000000003000000
  trampoline_32bit: 0x000000000009d000
  Physical KASLR using RDRAND RDTSC...
  Virtual KASLR using RDRAND RDTSC...
  
  Decompressing Linux... Parsing ELF... Performing relocations... done.
  Booting the kernel.

> Also, instead of commenting out snp_init() below, can you retry with this
> change instead?
> 
>   diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>   index 7b668f91c9ab..e9e55a99d60f 100644
>   --- a/arch/x86/kernel/sev.c
>   +++ b/arch/x86/kernel/sev.c
>   @@ -2083,9 +2083,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
>            * boot/decompression kernel, the CC blob may have been passed via
>            * setup_data instead.
>            */
>   +#if 0
>           cc_info = find_cc_blob_setup_data(bp);
>           if (!cc_info)
>                   return NULL;
>   +#endif
>   +       return NULL;
>   
>    found_cc_info:
>           if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> 

This version does not boot.

> And if that does not avoid the issue, can you retry with the below change
> (without the above change in place)?
> 
>   diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>   index 7b668f91c9ab..0b430f98e053 100644
>   --- a/arch/x86/kernel/sev.c
>   +++ b/arch/x86/kernel/sev.c
>   @@ -2073,10 +2073,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
>           struct cc_blob_sev_info *cc_info;
>   
>           /* Boot kernel would have passed the CC blob via boot_params. */
>   +#if 0
>           if (bp->cc_blob_address) {
>                   cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
>                   goto found_cc_info;
>           }
>   +#endif
>   
>           /*
>            * If kernel was booted directly, without the use of the
>   @@ -2087,7 +2089,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
>           if (!cc_info)
>                   return NULL;
>   
>   -found_cc_info:
>   +//found_cc_info:
>           if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
>                   snp_abort();
> 
> Trying to see if you're hitting a separate issue or not.

This version boots correctly.

> 
> Thanks,
> 
> Mike
> 
> 
