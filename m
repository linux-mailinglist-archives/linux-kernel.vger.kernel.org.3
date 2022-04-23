Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1564250C9CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiDWMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiDWMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:12:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F99229ECB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:09:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u15so20976713ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOvwlnaAUQe7yJE1udQ5lov+LHMqfAOAvn7N1w8zf8o=;
        b=C+PCZrVq80dR8SgDBclMGbIiHC9ypd84O7Ns20a+Kz6uI20AysLVDJkJyQO6KpyvUF
         aKvkNyjMMXhga72Dd2RYxTsveiZ7cHTu6CjFuSpZW47b3cMkori2+3A4y6PDmc3xUjdM
         5nAEv9H13Bv8sV9Y7x8Ur2LMLv2kvyrbY8B3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOvwlnaAUQe7yJE1udQ5lov+LHMqfAOAvn7N1w8zf8o=;
        b=BpW39IKunxgjubdyM95+CZI/6nmpI7wsO0c/7jSWUUdHiqE9MuGFA8B6CAAo/eG8Da
         coEluJ4lV9Ag7LvtEq0B0dD0+gEd1pa27YUVB7+rZxLzvBbTiMmT1AhKjMKmOSA4hn08
         Hen9aEd1sMlmKe0UJ7fWpsvP8hldsASrNGinSfs+smWWHTGSott6QG15W7IG9CmDTYJi
         cbXvissW6UCj5Jhne88eMCiVetpBHrsBGfnrzwg8qlK5ELuhCbQ4YJydzX31D/1D0403
         bsczws+R0oJiXxYhDzAowbGdvSammUaNI/bC+jgwnGy2OLQ5VzJqEC7s9+CuxEs5tCvN
         /8rQ==
X-Gm-Message-State: AOAM531MtQE3NfkNEjVhjBQgMD/6D1BSYunu06QMqwYdqYK0ex7QkGM4
        SfQ2zpGKKhnH6GnNJ+vBKFieaw==
X-Google-Smtp-Source: ABdhPJz8DvlUlcZQIDMK/WQCJB3SHRZTuITv0XAsaHpuwM9WFeVjMhssYyWAeq7GTTN6qch+dbOVNA==
X-Received: by 2002:a17:906:360d:b0:6e8:7f57:2d4d with SMTP id q13-20020a170906360d00b006e87f572d4dmr8324917ejb.736.1650715757861;
        Sat, 23 Apr 2022 05:09:17 -0700 (PDT)
Received: from capella.. (109.58.122.219.mobile.3.dk. [109.58.122.219])
        by smtp.gmail.com with ESMTPSA id hz24-20020a1709072cf800b006f383a4d56bsm24902ejc.4.2022.04.23.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:09:17 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm: bridge: adv7511: CEC support for ADV7535
Date:   Sat, 23 Apr 2022 14:08:51 +0200
Message-Id: <20220423120854.1503163-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Changes:

v1->v2:
  - add Robert's r-b
  - fix up 'case XXX...YYY+14' statements to read nicer in the 2nd patch


We have an ADV7535 which is nominally supported by this driver. These
two patches fix up the driver to get CEC working too.

The first adds the basic support by correcting some register offsets.

The second addresses an issue we saw with CEC RX on the ADV7535. It
hasn't been tested with the other chips (e.g. ADV7533), although it
should be compatible. I'm sending it against drm-misc-next because the
issue wasn't reported for other chips, and ADV7535 didn't have CEC
support before. But feel free to take it into -fixes instead.


Alvin Šipraga (2):
  drm: bridge: adv7511: enable CEC support for ADV7535
  drm: bridge: adv7511: use non-legacy mode for CEC RX

 drivers/gpu/drm/bridge/adv7511/adv7511.h     |  27 ++++-
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 116 +++++++++++++------
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  19 ++-
 3 files changed, 116 insertions(+), 46 deletions(-)

-- 
2.35.1

