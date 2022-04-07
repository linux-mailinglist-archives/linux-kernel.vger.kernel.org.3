Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A774F8940
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiDGUtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiDGUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:49:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2532FDF3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:41:58 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 125so5951950pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsfikvGKS7EdmIl+2iOk9u6ngpZWIU8z/zrcARIqPHQ=;
        b=tOWDVf5evJdQHKhBdYX/UbCqVT4V8kWTzzwNIFGft9PveKaupbjTyquiq+3tylKDHy
         ZdqxtITaS7Hb31q313DCaJkJjL5Hk3PG7+W1/PXJkFX9VBoIOjA2Dldii8LNZ6iJ3Tf9
         cjkJlKmBe3r4E7WHL2tqXyU8cyJ1TDtj7A0IA0Ka9I193d+UyUAT7Mnpz8C+FXx0B4Cn
         TXiYAH9JmD3kMUuf+ABMol4g0/m2sHuE7aWS6Bac0RwuLcnqnb9m8kuLJnRlf2uSe8fc
         apW8DPB7VP4WqlidUV4aYHwYdPdJeROzrwgkto6xvOkwcIKb5AClXNH+qZ9bA9nMoovF
         BKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsfikvGKS7EdmIl+2iOk9u6ngpZWIU8z/zrcARIqPHQ=;
        b=qpamW8/4yhd7m27qDj5X8bGaNu4Pq/Q9rxKNmxB6izcE+8/Y66+0xSWbEqdIcGaW7Z
         JmWFRoYbEw/9Ys0tXio/AKdvSpn5B4j306Zl1S8bY+cXKlcPT5/4OXErtTskfub6nSAh
         jsLUk4P6AYm1GxAzJoYQ8EOxksq60oFOfz5pWiW/OqPWUQa6xfEaveKXN2BwVQzjJu2r
         h/HjTL7R4a8PfMXcW6fDnu1nzqmRRE1/Y5UqSBhFhLPnx9rzEgJ4cz1DyT0cJ9Ij6h5x
         snWR19XokbWnMGH5XP8V/f+YgLml50zj3CPL03fz5mACPnDLSgGRL8B0OktpJqYCpB2f
         tgEg==
X-Gm-Message-State: AOAM532F+rt5eudTe4DftA9wpEIL5ki5BgzXPzOoG9qzGuhOVGPG93RE
        GkejfCxtTmkyyYUZHURc2a5PeOAxVZ87T9fdwAlokQ==
X-Google-Smtp-Source: ABdhPJyw/X9PAj5hQXkBHgIQHLkpVomaTRwQeIQ9NwMn/1m/zjbBSew3NGRBkecufGNq6ap7srYNrp4wut6BDAAtUN0=
X-Received: by 2002:a05:6a00:14ca:b0:4fb:5d3e:5f77 with SMTP id
 w10-20020a056a0014ca00b004fb5d3e5f77mr16115636pfu.34.1649364117644; Thu, 07
 Apr 2022 13:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 7 Apr 2022 13:41:46 -0700
Message-ID: <CAJ+vNU0McZxj_74DC0wCUyHq-NaT14URnvUP+kvudz7YLQq7fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add the iMX8MP PCIe support
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-phy@lists.infradead.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 1:18 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Based on the i.MX8MP GPC and blk-ctrl patch-set[1] issued by Lucas and the
> following commits.
>   - one codes refine patch-set[5].
>   - two Fixes[2],[3].
>   - one binding commit[4].
>   - some dts changes in Shawn's git if you want to test PCIe on i.MX8MM EVK.
>     b4d36c10bf17 arm64: dts: imx8mm-evk: Add the pcie support on imx8mm evk board
>     aaeba6a8e226 arm64: dts: imx8mm: Add the pcie support
>     cfc5078432ca arm64: dts: imx8mm: Add the pcie phy support
>
> Sorry about that there may be some conflictions when do the codes merge.
> I'm waiting for the ack now, and will re-base them in a proper sequence later.
>
> This series patches add the i.MX8MP PCIe support and tested on i.MX8MM EVK and
> i.MX8MP EVk boards. The PCIe NVME works fine on both boards.
>
> - i.MX8MP PCIe PHY has two resets refer to the i.MX8MM PCIe PHY.
>   Add one more PHY reset for i.MX8MP PCIe PHY accordingly.
> - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
>   And share as much as possible codes with i.MX8MM PCIe PHY.
> - Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
>   driver.
>
> Main changes v1-->v2:
> - It's my fault forget including Vinod, re-send v2 after include Vinod
>   and linux-phy@lists.infradead.org.
> - List the basements of this patch-set. The branch, codes changes and so on.
> - Clean up some useless register and bit definitions in #3 patch.
>
> [1]https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220228201731.3330192-1-l.stach@pengutronix.de/
> [2]https://patchwork.ozlabs.org/project/linux-pci/patch/1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com/
> [3]https://patchwork.ozlabs.org/project/linux-pci/patch/1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com/
> [4]https://patchwork.ozlabs.org/project/linux-pci/patch/1646293805-18248-1-git-send-email-hongxing.zhu@nxp.com/
> [5]https://patchwork.ozlabs.org/project/linux-pci/cover/1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com/
>
> NOTE:
> Based git <git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git>
> Based branch <pci/imx6>
>
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   1 +
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   4 +-
> arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  55 ++++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46 ++++++++++++++++++-
> drivers/pci/controller/dwc/pci-imx6.c                        |  19 +++++++-
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> drivers/reset/reset-imx7.c                                   |   1 +
> 7 files changed, 286 insertions(+), 45 deletions(-)
>
> [PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST support
> [PATCH v2 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
> [PATCH v2 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
> [PATCH v2 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible
> [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
> [PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
> [PATCH v2 7/7] PCI: imx6: Add the iMX8MP PCIe support
>

Richard,

Thanks for working on this!

Do you plan on submitting another version soon? I've tried to test
this with an imx8mp board I'm bringing up and while the host
controller enumerates I fail to get a link to a device. It's very
likely I am missing something as this series depends on the IMX8MP
blk-ctrl and gpc series which I also can't cleanly apply. Lucas just
submitted a 'consolidated i.MX8MP HSIO/MEDIA/HDMI blk-ctrl series' [1]
yet I can't find a repo/branch that applies to either.

Perhaps you have a git repo somewhere I can look at while we wait for
imx8mp blk-ctl/gpc to settle and you to submit a v3?

Best Regards,

Tim
[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=629586
