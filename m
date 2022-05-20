Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C052E29B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbiETCqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbiETCpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:45:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881912FFF0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:45:51 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1B54E402E2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653014750;
        bh=GaatjPyXHl4SmKXxygcZKmkO/KC5Kz97rzqAvXN3cKo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=HifUCEC0xIsGAV9qvjMaltwtEzsaCMADXfbjb4M87lkAYvocii34FNV+vufwvNHyf
         pZB1wloQ8KNUjvmOpbeXB242jHblxfJmVy0VZ5P/NKer1qNe9eFa63YWCwbPtPYe54
         uNFtFoUpFCMbfVs9+hgG3nais96Y4LuKWjcffmMr/Utqli9wjaIM3k7LqVn4xw8Acf
         ta7QpMw3yOP07n0HQHAu2p0a/eOsvCfcdAsCK70Y4TJ5d1JjUUW3sDLRN5IrVU4/5m
         m28FV3+W4aAFLPc1PPltT26bPRw39qlDy1kwKonPl1CQoZDwA+DOm7VFuMYEWtdHER
         0rD7wiieM+lCQ==
Received: by mail-oo1-f70.google.com with SMTP id e13-20020a056820060d00b0040e4f86c0a4so1936996oow.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaatjPyXHl4SmKXxygcZKmkO/KC5Kz97rzqAvXN3cKo=;
        b=g8oUNrw6qCd7JCXeKJ4wMIdfIFUCFGc3PNBkeI/maaJvdoPYEPtEwSye5tftTb4WWt
         N7FKk2VqIaLbrw2ooeH6NgG2v4IrI0Pwpd3KzSuBXuNctGOcFZDIAxhlZwkQY+GlW3p4
         JntMpAOcn4LAy0il3sZ/x54SSyjeql9rQkuLWG4fuybCCCwV/eX++UZ2kL8Aenf0vIYl
         8K3U/FKD11JBaLitjengAHEHGY6ZVWmBh8CgNMCuUSj6OLs6nkH1YhRRBjqF49JYvWrc
         Kcn8dAE1CiSh0TGT6nEELzEP4SsjJRt3+cn4DJ1BLp7DpLVulwZ0fS+bfWb4ItBflqXF
         TeKA==
X-Gm-Message-State: AOAM533jmMwQV80Zdf6iQpdGU8Pp7YQLJhyzS5Ljim6yX/dULyahA3NA
        J8qwjPiMLdhVDleXuWT7P3gWo2UTFr4yIHg8O3qFLtm24tsX8JRb8JWUvY9U3HqCN4qnV3assnt
        /gH43IcX1j7oODkRsHk2KWyTnf6d4Gt6a0ZX48ghTyZCtr+r2GjCkuWEPRg==
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id f17-20020a056870211100b000e680268651mr4440517oae.42.1653014745863;
        Thu, 19 May 2022 19:45:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUd8npgDZFVCRK+/H03mTTbAYJXBPp30NE0Tzuyut6qHq5m/2a0jX6vwPXLG6EttAHcJwZSaW+auW+bAcL76c=
X-Received: by 2002:a05:6870:2111:b0:e6:8026:8651 with SMTP id
 f17-20020a056870211100b000e680268651mr4440502oae.42.1653014745511; Thu, 19
 May 2022 19:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220511122806.2146847-1-kai.heng.feng@canonical.com>
 <20220511122806.2146847-2-kai.heng.feng@canonical.com> <6246d753-00cb-b5dc-f5fc-d041a8e78718@molgen.mpg.de>
 <CAAd53p52gkv-PLRvEM3GunTwU1J=c+n0J6uD03AQJ4EnL2y4Kg@mail.gmail.com>
