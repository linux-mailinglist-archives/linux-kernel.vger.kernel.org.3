Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B156391E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiGAS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGAS0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:26:12 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA87421262
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:26:10 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 261IPrRW3977630
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 1 Jul 2022 11:25:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 261IPrRW3977630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022060401; t=1656699953;
        bh=yu2boS/JWh71nQvIOYO8daiwUPo4OM9QG0VMDDS0hmo=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=w6rxpZ3ul9KdRwiZs/YA7RmQpAPRIpHOIvO3/xCZw6sB63DR0l/kmqBUdG3/w5VnY
         4RbMlkfY+r/Qy9VO2Mz1vwc2i2/vZ0OfEJyYRysX1Sdrq947juCqYswRm45K8Qbm13
         9al/uWjrv2HL2waGwFPwN/w4nLzvXQ/F3/TX7T3TfSkM0jguazdlH7r2I/C96WkGvs
         Fjbqr/iFo81tUeIRiLfv5/+74kyKOdskhYeCVsU6hrCoJezWwuGMA1bqXrzF3EvRKc
         NxZgWrav+L4ADjpyIzfTikqdcBT8Pbeue03FY3+QLRJv560u59k4bRGieDfHYv6vAC
         g+elEk1NnthOA==
Date:   Fri, 01 Jul 2022 11:25:49 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5=5D_x86/setup=3A_Allow_pas?= =?US-ASCII?Q?sing_RNG_seeds_via_e820_setup_table?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220701175808.188604-1-Jason@zx2c4.com>
References: <20220630133106.35970-1-Jason@zx2c4.com> <20220701175808.188604-1-Jason@zx2c4.com>
Message-ID: <05A1E6F8-432A-4D68-9CF8-C77A3FC68584@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 1, 2022 10:58:08 AM PDT, "Jason A=2E Donenfeld" <Jason@zx2c4=2Ecom>=
 wrote:
