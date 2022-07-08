Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C861B56B22D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiGHFQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4687676973
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 018D7B824AB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A1DC341C0;
        Fri,  8 Jul 2022 05:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657257378;
        bh=4wYE7v0lAhM5Calh+s5prT4A+3nwzjmMFNoQEcRsbG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsrHVfbHK5/zojMD3bFusOTRWdnu1UlFGWIdjtdtmzu10DnF/Pi5B4S2737FkTlTA
         cxSFPavn11Rke/IEjLJsqiep/kO5RRvSDJSkT+OTPoTXyJMmmVC5Abd7IzJ9Fd03Gs
         746teNFDCCR/0OEhhg6ZStW/RTFszZJs7VxW7aVPAyxAy55n+HlkgW0Cj2Mkfmvdqn
         pFq+D+bNarwZ4Vd6XiN9XLnMoZoojo1EMU5IXrG79gBiwjcjyzSQFx1nH35Pnhl7JV
         KWpAOsftWLG4+czWL3UeN5nIaoRWPG7qh3nxshRxGO3h62zl0sVQknoai9nzpusDOv
         qo+SfnOnpFgng==
Date:   Fri, 8 Jul 2022 10:46:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [BUG] USB broken on rk3568 based R2Pro
Message-ID: <Yse9nz9jjRoiPq6K@matsya>
References: <trinity-54ed588d-4b2c-4177-83b0-4eda8ff16a42-1657210235522@3c-app-gmx-bap68>
 <trinity-ec3b4258-cb12-42c2-9058-362260a275d2-1657216287085@3c-app-gmx-bap68>
 <CAMdYzYrs0oJXVcViOmJk4E7PSTeP5TYs0O_ePHmrcAiKtOAWXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYrs0oJXVcViOmJk4E7PSTeP5TYs0O_ePHmrcAiKtOAWXQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-22, 15:41, Peter Geis wrote:
> On Thu, Jul 7, 2022 at 1:51 PM Frank Wunderlich <frank-w@public-files.de> wrote:
> >
> > Hi,
> >
> > traced it down with manual reverts to this one:
> >
> > commit 6a98df08ccd55e87947d253b19925691763e755c
> >     phy: rockchip-inno-usb2: Fix muxed interrupt support
> >
> > luckily i can revert only this and now upper usb-port works again
> >
> > @samuel: have you an idea how to fix your problem without breaking my board? :)
> >
> > @greg/Vinod: maybe we can add a revert of this in mainline till issue is resolved?

Lets give it a few days if we can find a fix, if not we can revert

> >
> > regards Frank
> 
> I don't know what you're running, but with the standard arm64
> defconfig w/ all rockchip stuff built in, I have no issues here on
> 5.19.

Please share the config and other details on what your running so that
Peter can repro this...

> Note, the following changes are necessary to the 5.19 dts here:
> Remove the extcon from usb_host0_xhci, as the production model doesn't
> have automatic switching capabilities. The ID pin was removed in favor
> of the usb debug function which also doesn't work.
> Add dr_mode = "host" to the same node, for the same reason.
> 
> >
> >
> > > Von: "Frank Wunderlich" <frank-w@public-files.de>
> > > i noticed that upper usb-Port (otg) is broken on my Bananapi R2Pro with 5.19-rc1, works with 5.18.0
> > >
> > > this port is a usb3 (xhci) port which includes an usb2-phy and should support otg, but i still want
> > > to use it in host-only mode (USB-A socket).
> > >
> > > already tried setting dr_mode in dts back to "host" as this was changed in rk356x.dtsi by this commit:
> > >
> > > bc405bb3eeee 2022-04-25 arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
> > >
> > > i see no error in dmesg and usb-controllers seem to be initialized completely (visible in lsusb).
> > >
> > > r2pro has ID-Pin not connected, so i tried also peters Patch without success :(
> >

-- 
~Vinod
