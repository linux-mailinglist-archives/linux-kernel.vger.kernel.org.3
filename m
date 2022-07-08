Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD356C22D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbiGHTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239951AbiGHTih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:38:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F8410FC2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:38:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v14so31825499wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJI9Ehsx1DLhgOOTZFpXBygwtMTKmpvBdj5nkzZLTLY=;
        b=a2wrVl6zvNzyjpS74p8fzHi85oQNxgg+Gr9JWGaZuND/BBwhnekF1N+0OasRjtxTD5
         rqunmOW1D28Sm3WZ9CgtmzKbYnjI9rP6yEDVsvbMiORvYYM4zbJPUsA3MiLeFJZg0C3R
         zyQ51hCYa31tPaMajBYHJUyGrtuUnKiPRIKg4SzHNGQXtbAqN9VzK0HUv9oZLOWG4WeO
         X+s2m/Fg1dY6vFl5OtfPmyXLceIkhmXF9sWN5lv96aTryBfYaCMNNbFxiSDy9YWcRVOM
         nwgPNp+zWeVAJerlfW0a0GpoqyoJ39OoeH/gVKB8hNU0pV7E0aTrdzgflmYE+vvpYx20
         lhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJI9Ehsx1DLhgOOTZFpXBygwtMTKmpvBdj5nkzZLTLY=;
        b=awfx/2IT+tOOVgvc+xb9dq59PWDFt8z6pwzzekUMWFffLovHrafV2ksZYC87jR1uCr
         3tfSqe9oM02QDrFy9tGhjctkoP2oKyBhB1RrcUBaU6kpRzlRFAw5Bcr+v104vm/keJus
         wJSyWBNhuCdNNfC4s+EGGMNdp7uxAJy+yCDuA5NBmFBbSGvCaDNVzZsWg6ckCf1I+bsk
         RP2rPAmsffs6kl7YPtLaIRqd6WHovZwo4L64uxj+OUXAldmhdmT7E/naPhGvWrV5SinI
         nrlnD6lKwh/6C+yOyj8xhWPjptbtb83sIr7z7Mc4b1kOZuOZzpDipkxKylDEC1tYPitf
         K0Vg==
X-Gm-Message-State: AJIora9mJTcIiAE1KxtI2to0CWXs/eyCRvVfyTlRrE1ypOKGFtftIyjf
        N88/r2qm1uLhjf2S9+yiL2VG0639cB0G/g==
X-Google-Smtp-Source: AGRyM1v3slCHWDgrE0apW0q146paDpoAX8/kc8ApkFjKpoSjFradJsGClHiO0X094PeVXwUAjolvgg==
X-Received: by 2002:adf:e7c9:0:b0:21d:8716:e08d with SMTP id e9-20020adfe7c9000000b0021d8716e08dmr4822062wrn.328.1657309112010;
        Fri, 08 Jul 2022 12:38:32 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id w13-20020adff9cd000000b0021d8b1656dfsm3973684wrr.93.2022.07.08.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:38:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        Eric DeVolder <eric.devolder@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Date:   Fri, 08 Jul 2022 21:38:27 +0200
