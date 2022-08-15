Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF9592AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiHOHzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHOHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:55:53 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD5F12743
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:55:52 -0700 (PDT)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D21B93F13A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660550150;
        bh=ZeK/4GM2DAERl5jSwdbqaxPua0JzPliZulx33fNAkb8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZEJaeJnJep4z8AmdoKJRVqtbJiZLI9nQ04cPdpx6Lxj5ucvT5g95dE/Tv2QOHMaZo
         JbhvcJdJcEYoGoHpyTMHSHc5Za6eGZbour2hTPCyxvAkYqgbDuc+H4CQFi3ZKKsP8B
         At9IfMfwbs1dH25tpWyTCjB4dj3g21XdjbzfworDxEFeny85iUUTnwWZ70Hi1wBFKb
         6TngLkiGBzl3m4MNgQ6iA1LQAvTnDPX160g2hFhJ2DNXi90iGv9zmZRbO0zGfp89Qb
         Cr2AWN0RoIR/vAb9J4tZkl4ITpSJbVOm/mYMeDlyMi9ao2ZaPH/yfwRRm5ZcqoeX1D
         HBvuH1YZ9/pUw==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-10e8118cb3fso1009411fac.22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZeK/4GM2DAERl5jSwdbqaxPua0JzPliZulx33fNAkb8=;
        b=Jd+2VAfnGGedKlIvaaHQKquDq6UM45XqhqIrLh69vT3SOooP309WmrQhlrv7h0sjmd
         IsbTT7vrnvewSG+dhSgs71QOse4mT/hhERClv+dDjHdu7T527+5ksBnOthoUCTf6xyL1
         hy1DglHjml7/E1S45xYNcadEHdHXNDmweQgSz0Lf1oxIt7WgUnTfBDDtyl39CKEwIdsW
         4FBTVScZ/o00GrF4JGmFYo8V7DAZ6xpTUpU4V7mPYJ/cwbPgkSytKPlPMy88x7l37Rn7
         sKrGTXt8Eq3NkydYgU8qxgDp6NDvpjrzSG4DrI3ItP2Qzt4BnCGuamWyUWexk8O4UhYy
         aSQg==
X-Gm-Message-State: ACgBeo3eaQ3WgAEpblpDKSocExvu22eGfgdO4hwInw33tHZ6V6/lHaR+
        UcTcCETiB0y5r7ppx/XBgUFDBt9nwOURK7mxfJhGVT+TNq3mncSw3/uJsNKCTGIhxn24CXYNVsN
        iMNCp5RRVM3XwhAGT6+daGrrB2PllgTt2cMeMjWKFIEGZ5DlZoQ5KxemA/g==
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id f17-20020a056870211100b000e680268651mr6234001oae.42.1660550149814;
        Mon, 15 Aug 2022 00:55:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5IrHGGx4EgeCSzds0PVIvFzXVMzkl0mOjPY4nJL7WACPeiDtQcM0ACWeSWTM/uXP0x6AY+wCHRJEw3NdSM+bg=
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id
 f17-20020a056870211100b000e680268651mr6233991oae.42.1660550149504; Mon, 15
 Aug 2022 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220706123244.18056-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220706123244.18056-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 15 Aug 2022 15:55:36 +0800
Message-ID: <CAAd53p4Kg=mu8boPY-jGefsqxSBLdo6WPYHv+=eD5ZYz3_1AXw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable upstream port PTM during suspend
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 8:33 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> some errors reported by AER:
> pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> pcieport 0000:00:1d.0: AER: device recovery failed
>
> In addition to that, it can also block system from suspending when
> a Thunderbolt dock is attached to the same system.
>
> The original approach [1] is to disable AER and DPC when link is in
> L2/L3 Ready, L2 and L3, but Bjorn identified the root cause is the Unsupported
> Request:
>   - 08:00.0 sent a PTM Request Message (a Posted Request)
>   - 00:1d.0 received the PTM Request Message
>   - The link transitioned to DL_Down
>   - Per sec 2.9.1, 00:1d.0 discarded the Request and reported an
>     Unsupported Request
>   - Or, per sec 6.21.3, if 00:1d.0 received a PTM Request when its
>     own PTM Enable was clear, it would also be treated as an
>     Unsupported Request
>
> And further: 'David did something like this [1], but just for Root Ports. That
> looks wrong to me because sec 6.21.3 says we should not have PTM enabled in an
> Upstream Port (i.e., in a downstream device like 08:00.0) unless it is already
> enabled in the Downstream Port (i.e., in the Root Port 00:1d.0).'
>
> So also disable upstream port PTM to make the PCI driver conform to the spec
> and solve the issue.
>
> [1] https://lore.kernel.org/all/20220408153159.106741-1-kai.heng.feng@canonical.com/
> [2] https://lore.kernel.org/all/20220422222433.GA1464120@bhelgaas/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a82..8ba8a0e12946e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2717,7 +2717,8 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>          * port to enter a lower-power PM state and the SoC to reach a
>          * lower-power idle state as a whole.
>          */
> -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +           pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
>                 pci_disable_ptm(dev);
>
>         pci_enable_wake(dev, target_state, wakeup);
> @@ -2775,7 +2776,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>          * port to enter a lower-power PM state and the SoC to reach a
>          * lower-power idle state as a whole.
>          */
> -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +           pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
>                 pci_disable_ptm(dev);
>
>         __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
> --
> 2.36.1
>
