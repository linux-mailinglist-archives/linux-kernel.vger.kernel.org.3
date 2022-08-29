Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD15A56BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiH2WHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiH2WGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:06:55 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850DD9109D;
        Mon, 29 Aug 2022 15:06:53 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-333a4a5d495so229727837b3.10;
        Mon, 29 Aug 2022 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6Abl5zZCzh0eLx1GmDcxV2L0GXAFo3L1+X9aKPxjNDA=;
        b=YPsZlLiBWiMP2+zlnDZT4Vxzf0OGSoXdSJdNlanwZYXC8RMDqZ9wpd2t/8aU7evV+o
         zxWCZhI6q/ie/peuMZLPfoKOA1YI3CsEFfAapphb0z7jt+3yPJDoyj52gb1Yc78Iy07R
         Gy3wg4XMGO3X7+oFAlOwXIL1XWYtHnPI2NcncEbl3+f0QdWWLSctPs/s2FAruOkKQ8bU
         P7yG0aGMOfaJsn6DaWcmjP30jBXCwN/Eb5UQ82zTQn2X29hOHy8kFcylDSjMdlCPArow
         spYGzkPLckm009zSrmPINSkgs6IazycCcsIZtQU8K33/QyR49zswTCE4EkB7cQUVo76G
         WTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6Abl5zZCzh0eLx1GmDcxV2L0GXAFo3L1+X9aKPxjNDA=;
        b=RE8ChDUzEVcQyQ73WAlhmVm+aUCF0/tMqB2LpF7Ot33oraezhIagb11OQNB6lStUYD
         uTw8GQLA+TPlqKHqoRk5M9+5ZBEAzfq4KQaSVy5vGkcIV88hDqlRS/ScawUsfkMG6DZI
         Fws78i9GlntXiZ6hd3j+v2PdIYq+VR6xc12vyM7a5XwAkFgXSdlTaHni6sEhfMVhwnzh
         tthxoVHdnLeaFPyGppRHOyMuQt4pMmxfNqx4hw3DPXWbVEEA9k8Cb4mu0iPCbsAAbhky
         Os6/fZmjx8t3rNK5pGwlLUpQ51bUycockHoyUI/5ZFmE64cvzGILrziIWLkJUb7KSbcb
         6Amg==
X-Gm-Message-State: ACgBeo3RGV1AHqa7V5/ZYLOtyJ07G5nOxmvq61tcUC78lU6Fgkbh1W+h
        RRNdPmFlH16Vs5wLc8h42DKMYPTKc5sNxM0IUbQ=
X-Google-Smtp-Source: AA6agR7hbDqk2wWLeoQUy/xHKvZshH921s+9+bo31Aysii3pnqFKRfPeu3cOkHbVrGwSYjXIxTLZ0CCnxrsN8vV0Ybo=
X-Received: by 2002:a25:403:0:b0:696:4fe0:2dcd with SMTP id
 3-20020a250403000000b006964fe02dcdmr9853101ybe.279.1661810812665; Mon, 29 Aug
 2022 15:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 29 Aug 2022 23:06:26 +0100
Message-ID: <CA+V-a8vQ5De-QKNqGtOFuLduiFf6o8reNk_6SoHLvWaXgjoFcg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add driver for CSI2 and CRU modules found on Renesas
 RZ/G2L SoC
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 10:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> This patch series aims to add driver support to CRU module found
> on Renesas RZ/G2L SoC.
>
> The Camera Data Receiving Unit (CRU) consists of a MIPI CSI-2
> block and an Image Processing block. The Image Processing block
> can receive video data received from the external Digital Parallel
> Interface or MIPI CSI-2 block, and perform appropriate image
> processing for each.
>
> More details:
> * https://renesas.info/wiki/File:CRU.png
> * https://www.renesas.com/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en&r=1467981
>
> Currently the driver has been tested using yavta and Gstreamer
> on RZ/G2L SMARC EVK using the ov5645 sensor on CSI2 interface
> only.
>
> RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (4):
>   media: dt-bindings: media: Document RZ/G2L CSI-2 block
>   media: dt-bindings: media: Document RZ/G2L CRU
>   media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
>   media: platform: Add Renesas RZ/G2L CRU driver
>
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 142 ++++
>  .../bindings/media/renesas,rzg2l-csi2.yaml    | 149 ++++
>  drivers/media/platform/renesas/Kconfig        |   1 +
>  drivers/media/platform/renesas/Makefile       |   1 +
>  .../media/platform/renesas/rzg2l-cru/Kconfig  |  34 +
>  .../media/platform/renesas/rzg2l-cru/Makefile |   6 +
>  .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 371 +++++++++
>  .../platform/renesas/rzg2l-cru/rzg2l-cru.h    | 144 ++++
>  .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 702 +++++++++++++++++
>  .../platform/renesas/rzg2l-cru/rzg2l-csi2.h   |  49 ++
>  .../platform/renesas/rzg2l-cru/rzg2l-dma.c    | 728 ++++++++++++++++++
>  .../platform/renesas/rzg2l-cru/rzg2l-v4l2.c   | 354 +++++++++
>  12 files changed, 2681 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.h
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c
>
Gentle ping, request to review the driver code.

Cheers,
Prabhakar