Message-ID: <2843978.e9J7NaK4W3@opensuse>
In-Reply-To: <20220613224240.79400-8-eric.devolder@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com> <20220613224240.79400-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 14 giugno 2022 00:42:40 CEST Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
>=20
> When loading the crash kernel via kexec_load or kexec_file_load,
> the elfcorehdr is identified at run time in
> crash_core:handle_hotplug_event().
>=20
> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, and then installed over the top of
> the existing elfcorehdr.
>=20
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr=3D kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
>=20
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>=20
> With this change, crash hotplug for kexec_file_load syscall
> is supported. The kexec_load is also supported, but also
> requires a corresponding change to userspace kexec-tools.
>=20
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/Kconfig        |  11 ++++
>  arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 762a0b6ab8b6..e9eecff3b97d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2082,6 +2082,17 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=3Dy).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
> =20
> +config CRASH_MAX_MEMORY_RANGES
> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU ||=20
MEMORY_HOTPLUG)
> +	int
> +	default 32768
> +	help
> +	  For the kexec_file_load path, specify the maximum number of
> +	  memory regions, eg. as represented by the 'System RAM' entries
> +	  in /proc/iomem, that the elfcorehdr buffer/segment can=20
accommodate.
> +	  This value is combined with NR_CPUS and multiplied by=20
Elf64_Phdr
> +	  size to determine the final buffer size.
> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9db41cce8d97..b9cdf7a0d868 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/memblock.h>
> +#include <linux/highmem.h>
> =20
>  #include <asm/processor.h>
>  #include <asm/hardirq.h>
> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers =3D kbuf.buffer;
>  	image->elf_headers_sz =3D kbuf.bufsz;
> =20
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz =3D (CONFIG_NR_CPUS_DEFAULT +=20
CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
> +	/* For marking as usable to crash kernel */
> +	image->elf_headers_sz =3D kbuf.memsz;
> +	/* Record the index of the elfcorehdr segment */
> +	image->elfcorehdr_index =3D image->nr_segments;
> +	image->elfcorehdr_index_valid =3D true;
> +#else
>  	kbuf.memsz =3D kbuf.bufsz;
> +#endif
>  	kbuf.buf_align =3D ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
>  	ret =3D kexec_add_buffer(&kbuf);
> @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +int crash_hotplug_support(void) { return 1; }
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	/*
> +	 * NOTE: The addresses and sizes passed to this routine have
> +	 * already been fully aligned on page boundaries. There is no
> +	 * need for massaging the address or size.
> +	 */
> +	void *ptr =3D NULL;
> +
> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write=20
access */
> +	if (size > 0) {
> +		struct page *page =3D pfn_to_page(paddr >> PAGE_SHIFT);
> +
> +		ptr =3D kmap(page);
> +	}

kmap_local_page() is preferred over kmap() which should be avoided in new=20
code (please take a look at highmem.rst which I recently updated).

Can you please check if you can easily avoid using kmap()? Otherwise, this=
=20
code will be added to my (long) queue and changed one day or the other :-)

Thanks,

=46abio

> +
> +	return ptr;
> +}
> +
> +void arch_unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap(*ptr);
> +		*ptr =3D NULL;
> +	}
> +}
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + * @hp_action: the hot un/plug action being handled
> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
> + *
> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
> + * is passed to the crash kernel via the elfcorehdr=3D parameter)
> + * must be updated with the new list of CPUs and memories. The new
> + * elfcorehdr is prepared in a kernel buffer, and then it is
> + * written on top of the existing/old elfcorehdr.
> + *
> + * For hotplug changes to elfcorehdr to work, two conditions are
> + * needed:
> + * First, the segment containing the elfcorehdr must be large enough
> + * to permit a growing number of resources. See the
> + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
> + * Second, purgatory must explicitly exclude the elfcorehdr from the
> + * list of segments it checks (since the elfcorehdr changes and thus
> + * would require an update to purgatory itself to update the digest).
> + *
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +	unsigned int hp_action, unsigned int cpu)
> +{
> +	struct kexec_segment *ksegment;
> +	unsigned char *ptr =3D NULL;
> +	unsigned long elfsz =3D 0;
> +	void *elfbuf =3D NULL;
> +	unsigned long mem, memsz;
> +
> +	/*
> +	 * Elfcorehdr_index_valid checked in=20
crash_core:handle_hotplug_event()
> +	 */
> +	ksegment =3D &image->segment[image->elfcorehdr_index];
> +	mem =3D ksegment->mem;
> +	memsz =3D ksegment->memsz;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
> +		pr_err("crash hp: unable to prepare elfcore headers");
> +		goto out;
> +	}
> +	if (elfsz > memsz) {
> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz=20
%lu",
> +			elfsz, memsz);
> +		goto out;
> +	}
> +
> +	/*
> +	 * At this point, we are all but assured of success.
> +	 * Copy new elfcorehdr into destination.
> +	 */
> +	ptr =3D arch_map_crash_pages(mem, memsz);
> +	if (ptr) {
> +		/*
> +		 * Temporarily invalidate the crash image while the
> +		 * elfcorehdr is updated.
> +		 */
> +		xchg(&kexec_crash_image, NULL);
> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
> +		xchg(&kexec_crash_image, image);
> +	}
> +	arch_unmap_crash_pages((void **)&ptr);
> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
> +
> +out:
> +	if (elfbuf)
> +		vfree(elfbuf);
> +}
> +#endif
> --=20
> 2.31.1
>=20
>=20




