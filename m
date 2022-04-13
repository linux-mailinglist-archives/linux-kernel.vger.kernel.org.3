Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80104FFD01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiDMRni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiDMRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:43:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694F6B084;
        Wed, 13 Apr 2022 10:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1069B82694;
        Wed, 13 Apr 2022 17:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F33C385A8;
        Wed, 13 Apr 2022 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871672;
        bh=cfUI0fRVbB85CX8BoA03xkcHWpX1gvpU05tX4fEcWUc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vOPS8P9Qz0Wq87ZkY3ULFxxQA+Ph6PngOO+gd4pzqBFW8SYsuZIs+abB8EBcxJoLZ
         juZ+eFgFbmkCuRN0YLiHbjgKNYqc4bWsC+6ZLADCTYjnEFFZf8pQiBeGN91Id2cuYg
         DjUAguDwWs3CC8UYB6RSf0OV8hLrq7EUqW/AqtD70CErIMJUoMjMTzXnhy8L2XOCNt
         5OCYXodhn9Eyl33R39/aqcJWqnhUELYZNf1opO8k6W29q4SXghDTiGYII7hNcTXmun
         yWKasvprlGBQ2LIMVOOkgfEeWOy1zViDB7pgDL8v7Rms2pNVcgmFofFGlIKv7Hd7by
         7ckaj+4O1FOfg==
Received: by mail-oi1-f177.google.com with SMTP id e4so2844449oif.2;
        Wed, 13 Apr 2022 10:41:12 -0700 (PDT)
X-Gm-Message-State: AOAM533NeHAySlv2W69DHryG3YzpAlTAxRPxwXBiWV4XAlHu5+eeOh1Q
        i4azdtoo0Oz3j2aPiND33+3cg0OWmUX0IP5rrRg=
X-Google-Smtp-Source: ABdhPJx04NiMLTHyzd/Y8PfIk697qFilrwahli2EH9ol4LvWtk9SoGz+8yR1f1N8gvoUShWthsgBA7FJSTCiRynRhbo=
X-Received: by 2002:a05:6808:1513:b0:2fa:7a40:c720 with SMTP id
 u19-20020a056808151300b002fa7a40c720mr970327oiw.126.1649871671335; Wed, 13
 Apr 2022 10:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220407105120.1280-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20220407105120.1280-1-lorenzo.pieralisi@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:40:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEx1JFexVZvd=p3+ra1A7050VfWaZg1uuk-_nFDns4Z4Q@mail.gmail.com>
Message-ID: <CAMj1kXEx1JFexVZvd=p3+ra1A7050VfWaZg1uuk-_nFDns4Z4Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: osl: Fix BERT error region memory mapping
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Aristeu Rozanski <aris@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 12:51, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Currently the sysfs interface maps the BERT error region as "memory"
> (through acpi_os_map_memory()) in order to copy the error records into
> memory buffers through memory operations (eg memory_read_from_buffer()).
>
> The OS system cannot detect whether the BERT error region is part of
> system RAM or it is "device memory" (eg BMC memory) and therefore it
> cannot detect which memory attributes the bus to memory support (and
> corresponding kernel mapping, unless firmware provides the required
> information).
>
> The acpi_os_map_memory() arch backend implementation determines the
> mapping attributes. On arm64, if the BERT error region is not present in
> the EFI memory map, the error region is mapped as device-nGnRnE; this
> triggers alignment faults since memcpy unaligned accesses are not
> allowed in device-nGnRnE regions.
>
> The ACPI sysfs code cannot therefore map by default the BERT error
> region with memory semantics but should use a safer default.
>
> Change the sysfs code to map the BERT error region as MMIO (through
> acpi_os_map_iomem()) and use the memcpy_fromio() interface to read the
> error region into the kernel buffer.
>
> Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/acpi/sysfs.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a4b638bea6f1..cc2fe0618178 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -415,19 +415,30 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
>                               loff_t offset, size_t count)
>  {
>         struct acpi_data_attr *data_attr;
> -       void *base;
> -       ssize_t rc;
> +       void __iomem *base;
> +       ssize_t size;
>
>         data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
> +       size = data_attr->attr.size;
> +
> +       if (offset < 0)
> +               return -EINVAL;
> +
> +       if (offset >= size)
> +               return 0;
>
> -       base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
> +       if (count > size - offset)
> +               count = size - offset;
> +
> +       base = acpi_os_map_iomem(data_attr->addr, size);
>         if (!base)
>                 return -ENOMEM;
> -       rc = memory_read_from_buffer(buf, count, &offset, base,
> -                                    data_attr->attr.size);
> -       acpi_os_unmap_memory(base, data_attr->attr.size);
>
> -       return rc;
> +       memcpy_fromio(buf, base + offset, count);
> +
> +       acpi_os_unmap_iomem(base, size);
> +
> +       return count;
>  }
>
>  static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
> --
> 2.31.0
>
