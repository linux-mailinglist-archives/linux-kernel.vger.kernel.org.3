Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F964716CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhLKViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhLKViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:38:07 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469EC061714;
        Sat, 11 Dec 2021 13:38:06 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id bn20so18521280ljb.8;
        Sat, 11 Dec 2021 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AN606FDWoic1gE/hvIhNv/tnFd7knEeZEmhAMBvktOQ=;
        b=LLKACYa/RglwZ3lc+IgOkFptxsNWlNEp2S1LoPxuOhjVJnxlkAkMMg7GVek+lN0nMh
         a7OXtCOcI97959q+n4eeVfYRQ2v9YD73i1h5nhVmG899RH2MWdWVScMGa1cFhfyA3lrT
         kzKBCr6d/rKnDxeaTebzq8FV8vnSj2QYmOsL1QTX/C6+ytDp7oEIU5OR7arKPuFKqo26
         uML9DYon7GugigEv4PP7fOSbIMtrAEzZVUV1wIdWQOjG5WF3L+gckeg8WfSIHpyNZ5bd
         oSvLhdqlXZVHnEFXD7x9ofq5W+7MeDn+kqWdiCcGyl13Ifsb1hLQNEqBw2kJ2I5U8o0K
         hX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AN606FDWoic1gE/hvIhNv/tnFd7knEeZEmhAMBvktOQ=;
        b=48fvpiDiyWPfo9QpmbOQBbEDb/TTMdyZZozzDNArNKvqsBpHhKXOzsCLwD7muzWiwG
         Z8MXBnf/3Khjk2xY66r/UfiVnaSbH+obYHFfe0uaT0FEcLoFYXxAYT8rQtpZf+MwtACo
         w6OUgNQHOQMJic2tQ8TEwF+NZBe9qCx0mTHaYmt18QNetjADI38B40KPQWOkApo4DCjt
         D6UKQAIXfDnuKNKb7q8FbfK/b/kG6LzvyB/Yg5QlL5YorOu91/Lt7HJfODvwwkI8kNVt
         tV72ZXk7aJ4YR1t/r01FbXa1U9HZ4d7LlO7QHkN3NQeW7Y9/8tHCnOzoRCkzw4iSX+qZ
         uOnw==
X-Gm-Message-State: AOAM532K0W49SwxU3Fly80yOXu0lfYzVpUwrTAZfcFMJ62aO/a8EF+DV
        +HZNH3Kf/WT21DM/0si3d2g=
X-Google-Smtp-Source: ABdhPJw9Udh0ZLeBHQZnYsPbOAv42sClfx6AJuaWEU5e75QX0H8fo56IQmU7TA6gsFS6FPg71+K9eA==
X-Received: by 2002:a2e:b8cf:: with SMTP id s15mr20806073ljp.364.1639258684871;
        Sat, 11 Dec 2021 13:38:04 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id w14sm786844ljj.7.2021.12.11.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:38:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Support Sharp LQ101R1SX03 and HannStar HSD101PWW2 panels
Date:   Sun, 12 Dec 2021 00:36:50 +0300
Message-Id: <20211211213653.17700-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Sharp LQ101R1SX03 and HannStar HSD101PWW2
display panels that are used by Asus Transformer tablets, which we're
planning to support since 5.17 kernel.

Changelog:

v2: - Added ack from Rob Herring to the HSD101PWW2 binding.

    - Updated LQ101R1SX01 binding, like it was suggested by Rob Herring,
      making LQ101R1SX03 directly compatible with the LQ101R1SX01.
      Such that ["sharp,lq101r1sx03", "sharp,lq101r1sx01"] could be
      used in DT. This removes need to update panel driver with the new
      compatible.

    - Improved commit message of the LQ101R1SX03 patch.

    - Added my s-o-b to all patches.

Anton Bambura (1):
  dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03

Svyatoslav Ryhel (2):
  dt-bindings: display: simple: Add HannStar HSD101PWW2
  drm/panel: simple: Add support for HannStar HSD101PWW2 panel

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 .../display/panel/sharp,lq101r1sx01.yaml      |  7 ++++-
 drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.33.1

