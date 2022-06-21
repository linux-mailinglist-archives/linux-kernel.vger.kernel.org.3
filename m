Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58861552953
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbiFUC2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbiFUC2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:28:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E6DD8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:28:12 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 968F63FBF5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655778489;
        bh=UNuBfXpSXpZ3D5IsIMVi7WSYUlUBrkeS0wvAhdMcGn4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jXguBKT86q/B6Q4v9zyHg7g5SX3fKhBSbn6+e8ZnPeSxyRyl5szALQUdqg+fuiwjH
         Xnx9SIV4rJwi/ajbBS7jgPAJI120lIwmxYdT5lRRFAft7rjTsmyAXxJgv49Gq0yN96
         As8G2qmyTu9tWam8PUIUFRaPyy70PkS6b60Ucdm98a2cHpvhKglJdaxUR0PMC3vPTk
         iAVyFqpAu1QiuAWngaeK0gVe6iqZyI62FjdkuIvL2Ln0tHH9g+aw1MDARLhxjnvS9P
         2Z9PtqK0xJgUQTcuoVZv5yF4OJgI8py6L/zazk8LiATDue/nSm1o2Z3Lj7LqzuSczc
         PDyB2MjKJYaKg==
Received: by mail-oi1-f200.google.com with SMTP id bf2-20020a056808190200b0032ea485bb7dso6969068oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNuBfXpSXpZ3D5IsIMVi7WSYUlUBrkeS0wvAhdMcGn4=;
        b=42ctUZcpNCmBoJhMXWKz6pYd/1L+AX5k8UwkKoLw5q6tQRuKbXxuzJVtG+BLPT3MdO
         cBCIpH2bmNvwE4/M9anfDIgINLQAjOpoc5IIgHQy9Iw+yzMN3x0zfphtz7EJocHn94QB
         sjCP8IpX8EGQQWNy54RK5f7Ge4mUgeeMK8MItDD4D4+iehu+Wxa7y/+wM4b80i76kSet
         P4+WiGxGsja8vOmvD6A74CP4r8t6jrC+zDSmXPSepOIskeGTHIw93MuI7QC6QdSI018c
         jUHO7SGlG/oKEa2ekMLwvWRenvrCKCgpg4geWyiJIXbO4k+chrnJtqAAdOtXvVM+psno
         +ARg==
X-Gm-Message-State: AJIora9izKRjKzPjP0iZJJaXxEeLZLrkhxwof5R1jEbGcdqib+kaQbBu
        vE6L9zWWWn1/acVTspnnOv5VtrsltLgSLCt9+LUPwVYRxGRx8is1PtsVHk2PCMn9IdQYFj4FpBP
        UTIq515pVc75ROFHgMoTgoXMXBUUD/wNOFrQPVi/Cv12nWC8K1afBLNuv3Q==
X-Received: by 2002:a9d:6d90:0:b0:60c:757d:1e08 with SMTP id x16-20020a9d6d90000000b0060c757d1e08mr10391487otp.224.1655778488498;
        Mon, 20 Jun 2022 19:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u/qEtWTOcznlFO6/6DzmXZHqIjqZLMEnnAkGj+c5obYAtzAP/o58AuerszAEur2YMurVxQsX1SFQAcL3Ku9a4=
X-Received: by 2002:a9d:6d90:0:b0:60c:757d:1e08 with SMTP id
 x16-20020a9d6d90000000b0060c757d1e08mr10391484otp.224.1655778488235; Mon, 20
 Jun 2022 19:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220509073639.2048236-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220509073639.2048236-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 21 Jun 2022 10:27:56 +0800
Message-ID: <CAAd53p4NZ1Pd0TteMm0=Pcd2s-F+f7--tkiUNQqMRm+NgZtuSQ@mail.gmail.com>
Subject: Re: [PATCH] PCI:ASPM: Remove pcie_aspm_pm_state_change()
To:     bhelgaas@google.com
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 3:37 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> pcie_aspm_pm_state_change() was introduced at the inception of PCIe
> ASPM code.
>
> However, it can cause some issues. For instance, when ASPM config is
> changed via sysfs, those changes won't persist across power state change
> because pcie_aspm_pm_state_change() overwrites them.
>
> In addition to that, if the driver is to restore L1ss [1] after system
> resume, the restored states will also be overwritten by
> pcie_aspm_pm_state_change().
>
> So remove pcie_aspm_pm_state_change() for now, if there's any hardware
> really needs it to function, a quirk can be used instead.
>
> [1] https://lore.kernel.org/linux-pci/20220201123536.12962-1-vidyas@nvidia.com/
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
>  drivers/pci/pci.c       |  3 ---
>  drivers/pci/pci.h       |  2 --
>  drivers/pci/pcie/aspm.c | 19 -------------------
>  3 files changed, 24 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f1..d09f7b60ee4dc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1181,9 +1181,6 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>         if (need_restore)
>                 pci_restore_bars(dev);
>
> -       if (dev->bus->self)
> -               pcie_aspm_pm_state_change(dev->bus->self);
> -
>         return 0;
>  }
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a15..86a19f293d4ad 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -560,12 +560,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  #ifdef CONFIG_PCIEASPM
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> -static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  #endif
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc8..7f76a5875feb4 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1012,25 +1012,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>         up_read(&pci_bus_sem);
>  }
>
> -/* @pdev: the root port or switch downstream port */
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> -{
> -       struct pcie_link_state *link = pdev->link_state;
> -
> -       if (aspm_disabled || !link)
> -               return;
> -       /*
> -        * Devices changed PM state, we should recheck if latency
> -        * meets all functions' requirement
> -        */
> -       down_read(&pci_bus_sem);
> -       mutex_lock(&aspm_lock);
> -       pcie_update_aspm_capable(link->root);
> -       pcie_config_aspm_path(link);
> -       mutex_unlock(&aspm_lock);
> -       up_read(&pci_bus_sem);
> -}
> -
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  {
>         struct pcie_link_state *link = pdev->link_state;
> --
> 2.34.1
>
