Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6656CB1A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiGISl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGISly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 14:41:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4819237190
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 11:41:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk26so2202084wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afz0HFCyaKK/n0V2ad4ArLhaeQl00mG1v6qHamoozFM=;
        b=qVPI4o30sQoaP990Eq4HC7iN16X9vxdrJid76VUq/muhA+zQuWbfRAgeD9YsooQerS
         oZzyn7kdc1Ft59nbvy+HLy09c/Fh0mO1RtQrupE/XmJ13wvxFN5wQdyKLoeJviLZwTI7
         O+7aZ6PoUufXZkntdg0eQENSjBkyrdm7cJ2R6H91qaHjrMH2mNJWa9nWg8aBNLAGhLaq
         vchWj1Bx7QqcBJKysT+bpQa/Bq+HVGURjBMDh0XKNo+9rHrTvaagoeToWiS3ExTVc8dF
         JGA3w8jzDEEmQAdfH7yL9RBZkX8fcZWdJFk5AtW4hB32nc6BUxEhCx0Zu1BL+WZCMegh
         H9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afz0HFCyaKK/n0V2ad4ArLhaeQl00mG1v6qHamoozFM=;
        b=NcKvGcUbvMvSesvPyQS9pgmm8s5McEuw6AcIRJF6rCw8Yr+muwfWkDmYta7YsBXorq
         P77vkdXltBxYmLJUQqBI9LF1QtZDNND9SdmN8JUC/hW3wPkULXheDmCZ0QQd5wYvyk6R
         FI6yDOTzyDuyNSaWlkpZs9p3kdl9CCTIAdKpWNkncb3Bw0UKVwWznWDZQDracgdXLy61
         HWtzJhwVOm3htbXHnCkP7VPidxXzsIxm1m8QrYy9wwmlGORzi3CElphnmVuGCIjkr80X
         6Zsayq7B8+OuPqCAIGAgULiFiZ2wyQui0h9jPNNrFgJR6YEHIoiyA+wS4gPOa8XElM3H
         /U7g==
X-Gm-Message-State: AJIora/3WIVGNvV5ikzgsqxAi/SFwFKdoyIGSfnd4nAvaSWBDriJfvWr
        v1gv1umDbEZDWQs/PuhwCCNORz1JRcs=
X-Google-Smtp-Source: AGRyM1uWyUvU0+0n9AwqdWONf56SsxzB0N2QsG5ipwMtgssM95HDxMgnQY7m36n5baEki5JcGQN/Pw==
X-Received: by 2002:a5d:5952:0:b0:21d:7c9b:e444 with SMTP id e18-20020a5d5952000000b0021d7c9be444mr9543428wri.75.1657392111225;
        Sat, 09 Jul 2022 11:41:51 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id p129-20020a1c2987000000b003a17ab4e7c8sm5652149wmp.39.2022.07.09.11.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 11:41:49 -0700 (PDT)
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
        boris.ostrovsky@oracle.com, ira.weiny@intel.com
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Date:   Sat, 09 Jul 2022 20:41:47 +0200
Message-ID: <4427532.LvFx2qVVIh@opensuse>
In-Reply-To: <3bd962c3-7dc6-6dd0-6d0d-2e4667a69a8a@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com> <2843978.e9J7NaK4W3@opensuse> <3bd962c3-7dc6-6dd0-6d0d-2e4667a69a8a@oracle.com>
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

