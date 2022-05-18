Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE552B968
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiERL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiERL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:56:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A308D2BD2;
        Wed, 18 May 2022 04:56:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f9so3417645ejc.0;
        Wed, 18 May 2022 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oF+fUnzGRmCla6wkP2ZWWEZ7GzfOYIjKQWRL+xL61A4=;
        b=ZhOdUoZvH+KX2I9nBjZp3CtDu3nBvOk3p9ODvo5x1oIeBFD5fYyBJONJC9otmNNT6e
         toOCz1jR42Z4SpnKfNTHRZTqqTDFB1wGQQ+JNFAKKgC/UVWR1mAl3IIZCgJ3522FLH0t
         7MfwtDN5RlpMHFeXqqe2u3GnNDOWSPkG3WYjXV2ZQ/djEf/FL+8kct1Vt97X9Hj6HFBL
         R3gcv5yzbA7wkOfxzw/yJAVqnIbsr9rWHcRA3wk4lGLElIrBj9FKLETjF44MX0lk2YN/
         Ia+7Hny0BlRYxo6a/C7Jqg0tWqLdEh9KD+8H3i9+QLMIH1AqS7vEQvTZvZ2C0k/shZ1f
         7JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oF+fUnzGRmCla6wkP2ZWWEZ7GzfOYIjKQWRL+xL61A4=;
        b=U5jkzJ77gyW2p0OBBvGklBlBr09T1iLwhHpfQFbhaYO4SqjW5XWB9x9xVDJQc523uX
         u0zdYRXWm3GROFhTQiiqSqrJWmbyTcN/cjqjB5Natxt0sme2ZqXaTpoAK2qoGgLloeF6
         suHwvqyIOWAAWBzevzBB73sG7fXVCZ7/kHyn/WEffRvDG9YDjLVXyj/tRa/bO1qYKf5+
         UoktSQ2hvy5fFGNAq+KPE1qcmQoLrYH6C3IjnUhnrUTq6SETjA4KFQ37jGdX/NCeLLj8
         OjbJuWgYwBG5MoZ7QVIfhdAJp/PPVGmo9wf2dT95h+6qzQkysfc5VxWnQ37wKRIQS7xy
         50Mw==
X-Gm-Message-State: AOAM531VrrrJk6sBIdk5GtMOnMCY6TsFhwQhErCGnHyVNgV+CdO6jQay
        wazcKfx5UArBWCa7kvXzZ7k=
X-Google-Smtp-Source: ABdhPJyrMnKyVZWMc4n6Os+y/tg06UNnOrohRbv7mLb78lVsDCcAwXxErgbNu4RxUJjh76agRgw/2w==
X-Received: by 2002:a17:907:d89:b0:6f5:be3:b06d with SMTP id go9-20020a1709070d8900b006f50be3b06dmr23900488ejc.74.1652874973392;
        Wed, 18 May 2022 04:56:13 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id dq20-20020a170907735400b006f5294986besm873999ejc.111.2022.05.18.04.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 04:56:12 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nikita Kiryanov <nikita@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/panel: simple: add bus-format support for panel-dpi
Date:   Wed, 18 May 2022 13:55:37 +0200
Message-Id: <20220518115541.38407-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>


Commit 4a1d0dbc8332 ("drm/panel: simple: add panel-dpi support") added
support for defining a panel from device tree provided data.

However support for setting the bus format is missing, so that with
the current implementation a 'panel-dpi' panel can only be used
if the driver of the display interface connected can cope with a
missing bus_format.

This patch series defines the new property bus-format and adds it to
the panel-dpi implementation.

Check initial discussions [1] and [2].
[1] https://lore.kernel.org/all/20220201110717.3585-1-cniedermaier@dh-electronics.com/
[2] https://lore.kernel.org/all/20220222084723.14310-1-max.krummenacher@toradex.com/


Changes in v2:
    - Fix errors found by dt_binding_check

Max Krummenacher (3):
  dt-bindings: display: add new bus-format property for panel-dpi
  dt-bindings: display: startek,startek-kd050c: allow bus-format
    property
  drm/panel: simple: add bus-format support for panel-dpi

 .../bindings/display/panel/panel-dpi.yaml     | 11 +++++
 .../display/panel/startek,startek-kd050c.yaml |  1 +
 drivers/gpu/drm/panel/panel-simple.c          | 43 +++++++++++++++++++
 .../dt-bindings/display/dt-media-bus-format.h | 23 ++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 include/dt-bindings/display/dt-media-bus-format.h

-- 
2.20.1

