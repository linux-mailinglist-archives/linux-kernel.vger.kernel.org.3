Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD325810EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiGZKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiGZKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:15:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8D14009;
        Tue, 26 Jul 2022 03:15:38 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 12so12529249pga.1;
        Tue, 26 Jul 2022 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DY8UDvduTIOCtNuHCK2D2xodcevGwkNrrMtgQMDx0U4=;
        b=RWYTl97PkgO5lF0RfV58Ff+dY0q6bs8vrahBU7DjS7ih43wu/EAzb/gWF3budszxoA
         F+KWJPOLv+7mv3z7HQa2hECuDcza3UP7IL8fUOhengYAzykfx8QnAIT1YoEMk774vuhy
         0JwdduD+OnlzQEZRCEwC7KcIZbGl1ZCtWv3zT66rNBMtOoy9USw2twHv/K0jdeImgeya
         W+VuHq7E7qRO4e70Wba4KKnD1yrcFW+fTlrPAdzqDYeLg0j4/W44VoMgum1dZdBEAn0V
         2+eW+9oReXkdynD4zMqpqSEYa5UyMrDkxeAXjCcIrbETECmrF9MhZXSLK7iTnDu1MKNg
         DViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DY8UDvduTIOCtNuHCK2D2xodcevGwkNrrMtgQMDx0U4=;
        b=cEY4qC2UnCRWxg9FDqJMvWiy71PWGgFse/O/i4FePkHZ06cU68+u+ZMZz+b3JfAeMA
         k7EUZb7Wpxn6nbSHIQa6F6rygB3T7fPSbi3LFzwqCNI8XsbyxAntZ7ZFAGG6Ylx+CaBS
         7LlGszTxrGHq0H5/M9BxESOipcGe5LG3Jd62s+j6ijZ1eqQrjzjnsyetz7j8zMZ2gnZ0
         FrH82tMb48O3/vywhCqKIgpoIdYaYs/+JP1XN/BqJjXQIDHZmZ7qHJiL4gaGh0N4U8bO
         J94HFfL48PpfiogmPTh1B7VuKzk6HJRPiyfL6EcQH9EzCZOkevt+ehTZazP6b0K9VHNx
         9GlA==
X-Gm-Message-State: AJIora98fD3a/RQlOVVry8ubWmS+8PzN+pmGKkqZ+lNxrQu/jR7U5c/+
        m+CVm//JODfdNCHiHLYc1MQ=
X-Google-Smtp-Source: AGRyM1tXTx7wkr1bZ+J3yk8fuXY63jaLwVZDsXoBytwNpMaUaVtopL5oK6o84GNp7OgYbMXCO+iXRA==
X-Received: by 2002:a62:3107:0:b0:52b:83e6:98ae with SMTP id x7-20020a623107000000b0052b83e698aemr17035557pfx.55.1658830537585;
        Tue, 26 Jul 2022 03:15:37 -0700 (PDT)
Received: from localhost.localdomain ([112.0.190.94])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0016d303f266dsm5515106plg.276.2022.07.26.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:15:36 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH v3 0/2] Add driver for Novatek NT35596S panel
Date:   Tue, 26 Jul 2022 18:15:11 +0800
Message-Id: <20220726101513.66988-1-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for Novatek NT35596S based JDI FHD panels,
found in Xiaomi Mi Mix2S mobile phones.

Changes in v3:
- Embed the support into existing driver (panel-novatek-nt36672a), as
  these two IC are similar with different initialization commands.

Changes in v2:
- Correct items order in Makefile and improve failure handling.

Molly Sophia (2):
  dt-bindings: display: panel: Add Novatek NT35596S panel bindings
  drm: panel: Add novatek nt35596s panel driver

 .../display/panel/novatek,nt36672a.yaml       |  20 +-
 drivers/gpu/drm/panel/Kconfig                 |   7 +-
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 246 ++++++++++++++++--
 3 files changed, 247 insertions(+), 26 deletions(-)

-- 
2.37.1

