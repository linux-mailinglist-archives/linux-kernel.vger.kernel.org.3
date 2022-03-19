Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684834DE8EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbiCSPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiCSPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:01:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F133F894
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 07:59:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so22076494ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Un98TWN0bbthuEn4ebu9fEG7PBhy2GZCpdv54lxLkpM=;
        b=IAUbWl0Uagk19yLVwRpqPwmPOCYwVq5Ux9RkjGwj4eM4vGmQ0iImKVnKbKmIcMS6Nq
         JSEPUgnl34KTzHF6wwbC3eYG298jybkhu4kQdsjIhNJOV5sDOL+JdQaISAKexqJ8C+t1
         0qdkXNg5iCcMw3qGr0c0XipDBb0sRB1RkCd0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Un98TWN0bbthuEn4ebu9fEG7PBhy2GZCpdv54lxLkpM=;
        b=DSSGhN98oMm4Su1ig/NQQYKKP71iso9x3TIMxrLlJm9VhpmN5dlgujF3LN5Odz7Hrz
         s4/YCn30fWAThJbSq34mil1HoNEVx1JtxNcE3q1e8buhYyUo+5oGntHofv2p4XqQnmAe
         rF+kkPpcTbhx7YgFKIxZ+UTog9Jcp07jTbOSIqi5MMAIOK3G17K2/eKHpY1InmPedYtY
         pcoFUNuFvk1j2kUtLXZZjemd4Ez1XFeeYLk0wThjK4dtumZAMPh6xk6JydX0lSzhUpAj
         gq3FfiPUYkjIrrjZqFEuVy7CRKUdSxX6nPWlvab0BVemB4xHwfxf35KM5rg+8SjyGPDR
         dtkA==
X-Gm-Message-State: AOAM5321KOcsYbzF9ke0QCSyBbI+CmCJ4O2wqck8U87mKzteYfV3+/ir
        8cT5M8dNQqFho/6ckDz+DdqpZg==
X-Google-Smtp-Source: ABdhPJzSd3AnRcUe4wVCLYAoFppqJH2n2gxgiQFSvgJ3xO5CqntK/G4uH9t8BBrEByHdEWFR8J29eg==
X-Received: by 2002:a17:906:2695:b0:6ce:b94d:9f07 with SMTP id t21-20020a170906269500b006ceb94d9f07mr13588934ejc.297.1647701984055;
        Sat, 19 Mar 2022 07:59:44 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm4923329ejd.118.2022.03.19.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 07:59:43 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm: bridge: adv7511: two fixes for CEC
Date:   Sat, 19 Mar 2022 15:59:37 +0100
Message-Id: <20220319145939.978087-1-alvin@pqrs.dk>
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

The patches are sent against drm-misc-next. Thanks!

Alvin Šipraga (2):
  drm: bridge: adv7511: fix CEC power down control register offset
  drm: bridge: adv7511: unregister cec i2c device after cec adapter

 drivers/gpu/drm/bridge/adv7511/adv7511.h     | 5 +----
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 4 ++--
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 ++---
 3 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.35.1

