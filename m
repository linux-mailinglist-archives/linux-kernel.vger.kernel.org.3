Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A8A4D13C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbiCHJuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiCHJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:50:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFC340C4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:49:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u10so25906051wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 01:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02UDf1pdb0U70hOLizwodglM9/0MIkQTrFbx130jmiE=;
        b=TjZphH9hgyELIqRwTi2WvGdoGj1J9+ko37q3Dy+QljjxZrcmoDk6pGD+9BkVeoWGl1
         c9cQYim68QjDDKBJC75LgOBARQdj4uHxDI5dHKKBf7O/my4JRPQbITljSvXVICz+kIzQ
         uzMuCIEvQpgxiO7KMGkHAA9CI20uLtfq+mC2kUGMuJymhFoQsgvBfeH8Dh37Ijctf9/1
         j9s1H20UTvvd4CNKc+lJbQwbO0zPanfu1nuz0cHXv/0abJA/1RsruwvnID4aMwSvIGmN
         GPY9CCl/Vys09GOCr4GHKBC8J9A02W7kZrjPxLAvuU0LUvaGFMMvdelTSF37S0lPxzqf
         ddAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02UDf1pdb0U70hOLizwodglM9/0MIkQTrFbx130jmiE=;
        b=c+3md0KNZZVFrGK8zkGvNmDLyqfUrpXwb6RQGRfKewgHivkV0vGlieDySwWCIZAPYg
         sXAwbZorwbIwhoqDEKviOuqLjIsJL0jj8flwOmqUrG3/UbYSiXsvzPEHZnIc5LIz4rE4
         PSP1MSpu3Fo7K8lV8L0U/ICFFK1BseyM47lNYN4z/lUiOXrkk2wnIN6S3NxjdhtNx4d9
         QGpyPVKI+UlLWc1W5i5ZCMHVNWyUbf7rxOHwwwmunVaYYLm2TnlaHtkJW5g8dCUbIo1L
         f+CrNB0+XUomm2OoUBCBck5wUWjtpS1TvoEsmLlQGi1lcLVYtAZjQcyFXOo3/58iZV9v
         biXQ==
X-Gm-Message-State: AOAM53293wl9KAaFVZvlST1bXhgqBA0T9DXVtUcT+kVmm2mlb1Do1zAV
        6Ze8jUGHCQKlvScttjWYvjOEOA==
X-Google-Smtp-Source: ABdhPJwJl4t5Tn7r80HbhzAHKE1pKs8GUwcFZWPV2LvK0bS7AXZojL7riB/OQzKcrK/Px9dayrwCYg==
X-Received: by 2002:adf:fa46:0:b0:1f1:d99a:4b1 with SMTP id y6-20020adffa46000000b001f1d99a04b1mr11663745wrr.516.1646732954621;
        Tue, 08 Mar 2022 01:49:14 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm1684885wma.21.2022.03.08.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:49:14 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, robert.foss@linaro.org,
        laurent.pinchart@ideasonboard.com, xji@analogixsemi.com,
        hsinyi@chromium.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, arnd@arndb.de
Subject: [PATCH v2 0/2] Revert vendor property from anx7625 bindings
Date:   Tue,  8 Mar 2022 10:49:09 +0100
Message-Id: <20220308094911.2680291-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue[1] related to how the V4L2_FWNODE_BUS_TYPE_PARALLEL flag is mis-used
was found in recent addition to the anx7625 driver.

As used currently CPI (camera parallel interface) and DPI
(display parallel interface) would share the
V4L2_FWNODE_BUS_TYPE_PARALLEL enum. I think that would be perfectly
functional, but it is not what V4L2_FWNODE_BUS_TYPE_PARALLEL is
documented to represent. As far as I can see it's only intended to
represent CPI.

Instead of having V4L2_FWNODE_BUS_TYPE_PARALLEL represent two
standards, I think they should be split. And possibly
V4L2_FWNODE_BUS_TYPE_PARALLEL should be renamed for CPI, but that is a
separate story. This would provide for the neatest and most legible
solution. If this solution is implemented, this range would be
incorrect. Additionally the snippet reverted in 2/2 of this series
would no longer be valid.

As it stands V4L2_FWNODE_BUS_TYPE_PARALLEL was used to represent DPI
due to not being caught in the review process.

In order to not introduce this issue into the ABI, let's revert the changes
to the anx7625 dt-binding related to this.

[1] https://lore.kernel.org/all/YiTruiCIkyxs3jTC@pendragon.ideasonboard.com/

Robert Foss (2):
  dt-bindings: drm/bridge: anx7625: Revert DPI support
  Revert "arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI
    endpoint"

 .../display/bridge/analogix,anx7625.yaml      | 19 +------------------
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  2 --
 2 files changed, 1 insertion(+), 20 deletions(-)

-- 
2.32.0

