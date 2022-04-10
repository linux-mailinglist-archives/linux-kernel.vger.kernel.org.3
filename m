Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374E4FAD99
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiDJLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiDJLCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 07:02:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0381EDF42
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 04:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84C5EB80CB7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 11:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A43C385AC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649588411;
        bh=HG3EYnk4+K3Kn+2yIOOHTNYQ+C3e3gphCbEHyUI4A8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJzXu+qjQoUtc9E7t328XJzQ+z0+8iv6EAdxfIzRBlfsIMRj6xhBbRctc90CQHQnG
         KBt7JdJ6ftT2w8aaG1O6yNiF4nL1AjdPuYxPExn42yUfWjatEeLzP6DFyBsKSY6/m3
         ztpCVELnpiXitCA4aUo8UQzYrLhf+aGayTRJBoVT6JwkMRudEHqAT5mbGZQYsPvMUA
         gV8RfvEIBZ3WMMSVeNLdOPg/9DNNwklY9Tt1Q3DG6IoUIEz2DW+wwmYF47dX29+wIS
         Y3yjPVekBcEDDZK3DSsxCORsxH5gxGK5wHQUnOGbxN+dY8+zCHuMd58R8U5gjIJd/v
         jqpIJ+9sQsHKw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ebf4b91212so39271487b3.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 04:00:10 -0700 (PDT)
X-Gm-Message-State: AOAM532G1VX7GJz3ip5CmwvVhfTlWLyMBbn01udVlnuy6Q1Ft1t8l9+8
        Z3/+2yHb0nXj+bijHfaDaONDGSxPXI1cOo6befo=
X-Google-Smtp-Source: ABdhPJxBxfZ0z3pnWvMZWbELdbyMq5gxlXwDGYBc87VCrQWqRYDGvz/w/hx27YUP7/lwCMS8Ng/VQQO7MjnHMKnxe0U=
X-Received: by 2002:a81:6188:0:b0:2eb:4bd3:9b86 with SMTP id
 v130-20020a816188000000b002eb4bd39b86mr21098036ywb.46.1649588409982; Sun, 10
 Apr 2022 04:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
In-Reply-To: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 10 Apr 2022 13:59:43 +0300
X-Gmail-Original-Message-ID: <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
Message-ID: <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Stop using iommu_present()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>
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

On Tue, Apr 5, 2022 at 4:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Replace iommu_present() with a more appropriate check.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
>  drivers/misc/habanalabs/goya/goya.c   | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 21c2b678ff72..5dc66dc7618e 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -6133,7 +6133,7 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
> @@ -6176,7 +6176,7 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
> @@ -6223,7 +6223,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
> @@ -6268,7 +6268,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index ec9358bcbf0b..0c455bf460f4 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -4309,7 +4309,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
>         } else {
> @@ -4369,7 +4369,7 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
>         } else {
> @@ -4418,7 +4418,7 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
>         } else {
> @@ -4465,7 +4465,7 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
>         } else {
> --
> 2.28.0.dirty
>

Hi Robin,
Can you please rebase this over the latest habanalabs-next ?
The code was totally changed, but I think your core change is
definitely relevant.
Thanks,
Oded
