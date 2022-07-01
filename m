Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266A85631F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiGAKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiGAKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:53:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B47D1EB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:53:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 136so2088582pfy.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ab5IJ5FlC2arzoi3kWfdSjGdGoRkJfvUHhC4m41OOk=;
        b=mtddHLkVMqoogqM4lpgfmAsgGkue45P41hAbtARlD5IRzAri5JNDDXCGek+WlUZmVD
         d5zVOxLl2wnQqzA64eAvtCy0Q7wwOAzx6pAlpCImQerZmioHoWR9LwdNy2Po1fcbfwST
         HDcUXTpvpNx3TYOrPITxyVh91ll+sYpBigJg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ab5IJ5FlC2arzoi3kWfdSjGdGoRkJfvUHhC4m41OOk=;
        b=f5QCcEoOtkvcy/32nrx44B0D9EbBrdimXLM/foVK+epQXggcI/Zqj/1lGLKzFW9DlS
         TKW81ooMZCG8LTcoe6S7O5OufSq4fdTh5f+dlKlkd59/4YSS4/KJU/XcodgJ1zOy6a9q
         XYs57pMva7xIkNG/v5tvNjl2cYJYdPhtUvfUFu3Gud6a9sfoADOVPMGaH40ArhLPj2vt
         aQwE9XdbmLfCrhsOSfa5ICPF+uYyM9S8CUAXVG0YLjIeFr8UCiYd3B++gNsBNz4HPcCE
         6L2Lzbm0hRze1B9hYAVJxvdgQHY7nUsjyAF1/rkCP5r7GoAUB412L/jNJ3F4TTf72pc+
         2IEA==
X-Gm-Message-State: AJIora8qa4V6q+fYwt+eQ83QZNpSHO+utOwEO+Um3UYCbZlaMbm0DWOY
        e025D4ZOJhxYxOpafVtcB4dTcw==
X-Google-Smtp-Source: AGRyM1tw7DbaCi+C/xp94ptdl0n14kYLKVC7KPloTo8sA9w65Gkvnag6DLdW1HXoS6xysBJhFC/7RA==
X-Received: by 2002:aa7:9911:0:b0:525:1bb3:965a with SMTP id z17-20020aa79911000000b005251bb3965amr19804013pff.79.1656672784933;
        Fri, 01 Jul 2022 03:53:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0016a058b7547sm14906670pll.294.2022.07.01.03.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:53:04 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 0/6] media: mediatek-vcodec: Fix capability fields again
Date:   Fri,  1 Jul 2022 18:52:31 +0800
Message-Id: <20220701105237.932332-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

The previous round of changes to the mtk-vcodec driver's returned
capabilities caused some issues for ChromeOS. In particular, the
ChromeOS stateless video decoder uses the "Driver Name" field to
match a video device to its media device. As the field was only
changed for the video device and not the media device, a match
could no longer be found.

While fixing this, I found that the current info used for the fields
don't make a lot of sense, and tried to fix them in this series.

Patch 1 reverts the driver name field change. It also makes it
explicit that the field really should match the driver name.

Patch 2 changes the value for the card name, making it a free form
string that includes the SoC model.

Patch 3 removes setting the bus_info field, instead using the default
value derived from the underlying |struct device| as set by the V4L2
core.

Patches 4 through 6 do the same as 1 through 3 respectively, but for
the encoder side.

This series is based on next-20220701, and was tested on mainline on
MT8183 Juniper, and on ChromeOS v5.10, on which we have a whole bunch
of backports pending, on MT8195 Tomato.

Please have a look.


Thanks
ChenYu

Chen-Yu Tsai (6):
  media: mediatek: vcodec: Revert driver name change in decoder
    capabilities
  media: mediatek: vcodec: Use meaningful decoder card name including
    chip name
  media: mediatek: vcodec: Use default bus_info for decoder capability
  media: mediatek: vcodec: Revert driver name change in encoder
    capabilities
  media: mediatek: vcodec: Use meaningful encoder card name including
    chip name
  media: mediatek: vcodec: Use default bus_info for encoder capability

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 ++++---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 1 +
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 7 ++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

