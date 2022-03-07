Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3608D4D033A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiCGPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243597AbiCGPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:47:10 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750D7EB32
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:46:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x5so20489518edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2robocWX/4eX3h0HkkMwskjpGu6tvHElNahbn7kKFw=;
        b=G9xK+pOQDnRlW9TPM9PfZSJ+HE03a8E0WnxkTNwtnH+cVBA4mObITDp5hePOIoBiHz
         HYtUXJ7pLhIiprdZUmnfyFeDFg9XE1B4vwemp1DbGxIsiBy1dCmVIJt29Cx3DY9+a8mJ
         /cJnrDju5fawzi4IbBHnHrL7LhiBTpm3TLeZ8cxuEsDy4SpKPrM6lC6mh2iKEaYuZLeB
         2kmyKFWpFtmrNBhF6IVYcmWMBZ4vHoJtkLu1OfpI9HVuaxkGBZxWIRAps2tQiL0GiFGf
         5xfhwIRGIPstbdmIMj8GVeaHkZSknqdypmELx3xdjPyZmE0TeEYanW4fWbFbpBuOjc/h
         Z8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2robocWX/4eX3h0HkkMwskjpGu6tvHElNahbn7kKFw=;
        b=AuUZDf3nK5nnnvGoRy2+WsAsctNWk2QTSGae9Aih+mym4ToJtkdpMirZX5+3U7HEtV
         0nI9NxKl45yNfJ6ixpUhK19zXy0dSLEYogCFrmbftMM/n8LBLHlK6J8w3Ld18ZULnuMc
         tQtDsVlOtdhg0mAcKJo6aRLJuBvwc4P+qb8D7rhriuisokPJLfOb2coeiBmIYQRskCTy
         sibBQADXW7zVVHhpi6sPKC9Gg9K3iTEUJVSVkSspIDkdiMLsuki97qME26HUrHQrpOFs
         q0WsgNTuSs29UOJoXIDwElFhEOCgohBRJskGt9VIREROM/Tsgzv3qZWaUV6uxOvh76zP
         Q0UA==
X-Gm-Message-State: AOAM532gBTiHCsqvz+5yZirckJhEHyNX6cBG+M12KB5kHTxsGkVbYleT
        S/0wsJZDmSA3lym8a876pNGJoQ==
X-Google-Smtp-Source: ABdhPJzIFSku8aVjJrO50LvyMLTMndzAvl2LadpIo5JOvunKayfQxPpk+9wCWH705xaBAJv5DVyZ6w==
X-Received: by 2002:aa7:c4cf:0:b0:416:e28:45b9 with SMTP id p15-20020aa7c4cf000000b004160e2845b9mr11805955edr.319.1646667974548;
        Mon, 07 Mar 2022 07:46:14 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402190c00b0041615cd434csm4210747edz.60.2022.03.07.07.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:46:13 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, robert.foss@linaro.org,
        xji@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v1 0/2] Revert vendor property from anx7625 bindings
Date:   Mon,  7 Mar 2022 16:45:56 +0100
Message-Id: <20220307154558.2505734-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue[1] related to how the V4L2_FWNODE_BUS_TYPE_PARALLEL flag is mis-used
was found in recent addition to the anx7625 driver.

In order to not introduce this issue into the ABI, let's revert the changes
to the anx7625 dt-binding related to this.

[1] https://lore.kernel.org/all/YiTruiCIkyxs3jTC@pendragon.ideasonboard.com/

Robert Foss (2):
  Revert "dt-bindings:drm/bridge:anx7625:add vendor define"
  Revert "arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI
    endpoint"

 .../display/bridge/analogix,anx7625.yaml      | 65 +------------------
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  2 -
 2 files changed, 2 insertions(+), 65 deletions(-)

-- 
2.32.0

