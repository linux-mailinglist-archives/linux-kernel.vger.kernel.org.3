Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F06595EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiHPPIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbiHPPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:08:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10724B8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/r8p1R1Tnnot+w2ba/xhxj0J0xPosWpY8H13qc57giK8M2/f6zitjRAsW0CrRh7YzNC0s6nqrS1BZ84szovWHNoxnCfPps9sLaNG6VamE92UtgwRxcHHcXqGbITureuJLq6nmZ+bJDWWtZtgRnqUFZrNRQIZq0oI4fJ3LR6jHWZxawt/Q3uvs/A1fDc63H+T9zViu++f+4kJWhS3vJlF04foRqbKWx2xdvWSOgjGKsCiDEUEETHyX2+/RVHUyIaZVESuHemeLwFSLdMoH5ZMpCyyFq8FVQh0tTNTUKu4sUtNgSRRLqa3W/zWmN5MW/BijsgWJH/8Us2axmiHazjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWeWgj72xO5DQzZh95lIR5IAGeFbhUNBbwjz61tuaJo=;
 b=R2Sc0NhD5DndrD1j9KK3+GdXx7bLhimx8l+RqRn2DQgX68EDVr8V3Hdbud/Z0+QJdtjf5Da2Jj4VJB3uaKjP9vQH/xx8WClYoV/baxXAMbUo06OZwyStOHAEMdcEgUv1ENBCfgu3hgHRndLV5Q7e2sdQ3npykj50tvehWb5JakFSLhVQ9Ojyl0eqvYgdmF9ZR3k8TJboNcOvs2x6QVqUlmte6nzrE5qArMubZJTCqA1+VCo1FA8fhEDL82f3KIGJxXHEMOpajtPCJNwg8nc1yZsmBg6J7tIokqREnB15Uagrp93D/5uKwj+6Eqm4ygxu68D84kkKx/hP8yT08zJtOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWeWgj72xO5DQzZh95lIR5IAGeFbhUNBbwjz61tuaJo=;
 b=QPpEoKy0sfaLwAkJpHCeAGCyMLHt/V+9gC40Me9pV8hm24hdgGZnxgewid7Bb+vC7DYbvyqxixJJjg0MAxkK0AsGZ9WhpaPrZ8M9jmJtLxCwXRYbHguqOQSjZR6MKpPHmYG+NOADpqD6+N4V8swq4df0mEa53j3mFMfZelp56YM=
