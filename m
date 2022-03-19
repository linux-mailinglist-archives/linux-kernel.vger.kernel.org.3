Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861B4DE8F1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiCSPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiCSPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:12:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D354BC0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:10:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so22119612ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKe0U/RwVI8iJXkVv2dwHxyKD0fd8KiFXYVJtE85vQA=;
        b=fk8ezcY5X3ICrRjDohBHJmYk8HCMAYB11MRxx6SNlb2bb1ZgqEWkTHekiUY1V7QFj0
         v2BG+FDPa1x+0d1Sca6C8DupmYY2+Cv1WxLfkPmlc6S9IeRER+OJdKMdrpHObCrCnziE
         haoHTeR3/wICmRyD9YB4JFX7XbHq8dyXCPeUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKe0U/RwVI8iJXkVv2dwHxyKD0fd8KiFXYVJtE85vQA=;
        b=eUG94K0Z1b8JvWtL/AFF+e+GMor/ti+Gz9ByhlKAQhO511q/UhOg1aEX9wObFhQu/A
         lf9MuHzQ0TX7arG6atLiXHIJ3hTjEqVokRrZSx2QqjMnKUHL29mkuBU9G6plnXV0F8XI
         igbHwJ6i+TWzkTJS9FrNyzPQW8SIebLDchGsGjgUIZLtfZaxu7jsKIAvqBLZkzHAtyMC
         xgYcg+SqPUcFpWdFEBWkTS39o1lnajDa7641c++d+pB9NmW+mHXKqplt0o6rPzGHViH9
         DOznWjjsbpNuFYbNezUlXhKgLw/Ufg9BUM2jMqg2xRz8ydWayiMmIRDE3vvc4kkyedwZ
         2Z5Q==
X-Gm-Message-State: AOAM531Su99uNDYtaDnfW7UduivAQDoMGCFIlnfS+3WE9yRVwqsYuiW6
        S4EQyJwJsO689DILG4VxomsIsA==
X-Google-Smtp-Source: ABdhPJyozYKuNYImBQmoKqThMDKDwjsuoBHrBNf58UKZmcvHVn3ID+/mVwxEYE96rWtbTts0ZMu9cw==
X-Received: by 2002:a17:907:3da6:b0:6db:aebf:5fd5 with SMTP id he38-20020a1709073da600b006dbaebf5fd5mr13430316ejc.503.1647702643755;
        Sat, 19 Mar 2022 08:10:43 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm4573778ejl.122.2022.03.19.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 08:10:43 -0700 (PDT)
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
Subject: [PATCH 0/2] drm: bridge: adv7511: CEC support for ADV7535
Date:   Sat, 19 Mar 2022 16:10:13 +0100
Message-Id: <20220319151016.983348-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

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
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  22 +++-
 3 files changed, 119 insertions(+), 46 deletions(-)

-- 
2.35.1

