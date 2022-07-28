Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7A5836F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiG1CgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiG1CgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:36:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550AB25E8F;
        Wed, 27 Jul 2022 19:36:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x1so612400plb.3;
        Wed, 27 Jul 2022 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdQIfx2yBoVp1XbVGjdpkzY7q06jAiqpy0iyo3m7Pa0=;
        b=RK13hn2INVyTNO+EVC6Jv8ur0KlF4o1tmp2ID1/lA71y+8Em7LGfQyL/D3LAabJWD+
         XxqVCraWinE+JoQEOmG2GyShj0gDD3qGmaBpzh0r73iGjJLeAlLiaDg7kNmSeLYbaE+x
         6qvzWeVjx1SB6Iy/x8lxXd8xvuX8bHT73EkSCltjeMH9mtSzCqwdL8jKTcXW5+e1Tki5
         JcjtO9uEJ4OS0CXe8gthFGQNZFirc8mIILU6isfHmjsQy3GkqmdR91XMHQRXVGCfhaRv
         OnQvWr+r7FJh2F1K2hn3EHWxLHs/5ICbOXFSAyuy7oA3pCyr58RCEt7e3CjJ2S+jrdiE
         93cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdQIfx2yBoVp1XbVGjdpkzY7q06jAiqpy0iyo3m7Pa0=;
        b=e/eIdGuzyCJEzfb6kJ1zQIcut9q7HyGE6t8p0vNC15XPpngo9lItq6lDDMEJkio7DH
         u3MXNyVuA00cvEMEQ5BXMZpKAQAt6QWv6r+Arz/yWgt9oKoAfYqNsRZ1huBMeAToa8Fn
         Z2leCZzZB4PkuL720WXnueYqLxX+HhF4sVy4J6uVmGeKXFfTG+M58V+PcJKUMFymSwgx
         A71w98fBsnfGHBwrlje//RZqS0TYITszLYHjX9b+Qz/Q5HU5QGlTCa8cGo8dF/pUU0bz
         Sf5+DIp0ZFPFXXwHVJtV6rPg+ZUXYVOG0rfTjxN4wfp8V0lnQNyCLqsVNnn94QqzYfGc
         jl7w==
X-Gm-Message-State: AJIora9k2R5TnkJa2RUzxFXElOGXjwHxFYsWQmzB64rGckrbHf03utTE
        XoDr4V2/BHoIxoW7vWqsfI4gDolORLJ7pQ==
X-Google-Smtp-Source: AGRyM1tJAvXnnyR2+MnboO+W1hgL7XJhlQojAqA0LGuvJUkuDLu7/OtT/Hm2Feb2JBYcqHVzl4r2Jw==
X-Received: by 2002:a17:903:124f:b0:16b:8167:e34e with SMTP id u15-20020a170903124f00b0016b8167e34emr24436604plh.52.1658975777717;
        Wed, 27 Jul 2022 19:36:17 -0700 (PDT)
Received: from localhost.localdomain ([112.0.190.165])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm14631311pfi.89.2022.07.27.19.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 19:36:17 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add driver for Novatek NT35596S panel
Date:   Thu, 28 Jul 2022 10:35:53 +0800
Message-Id: <20220728023555.8952-1-mollysophia379@gmail.com>
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

Changes in v4:
- Correct numeric order of the items in binding.

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