>Currently the only way x86 can get an early boot RNG seed is via EFI,
>which is generally always used now for physical machines, but is very
>rarely used in VMs, especially VMs that are optimized for starting
>"instantaneously", such as Firecracker's MicroVM=2E For tiny fast booting
>VMs, EFI is not something you generally need or want=2E
>
>Rather, here we want the ability for the image loader or firmware to
>pass a single random seed, exactly as device tree platforms do with the
>"rng-seed" property=2E Additionally, this is something that bootloaders
>can append, with their own seed file management, which is something
>every other major OS ecosystem has that we do not (yet)=2E
>
>This patch adds SETUP_RNG_SEED, similar to the other seven SETUP_*
>entries that are parsed from the e820 setup table=2E It also takes care t=
o
>zero out the seed immediately after using, in order to retain forward
>secrecy=2E This all takes about 7 trivial lines of code=2E
>
>Then, on kexec_file_load(), a new fresh seed is generated and passed to
>the next kernel, just as is done on device tree architectures when
>using kexec=2E And, importantly, I've tested that QEMU is able to properl=
y
>pass SETUP_RNG_SEED as well, making this work for every step of the way=
=2E
>This code too is pretty straight forward=2E
>
>Together these measures ensure that VMs and nested kexec()'d kernels
>always are getting a proper boot time RNG seed at the earliest possible
>stage from their parents:
>
>   - Host [already has strongly initialized RNG]
>     - QEMU [passes fresh seed in e820 SETUP_RNG_SEED field]
>       - Linux [uses parent's seed and gathers entropy of its own]
>         - kexec [passes this in e820 SETUP_RNG_SEED field]
>           - Linux [uses parent's seed and gathers entropy of its own]
>             - kexec [passes this in e820 SETUP_RNG_SEED field]
>               - Linux [uses parent's seed and gathers entropy of its own=
]
>                 - kexec [passes this in e820 SETUP_RNG_SEED field]
>		   - =2E=2E=2E
>
>I've verified in several scenarios that this works quite well from a
>host kernel to QEMU and down inwards, mixing and matching loaders, with
>every layer providing a seed to the next=2E
>
>Signed-off-by: Jason A=2E Donenfeld <Jason@zx2c4=2Ecom>
>---
>Another day, another patch revision=2E If you haven't noticed, I'm quite
>determined to make this work well and robustly=2E At some point I'd of
>course appreciate some review=2E Either way, I've got every intention of
>plugging away at this until it's perfect=2E
>
>Changes v4->v5:
>- Populate field when loading bzimages for kexec, just like device tree
>  platforms do=2E
>Changes v3->v4:
>- Zero out data after using, for forward secrecy=2E
>Changes v2->v3:
>- Actually memmap the right area with the random bytes in it=2E This
>  worked before because of page sizes, but the code wasn't right=2E Now
>  it's right=2E
>Changes v1->v2:
>- Fix small typo of data_len -> data->len=2E
>
> arch/x86/include/uapi/asm/bootparam=2Eh |  1 +
> arch/x86/kernel/kexec-bzimage64=2Ec     | 36 ++++++++++++++++++++++++---
> arch/x86/kernel/setup=2Ec               |  8 ++++++
> 3 files changed, 42 insertions(+), 3 deletions(-)
>
>diff --git a/arch/x86/include/uapi/asm/bootparam=2Eh b/arch/x86/include/u=
api/asm/bootparam=2Eh
>index bea5cdcdf532=2E=2Ea60676b8d1d4 100644
>--- a/arch/x86/include/uapi/asm/bootparam=2Eh
>+++ b/arch/x86/include/uapi/asm/bootparam=2Eh
>@@ -11,6 +11,7 @@
> #define SETUP_APPLE_PROPERTIES		5
> #define SETUP_JAILHOUSE			6
> #define SETUP_CC_BLOB			7
>+#define SETUP_RNG_SEED			8
>=20
> #define SETUP_INDIRECT			(1<<31)
>=20
>diff --git a/arch/x86/kernel/kexec-bzimage64=2Ec b/arch/x86/kernel/kexec-=
bzimage64=2Ec
>index 170d0fd68b1f=2E=2E13b2c55ebbf0 100644
>--- a/arch/x86/kernel/kexec-bzimage64=2Ec
>+++ b/arch/x86/kernel/kexec-bzimage64=2Ec
>@@ -18,6 +18,7 @@
> #include <linux/mm=2Eh>
> #include <linux/efi=2Eh>
> #include <linux/verification=2Eh>
>+#include <linux/random=2Eh>
>=20
> #include <asm/bootparam=2Eh>
> #include <asm/setup=2Eh>
>@@ -110,6 +111,27 @@ static int setup_e820_entries(struct boot_params *pa=
rams)
> 	return 0;
> }
>=20
>+enum { RNG_SEED_LENGTH =3D 32 };
>+
>+static void
>+add_rng_seed_setup_data(struct boot_params *params,
>+			unsigned long params_load_addr,
>+			unsigned int rng_seed_setup_data_offset)
>+{
>+	struct setup_data *sd =3D (void *)params + rng_seed_setup_data_offset;
>+	unsigned long setup_data_phys;
>+
>+	if (!rng_is_initialized())
>+		return;
>+
>+	sd->type =3D SETUP_RNG_SEED;
>+	sd->len =3D RNG_SEED_LENGTH;
>+	get_random_bytes(sd->data, RNG_SEED_LENGTH);
>+	setup_data_phys =3D params_load_addr + rng_seed_setup_data_offset;
>+	sd->next =3D params->hdr=2Esetup_data;
>+	params->hdr=2Esetup_data =3D setup_data_phys;
>+}
>+
> #ifdef CONFIG_EFI
> static int setup_efi_info_memmap(struct boot_params *params,
> 				  unsigned long params_load_addr,
>@@ -190,7 +212,8 @@ static int
> setup_boot_parameters(struct kimage *image, struct boot_params *params,
> 		      unsigned long params_load_addr,
> 		      unsigned int efi_map_offset, unsigned int efi_map_sz,
>-		      unsigned int efi_setup_data_offset)
>+		      unsigned int efi_setup_data_offset,
>+		      unsigned int rng_seed_setup_data_offset)
> {
> 	unsigned int nr_e820_entries;
> 	unsigned long long mem_k, start, end;
>@@ -242,6 +265,8 @@ setup_boot_parameters(struct kimage *image, struct bo=
ot_params *params,
> 		}
> 	}
>=20
>+	add_rng_seed_setup_data(params, params_load_addr,
>+				rng_seed_setup_data_offset);
> #ifdef CONFIG_EFI
> 	/* Setup EFI state */
> 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>@@ -337,6 +362,7 @@ static void *bzImage64_load(struct kimage *image, cha=
r *kernel,
> 	void *stack;
> 	unsigned int setup_hdr_offset =3D offsetof(struct boot_params, hdr);
> 	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
>+	unsigned int rng_seed_setup_data_offset;
> 	struct kexec_buf kbuf =3D { =2Eimage =3D image, =2Ebuf_max =3D ULONG_MA=
X,
> 				  =2Etop_down =3D true };
> 	struct kexec_buf pbuf =3D { =2Eimage =3D image, =2Ebuf_min =3D MIN_PURG=
ATORY_ADDR,
>@@ -401,13 +427,16 @@ static void *bzImage64_load(struct kimage *image, c=
har *kernel,
> 	params_cmdline_sz =3D ALIGN(params_cmdline_sz, 16);
> 	kbuf=2Ebufsz =3D params_cmdline_sz + ALIGN(efi_map_sz, 16) +
> 				sizeof(struct setup_data) +
>-				sizeof(struct efi_setup_data);
>+				sizeof(struct efi_setup_data) +
>+				sizeof(struct setup_data) +
>+				RNG_SEED_LENGTH;
>=20
> 	params =3D kzalloc(kbuf=2Ebufsz, GFP_KERNEL);
> 	if (!params)
> 		return ERR_PTR(-ENOMEM);
> 	efi_map_offset =3D params_cmdline_sz;
> 	efi_setup_data_offset =3D efi_map_offset + ALIGN(efi_map_sz, 16);
>+	rng_seed_setup_data_offset =3D efi_setup_data_offset + sizeof(struct ef=
i_setup_data);
>=20
> 	/* Copy setup header onto bootparams=2E Documentation/x86/boot=2Erst */
> 	setup_header_size =3D 0x0202 + kernel[0x0201] - setup_hdr_offset;
>@@ -490,7 +519,8 @@ static void *bzImage64_load(struct kimage *image, cha=
r *kernel,
>=20
> 	ret =3D setup_boot_parameters(image, params, bootparam_load_addr,
> 				    efi_map_offset, efi_map_sz,
>-				    efi_setup_data_offset);
>+				    efi_setup_data_offset,
>+				    rng_seed_setup_data_offset);
> 	if (ret)
> 		goto out_free_params;
>=20
>diff --git a/arch/x86/kernel/setup=2Ec b/arch/x86/kernel/setup=2Ec
>index bd6c6fd373ae=2E=2E6c807a4ae141 100644
>--- a/arch/x86/kernel/setup=2Ec
>+++ b/arch/x86/kernel/setup=2Ec
>@@ -23,6 +23,7 @@
> #include <linux/usb/xhci-dbgp=2Eh>
> #include <linux/static_call=2Eh>
> #include <linux/swiotlb=2Eh>
>+#include <linux/random=2Eh>
>=20
> #include <uapi/linux/mount=2Eh>
>=20
>@@ -355,6 +356,13 @@ static void __init parse_setup_data(void)
> 		case SETUP_EFI:
> 			parse_efi_setup(pa_data, data_len);
> 			break;
>+		case SETUP_RNG_SEED:
>+			data =3D early_memremap(pa_data, data_len);
>+			add_bootloader_randomness(data->data, data->len);
>+			memzero_explicit(data->data, data->len);
>+			memzero_explicit(&data->len, sizeof(data->len));
>+			early_memunmap(data, data_len);
>+			break;
> 		default:
> 			break;
> 		}

Please correct the incredibly confusing title of this patch=2E

The setup_data linked list has nothing to do with memory types (e820), exc=
ept that memory types is one kind of data that can be passed on by this mec=
hanism=2E This title makes it sound like you are passing random data in as =
a memory type, which could make some bizarre sense if it were, say, some ki=
nd of ring buffer preconfigured by the BIOS/VMM/boot loader to be continual=
ly overwritten with new random data=2E

