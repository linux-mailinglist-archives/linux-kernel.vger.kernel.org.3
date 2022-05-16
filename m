Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF2528A61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiEPQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343634AbiEPQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:29:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E3F3B02C;
        Mon, 16 May 2022 09:29:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ch13so29664163ejb.12;
        Mon, 16 May 2022 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z664EsRbmKvMTMJMIIbFibyESl4V8wTy2xC+qQ6EHX8=;
        b=S/mO7960uNYEyhFA9Xj5FaZrLw0jj70ilWt3AWMKNI7ilvT8/W/389Tcb3DDQZpfuU
         Y/7/i73+FLJPOpwFgSfWBvdJ6gwnWiakkcMWOb0keOrc5a6q2CcwdCwf38r41ZfG9uFE
         QTDPHqMZiCvyGXWjts9lxESFX0q+IWXYbwUMV3N/lM0PJFeqkYYiG6f05BIkBoBNIyxP
         bNdTMqRgOvRn9PpFfhEB5cYJ7ue9GvMnWme3G5V7LDC52rYegJsw7F+xThHg6PX65ktJ
         SaLrlCzfZviz1WuRzPNL/H/+WlnioG3WqNJRxeWpAcKHkWD0NUVNVtY79yL0vbGbFkj7
         kYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z664EsRbmKvMTMJMIIbFibyESl4V8wTy2xC+qQ6EHX8=;
        b=wUWQYVfdAcXXCuNCmZvu82U8fDuyAVjFi2fCqcP8qjrTIBM5ayFQUL4SU4TBZ8Pk+V
         cdbaSWi91mEwiBERkKtZ/PbDp/M4RE4mEjgrSt3TrMIBglu67nAM7Yw5krsevI3vi2ME
         JlrnYkFVNp/gTh+SKmMeq0GAEtFlOGUEUbzNVAFThaLflrkj+Du6t3LZoGB7QxyWKVFE
         hflT8LtsQgTkfFX6ifkv2ri5Gp29FcfpV6zffX+dMWxJ1LccWDaYpb8ZUBEDgPWoszKd
         4m3xjpNqgyCx9cDLLBElXaUWVwVBIregIolNFMfDxN989bOcj3sqOo2E8vgup38kQb1+
         B2tw==
X-Gm-Message-State: AOAM533QFqZCwaibkEujvbk4j682/eziPoQirgjaqL6wrqqUx1txZWy+
        A+FbyW1DHQG0WQWjXxGbawc=
X-Google-Smtp-Source: ABdhPJwqdsWUekOMU8dN2Q7HZJY3pp4HFQiSwnN1K4N0Ebz3Z0wTMdmY/DKl2oOhTcjaattKUXcuEQ==
X-Received: by 2002:a17:906:99c3:b0:6f4:a9d7:6dac with SMTP id s3-20020a17090699c300b006f4a9d76dacmr16118497ejn.85.1652718547605;
        Mon, 16 May 2022 09:29:07 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906004900b006f3ef214e3bsm58819ejg.161.2022.05.16.09.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:29:07 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] drm/panel: simple: add bus-format support for panel-dpi
Date:   Mon, 16 May 2022 18:28:24 +0200
Message-Id: <20220516162826.23025-1-max.oss.09@gmail.com>
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



Max Krummenacher (2):
  dt-bindings: display: add new bus-format property for panel-dpi
  drm/panel: simple: add bus-format support for panel-dpi

 .../bindings/display/panel/panel-dpi.yaml     | 11 +++++
 drivers/gpu/drm/panel/panel-simple.c          | 43 +++++++++++++++++++
 .../dt-bindings/display/dt-media-bus-format.h | 23 ++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 include/dt-bindings/display/dt-media-bus-format.h

-- 
2.20.1

