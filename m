Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB75741D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiGNDUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiGNDUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:20:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F58240AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:20:42 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B21443FC18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657768839;
        bh=M5rngXpBSi/8BAmWOZjNpGjwI3WW+h4X/K0YbXQNmms=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=seLRui2syJgTwNb2Ns/A8PQ+oI7UXtQkte5pOQCqEj6Yv1W1eRy2X+oCKEG1jiNfo
         aBpkdbgVe+0lQZjimPOwqWwi0eyK2FADpmevQfmKOfhFthNPuL8b36tsN8FRV6Uhcr
         GsgF9vUo9n1MMCsxES80NaN8Y93LMc6Ptruy+VALtiAKZ7liwiXPE/qqq3MDC4CGoz
         ObIuI6iyqU/59C5W83+6aib/fXfS9CMiYpRVmNP1nrP81X7nmB4QIPSYH5ff4iExEp
         Wm6hw+2zORU3TT/xWb2lQMawJV1BCyxjDPjFQgW2S5kWDheBOws0OlldfrjS5VyUMH
         G8e3c+qVi0zMQ==
Received: by mail-ot1-f70.google.com with SMTP id e14-20020a9d63ce000000b0061c6ca80c54so248946otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5rngXpBSi/8BAmWOZjNpGjwI3WW+h4X/K0YbXQNmms=;
        b=gx8AwiXa9YGPnUqqIakv/PrCCCkguOtrYus9+l+11fiXxEgm/lrhqwfxCq7/MHfiTF
         T+DkFPXbUvYwBqNCMgoHEX8McCp37ofpIv7fdxW3X7ynrjqVvaoQsabnR9gkP6yIIbRz
         dUQNyDfkW0r8DRJtpSjTvCndaAI3UfrNQxC/oICgmysst4ri5vaSJd2CTkPqoOFXtddp
         RKL2R39QAvo7UK1gE3VWjHOcnHlGsEa4b3MVBay0v1k6AdtxGlyKwhKKY3cckQdfC6GX
         lJ3gpn8F+sB3NJnjAyhJ8gfSG5dcTQIHnlrwQyQfTYASmEKeunUCUnLdd3Y+YZy003wS
         47zg==
X-Gm-Message-State: AJIora+YzmcGDZygHeobRm6RPDMrn9cYduxrSItkmOdn6Hxc5+AiYScH
        JsTsFRcTxXQDi8L5ETVoFRyEfYmiJ1WXqYkhPG3/45Lb6dOCIzCHKPRajGzhx+hHmS23LHdymuY
        L4e+QIXBLvonL8fW44Ko048jibbADXEwfAHo5nePfENxF3kwOjGNKp+E2/g==
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id f17-20020a056870211100b000e680268651mr3463550oae.42.1657768838387;
        Wed, 13 Jul 2022 20:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1swNElVyTCduZe/Wj8S87UIjYniw7HoMWKL++RqaPzDQzvc33cYWQhEto50ZGbFPMUsl8nzCEv2DvpXYKSODYI=
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id
 f17-20020a056870211100b000e680268651mr3463532oae.42.1657768838040; Wed, 13
 Jul 2022 20:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220713112612.6935-1-limanyi@uniontech.com> <20220713182852.GA841582@bhelgaas>
In-Reply-To: <20220713182852.GA841582@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 14 Jul 2022 11:20:26 +0800
Message-ID: <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manyi Li <limanyi@uniontech.com>, bhelgaas@google.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
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

[+Cc Matthew]

On Thu, Jul 14, 2022 at 2:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Kai-Heng, Vidya, who also have ASPM patches in flight]
>
> On Wed, Jul 13, 2022 at 07:26:12PM +0800, Manyi Li wrote:
> > Startup log of ASUSTeK X456UJ Notebook show:
> > [    0.130563] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> > [   48.092472] pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> > [   48.092479] pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> > [   48.092481] pcieport 0000:00:1c.5:    [ 0] RxErr
> > [   48.092490] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> > [   48.092504] pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> > [   48.092506] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
>
> Can you elaborate on the connection between the FADT ASPM bit and the
> AER logs above?
>
> What problem are we solving here?  A single corrected error being
> logged?  An infinite stream of errors?  A device that doesn't work at
> all?

Agree, what's the real symptom of the issue?

>
> We don't need the dmesg timestamps unless they contribute to
> understanding the problem.  I don't think they do in this case.

According to commit 387d37577fdd ("PCI: Don't clear ASPM bits when the
FADT declares it's unsupported"), the bit means "just use the ASPM
bits handed over by BIOS".

However, I do wonder why both drivers/pci/pci-acpi.c and
drivers/acpi/pci_root.c are doing the ACPI_FADT_NO_ASPM check, maybe
one of them should be removed?

>
> > Signed-off-by: Manyi Li <limanyi@uniontech.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b7424c9bc..b173d3c75ae7 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1359,6 +1359,7 @@ void pcie_no_aspm(void)
> >       if (!aspm_force) {
> >               aspm_policy = POLICY_DEFAULT;
> >               aspm_disabled = 1;
> > +             aspm_support_enabled = false;
>
> This makes pcie_no_aspm() work the same as booting with
> "pcie_aspm=off".  That might be reasonable.
>
> I do wonder why we need both "aspm_disabled" and
> "aspm_support_enabled".  And I wonder why we need to set "aspm_policy"
> when we're disabling ASPM.  But those aren't really connected to your
> change here.

From what I can understand "aspm_disabled" means "don't touch ASPM
left by BIOS", and "aspm_support_enabled" means "whether ASPM is
disabled via command line".
There seems to be some overlaps though.

Kai-Heng

>
> >       }
> >  }
> >
> > --
> > 2.20.1
> >
> >
> >
