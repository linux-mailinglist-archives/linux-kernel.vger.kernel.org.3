Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2B5242EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbiELC4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbiELC4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:56:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFAD393E6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:56:09 -0700 (PDT)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CEDE3F802
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652324164;
        bh=BRwUw/6x3iMS6QPThP0eKLyO8wl8nQwwsftQd0bs2ks=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UAjapNJxYPHy79pi8qDzKSBZdHIseWbKd1VTINRd+7umeJJP18I7q3vrvEiHRhBSa
         u5yARbav15dVCliMxFMhd4+8LBB1Op+lzrW1f/NOPlxpJqbm3SpqWXSYn7TV7F9l2E
         ypZVQ0rtv+XxB+KhBf5ag4hb3aGFddUpHWL3z57yLL1OxnuygnBUnA8SfmbHbo3i09
         XHf4Oz79fQiYqV5DHM94BFTUJg0K2BcjPlqAmDGZMIYgWcYWTw/VPqv3XJ4wpoKkfA
         p5lF0bBwVhLqYZuWTi2ky+x10n/hkynqySxyqy6FhEN22CfWiP6WjNhp9oEsgVKbRR
         iyBoZC2fYyo4w==
Received: by mail-oo1-f72.google.com with SMTP id c1-20020a4aa4c1000000b0035e95332a48so2064741oom.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRwUw/6x3iMS6QPThP0eKLyO8wl8nQwwsftQd0bs2ks=;
        b=rGwEeysMcWiiHZnA43IN16QB+R2Vv8ecocZ1k8mufVNAXy0H1hf0LyIBeAkVm47Qlg
         ETq3mydi2QZ8xOMcj1JsvHCv8pVcAF8EYce/jrmKbDJ8Ng5qLcON4iprVXQTIShzz3Z1
         F3lNfzF6ESbxHJRjQ/r92McSxQ/GZdN3sfzCnCwZG73V8fr2+0h8+NF4MuXqNoTu3Jgl
         woCzA/fOfDWw9VF+31NUWavCc3fIMfW6XqeE7iNdaXM5MBR5MK8zmAZiGzPMjtr4JXha
         VFR1smUgbfpmXVPVcUDw5WdEj4VKgsN+qvAj24w5oYQSnL1l/99fF6SSRSGv1mMRU4Mj
         h2pA==
X-Gm-Message-State: AOAM533mn3+bxt7zi+9iF/w2Y9s6F2/oZ5b78WSYx3MFSjGiiOGMkOAZ
        KoAaa998Nmve6XmbQuxz9aEnMB8ZguhhFgI3U2cKbJsRxrVgqdqFR5nuwOeQgbG1JlhH+Drt1HL
        2hLfQOKOdLK+TLp20lbpYGI+Re1ltd3mgFXRWN/6mopd57P4/3TbVf/V8Zw==
X-Received: by 2002:a05:6808:20aa:b0:326:9a80:1f95 with SMTP id s42-20020a05680820aa00b003269a801f95mr3988379oiw.176.1652324163432;
        Wed, 11 May 2022 19:56:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjHM9+dR05isUo+2Kz6/WgFd2F/IJWmAZQXb3XNqkMx8e/Gr0odiq92/6S63KQUeZHaQyOyAc4tX34d3+79uQ=
X-Received: by 2002:a05:6808:20aa:b0:326:9a80:1f95 with SMTP id
 s42-20020a05680820aa00b003269a801f95mr3988367oiw.176.1652324163142; Wed, 11
 May 2022 19:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220511122806.2146847-1-kai.heng.feng@canonical.com>
 <20220511122806.2146847-2-kai.heng.feng@canonical.com> <6246d753-00cb-b5dc-f5fc-d041a8e78718@molgen.mpg.de>
In-Reply-To: <6246d753-00cb-b5dc-f5fc-d041a8e78718@molgen.mpg.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 12 May 2022 10:55:50 +0800
Message-ID: <CAAd53p52gkv-PLRvEM3GunTwU1J=c+n0J6uD03AQJ4EnL2y4Kg@mail.gmail.com>
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
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, May 11, 2022 at 8:49 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Kai-Hang,
>
>
> Thank you for the patch.
>
>
> Am 11.05.22 um 14:28 schrieb Kai-Heng Feng:
> > We found Intel I210 can only achieve ~750Mbps Tx speed on some
> > platforms. The RR2DCDELAY shows around 0x2xxx DMA delay, which will be
>
> Please give an example platform, where it works and where it does not.

The platform is about but not yet hit the market yet, so I can't disclose it.
They are Intel Alder Lake based.

>
> How did you test transfer speed?

Iperf.

>
> > significantly lower when 1) ASPM is disabled or 2) SoC package c-state
> > stays above PC3. When the RR2DCDELAY is around 0x1xxx the Tx speed can
> > reach to ~950Mbps.
> >
> > According to the I210 datasheet "8.26.1 PCIe Misc. Register - PCIEMISC",
> > "DMA Idle Indication" doesn't seem to tie to DMA coalesce anymore, so
> > set it to 1b for "DMA is considered idle when there is no Rx or Tx AND
> > when there are no TLPs indicating that CPU is active detected on the
> > PCIe link (such as the host executes CSR or Configuration register read
> > or write operation)" and performing Tx should also fall under "active
> > CPU on PCIe link" case.
> >
> > In addition to that, commit b6e0c419f040 ("igb: Move DMA Coalescing init
> > code to separate function.") seems to wrongly changed from enabling
> > E1000_PCIEMISC_LX_DECISION to disabling it, also fix that.
>
> Please split this into a separate commit with Fixes tag, and maybe the
> commit author in Cc.

I don't see the need to split to separate commit as both require the
same change.

I will add the "Fixes" tag once the igb maintainers reviewed the patch.

Kai-Heng

>
>
> Kind regards,
>
> Paul
>
>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 34b33b21e0dcd..eca797dded429 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -9897,11 +9897,10 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
> >       struct e1000_hw *hw = &adapter->hw;
> >       u32 dmac_thr;
> >       u16 hwm;
> > +     u32 reg;
> >
> >       if (hw->mac.type > e1000_82580) {
> >               if (adapter->flags & IGB_FLAG_DMAC) {
> > -                     u32 reg;
> > -
> >                       /* force threshold to 0. */
> >                       wr32(E1000_DMCTXTH, 0);
> >
> > @@ -9934,7 +9933,6 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
> >                       /* Disable BMC-to-OS Watchdog Enable */
> >                       if (hw->mac.type != e1000_i354)
> >                               reg &= ~E1000_DMACR_DC_BMC2OSW_EN;
> > -
> >                       wr32(E1000_DMACR, reg);
> >
> >                       /* no lower threshold to disable
> > @@ -9951,12 +9949,12 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
> >                        */
> >                       wr32(E1000_DMCTXTH, (IGB_MIN_TXPBSIZE -
> >                            (IGB_TX_BUF_4096 + adapter->max_frame_size)) >> 6);
> > +             }
> >
> > -                     /* make low power state decision controlled
> > -                      * by DMA coal
> > -                      */
> > +             if (hw->mac.type >= e1000_i210 ||
> > +                 (adapter->flags & IGB_FLAG_DMAC)) {
> >                       reg = rd32(E1000_PCIEMISC);
> > -                     reg &= ~E1000_PCIEMISC_LX_DECISION;
> > +                     reg |= E1000_PCIEMISC_LX_DECISION;
> >                       wr32(E1000_PCIEMISC, reg);
> >               } /* endif adapter->dmac is not disabled */
> >       } else if (hw->mac.type == e1000_82580) {
