Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93734A889C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352234AbiBCQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiBCQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:32:17 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF41C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:32:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c3so2590651pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AAlNoOG/UXb3s+dbBrGIB7Hd6NHMbUrRsNwW20O4pEk=;
        b=acWGGn70lPVBFT3J6TQClxfyXuabzViC8H0lyOE5fSY7nTTkoNNClfQ98ypsdq7mo5
         wu1of3b1QhCRfz4Gh1PWcAioT2d4ysPjsLO73258L6882zj0Z/Ppmres9y5YloxCVAeH
         xkwfprVgDDZCYNtB2qYwsjdHNTk39p+EfvaE6Qy5WLSaIwGSgfH++YKbzynJkxYZrxXP
         SBz2HgZmW9buRjTYHDnuyKjl3X7GQtSfIhTKi1F47es8SBPmx4TSaYtHWFrV3EH7mty/
         HB+I0v1unw10YjnBq/h9MtFIxZJjLRpQ/USOrSdK2MdXTAreXgugD1dOKKbvW6ptSEKX
         GYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AAlNoOG/UXb3s+dbBrGIB7Hd6NHMbUrRsNwW20O4pEk=;
        b=mdTXyXiDpC/KdZ/eRDiQeXoOLQbu2nL37QBSK2TBl9R3JD+ofvnGq/u+oWxZTTYm7y
         jD0ISdeTIauYiyL3zBpnVHs+1nD2791pBYJWYr+Ix5R9J9L8DWRZasq5+Q9/IBMoItQz
         Czbnca0sl4BNx186HXXGOQF+8Hc/wu3Rvm9pW6N/+uo5uNvYA4bmaN6szoRDvxfVXxVb
         H+NLyVnMjoHq6bgHea3AHfmjF9frhUccH1xUJhhZ7ATEFqWhKZAcw05HUcbI+pZ/AouW
         fP+fUx3kRGv8h0lTzvaDZEmiyOaAppucJnwUJqnK3TWX14imR/X/Clr77yBD0oGVg7mF
         zTFA==
X-Gm-Message-State: AOAM532MIKrKraV+IMJkYC7uHCrfim1XJBPeMU3a9lqX/TLWeh6wBrUH
        csfcVBuV5X5L4gxHI1/TZGbPekdDUXbDzkMAMME5s0k7
X-Google-Smtp-Source: ABdhPJxiFek5c/7XUAhY3PnJ0Wi58Wdq8aDAikbXD5gZ+d0eZBnsO6mcd+fN3S7B1BBXFNA/uAk/9AdjPDHwLbFyisQ=
X-Received: by 2002:a17:902:d50f:: with SMTP id b15mr2341360plg.54.1643905936833;
 Thu, 03 Feb 2022 08:32:16 -0800 (PST)
MIME-Version: 1.0
References: <BN7PR11MB26099D11661A8D4D968CC646FDA90@BN7PR11MB2609.namprd11.prod.outlook.com>
 <Yfv5OxhDdfLHETkt@smile.fi.intel.com>
In-Reply-To: <Yfv5OxhDdfLHETkt@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 3 Feb 2022 08:32:21 -0800
Message-ID: <CAAH8bW92QodQwDyrxxYeJYCiQzc9PpAoStDA7XSRzbPvgaYVxg@mail.gmail.com>
Subject: Re: Why not use kvcalloc in bitmap_zalloc/bitmap_alloc?
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianpeng,

I feel a bit out of context. Can you please describe your problem in
greater details?
If you already have a solution - can you attach it to your email?

If I understand correctly, your bitmap size exceeded the kmalloc()
limit. In that case,
I would suggest adding the bitmap_valloc() to the API.

Thanks,
Yury

