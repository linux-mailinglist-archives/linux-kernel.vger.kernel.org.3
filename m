Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63054A3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiFNBod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiFNBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DC6028733
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655171068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8tMWrimMGfLwBpAuu2lBsQ7zXDAkGHB6K2YkN+rto8=;
        b=O0+TXiaLeKwhnmfxSR5ab/10WgCUNmvk4c2qkC0o0JrJC+yH63EAfR4lqnYeUbFZkA+x09
        Uxwh9VPZfP/0HjBeNEpH4eIeREO4+Qw6TUhDISRVw43bp10RzukjLyUq+ECrQfEn3nfCU+
        2GADfYsX6N1r2DJ96Ne17qAsFDJ0eUs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-iX3BZVL7PdGfC7coEHCSTg-1; Mon, 13 Jun 2022 21:44:27 -0400
X-MC-Unique: iX3BZVL7PdGfC7coEHCSTg-1
Received: by mail-io1-f69.google.com with SMTP id r76-20020a6b2b4f000000b00669b75529e5so3573580ior.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8tMWrimMGfLwBpAuu2lBsQ7zXDAkGHB6K2YkN+rto8=;
        b=vVIhkq2Z5fyZC1LZRUImVuiooQYHxHNOY+jK05ylm5EyYyGQ+XB8sc+Xw49Mg8EVwW
         pcrFMEwgF+niYRtVVAszKGwoI+Af61uyxfKnKCsQMBMOp4SQaCZviolYxRZuefO8TorN
         g4iCUlsHbAHyVpmFoBwsFk6uYmC+nywl94x9jpdMDYOi6MJAVs7TtDU3VirifP9cVFZf
         S157uy6AZ/4o/YuVpHCHOPiGy4yTqRaK8oW6e3bTG+cb6Hjfq2P/tY0LqCHdG24DxtA1
         GHzE6PlwDz3FEHVEOYNXMQC5bY9oX4m6NyfzCo+8NxHa2vvEARPq9q5l1SewluTSVk7e
         qSxQ==
X-Gm-Message-State: AJIora+HqeZypKyOEIGPHnvGphtDla3Jr2P+Gxa2j27/ylrqTyy4aopn
        da6p3CxAcyF0Txb6Ys3N31L/lPstBCsOxfVzTh4BLjNQbFCiTaxEc1nrj/XMZBpcOJhF5BcOJQ+
        Fex+H5K+KyFUP7HaR47WZXQnCY0m3zviJ7o46+PWc
X-Received: by 2002:a92:cd8e:0:b0:2d3:e757:8df0 with SMTP id r14-20020a92cd8e000000b002d3e7578df0mr1532722ilb.190.1655171066694;
        Mon, 13 Jun 2022 18:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtaqA/8b56sYGyTFEUt5xb3zJsIm6CNge5IWbpRTP/JBVTQtlBIseF/tRabKJOi7RdPJ50E8K5f9G5Up9+FLQ=
X-Received: by 2002:a92:cd8e:0:b0:2d3:e757:8df0 with SMTP id
 r14-20020a92cd8e000000b002d3e7578df0mr1532710ilb.190.1655171066465; Mon, 13
 Jun 2022 18:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220505194658.246121-1-steve.wahl@hpe.com> <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor> <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
In-Reply-To: <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Mon, 13 Jun 2022 18:44:00 -0700
Message-ID: <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/6/14 04:57, Jerry Snitselaar wrote:
> > On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> >> To support up to 64 sockets with 10 DMAR units each (640), make the
> >> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> >> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> >> set.
> >>
> >> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> >> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> >> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> >> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> >> fails to boot properly.
> >>
> >> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> >> ---
> >>
> >> Note that we could not find a reason for connecting
> >> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> >> it seemed like the two would continue to match on earlier processors.
> >> There doesn't appear to be kernel code that assumes that the value of
> >> one is related to the other.
> >>
> >> v2: Make this value a config option, rather than a fixed constant.  The default
> >> values should match previous configuration except in the MAXSMP case.  Keeping the
> >> value at a power of two was requested by Kevin Tian.
> >>
> >>   drivers/iommu/intel/Kconfig | 6 ++++++
> >>   include/linux/dmar.h        | 6 +-----
> >>   2 files changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> >> index 247d0f2d5fdf..fdbda77ac21e 100644
> >> --- a/drivers/iommu/intel/Kconfig
> >> +++ b/drivers/iommu/intel/Kconfig
> >> @@ -9,6 +9,12 @@ config DMAR_PERF
> >>   config DMAR_DEBUG
> >>      bool
> >>
> >> +config DMAR_UNITS_SUPPORTED
> >> +    int "Number of DMA Remapping Units supported"
> >
> > Also, should there be a "depends on (X86 || IA64)" here?
>
> Do you have any compilation errors or warnings?
>
> Best regards,
> baolu
>

I think it is probably harmless since it doesn't get used elsewhere,
but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
being autogenerated into the configs for the non-x86 architectures we
build (aarch64, s390x, ppcle64).
We have files corresponding to the config options that it looks at,
and I had one for x86 and not the others so it noticed the
discrepancy.


> >
> >> +    default 1024 if MAXSMP
> >> +    default 128  if X86_64
> >> +    default 64
> >> +
> >>   config INTEL_IOMMU
> >>      bool "Support for Intel IOMMU using DMA Remapping Devices"
> >>      depends on PCI_MSI && ACPI && (X86 || IA64)
> >> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> >> index 45e903d84733..0c03c1845c23 100644
> >> --- a/include/linux/dmar.h
> >> +++ b/include/linux/dmar.h
> >> @@ -18,11 +18,7 @@
> >>
> >>   struct acpi_dmar_header;
> >>
> >> -#ifdef      CONFIG_X86
> >> -# define    DMAR_UNITS_SUPPORTED    MAX_IO_APICS
> >> -#else
> >> -# define    DMAR_UNITS_SUPPORTED    64
> >> -#endif
> >> +#define     DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
> >>
> >>   /* DMAR Flags */
> >>   #define DMAR_INTR_REMAP            0x1
> >> --
> >> 2.26.2
> >>
> >
>