On venerd=C3=AC 8 luglio 2022 23:07:20 CEST Eric DeVolder wrote:
>=20
> On 7/8/22 14:38, Fabio M. De Francesco wrote:
> > On marted=C3=AC 14 giugno 2022 00:42:40 CEST Eric DeVolder wrote:
> >> For x86_64, when CPU or memory is hot un/plugged, the crash
> >> elfcorehdr, which describes the CPUs and memory in the system,
> >> must also be updated.
> >>
> >> When loading the crash kernel via kexec_load or kexec_file_load,
> >> the elfcorehdr is identified at run time in
> >> crash_core:handle_hotplug_event().
> >>
> >> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> >> generated from the available CPUs and memory. The new elfcorehdr
> >> is prepared into a buffer, and then installed over the top of
> >> the existing elfcorehdr.
> >>
> >> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> >> the need to update purgatory due to the change in elfcorehdr was
> >> eliminated.  As a result, no changes to purgatory or boot_params
> >> (as the elfcorehdr=3D kernel command line parameter pointer
> >> remains unchanged and correct) are needed, just elfcorehdr.
> >>
> >> To accommodate a growing number of resources via hotplug, the
> >> elfcorehdr segment must be sufficiently large enough to accommodate
> >> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
> >>
> >> With this change, crash hotplug for kexec_file_load syscall
> >> is supported. The kexec_load is also supported, but also
> >> requires a corresponding change to userspace kexec-tools.
> >>
> >> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> >> ---
> >>   arch/x86/Kconfig        |  11 ++++
> >>   arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++
++
> >>   2 files changed, 127 insertions(+)
> >>
> >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >> index 762a0b6ab8b6..e9eecff3b97d 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -2082,6 +2082,17 @@ config CRASH_DUMP
> >>   	  (CONFIG_RELOCATABLE=3Dy).
> >>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
> >>  =20
> >> +config CRASH_MAX_MEMORY_RANGES
> >> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU ||
> > MEMORY_HOTPLUG)
> >> +	int
> >> +	default 32768
> >> +	help
> >> +	  For the kexec_file_load path, specify the maximum number of
> >> +	  memory regions, eg. as represented by the 'System RAM' entries
> >> +	  in /proc/iomem, that the elfcorehdr buffer/segment can
> > accommodate.
> >> +	  This value is combined with NR_CPUS and multiplied by
> > Elf64_Phdr
> >> +	  size to determine the final buffer size.
> >> +
> >>   config KEXEC_JUMP
> >>   	bool "kexec jump"
> >>   	depends on KEXEC && HIBERNATION
> >> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> >> index 9db41cce8d97..b9cdf7a0d868 100644
> >> --- a/arch/x86/kernel/crash.c
> >> +++ b/arch/x86/kernel/crash.c
> >> @@ -25,6 +25,7 @@
> >>   #include <linux/slab.h>
> >>   #include <linux/vmalloc.h>
> >>   #include <linux/memblock.h>
> >> +#include <linux/highmem.h>
> >>  =20
> >>   #include <asm/processor.h>
> >>   #include <asm/hardirq.h>
> >> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
> >>   	image->elf_headers =3D kbuf.buffer;
> >>   	image->elf_headers_sz =3D kbuf.bufsz;
> >>  =20
> >> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> >> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> >> +	kbuf.memsz =3D (CONFIG_NR_CPUS_DEFAULT +
> > CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
> >> +	/* For marking as usable to crash kernel */
> >> +	image->elf_headers_sz =3D kbuf.memsz;
> >> +	/* Record the index of the elfcorehdr segment */
> >> +	image->elfcorehdr_index =3D image->nr_segments;
> >> +	image->elfcorehdr_index_valid =3D true;
> >> +#else
> >>   	kbuf.memsz =3D kbuf.bufsz;
> >> +#endif
> >>   	kbuf.buf_align =3D ELF_CORE_HEADER_ALIGN;
> >>   	kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >>   	ret =3D kexec_add_buffer(&kbuf);
> >> @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
> >>   	return ret;
> >>   }
> >>   #endif /* CONFIG_KEXEC_FILE */
> >> +
> >> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> >> +int crash_hotplug_support(void) { return 1; }
> >> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> >> +{
> >> +	/*
> >> +	 * NOTE: The addresses and sizes passed to this routine have
> >> +	 * already been fully aligned on page boundaries. There is no
> >> +	 * need for massaging the address or size.
> >> +	 */
> >> +	void *ptr =3D NULL;
> >> +
> >> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write
> > access */
> >> +	if (size > 0) {
> >> +		struct page *page =3D pfn_to_page(paddr >> PAGE_SHIFT);
> >> +
> >> +		ptr =3D kmap(page);
> >> +	}
> >=20
> > kmap_local_page() is preferred over kmap() which should be avoided in=20
new
> > code (please take a look at highmem.rst which I recently updated).
> >=20
> > Can you please check if you can easily avoid using kmap()? Otherwise,=20
this
> > code will be added to my (long) queue and changed one day or the other=
=20
:-)
> >=20
> > Thanks,
> >=20
> > Fabio
> Fabio,
> I converted this to kmap_local_page()!
> Thanks!
> eric
>=20
> >=20
Eric,

Thanks for the very quick reaction to my suggestion.

=46abio