In-Reply-To: <CAAd53p52gkv-PLRvEM3GunTwU1J=c+n0J6uD03AQJ4EnL2y4Kg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 20 May 2022 10:45:33 +0800
Message-ID: <CAAd53p4h1-SJROvUghPYbBnh2Z9nRtgfNEagE4X6XtBwNg8JOg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 2/2] igb: Make DMA faster when CPU is
 active on the PCIe link
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:55 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Paul,
>
> On Wed, May 11, 2022 at 8:49 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > Dear Kai-Hang,
> >
> >
> > Thank you for the patch.
> >
> >
> > Am 11.05.22 um 14:28 schrieb Kai-Heng Feng:
> > > We found Intel I210 can only achieve ~750Mbps Tx speed on some
> > > platforms. The RR2DCDELAY shows around 0x2xxx DMA delay, which will be
> >
> > Please give an example platform, where it works and where it does not.
>
> The platform is about but not yet hit the market yet, so I can't disclose it.
> They are Intel Alder Lake based.
>
> >
> > How did you test transfer speed?
>
> Iperf.
>
> >
> > > significantly lower when 1) ASPM is disabled or 2) SoC package c-state
> > > stays above PC3. When the RR2DCDELAY is around 0x1xxx the Tx speed can
> > > reach to ~950Mbps.
> > >
> > > According to the I210 datasheet "8.26.1 PCIe Misc. Register - PCIEMISC",
> > > "DMA Idle Indication" doesn't seem to tie to DMA coalesce anymore, so
> > > set it to 1b for "DMA is considered idle when there is no Rx or Tx AND
> > > when there are no TLPs indicating that CPU is active detected on the
> > > PCIe link (such as the host executes CSR or Configuration register read
> > > or write operation)" and performing Tx should also fall under "active
> > > CPU on PCIe link" case.
> > >
> > > In addition to that, commit b6e0c419f040 ("igb: Move DMA Coalescing init
> > > code to separate function.") seems to wrongly changed from enabling
> > > E1000_PCIEMISC_LX_DECISION to disabling it, also fix that.
> >
> > Please split this into a separate commit with Fixes tag, and maybe the
> > commit author in Cc.
>
> I don't see the need to split to separate commit as both require the
> same change.
>
> I will add the "Fixes" tag once the igb maintainers reviewed the patch.

A gentle ping...

Please let me know if this is a proper fix so I can send v2.

Kai-Heng

>
> Kai-Heng
>
> >
> >
> > Kind regards,
> >
> > Paul
> >
> >
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >   drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++-------
> > >   1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > > index 34b33b21e0dcd..eca797dded429 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -9897,11 +9897,10 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
> > >       struct e1000_hw *hw = &adapter->hw;
> > >       u32 dmac_thr;
> > >       u16 hwm;
> > > +     u32 reg;
> > >
> > >       if (hw->mac.type > e1000_82580) {
> > >               if (adapter->flags & IGB_FLAG_DMAC) {
> > > -                     u32 reg;
> > > -
> > >                       /* force threshold to 0. */
> > >                       wr32(E1000_DMCTXTH, 0);
> > >
> > > @@ -9934,7 +9933,6 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
> > >                       /* Disable BMC-to-OS Watchdog Enable */
> > >                       if (hw->mac.type != e1000_i354)
> > >                               reg &= ~E1000_DMACR_DC_BMC2OSW_EN;
> > > -
> > >                       wr32(E1000_DMACR, reg);
> > >
> > >                       /* no lower threshold to disable
> > > @@ -9951,12 +9949,12 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
> > >                        */
> > >                       wr32(E1000_DMCTXTH, (IGB_MIN_TXPBSIZE -
> > >                            (IGB_TX_BUF_4096 + adapter->max_frame_size)) >> 6);
> > > +             }
> > >
> > > -                     /* make low power state decision controlled
> > > -                      * by DMA coal
> > > -                      */
> > > +             if (hw->mac.type >= e1000_i210 ||
> > > +                 (adapter->flags & IGB_FLAG_DMAC)) {
> > >                       reg = rd32(E1000_PCIEMISC);
> > > -                     reg &= ~E1000_PCIEMISC_LX_DECISION;
> > > +                     reg |= E1000_PCIEMISC_LX_DECISION;
> > >                       wr32(E1000_PCIEMISC, reg);
> > >               } /* endif adapter->dmac is not disabled */
> > >       } else if (hw->mac.type == e1000_82580) {