Received: from DS7PR05CA0023.namprd05.prod.outlook.com (2603:10b6:5:3b9::28)
 by BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 15:07:12 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::db) by DS7PR05CA0023.outlook.office365.com
 (2603:10b6:5:3b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Tue, 16 Aug 2022 15:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Tue, 16 Aug 2022 15:07:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 10:07:07 -0500
Date:   Tue, 16 Aug 2022 10:06:37 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
CC:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>, LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: Re: [Regression v5.19-rc1] kernel fails to boot, no console output
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <20220816150637.lyfeirdebb7eetgf@amd.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <Yvuo2rtootBSlpfQ@jpiotrowski-Surface-Book-3>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yvuo2rtootBSlpfQ@jpiotrowski-Surface-Book-3>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a77c8b-2dc7-49aa-631d-08da7f98ff43
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiCt7GzOElUYsBG/MwqdxyxGrdm4otUU5Voi6Swe81TN8/Cz5YdB0OrSt8JTPyXIvNKqE2w2whn3WNQEvkNnWrzfaXiHPu+L1l0IPC5xsxkPKiVGXvF7mrpSQR7Zj6mvxVQz61cU2+ytS9xh61eIBxpCP5qtuhnQnybkEsbsGUhYsuvFiUDhPeO+UP+DxNPx95JoguokH7lbQ3z+xOvHEIaE45YEkrm6pjUsa6WWEv75v/HgYl04K4VZnUtG+c3n7nC9y6j85D6uF1AnDy/gXVX1swfb+DHRJ+RzGMHRmmENS3bkRRFflqrjjpVols7sGeEFTnf8WxtN1VcFo3wh2DhqWk1MvE8HNedqPcKPSSQTATBv96uluU9RkaJZclRWrpOQrR3ptiaWXoQqCeqmLgkuX/mNmSYieqsKWr+hmcKizWo9IaFBrwbUQX/gJIsW/KaoAynxxn9ECGyv8eP9vJo0vdR7KjVQicLvWMwYx1n0A5q0C0vycJqZTk1GyzCwoUIY7kfqzoqOcu+IHHCeChEw4OzarAKpTEzjkkEtgaBj4HDU39s+ZDJY85cMeqJ9LeJ5+BpQVQ/aP37RbqdGUIT2nOTecT8mJgb/9PBaa77P4VkiWiLl8dl4fI3Qvqwby3R0XQTQxnLDul/twI9qgoc7sj80I/TFjTNFw/ICv4uIwOZsZGlWobXT2XD9JlW4OYd78U8YyuGDe1m+AhpC1ahTjpksR+3kAoVok6mJXS89vUfbcyhAoUVwpbKnJvDMc67OmBeXiLy37t3rg1s7hTTZnKRg5c4LvnP+EjI++/eW+uMzbJ09W+5xdnQcFc06854G7Dql/Iz1UpPp4UbyBTopGwU9Zek3tBqeggHckEY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(70586007)(70206006)(5660300002)(8676002)(316002)(6916009)(4326008)(54906003)(40480700001)(82310400005)(82740400003)(44832011)(40460700003)(8936002)(2906002)(356005)(81166007)(30864003)(36860700001)(36756003)(86362001)(15974865002)(41300700001)(478600001)(26005)(6666004)(45080400002)(83380400001)(16526019)(336012)(426003)(1076003)(2616005)(186003)(66574015)(47076005)(36900700001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 15:07:11.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a77c8b-2dc7-49aa-631d-08da7f98ff43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:25:30PM +0200, Jeremi Piotrowski wrote:
> On Fri, Jun 24, 2022 at 12:44:52AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> > I found crash kexec fails to boot the 2nd kernel since v5.19-rc1 and
> > git bisect points to this as a bad commit:
> > 
> >   commit b190a043c49af4587f5e157053f909192820522a
> >   Author: Michael Roth <michael.roth@amd.com>
> >   Date:   Thu Feb 24 10:56:18 2022 -0600
> > 
> >     x86/sev: Add SEV-SNP feature detection/setup
> > 
> >     Initial/preliminary detection of SEV-SNP is done via the Confidential
> >     Computing blob. Check for it prior to the normal SEV/SME feature
> >     initialization, and add some sanity checks to confirm it agrees with
> >     SEV-SNP CPUID/MSR bits.
> > 
> 
> Hi Michael,
> 
> I too have bisected an issue to this commit and my issue is not fixed by
> b57feed2cc2622ae14b2fa62f19e973e5e0a60cf. I have a Dell R6515 with AMD EPYC
> 7513 that is supposed to act as an SNP host, but after v5.19-rc1 I don't get
> any console output and the machine resets shortly after grub loads the
> kernel.
> 
> The bisect was done on 5.18+SNP patches that were merged into 5.19-rc1, this
> is the full patch list:
> 
>   git log --oneline v5.18-rc1..eb39e37d5cebdf0f63ee2a315fc23b035d81b4b0^2
> 
> If I comment out the following lines, the machine boots correctly and if I also
> have the SNP host patches applied SNP guests work correctly. Applying

Hi Jeremi,

Can you retry with earlyprintk enabled via kernel cmdline? I'm trying to see
if you're getting these messages and making it past the boot/compressed kernel
(which has its own snp_init()):

  EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path^M
  early console in extract_kernel^M
  input_data: 0x00000000352fd4cc^M
  input_len: 0x0000000000c5adcb^M
  output: 0x0000000033000000^M
  output_len: 0x0000000002f07ec4^M
  kernel_total_size: 0x000000000242c000^M
  needed_size: 0x0000000003000000^M
  trampoline_32bit: 0x000000000009d000^M
  Physical KASLR using RDRAND RDTSC...^M
  Virtual KASLR using RDRAND RDTSC...^M
  ^M
  Decompressing Linux... Parsing ELF... Performing relocations... done.^M
  Booting the kernel.
  [    0.000000] Linux version ...

Also, instead of commenting out snp_init() below, can you retry with this
change instead?

  diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
  index 7b668f91c9ab..e9e55a99d60f 100644
  --- a/arch/x86/kernel/sev.c
  +++ b/arch/x86/kernel/sev.c
  @@ -2083,9 +2083,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
           * boot/decompression kernel, the CC blob may have been passed via
           * setup_data instead.
           */
  +#if 0
          cc_info = find_cc_blob_setup_data(bp);
          if (!cc_info)
                  return NULL;
  +#endif
  +       return NULL;
  
   found_cc_info:
          if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)

And if that does not avoid the issue, can you retry with the below change
(without the above change in place)?

  diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
  index 7b668f91c9ab..0b430f98e053 100644
  --- a/arch/x86/kernel/sev.c
  +++ b/arch/x86/kernel/sev.c
  @@ -2073,10 +2073,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
          struct cc_blob_sev_info *cc_info;
  
          /* Boot kernel would have passed the CC blob via boot_params. */
  +#if 0
          if (bp->cc_blob_address) {
                  cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
                  goto found_cc_info;
          }
  +#endif
  
          /*
           * If kernel was booted directly, without the use of the
  @@ -2087,7 +2089,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
          if (!cc_info)
                  return NULL;
  
  -found_cc_info:
  +//found_cc_info:
          if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
                  snp_abort();

Trying to see if you're hitting a separate issue or not.

Thanks,

Mike


> have the SNP host patches applied SNP guests work correctly. Applying
> b57feed2cc2622ae14b2fa62f19e973e5e0a60cf instead does not change anything,
> there is still no console output and no boot.
> 
> Any further suggestions on how to debug this? Attached you'll find my dmesg and
> config.
> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index f415498d3175..7ffde3fa6be8 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -510,10 +510,10 @@ void __init sme_enable(struct boot_params *bp)
>         bool active_by_default;
>         unsigned long me_mask;
>         char buffer[16];
> -       bool snp;
> +       //bool snp;
>         u64 msr;
>  
> -       snp = snp_init(bp);
> +       //snp = snp_init(bp);
>  
>         /* Check for the SME/SEV support leaf */
>         eax = 0x80000000;
> @@ -547,8 +547,10 @@ void __init sme_enable(struct boot_params *bp)
>         feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
>  
>         /* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
> +       /*
>         if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>                 snp_abort();
> +       */
>  
>         /* Check if memory encryption is enabled */
>         if (feature_mask == AMD_SME_BIT) {
> 

> [    0.000000] Linux version 5.18.0-snp-host+ (jeremi@amd-sev-reserved) (gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #18 SMP PREEMPT_DYNAMIC Tue Aug 16 08:27:29 UTC 2022
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.18.0-snp-host+ root=UUID=fe266f32-9e15-498c-9211-8f9d1a1a4c6e ro console=tty0 console=ttyS1,115200n8 systemd.unified_cgroup_hierarchy=0 earlyprintk=ttyS1 console=tty1 console=ttyS0
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai  
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
> [    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
> [    0.000000] signal: max sigframe size: 3376
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000015ffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000016000000-0x00000000568fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000056900000-0x00000000569fbfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000569fc000-0x00000000569fcfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000569fd000-0x000000005a151fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000005a152000-0x000000005a1d1fff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000005a1d2000-0x0000000067acefff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000067acf000-0x000000006dfcefff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000006dfcf000-0x000000006edfefff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000006edff000-0x000000006effefff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000006efff000-0x000000006effffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000006f000000-0x000000006f00afff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000006f00b000-0x000000006fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000aa000000-0x00000000aaffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000c5000000-0x00000000c5ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e0ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000407f0fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000407f100000-0x000000407fffffff] reserved
> [    0.000000] printk: bootconsole [earlyser0] enabled
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x0c24b020-0x0c27e65f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c24b020-0x0c27e65f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c217020-0x0c24a65f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c217020-0x0c24a65f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c208020-0x0c21685f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c208020-0x0c21685f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c1f9020-0x0c20785f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c1f9020-0x0c20785f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c1cb020-0x0c1f8c5f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c1cb020-0x0c1f8c5f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c1c2020-0x0c1ca05f] usable ==> usable
> [    0.000000] e820: update [mem 0x0c1c2020-0x0c1ca05f] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008efff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000000c1c201f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c1c2020-0x000000000c1ca05f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c1ca060-0x000000000c1cb01f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c1cb020-0x000000000c1f8c5f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c1f8c60-0x000000000c1f901f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c1f9020-0x000000000c20785f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c207860-0x000000000c20801f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c208020-0x000000000c21685f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c216860-0x000000000c21701f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c217020-0x000000000c24a65f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c24a660-0x000000000c24b01f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c24b020-0x000000000c27e65f] usable
> [    0.000000] reserve setup_data: [mem 0x000000000c27e660-0x0000000015ffffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000016000000-0x00000000568fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000056900000-0x00000000569fbfff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000569fc000-0x00000000569fcfff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000569fd000-0x000000005a151fff] usable
> [    0.000000] reserve setup_data: [mem 0x000000005a152000-0x000000005a1d1fff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000005a1d2000-0x0000000067acefff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000067acf000-0x000000006dfcefff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000006dfcf000-0x000000006edfefff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000006edff000-0x000000006effefff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x000000006efff000-0x000000006effffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000006f000000-0x000000006f00afff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000006f00b000-0x000000006fffffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000070000000-0x000000008fffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000aa000000-0x00000000aaffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000c5000000-0x00000000c5ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000e0ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000407f0fffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000407f100000-0x000000407fffffff] reserved
> [    0.000000] efi: EFI v2.70 by Dell Inc.
> [    0.000000] efi: ACPI=0x6effe000 ACPI 2.0=0x6effe014 MEMATTR=0x62d8f020 SMBIOS=0x697a0000 SMBIOS 3.0=0x6979e000 RNG=0x67bcdc20 TPMEventLog=0xc27f020 
> [    0.000000] efi: seeding entropy pool
> [    0.000000] random: crng init done
> [    0.000000] TPM Final Events table not present
> [    0.000000] SMBIOS 3.3.0 present.
> [    0.000000] DMI: Dell Inc. PowerEdge R6515/068NXX, BIOS 2.6.6 01/13/2022
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2595.384 MHz processor
> [    0.000016] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000018] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000026] last_pfn = 0x407f100 max_arch_pfn = 0x400000000
> [    0.066696] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.186134] x2apic: enabled by BIOS, switching to x2apic ops
> [    0.253725] last_pfn = 0x70000 max_arch_pfn = 0x400000000
> [    0.321764] Using GB pages for direct mapping
> [    0.372284] Secure boot disabled
> [    0.410222] RAMDISK: [mem 0x0c284000-0x0d899fff]
> [    0.465339] ACPI: Early table checksum verification disabled
> [    0.532927] ACPI: RSDP 0x000000006EFFE014 000024 (v02 DELL  )
> [    0.601556] ACPI: XSDT 0x000000006EFFD0E8 0000C4 (v01 DELL   PE_SC3   00000002 DELL 00000001)
> [    0.703464] ACPI: FACP 0x000000006EFF9000 000114 (v06 DELL   PE_SC3   00000002 DELL 00000001)
> [    0.805369] ACPI: DSDT 0x000000006EFDA000 019535 (v02 DELL   PE_SC3   00000002 DELL 00000001)
> [    0.907273] ACPI: FACS 0x000000006EDB9000 000040
> [    0.962385] ACPI: BERT 0x000000006EFFC000 000030 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    1.064291] ACPI: ERST 0x000000006EFFB000 000230 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    1.166197] ACPI: HEST 0x000000006EFFA000 0007F4 (v01 DELL   PE_SC3   00000001 DELL 00000001)
> [    1.268103] ACPI: HPET 0x000000006EFF8000 000038 (v01 DELL   PE_SC3   00000002 DELL 00000001)
> [    1.370008] ACPI: APIC 0x000000006EFF6000 0018BE (v05 DELL   PE_SC3   00000002 DELL 00000001)
> [    1.471913] ACPI: MCFG 0x000000006EFF5000 00003C (v01 DELL   PE_SC3   00000002 DELL 00000001)
> [    1.573819] ACPI: WSMT 0x000000006EFF4000 000028 (v01 DELL   PE_SC3   00000002 DELL 00000001)
> [    1.675725] ACPI: SSDT 0x000000006EFD9000 000629 (v02 DELL   xhc_port 00000001 INTL 20210331)
> [    1.777631] ACPI: SSDT 0x000000006EFD8000 000D7B (v02 AMD    CPMRAS   00000001 INTL 20210331)
> [    1.879536] ACPI: SSDT 0x000000006EFD7000 000623 (v02 DELL   Tpm2Tabl 00001000 INTL 20210331)
> [    1.981442] ACPI: TPM2 0x000000006EFD6000 00004C (v04 DELL   PE_SC3   00000002 DELL 00000001)
> [    2.083347] ACPI: EINJ 0x000000006EFD5000 000150 (v01 AMD    PE_SC3   00000001 AMD  00000001)
> [    2.185256] ACPI: SSDT 0x000000006EFD4000 000364 (v02 DELL   PE_SC3   00000001 AMD  00000001)
> [    2.287162] ACPI: CRAT 0x000000006EFD0000 0039D0 (v01 DELL   PE_SC3   00000001 AMD  00000001)
> [    2.389064] ACPI: CDIT 0x000000006EFCF000 000029 (v01 DELL   PE_SC3   00000001 AMD  00000001)
> [    2.490970] ACPI: IVRS 0x000000006EFCE000 0001F0 (v02 DELL   PE_SC3   00000001 AMD  00000001)
> [    2.592876] ACPI: SPCR 0x000000006EFCD000 000050 (v02 DELL   PE_SC3   00000002 DELL 00000001)
> [    2.694782] ACPI: SSDT 0x000000006EFCC000 000C7B (v02 DELL   PE_SC3   00000002 DELL 00000001)
> [    2.796688] ACPI: SSDT 0x000000006EFCA000 00193C (v02 AMD    CPMCMN   00000001 INTL 20210331)
> [    2.898592] ACPI: Reserving FACP table memory at [mem 0x6eff9000-0x6eff9113]
> [    2.982821] ACPI: Reserving DSDT table memory at [mem 0x6efda000-0x6eff3534]
> [    3.067050] ACPI: Reserving FACS table memory at [mem 0x6edb9000-0x6edb903f]
> [    3.151278] ACPI: Reserving BERT table memory at [mem 0x6effc000-0x6effc02f]
> [    3.235505] ACPI: Reserving ERST table memory at [mem 0x6effb000-0x6effb22f]
> [    3.319734] ACPI: Reserving HEST table memory at [mem 0x6effa000-0x6effa7f3]
> [    3.403961] ACPI: Reserving HPET table memory at [mem 0x6eff8000-0x6eff8037]
> [    3.488190] ACPI: Reserving APIC table memory at [mem 0x6eff6000-0x6eff78bd]
> [    3.572418] ACPI: Reserving MCFG table memory at [mem 0x6eff5000-0x6eff503b]
> [    3.656647] ACPI: Reserving WSMT table memory at [mem 0x6eff4000-0x6eff4027]
> [    3.740874] ACPI: Reserving SSDT table memory at [mem 0x6efd9000-0x6efd9628]
> [    3.825102] ACPI: Reserving SSDT table memory at [mem 0x6efd8000-0x6efd8d7a]
> [    3.909330] ACPI: Reserving SSDT table memory at [mem 0x6efd7000-0x6efd7622]
> [    3.993560] ACPI: Reserving TPM2 table memory at [mem 0x6efd6000-0x6efd604b]
> [    4.077787] ACPI: Reserving EINJ table memory at [mem 0x6efd5000-0x6efd514f]
> [    4.162015] ACPI: Reserving SSDT table memory at [mem 0x6efd4000-0x6efd4363]
> [    4.246245] ACPI: Reserving CRAT table memory at [mem 0x6efd0000-0x6efd39cf]
> [    4.330472] ACPI: Reserving CDIT table memory at [mem 0x6efcf000-0x6efcf028]
> [    4.414700] ACPI: Reserving IVRS table memory at [mem 0x6efce000-0x6efce1ef]
> [    4.498928] ACPI: Reserving SPCR table memory at [mem 0x6efcd000-0x6efcd04f]
> [    4.583157] ACPI: Reserving SSDT table memory at [mem 0x6efcc000-0x6efccc7a]
> [    4.667385] ACPI: Reserving SSDT table memory at [mem 0x6efca000-0x6efcb93b]
> [    4.751624] Setting APIC routing to cluster x2apic.
> [    4.809938] No NUMA configuration found
> [    4.855598] Faking a node at [mem 0x0000000000000000-0x000000407f0fffff]
> [    4.935672] NODE_DATA(0) allocated [mem 0x407f0d5000-0x407f0fffff]
> [    5.009838] Zone ranges:
> [    5.039652]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    5.113482]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    5.187312]   Normal   [mem 0x0000000100000000-0x000000407f0fffff]
> [    5.261141]   Device   empty
> [    5.295456] Movable zone start for each node
> [    5.346411] Early memory node ranges
> [    5.389043]   node   0: [mem 0x0000000000001000-0x000000000008efff]
> [    5.463914]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
> [    5.538782]   node   0: [mem 0x0000000000100000-0x0000000015ffffff]
> [    5.613652]   node   0: [mem 0x0000000056900000-0x00000000569fbfff]
> [    5.688522]   node   0: [mem 0x00000000569fd000-0x000000005a151fff]
> [    5.763390]   node   0: [mem 0x000000005a1d2000-0x0000000067acefff]
> [    5.838261]   node   0: [mem 0x000000006efff000-0x000000006effffff]
> [    5.913129]   node   0: [mem 0x000000006f00b000-0x000000006fffffff]
> [    5.988000]   node   0: [mem 0x0000000100000000-0x000000407f0fffff]
> [    6.062885] Initmem setup node 0 [mem 0x0000000000001000-0x000000407f0fffff]
> [    6.147100] On node 0, zone DMA: 1 pages in unavailable ranges
> [    6.147102] On node 0, zone DMA: 1 pages in unavailable ranges
> [    6.216778] On node 0, zone DMA: 96 pages in unavailable ranges
> [    6.286857] On node 0, zone DMA32: 35072 pages in unavailable ranges
> [    6.357189] On node 0, zone DMA32: 1 pages in unavailable ranges
> [    6.433198] On node 0, zone DMA32: 128 pages in unavailable ranges
> [    6.504979] On node 0, zone DMA32: 30000 pages in unavailable ranges
> [    6.578648] On node 0, zone DMA32: 11 pages in unavailable ranges
> [    6.841050] On node 0, zone Normal: 3840 pages in unavailable ranges
> [    6.911912] tboot: non-0 tboot_addr but it is not of type E820_TYPE_RESERVED
> [    7.072187] ACPI: PM-Timer IO Port: 0x408
> [    7.119894] ACPI: X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> [    7.193711] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    7.264434] IOAPIC[0]: apic_id 240, version 33, address 0xfec00000, GSI 0-23
> [    7.348653] IOAPIC[1]: apic_id 241, version 33, address 0xe0100000, GSI 120-151
> [    7.436000] IOAPIC[2]: apic_id 242, version 33, address 0xc5100000, GSI 88-119
> [    7.522309] IOAPIC[3]: apic_id 243, version 33, address 0xaa100000, GSI 56-87
> [    7.607576] IOAPIC[4]: apic_id 244, version 33, address 0xfd100000, GSI 24-55
> [    7.692842] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    7.768751] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    7.846744] ACPI: Using ACPI (MADT) for SMP configuration information
> [    7.923689] ACPI: HPET id: 0x10228201 base: 0xfed00000
> [    7.985043] ACPI: SPCR: console: uart,io,0x3f8,115200
> [    8.045352] smpboot: Allowing 64 CPUs, 0 hotplug CPUs
> [    8.105682] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    8.196133] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
> [    8.286598] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    8.377066] PM: hibernation: Registered nosave memory: [mem 0x0c1c2000-0x0c1c2fff]
> [    8.467533] PM: hibernation: Registered nosave memory: [mem 0x0c1ca000-0x0c1cafff]
> [    8.557999] PM: hibernation: Registered nosave memory: [mem 0x0c1cb000-0x0c1cbfff]
> [    8.648467] PM: hibernation: Registered nosave memory: [mem 0x0c1f8000-0x0c1f8fff]
> [    8.738934] PM: hibernation: Registered nosave memory: [mem 0x0c1f9000-0x0c1f9fff]
> [    8.829401] PM: hibernation: Registered nosave memory: [mem 0x0c207000-0x0c207fff]
> [    8.919869] PM: hibernation: Registered nosave memory: [mem 0x0c208000-0x0c208fff]
> [    9.010336] PM: hibernation: Registered nosave memory: [mem 0x0c216000-0x0c216fff]
> [    9.100803] PM: hibernation: Registered nosave memory: [mem 0x0c217000-0x0c217fff]
> [    9.191270] PM: hibernation: Registered nosave memory: [mem 0x0c24a000-0x0c24afff]
> [    9.281737] PM: hibernation: Registered nosave memory: [mem 0x0c24b000-0x0c24bfff]
> [    9.372206] PM: hibernation: Registered nosave memory: [mem 0x0c27e000-0x0c27efff]
> [    9.462672] PM: hibernation: Registered nosave memory: [mem 0x16000000-0x568fffff]
> [    9.553140] PM: hibernation: Registered nosave memory: [mem 0x569fc000-0x569fcfff]
> [    9.643608] PM: hibernation: Registered nosave memory: [mem 0x5a152000-0x5a1d1fff]
> [    9.734075] PM: hibernation: Registered nosave memory: [mem 0x67acf000-0x6dfcefff]
> [    9.824541] PM: hibernation: Registered nosave memory: [mem 0x6dfcf000-0x6edfefff]
> [    9.915009] PM: hibernation: Registered nosave memory: [mem 0x6edff000-0x6effefff]
> [   10.005477] PM: hibernation: Registered nosave memory: [mem 0x6f000000-0x6f00afff]
> [   10.095943] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x8fffffff]
> [   10.186411] PM: hibernation: Registered nosave memory: [mem 0x90000000-0xa9ffffff]
> [   10.276877] PM: hibernation: Registered nosave memory: [mem 0xaa000000-0xaaffffff]
> [   10.367345] PM: hibernation: Registered nosave memory: [mem 0xab000000-0xc4ffffff]
> [   10.457813] PM: hibernation: Registered nosave memory: [mem 0xc5000000-0xc5ffffff]
> [   10.548281] PM: hibernation: Registered nosave memory: [mem 0xc6000000-0xdfffffff]
> [   10.638747] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xe0ffffff]
> [   10.729214] PM: hibernation: Registered nosave memory: [mem 0xe1000000-0xfcffffff]
> [   10.819682] PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xffffffff]
> [   10.910151] [mem 0xe1000000-0xfcffffff] available for PCI devices
> [   10.982940] Booting paravirtualized kernel on bare hardware
> [   11.049492] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [   11.174280] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:64 nr_cpu_ids:64 nr_node_ids:1
> [   11.268821] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
> [   11.345855] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=1*2097152
> [   11.345857] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
> [   11.345863] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31 
> [   11.345869] pcpu-alloc: [0] 32 33 34 35 36 37 38 39 [0] 40 41 42 43 44 45 46 47 
> [   11.345874] pcpu-alloc: [0] 48 49 50 51 52 53 54 55 [0] 56 57 58 59 60 61 62 63 
> [   11.345905] Fallback order for Node 0: 0 
> [   11.393685] Built 1 zonelists, mobility grouping on.  Total pages: 65700474
> [   11.476870] Policy zone: Normal
> [   11.514304] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.18.0-snp-host+ root=UUID=fe266f32-9e15-498c-9211-8f9d1a1a4c6e ro console=tty0 console=ttyS1,115200n8 systemd.unified_cgroup_hierarchy=0 earlyprintk=ttyS1 console=tty1 console=ttyS0
> [   11.769132] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-5.18.0-snp-host+", will be passed to user space.
> [   11.904250] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [   11.987438] printk: log_buf_len total cpu_extra contributions: 258048 bytes
> [   12.070626] printk: log_buf_len min size: 262144 bytes
> [   12.132143] printk: log_buf_len: 524288 bytes
> [   12.183970] printk: early log buf free: 243840(93%)
> [   12.244463] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, linear)
> [   12.342430] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
> [   12.437192] mem auto-init: stack:off, heap alloc:on, heap free:off
> [   12.777804] Memory: 262368800K/266979208K available (16392K kernel code, 4524K rwdata, 5548K rodata, 2732K init, 4876K bss, 4610148K reserved, 0K cma-reserved)
> [   12.946514] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=1
> [   13.025429] ftrace: allocating 47765 entries in 187 pages
> [   13.098377] ftrace: allocated 187 pages with 6 groups
> [   13.157402] Dynamic Preempt: voluntary
> [   13.201539] rcu: Preemptible hierarchical RCU implementation.
> [   13.270099] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=64.
> [   13.352247] 	Trampoline variant of Tasks RCU enabled.
> [   13.412558] 	Rude variant of Tasks RCU enabled.
> [   13.466630] 	Tracing variant of Tasks RCU enabled.
> [   13.523822] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [   13.614290] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=64
> [   13.697908] NR_IRQS: 524544, nr_irqs: 3112, preallocated irqs: 16
> [   13.768965] Console: colour dummy device 80x25
> [   13.821979] printk: console [tty0] enabled
> [   15.591580] printk: console [ttyS1] enabled
> [   15.599945] ACPI: Core revision 20211217
> [   15.607881] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [   15.626110] APIC: Switch to symmetric I/O mode setup
> [   15.638346] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [   15.670107] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2569339d3ba, max_idle_ns: 440795301522 ns
> [   15.691143] Calibrating delay loop (skipped), value calculated using timer frequency.. 5190.76 BogoMIPS (lpj=10381536)
> [   15.695140] pid_max: default: 65536 minimum: 512
> [   15.704406] LSM: Security Framework initializing
> [   15.707149] landlock: Up and running.
> [   15.711140] Yama: becoming mindful.
> [   15.715154] AppArmor: AppArmor initialized
> [   15.719247] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [   15.723216] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [   15.731141] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [   15.735238] LVT offset 2 assigned for vector 0xf4
> [   15.739172] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
> [   15.743140] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
> [   15.747143] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [   15.751141] Spectre V2 : Mitigation: Retpolines
> [   15.755140] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [   15.759140] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [   15.763141] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [   15.767140] Spectre V2 : User space: Mitigation: STIBP always-on protection
> [   15.771141] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [   15.781202] Freeing SMP alternatives memory: 40K
> [   15.894697] smpboot: CPU0: AMD EPYC 7513 32-Core Processor (family: 0x19, model: 0x1, stepping: 0x1)
> [   15.895225] cblist_init_generic: Setting adjustable number of callback queues.
> [   15.899140] cblist_init_generic: Setting shift to 6 and lim to 1.
> [   15.903152] cblist_init_generic: Setting shift to 6 and lim to 1.
> [   15.907152] cblist_init_generic: Setting shift to 6 and lim to 1.
> [   15.911151] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> [   15.915141] ... version:                0
> [   15.919140] ... bit width:              48
> [   15.923140] ... generic registers:      6
> [   15.927140] ... value mask:             0000ffffffffffff
> [   15.931140] ... max period:             00007fffffffffff
> [   15.935140] ... fixed-purpose events:   0
> [   15.939140] ... event mask:             000000000000003f
> [   15.943193] rcu: Hierarchical SRCU implementation.
> [   15.947449] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [   15.951423] smp: Bringing up secondary CPUs ...
> [   15.955211] x86: Booting SMP configuration:
> [   15.959142] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31 #32
> [   16.035230] Spectre V2 : Update user space SMT mitigation: STIBP always-on
> [   16.043251]  #33 #34 #35 #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47 #48 #49 #50 #51 #52 #53 #54 #55 #56 #57 #58 #59 #60 #61 #62 #63
> [   16.113361] smp: Brought up 1 node, 64 CPUs
> [   16.119141] smpboot: Max logical packages: 1
> [   16.123141] smpboot: Total of 64 processors activated (332209.15 BogoMIPS)
> [   16.137134] devtmpfs: initialized
> [   16.139178] x86/mm: Memory block size: 2048MB
> [   16.143889] ACPI: PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
> [   16.147142] ACPI: PM: Registering ACPI NVS region [mem 0x6dfcf000-0x6edfefff] (14876672 bytes)
> [   16.155198] ACPI: PM: Registering ACPI NVS region [mem 0x6f000000-0x6f00afff] (45056 bytes)
> [   16.159178] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [   16.163185] futex hash table entries: 16384 (order: 8, 1048576 bytes, linear)
> [   16.167232] pinctrl core: initialized pinctrl subsystem
> [   16.171227] PM: RTC time: 08:33:22, date: 2022-08-16
> [   16.175395] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [   16.179379] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> [   16.183313] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [   16.187312] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [   16.191145] audit: initializing netlink subsys (disabled)
> [   16.195163] audit: type=2000 audit(1660638799.536:1): state=initialized audit_enabled=0 res=1
> [   16.195214] thermal_sys: Registered thermal governor 'fair_share'
> [   16.199142] thermal_sys: Registered thermal governor 'bang_bang'
> [   16.203144] thermal_sys: Registered thermal governor 'step_wise'
> [   16.207140] thermal_sys: Registered thermal governor 'user_space'
> [   16.211140] thermal_sys: Registered thermal governor 'power_allocator'
> [   16.215144] EISA bus registered
> [   16.223162] cpuidle: using governor ladder
> [   16.231157] cpuidle: using governor menu
> [   16.235186] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [   16.239142] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [   16.243185] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [   16.247143] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> [   16.251156] PCI: Using configuration type 1 for base access
> [   16.255147] PCI: Dell System detected, enabling pci=bfsort.
> [   16.261075] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [   16.263177] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [   16.267142] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [   16.271183] fbcon: Taking over console
> [   16.275183] ACPI: Added _OSI(Module Device)
> [   16.279146] ACPI: Added _OSI(Processor Device)
> [   16.283141] ACPI: Added _OSI(3.0 _SCP Extensions)
> [   16.287140] ACPI: Added _OSI(Processor Aggregator Device)
> [   16.291141] ACPI: Added _OSI(Linux-Dell-Video)
> [   16.295140] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [   16.299140] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [   16.315835] ACPI: 7 ACPI AML tables successfully acquired and loaded
> [   16.324306] ACPI: Interpreter enabled
> [   16.327148] ACPI: PM: (supports S0 S5)
> [   16.331140] ACPI: Using IOAPIC for interrupt routing
> [   16.335391] HEST: Table parsing has been initialized.
> [   16.339407] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> [   16.343142] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [   16.348154] ACPI: Enabled 1 GPEs in block 00 to 1F
> [   16.367133] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
> [   16.367176] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
> [   16.371175] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
> [   16.375181] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
> [   16.379175] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> [   16.383174] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
> [   16.387174] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> [   16.391174] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
> [   16.395352] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-3f])
> [   16.399143] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   16.403200] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
> [   16.407250] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   16.411141] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [   16.415483] PCI host bridge to bus 0000:00
> [   16.419141] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
> [   16.423140] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
> [   16.427140] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000fffff window]
> [   16.431140] pci_bus 0000:00: root bus resource [io  0x0d00-0x3fff window]
> [   16.435140] pci_bus 0000:00: root bus resource [mem 0xe1000000-0xfebfffff window]
> [   16.439140] pci_bus 0000:00: root bus resource [mem 0x63dc0000000-0x7fcffffffff window]
> [   16.443141] pci_bus 0000:00: root bus resource [bus 00-3f]
> [   16.447150] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
> [   16.451217] pci 0000:00:00.2: [1022:164f] type 00 class 0x080600
> [   16.455212] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
> [   16.459192] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
> [   16.463191] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
> [   16.467190] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
> [   16.471191] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
> [   16.475191] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
> [   16.479185] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
> [   16.483164] pci 0000:00:07.1: enabling Extended Tags
> [   16.487179] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
> [   16.491212] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
> [   16.495188] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
> [   16.499164] pci 0000:00:08.1: enabling Extended Tags
> [   16.503180] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [   16.507226] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
> [   16.511229] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
> [   16.515247] pci 0000:00:18.0: [1022:1650] type 00 class 0x060000
> [   16.519177] pci 0000:00:18.1: [1022:1651] type 00 class 0x060000
> [   16.523166] pci 0000:00:18.2: [1022:1652] type 00 class 0x060000
> [   16.527166] pci 0000:00:18.3: [1022:1653] type 00 class 0x060000
> [   16.531167] pci 0000:00:18.4: [1022:1654] type 00 class 0x060000
> [   16.535169] pci 0000:00:18.5: [1022:1655] type 00 class 0x060000
> [   16.539167] pci 0000:00:18.6: [1022:1656] type 00 class 0x060000
> [   16.543166] pci 0000:00:18.7: [1022:1657] type 00 class 0x060000
> [   16.547216] pci 0000:01:00.0: [1022:148a] type 00 class 0x130000
> [   16.551177] pci 0000:01:00.0: enabling Extended Tags
> [   16.555236] pci 0000:01:00.2: [1022:1498] type 00 class 0x108000
> [   16.559157] pci 0000:01:00.2: reg 0x18: [mem 0xf7200000-0xf727ffff]
> [   16.563153] pci 0000:01:00.2: reg 0x24: [mem 0xf7280000-0xf7281fff]
> [   16.567148] pci 0000:01:00.2: enabling Extended Tags
> [   16.575153] pci 0000:00:07.1: PCI bridge to [bus 01]
> [   16.579144] pci 0000:00:07.1:   bridge window [mem 0xf7200000-0xf72fffff]
> [   16.583207] pci 0000:02:00.0: [1022:1485] type 00 class 0x130000
> [   16.587181] pci 0000:02:00.0: enabling Extended Tags
> [   16.591257] pci 0000:02:00.2: [1022:1498] type 00 class 0x108000
> [   16.595159] pci 0000:02:00.2: reg 0x18: [mem 0xf7100000-0xf717ffff]
> [   16.599154] pci 0000:02:00.2: reg 0x24: [mem 0xf7180000-0xf7181fff]
> [   16.603149] pci 0000:02:00.2: enabling Extended Tags
> [   16.607243] pci 0000:02:00.3: [1022:148c] type 00 class 0x0c0330
> [   16.611152] pci 0000:02:00.3: reg 0x10: [mem 0xf7000000-0xf70fffff 64bit]
> [   16.615168] pci 0000:02:00.3: enabling Extended Tags
> [   16.619183] pci 0000:02:00.3: PME# supported from D0 D3hot D3cold
> [   16.623217] pci 0000:00:08.1: PCI bridge to [bus 02]
> [   16.627144] pci 0000:00:08.1:   bridge window [mem 0xf7000000-0xf71fffff]
> [   16.635413] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 40-7f])
> [   16.639142] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   16.643201] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER]
> [   16.647249] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   16.651141] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
> [   16.655465] PCI host bridge to bus 0000:40
> [   16.659141] pci_bus 0000:40: root bus resource [io  0x4000-0x6fff window]
> [   16.663140] pci_bus 0000:40: root bus resource [mem 0x90000000-0xaaffffff window]
> [   16.667140] pci_bus 0000:40: root bus resource [mem 0x47e80000000-0x63dbfffffff window]
> [   16.671140] pci_bus 0000:40: root bus resource [bus 40-7f]
> [   16.675147] pci 0000:40:00.0: [1022:1480] type 00 class 0x060000
> [   16.679195] pci 0000:40:00.2: [1022:164f] type 00 class 0x080600
> [   16.683205] pci 0000:40:01.0: [1022:1482] type 00 class 0x060000
> [   16.687185] pci 0000:40:01.1: [1022:1483] type 01 class 0x060400
> [   16.691210] pci 0000:40:01.1: PME# supported from D0 D3hot D3cold
> [   16.695644] pci 0000:40:02.0: [1022:1482] type 00 class 0x060000
> [   16.699195] pci 0000:40:03.0: [1022:1482] type 00 class 0x060000
> [   16.703195] pci 0000:40:03.1: [1022:1483] type 01 class 0x060400
> [   16.707214] pci 0000:40:03.1: PME# supported from D0 D3hot D3cold
> [   16.711718] pci 0000:40:03.2: [1022:1483] type 01 class 0x060400
> [   16.715211] pci 0000:40:03.2: PME# supported from D0 D3hot D3cold
> [   16.719629] pci 0000:40:03.3: [1022:1483] type 01 class 0x060400
> [   16.723211] pci 0000:40:03.3: PME# supported from D0 D3hot D3cold
> [   16.731587] pci 0000:40:03.4: [1022:1483] type 01 class 0x060400
> [   16.735211] pci 0000:40:03.4: PME# supported from D0 D3hot D3cold
> [   16.739626] pci 0000:40:04.0: [1022:1482] type 00 class 0x060000
> [   16.743188] pci 0000:40:05.0: [1022:1482] type 00 class 0x060000
> [   16.747186] pci 0000:40:07.0: [1022:1482] type 00 class 0x060000
> [   16.751184] pci 0000:40:07.1: [1022:1484] type 01 class 0x060400
> [   16.755163] pci 0000:40:07.1: enabling Extended Tags
> [   16.759178] pci 0000:40:07.1: PME# supported from D0 D3hot D3cold
> [   16.763204] pci 0000:40:08.0: [1022:1482] type 00 class 0x060000
> [   16.767185] pci 0000:40:08.1: [1022:1484] type 01 class 0x060400
> [   16.771164] pci 0000:40:08.1: enabling Extended Tags
> [   16.775179] pci 0000:40:08.1: PME# supported from D0 D3hot D3cold
> [   16.779271] pci 0000:41:00.0: [8086:159b] type 00 class 0x020000
> [   16.783154] pci 0000:41:00.0: reg 0x10: [mem 0x92000000-0x93ffffff 64bit pref]
> [   16.787155] pci 0000:41:00.0: reg 0x1c: [mem 0x94010000-0x9401ffff 64bit pref]
> [   16.791152] pci 0000:41:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
> [   16.795236] pci 0000:41:00.0: reg 0x184: [mem 0x00000000-0x0001ffff 64bit pref]
> [   16.799140] pci 0000:41:00.0: VF(n) BAR0 space: [mem 0x00000000-0x00ffffff 64bit pref] (contains BAR0 for 128 VFs)
> [   16.803153] pci 0000:41:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
> [   16.807140] pci 0000:41:00.0: VF(n) BAR3 space: [mem 0x00000000-0x001fffff 64bit pref] (contains BAR3 for 128 VFs)
> [   16.811499] pci 0000:41:00.1: [8086:159b] type 00 class 0x020000
> [   16.815154] pci 0000:41:00.1: reg 0x10: [mem 0x90000000-0x91ffffff 64bit pref]
> [   16.819155] pci 0000:41:00.1: reg 0x1c: [mem 0x94000000-0x9400ffff 64bit pref]
> [   16.823152] pci 0000:41:00.1: reg 0x30: [mem 0xfff00000-0xffffffff pref]
> [   16.827222] pci 0000:41:00.1: reg 0x184: [mem 0x00000000-0x0001ffff 64bit pref]
> [   16.831141] pci 0000:41:00.1: VF(n) BAR0 space: [mem 0x00000000-0x00ffffff 64bit pref] (contains BAR0 for 128 VFs)
> [   16.835153] pci 0000:41:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
> [   16.839141] pci 0000:41:00.1: VF(n) BAR3 space: [mem 0x00000000-0x001fffff 64bit pref] (contains BAR3 for 128 VFs)
> [   16.843457] pci 0000:40:01.1: PCI bridge to [bus 41]
> [   16.847146] pci 0000:40:01.1:   bridge window [mem 0x90000000-0x940fffff 64bit pref]
> [   16.851140] pci 0000:40:01.1: bridge has subordinate 41 but max busn 42
> [   16.855186] pci 0000:40:03.1: PCI bridge to [bus 42]
> [   16.859144] pci 0000:40:03.1:   bridge window [mem 0xa4400000-0xa47fffff]
> [   16.863187] pci 0000:40:03.2: PCI bridge to [bus 43]
> [   16.867144] pci 0000:40:03.2:   bridge window [mem 0xa4000000-0xa43fffff]
> [   16.871253] pci 0000:44:00.0: [1344:51b1] type 00 class 0x010802
> [   16.875271] pci 0000:44:00.0: reg 0x10: [mem 0xa4d00000-0xa4d03fff 64bit]
> [   16.879423] pci 0000:44:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
> [   16.885097] pci 0000:40:03.3: PCI bridge to [bus 44]
> [   16.887148] pci 0000:40:03.3:   bridge window [mem 0xa4d00000-0xa4dfffff]
> [   16.891262] pci 0000:45:00.0: [1344:51b1] type 00 class 0x010802
> [   16.895271] pci 0000:45:00.0: reg 0x10: [mem 0xa4c00000-0xa4c03fff 64bit]
> [   16.903415] pci 0000:45:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
> [   16.909046] pci 0000:40:03.4: PCI bridge to [bus 45]
> [   16.911144] pci 0000:40:03.4:   bridge window [mem 0xa4c00000-0xa4cfffff]
> [   16.915189] pci 0000:46:00.0: [1022:148a] type 00 class 0x130000
> [   16.919176] pci 0000:46:00.0: enabling Extended Tags
> [   16.923237] pci 0000:46:00.2: [1022:1498] type 00 class 0x108000
> [   16.927157] pci 0000:46:00.2: reg 0x18: [mem 0xa4b00000-0xa4b7ffff]
> [   16.931153] pci 0000:46:00.2: reg 0x24: [mem 0xa4b80000-0xa4b81fff]
> [   16.935148] pci 0000:46:00.2: enabling Extended Tags
> [   16.943226] pci 0000:40:07.1: PCI bridge to [bus 46]
> [   16.947143] pci 0000:40:07.1:   bridge window [mem 0xa4b00000-0xa4bfffff]
> [   16.951222] pci 0000:47:00.0: [1022:1485] type 00 class 0x130000
> [   16.955181] pci 0000:47:00.0: enabling Extended Tags
> [   16.959257] pci 0000:47:00.1: [1022:1486] type 00 class 0x108000
> [   16.963159] pci 0000:47:00.1: reg 0x18: [mem 0xa4900000-0xa49fffff]
> [   16.967155] pci 0000:47:00.1: reg 0x24: [mem 0xa4a82000-0xa4a83fff]
> [   16.971149] pci 0000:47:00.1: enabling Extended Tags
> [   16.975244] pci 0000:47:00.2: [1022:1498] type 00 class 0x108000
> [   16.979158] pci 0000:47:00.2: reg 0x18: [mem 0xa4a00000-0xa4a7ffff]
> [   16.983154] pci 0000:47:00.2: reg 0x24: [mem 0xa4a80000-0xa4a81fff]
> [   16.987150] pci 0000:47:00.2: enabling Extended Tags
> [   16.991246] pci 0000:47:00.3: [1022:148c] type 00 class 0x0c0330
> [   16.995152] pci 0000:47:00.3: reg 0x10: [mem 0xa4800000-0xa48fffff 64bit]
> [   16.999167] pci 0000:47:00.3: enabling Extended Tags
> [   17.003183] pci 0000:47:00.3: PME# supported from D0 D3hot D3cold
> [   17.007225] pci 0000:40:08.1: PCI bridge to [bus 47]
> [   17.011148] pci 0000:40:08.1:   bridge window [mem 0xa4800000-0xa4afffff]
> [   17.015503] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 80-bf])
> [   17.019157] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   17.023204] acpi PNP0A08:02: _OSC: platform does not support [SHPCHotplug AER]
> [   17.027249] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   17.031140] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
> [   17.035475] PCI host bridge to bus 0000:80
> [   17.039141] pci_bus 0000:80: root bus resource [io  0x7000-0x9fff window]
> [   17.043140] pci_bus 0000:80: root bus resource [mem 0xab000000-0xc5ffffff window]
> [   17.047140] pci_bus 0000:80: root bus resource [mem 0x2bf40000000-0x47e7fffffff window]
> [   17.051141] pci_bus 0000:80: root bus resource [bus 80-bf]
> [   17.055147] pci 0000:80:00.0: [1022:1480] type 00 class 0x060000
> [   17.059197] pci 0000:80:00.2: [1022:164f] type 00 class 0x080600
> [   17.063205] pci 0000:80:01.0: [1022:1482] type 00 class 0x060000
> [   17.067188] pci 0000:80:01.1: [1022:1483] type 01 class 0x060400
> [   17.071226] pci 0000:80:01.1: PME# supported from D0 D3hot D3cold
> [   17.075729] pci 0000:80:01.2: [1022:1483] type 01 class 0x060400
> [   17.079224] pci 0000:80:01.2: PME# supported from D0 D3hot D3cold
> [   17.083640] pci 0000:80:02.0: [1022:1482] type 00 class 0x060000
> [   17.087190] pci 0000:80:03.0: [1022:1482] type 00 class 0x060000
> [   17.091192] pci 0000:80:04.0: [1022:1482] type 00 class 0x060000
> [   17.095189] pci 0000:80:05.0: [1022:1482] type 00 class 0x060000
> [   17.099185] pci 0000:80:07.0: [1022:1482] type 00 class 0x060000
> [   17.103185] pci 0000:80:07.1: [1022:1484] type 01 class 0x060400
> [   17.107163] pci 0000:80:07.1: enabling Extended Tags
> [   17.111179] pci 0000:80:07.1: PME# supported from D0 D3hot D3cold
> [   17.115213] pci 0000:80:08.0: [1022:1482] type 00 class 0x060000
> [   17.119186] pci 0000:80:08.1: [1022:1484] type 01 class 0x060400
> [   17.123164] pci 0000:80:08.1: enabling Extended Tags
> [   17.127180] pci 0000:80:08.1: PME# supported from D0 D3hot D3cold
> [   17.131275] pci 0000:80:01.1: PCI bridge to [bus 81]
> [   17.135144] pci 0000:80:01.1:   bridge window [mem 0xbf400000-0xbf7fffff]
> [   17.139190] pci 0000:80:01.2: PCI bridge to [bus 82]
> [   17.143144] pci 0000:80:01.2:   bridge window [mem 0xbf000000-0xbf3fffff]
> [   17.147188] pci 0000:83:00.0: [1022:148a] type 00 class 0x130000
> [   17.151177] pci 0000:83:00.0: enabling Extended Tags
> [   17.155239] pci 0000:83:00.2: [1022:1498] type 00 class 0x108000
> [   17.159157] pci 0000:83:00.2: reg 0x18: [mem 0xbf900000-0xbf97ffff]
> [   17.163153] pci 0000:83:00.2: reg 0x24: [mem 0xbf980000-0xbf981fff]
> [   17.167148] pci 0000:83:00.2: enabling Extended Tags
> [   17.171246] pci 0000:80:07.1: PCI bridge to [bus 83]
> [   17.175143] pci 0000:80:07.1:   bridge window [mem 0xbf900000-0xbf9fffff]
> [   17.179205] pci 0000:84:00.0: [1022:1485] type 00 class 0x130000
> [   17.183180] pci 0000:84:00.0: enabling Extended Tags
> [   17.187256] pci 0000:84:00.2: [1022:1498] type 00 class 0x108000
> [   17.191159] pci 0000:84:00.2: reg 0x18: [mem 0xbf800000-0xbf87ffff]
> [   17.195154] pci 0000:84:00.2: reg 0x24: [mem 0xbf880000-0xbf881fff]
> [   17.199149] pci 0000:84:00.2: enabling Extended Tags
> [   17.203256] pci 0000:80:08.1: PCI bridge to [bus 84]
> [   17.207144] pci 0000:80:08.1:   bridge window [mem 0xbf800000-0xbf8fffff]
> [   17.211464] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus c0-ff])
> [   17.215142] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   17.219201] acpi PNP0A08:03: _OSC: platform does not support [SHPCHotplug AER]
> [   17.223249] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   17.227140] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using BIOS configuration
> [   17.231511] PCI host bridge to bus 0000:c0
> [   17.235141] pci_bus 0000:c0: root bus resource [io  0xa000-0xffff window]
> [   17.239140] pci_bus 0000:c0: root bus resource [mem 0xc6000000-0xe0ffffff window]
> [   17.243141] pci_bus 0000:c0: root bus resource [mem 0x10000000000-0x2bf3fffffff window]
> [   17.247141] pci_bus 0000:c0: root bus resource [io  0x03b0-0x03df window]
> [   17.251141] pci_bus 0000:c0: root bus resource [mem 0x000a0000-0x000bffff window]
> [   17.255140] pci_bus 0000:c0: root bus resource [bus c0-ff]
> [   17.259147] pci 0000:c0:00.0: [1022:1480] type 00 class 0x060000
> [   17.263195] pci 0000:c0:00.2: [1022:164f] type 00 class 0x080600
> [   17.267201] pci 0000:c0:01.0: [1022:1482] type 00 class 0x060000
> [   17.271184] pci 0000:c0:01.1: [1022:1483] type 01 class 0x060400
> [   17.275209] pci 0000:c0:01.1: PME# supported from D0 D3hot D3cold
> [   17.279632] pci 0000:c0:02.0: [1022:1482] type 00 class 0x060000
> [   17.283188] pci 0000:c0:03.0: [1022:1482] type 00 class 0x060000
> [   17.287188] pci 0000:c0:03.1: [1022:1483] type 01 class 0x060400
> [   17.291220] pci 0000:c0:03.1: PME# supported from D0 D3hot D3cold
> [   17.295718] pci 0000:c0:03.2: [1022:1483] type 01 class 0x060400
> [   17.299221] pci 0000:c0:03.2: PME# supported from D0 D3hot D3cold
> [   17.303664] pci 0000:c0:03.3: [1022:1483] type 01 class 0x060400
> [   17.307220] pci 0000:c0:03.3: PME# supported from D0 D3hot D3cold
> [   17.311663] pci 0000:c0:03.4: [1022:1483] type 01 class 0x060400
> [   17.315221] pci 0000:c0:03.4: PME# supported from D0 D3hot D3cold
> [   17.323598] pci 0000:c0:04.0: [1022:1482] type 00 class 0x060000
> [   17.327186] pci 0000:c0:05.0: [1022:1482] type 00 class 0x060000
> [   17.331185] pci 0000:c0:05.2: [1022:149a] type 01 class 0x060400
> [   17.335195] pci 0000:c0:05.2: PME# supported from D0 D3hot D3cold
> [   17.339199] pci 0000:c0:07.0: [1022:1482] type 00 class 0x060000
> [   17.343185] pci 0000:c0:07.1: [1022:1484] type 01 class 0x060400
> [   17.347163] pci 0000:c0:07.1: enabling Extended Tags
> [   17.351177] pci 0000:c0:07.1: PME# supported from D0 D3hot D3cold
> [   17.355201] pci 0000:c0:08.0: [1022:1482] type 00 class 0x060000
> [   17.359187] pci 0000:c0:08.1: [1022:1484] type 01 class 0x060400
> [   17.363163] pci 0000:c0:08.1: enabling Extended Tags
> [   17.367178] pci 0000:c0:08.1: PME# supported from D0 D3hot D3cold
> [   17.371267] pci 0000:c3:00.0: [1b4b:9230] type 00 class 0x010601
> [   17.375151] pci 0000:c3:00.0: reg 0x10: [io  0xa028-0xa02f]
> [   17.379146] pci 0000:c3:00.0: reg 0x14: [io  0xa034-0xa037]
> [   17.383146] pci 0000:c3:00.0: reg 0x18: [io  0xa020-0xa027]
> [   17.387146] pci 0000:c3:00.0: reg 0x1c: [io  0xa030-0xa033]
> [   17.391146] pci 0000:c3:00.0: reg 0x20: [io  0xa000-0xa01f]
> [   17.395146] pci 0000:c3:00.0: reg 0x24: [mem 0xdbc00000-0xdbc007ff]
> [   17.399146] pci 0000:c3:00.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
> [   17.403150] pci 0000:c3:00.0: Enabling fixed DMA alias to 00.1
> [   17.407168] pci 0000:c3:00.0: PME# supported from D3hot
> [   17.411233] pci 0000:c0:01.1: PCI bridge to [bus c3]
> [   17.415143] pci 0000:c0:01.1:   bridge window [io  0xa000-0xafff]
> [   17.419141] pci 0000:c0:01.1:   bridge window [mem 0xdbc00000-0xdbcfffff]
> [   17.423190] pci 0000:c0:03.1: PCI bridge to [bus c4]
> [   17.427144] pci 0000:c0:03.1:   bridge window [mem 0xdb600000-0xdb9fffff]
> [   17.431197] pci 0000:c0:03.2: PCI bridge to [bus c5]
> [   17.435144] pci 0000:c0:03.2:   bridge window [mem 0xdb200000-0xdb5fffff]
> [   17.439189] pci 0000:c0:03.3: PCI bridge to [bus c6]
> [   17.443144] pci 0000:c0:03.3:   bridge window [mem 0xdae00000-0xdb1fffff]
> [   17.447189] pci 0000:c0:03.4: PCI bridge to [bus c7]
> [   17.451144] pci 0000:c0:03.4:   bridge window [mem 0xdaa00000-0xdadfffff]
> [   17.455184] pci 0000:c1:00.0: [1556:be00] type 01 class 0x060400
> [   17.471159] pci 0000:c0:05.2: PCI bridge to [bus c1-c2]
> [   17.475144] pci 0000:c0:05.2:   bridge window [mem 0xda000000-0xda8fffff]
> [   17.479143] pci 0000:c0:05.2:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
> [   17.483181] pci_bus 0000:c2: extended config space not accessible
> [   17.495170] pci 0000:c2:00.0: [102b:0536] type 00 class 0x030000
> [   17.499156] pci 0000:c2:00.0: reg 0x10: [mem 0xc6000000-0xc6ffffff pref]
> [   17.503148] pci 0000:c2:00.0: reg 0x14: [mem 0xda808000-0xda80bfff]
> [   17.507148] pci 0000:c2:00.0: reg 0x18: [mem 0xda000000-0xda7fffff]
> [   17.511180] pci 0000:c2:00.0: BAR 0: assigned to efifb
> [   17.515146] pci 0000:c2:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [   17.519223] pci 0000:c1:00.0: PCI bridge to [bus c2]
> [   17.523147] pci 0000:c1:00.0:   bridge window [mem 0xda000000-0xda8fffff]
> [   17.527144] pci 0000:c1:00.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
> [   17.535166] pci 0000:c8:00.0: [1022:148a] type 00 class 0x130000
> [   17.539176] pci 0000:c8:00.0: enabling Extended Tags
> [   17.543235] pci 0000:c8:00.2: [1022:1498] type 00 class 0x108000
> [   17.547156] pci 0000:c8:00.2: reg 0x18: [mem 0xdbb00000-0xdbb7ffff]
> [   17.551153] pci 0000:c8:00.2: reg 0x24: [mem 0xdbb80000-0xdbb81fff]
> [   17.555148] pci 0000:c8:00.2: enabling Extended Tags
> [   17.559244] pci 0000:c0:07.1: PCI bridge to [bus c8]
> [   17.563143] pci 0000:c0:07.1:   bridge window [mem 0xdbb00000-0xdbbfffff]
> [   17.567205] pci 0000:c9:00.0: [1022:1485] type 00 class 0x130000
> [   17.571179] pci 0000:c9:00.0: enabling Extended Tags
> [   17.575253] pci 0000:c9:00.2: [1022:1498] type 00 class 0x108000
> [   17.579158] pci 0000:c9:00.2: reg 0x18: [mem 0xdba00000-0xdba7ffff]
> [   17.583155] pci 0000:c9:00.2: reg 0x24: [mem 0xdba80000-0xdba81fff]
> [   17.587149] pci 0000:c9:00.2: enabling Extended Tags
> [   17.591249] pci 0000:c0:08.1: PCI bridge to [bus c9]
> [   17.595143] pci 0000:c0:08.1:   bridge window [mem 0xdba00000-0xdbafffff]
> [   17.604053] iommu: Default domain type: Translated 
> [   17.607141] iommu: DMA domain TLB invalidation policy: lazy mode 
> [   17.611255] SCSI subsystem initialized
> [   17.615153] libata version 3.00 loaded.
> [   17.615162] ACPI: bus type USB registered
> [   17.619148] usbcore: registered new interface driver usbfs
> [   17.623144] usbcore: registered new interface driver hub
> [   17.631145] usbcore: registered new device driver usb
> [   17.635175] pps_core: LinuxPPS API ver. 1 registered
> [   17.639140] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [   17.643142] PTP clock support registered
> [   17.647157] EDAC MC: Ver: 3.0.0
> [   17.651301] Registered efivars operations
> [   17.655251] NetLabel: Initializing
> [   17.659141] NetLabel:  domain hash size = 128
> [   17.663140] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [   17.667154] NetLabel:  unlabeled traffic allowed by default
> [   17.671165] PCI: Using ACPI for IRQ routing
> [   17.681629] PCI: pci_cache_line_size set to 64 bytes
> [   17.681786] Expanded resource Reserved due to conflict with PCI Bus 0000:00
> [   17.683142] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
> [   17.683144] e820: reserve RAM buffer [mem 0x0c1c2020-0x0fffffff]
> [   17.683145] e820: reserve RAM buffer [mem 0x0c1cb020-0x0fffffff]
> [   17.683146] e820: reserve RAM buffer [mem 0x0c1f9020-0x0fffffff]
> [   17.683147] e820: reserve RAM buffer [mem 0x0c208020-0x0fffffff]
> [   17.683148] e820: reserve RAM buffer [mem 0x0c217020-0x0fffffff]
> [   17.683148] e820: reserve RAM buffer [mem 0x0c24b020-0x0fffffff]
> [   17.683149] e820: reserve RAM buffer [mem 0x16000000-0x17ffffff]
> [   17.683150] e820: reserve RAM buffer [mem 0x569fc000-0x57ffffff]
> [   17.683150] e820: reserve RAM buffer [mem 0x5a152000-0x5bffffff]
> [   17.683151] e820: reserve RAM buffer [mem 0x67acf000-0x67ffffff]
> [   17.683152] e820: reserve RAM buffer [mem 0x6f000000-0x6fffffff]
> [   17.683152] e820: reserve RAM buffer [mem 0x407f100000-0x407fffffff]
> [   17.683202] pci 0000:c2:00.0: vgaarb: setting as boot VGA device
> [   17.687140] pci 0000:c2:00.0: vgaarb: bridge control possible
> [   17.687140] pci 0000:c2:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [   17.687141] vgaarb: loaded
> [   17.691194] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [   17.695141] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [   17.704166] SEV-SNP: RMP table physical address 0x0000000016000000 - 0x00000000568fffff
> [   17.728180] clocksource: Switched to clocksource tsc-early
> [   17.745151] VFS: Disk quotas dquot_6.6.0
> [   17.752990] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [   17.766799] AppArmor: AppArmor Filesystem Enabled
> [   17.776191] pnp: PnP ACPI init
> [   17.782480] system 00:00: [mem 0x80000000-0x8fffffff] has been reserved
> [   17.795715] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
> [   17.809718] pnp: PnP ACPI: found 5 devices
> [   17.823870] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   17.841610] NET: Registered PF_INET protocol family
> [   17.851436] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [   17.867484] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [   17.885268] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [   17.901917] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [   17.916738] TCP: Hash tables configured (established 524288 bind 65536)
> [   17.930088] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
> [   17.945527] UDP hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [   17.959638] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [   17.974597] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [   17.985886] NET: Registered PF_XDP protocol family
> [   17.995446] pci 0000:41:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
> [   18.015226] pci 0000:41:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
> [   18.035016] pci 0000:44:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
> [   18.054792] pci 0000:45:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
> [   18.074575] pci 0000:c3:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
> [   18.094364] pci 0000:00:07.1: PCI bridge to [bus 01]
> [   18.104267] pci 0000:00:07.1:   bridge window [mem 0xf7200000-0xf72fffff]
> [   18.117810] pci 0000:00:08.1: PCI bridge to [bus 02]
> [   18.127712] pci 0000:00:08.1:   bridge window [mem 0xf7000000-0xf71fffff]
> [   18.141258] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
> [   18.153604] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
> [   18.165934] pci_bus 0000:00: resource 6 [mem 0x000c0000-0x000fffff window]
> [   18.179643] pci_bus 0000:00: resource 7 [io  0x0d00-0x3fff window]
> [   18.191966] pci_bus 0000:00: resource 8 [mem 0xe1000000-0xfebfffff window]
> [   18.205683] pci_bus 0000:00: resource 9 [mem 0x63dc0000000-0x7fcffffffff window]
> [   18.220432] pci_bus 0000:01: resource 1 [mem 0xf7200000-0xf72fffff]
> [   18.232935] pci_bus 0000:02: resource 1 [mem 0xf7000000-0xf71fffff]
> [   18.245492] pci_bus 0000:40: max bus depth: 1 pci_try_num: 2
> [   18.256792] pci 0000:40:01.1: BAR 14: assigned [mem 0x94100000-0x942fffff]
> [   18.270509] pci 0000:40:03.1: BAR 15: assigned [mem 0x47e80000000-0x47e801fffff 64bit pref]
> [   18.287165] pci 0000:40:03.2: BAR 15: assigned [mem 0x47e80200000-0x47e803fffff 64bit pref]
> [   18.303827] pci 0000:40:03.3: BAR 15: assigned [mem 0x47e80400000-0x47e805fffff 64bit pref]
> [   18.320484] pci 0000:40:03.4: BAR 15: assigned [mem 0x47e80600000-0x47e807fffff 64bit pref]
> [   18.337145] pci 0000:40:03.1: BAR 13: assigned [io  0x4000-0x4fff]
> [   18.349468] pci 0000:40:03.2: BAR 13: assigned [io  0x5000-0x5fff]
> [   18.361808] pci 0000:40:03.3: BAR 13: assigned [io  0x6000-0x6fff]
> [   18.374131] pci 0000:40:03.4: BAR 13: no space for [io  size 0x1000]
> [   18.386807] pci 0000:40:03.4: BAR 13: failed to assign [io  size 0x1000]
> [   18.400170] pci 0000:41:00.0: BAR 6: assigned [mem 0x94100000-0x941fffff pref]
> [   18.414573] pci 0000:41:00.1: BAR 6: assigned [mem 0x94200000-0x942fffff pref]
> [   18.428983] pci 0000:41:00.0: BAR 7: no space for [mem size 0x01000000 64bit pref]
> [   18.444087] pci 0000:41:00.0: BAR 7: failed to assign [mem size 0x01000000 64bit pref]
> [   18.459875] pci 0000:41:00.1: BAR 7: no space for [mem size 0x01000000 64bit pref]
> [   18.474969] pci 0000:41:00.1: BAR 7: failed to assign [mem size 0x01000000 64bit pref]
> [   18.490760] pci 0000:41:00.0: BAR 10: no space for [mem size 0x00200000 64bit pref]
> [   18.506035] pci 0000:41:00.0: BAR 10: failed to assign [mem size 0x00200000 64bit pref]
> [   18.521998] pci 0000:41:00.1: BAR 10: no space for [mem size 0x00200000 64bit pref]
> [   18.537266] pci 0000:41:00.1: BAR 10: failed to assign [mem size 0x00200000 64bit pref]
> [   18.553228] pci 0000:40:01.1: PCI bridge to [bus 41]
> [   18.563125] pci 0000:40:01.1:   bridge window [mem 0x94100000-0x942fffff]
> [   18.576668] pci 0000:40:01.1:   bridge window [mem 0x90000000-0x940fffff 64bit pref]
> [   18.592112] pci 0000:40:03.1: PCI bridge to [bus 42]
> [   18.602014] pci 0000:40:03.1:   bridge window [io  0x4000-0x4fff]
> [   18.614164] pci 0000:40:03.1:   bridge window [mem 0xa4400000-0xa47fffff]
> [   18.627707] pci 0000:40:03.1:   bridge window [mem 0x47e80000000-0x47e801fffff 64bit pref]
> [   18.644190] pci 0000:40:03.2: PCI bridge to [bus 43]
> [   18.654095] pci 0000:40:03.2:   bridge window [io  0x5000-0x5fff]
> [   18.666253] pci 0000:40:03.2:   bridge window [mem 0xa4000000-0xa43fffff]
> [   18.679805] pci 0000:40:03.2:   bridge window [mem 0x47e80200000-0x47e803fffff 64bit pref]
> [   18.696288] pci 0000:44:00.0: BAR 6: assigned [mem 0xa4d20000-0xa4d3ffff pref]
> [   18.710696] pci 0000:40:03.3: PCI bridge to [bus 44]
> [   18.720592] pci 0000:40:03.3:   bridge window [io  0x6000-0x6fff]
> [   18.732743] pci 0000:40:03.3:   bridge window [mem 0xa4d00000-0xa4dfffff]
> [   18.746284] pci 0000:40:03.3:   bridge window [mem 0x47e80400000-0x47e805fffff 64bit pref]
> [   18.762768] pci 0000:45:00.0: BAR 6: assigned [mem 0xa4c20000-0xa4c3ffff pref]
> [   18.777176] pci 0000:40:03.4: PCI bridge to [bus 45]
> [   18.787073] pci 0000:40:03.4:   bridge window [mem 0xa4c00000-0xa4cfffff]
> [   18.800610] pci 0000:40:03.4:   bridge window [mem 0x47e80600000-0x47e807fffff 64bit pref]
> [   18.817102] pci 0000:40:07.1: PCI bridge to [bus 46]
> [   18.827006] pci 0000:40:07.1:   bridge window [mem 0xa4b00000-0xa4bfffff]
> [   18.840553] pci 0000:40:08.1: PCI bridge to [bus 47]
> [   18.850453] pci 0000:40:08.1:   bridge window [mem 0xa4800000-0xa4afffff]
> [   18.863990] pci_bus 0000:40: No. 2 try to assign unassigned res
> [   18.875797] release child resource [mem 0x90000000-0x91ffffff 64bit pref]
> [   18.875798] release child resource [mem 0x92000000-0x93ffffff 64bit pref]
> [   18.875799] release child resource [mem 0x94000000-0x9400ffff 64bit pref]
> [   18.875799] release child resource [mem 0x94010000-0x9401ffff 64bit pref]
> [   18.875800] pci 0000:40:01.1: resource 15 [mem 0x90000000-0x940fffff 64bit pref] released
> [   18.892132] pci 0000:40:01.1: PCI bridge to [bus 41]
> [   18.902032] pci 0000:40:01.1: bridge window [mem 0x01000000-0x05ffffff 64bit pref] to [bus 41] add_size 2000000 add_align 1000000
> [   18.925280] pci 0000:40:01.1: BAR 15: assigned [mem 0x47e81000000-0x47e87ffffff 64bit pref]
> [   18.941943] pci 0000:40:03.4: BAR 13: no space for [io  size 0x1000]
> [   18.954612] pci 0000:40:03.4: BAR 13: failed to assign [io  size 0x1000]
> [   18.967974] pci 0000:40:03.4: BAR 13: no space for [io  size 0x1000]
> [   18.980640] pci 0000:40:03.4: BAR 13: failed to assign [io  size 0x1000]
> [   18.994006] pci 0000:41:00.0: BAR 0: assigned [mem 0x47e82000000-0x47e83ffffff 64bit pref]
> [   19.010499] pci 0000:41:00.1: BAR 0: assigned [mem 0x47e84000000-0x47e85ffffff 64bit pref]
> [   19.026990] pci 0000:41:00.0: BAR 7: assigned [mem 0x47e81000000-0x47e81ffffff 64bit pref]
> [   19.043479] pci 0000:41:00.1: BAR 7: assigned [mem 0x47e86000000-0x47e86ffffff 64bit pref]
> [   19.059969] pci 0000:41:00.0: BAR 3: assigned [mem 0x47e87000000-0x47e8700ffff 64bit pref]
> [   19.076463] pci 0000:41:00.1: BAR 3: assigned [mem 0x47e87010000-0x47e8701ffff 64bit pref]
> [   19.092953] pci 0000:41:00.0: BAR 10: assigned [mem 0x47e87020000-0x47e8721ffff 64bit pref]
> [   19.109612] pci 0000:41:00.1: BAR 10: assigned [mem 0x47e87220000-0x47e8741ffff 64bit pref]
> [   19.126275] pci 0000:40:01.1: PCI bridge to [bus 41]
> [   19.136172] pci 0000:40:01.1:   bridge window [mem 0x94100000-0x942fffff]
> [   19.149714] pci 0000:40:01.1:   bridge window [mem 0x47e81000000-0x47e87ffffff 64bit pref]
> [   19.166199] pci 0000:40:03.1: PCI bridge to [bus 42]
> [   19.176100] pci 0000:40:03.1:   bridge window [io  0x4000-0x4fff]
> [   19.188252] pci 0000:40:03.1:   bridge window [mem 0xa4400000-0xa47fffff]
> [   19.201812] pci 0000:40:03.1:   bridge window [mem 0x47e80000000-0x47e801fffff 64bit pref]
> [   19.218304] pci 0000:40:03.2: PCI bridge to [bus 43]
> [   19.228206] pci 0000:40:03.2:   bridge window [io  0x5000-0x5fff]
> [   19.240355] pci 0000:40:03.2:   bridge window [mem 0xa4000000-0xa43fffff]
> [   19.253889] pci 0000:40:03.2:   bridge window [mem 0x47e80200000-0x47e803fffff 64bit pref]
> [   19.270374] pci 0000:40:03.3: PCI bridge to [bus 44]
> [   19.280275] pci 0000:40:03.3:   bridge window [io  0x6000-0x6fff]
> [   19.292427] pci 0000:40:03.3:   bridge window [mem 0xa4d00000-0xa4dfffff]
> [   19.305970] pci 0000:40:03.3:   bridge window [mem 0x47e80400000-0x47e805fffff 64bit pref]
> [   19.322453] pci 0000:40:03.4: PCI bridge to [bus 45]
> [   19.332357] pci 0000:40:03.4:   bridge window [mem 0xa4c00000-0xa4cfffff]
> [   19.345900] pci 0000:40:03.4:   bridge window [mem 0x47e80600000-0x47e807fffff 64bit pref]
> [   19.362385] pci 0000:40:07.1: PCI bridge to [bus 46]
> [   19.372286] pci 0000:40:07.1:   bridge window [mem 0xa4b00000-0xa4bfffff]
> [   19.385824] pci 0000:40:08.1: PCI bridge to [bus 47]
> [   19.395727] pci 0000:40:08.1:   bridge window [mem 0xa4800000-0xa4afffff]
> [   19.409300] pci_bus 0000:40: Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off
> [   19.430464] pci_bus 0000:40: resource 4 [io  0x4000-0x6fff window]
> [   19.442788] pci_bus 0000:40: resource 5 [mem 0x90000000-0xaaffffff window]
> [   19.456497] pci_bus 0000:40: resource 6 [mem 0x47e80000000-0x63dbfffffff window]
> [   19.471245] pci_bus 0000:41: resource 1 [mem 0x94100000-0x942fffff]
> [   19.483740] pci_bus 0000:41: resource 2 [mem 0x47e81000000-0x47e87ffffff 64bit pref]
> [   19.499184] pci_bus 0000:42: resource 0 [io  0x4000-0x4fff]
> [   19.510362] pci_bus 0000:42: resource 1 [mem 0xa4400000-0xa47fffff]
> [   19.522856] pci_bus 0000:42: resource 2 [mem 0x47e80000000-0x47e801fffff 64bit pref]
> [   19.538297] pci_bus 0000:43: resource 0 [io  0x5000-0x5fff]
> [   19.549406] pci_bus 0000:43: resource 1 [mem 0xa4000000-0xa43fffff]
> [   19.561902] pci_bus 0000:43: resource 2 [mem 0x47e80200000-0x47e803fffff 64bit pref]
> [   19.577346] pci_bus 0000:44: resource 0 [io  0x6000-0x6fff]
> [   19.588454] pci_bus 0000:44: resource 1 [mem 0xa4d00000-0xa4dfffff]
> [   19.600948] pci_bus 0000:44: resource 2 [mem 0x47e80400000-0x47e805fffff 64bit pref]
> [   19.616391] pci_bus 0000:45: resource 1 [mem 0xa4c00000-0xa4cfffff]
> [   19.628887] pci_bus 0000:45: resource 2 [mem 0x47e80600000-0x47e807fffff 64bit pref]
> [   19.644329] pci_bus 0000:46: resource 1 [mem 0xa4b00000-0xa4bfffff]
> [   19.656824] pci_bus 0000:47: resource 1 [mem 0xa4800000-0xa4afffff]
> [   19.669352] pci 0000:80:01.1: bridge window [io  0x1000-0x0fff] to [bus 81] add_size 1000
> [   19.685663] pci 0000:80:01.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 81] add_size 200000 add_align 100000
> [   19.708559] pci 0000:80:01.2: bridge window [io  0x1000-0x0fff] to [bus 82] add_size 1000
> [   19.724873] pci 0000:80:01.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 82] add_size 200000 add_align 100000
> [   19.747773] pci 0000:80:01.1: BAR 15: assigned [mem 0x2bf40000000-0x2bf401fffff 64bit pref]
> [   19.764433] pci 0000:80:01.2: BAR 15: assigned [mem 0x2bf40200000-0x2bf403fffff 64bit pref]
> [   19.781086] pci 0000:80:01.1: BAR 13: assigned [io  0x7000-0x7fff]
> [   19.793410] pci 0000:80:01.2: BAR 13: assigned [io  0x8000-0x8fff]
> [   19.805731] pci 0000:80:01.1: PCI bridge to [bus 81]
> [   19.815631] pci 0000:80:01.1:   bridge window [io  0x7000-0x7fff]
> [   19.827787] pci 0000:80:01.1:   bridge window [mem 0xbf400000-0xbf7fffff]
> [   19.841330] pci 0000:80:01.1:   bridge window [mem 0x2bf40000000-0x2bf401fffff 64bit pref]
> [   19.857817] pci 0000:80:01.2: PCI bridge to [bus 82]
> [   19.867716] pci 0000:80:01.2:   bridge window [io  0x8000-0x8fff]
> [   19.879865] pci 0000:80:01.2:   bridge window [mem 0xbf000000-0xbf3fffff]
> [   19.893402] pci 0000:80:01.2:   bridge window [mem 0x2bf40200000-0x2bf403fffff 64bit pref]
> [   19.909894] pci 0000:80:07.1: PCI bridge to [bus 83]
> [   19.919796] pci 0000:80:07.1:   bridge window [mem 0xbf900000-0xbf9fffff]
> [   19.933370] pci 0000:80:08.1: PCI bridge to [bus 84]
> [   19.943271] pci 0000:80:08.1:   bridge window [mem 0xbf800000-0xbf8fffff]
> [   19.956817] pci_bus 0000:80: resource 4 [io  0x7000-0x9fff window]
> [   19.969147] pci_bus 0000:80: resource 5 [mem 0xab000000-0xc5ffffff window]
> [   19.982864] pci_bus 0000:80: resource 6 [mem 0x2bf40000000-0x47e7fffffff window]
> [   19.997622] pci_bus 0000:81: resource 0 [io  0x7000-0x7fff]
> [   20.008739] pci_bus 0000:81: resource 1 [mem 0xbf400000-0xbf7fffff]
> [   20.021243] pci_bus 0000:81: resource 2 [mem 0x2bf40000000-0x2bf401fffff 64bit pref]
> [   20.036713] pci_bus 0000:82: resource 0 [io  0x8000-0x8fff]
> [   20.047827] pci_bus 0000:82: resource 1 [mem 0xbf000000-0xbf3fffff]
> [   20.060323] pci_bus 0000:82: resource 2 [mem 0x2bf40200000-0x2bf403fffff 64bit pref]
> [   20.075768] pci_bus 0000:83: resource 1 [mem 0xbf900000-0xbf9fffff]
> [   20.088271] pci_bus 0000:84: resource 1 [mem 0xbf800000-0xbf8fffff]
> [   20.100863] pci 0000:c0:03.1: bridge window [io  0x1000-0x0fff] to [bus c4] add_size 1000
> [   20.117192] pci 0000:c0:03.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c4] add_size 200000 add_align 100000
> [   20.140091] pci 0000:c0:03.2: bridge window [io  0x1000-0x0fff] to [bus c5] add_size 1000
> [   20.156408] pci 0000:c0:03.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c5] add_size 200000 add_align 100000
> [   20.179308] pci 0000:c0:03.3: bridge window [io  0x1000-0x0fff] to [bus c6] add_size 1000
> [   20.195618] pci 0000:c0:03.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c6] add_size 200000 add_align 100000
> [   20.218529] pci 0000:c0:03.4: bridge window [io  0x1000-0x0fff] to [bus c7] add_size 1000
> [   20.234838] pci 0000:c0:03.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c7] add_size 200000 add_align 100000
> [   20.257756] pci 0000:c0:03.1: BAR 15: assigned [mem 0x10000000000-0x100001fffff 64bit pref]
> [   20.274413] pci 0000:c0:03.2: BAR 15: assigned [mem 0x10000200000-0x100003fffff 64bit pref]
> [   20.291083] pci 0000:c0:03.3: BAR 15: assigned [mem 0x10000400000-0x100005fffff 64bit pref]
> [   20.307740] pci 0000:c0:03.4: BAR 15: assigned [mem 0x10000600000-0x100007fffff 64bit pref]
> [   20.324405] pci 0000:c0:03.1: BAR 13: assigned [io  0xb000-0xbfff]
> [   20.336732] pci 0000:c0:03.2: BAR 13: assigned [io  0xc000-0xcfff]
> [   20.349067] pci 0000:c0:03.3: BAR 13: assigned [io  0xd000-0xdfff]
> [   20.361401] pci 0000:c0:03.4: BAR 13: assigned [io  0xe000-0xefff]
> [   20.373727] pci 0000:c3:00.0: BAR 6: assigned [mem 0xdbc40000-0xdbc7ffff pref]
> [   20.388139] pci 0000:c0:01.1: PCI bridge to [bus c3]
> [   20.398045] pci 0000:c0:01.1:   bridge window [io  0xa000-0xafff]
> [   20.410203] pci 0000:c0:01.1:   bridge window [mem 0xdbc00000-0xdbcfffff]
> [   20.423748] pci 0000:c0:03.1: PCI bridge to [bus c4]
> [   20.433649] pci 0000:c0:03.1:   bridge window [io  0xb000-0xbfff]
> [   20.445799] pci 0000:c0:03.1:   bridge window [mem 0xdb600000-0xdb9fffff]
> [   20.459342] pci 0000:c0:03.1:   bridge window [mem 0x10000000000-0x100001fffff 64bit pref]
> [   20.475835] pci 0000:c0:03.2: PCI bridge to [bus c5]
> [   20.485736] pci 0000:c0:03.2:   bridge window [io  0xc000-0xcfff]
> [   20.497885] pci 0000:c0:03.2:   bridge window [mem 0xdb200000-0xdb5fffff]
> [   20.511423] pci 0000:c0:03.2:   bridge window [mem 0x10000200000-0x100003fffff 64bit pref]
> [   20.527912] pci 0000:c0:03.3: PCI bridge to [bus c6]
> [   20.537817] pci 0000:c0:03.3:   bridge window [io  0xd000-0xdfff]
> [   20.549975] pci 0000:c0:03.3:   bridge window [mem 0xdae00000-0xdb1fffff]
> [   20.563542] pci 0000:c0:03.3:   bridge window [mem 0x10000400000-0x100005fffff 64bit pref]
> [   20.580027] pci 0000:c0:03.4: PCI bridge to [bus c7]
> [   20.589931] pci 0000:c0:03.4:   bridge window [io  0xe000-0xefff]
> [   20.602090] pci 0000:c0:03.4:   bridge window [mem 0xdaa00000-0xdadfffff]
> [   20.615630] pci 0000:c0:03.4:   bridge window [mem 0x10000600000-0x100007fffff 64bit pref]
> [   20.632117] pci 0000:c1:00.0: PCI bridge to [bus c2]
> [   20.642019] pci 0000:c1:00.0:   bridge window [mem 0xda000000-0xda8fffff]
> [   20.655564] pci 0000:c1:00.0:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
> [   20.671018] pci 0000:c0:05.2: PCI bridge to [bus c1-c2]
> [   20.681437] pci 0000:c0:05.2:   bridge window [mem 0xda000000-0xda8fffff]
> [   20.694972] pci 0000:c0:05.2:   bridge window [mem 0xc6000000-0xc6ffffff 64bit pref]
> [   20.710417] pci 0000:c0:07.1: PCI bridge to [bus c8]
> [   20.720320] pci 0000:c0:07.1:   bridge window [mem 0xdbb00000-0xdbbfffff]
> [   20.733867] pci 0000:c0:08.1: PCI bridge to [bus c9]
> [   20.743766] pci 0000:c0:08.1:   bridge window [mem 0xdba00000-0xdbafffff]
> [   20.757307] pci_bus 0000:c0: resource 4 [io  0xa000-0xffff window]
> [   20.769668] pci_bus 0000:c0: resource 5 [mem 0xc6000000-0xe0ffffff window]
> [   20.783375] pci_bus 0000:c0: resource 6 [mem 0x10000000000-0x2bf3fffffff window]
> [   20.798126] pci_bus 0000:c0: resource 7 [io  0x03b0-0x03df window]
> [   20.810448] pci_bus 0000:c0: resource 8 [mem 0x000a0000-0x000bffff window]
> [   20.824157] pci_bus 0000:c3: resource 0 [io  0xa000-0xafff]
> [   20.835264] pci_bus 0000:c3: resource 1 [mem 0xdbc00000-0xdbcfffff]
> [   20.847759] pci_bus 0000:c4: resource 0 [io  0xb000-0xbfff]
> [   20.858870] pci_bus 0000:c4: resource 1 [mem 0xdb600000-0xdb9fffff]
> [   20.871400] pci_bus 0000:c4: resource 2 [mem 0x10000000000-0x100001fffff 64bit pref]
> [   20.886843] pci_bus 0000:c5: resource 0 [io  0xc000-0xcfff]
> [   20.897949] pci_bus 0000:c5: resource 1 [mem 0xdb200000-0xdb5fffff]
> [   20.910447] pci_bus 0000:c5: resource 2 [mem 0x10000200000-0x100003fffff 64bit pref]
> [   20.925889] pci_bus 0000:c6: resource 0 [io  0xd000-0xdfff]
> [   20.936996] pci_bus 0000:c6: resource 1 [mem 0xdae00000-0xdb1fffff]
> [   20.949493] pci_bus 0000:c6: resource 2 [mem 0x10000400000-0x100005fffff 64bit pref]
> [   20.964936] pci_bus 0000:c7: resource 0 [io  0xe000-0xefff]
> [   20.976045] pci_bus 0000:c7: resource 1 [mem 0xdaa00000-0xdadfffff]
> [   20.988540] pci_bus 0000:c7: resource 2 [mem 0x10000600000-0x100007fffff 64bit pref]
> [   21.003983] pci_bus 0000:c1: resource 1 [mem 0xda000000-0xda8fffff]
> [   21.016477] pci_bus 0000:c1: resource 2 [mem 0xc6000000-0xc6ffffff 64bit pref]
> [   21.030880] pci_bus 0000:c2: resource 1 [mem 0xda000000-0xda8fffff]
> [   21.043374] pci_bus 0000:c2: resource 2 [mem 0xc6000000-0xc6ffffff 64bit pref]
> [   21.057776] pci_bus 0000:c8: resource 1 [mem 0xdbb00000-0xdbbfffff]
> [   21.070272] pci_bus 0000:c9: resource 1 [mem 0xdba00000-0xdbafffff]
> [   21.083246] PCI: CLS 0 bytes, default 64
> [   21.091119] pci 0000:c0:00.2: AMD-Vi: IOMMU performance counters supported
> [   21.091192] Unpacking initramfs...
> [   21.111617] pci 0000:80:00.2: AMD-Vi: IOMMU performance counters supported
> [   21.111634] pci 0000:40:00.2: AMD-Vi: IOMMU performance counters supported
> [   21.139065] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [   21.152805] pci 0000:00:01.0: Adding to iommu group 0
> [   21.162895] pci 0000:00:02.0: Adding to iommu group 1
> [   21.172979] pci 0000:00:03.0: Adding to iommu group 2
> [   21.183072] pci 0000:00:04.0: Adding to iommu group 3
> [   21.184419] Freeing initrd memory: 22616K
> [   21.193169] pci 0000:00:05.0: Adding to iommu group 4
> [   21.211244] pci 0000:00:07.0: Adding to iommu group 5
> [   21.221330] pci 0000:00:07.1: Adding to iommu group 6
> [   21.231424] pci 0000:00:08.0: Adding to iommu group 7
> [   21.241504] pci 0000:00:08.1: Adding to iommu group 8
> [   21.251599] pci 0000:00:14.0: Adding to iommu group 9
> [   21.261682] pci 0000:00:14.3: Adding to iommu group 9
> [   21.271800] pci 0000:00:18.0: Adding to iommu group 10
> [   21.282058] pci 0000:00:18.1: Adding to iommu group 10
> [   21.292325] pci 0000:00:18.2: Adding to iommu group 10
> [   21.302574] pci 0000:00:18.3: Adding to iommu group 10
> [   21.312828] pci 0000:00:18.4: Adding to iommu group 10
> [   21.323078] pci 0000:00:18.5: Adding to iommu group 10
> [   21.333330] pci 0000:00:18.6: Adding to iommu group 10
> [   21.343581] pci 0000:00:18.7: Adding to iommu group 10
> [   21.353835] pci 0000:01:00.0: Adding to iommu group 11
> [   21.364095] pci 0000:01:00.2: Adding to iommu group 12
> [   21.374355] pci 0000:02:00.0: Adding to iommu group 13
> [   21.384613] pci 0000:02:00.2: Adding to iommu group 14
> [   21.394899] pci 0000:02:00.3: Adding to iommu group 15
> [   21.405164] pci 0000:40:01.0: Adding to iommu group 16
> [   21.415417] pci 0000:40:01.1: Adding to iommu group 17
> [   21.425674] pci 0000:40:02.0: Adding to iommu group 18
> [   21.435948] pci 0000:40:03.0: Adding to iommu group 19
> [   21.446208] pci 0000:40:03.1: Adding to iommu group 19
> [   21.456466] pci 0000:40:03.2: Adding to iommu group 19
> [   21.466718] pci 0000:40:03.3: Adding to iommu group 20
> [   21.476967] pci 0000:40:03.4: Adding to iommu group 21
> [   21.487222] pci 0000:40:04.0: Adding to iommu group 22
> [   21.497485] pci 0000:40:05.0: Adding to iommu group 23
> [   21.507744] pci 0000:40:07.0: Adding to iommu group 24
> [   21.517998] pci 0000:40:07.1: Adding to iommu group 25
> [   21.528256] pci 0000:40:08.0: Adding to iommu group 26
> [   21.538512] pci 0000:40:08.1: Adding to iommu group 27
> [   21.548774] pci 0000:41:00.0: Adding to iommu group 28
> [   21.559032] pci 0000:41:00.1: Adding to iommu group 29
> [   21.569291] pci 0000:44:00.0: Adding to iommu group 30
> [   21.579541] pci 0000:45:00.0: Adding to iommu group 31
> [   21.589793] pci 0000:46:00.0: Adding to iommu group 32
> [   21.600043] pci 0000:46:00.2: Adding to iommu group 33
> [   21.610295] pci 0000:47:00.0: Adding to iommu group 34
> [   21.620546] pci 0000:47:00.1: Adding to iommu group 35
> [   21.630799] pci 0000:47:00.2: Adding to iommu group 36
> [   21.641056] pci 0000:47:00.3: Adding to iommu group 37
> [   21.651324] pci 0000:80:01.0: Adding to iommu group 38
> [   21.661581] pci 0000:80:01.1: Adding to iommu group 38
> [   21.671839] pci 0000:80:01.2: Adding to iommu group 38
> [   21.682102] pci 0000:80:02.0: Adding to iommu group 39
> [   21.692361] pci 0000:80:03.0: Adding to iommu group 40
> [   21.702646] pci 0000:80:04.0: Adding to iommu group 41
> [   21.712908] pci 0000:80:05.0: Adding to iommu group 42
> [   21.723169] pci 0000:80:07.0: Adding to iommu group 43
> [   21.733423] pci 0000:80:07.1: Adding to iommu group 44
> [   21.743680] pci 0000:80:08.0: Adding to iommu group 45
> [   21.753933] pci 0000:80:08.1: Adding to iommu group 46
> [   21.764185] pci 0000:83:00.0: Adding to iommu group 47
> [   21.774437] pci 0000:83:00.2: Adding to iommu group 48
> [   21.784696] pci 0000:84:00.0: Adding to iommu group 49
> [   21.794947] pci 0000:84:00.2: Adding to iommu group 50
> [   21.805218] pci 0000:c0:01.0: Adding to iommu group 51
> [   21.815533] pci 0000:c0:01.1: Adding to iommu group 52
> [   21.825796] pci 0000:c0:02.0: Adding to iommu group 53
> [   21.836076] pci 0000:c0:03.0: Adding to iommu group 54
> [   21.846336] pci 0000:c0:03.1: Adding to iommu group 54
> [   21.856598] pci 0000:c0:03.2: Adding to iommu group 54
> [   21.866858] pci 0000:c0:03.3: Adding to iommu group 54
> [   21.877115] pci 0000:c0:03.4: Adding to iommu group 54
> [   21.887375] pci 0000:c0:04.0: Adding to iommu group 55
> [   21.897641] pci 0000:c0:05.0: Adding to iommu group 56
> [   21.907896] pci 0000:c0:05.2: Adding to iommu group 56
> [   21.918158] pci 0000:c0:07.0: Adding to iommu group 57
> [   21.928411] pci 0000:c0:07.1: Adding to iommu group 58
> [   21.938668] pci 0000:c0:08.0: Adding to iommu group 59
> [   21.948923] pci 0000:c0:08.1: Adding to iommu group 60
> [   21.959169] pci 0000:c1:00.0: Adding to iommu group 56
> [   21.969420] pci 0000:c2:00.0: Adding to iommu group 56
> [   21.979678] pci 0000:c3:00.0: Adding to iommu group 61
> [   21.989939] pci 0000:c8:00.0: Adding to iommu group 62
> [   22.000199] pci 0000:c8:00.2: Adding to iommu group 63
> [   22.010458] pci 0000:c9:00.0: Adding to iommu group 64
> [   22.020719] pci 0000:c9:00.2: Adding to iommu group 65
> [   22.045882] pci 0000:c0:00.2: AMD-Vi: Found IOMMU cap 0x40
> [   22.056828] AMD-Vi: Extended features (0x841f77e022094ace): PPR X2APIC NX IA GA PC
> [   22.071930] pci 0000:80:00.2: AMD-Vi: Found IOMMU cap 0x40
> [   22.082874] AMD-Vi: Extended features (0x841f77e022094ace): PPR X2APIC NX IA GA PC
> [   22.097979] pci 0000:40:00.2: AMD-Vi: Found IOMMU cap 0x40
> [   22.108938] AMD-Vi: Extended features (0x841f77e022094ace): PPR X2APIC NX IA GA PC
> [   22.124033] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [   22.134972] AMD-Vi: Extended features (0x841f77e022094ace): PPR X2APIC NX IA GA PC
> [   22.150074] AMD-Vi: Interrupt remapping enabled
> [   22.159103] AMD-Vi: X2APIC enabled
> [   22.166155] software IO TLB: tearing down default memory pool
> [   22.178367] LVT offset 0 assigned for vector 0x400
> [   22.188731] perf: AMD IBS detected (0x000003ff)
> [   22.197772] amd_uncore: 4  amd_df counters detected
> [   22.207511] amd_uncore: 6  amd_l3 counters detected
> [   22.218436] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
> [   22.232672] perf/amd_iommu: Detected AMD IOMMU #1 (2 banks, 4 counters/bank).
> [   22.246909] perf/amd_iommu: Detected AMD IOMMU #2 (2 banks, 4 counters/bank).
> [   22.261145] perf/amd_iommu: Detected AMD IOMMU #3 (2 banks, 4 counters/bank).
> [   22.276079] Initialise system trusted keyrings
> [   22.284954] Key type blacklist registered
> [   22.292996] workingset: timestamp_bits=36 max_order=26 bucket_order=0
> [   22.306519] zbud: loaded
> [   22.311805] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [   22.323530] fuse: init (API version 7.36)
> [   22.331652] integrity: Platform Keyring initialized
> [   22.344306] Key type asymmetric registered
> [   22.352474] Asymmetric key parser 'x509' registered
> [   22.364853] alg: self-tests for CTR-KDF (hmac(sha256)) passed
> [   22.376327] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> [   22.391132] io scheduler mq-deadline registered
> [   22.401390] pcieport 0000:00:07.1: PME: Signaling with IRQ 31
> [   22.412970] pcieport 0000:00:08.1: PME: Signaling with IRQ 32
> [   22.424563] pcieport 0000:40:01.1: PME: Signaling with IRQ 33
> [   22.436167] pcieport 0000:40:03.1: PME: Signaling with IRQ 34
> [   22.447655] pcieport 0000:40:03.1: pciehp: Slot #167 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.475104] pcieport 0000:40:03.2: PME: Signaling with IRQ 35
> [   22.486592] pcieport 0000:40:03.2: pciehp: Slot #166 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.514022] pcieport 0000:40:03.3: PME: Signaling with IRQ 36
> [   22.525540] pcieport 0000:40:03.3: pciehp: Slot #169 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.552960] pcieport 0000:40:03.4: PME: Signaling with IRQ 37
> [   22.564456] pcieport 0000:40:03.4: pciehp: Slot #168 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.591902] pcieport 0000:40:07.1: PME: Signaling with IRQ 39
> [   22.603465] pcieport 0000:40:08.1: PME: Signaling with IRQ 40
> [   22.615055] pcieport 0000:80:01.1: PME: Signaling with IRQ 41
> [   22.626548] pcieport 0000:80:01.1: pciehp: Slot #160 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.653990] pcieport 0000:80:01.2: PME: Signaling with IRQ 42
> [   22.665481] pcieport 0000:80:01.2: pciehp: Slot #161 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.692949] pcieport 0000:80:07.1: PME: Signaling with IRQ 44
> [   22.704551] pcieport 0000:80:08.1: PME: Signaling with IRQ 46
> [   22.716124] pcieport 0000:c0:01.1: PME: Signaling with IRQ 47
> [   22.727719] pcieport 0000:c0:03.1: PME: Signaling with IRQ 48
> [   22.739212] pcieport 0000:c0:03.1: pciehp: Slot #163 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.766647] pcieport 0000:c0:03.2: PME: Signaling with IRQ 49
> [   22.778133] pcieport 0000:c0:03.2: pciehp: Slot #162 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.805570] pcieport 0000:c0:03.3: PME: Signaling with IRQ 50
> [   22.817059] pcieport 0000:c0:03.3: pciehp: Slot #165 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.844495] pcieport 0000:c0:03.4: PME: Signaling with IRQ 51
> [   22.855985] pcieport 0000:c0:03.4: pciehp: Slot #164 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> [   22.883400] pcieport 0000:c0:05.2: PME: Signaling with IRQ 52
> [   22.895007] pcieport 0000:c0:07.1: PME: Signaling with IRQ 54
> [   22.906601] pcieport 0000:c0:08.1: PME: Signaling with IRQ 56
> [   22.918187] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [   22.931805] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [   22.946602] ACPI: button: Power Button [PWRF]
> [   22.956983] ERST: Error Record Serialization Table (ERST) support is initialized.
> [   22.971910] pstore: Registered erst as persistent store backend
> [   22.983868] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [   23.017101] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   23.052507] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   23.068422] Linux agpgart interface v0.103
> [   23.088751] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
> [   23.144184] loop: module loaded
> [   23.150661] tun: Universal TUN/TAP device driver, 1.6
> [   23.160762] PPP generic driver version 2.4.2
> [   23.169334] VFIO - User Level meta-driver version: 0.3
> [   23.179649] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [   23.192670] ehci-pci: EHCI PCI platform driver
> [   23.201542] ehci-platform: EHCI generic platform driver
> [   23.211982] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   23.224304] ohci-pci: OHCI PCI platform driver
> [   23.233166] ohci-platform: OHCI generic platform driver
> [   23.243599] uhci_hcd: USB Universal Host Controller Interface driver
> [   23.256293] i8042: PNP: No PS/2 controller found.
> [   23.265716] mousedev: PS/2 mouse device common for all mice
> [   23.276909] rtc_cmos 00:02: RTC can wake from S4
> [   23.286309] rtc_cmos 00:02: registered as rtc0
> [   23.295212] rtc_cmos 00:02: setting system clock to 2022-08-16T08:33:32 UTC (1660638812)
> [   23.303152] tsc: Refined TSC clocksource calibration: 2595.124 MHz
> [   23.311361] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [   23.323699] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25683d9e828, max_idle_ns: 440795202126 ns
> [   23.338958] i2c_dev: i2c /dev entries driver
> [   23.367448] clocksource: Switched to clocksource tsc
> [   23.367467] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [   23.401668] device-mapper: uevent: version 1.0.3
> [   23.410923] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
> [   23.427770] platform eisa.0: Probing EISA bus 0
> [   23.436804] platform eisa.0: EISA: Cannot allocate resource for mainboard
> [   23.450342] platform eisa.0: Cannot allocate resource for EISA slot 1
> [   23.463193] platform eisa.0: Cannot allocate resource for EISA slot 2
> [   23.476040] platform eisa.0: Cannot allocate resource for EISA slot 3
> [   23.488890] platform eisa.0: Cannot allocate resource for EISA slot 4
> [   23.501743] platform eisa.0: Cannot allocate resource for EISA slot 5
> [   23.514585] platform eisa.0: Cannot allocate resource for EISA slot 6
> [   23.527430] platform eisa.0: Cannot allocate resource for EISA slot 7
> [   23.540272] platform eisa.0: Cannot allocate resource for EISA slot 8
> [   23.553117] platform eisa.0: EISA: Detected 0 cards
> [   23.563535] ledtrig-cpu: registered to indicate activity on CPUs
> [   23.575541] efifb: probing for efifb
> [   23.582680] efifb: No BGRT, not showing boot graphics
> [   23.592756] efifb: framebuffer at 0xc6000000, using 3072k, total 3072k
> [   23.605772] efifb: mode is 1024x768x32, linelength=4096, pages=1
> [   23.617748] efifb: scrolling: redraw
> [   23.624872] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [   23.636044] Console: switching to colour frame buffer device 128x48
> [   23.664554] fb0: EFI VGA frame buffer device
> [   23.673192] EFI Variables Facility v0.08 2004-May-17
> [   23.684548] drop_monitor: Initializing network drop monitor service
> [   23.697329] NET: Registered PF_INET6 protocol family
> [   23.709978] Segment Routing with IPv6
> [   23.717391] In-situ OAM (IOAM) with IPv6
> [   23.725346] NET: Registered PF_PACKET protocol family
> [   23.735604] Key type dns_resolver registered
> [   23.746633] microcode: CPU0: patch_level=0x0a00115d
> [   23.756500] microcode: CPU1: patch_level=0x0a00115d
> [   23.766374] microcode: CPU2: patch_level=0x0a00115d
> [   23.776244] microcode: CPU3: patch_level=0x0a00115d
> [   23.786114] microcode: CPU4: patch_level=0x0a00115d
> [   23.795986] microcode: CPU5: patch_level=0x0a00115d
> [   23.805860] microcode: CPU6: patch_level=0x0a00115d
> [   23.815754] microcode: CPU7: patch_level=0x0a00115d
> [   23.825672] microcode: CPU8: patch_level=0x0a00115d
> [   23.835550] microcode: CPU9: patch_level=0x0a00115d
> [   23.845427] microcode: CPU10: patch_level=0x0a00115d
> [   23.855492] microcode: CPU11: patch_level=0x0a00115d
> [   23.865548] microcode: CPU12: patch_level=0x0a00115d
> [   23.875611] microcode: CPU13: patch_level=0x0a00115d
> [   23.885664] microcode: CPU14: patch_level=0x0a00115d
> [   23.899815] microcode: CPU15: patch_level=0x0a00115d
> [   23.914983] microcode: CPU16: patch_level=0x0a00115d
> [   23.928791] microcode: CPU17: patch_level=0x0a00115d
> [   23.942891] microcode: CPU18: patch_level=0x0a00115d
> [   23.956543] microcode: CPU19: patch_level=0x0a00115d
> [   23.970374] microcode: CPU20: patch_level=0x0a00115d
> [   23.983993] microcode: CPU21: patch_level=0x0a00115d
> [   23.997204] microcode: CPU22: patch_level=0x0a00115d
> [   24.010603] microcode: CPU23: patch_level=0x0a00115d
> [   24.024079] microcode: CPU24: patch_level=0x0a00115d
> [   24.037552] microcode: CPU25: patch_level=0x0a00115d
> [   24.050763] microcode: CPU26: patch_level=0x0a00115d
> [   24.063867] microcode: CPU27: patch_level=0x0a00115d
> [   24.077547] microcode: CPU28: patch_level=0x0a00115d
> [   24.090713] microcode: CPU29: patch_level=0x0a00115d
> [   24.104124] microcode: CPU30: patch_level=0x0a00115d
> [   24.117243] microcode: CPU31: patch_level=0x0a00115d
> [   24.130333] microcode: CPU32: patch_level=0x0a00115d
> [   24.143156] microcode: CPU33: patch_level=0x0a00115d
> [   24.155977] microcode: CPU34: patch_level=0x0a00115d
> [   24.168663] microcode: CPU35: patch_level=0x0a00115d
> [   24.181263] microcode: CPU36: patch_level=0x0a00115d
> [   24.193586] microcode: CPU37: patch_level=0x0a00115d
> [   24.205866] microcode: CPU38: patch_level=0x0a00115d
> [   24.217992] microcode: CPU39: patch_level=0x0a00115d
> [   24.230005] microcode: CPU40: patch_level=0x0a00115d
> [   24.242259] microcode: CPU41: patch_level=0x0a00115d
> [   24.254131] microcode: CPU42: patch_level=0x0a00115d
> [   24.265902] microcode: CPU43: patch_level=0x0a00115d
> [   24.277427] microcode: CPU44: patch_level=0x0a00115d
> [   24.290227] microcode: CPU45: patch_level=0x0a00115d
> [   24.301734] microcode: CPU46: patch_level=0x0a00115d
> [   24.313070] microcode: CPU47: patch_level=0x0a00115d
> [   24.324207] microcode: CPU48: patch_level=0x0a00115d
> [   24.335397] microcode: CPU49: patch_level=0x0a00115d
> [   24.346587] microcode: CPU50: patch_level=0x0a00115d
> [   24.357748] microcode: CPU51: patch_level=0x0a00115d
> [   24.368899] microcode: CPU52: patch_level=0x0a00115d
> [   24.380124] microcode: CPU53: patch_level=0x0a00115d
> [   24.391918] microcode: CPU54: patch_level=0x0a00115d
> [   24.403204] microcode: CPU55: patch_level=0x0a00115d
> [   24.414373] microcode: CPU56: patch_level=0x0a00115d
> [   24.426518] microcode: CPU57: patch_level=0x0a00115d
> [   24.439120] microcode: CPU58: patch_level=0x0a00115d
> [   24.450655] microcode: CPU59: patch_level=0x0a00115d
> [   24.462966] microcode: CPU60: patch_level=0x0a00115d
> [   24.474174] microcode: CPU61: patch_level=0x0a00115d
> [   24.485366] microcode: CPU62: patch_level=0x0a00115d
> [   24.496522] microcode: CPU63: patch_level=0x0a00115d
> [   24.507675] microcode: Microcode Update Driver: v2.2.
> [   24.508378] resctrl: L3 allocation detected
> [   24.529485] resctrl: MB allocation detected
> [   24.539184] resctrl: L3 monitoring detected
> [   24.548909] IPI shorthand broadcast: enabled
> [   24.558922] sched_clock: Marking stable (22668686593, 1890227542)->(27947117592, -3388203457)
> [   24.578747] registered taskstats version 1
> [   24.589340] Loading compiled-in X.509 certificates
> [   24.601374] Loaded X.509 cert 'Build time autogenerated kernel key: 5d9438559deceef05921a0022ca8b67dd668a04f'
> [   24.624479] zswap: loaded using pool lzo/zbud
> [   24.635705] Key type ._fscrypt registered
> [   24.646177] Key type .fscrypt registered
> [   24.656519] Key type fscrypt-provisioning registered
> [   24.669091] pstore: Using crash dump compression: deflate
> [   24.682866] Key type trusted registered
> [   24.695914] Key type encrypted registered
> [   24.706733] AppArmor: AppArmor sha1 policy hashing enabled
> [   24.720755] integrity: Loading X.509 certificate: UEFI:db
> [   24.734649] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> [   24.759672] integrity: Loading X.509 certificate: UEFI:db
> [   24.774147] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> [   24.800126] integrity: Loading X.509 certificate: UEFI:db
> [   24.814988] integrity: Loaded X.509 cert 'VMware, Inc.: 4ad8ba0472073d28127706ddc6ccb9050441bbc7'
> [   24.837279] integrity: Loading X.509 certificate: UEFI:db
> [   24.852797] integrity: Loaded X.509 cert 'VMware, Inc.: VMware Secure Boot Signing: 04597f3e1ffb240bba0ff0f05d5eb05f3e15f6d7'
> [   24.880279] Loading compiled-in module X.509 certificates
> [   24.896586] Loaded X.509 cert 'Build time autogenerated kernel key: 5d9438559deceef05921a0022ca8b67dd668a04f'
> [   24.921543] ima: Allocated hash algorithm: sha1
> [   24.967974] ima: No architecture policies found
> [   24.983458] evm: Initialising EVM extended attributes:
> [   24.999211] evm: security.selinux
> [   25.011836] evm: security.SMACK64
> [   25.023964] evm: security.SMACK64EXEC
> [   25.036756] evm: security.SMACK64TRANSMUTE
> [   25.050590] evm: security.SMACK64MMAP
> [   25.064188] evm: security.apparmor
> [   25.076632] evm: security.ima
> [   25.090353] evm: security.capability
> [   25.104697] evm: HMAC attrs: 0x1
> [   25.118782] PM:   Magic number: 2:92:574
> [   25.133786] RAS: Correctable Errors collector initialized.
> [   25.152299] Freeing unused decrypted memory: 2036K
> [   25.168732] Freeing unused kernel image (initmem) memory: 2732K
> [   25.203161] Write protecting the kernel read-only data: 24576k
> [   25.221564] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [   25.243144] Freeing unused kernel image (rodata/data gap) memory: 596K
> [   25.291505] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   25.312697] Run /init as init process
> [   25.327111]   with arguments:
> [   25.327112]     /init
> [   25.327113]   with environment:
> [   25.327113]     HOME=/
> [   25.327114]     TERM=linux
> [   25.327114]     BOOT_IMAGE=/boot/vmlinuz-5.18.0-snp-host+
> [   25.419948] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [   25.441748] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
> [   25.464377] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
> [   25.464530] xhci_hcd 0000:02:00.3: xHCI Host Controller
> [   25.504263] xhci_hcd 0000:02:00.3: new USB bus registered, assigned bus number 1
> [   25.527469] xhci_hcd 0000:02:00.3: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000000000410
> [   25.553398] cryptd: max_cpu_qlen set to 1000
> [   25.553517] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.18
> [   25.595272] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   25.617258] usb usb1: Product: xHCI Host Controller
> [   25.634001] usb usb1: Manufacturer: Linux 5.18.0-snp-host+ xhci-hcd
> [   25.653491] usb usb1: SerialNumber: 0000:02:00.3
> [   25.670011] hub 1-0:1.0: USB hub found
> [   25.684779] hub 1-0:1.0: 2 ports detected
> [   25.701765] xhci_hcd 0000:02:00.3: xHCI Host Controller
> [   25.719327] xhci_hcd 0000:02:00.3: new USB bus registered, assigned bus number 2
> [   25.745020] xhci_hcd 0000:02:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [   25.766524] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [   25.789536] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.18
> [   25.813027] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   25.834598] usb usb2: Product: xHCI Host Controller
> [   25.850997] usb usb2: Manufacturer: Linux 5.18.0-snp-host+ xhci-hcd
> [   25.871866] usb usb2: SerialNumber: 0000:02:00.3
> [   25.887943] hub 2-0:1.0: USB hub found
> [   25.901642] hub 2-0:1.0: 2 ports detected
> [   25.901719] ice: Intel(R) Ethernet Connection E800 Series Linux Driver
> [   25.901773] ahci 0000:c3:00.0: version 3.0
> [   25.901904] ahci 0000:c3:00.0: controller can do FBS, turning on CAP_FBS
> [   25.912218] ahci 0000:c3:00.0: AHCI 0001.0200 32 slots 3 ports 6 Gbps 0x7 impl SATA mode
> [   25.912221] ahci 0000:c3:00.0: flags: 64bit ncq fbs pio 
> [   25.912747] scsi host0: ahci
> [   25.912885] scsi host1: ahci
> [   25.912989] scsi host2: ahci
> [   25.913038] ata1: SATA max UDMA/133 abar m2048@0xdbc00000 port 0xdbc00100 irq 67
> [   25.913051] ata2: SATA max UDMA/133 abar m2048@0xdbc00000 port 0xdbc00180 irq 67
> [   25.913052] ata3: SATA max UDMA/133 abar m2048@0xdbc00000 port 0xdbc00200 irq 67
> [   25.916542] xhci_hcd 0000:47:00.3: xHCI Host Controller
> [   25.936946] ice: Copyright (c) 2018, Intel Corporation.
> [   25.979147] usb 1-1: new high-speed USB device number 2 using xhci_hcd
> [   25.996032] xhci_hcd 0000:47:00.3: new USB bus registered, assigned bus number 3
> [   26.166018] usb 1-1: New USB device found, idVendor=0424, idProduct=2744, bcdDevice= 1.21
> [   26.172094] xhci_hcd 0000:47:00.3: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000000000410
> [   26.195088] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   26.220341] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.18
> [   26.225394] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   26.235678] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   26.241987] usb 1-1: Product: USB2734
> [   26.241989] usb 1-1: Manufacturer: Microchip Tech
> [   26.266527] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   26.266528] usb usb3: Product: xHCI Host Controller
> [   26.310651] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
> [   26.321318] usb usb3: Manufacturer: Linux 5.18.0-snp-host+ xhci-hcd
> [   26.339492] ata3.00: ATAPI: MARVELL VIRTUAL, 1.09, max UDMA/66
> [   26.342671] hub 1-1:1.0: USB hub found
> [   26.343021] hub 1-1:1.0: 4 ports detected
> [   26.355497] usb 2-1: New USB device found, idVendor=0424, idProduct=5744, bcdDevice= 1.21
> [   26.355500] usb 2-1: New USB device strings: Mfr=2, Product=3, SerialNumber=0
> [   26.355503] usb 2-1: Product: USB5734
> [   26.355504] usb 2-1: Manufacturer: Microchip Tech
> [   26.359386] usb usb3: SerialNumber: 0000:47:00.3
> [   26.376128] ata1.00: ATA-11: MTFDDAV240TDU,  D3DJ004, max UDMA/133
> [   26.396483] hub 3-0:1.0: USB hub found
> [   26.416405] ata3.00: configured for UDMA/66
> [   26.422590] hub 2-1:1.0: USB hub found
> [   26.422616] hub 2-1:1.0: 4 ports detected
> [   26.423164] usb: port power management may be unreliable
> [   26.436762] hub 3-0:1.0: 2 ports detected
> [   26.456418] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [   26.468653] ice 0000:41:00.0: The DDP package was successfully loaded: ICE OS Default Package version 1.3.26.0
> [   26.470397] xhci_hcd 0000:47:00.3: xHCI Host Controller
> [   26.494044] ata1.00: Features: NCQ-prio
> [   26.513974] xhci_hcd 0000:47:00.3: new USB bus registered, assigned bus number 4
> [   26.528417] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   26.545431] xhci_hcd 0000:47:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [   26.562911] ata2.00: ATA-11: MTFDDAV240TDU,  D3DJ004, max UDMA/133
> [   26.569563] ice 0000:41:00.0: PTP init successful
> [   26.583901] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [   26.595684] ice 0000:41:00.0: DCB is enabled in the hardware, max number of TCs supported on this port are 8
> [   26.595736] ice 0000:41:00.0: Configuring initial DCB values
> [   26.595738] ice 0000:41:00.0: Commit DCB Configuration to the hardware
> [   26.596768] ice 0000:41:00.0: 126.024 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x8 link)
> [   26.603010] ata2.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [   26.614626] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.18
> [   26.630020] ata1.00: configured for UDMA/133
> [   26.646923] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   26.665963] ata2.00: Features: NCQ-prio
> [   26.666081] scsi 0:0:0:0: Direct-Access     ATA      MTFDDAV240TDU    J004 PQ: 0 ANSI: 5
> [   26.666222] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   26.666344] sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
> [   26.666347] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [   26.666352] sd 0:0:0:0: [sda] Write Protect is off
> [   26.666353] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   26.666360] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   26.680201] usb usb4: Product: xHCI Host Controller
> [   26.708298] ata2.00: configured for UDMA/133
> [   26.723150] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [   26.729067] usb usb4: Manufacturer: Linux 5.18.0-snp-host+ xhci-hcd
> [   26.746474] scsi 1:0:0:0: Direct-Access     ATA      MTFDDAV240TDU    J004 PQ: 0 ANSI: 5
> [   26.761267] usb usb4: SerialNumber: 0000:47:00.3
> [   26.761363] hub 4-0:1.0: USB hub found
> [   26.782899] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [   26.783014] sd 1:0:0:0: [sdb] 468862128 512-byte logical blocks: (240 GB/224 GiB)
> [   26.783017] sd 1:0:0:0: [sdb] 4096-byte physical blocks
> [   26.783026] sd 1:0:0:0: [sdb] Write Protect is off
> [   26.783029] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [   26.783044] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   26.802420] hub 4-0:1.0: 2 ports detected
> [   26.802428] ACPI: bus type drm_connector registered
> [   26.810337] ice 0000:41:00.1: DDP package already present on device: ICE OS Default Package version 1.3.26.0
> [   26.824256] scsi 2:0:0:0: Processor         Marvell  Console          1.01 PQ: 0 ANSI: 5
> [   26.832459]  sda: sda1 sda2 sda3
> [   26.872081] usb 3-1: New USB device found, idVendor=1604, idProduct=10c0, bcdDevice= 0.00
> [   26.878790] ice 0000:41:00.1: PTP init successful
> [   26.885328] scsi 2:0:0:0: Attached scsi generic sg2 type 3
> [   26.909809] ice 0000:41:00.1: DCB is enabled in the hardware, max number of TCs supported on this port are 8
> [   26.909810] ice 0000:41:00.1: Configuring initial DCB values
> [   26.909811] ice 0000:41:00.1: Commit DCB Configuration to the hardware
> [   26.910450] ice 0000:41:00.1: 126.024 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x8 link)
> [   26.913379] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [   26.968096] hub 3-1:1.0: USB hub found
> [   27.000272] sd 0:0:0:0: [sda] Attached SCSI disk
> [   27.025086] hub 3-1:1.0: 4 ports detected
> [   27.039250] sd 1:0:0:0: [sdb] Attached SCSI disk
> [   27.108037] ice 0000:41:00.0 enp65s0f0: renamed from eth0
> [   27.544373] AVX2 version of gcm_enc/dec engaged.
> [   27.649088] nvme nvme0: pci function 0000:44:00.0
> [   27.699613] ice 0000:41:00.1 enp65s0f1: renamed from eth1
> [   27.715736] nvme nvme1: pci function 0000:45:00.0
> [   27.851149] usb 3-1.1: new high-speed USB device number 3 using xhci_hcd
> [   27.865811] AES CTR mode by8 optimization enabled
> [   28.044084] usb 3-1.1: New USB device found, idVendor=1604, idProduct=10c0, bcdDevice= 0.00
> [   28.068402] usb 3-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [   28.152106] hub 3-1.1:1.0: USB hub found
> [   28.167711] hub 3-1.1:1.0: 4 ports detected
> [   28.263151] usb 3-1.4: new high-speed USB device number 4 using xhci_hcd
> [   28.384088] usb 3-1.4: New USB device found, idVendor=1604, idProduct=10c0, bcdDevice= 0.00
> [   28.408297] usb 3-1.4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [   28.472099] hub 3-1.4:1.0: USB hub found
> [   28.487714] hub 3-1.4:1.0: 4 ports detected
> [   30.167034] nvme nvme0: Shutdown timeout set to 10 seconds
> [   30.195890] nvme nvme0: 64/0/0 default/read/poll queues
> [   30.321743] nvme nvme1: Shutdown timeout set to 10 seconds
> [   30.351284] nvme nvme1: 64/0/0 default/read/poll queues
> [   30.381544] checking generic (c6000000 300000) vs hw (c6000000 1000000)
> [   30.381547] fb0: switching to mgag200 from EFI VGA
> [   30.401908] Console: switching to colour dummy device 80x25
> [   30.413069] mgag200 0000:c2:00.0: vgaarb: deactivate vga console
> [   30.430820] [drm] Initialized mgag200 1.0.0 20110418 for 0000:c2:00.0 on minor 0
> [   30.447084] fbcon: mgag200drmfb (fb0) is primary device
> [   30.448128] mgag200 0000:c2:00.0: [drm] drm_plane_enable_fb_damage_clips() not called
> [   30.806665] Console: switching to colour frame buffer device 128x48
> [   30.862097] mgag200 0000:c2:00.0: [drm] fb0: mgag200drmfb frame buffer device
> [   31.035142] raid6: avx2x4   gen() 37639 MB/s
> [   31.111142] raid6: avx2x2   gen() 29881 MB/s
> [   31.187142] raid6: avx2x1   gen() 28533 MB/s
> [   31.195736] raid6: using algorithm avx2x4 gen() 37639 MB/s
> [   31.271143] raid6: .... xor() 5604 MB/s, rmw enabled
> [   31.281053] raid6: using avx2x2 recovery algorithm
> [   31.291311] xor: automatically using best checksumming function   avx       
> [   31.306626] async_tx: api initialized (async)
> [   31.358484] Btrfs loaded, crc32c=crc32c-intel, zoned=yes, fsverity=yes
> [   31.703415] EXT4-fs (sda3): mounted filesystem with ordered data mode. Quota mode: none.
> [   31.887403] systemd[1]: Inserted module 'autofs4'
> [   31.913133] systemd[1]: systemd 249.11-0ubuntu3.1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP -LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [   31.991213] systemd[1]: Detected architecture x86-64.
> [   32.051381] systemd[1]: Hostname set to <amd-sev-reserved>.
> [   32.228822] systemd[1]: Configuration file /lib/systemd/system/kubelet.service is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
> [   32.267601] systemd[1]: Configuration file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
> [   32.344736] systemd[1]: Queued start job for default target Graphical Interface.
> [   32.387208] systemd[1]: Created slice Slice /system/modprobe.
> [   32.419919] systemd[1]: Created slice Slice /system/serial-getty.
> [   32.447700] systemd[1]: Created slice Slice /system/systemd-fsck.
> [   32.475645] systemd[1]: Created slice Slice /system/wg-quick.
> [   32.503590] systemd[1]: Created slice User and Session Slice.
> [   32.531229] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [   32.563215] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
> [   32.586921] systemd[1]: Reached target Slice Units.
> [   32.611181] systemd[1]: Reached target Swaps.
> [   32.635189] systemd[1]: Reached target Local Verity Protected Volumes.
> [   32.667271] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [   32.699230] systemd[1]: Listening on LVM2 poll daemon socket.
> [   32.727385] systemd[1]: Listening on multipathd control socket.
> [   32.755289] systemd[1]: Listening on Syslog Socket.
> [   32.779255] systemd[1]: Listening on fsck to fsckd communication Socket.
> [   32.811216] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [   32.843271] systemd[1]: Listening on Journal Audit Socket.
> [   32.871228] systemd[1]: Listening on Journal Socket (/dev/log).
> [   32.899253] systemd[1]: Listening on Journal Socket.
> [   32.923268] systemd[1]: Listening on Network Service Netlink Socket.
> [   32.951410] systemd[1]: Listening on udev Control Socket.
> [   32.979266] systemd[1]: Listening on udev Kernel Socket.
> [   33.008207] systemd[1]: Mounting Huge Pages File System...
> [   33.036090] systemd[1]: Mounting POSIX Message Queue File System...
> [   33.064044] systemd[1]: Mounting Kernel Debug File System...
> [   33.092037] systemd[1]: Mounting Kernel Trace File System...
> [   33.120677] systemd[1]: Starting Journal Service...
> [   33.144205] systemd[1]: Starting Set the console keyboard layout...
> [   33.172188] systemd[1]: Starting Create List of Static Device Nodes...
> [   33.203991] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [   33.243207] systemd[1]: Condition check resulted in LXD - agent being skipped.
> [   33.260079] systemd[1]: Starting Load Kernel Module configfs...
> [   33.288295] systemd[1]: Starting Load Kernel Module drm...
> [   33.315960] systemd[1]: Starting Load Kernel Module fuse...
> [   33.343204] systemd[1]: Condition check resulted in OpenVSwitch configuration for cleanup being skipped.
> [   33.362604] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
> [   33.384605] systemd[1]: Starting Load Kernel Modules...
> [   33.401798] IPMI message handler: version 39.2
> [   33.412268] ipmi device interface
> [   33.427339] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> [   33.448113] systemd[1]: Starting Remount Root and Kernel File Systems...
> [   33.452758] EXT4-fs (sda3): re-mounted. Quota mode: none.
> [   33.480449] Bridge firewalling registered
> [   33.504422] systemd[1]: Starting Coldplug All udev Devices...
> [   33.532899] systemd[1]: Started Journal Service.
> [   33.823190] alua: device handler registered
> [   33.834463] emc: device handler registered
> [   33.845002] rdac: device handler registered
> [   33.847245] systemd-journald[1090]: Received client request to flush runtime journal.
> [   33.876719] systemd-journald[1090]: File /var/log/journal/c557bb326e784911aa966bce581b0934/system.journal corrupted or uncleanly shut down, renaming and replacing.
> [   34.195830] loop0: detected capacity change from 0 to 113736
> [   34.218664] loop1: detected capacity change from 0 to 113792
> [   34.234135] loop2: detected capacity change from 0 to 126896
> [   34.250167] loop3: detected capacity change from 0 to 126896
> [   34.266417] loop4: detected capacity change from 0 to 163736
> [   34.288597] loop5: detected capacity change from 0 to 96160
> [   34.305982] loop6: detected capacity change from 0 to 96176
> [   34.323176] loop7: detected capacity change from 0 to 5632
> [   34.430997] ACPI Error: No handler for Region [SYSI] (00000000284fb266) [IPMI] (20211217/evregion-130)
> [   34.450499] ACPI Error: Region IPMI (ID=7) has no handler (20211217/exfldio-261)
> 
> [   34.466501] No Local Variables are initialized for Method [_GHL]
> 
> [   34.466503] No Arguments are initialized for method [_GHL]
> 
> [   34.466510] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20211217/psparse-529)
> [   34.466853] ipmi_si: IPMI System Interface driver
> [   34.467860] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
> [   34.488716] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [   34.488719] ipmi_platform: ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
> [   34.488722] ipmi_si: Adding SMBIOS-specified kcs state machine
> [   34.488780] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
> [   34.488807] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca8] regsize 1 spacing 4 irq 10
> [   34.489123] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20211217/psparse-529)
> [   34.511073] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> [   34.511133] ccp 0000:47:00.1: no command queues available
> [   34.511267] ccp 0000:47:00.1: sev enabled
> [   34.511269] ccp 0000:47:00.1: psp enabled
> [   34.511709] pstore: ignoring unexpected backend 'efi'
> [   34.513507] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.4)
> [   34.518531] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
> [   34.518534] ipmi_si: Adding ACPI-specified kcs state machine
> [   34.518728] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 10
> [   34.532320] i40e: Intel(R) Ethernet Connection XL710 Network Driver
> [   34.532322] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> [   34.544571] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
> [   34.544575] RAPL PMU: hw unit of domain package 2^-16 Joules
> [   34.564242] ccp 0000:47:00.1: SEV firmware update successful
> [   34.919154] ipmi_si IPI0001:00: The BMC does not support setting the recv irq bit, compensating, but the BMC needs to be fixed.
> [   34.945403] audit: type=1400 audit(1660638824.144:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=1501 comm="apparmor_parser"
> [   34.945663] audit: type=1400 audit(1660638824.144:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=1502 comm="apparmor_parser"
> [   34.945667] audit: type=1400 audit(1660638824.144:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=1502 comm="apparmor_parser"
> [   34.946197] audit: type=1400 audit(1660638824.144:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1504 comm="apparmor_parser"
> [   34.946202] audit: type=1400 audit(1660638824.144:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=1504 comm="apparmor_parser"
> [   34.946205] audit: type=1400 audit(1660638824.144:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=1504 comm="apparmor_parser"
> [   34.948594] audit: type=1400 audit(1660638824.148:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=1506 comm="apparmor_parser"
> [   34.948598] audit: type=1400 audit(1660638824.148:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=1506 comm="apparmor_parser"
> [   34.949918] audit: type=1400 audit(1660638824.148:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="tcpdump" pid=1505 comm="apparmor_parser"
> [   34.951789] audit: type=1400 audit(1660638824.152:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=1503 comm="apparmor_parser"
> [   34.983212] ipmi_si IPI0001:00: Using irq 10
> [   35.018505] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
> [   35.093284] ipmi_si IPI0001:00: IPMI kcs interface initialized
> [   35.094949] ipmi_ssif: IPMI SSIF Interface driver
> [   35.550494] bonding: bond0 is being created...
> [   35.765944] ice 0000:41:00.0 enp65s0f0: NIC Link is up 25 Gbps Full Duplex, Requested FEC: RS-FEC, Negotiated FEC: FC-FEC/BASE-R, Autoneg Advertised: On, Autoneg Negotiated: False, Flow Control: None
> [   35.790898] bond0: (slave enp65s0f0): Enslaving as a backup interface with an up link
> [   35.848281] bond0: (slave enp65s0f0): link status definitely up, 25000 Mbps full duplex
> [   35.848287] bond0: now running without any active interface!
> [   35.848528] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
> [   38.002026] ccp 0000:47:00.1: SEV API:1.51 build:3
> [   38.002033] ccp 0000:47:00.1: SEV-SNP API:1.51 build:3
> [   38.013311] SVM: TSC scaling supported
> [   38.013314] kvm: Nested Virtualization enabled
> [   38.013315] SVM: kvm: Nested Paging enabled
> [   38.013316] SEV supported: 410 ASIDs
> [   38.013317] SEV-ES and SEV-SNP supported: 99 ASIDs
> [   38.013354] SVM: Virtual VMLOAD VMSAVE supported
> [   38.013354] SVM: Virtual GIF supported
> [   38.013355] SVM: LBR virtualization supported
> [   38.022542] MCE: In-kernel MCE decoding enabled.
> [   38.024735] EDAC amd64: MCT channel count: 8
> [   38.024819] EDAC MC0: Giving out device to module amd64_edac controller F19h: DEV 0000:00:18.3 (INTERRUPT)
> [   38.024821] EDAC amd64: F19h detected (node 0).
> [   38.024824] EDAC MC: UMC0 chip selects:
> [   38.024824] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024826] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024828] EDAC MC: UMC1 chip selects:
> [   38.024829] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024830] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024832] EDAC MC: UMC2 chip selects:
> [   38.024832] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024833] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024835] EDAC MC: UMC3 chip selects:
> [   38.024836] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024836] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024838] EDAC MC: UMC4 chip selects:
> [   38.024839] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024840] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024842] EDAC MC: UMC5 chip selects:
> [   38.024842] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024843] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024845] EDAC MC: UMC6 chip selects:
> [   38.024845] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024846] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024848] EDAC MC: UMC7 chip selects:
> [   38.024848] EDAC amd64: MC: 0:     0MB 1:     0MB
> [   38.024849] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [   38.024849] EDAC amd64: using x16 syndromes.
> [   38.024855] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
> [   38.024857] AMD64 EDAC driver v3.5.0
> [   38.028329] intel_rapl_common: Found RAPL domain package
> [   38.028332] intel_rapl_common: Found RAPL domain core
> [   39.679610] ice 0000:41:00.1 enp65s0f1: NIC Link is up 25 Gbps Full Duplex, Requested FEC: RS-FEC, Negotiated FEC: FC-FEC/BASE-R, Autoneg Advertised: On, Autoneg Negotiated: False, Flow Control: None
> [   39.705100] bond0: (slave enp65s0f1): Enslaving as a backup interface with an up link
> [   39.942905] bond0: (slave enp65s0f1): link status definitely up, 25000 Mbps full duplex
> [   47.161508] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
> [   47.161512] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 5.18.0 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=110200
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23800
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23800
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_PAHOLE_VERSION=122
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION="-snp-host"
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_KERNEL_ZSTD=y
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> CONFIG_WATCH_QUEUE=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_USELIB=y
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_IRQ_MSI_IOMMU=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> 
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=y
> CONFIG_BPF_JIT=y
> CONFIG_BPF_JIT_ALWAYS_ON=y
> CONFIG_BPF_JIT_DEFAULT_ON=y
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> CONFIG_USERMODE_DRIVER=y
> # CONFIG_BPF_PRELOAD is not set
> CONFIG_BPF_LSM=y
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_SCHED_CORE=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> CONFIG_PSI=y
> # CONFIG_PSI_DEFAULT_DISABLED is not set
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=m
> # CONFIG_IKCONFIG_PROC is not set
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=18
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> CONFIG_UCLAMP_TASK=y
> CONFIG_UCLAMP_BUCKETS_COUNT=5
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_NUMA_BALANCING=y
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_SWAP=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_UCLAMP_TASK_GROUP=y
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_BPF=y
> CONFIG_CGROUP_MISC=y
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> CONFIG_IPC_NS=y
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> CONFIG_BOOT_CONFIG=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_EXPERT=y
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_DEBUG_RSEQ is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_GUEST_PERF_EVENTS=y
> CONFIG_PC104=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_SLAB_FREELIST_HARDENED=y
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=1024
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_HAVE_INTEL_TXT=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_DYNAMIC_PHYSICAL_MASK=y
> CONFIG_PGTABLE_LEVELS=5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_X2APIC=y
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=y
> CONFIG_CC_HAS_SLS=y
> # CONFIG_SLS is not set
> CONFIG_X86_CPU_RESCTRL=y
> CONFIG_X86_EXTENDED_PLATFORM=y
> CONFIG_X86_NUMACHIP=y
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=y
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=y
> CONFIG_X86_AMD_PLATFORM_DEVICE=y
> CONFIG_IOSF_MBI=y
> CONFIG_IOSF_MBI_DEBUG=y
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> CONFIG_PARAVIRT_XXL=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=y
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_XEN=y
> CONFIG_XEN_PV=y
> CONFIG_XEN_512GB=y
> CONFIG_XEN_PV_SMP=y
> CONFIG_XEN_PV_DOM0=y
> CONFIG_XEN_PVHVM=y
> CONFIG_XEN_PVHVM_SMP=y
> CONFIG_XEN_PVHVM_GUEST=y
> CONFIG_XEN_SAVE_RESTORE=y
> # CONFIG_XEN_DEBUG_FS is not set
> CONFIG_XEN_PVH=y
> CONFIG_XEN_DOM0=y
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> CONFIG_PVH=y
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> CONFIG_JAILHOUSE_GUEST=y
> CONFIG_ACRN_GUEST=y
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_PROCESSOR_SELECT=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> CONFIG_GART_IOMMU=y
> CONFIG_MAXSMP=y
> CONFIG_NR_CPUS_RANGE_BEGIN=8192
> CONFIG_NR_CPUS_RANGE_END=8192
> CONFIG_NR_CPUS_DEFAULT=8192
> CONFIG_NR_CPUS=8192
> CONFIG_SCHED_CLUSTER=y
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCELOG_LEGACY=y
> CONFIG_X86_MCE_INTEL=y
> CONFIG_X86_MCE_AMD=y
> CONFIG_X86_MCE_THRESHOLD=y
> # CONFIG_X86_MCE_INJECT is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=m
> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> CONFIG_PERF_EVENTS_AMD_UNCORE=y
> # end of Performance monitoring
> 
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=m
> CONFIG_X86_5LEVEL=y
> CONFIG_X86_DIRECT_GBPAGES=y
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_X86_MEM_ENCRYPT=y
> CONFIG_AMD_MEM_ENCRYPT=y
> # CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
> CONFIG_NUMA=y
> CONFIG_AMD_NUMA=y
> CONFIG_X86_64_ACPI_NUMA=y
> # CONFIG_NUMA_EMU is not set
> CONFIG_NODES_SHIFT=10
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_MEMORY_PROBE=y
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=y
> CONFIG_X86_PMEM_LEGACY=y
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> CONFIG_CC_HAS_IBT=y
> # CONFIG_X86_KERNEL_IBT is not set
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_X86_SGX=y
> CONFIG_EFI=y
> CONFIG_EFI_STUB=y
> CONFIG_EFI_MIXED=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> CONFIG_KEXEC_SIG=y
> # CONFIG_KEXEC_SIG_FORCE is not set
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_CRASH_DUMP=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_LEGACY_VSYSCALL_EMULATE is not set
> CONFIG_LEGACY_VSYSCALL_XONLY=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=y
> CONFIG_LIVEPATCH=y
> # end of Processor type and features
> 
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_HIBERNATION_SNAPSHOT_DEV=y
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> CONFIG_PM_WAKELOCKS=y
> CONFIG_PM_WAKELOCKS_LIMIT=100
> CONFIG_PM_WAKELOCKS_GC=y
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_ADVANCED_DEBUG=y
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_DPM_WATCHDOG is not set
> CONFIG_PM_TRACE=y
> CONFIG_PM_TRACE_RTC=y
> CONFIG_PM_CLK=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_ENERGY_MODEL=y
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> CONFIG_ACPI_DEBUGGER=y
> CONFIG_ACPI_DEBUGGER_USER=y
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_FPDT=y
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> # CONFIG_ACPI_VIDEO is not set
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_IPMI=m
> CONFIG_ACPI_HOTPLUG_CPU=y
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_PCI_SLOT=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> # CONFIG_ACPI_SBS is not set
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> CONFIG_ACPI_BGRT=y
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> # CONFIG_ACPI_NFIT is not set
> CONFIG_ACPI_NUMA=y
> CONFIG_ACPI_HMAT=y
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> CONFIG_ACPI_APEI_PCIEAER=y
> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> # CONFIG_ACPI_APEI_EINJ is not set
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> CONFIG_ACPI_DPTF=y
> # CONFIG_DPTF_POWER is not set
> # CONFIG_DPTF_PCH_FIVR is not set
> # CONFIG_ACPI_EXTLOG is not set
> # CONFIG_ACPI_CONFIGFS is not set
> # CONFIG_ACPI_PFRUT is not set
> CONFIG_ACPI_PCC=y
> CONFIG_PMIC_OPREGION=y
> CONFIG_BYTCRC_PMIC_OPREGION=y
> CONFIG_CHTCRC_PMIC_OPREGION=y
> CONFIG_CHT_WC_PMIC_OPREGION=y
> CONFIG_ACPI_VIOT=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_ACPI_PRMT=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> CONFIG_X86_PCC_CPUFREQ=y
> # CONFIG_X86_AMD_PSTATE is not set
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> CONFIG_X86_POWERNOW_K8=y
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> # CONFIG_X86_P4_CLOCKMOD is not set
> 
> #
> # shared options
> #
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_CPU_IDLE_GOV_TEO=y
> CONFIG_CPU_IDLE_GOV_HALTPOLL=y
> # CONFIG_HALTPOLL_CPUIDLE is not set
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_XEN=y
> CONFIG_MMCONF_FAM10H=y
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> CONFIG_ISA_BUS=y
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=y
> # CONFIG_X86_X32_ABI is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_SYSVIPC_COMPAT=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_PFNCACHE=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_DIRTY_RING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_HAVE_KVM_NO_POLL=y
> CONFIG_KVM_XFER_TO_GUEST_WORK=y
> CONFIG_HAVE_KVM_PM_NOTIFIER=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=m
> CONFIG_KVM_WERROR=y
> # CONFIG_KVM_INTEL is not set
> CONFIG_KVM_AMD=m
> CONFIG_KVM_AMD_SEV=y
> CONFIG_KVM_XEN=y
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_GENERIC_ENTRY=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=y
> CONFIG_KPROBES_ON_FTRACE=y
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_KRETPROBE_ON_RETHOOK=y
> CONFIG_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_ARCH_HAS_CC_PLATFORM=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_STATIC_CALL_INLINE=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_MODVERSIONS=y
> CONFIG_ASM_MODVERSIONS=y
> CONFIG_MODULE_SRCVERSION_ALL=y
> CONFIG_MODULE_SIG=y
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=y
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> # CONFIG_MODULE_SIG_SHA256 is not set
> # CONFIG_MODULE_SIG_SHA384 is not set
> CONFIG_MODULE_SIG_SHA512=y
> CONFIG_MODULE_SIG_HASH="sha512"
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLOCK_LEGACY_AUTOLOAD=y
> CONFIG_BLK_RQ_ALLOC_TIME=y
> CONFIG_BLK_CGROUP_RWSTAT=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=y
> CONFIG_BLK_DEV_ZONED=y
> CONFIG_BLK_DEV_THROTTLING=y
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> CONFIG_BLK_WBT=y
> CONFIG_BLK_WBT_MQ=y
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> CONFIG_BLK_CGROUP_IOCOST=y
> CONFIG_BLK_CGROUP_IOPRIO=y
> CONFIG_BLK_DEBUG_FS=y
> CONFIG_BLK_DEBUG_FS_ZONED=y
> CONFIG_BLK_SED_OPAL=y
> CONFIG_BLK_INLINE_ENCRYPTION=y
> CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> CONFIG_AIX_PARTITION=y
> CONFIG_OSF_PARTITION=y
> CONFIG_AMIGA_PARTITION=y
> CONFIG_ATARI_PARTITION=y
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
> CONFIG_SGI_PARTITION=y
> CONFIG_ULTRIX_PARTITION=y
> CONFIG_SUN_PARTITION=y
> CONFIG_KARMA_PARTITION=y
> CONFIG_EFI_PARTITION=y
> CONFIG_SYSV68_PARTITION=y
> CONFIG_CMDLINE_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_MQ_RDMA=y
> CONFIG_BLK_PM=y
> CONFIG_BLOCK_HOLDER_DEPRECATED=y
> CONFIG_BLK_MQ_STACKING=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> # CONFIG_MQ_IOSCHED_KYBER is not set
> # CONFIG_IOSCHED_BFQ is not set
> # end of IO Schedulers
> 
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> # CONFIG_BINFMT_MISC is not set
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_NUMA_KEEP_MEMINFO=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_MHP_MEMMAP_ON_MEMORY=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_DEVICE_MIGRATION=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_MEMORY_FAILURE=y
> # CONFIG_HWPOISON_INJECT is not set
> CONFIG_TRANSPARENT_HUGEPAGE=y
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_FRONTSWAP=y
> # CONFIG_CMA is not set
> CONFIG_MEM_SOFT_DIRTY=y
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> # CONFIG_Z3FOLD is not set
> CONFIG_ZSMALLOC=y
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_ARCH_HAS_PTE_DEVMAP=y
> CONFIG_ARCH_HAS_ZONE_DMA_SET=y
> CONFIG_ZONE_DMA=y
> CONFIG_ZONE_DMA32=y
> CONFIG_ZONE_DEVICE=y
> CONFIG_HMM_MIRROR=y
> CONFIG_DEVICE_PRIVATE=y
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_SECRETMEM=y
> # CONFIG_ANON_VMA_NAME is not set
> 
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> CONFIG_SKB_EXTENSIONS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> # CONFIG_UNIX_DIAG is not set
> CONFIG_TLS=m
> CONFIG_TLS_DEVICE=y
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_ALGO=m
> CONFIG_XFRM_USER=m
> # CONFIG_XFRM_USER_COMPAT is not set
> # CONFIG_XFRM_INTERFACE is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> CONFIG_XFRM_STATISTICS=y
> # CONFIG_NET_KEY is not set
> # CONFIG_SMC is not set
> CONFIG_XDP_SOCKETS=y
> # CONFIG_XDP_SOCKETS_DIAG is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_FIB_TRIE_STATS=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=m
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> # CONFIG_NET_IPVTI is not set
> CONFIG_NET_UDP_TUNNEL=m
> # CONFIG_NET_FOU is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_DIAG is not set
> CONFIG_TCP_CONG_ADVANCED=y
> # CONFIG_TCP_CONG_BIC is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_TCP_CONG_WESTWOOD=m
> # CONFIG_TCP_CONG_HTCP is not set
> # CONFIG_TCP_CONG_HSTCP is not set
> # CONFIG_TCP_CONG_HYBLA is not set
> # CONFIG_TCP_CONG_VEGAS is not set
> # CONFIG_TCP_CONG_NV is not set
> # CONFIG_TCP_CONG_SCALABLE is not set
> # CONFIG_TCP_CONG_LP is not set
> # CONFIG_TCP_CONG_VENO is not set
> # CONFIG_TCP_CONG_YEAH is not set
> # CONFIG_TCP_CONG_ILLINOIS is not set
> # CONFIG_TCP_CONG_DCTCP is not set
> # CONFIG_TCP_CONG_CDG is not set
> # CONFIG_TCP_CONG_BBR is not set
> CONFIG_DEFAULT_CUBIC=y
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG="cubic"
> CONFIG_TCP_MD5SIG=y
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_PREF=y
> CONFIG_IPV6_ROUTE_INFO=y
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_ILA is not set
> # CONFIG_IPV6_VTI is not set
> # CONFIG_IPV6_SIT is not set
> # CONFIG_IPV6_TUNNEL is not set
> CONFIG_IPV6_MULTIPLE_TABLES=y
> CONFIG_IPV6_SUBTREES=y
> CONFIG_IPV6_MROUTE=y
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IPV6_PIMSM_V2=y
> CONFIG_IPV6_SEG6_LWTUNNEL=y
> CONFIG_IPV6_SEG6_HMAC=y
> CONFIG_IPV6_SEG6_BPF=y
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=y
> CONFIG_MPTCP=y
> CONFIG_MPTCP_IPV6=y
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_BRIDGE_NETFILTER=m
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_EGRESS=y
> CONFIG_NETFILTER_SKIP_EGRESS=y
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_FAMILY_BRIDGE=y
> CONFIG_NETFILTER_FAMILY_ARP=y
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> # CONFIG_NETFILTER_NETLINK_QUEUE is not set
> # CONFIG_NETFILTER_NETLINK_LOG is not set
> # CONFIG_NETFILTER_NETLINK_OSF is not set
> CONFIG_NF_CONNTRACK=m
> # CONFIG_NF_LOG_SYSLOG is not set
> CONFIG_NF_CONNTRACK_MARK=y
> CONFIG_NF_CONNTRACK_SECMARK=y
> CONFIG_NF_CONNTRACK_ZONES=y
> # CONFIG_NF_CONNTRACK_PROCFS is not set
> CONFIG_NF_CONNTRACK_EVENTS=y
> CONFIG_NF_CONNTRACK_TIMEOUT=y
> CONFIG_NF_CONNTRACK_TIMESTAMP=y
> CONFIG_NF_CONNTRACK_LABELS=y
> CONFIG_NF_CT_PROTO_DCCP=y
> CONFIG_NF_CT_PROTO_SCTP=y
> CONFIG_NF_CT_PROTO_UDPLITE=y
> # CONFIG_NF_CONNTRACK_AMANDA is not set
> # CONFIG_NF_CONNTRACK_FTP is not set
> # CONFIG_NF_CONNTRACK_H323 is not set
> # CONFIG_NF_CONNTRACK_IRC is not set
> # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
> # CONFIG_NF_CONNTRACK_SNMP is not set
> # CONFIG_NF_CONNTRACK_PPTP is not set
> # CONFIG_NF_CONNTRACK_SANE is not set
> # CONFIG_NF_CONNTRACK_SIP is not set
> # CONFIG_NF_CONNTRACK_TFTP is not set
> CONFIG_NF_CT_NETLINK=m
> # CONFIG_NF_CT_NETLINK_TIMEOUT is not set
> CONFIG_NF_NAT=m
> CONFIG_NF_NAT_MASQUERADE=y
> CONFIG_NF_TABLES=m
> CONFIG_NF_TABLES_INET=y
> CONFIG_NF_TABLES_NETDEV=y
> # CONFIG_NFT_NUMGEN is not set
> # CONFIG_NFT_CT is not set
> # CONFIG_NFT_CONNLIMIT is not set
> # CONFIG_NFT_LOG is not set
> # CONFIG_NFT_LIMIT is not set
> # CONFIG_NFT_MASQ is not set
> # CONFIG_NFT_REDIR is not set
> CONFIG_NFT_NAT=m
> # CONFIG_NFT_TUNNEL is not set
> # CONFIG_NFT_OBJREF is not set
> # CONFIG_NFT_QUOTA is not set
> # CONFIG_NFT_REJECT is not set
> CONFIG_NFT_COMPAT=m
> # CONFIG_NFT_HASH is not set
> # CONFIG_NFT_XFRM is not set
> # CONFIG_NFT_SOCKET is not set
> # CONFIG_NFT_OSF is not set
> # CONFIG_NFT_TPROXY is not set
> # CONFIG_NFT_SYNPROXY is not set
> # CONFIG_NF_DUP_NETDEV is not set
> # CONFIG_NFT_DUP_NETDEV is not set
> # CONFIG_NFT_FWD_NETDEV is not set
> # CONFIG_NF_FLOW_TABLE is not set
> CONFIG_NETFILTER_XTABLES=m
> CONFIG_NETFILTER_XTABLES_COMPAT=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=m
> # CONFIG_NETFILTER_XT_CONNMARK is not set
> CONFIG_NETFILTER_XT_SET=m
> 
> #
> # Xtables targets
> #
> # CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
> # CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
> # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
> # CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_CONNSECMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_CT is not set
> # CONFIG_NETFILTER_XT_TARGET_DSCP is not set
> # CONFIG_NETFILTER_XT_TARGET_HL is not set
> # CONFIG_NETFILTER_XT_TARGET_HMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> # CONFIG_NETFILTER_XT_TARGET_LOG is not set
> # CONFIG_NETFILTER_XT_TARGET_MARK is not set
> CONFIG_NETFILTER_XT_NAT=m
> # CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
> # CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
> # CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
> # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
> # CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
> # CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
> # CONFIG_NETFILTER_XT_TARGET_TEE is not set
> # CONFIG_NETFILTER_XT_TARGET_TPROXY is not set
> # CONFIG_NETFILTER_XT_TARGET_TRACE is not set
> # CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
> # CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
> 
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> # CONFIG_NETFILTER_XT_MATCH_BPF is not set
> # CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
> # CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
> CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> # CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> # CONFIG_NETFILTER_XT_MATCH_CPU is not set
> # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
> # CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
> # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
> # CONFIG_NETFILTER_XT_MATCH_ECN is not set
> # CONFIG_NETFILTER_XT_MATCH_ESP is not set
> # CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_HELPER is not set
> # CONFIG_NETFILTER_XT_MATCH_HL is not set
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> # CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
> # CONFIG_NETFILTER_XT_MATCH_IPVS is not set
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
> # CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
> # CONFIG_NETFILTER_XT_MATCH_MAC is not set
> # CONFIG_NETFILTER_XT_MATCH_MARK is not set
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> # CONFIG_NETFILTER_XT_MATCH_OSF is not set
> # CONFIG_NETFILTER_XT_MATCH_OWNER is not set
> # CONFIG_NETFILTER_XT_MATCH_POLICY is not set
> # CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
> # CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
> # CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
> # CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
> # CONFIG_NETFILTER_XT_MATCH_REALM is not set
> # CONFIG_NETFILTER_XT_MATCH_RECENT is not set
> # CONFIG_NETFILTER_XT_MATCH_SCTP is not set
> # CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
> # CONFIG_NETFILTER_XT_MATCH_STATE is not set
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> # CONFIG_NETFILTER_XT_MATCH_STRING is not set
> # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
> 
> CONFIG_IP_SET=m
> CONFIG_IP_SET_MAX=256
> # CONFIG_IP_SET_BITMAP_IP is not set
> # CONFIG_IP_SET_BITMAP_IPMAC is not set
> # CONFIG_IP_SET_BITMAP_PORT is not set
> CONFIG_IP_SET_HASH_IP=m
> # CONFIG_IP_SET_HASH_IPMARK is not set
> # CONFIG_IP_SET_HASH_IPPORT is not set
> # CONFIG_IP_SET_HASH_IPPORTIP is not set
> # CONFIG_IP_SET_HASH_IPPORTNET is not set
> # CONFIG_IP_SET_HASH_IPMAC is not set
> # CONFIG_IP_SET_HASH_MAC is not set
> # CONFIG_IP_SET_HASH_NETPORTNET is not set
> CONFIG_IP_SET_HASH_NET=m
> # CONFIG_IP_SET_HASH_NETNET is not set
> # CONFIG_IP_SET_HASH_NETPORT is not set
> # CONFIG_IP_SET_HASH_NETIFACE is not set
> # CONFIG_IP_SET_LIST_SET is not set
> CONFIG_IP_VS=m
> CONFIG_IP_VS_IPV6=y
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=y
> CONFIG_IP_VS_PROTO_UDP=y
> CONFIG_IP_VS_PROTO_AH_ESP=y
> CONFIG_IP_VS_PROTO_ESP=y
> CONFIG_IP_VS_PROTO_AH=y
> CONFIG_IP_VS_PROTO_SCTP=y
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> # CONFIG_IP_VS_LC is not set
> # CONFIG_IP_VS_WLC is not set
> # CONFIG_IP_VS_FO is not set
> # CONFIG_IP_VS_OVF is not set
> # CONFIG_IP_VS_LBLC is not set
> # CONFIG_IP_VS_LBLCR is not set
> # CONFIG_IP_VS_DH is not set
> CONFIG_IP_VS_SH=m
> # CONFIG_IP_VS_MH is not set
> # CONFIG_IP_VS_SED is not set
> # CONFIG_IP_VS_NQ is not set
> # CONFIG_IP_VS_TWOS is not set
> 
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=8
> 
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=12
> 
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_NFCT=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=m
> # CONFIG_NF_SOCKET_IPV4 is not set
> # CONFIG_NF_TPROXY_IPV4 is not set
> CONFIG_NF_TABLES_IPV4=y
> # CONFIG_NFT_DUP_IPV4 is not set
> # CONFIG_NFT_FIB_IPV4 is not set
> CONFIG_NF_TABLES_ARP=y
> # CONFIG_NF_DUP_IPV4 is not set
> # CONFIG_NF_LOG_ARP is not set
> # CONFIG_NF_LOG_IPV4 is not set
> CONFIG_NF_REJECT_IPV4=m
> CONFIG_IP_NF_IPTABLES=m
> # CONFIG_IP_NF_MATCH_AH is not set
> # CONFIG_IP_NF_MATCH_ECN is not set
> CONFIG_IP_NF_MATCH_RPFILTER=m
> # CONFIG_IP_NF_MATCH_TTL is not set
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> # CONFIG_IP_NF_TARGET_SYNPROXY is not set
> # CONFIG_IP_NF_NAT is not set
> CONFIG_IP_NF_MANGLE=m
> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
> # CONFIG_IP_NF_TARGET_ECN is not set
> # CONFIG_IP_NF_TARGET_TTL is not set
> CONFIG_IP_NF_RAW=m
> # CONFIG_IP_NF_SECURITY is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV6 is not set
> # CONFIG_NF_TPROXY_IPV6 is not set
> CONFIG_NF_TABLES_IPV6=y
> # CONFIG_NFT_DUP_IPV6 is not set
> # CONFIG_NFT_FIB_IPV6 is not set
> # CONFIG_NF_DUP_IPV6 is not set
> # CONFIG_NF_REJECT_IPV6 is not set
> # CONFIG_NF_LOG_IPV6 is not set
> # CONFIG_IP6_NF_IPTABLES is not set
> # end of IPv6: Netfilter Configuration
> 
> CONFIG_NF_DEFRAG_IPV6=m
> # CONFIG_NF_TABLES_BRIDGE is not set
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> # CONFIG_BRIDGE_NF_EBTABLES is not set
> CONFIG_BPFILTER=y
> # CONFIG_BPFILTER_UMH is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> CONFIG_STP=m
> CONFIG_BRIDGE=m
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_BRIDGE_MRP=y
> CONFIG_BRIDGE_CFM=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> CONFIG_LLC=m
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> # CONFIG_NET_SCH_CBQ is not set
> # CONFIG_NET_SCH_HTB is not set
> # CONFIG_NET_SCH_HFSC is not set
> # CONFIG_NET_SCH_PRIO is not set
> # CONFIG_NET_SCH_MULTIQ is not set
> # CONFIG_NET_SCH_RED is not set
> # CONFIG_NET_SCH_SFB is not set
> # CONFIG_NET_SCH_SFQ is not set
> # CONFIG_NET_SCH_TEQL is not set
> # CONFIG_NET_SCH_TBF is not set
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> # CONFIG_NET_SCH_TAPRIO is not set
> # CONFIG_NET_SCH_GRED is not set
> # CONFIG_NET_SCH_DSMARK is not set
> # CONFIG_NET_SCH_NETEM is not set
> # CONFIG_NET_SCH_DRR is not set
> # CONFIG_NET_SCH_MQPRIO is not set
> # CONFIG_NET_SCH_SKBPRIO is not set
> # CONFIG_NET_SCH_CHOKE is not set
> # CONFIG_NET_SCH_QFQ is not set
> # CONFIG_NET_SCH_CODEL is not set
> CONFIG_NET_SCH_FQ_CODEL=m
> # CONFIG_NET_SCH_CAKE is not set
> # CONFIG_NET_SCH_FQ is not set
> # CONFIG_NET_SCH_HHF is not set
> # CONFIG_NET_SCH_PIE is not set
> # CONFIG_NET_SCH_INGRESS is not set
> # CONFIG_NET_SCH_PLUG is not set
> # CONFIG_NET_SCH_ETS is not set
> # CONFIG_NET_SCH_DEFAULT is not set
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> # CONFIG_NET_CLS_BASIC is not set
> # CONFIG_NET_CLS_TCINDEX is not set
> # CONFIG_NET_CLS_ROUTE4 is not set
> # CONFIG_NET_CLS_FW is not set
> # CONFIG_NET_CLS_U32 is not set
> # CONFIG_NET_CLS_RSVP is not set
> # CONFIG_NET_CLS_RSVP6 is not set
> # CONFIG_NET_CLS_FLOW is not set
> # CONFIG_NET_CLS_CGROUP is not set
> # CONFIG_NET_CLS_BPF is not set
> # CONFIG_NET_CLS_FLOWER is not set
> # CONFIG_NET_CLS_MATCHALL is not set
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> # CONFIG_NET_EMATCH_CMP is not set
> # CONFIG_NET_EMATCH_NBYTE is not set
> # CONFIG_NET_EMATCH_U32 is not set
> # CONFIG_NET_EMATCH_META is not set
> # CONFIG_NET_EMATCH_TEXT is not set
> # CONFIG_NET_EMATCH_IPSET is not set
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=y
> # CONFIG_NET_ACT_POLICE is not set
> # CONFIG_NET_ACT_GACT is not set
> # CONFIG_NET_ACT_MIRRED is not set
> # CONFIG_NET_ACT_SAMPLE is not set
> # CONFIG_NET_ACT_IPT is not set
> # CONFIG_NET_ACT_NAT is not set
> # CONFIG_NET_ACT_PEDIT is not set
> # CONFIG_NET_ACT_SIMP is not set
> # CONFIG_NET_ACT_SKBEDIT is not set
> # CONFIG_NET_ACT_CSUM is not set
> # CONFIG_NET_ACT_MPLS is not set
> # CONFIG_NET_ACT_VLAN is not set
> # CONFIG_NET_ACT_BPF is not set
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_CTINFO is not set
> # CONFIG_NET_ACT_SKBMOD is not set
> # CONFIG_NET_ACT_IFE is not set
> # CONFIG_NET_ACT_TUNNEL_KEY is not set
> # CONFIG_NET_ACT_GATE is not set
> CONFIG_NET_TC_SKB_EXT=y
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> CONFIG_DNS_RESOLVER=y
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> CONFIG_MPLS=y
> # CONFIG_NET_MPLS_GSO is not set
> # CONFIG_MPLS_ROUTING is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> CONFIG_NET_SWITCHDEV=y
> CONFIG_NET_L3_MASTER_DEV=y
> # CONFIG_QRTR is not set
> CONFIG_NET_NCSI=y
> CONFIG_NCSI_OEM_CMD_GET_MAC=y
> # CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
> CONFIG_PCPU_DEV_REFCNT=y
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_SOCK_RX_QUEUE_MAPPING=y
> CONFIG_XPS=y
> CONFIG_CGROUP_NET_PRIO=y
> CONFIG_CGROUP_NET_CLASSID=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_STREAM_PARSER=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NET_DROP_MONITOR=y
> # end of Network testing
> # end of Networking options
> 
> CONFIG_HAMRADIO=y
> 
> #
> # Packet Radio protocols
> #
> # CONFIG_AX25 is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=y
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> CONFIG_RFKILL=y
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> # CONFIG_RFKILL_GPIO is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=y
> CONFIG_LWTUNNEL_BPF=y
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_SOCK_VALIDATE_XMIT=y
> CONFIG_NET_SELFTESTS=y
> CONFIG_NET_SOCK_MSG=y
> CONFIG_NET_DEVLINK=y
> CONFIG_PAGE_POOL=y
> # CONFIG_PAGE_POOL_STATS is not set
> # CONFIG_FAILOVER is not set
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> CONFIG_EISA=y
> CONFIG_EISA_VLB_PRIMING=y
> CONFIG_EISA_PCI_EISA=y
> CONFIG_EISA_VIRTUAL_ROOT=y
> CONFIG_EISA_NAMES=y
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> # CONFIG_PCIEAER_INJECT is not set
> # CONFIG_PCIE_ECRC is not set
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> CONFIG_PCIE_DPC=y
> CONFIG_PCIE_PTM=y
> # CONFIG_PCIE_EDR is not set
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> # CONFIG_PCI_STUB is not set
> # CONFIG_PCI_PF_STUB is not set
> # CONFIG_XEN_PCIDEV_FRONTEND is not set
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PRI=y
> CONFIG_PCI_PASID=y
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=y
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> CONFIG_PCIE_BUS_DEFAULT=y
> # CONFIG_PCIE_BUS_SAFE is not set
> # CONFIG_PCIE_BUS_PERFORMANCE is not set
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> CONFIG_HOTPLUG_PCI_CPCI=y
> # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> # CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
> CONFIG_HOTPLUG_PCI_SHPC=y
> 
> #
> # PCI controller drivers
> #
> # CONFIG_VMD is not set
> 
> #
> # DesignWare PCI Core Support
> #
> CONFIG_PCIE_DW=y
> CONFIG_PCIE_DW_HOST=y
> CONFIG_PCIE_DW_EP=y
> CONFIG_PCIE_DW_PLAT=y
> CONFIG_PCIE_DW_PLAT_HOST=y
> CONFIG_PCIE_DW_PLAT_EP=y
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> CONFIG_PCI_ENDPOINT=y
> CONFIG_PCI_ENDPOINT_CONFIGFS=y
> # CONFIG_PCI_EPF_TEST is not set
> # CONFIG_PCI_EPF_NTB is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> CONFIG_RAPIDIO=y
> # CONFIG_RAPIDIO_TSI721 is not set
> CONFIG_RAPIDIO_DISC_TIMEOUT=30
> # CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
> CONFIG_RAPIDIO_DMA_ENGINE=y
> # CONFIG_RAPIDIO_DEBUG is not set
> # CONFIG_RAPIDIO_ENUM_BASIC is not set
> # CONFIG_RAPIDIO_CHMAN is not set
> # CONFIG_RAPIDIO_MPORT_CDEV is not set
> 
> #
> # RapidIO Switch drivers
> #
> # CONFIG_RAPIDIO_CPS_XX is not set
> # CONFIG_RAPIDIO_CPS_GEN2 is not set
> # CONFIG_RAPIDIO_RXS_GEN3 is not set
> # end of RapidIO Switch drivers
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> # CONFIG_DEVTMPFS_SAFE is not set
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_FW_LOADER_COMPRESS=y
> CONFIG_FW_CACHE=y
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_HMEM_REPORTING=y
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> CONFIG_EDD=y
> CONFIG_EDD_OFF=y
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_ISCSI_IBFT is not set
> # CONFIG_FW_CFG_SYSFS is not set
> CONFIG_SYSFB=y
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=y
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_VARS_PSTORE=m
> # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> CONFIG_EFI_RUNTIME_MAP=y
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_SOFT_RESERVE=y
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> CONFIG_APPLE_PROPERTIES=y
> CONFIG_RESET_ATTACK_MITIGATION=y
> CONFIG_EFI_RCI2_TABLE=y
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
> 
> CONFIG_UEFI_CPER=y
> CONFIG_UEFI_CPER_X86=y
> CONFIG_EFI_DEV_PATH_PARSER=y
> CONFIG_EFI_EARLYCON=y
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=y
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_XEN_BLKDEV_FRONTEND=y
> # CONFIG_XEN_BLKDEV_BACKEND is not set
> # CONFIG_VIRTIO_BLK is not set
> # CONFIG_BLK_DEV_RBD is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=m
> CONFIG_BLK_DEV_NVME=m
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> CONFIG_NVME_HWMON=y
> # CONFIG_NVME_RDMA is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TCP is not set
> # CONFIG_NVME_TARGET is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_SGI_XP is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_SGI_GRU is not set
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> # CONFIG_ISL29020 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> CONFIG_SRAM=y
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> # CONFIG_EEPROM_LEGACY is not set
> # CONFIG_EEPROM_MAX6875 is not set
> # CONFIG_EEPROM_93CX6 is not set
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> # CONFIG_CB710_CORE is not set
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> # CONFIG_ALTERA_STAPL is not set
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_UACCE is not set
> CONFIG_PVPANIC=y
> # CONFIG_PVPANIC_MMIO is not set
> # CONFIG_PVPANIC_PCI is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI_COMMON=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> CONFIG_BLK_DEV_SR=y
> CONFIG_CHR_DEV_SG=y
> CONFIG_BLK_DEV_BSG=y
> # CONFIG_CHR_DEV_SCH is not set
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> # end of SCSI Transports
> 
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> CONFIG_MEGARAID_NEWGEN=y
> # CONFIG_MEGARAID_MM is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_MPT3SAS is not set
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_MPI3MR is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> # CONFIG_XEN_SCSI_FRONTEND is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> # CONFIG_SCSI_ISCI is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_VIRTIO is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=m
> # CONFIG_SCSI_DH_HP_SW is not set
> CONFIG_SCSI_DH_EMC=m
> CONFIG_SCSI_DH_ALUA=m
> # end of SCSI device support
> 
> CONFIG_ATA=y
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> CONFIG_SATA_ZPODD=y
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_MOBILE_LPM_POLICY=3
> CONFIG_SATA_AHCI_PLATFORM=m
> # CONFIG_SATA_INIC162X is not set
> CONFIG_SATA_ACARD_AHCI=m
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=y
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
> 
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> CONFIG_PATA_SIS=y
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_PLATFORM is not set
> # CONFIG_PATA_RZ1000 is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=y
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> CONFIG_MD_MULTIPATH=m
> # CONFIG_MD_FAULTY is not set
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=y
> # CONFIG_DM_DEBUG is not set
> # CONFIG_DM_UNSTRIPED is not set
> # CONFIG_DM_CRYPT is not set
> # CONFIG_DM_SNAPSHOT is not set
> # CONFIG_DM_THIN_PROVISIONING is not set
> # CONFIG_DM_CACHE is not set
> # CONFIG_DM_WRITECACHE is not set
> # CONFIG_DM_EBS is not set
> # CONFIG_DM_ERA is not set
> # CONFIG_DM_CLONE is not set
> # CONFIG_DM_MIRROR is not set
> # CONFIG_DM_RAID is not set
> # CONFIG_DM_ZERO is not set
> CONFIG_DM_MULTIPATH=m
> # CONFIG_DM_MULTIPATH_QL is not set
> # CONFIG_DM_MULTIPATH_ST is not set
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> # CONFIG_DM_DELAY is not set
> # CONFIG_DM_DUST is not set
> CONFIG_DM_INIT=y
> CONFIG_DM_UEVENT=y
> # CONFIG_DM_FLAKEY is not set
> # CONFIG_DM_VERITY is not set
> # CONFIG_DM_SWITCH is not set
> # CONFIG_DM_LOG_WRITES is not set
> # CONFIG_DM_INTEGRITY is not set
> # CONFIG_DM_ZONED is not set
> CONFIG_DM_AUDIT=y
> # CONFIG_TARGET_CORE is not set
> CONFIG_FUSION=y
> # CONFIG_FUSION_SPI is not set
> # CONFIG_FUSION_SAS is not set
> CONFIG_FUSION_MAX_SGE=128
> CONFIG_FUSION_LOGGING=y
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=m
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> CONFIG_BONDING=m
> # CONFIG_DUMMY is not set
> CONFIG_WIREGUARD=m
> # CONFIG_WIREGUARD_DEBUG is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_NET_FC=y
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> CONFIG_VXLAN=m
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_AMT is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_RIONET is not set
> CONFIG_TUN=y
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=m
> # CONFIG_VIRTIO_NET is not set
> # CONFIG_NLMON is not set
> # CONFIG_NET_VRF is not set
> # CONFIG_ARCNET is not set
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ASIX=y
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> # CONFIG_CX_ECAT is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> # CONFIG_CAVIUM_PTP is not set
> # CONFIG_LIQUIDIO is not set
> # CONFIG_LIQUIDIO_VF is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CIRRUS=y
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> CONFIG_NET_VENDOR_DAVICOM=y
> # CONFIG_DM9051 is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> CONFIG_NET_TULIP=y
> # CONFIG_DE2104X is not set
> # CONFIG_TULIP is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_DM9102 is not set
> # CONFIG_ULI526X is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_ENGLEDER=y
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_FUNGIBLE=y
> # CONFIG_FUN_ETH is not set
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> # CONFIG_E1000 is not set
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_IXGBEVF is not set
> CONFIG_I40E=m
> CONFIG_I40E_DCB=y
> # CONFIG_I40EVF is not set
> CONFIG_ICE=m
> CONFIG_ICE_SWITCHDEV=y
> CONFIG_ICE_HWTS=y
> # CONFIG_FM10K is not set
> # CONFIG_IGC is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MICROSOFT=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> # CONFIG_ROCKER is not set
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VERTEXCOM=y
> # CONFIG_MSE102X is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> CONFIG_FDDI=y
> # CONFIG_DEFXX is not set
> # CONFIG_SKFP is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> CONFIG_LED_TRIGGER_PHY=y
> CONFIG_FIXED_PHY=y
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_ADIN_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> # CONFIG_AX88796B_PHY is not set
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_BCM54140_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> CONFIG_BCM84881_PHY=y
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> # CONFIG_MEDIATEK_GE_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_MOTORCOMM_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_AT803X_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_REALTEK_PHY is not set
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_FWNODE_MDIO=y
> CONFIG_ACPI_MDIO=y
> CONFIG_MDIO_DEVRES=y
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> # CONFIG_MDIO_THUNDER is not set
> 
> #
> # MDIO Multiplexers
> #
> 
> #
> # PCS device drivers
> #
> # CONFIG_PCS_XPCS is not set
> # end of PCS device drivers
> 
> CONFIG_PPP=y
> # CONFIG_PPP_BSDCOMP is not set
> # CONFIG_PPP_DEFLATE is not set
> CONFIG_PPP_FILTER=y
> # CONFIG_PPP_MPPE is not set
> CONFIG_PPP_MULTILINK=y
> # CONFIG_PPPOE is not set
> # CONFIG_PPP_ASYNC is not set
> # CONFIG_PPP_SYNC_TTY is not set
> # CONFIG_SLIP is not set
> CONFIG_SLHC=y
> # CONFIG_USB_NET_DRIVERS is not set
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> CONFIG_ATH5K_PCI=y
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> CONFIG_WAN=y
> # CONFIG_HDLC is not set
> 
> #
> # Wireless WAN
> #
> CONFIG_WWAN=y
> CONFIG_WWAN_DEBUGFS=y
> # CONFIG_WWAN_HWSIM is not set
> # CONFIG_IOSM is not set
> # end of Wireless WAN
> 
> CONFIG_XEN_NETDEV_FRONTEND=y
> # CONFIG_XEN_NETDEV_BACKEND is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_NETDEVSIM is not set
> # CONFIG_NET_FAILOVER is not set
> CONFIG_ISDN=y
> # CONFIG_MISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_SPARSEKMAP is not set
> # CONFIG_INPUT_MATRIXKMAP is not set
> CONFIG_INPUT_VIVALDIFMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5520 is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_TWL4030 is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=y
> # CONFIG_MOUSE_PS2 is not set
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> CONFIG_INPUT_JOYSTICK=y
> # CONFIG_JOYSTICK_ANALOG is not set
> # CONFIG_JOYSTICK_A3D is not set
> # CONFIG_JOYSTICK_ADI is not set
> # CONFIG_JOYSTICK_COBRA is not set
> # CONFIG_JOYSTICK_GF2K is not set
> # CONFIG_JOYSTICK_GRIP is not set
> # CONFIG_JOYSTICK_GRIP_MP is not set
> # CONFIG_JOYSTICK_GUILLEMOT is not set
> # CONFIG_JOYSTICK_INTERACT is not set
> # CONFIG_JOYSTICK_SIDEWINDER is not set
> # CONFIG_JOYSTICK_TMDC is not set
> # CONFIG_JOYSTICK_IFORCE is not set
> # CONFIG_JOYSTICK_WARRIOR is not set
> # CONFIG_JOYSTICK_MAGELLAN is not set
> # CONFIG_JOYSTICK_SPACEORB is not set
> # CONFIG_JOYSTICK_SPACEBALL is not set
> # CONFIG_JOYSTICK_STINGER is not set
> # CONFIG_JOYSTICK_TWIDJOY is not set
> # CONFIG_JOYSTICK_ZHENHUA is not set
> # CONFIG_JOYSTICK_AS5011 is not set
> # CONFIG_JOYSTICK_JOYDUMP is not set
> # CONFIG_JOYSTICK_XPAD is not set
> # CONFIG_JOYSTICK_PSXPAD_SPI is not set
> # CONFIG_JOYSTICK_PXRC is not set
> # CONFIG_JOYSTICK_QWIIC is not set
> # CONFIG_JOYSTICK_FSIA6B is not set
> CONFIG_INPUT_TABLET=y
> # CONFIG_TABLET_USB_ACECAD is not set
> # CONFIG_TABLET_USB_AIPTEK is not set
> # CONFIG_TABLET_USB_HANWANG is not set
> # CONFIG_TABLET_USB_KBTAB is not set
> # CONFIG_TABLET_USB_PEGASUS is not set
> # CONFIG_TABLET_SERIAL_WACOM4 is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> # CONFIG_TOUCHSCREEN_88PM860X is not set
> # CONFIG_TOUCHSCREEN_ADS7846 is not set
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> # CONFIG_TOUCHSCREEN_BU21029 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> # CONFIG_TOUCHSCREEN_DA9034 is not set
> # CONFIG_TOUCHSCREEN_DA9052 is not set
> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> # CONFIG_TOUCHSCREEN_EXC3000 is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> # CONFIG_TOUCHSCREEN_HIDEEP is not set
> # CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_ILITEK is not set
> # CONFIG_TOUCHSCREEN_S6SY761 is not set
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> CONFIG_TOUCHSCREEN_ELAN=y
> # CONFIG_TOUCHSCREEN_ELO is not set
> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> # CONFIG_TOUCHSCREEN_MCS5000 is not set
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> # CONFIG_TOUCHSCREEN_MSG2638 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_IMAGIS is not set
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> # CONFIG_TOUCHSCREEN_MK712 is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> # CONFIG_TOUCHSCREEN_WM831X is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> # CONFIG_TOUCHSCREEN_TSC2005 is not set
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> # CONFIG_TOUCHSCREEN_PCAP is not set
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> # CONFIG_TOUCHSCREEN_SX8654 is not set
> # CONFIG_TOUCHSCREEN_TPS6507X is not set
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> # CONFIG_TOUCHSCREEN_ZINITIX is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_88PM860X_ONKEY is not set
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> # CONFIG_INPUT_PCSPKR is not set
> # CONFIG_INPUT_MAX77693_HAPTIC is not set
> # CONFIG_INPUT_MAX8925_ONKEY is not set
> # CONFIG_INPUT_MAX8997_HAPTIC is not set
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_APANEL is not set
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> # CONFIG_INPUT_ATLAS_BTNS is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> # CONFIG_INPUT_TWL4030_PWRBUTTON is not set
> # CONFIG_INPUT_TWL4030_VIBRA is not set
> # CONFIG_INPUT_TWL6040_VIBRA is not set
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_PALMAS_PWRBUTTON is not set
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_PWM_BEEPER is not set
> # CONFIG_INPUT_PWM_VIBRA is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> # CONFIG_INPUT_DA9052_ONKEY is not set
> # CONFIG_INPUT_DA9055_ONKEY is not set
> # CONFIG_INPUT_DA9063_ONKEY is not set
> # CONFIG_INPUT_WM831X_ON is not set
> # CONFIG_INPUT_PCAP is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_IQS269A is not set
> # CONFIG_INPUT_IQS626A is not set
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=0
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=y
> CONFIG_SERIAL_8250_16550A_VARIANTS=y
> CONFIG_SERIAL_8250_FINTEK=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> # CONFIG_SERIAL_8250_EXAR is not set
> CONFIG_SERIAL_8250_NR_UARTS=48
> CONFIG_SERIAL_8250_RUNTIME_UARTS=32
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=y
> # CONFIG_SERIAL_8250_DW is not set
> CONFIG_SERIAL_8250_RT288X=y
> # CONFIG_SERIAL_8250_LPSS is not set
> # CONFIG_SERIAL_8250_MID is not set
> CONFIG_SERIAL_8250_PERICOM=y
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_KGDB_NMI=y
> # CONFIG_SERIAL_MAX3100 is not set
> CONFIG_SERIAL_MAX310X=y
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_CONSOLE_POLL=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_LANTIQ is not set
> CONFIG_SERIAL_SCCNXP=y
> CONFIG_SERIAL_SCCNXP_CONSOLE=y
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> CONFIG_SERIAL_NONSTANDARD=y
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> # CONFIG_SYNCLINK_GT is not set
> # CONFIG_N_HDLC is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_IRQ=y
> CONFIG_HVC_XEN=y
> CONFIG_HVC_XEN_FRONTEND=y
> CONFIG_SERIAL_DEV_BUS=y
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> CONFIG_TTY_PRINTK=y
> CONFIG_TTY_PRINTK_LEVEL=6
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_SI=m
> CONFIG_IPMI_SSIF=m
> # CONFIG_IPMI_WATCHDOG is not set
> # CONFIG_IPMI_POWEROFF is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> # CONFIG_HW_RANDOM_INTEL is not set
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_BA431 is not set
> # CONFIG_HW_RANDOM_VIA is not set
> # CONFIG_HW_RANDOM_VIRTIO is not set
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=y
> # CONFIG_NVRAM is not set
> CONFIG_DEVPORT=y
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> CONFIG_HPET_MMAP_DEFAULT=y
> # CONFIG_HANGCHECK_TIMER is not set
> # CONFIG_UV_MMTIMER is not set
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> # CONFIG_TCG_NSC is not set
> # CONFIG_TCG_ATMEL is not set
> # CONFIG_TCG_INFINEON is not set
> # CONFIG_TCG_XEN is not set
> CONFIG_TCG_CRB=y
> # CONFIG_TCG_VTPM_PROXY is not set
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> # CONFIG_TELCLOCK is not set
> # CONFIG_XILLYBUS is not set
> # CONFIG_XILLYUSB is not set
> CONFIG_RANDOM_TRUST_CPU=y
> CONFIG_RANDOM_TRUST_BOOTLOADER=y
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> # CONFIG_I2C_MUX is not set
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_ALGOBIT=m
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> CONFIG_I2C_PIIX4=m
> # CONFIG_I2C_CHT_WC is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_AMDPSP is not set
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PCA_PLATFORM is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_CP2615 is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_NXP_FLEXSPI is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_INTEL_PCI is not set
> # CONFIG_SPI_INTEL_PLATFORM is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_ROCKCHIP is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> # CONFIG_SPI_AMD is not set
> 
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> CONFIG_SPI_SLAVE=y
> # CONFIG_SPI_SLAVE_TIME is not set
> # CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
> CONFIG_SPI_DYNAMIC=y
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> # CONFIG_DP83640_PHY is not set
> # CONFIG_PTP_1588_CLOCK_INES is not set
> # CONFIG_PTP_1588_CLOCK_KVM is not set
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> CONFIG_PINCTRL_AMD=y
> # CONFIG_PINCTRL_MCP23S08 is not set
> CONFIG_PINCTRL_SX150X=y
> 
> #
> # Intel pinctrl drivers
> #
> CONFIG_PINCTRL_BAYTRAIL=y
> CONFIG_PINCTRL_CHERRYVIEW=y
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=y
> # CONFIG_PINCTRL_ALDERLAKE is not set
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LAKEFIELD is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> # CONFIG_PINCTRL_TIGERLAKE is not set
> # end of Intel pinctrl drivers
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_CDEV=y
> # CONFIG_GPIO_CDEV_V1 is not set
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_104_DIO_48E is not set
> # CONFIG_GPIO_104_IDIO_16 is not set
> # CONFIG_GPIO_104_IDI_48 is not set
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_GPIO_MM is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_ADP5520 is not set
> CONFIG_GPIO_CRYSTAL_COVE=y
> # CONFIG_GPIO_DA9052 is not set
> # CONFIG_GPIO_DA9055 is not set
> CONFIG_GPIO_PALMAS=y
> CONFIG_GPIO_RC5T583=y
> CONFIG_GPIO_TPS6586X=y
> CONFIG_GPIO_TPS65910=y
> # CONFIG_GPIO_TPS65912 is not set
> # CONFIG_GPIO_TWL4030 is not set
> # CONFIG_GPIO_TWL6040 is not set
> # CONFIG_GPIO_WM831X is not set
> # CONFIG_GPIO_WM8350 is not set
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
> 
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=y
> CONFIG_POWER_RESET_RESTART=y
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> # CONFIG_IP5XXX_POWER is not set
> # CONFIG_MAX8925_POWER is not set
> # CONFIG_WM831X_BACKUP is not set
> # CONFIG_WM831X_POWER is not set
> # CONFIG_WM8350_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_BATTERY_88PM860X is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_DA9030 is not set
> # CONFIG_BATTERY_DA9052 is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> CONFIG_CHARGER_MANAGER=y
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_MAX14577 is not set
> # CONFIG_CHARGER_MAX77693 is not set
> # CONFIG_CHARGER_MAX77976 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24190 is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_CHARGER_TPS65090 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_BD99954 is not set
> # CONFIG_BATTERY_UG3105 is not set
> CONFIG_HWMON=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> # CONFIG_SENSORS_ABITUGURU3 is not set
> # CONFIG_SENSORS_AD7314 is not set
> # CONFIG_SENSORS_AD7414 is not set
> # CONFIG_SENSORS_AD7418 is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM1177 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> # CONFIG_SENSORS_ADT7462 is not set
> # CONFIG_SENSORS_ADT7470 is not set
> # CONFIG_SENSORS_ADT7475 is not set
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AS370 is not set
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> # CONFIG_SENSORS_K8TEMP is not set
> CONFIG_SENSORS_K10TEMP=m
> # CONFIG_SENSORS_FAM15H_POWER is not set
> # CONFIG_SENSORS_APPLESMC is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ASPEED is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> # CONFIG_SENSORS_DS620 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_DELL_SMM is not set
> # CONFIG_SENSORS_DA9052_ADC is not set
> # CONFIG_SENSORS_DA9055 is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_FSCHMD is not set
> # CONFIG_SENSORS_FTSTEUTATES is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> # CONFIG_SENSORS_IBMAEM is not set
> # CONFIG_SENSORS_IBMPEX is not set
> # CONFIG_SENSORS_I5500 is not set
> # CONFIG_SENSORS_CORETEMP is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_JC42 is not set
> # CONFIG_SENSORS_POWR1220 is not set
> # CONFIG_SENSORS_LINEAGE is not set
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> # CONFIG_SENSORS_LTC4260 is not set
> # CONFIG_SENSORS_LTC4261 is not set
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> # CONFIG_SENSORS_MAX16065 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_MAX1668 is not set
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6642 is not set
> # CONFIG_SENSORS_MAX6650 is not set
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_MLXREG_FAN is not set
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM70 is not set
> # CONFIG_SENSORS_LM73 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_LM93 is not set
> # CONFIG_SENSORS_LM95234 is not set
> # CONFIG_SENSORS_LM95241 is not set
> # CONFIG_SENSORS_LM95245 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_NCT6683 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> # CONFIG_SENSORS_SHT15 is not set
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_SY7636A is not set
> # CONFIG_SENSORS_DME1737 is not set
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC6W201 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_SCH5627 is not set
> # CONFIG_SENSORS_SCH5636 is not set
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> # CONFIG_SENSORS_ADS7871 is not set
> # CONFIG_SENSORS_AMC6821 is not set
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_INA238 is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83793 is not set
> # CONFIG_SENSORS_W83795 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_SENSORS_WM831X is not set
> # CONFIG_SENSORS_WM8350 is not set
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=m
> # CONFIG_SENSORS_ATK0110 is not set
> # CONFIG_SENSORS_ASUS_WMI is not set
> # CONFIG_SENSORS_ASUS_WMI_EC is not set
> # CONFIG_SENSORS_ASUS_EC is not set
> CONFIG_THERMAL=y
> CONFIG_THERMAL_NETLINK=y
> CONFIG_THERMAL_STATISTICS=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
> CONFIG_DEVFREQ_THERMAL=y
> CONFIG_THERMAL_EMULATION=y
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_X86_THERMAL_VECTOR=y
> # CONFIG_X86_PKG_TEMP_THERMAL is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_PCH_THERMAL is not set
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_MENLOW is not set
> # CONFIG_INTEL_HFI_THERMAL is not set
> # end of Intel thermal drivers
> 
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> CONFIG_WATCHDOG_SYSFS=y
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
> 
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
> 
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_DA9052_WATCHDOG is not set
> # CONFIG_DA9055_WATCHDOG is not set
> # CONFIG_DA9063_WATCHDOG is not set
> # CONFIG_WDAT_WDT is not set
> # CONFIG_WM831X_WATCHDOG is not set
> # CONFIG_WM8350_WATCHDOG is not set
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_MLX_WDT is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_TWL4030_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_EBC_C384_WDT is not set
> # CONFIG_F71808E_WDT is not set
> # CONFIG_SP5100_TCO is not set
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_IBMASR is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I6300ESB_WDT is not set
> # CONFIG_IE6XX_WDT is not set
> # CONFIG_ITCO_WDT is not set
> # CONFIG_IT8712F_WDT is not set
> # CONFIG_IT87_WDT is not set
> # CONFIG_HP_WATCHDOG is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> # CONFIG_NV_TCO is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> # CONFIG_SMSC_SCH311X_WDT is not set
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> # CONFIG_VIA_WDT is not set
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_W83977F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> # CONFIG_XEN_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
> 
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> CONFIG_MFD_AS3711=y
> CONFIG_PMIC_ADP5520=y
> CONFIG_MFD_AAT2870_CORE=y
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_MADERA is not set
> CONFIG_PMIC_DA903X=y
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_SPI=y
> CONFIG_MFD_DA9052_I2C=y
> CONFIG_MFD_DA9055=y
> # CONFIG_MFD_DA9062 is not set
> CONFIG_MFD_DA9063=y
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_HTC_PASIC3 is not set
> CONFIG_HTC_I2CPLD=y
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> CONFIG_INTEL_SOC_PMIC=y
> CONFIG_INTEL_SOC_PMIC_CHTWC=y
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> # CONFIG_INTEL_SOC_PMIC_MRFLD is not set
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> CONFIG_MFD_88PM860X=y
> CONFIG_MFD_MAX14577=y
> CONFIG_MFD_MAX77693=y
> CONFIG_MFD_MAX77843=y
> # CONFIG_MFD_MAX8907 is not set
> CONFIG_MFD_MAX8925=y
> CONFIG_MFD_MAX8997=y
> CONFIG_MFD_MAX8998=y
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> CONFIG_EZX_PCAP=y
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> CONFIG_MFD_RC5T583=y
> # CONFIG_MFD_SI476X_CORE is not set
> # CONFIG_MFD_SIMPLE_MFD_I2C is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SKY81452 is not set
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> CONFIG_MFD_LP8788=y
> # CONFIG_MFD_TI_LMU is not set
> CONFIG_MFD_PALMAS=y
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> CONFIG_MFD_TPS65090=y
> # CONFIG_MFD_TI_LP873X is not set
> CONFIG_MFD_TPS6586X=y
> CONFIG_MFD_TPS65910=y
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> CONFIG_MFD_TPS65912_SPI=y
> CONFIG_TWL4030_CORE=y
> CONFIG_MFD_TWL4030_AUDIO=y
> CONFIG_TWL6040_CORE=y
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> CONFIG_MFD_WM8400=y
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> CONFIG_MFD_WM831X_SPI=y
> CONFIG_MFD_WM8350=y
> CONFIG_MFD_WM8350_I2C=y
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_RAVE_SP_CORE is not set
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> # CONFIG_REGULATOR_88PG86X is not set
> # CONFIG_REGULATOR_88PM8607 is not set
> # CONFIG_REGULATOR_ACT8865 is not set
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_AAT2870 is not set
> # CONFIG_REGULATOR_AS3711 is not set
> # CONFIG_REGULATOR_DA903X is not set
> # CONFIG_REGULATOR_DA9052 is not set
> # CONFIG_REGULATOR_DA9055 is not set
> # CONFIG_REGULATOR_DA9210 is not set
> # CONFIG_REGULATOR_DA9211 is not set
> # CONFIG_REGULATOR_FAN53555 is not set
> # CONFIG_REGULATOR_GPIO is not set
> # CONFIG_REGULATOR_ISL9305 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> # CONFIG_REGULATOR_LP872X is not set
> # CONFIG_REGULATOR_LP8755 is not set
> # CONFIG_REGULATOR_LP8788 is not set
> # CONFIG_REGULATOR_LTC3589 is not set
> # CONFIG_REGULATOR_LTC3676 is not set
> # CONFIG_REGULATOR_MAX14577 is not set
> # CONFIG_REGULATOR_MAX1586 is not set
> # CONFIG_REGULATOR_MAX8649 is not set
> # CONFIG_REGULATOR_MAX8660 is not set
> # CONFIG_REGULATOR_MAX8893 is not set
> # CONFIG_REGULATOR_MAX8925 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> # CONFIG_REGULATOR_MAX8997 is not set
> # CONFIG_REGULATOR_MAX8998 is not set
> # CONFIG_REGULATOR_MAX20086 is not set
> # CONFIG_REGULATOR_MAX77693 is not set
> # CONFIG_REGULATOR_MAX77826 is not set
> # CONFIG_REGULATOR_MP8859 is not set
> # CONFIG_REGULATOR_MT6311 is not set
> # CONFIG_REGULATOR_PALMAS is not set
> # CONFIG_REGULATOR_PCA9450 is not set
> # CONFIG_REGULATOR_PCAP is not set
> # CONFIG_REGULATOR_PV88060 is not set
> # CONFIG_REGULATOR_PV88080 is not set
> # CONFIG_REGULATOR_PV88090 is not set
> # CONFIG_REGULATOR_PWM is not set
> # CONFIG_REGULATOR_RC5T583 is not set
> # CONFIG_REGULATOR_RT4801 is not set
> # CONFIG_REGULATOR_RT5190A is not set
> # CONFIG_REGULATOR_RT6160 is not set
> # CONFIG_REGULATOR_RT6245 is not set
> # CONFIG_REGULATOR_RTQ2134 is not set
> # CONFIG_REGULATOR_RTMV20 is not set
> # CONFIG_REGULATOR_RTQ6752 is not set
> # CONFIG_REGULATOR_SLG51000 is not set
> # CONFIG_REGULATOR_SY7636A is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> # CONFIG_REGULATOR_TPS65023 is not set
> # CONFIG_REGULATOR_TPS6507X is not set
> # CONFIG_REGULATOR_TPS65090 is not set
> # CONFIG_REGULATOR_TPS65132 is not set
> # CONFIG_REGULATOR_TPS6524X is not set
> # CONFIG_REGULATOR_TPS6586X is not set
> # CONFIG_REGULATOR_TPS65910 is not set
> # CONFIG_REGULATOR_TPS65912 is not set
> # CONFIG_REGULATOR_TWL4030 is not set
> # CONFIG_REGULATOR_WM831X is not set
> # CONFIG_REGULATOR_WM8350 is not set
> # CONFIG_REGULATOR_WM8400 is not set
> CONFIG_RC_CORE=m
> CONFIG_LIRC=y
> # CONFIG_RC_MAP is not set
> CONFIG_RC_DECODERS=y
> # CONFIG_IR_IMON_DECODER is not set
> # CONFIG_IR_JVC_DECODER is not set
> # CONFIG_IR_MCE_KBD_DECODER is not set
> # CONFIG_IR_NEC_DECODER is not set
> # CONFIG_IR_RC5_DECODER is not set
> # CONFIG_IR_RC6_DECODER is not set
> # CONFIG_IR_RCMM_DECODER is not set
> # CONFIG_IR_SANYO_DECODER is not set
> # CONFIG_IR_SHARP_DECODER is not set
> # CONFIG_IR_SONY_DECODER is not set
> # CONFIG_IR_XMP_DECODER is not set
> CONFIG_RC_DEVICES=y
> # CONFIG_IR_ENE is not set
> # CONFIG_IR_FINTEK is not set
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> # CONFIG_IR_ITE_CIR is not set
> # CONFIG_IR_MCEUSB is not set
> # CONFIG_IR_NUVOTON is not set
> # CONFIG_IR_REDRAT3 is not set
> # CONFIG_IR_SERIAL is not set
> # CONFIG_IR_STREAMZAP is not set
> # CONFIG_IR_TOY is not set
> # CONFIG_IR_TTUSBIR is not set
> # CONFIG_IR_WINBOND_CIR is not set
> # CONFIG_RC_ATI_REMOTE is not set
> # CONFIG_RC_LOOPBACK is not set
> # CONFIG_RC_XBOX_DVD is not set
> CONFIG_CEC_CORE=m
> 
> #
> # CEC support
> #
> CONFIG_MEDIA_CEC_RC=y
> CONFIG_MEDIA_CEC_SUPPORT=y
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_GPIO is not set
> # CONFIG_CEC_SECO is not set
> # CONFIG_USB_PULSE8_CEC is not set
> # CONFIG_USB_RAINSHADOW_CEC is not set
> # end of CEC support
> 
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> CONFIG_AGP=y
> CONFIG_AGP_AMD64=y
> CONFIG_AGP_INTEL=y
> # CONFIG_AGP_SIS is not set
> CONFIG_AGP_VIA=y
> CONFIG_INTEL_GTT=y
> CONFIG_VGA_SWITCHEROO=y
> CONFIG_DRM=m
> CONFIG_DRM_DP_AUX_CHARDEV=y
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=m
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> # CONFIG_DRM_DEBUG_MODESET_LOCK is not set
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_DP_CEC=y
> CONFIG_DRM_GEM_SHMEM_HELPER=m
> 
> #
> # I2C encoder or helper chips
> #
> # CONFIG_DRM_I2C_CH7006 is not set
> # CONFIG_DRM_I2C_SIL164 is not set
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> # CONFIG_DRM_I915 is not set
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_VMWGFX is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> CONFIG_DRM_MGAG200=m
> # CONFIG_DRM_QXL is not set
> # CONFIG_DRM_VIRTIO_GPU is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> # CONFIG_DRM_BOCHS is not set
> # CONFIG_DRM_CIRRUS_QEMU is not set
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_DRM_PANEL_MIPI_DBI is not set
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9163 is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> # CONFIG_DRM_XEN_FRONTEND is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_GUD is not set
> # CONFIG_DRM_SSD130X is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> CONFIG_DRM_NOMODESET=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=m
> CONFIG_FB_SYS_COPYAREA=m
> CONFIG_FB_SYS_IMAGEBLIT=m
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=m
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> CONFIG_FB_ASILIANT=y
> CONFIG_FB_IMSTT=y
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_EFI=y
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_INTEL is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_XEN_FBDEV_FRONTEND is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> # CONFIG_BACKLIGHT_DA903X is not set
> # CONFIG_BACKLIGHT_DA9052 is not set
> # CONFIG_BACKLIGHT_MAX8925 is not set
> # CONFIG_BACKLIGHT_APPLE is not set
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_WM831X is not set
> # CONFIG_BACKLIGHT_ADP5520 is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_88PM860X is not set
> # CONFIG_BACKLIGHT_AAT2870 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_LP855X is not set
> # CONFIG_BACKLIGHT_LP8788 is not set
> # CONFIG_BACKLIGHT_PANDORA is not set
> # CONFIG_BACKLIGHT_AS3711 is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
> 
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
> # end of Console display driver support
> 
> # CONFIG_LOGO is not set
> # end of Graphics support
> 
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> # CONFIG_HID is not set
> 
> #
> # USB HID support
> #
> # CONFIG_USB_HID is not set
> CONFIG_HID_PID=y
> 
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # end of USB HID Boot Protocol drivers
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # end of I2C HID support
> 
> #
> # Intel ISH HID support
> #
> # CONFIG_INTEL_ISH_HID is not set
> # end of Intel ISH HID support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_LED_TRIG=y
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> CONFIG_USB_DYNAMIC_MINORS=y
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
> # CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> # CONFIG_USB_MON is not set
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_XHCI_DBGCAP=y
> CONFIG_USB_XHCI_PCI=m
> CONFIG_USB_XHCI_PCI_RENESAS=m
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_FSL is not set
> CONFIG_USB_EHCI_HCD_PLATFORM=y
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_FOTG210_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> CONFIG_USB_UHCI_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
> # CONFIG_USB_XEN_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> CONFIG_USB_DWC2=y
> CONFIG_USB_DWC2_HOST=y
> 
> #
> # Gadget/Dual-role mode requires USB Gadget support to be enabled
> #
> # CONFIG_USB_DWC2_PCI is not set
> # CONFIG_USB_DWC2_DEBUG is not set
> # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> CONFIG_USB_ROLE_SWITCH=y
> # CONFIG_USB_ROLES_INTEL_XHCI is not set
> CONFIG_MMC=y
> # CONFIG_MMC_BLOCK is not set
> # CONFIG_SDIO_UART is not set
> # CONFIG_MMC_TEST is not set
> CONFIG_MMC_CRYPTO=y
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> # CONFIG_MMC_SDHCI is not set
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> # CONFIG_MMC_SPI is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_VUB300 is not set
> # CONFIG_MMC_USHC is not set
> # CONFIG_MMC_USDHI6ROL0 is not set
> # CONFIG_MMC_CQHCI is not set
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_88PM860X is not set
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_LM3530 is not set
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> # CONFIG_LEDS_LP3944 is not set
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP50XX is not set
> # CONFIG_LEDS_LP8788 is not set
> # CONFIG_LEDS_CLEVO_MAIL is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_WM831X_STATUS is not set
> # CONFIG_LEDS_WM8350 is not set
> # CONFIG_LEDS_DA903X is not set
> # CONFIG_LEDS_DA9052 is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_REGULATOR is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> # CONFIG_LEDS_LT3593 is not set
> # CONFIG_LEDS_ADP5520 is not set
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_MAX8997 is not set
> # CONFIG_LEDS_LM355x is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> # CONFIG_LEDS_MLXCPLD is not set
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> # CONFIG_LEDS_TRIGGER_TIMER is not set
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> CONFIG_LEDS_TRIGGER_DISK=y
> # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> CONFIG_LEDS_TRIGGER_CPU=y
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> CONFIG_LEDS_TRIGGER_PANIC=y
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> # CONFIG_LEDS_TRIGGER_AUDIO is not set
> # CONFIG_LEDS_TRIGGER_TTY is not set
> 
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_INFINIBAND=m
> # CONFIG_INFINIBAND_USER_MAD is not set
> CONFIG_INFINIBAND_USER_ACCESS=m
> CONFIG_INFINIBAND_USER_MEM=y
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> CONFIG_INFINIBAND_ADDR_TRANS=y
> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
> CONFIG_INFINIBAND_VIRT_DMA=y
> # CONFIG_INFINIBAND_MTHCA is not set
> # CONFIG_INFINIBAND_EFA is not set
> CONFIG_INFINIBAND_IRDMA=m
> # CONFIG_MLX4_INFINIBAND is not set
> # CONFIG_INFINIBAND_OCRDMA is not set
> # CONFIG_INFINIBAND_USNIC is not set
> # CONFIG_INFINIBAND_RDMAVT is not set
> # CONFIG_RDMA_RXE is not set
> # CONFIG_RDMA_SIW is not set
> # CONFIG_INFINIBAND_IPOIB is not set
> # CONFIG_INFINIBAND_SRP is not set
> # CONFIG_INFINIBAND_ISER is not set
> # CONFIG_INFINIBAND_RTRS_CLIENT is not set
> # CONFIG_INFINIBAND_RTRS_SERVER is not set
> # CONFIG_INFINIBAND_OPA_VNIC is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> # CONFIG_EDAC_LEGACY_SYSFS is not set
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=m
> CONFIG_EDAC_GHES=y
> CONFIG_EDAC_AMD64=m
> # CONFIG_EDAC_E752X is not set
> # CONFIG_EDAC_I82975X is not set
> # CONFIG_EDAC_I3000 is not set
> # CONFIG_EDAC_I3200 is not set
> # CONFIG_EDAC_IE31200 is not set
> # CONFIG_EDAC_X38 is not set
> # CONFIG_EDAC_I5400 is not set
> # CONFIG_EDAC_I7CORE is not set
> # CONFIG_EDAC_I5000 is not set
> # CONFIG_EDAC_I5100 is not set
> # CONFIG_EDAC_I7300 is not set
> # CONFIG_EDAC_SBRIDGE is not set
> # CONFIG_EDAC_SKX is not set
> # CONFIG_EDAC_I10NM is not set
> # CONFIG_EDAC_PND2 is not set
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_88PM860X is not set
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> # CONFIG_RTC_DRV_DS1307 is not set
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_LP8788 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_MAX8925 is not set
> # CONFIG_RTC_DRV_MAX8998 is not set
> # CONFIG_RTC_DRV_MAX8997 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_ISL12022 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_BQ32K is not set
> # CONFIG_RTC_DRV_PALMAS is not set
> # CONFIG_RTC_DRV_TPS6586X is not set
> # CONFIG_RTC_DRV_TPS65910 is not set
> # CONFIG_RTC_DRV_RC5T583 is not set
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> # CONFIG_RTC_DRV_RX8010 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> # CONFIG_RTC_DRV_RX4581 is not set
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_DS2404 is not set
> # CONFIG_RTC_DRV_DA9052 is not set
> # CONFIG_RTC_DRV_DA9055 is not set
> # CONFIG_RTC_DRV_DA9063 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_V3020 is not set
> # CONFIG_RTC_DRV_WM831X is not set
> # CONFIG_RTC_DRV_WM8350 is not set
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> # CONFIG_RTC_DRV_PCAP is not set
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> # CONFIG_INTEL_IDMA64 is not set
> # CONFIG_INTEL_IDXD is not set
> # CONFIG_INTEL_IDXD_COMPAT is not set
> # CONFIG_INTEL_IOATDMA is not set
> # CONFIG_PLX_DMA is not set
> # CONFIG_AMD_PTDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> # CONFIG_DW_DMAC is not set
> # CONFIG_DW_DMAC_PCI is not set
> # CONFIG_DW_EDMA is not set
> # CONFIG_DW_EDMA_PCIE is not set
> # CONFIG_SF_PDMA is not set
> CONFIG_INTEL_LDMA=y
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> # CONFIG_DMATEST is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> CONFIG_SW_SYNC=y
> CONFIG_UDMABUF=y
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> CONFIG_DMABUF_HEAPS=y
> # CONFIG_DMABUF_SYSFS_STATS is not set
> CONFIG_DMABUF_HEAPS_SYSTEM=y
> # end of DMABUF options
> 
> CONFIG_AUXDISPLAY=y
> # CONFIG_HD44780 is not set
> # CONFIG_IMG_ASCII_LCD is not set
> # CONFIG_HT16K33 is not set
> # CONFIG_LCD2S is not set
> # CONFIG_CHARLCD_BL_OFF is not set
> # CONFIG_CHARLCD_BL_ON is not set
> CONFIG_CHARLCD_BL_FLASH=y
> # CONFIG_UIO is not set
> CONFIG_VFIO=y
> CONFIG_VFIO_IOMMU_TYPE1=y
> CONFIG_VFIO_VIRQFD=y
> CONFIG_VFIO_NOIOMMU=y
> CONFIG_VFIO_PCI_CORE=y
> CONFIG_VFIO_PCI_MMAP=y
> CONFIG_VFIO_PCI_INTX=y
> CONFIG_VFIO_PCI=y
> CONFIG_VFIO_PCI_VGA=y
> CONFIG_VFIO_PCI_IGD=y
> # CONFIG_VFIO_MDEV is not set
> CONFIG_IRQ_BYPASS_MANAGER=y
> CONFIG_VIRT_DRIVERS=y
> CONFIG_VMGENID=y
> # CONFIG_VBOXGUEST is not set
> # CONFIG_NITRO_ENCLAVES is not set
> # CONFIG_ACRN_HSM is not set
> CONFIG_SEV_GUEST=m
> CONFIG_VIRTIO=y
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
> CONFIG_VIRTIO_PCI_LIB=y
> CONFIG_VIRTIO_PCI_LIB_LEGACY=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=y
> # CONFIG_VIRTIO_MEM is not set
> # CONFIG_VIRTIO_INPUT is not set
> CONFIG_VIRTIO_MMIO=y
> CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> # CONFIG_VDPA is not set
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_NET is not set
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
> 
> #
> # Xen driver support
> #
> CONFIG_XEN_BALLOON=y
> CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
> CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
> CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
> # CONFIG_XEN_DEV_EVTCHN is not set
> CONFIG_XEN_BACKEND=y
> # CONFIG_XENFS is not set
> CONFIG_XEN_SYS_HYPERVISOR=y
> CONFIG_XEN_XENBUS_FRONTEND=y
> # CONFIG_XEN_GNTDEV is not set
> # CONFIG_XEN_GRANT_DEV_ALLOC is not set
> CONFIG_XEN_GRANT_DMA_ALLOC=y
> CONFIG_SWIOTLB_XEN=y
> # CONFIG_XEN_PCIDEV_BACKEND is not set
> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> # CONFIG_XEN_PVCALLS_BACKEND is not set
> # CONFIG_XEN_PRIVCMD is not set
> CONFIG_XEN_ACPI_PROCESSOR=y
> CONFIG_XEN_MCE_LOG=y
> CONFIG_XEN_HAVE_PVMMU=y
> CONFIG_XEN_EFI=y
> CONFIG_XEN_AUTO_XLATE=y
> CONFIG_XEN_ACPI=y
> CONFIG_XEN_HAVE_VPMU=y
> CONFIG_XEN_UNPOPULATED_ALLOC=y
> # end of Xen driver support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> CONFIG_STAGING=y
> # CONFIG_RTL8192U is not set
> # CONFIG_RTLLIB is not set
> # CONFIG_RTS5208 is not set
> # CONFIG_FB_SM750 is not set
> CONFIG_STAGING_MEDIA=y
> # CONFIG_LTE_GDM724X is not set
> CONFIG_UNISYSSPAR=y
> # CONFIG_FB_TFT is not set
> # CONFIG_KS7010 is not set
> # CONFIG_PI433 is not set
> # CONFIG_FIELDBUS_DEV is not set
> # CONFIG_QLGE is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACPI_WMI=m
> CONFIG_WMI_BMOF=m
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_UV_SYSFS is not set
> # CONFIG_MXM_WMI is not set
> # CONFIG_PEAQ_WMI is not set
> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> # CONFIG_YOGABOOK_WMI is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_ACER_WMI is not set
> # CONFIG_AMD_PMC is not set
> # CONFIG_AMD_HSMP is not set
> # CONFIG_ADV_SWBUTTON is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_ASUS_LAPTOP is not set
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_ASUS_WMI is not set
> # CONFIG_EEEPC_LAPTOP is not set
> CONFIG_X86_PLATFORM_DRIVERS_DELL=y
> # CONFIG_ALIENWARE_WMI is not set
> CONFIG_DCDBAS=m
> # CONFIG_DELL_LAPTOP is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DELL_RBTN is not set
> CONFIG_DELL_SMBIOS=m
> CONFIG_DELL_SMBIOS_WMI=y
> CONFIG_DELL_SMBIOS_SMM=y
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_DELL_WMI is not set
> # CONFIG_DELL_WMI_AIO is not set
> CONFIG_DELL_WMI_DESCRIPTOR=m
> # CONFIG_DELL_WMI_LED is not set
> # CONFIG_DELL_WMI_SYSMAN is not set
> # CONFIG_AMILO_RFKILL is not set
> # CONFIG_FUJITSU_LAPTOP is not set
> # CONFIG_FUJITSU_TABLET is not set
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_HP_ACCEL is not set
> # CONFIG_WIRELESS_HOTKEY is not set
> # CONFIG_HP_WMI is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_IDEAPAD_LAPTOP is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_THINKPAD_ACPI is not set
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> # CONFIG_INTEL_SKL_INT3472 is not set
> CONFIG_INTEL_PMC_CORE=y
> 
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
> 
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> # CONFIG_INTEL_WMI_THUNDERBOLT is not set
> 
> #
> # Intel Uncore Frequency Control
> #
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> # end of Intel Uncore Frequency Control
> 
> # CONFIG_INTEL_HID_EVENT is not set
> # CONFIG_INTEL_VBTN is not set
> # CONFIG_INTEL_INT0002_VGPIO is not set
> # CONFIG_INTEL_OAKTRAIL is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_TURBO_MAX_3=y
> # CONFIG_INTEL_VSEC is not set
> # CONFIG_MSI_LAPTOP is not set
> # CONFIG_MSI_WMI is not set
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> # CONFIG_SAMSUNG_LAPTOP is not set
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> # CONFIG_ACPI_CMPC is not set
> # CONFIG_COMPAL_LAPTOP is not set
> # CONFIG_LG_LAPTOP is not set
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_SONY_LAPTOP is not set
> # CONFIG_SYSTEM76_ACPI is not set
> # CONFIG_TOPSTAR_LAPTOP is not set
> # CONFIG_SERIAL_MULTI_INSTANTIATE is not set
> # CONFIG_MLX_PLATFORM is not set
> # CONFIG_X86_ANDROID_TABLETS is not set
> # CONFIG_INTEL_IPS is not set
> CONFIG_INTEL_SCU_IPC=y
> CONFIG_INTEL_SCU=y
> CONFIG_INTEL_SCU_PCI=y
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_INTEL_SCU_IPC_UTIL is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> CONFIG_PMC_ATOM=y
> CONFIG_CHROME_PLATFORMS=y
> # CONFIG_CHROMEOS_LAPTOP is not set
> # CONFIG_CHROMEOS_PSTORE is not set
> # CONFIG_CHROMEOS_TBMC is not set
> # CONFIG_CROS_EC is not set
> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> # CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
> CONFIG_MELLANOX_PLATFORM=y
> # CONFIG_MLXREG_HOTPLUG is not set
> # CONFIG_MLXREG_IO is not set
> # CONFIG_MLXREG_LC is not set
> CONFIG_SURFACE_PLATFORMS=y
> # CONFIG_SURFACE3_WMI is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> # CONFIG_SURFACE_AGGREGATOR is not set
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_COMMON_CLK_WM831X is not set
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_CLK_TWL6040 is not set
> # CONFIG_COMMON_CLK_PALMAS is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_HWSPINLOCK=y
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOASID=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IO_PGTABLE=y
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=y
> CONFIG_IOMMU_SVA=y
> CONFIG_AMD_IOMMU=y
> # CONFIG_AMD_IOMMU_V2 is not set
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> CONFIG_INTEL_IOMMU_SVM=y
> CONFIG_INTEL_IOMMU_DEFAULT_ON=y
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
> CONFIG_IRQ_REMAP=y
> CONFIG_VIRTIO_IOMMU=y
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=y
> CONFIG_REMOTEPROC_CDEV=y
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> CONFIG_SOC_TI=y
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> CONFIG_DEVFREQ_GOV_USERSPACE=y
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=y
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_FSA9480 is not set
> # CONFIG_EXTCON_GPIO is not set
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> # CONFIG_EXTCON_INTEL_CHT_WC is not set
> # CONFIG_EXTCON_MAX14577 is not set
> # CONFIG_EXTCON_MAX3355 is not set
> # CONFIG_EXTCON_MAX77693 is not set
> # CONFIG_EXTCON_MAX77843 is not set
> # CONFIG_EXTCON_MAX8997 is not set
> # CONFIG_EXTCON_PALMAS is not set
> # CONFIG_EXTCON_PTN5150 is not set
> # CONFIG_EXTCON_RT8973A is not set
> # CONFIG_EXTCON_SM5502 is not set
> # CONFIG_EXTCON_USB_GPIO is not set
> # CONFIG_EXTCON_USBC_TUSB320 is not set
> CONFIG_MEMORY=y
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> CONFIG_VME_BUS=y
> 
> #
> # VME Bridge Drivers
> #
> # CONFIG_VME_CA91CX42 is not set
> # CONFIG_VME_TSI148 is not set
> # CONFIG_VME_FAKE is not set
> 
> #
> # VME Board Drivers
> #
> # CONFIG_VMIVME_7805 is not set
> 
> #
> # VME Device Drivers
> #
> # CONFIG_VME_USER is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> CONFIG_PWM_CRC=y
> # CONFIG_PWM_DWC is not set
> CONFIG_PWM_LPSS=y
> CONFIG_PWM_LPSS_PCI=y
> CONFIG_PWM_LPSS_PLATFORM=y
> # CONFIG_PWM_PCA9685 is not set
> # CONFIG_PWM_TWL is not set
> # CONFIG_PWM_TWL_LED is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> # CONFIG_IPACK_BUS is not set
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_RESET_TI_SYSCON is not set
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
> 
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_SAMSUNG_USB2 is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> CONFIG_INTEL_RAPL_CORE=m
> CONFIG_INTEL_RAPL=m
> CONFIG_IDLE_INJECT=y
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> CONFIG_RAS_CEC=y
> # CONFIG_RAS_CEC_DEBUG is not set
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> CONFIG_LIBNVDIMM=y
> # CONFIG_BLK_DEV_PMEM is not set
> CONFIG_ND_CLAIM=y
> CONFIG_BTT=y
> CONFIG_NVDIMM_PFN=y
> CONFIG_NVDIMM_DAX=y
> CONFIG_NVDIMM_KEYS=y
> CONFIG_DAX=y
> # CONFIG_DEV_DAX is not set
> # CONFIG_DEV_DAX_HMEM is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> CONFIG_PM_OPP=y
> # CONFIG_UNISYS_VISORBUS is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> CONFIG_INTERCONNECT=y
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # CONFIG_PECI is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_VALIDATE_FS_PARSER=y
> CONFIG_FS_IOMAP=y
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_USE_FOR_EXT2=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> CONFIG_BTRFS_FS=m
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> # CONFIG_ZONEFS_FS is not set
> CONFIG_FS_DAX=y
> CONFIG_FS_DAX_PMD=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
> CONFIG_FS_VERITY=y
> # CONFIG_FS_VERITY_DEBUG is not set
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> # CONFIG_PRINT_QUOTA_WARNING is not set
> # CONFIG_QUOTA_DEBUG is not set
> # CONFIG_QFMT_V1 is not set
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> # CONFIG_AUTOFS4_FS is not set
> CONFIG_AUTOFS_FS=m
> CONFIG_FUSE_FS=y
> # CONFIG_CUSE is not set
> # CONFIG_VIRTIO_FS is not set
> CONFIG_OVERLAY_FS=m
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> # CONFIG_OVERLAY_FS_INDEX is not set
> CONFIG_OVERLAY_FS_XINO_AUTO=y
> # CONFIG_OVERLAY_FS_METACOPY is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_VMCORE=y
> CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_PROC_CPU_RESCTRL=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> CONFIG_TMPFS_INODE64=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
> # CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> CONFIG_ECRYPT_FS=y
> CONFIG_ECRYPT_FS_MESSAGING=y
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> CONFIG_SQUASHFS=y
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZ4=y
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> CONFIG_SQUASHFS_ZSTD=y
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=y
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=y
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> # CONFIG_PSTORE_RAM is not set
> # CONFIG_PSTORE_BLK is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> # CONFIG_NFS_FS is not set
> # CONFIG_NFSD is not set
> # CONFIG_CEPH_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_SMB_SERVER is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=m
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> # CONFIG_NLS_UTF8 is not set
> # CONFIG_DLM is not set
> CONFIG_UNICODE=y
> # CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_REQUEST_CACHE=y
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_TRUSTED_KEYS=y
> CONFIG_ENCRYPTED_KEYS=y
> # CONFIG_USER_DECRYPTED_DATA is not set
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_KEY_NOTIFICATIONS=y
> CONFIG_SECURITY_DMESG_RESTRICT=y
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_SECURITY_INFINIBAND=y
> CONFIG_SECURITY_NETWORK_XFRM=y
> CONFIG_SECURITY_PATH=y
> CONFIG_INTEL_TXT=y
> CONFIG_LSM_MMAP_MIN_ADDR=0
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
> CONFIG_SECURITY_SMACK=y
> # CONFIG_SECURITY_SMACK_BRINGUP is not set
> CONFIG_SECURITY_SMACK_NETFILTER=y
> CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
> CONFIG_SECURITY_TOMOYO=y
> CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
> CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
> # CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
> CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
> CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/sbin/init"
> # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
> CONFIG_SECURITY_APPARMOR=y
> CONFIG_SECURITY_APPARMOR_HASH=y
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=y
> CONFIG_SECURITY_SAFESETID=y
> CONFIG_SECURITY_LOCKDOWN_LSM=y
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
> CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
> CONFIG_SECURITY_LANDLOCK=y
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> CONFIG_INTEGRITY_PLATFORM_KEYRING=y
> # CONFIG_INTEGRITY_MACHINE_KEYRING is not set
> CONFIG_LOAD_UEFI_KEYS=y
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=y
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA1=y
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH="sha1"
> # CONFIG_IMA_WRITE_POLICY is not set
> # CONFIG_IMA_READ_POLICY is not set
> CONFIG_IMA_APPRAISE=y
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> CONFIG_IMA_APPRAISE_MODSIG=y
> CONFIG_IMA_TRUSTED_KEYRING=y
> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> CONFIG_EVM_EXTRA_SMACK_XATTRS=y
> CONFIG_EVM_ADD_XATTRS=y
> # CONFIG_EVM_LOAD_X509 is not set
> # CONFIG_DEFAULT_SECURITY_SELINUX is not set
> # CONFIG_DEFAULT_SECURITY_SMACK is not set
> # CONFIG_DEFAULT_SECURITY_TOMOYO is not set
> CONFIG_DEFAULT_SECURITY_APPARMOR=y
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM="landlock,lockdown,yama,integrity,apparmor"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
> # CONFIG_ZERO_CALL_USED_REGS is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=m
> CONFIG_ASYNC_CORE=m
> CONFIG_ASYNC_MEMCPY=m
> CONFIG_ASYNC_XOR=m
> CONFIG_ASYNC_PQ=m
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_PCRYPT is not set
> CONFIG_CRYPTO_CRYPTD=m
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=m
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> # CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
> # CONFIG_CRYPTO_ECDH is not set
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> CONFIG_CRYPTO_CURVE25519_X86=m
> 
> #
> # Authenticated Encryption with Associated Data
> #
> # CONFIG_CRYPTO_CCM is not set
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_SEQIV=y
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_OFB is not set
> # CONFIG_CRYPTO_PCBC is not set
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> # CONFIG_CRYPTO_CMAC is not set
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> # CONFIG_CRYPTO_CRC32 is not set
> CONFIG_CRYPTO_CRC32_PCLMUL=m
> CONFIG_CRYPTO_XXHASH=m
> CONFIG_CRYPTO_BLAKE2B=m
> # CONFIG_CRYPTO_BLAKE2S is not set
> CONFIG_CRYPTO_BLAKE2S_X86=m
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
> CONFIG_CRYPTO_CRC64_ROCKSOFT=y
> CONFIG_CRYPTO_GHASH=y
> # CONFIG_CRYPTO_POLY1305 is not set
> CONFIG_CRYPTO_POLY1305_X86_64=m
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_SHA1=y
> # CONFIG_CRYPTO_SHA1_SSSE3 is not set
> # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> # CONFIG_CRYPTO_SHA3 is not set
> # CONFIG_CRYPTO_SM3 is not set
> # CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> # CONFIG_CRYPTO_WP512 is not set
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_NI_INTEL=m
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_CHACHA20 is not set
> CONFIG_CRYPTO_CHACHA20_X86_64=m
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_SM4 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_TWOFISH_X86_64 is not set
> # CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
> # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_KDF800108_CTR=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=y
> # CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
> # CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=y
> CONFIG_CRYPTO_DEV_CCP_DD=m
> CONFIG_CRYPTO_DEV_SP_CCP=y
> # CONFIG_CRYPTO_DEV_CCP_CRYPTO is not set
> CONFIG_CRYPTO_DEV_SP_PSP=y
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> # CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> CONFIG_SYSTEM_REVOCATION_LIST=y
> CONFIG_SYSTEM_REVOCATION_KEYS=""
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_RAID6_PQ_BENCHMARK=y
> CONFIG_LINEAR_RANGES=y
> CONFIG_PACKING=y
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> # CONFIG_CORDIC is not set
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
> CONFIG_CRYPTO_LIB_CHACHA=m
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
> CONFIG_CRYPTO_LIB_CURVE25519=m
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
> CONFIG_CRYPTO_LIB_POLY1305=m
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC64_ROCKSOFT=y
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=y
> # CONFIG_CRC4 is not set
> # CONFIG_CRC7 is not set
> CONFIG_LIBCRC32C=m
> # CONFIG_CRC8 is not set
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=m
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_COHERENT_POOL=y
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_IOMMU_HELPER=y
> CONFIG_CPUMASK_OFFSTACK=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_DIMLIB=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_7x14 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> CONFIG_FONT_ACORN_8x8=y
> # CONFIG_FONT_MINI_4x6 is not set
> CONFIG_FONT_6x10=y
> # CONFIG_FONT_10x18 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> CONFIG_FONT_TER16x32=y
> # CONFIG_FONT_6x8 is not set
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_COPY_MC=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> CONFIG_PLDMFW=y
> CONFIG_ASN1_ENCODER=y
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> # CONFIG_PRINTK_CALLER is not set
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_NONE is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> CONFIG_DEBUG_INFO_DWARF5=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> CONFIG_GDB_SCRIPTS=y
> CONFIG_FRAME_WARN=1024
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
> CONFIG_FRAME_POINTER=y
> CONFIG_STACK_VALIDATION=y
> CONFIG_VMLINUX_MAP=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> CONFIG_KGDB=y
> CONFIG_KGDB_HONOUR_BLOCKLIST=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> # CONFIG_KGDB_TESTS is not set
> CONFIG_KGDB_LOW_LEVEL_TRAP=y
> CONFIG_KGDB_KDB=y
> CONFIG_KDB_DEFAULT_ENABLE=0x1
> CONFIG_KDB_KEYBOARD=y
> CONFIG_KDB_CONTINUE_CATASTROPHIC=0
> CONFIG_ARCH_HAS_EARLY_DEBUG=y
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ONLY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> CONFIG_UBSAN_BOOL=y
> CONFIG_UBSAN_ENUM=y
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_TEST_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=y
> CONFIG_HAVE_KCSAN_COMPILER=y
> # CONFIG_KCSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_TABLE_CHECK is not set
> CONFIG_PAGE_POISONING=y
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_DEBUG_WX=y
> CONFIG_GENERIC_PTDUMP=y
> CONFIG_PTDUMP_CORE=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> # CONFIG_KASAN is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> CONFIG_KFENCE=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=0
> CONFIG_KFENCE_NUM_OBJECTS=255
> # CONFIG_KFENCE_DEFERRABLE is not set
> # CONFIG_KFENCE_STATIC_KEYS is not set
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> CONFIG_DEBUG_PREEMPT=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_RETHOOK=y
> CONFIG_RETHOOK=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_OBJTOOL_MCOUNT=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
> CONFIG_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_BOOTTIME_TRACING=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
> # CONFIG_FPROBE is not set
> CONFIG_FUNCTION_PROFILER=y
> CONFIG_STACK_TRACER=y
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_SCHED_TRACER=y
> CONFIG_HWLAT_TRACER=y
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> CONFIG_MMIOTRACE=y
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_KPROBE_EVENTS=y
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> CONFIG_BPF_KPROBE_OVERRIDE=y
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_MCOUNT_USE_CC=y
> CONFIG_TRACING_MAP=y
> CONFIG_SYNTH_EVENTS=y
> CONFIG_HIST_TRIGGERS=y
> CONFIG_TRACE_EVENT_INJECT=y
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_MMIOTRACE_TEST is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> CONFIG_SAMPLES=y
> # CONFIG_SAMPLE_AUXDISPLAY is not set
> # CONFIG_SAMPLE_TRACE_EVENTS is not set
> # CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
> # CONFIG_SAMPLE_TRACE_PRINTK is not set
> # CONFIG_SAMPLE_FTRACE_DIRECT is not set
> # CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
> # CONFIG_SAMPLE_TRACE_ARRAY is not set
> # CONFIG_SAMPLE_KOBJECT is not set
> # CONFIG_SAMPLE_KPROBES is not set
> # CONFIG_SAMPLE_HW_BREAKPOINT is not set
> # CONFIG_SAMPLE_KFIFO is not set
> # CONFIG_SAMPLE_KDB is not set
> # CONFIG_SAMPLE_LIVEPATCH is not set
> # CONFIG_SAMPLE_CONFIGFS is not set
> # CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
> # CONFIG_SAMPLE_WATCHDOG is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_EARLY_PRINTK_USB=y
> # CONFIG_X86_VERBOSE_BOOTUP is not set
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> # CONFIG_IOMMU_DEBUG is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> # CONFIG_IO_DELAY_0X80 is not set
> CONFIG_IO_DELAY_0XED=y
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> CONFIG_X86_DEBUG_FPU=y
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> # CONFIG_UNWINDER_ORC is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # CONFIG_UNWINDER_GUESS is not set
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_SIPHASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_LIVEPATCH is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_HMM is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=y
> CONFIG_MEMTEST=y
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