On Thu, Feb 3, 2022 at 7:49 AM andriy.shevchenko@linux.intel.com
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 13, 2021 at 01:02:30AM +0000, Ma, Jianpeng wrote:
> > Hi Andy:
> >      Currently, I want to use bitmap_zalloc. But because I need large s=
pace(pages > 1024). So met the following message.
> >      From the code, I know bitmap_zalloc use kmalloc.  To fix this prob=
lem, I change the code use "kvcalloc(BITS_TO_LONGS(ns->pages_total), sizeof=
(unsigned long), GFP_KERNEL);"
> >      Because you introduced bitmap_zalloc, so I wanted to know why use =
kvcalloc in bitmap_zalloc?  Are there other considerations=EF=BC=9F
>
> +Cc: maintainer and mailing list
>
> > 2114 Jan 12 08:44:46 ceph kernel: [19770.801510] Modules linked in: tes=
t_nvm(E+) bcache(E) crc64 btrfs blake2b_generic xor zstd_compress raid6_pq =
ufs qnx4 hfsplus hfs minix ntfs msdos jfs intel_rapl_msr intel_rapl_common =
dax_pmem_compat  device_dax nd_pmem dax_pmem_core nd_btt skx_edac ipmi_ssif=
 x86_pkg_temp_thermal binfmt_misc intel_powerclamp coretemp crct10dif_pclmu=
l crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_help=
er nls_iso8859_1 raplxfs intel_cstate libcrc32c input_leds efi_pstore ast d=
rm_vram_helper drm_ttm_helper ttm drm_kms_helper cec drm i2c_algo_bit fb_sy=
s_fops syscopyarea sysfillrect sysimgblt switchtec lpc_ich mei_me mei ioatd=
ma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_pad acpi_power_=
meter mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables a=
utofs4 hid_generic usbhid hid ixgbe megaraid_sas xfrm_algo i40e dca mdio nv=
me nvme_core ahci libahci wmi [last unloaded: bcache]
> >  2115 Jan 12 08:44:46 ceph kernel: [19770.801568] CPU: 72 PID: 74351 Co=
mm: insmod Tainted: G            E     5.10.0-rc5+ #1
> >  2116 Jan 12 08:44:46 ceph kernel: [19770.801569] Hardware name: Intel =
Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/=
19/2019
> >  2117 Jan 12 08:44:46 ceph kernel: [19770.801572] RIP: 0010:__alloc_pag=
es_nodemask+0x297/0x330
> >  2118 Jan 12 08:44:46 ceph kernel: [19770.801574] Code: 08 44 89 f9 44 =
89 ea 4c 89 f6 e8 54 96 fc ff e9 4c ff ff ff e8 fa 17 fc ff 48 89 c7 e9 b8 =
fe ff ff 41 81 e4 00 20 00 00 75 a7 <0f> 0b eb a3 31 c0 e9 1b fe ff ff 65 4=
8 8b 04 25 c0 7b       01 00 8b 40
> >  2119 Jan 12 08:44:46 ceph kernel: [19770.801575] RSP: 0018:ffffb2afcd4=
e39d8 EFLAGS: 00010246
> >  2120 Jan 12 08:44:46 ceph kernel: [19770.801577] RAX: 0000000000000000=
 RBX: 0000000000000dc0 RCX: 0000000000000000
> >  2121 Jan 12 08:44:46 ceph kernel: [19770.801578] RDX: 0000000000000001=
 RSI: 000000000000000b RDI: 0000000000040dc0
> >  2122 Jan 12 08:44:46 ceph kernel: [19770.801579] RBP: ffffb2afcd4e3a30=
 R08: ffffffffb29c83c8 R09: 0000000000000000
> >  2123 Jan 12 08:44:46 ceph kernel: [19770.801580] R10: 0000000000000000=
 R11: fefefefefefefeff R12: 0000000000000000
> >  2124 Jan 12 08:44:46 ceph kernel: [19770.801581] R13: ffffffffb29c83c8=
 R14: 000000000000000b R15: 0000000000000000
> >  2125 Jan 12 08:44:46 ceph kernel: [19770.801583] FS:  00007f24f731b540=
(0000) GS:ffff89abc1800000(0000) knlGS:0000000000000000
> >  2126 Jan 12 08:44:46 ceph kernel: [19770.801584] CS:  0010 DS: 0000 ES=
: 0000 CR0: 0000000080050033
> >  2127 Jan 12 08:44:46 ceph kernel: [19770.801585] CR2: 00007f24f6e9f450=
 CR3: 00000040fc79e004 CR4: 00000000007706e0
> >  2128 Jan 12 08:44:46 ceph kernel: [19770.801586] DR0: 0000000000000000=
 DR1: 0000000000000000 DR2: 0000000000000000
> >  2129 Jan 12 08:44:46 ceph kernel: [19770.801587] DR3: 0000000000000000=
 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  2130 Jan 12 08:44:46 ceph kernel: [19770.801588] PKRU: 55555554
> >  2131 Jan 12 08:44:46 ceph kernel: [19770.801589] Call Trace:
> >  2132 Jan 12 08:44:46 ceph kernel: [19770.801598]  alloc_pages_current+=
0x87/0xe0
> >  2133 Jan 12 08:44:46 ceph kernel: [19770.801602]  kmalloc_order+0x2c/0=
x90
> >  2134 Jan 12 08:44:46 ceph kernel: [19770.801604]  kmalloc_order_trace+=
0x1d/0x80
> >  2135 Jan 12 08:44:46 ceph kernel: [19770.801608]  __kmalloc+0x271/0x30=
0
> >  2136 Jan 12 08:44:46 ceph kernel: [19770.801612]  bitmap_zalloc+0x1d/0=
x20
> >  2137 Jan 12 08:44:46 ceph kernel: [19770.801630]  bch_register_namespa=
ce+0x387/0x4e0 [bcache]
> >  2138 Jan 12 08:44:46 ceph kernel: [19770.801636]  ? __wake_up_common_l=
ock+0x8a/0xc0
> >  2139 Jan 12 08:44:46 ceph kernel: [19770.801639]  ? 0xffffffffc04e3000
> >  2140 Jan 12 08:44:46 ceph kernel: [19770.801641]  test_nvm_init+0x2f/0=
x1000 [test_nvm]
> >  2141 Jan 12 08:44:46 ceph kernel: [19770.801646]  ? netlink_broadcast_=
filtered+0x13e/0x480
> >  2142 Jan 12 08:44:46 ceph kernel: [19770.801649]  ? _cond_resched+0x19=
/0x30
> >  2143 Jan 12 08:44:46 ceph kernel: [19770.801651]  ? unmap_kernel_range=
_noflush+0x2e7/0x360
> >  2144 Jan 12 08:44:46 ceph kernel: [19770.801653]  ? free_pcp_prepare+0=
x80/0x160
> >  2145 Jan 12 08:44:46 ceph kernel: [19770.801654]  ? 0xffffffffc04e3000
> >  2146 Jan 12 08:44:46 ceph kernel: [19770.801658]  do_one_initcall+0x48=
/0x1d0
> >  2147 Jan 12 08:44:46 ceph kernel: [19770.801659]  ? _cond_resched+0x19=
/0x30
> >  2148 Jan 12 08:44:46 ceph kernel: [19770.801661]  ? kmem_cache_alloc_t=
race+0x153/0x2b0
> >  2149 Jan 12 08:44:46 ceph kernel: [19770.801664]  do_init_module+0x62/=
0x240
> >  2150 Jan 12 08:44:46 ceph kernel: [19770.801666]  load_module+0x28a0/0=
x2c50
> >  2151 Jan 12 08:44:46 ceph kernel: [19770.801672]  ? security_kernel_po=
st_read_file+0x5c/0x70
> >  2152 Jan 12 08:44:46 ceph kernel: [19770.801674]  __do_sys_finit_modul=
e+0xc2/0x120
> >  2153 Jan 12 08:44:46 ceph kernel: [19770.801676]  ? __do_sys_finit_mod=
ule+0xc2/0x120
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
