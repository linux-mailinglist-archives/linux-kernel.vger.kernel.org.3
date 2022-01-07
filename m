Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7B648797E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiAGPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiAGPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:05:18 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF1C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:05:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e9so10086389wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hNM7Jx0ka9c89ARXL18Y6Yomz5BgQ3R+02Ck2gVejo=;
        b=znEnsrWNoFHGs0yDXT0ajFzwU3OmTsmRvzG8YPbXJWhTE3RvFvkGF0qip3OKuZ9hkV
         pH1kfep0nAMkZa70Ig88zskk6DuT2hUovV8k3yDl8LUBRr6qLgWZGObYSafE1RoYr7aD
         3ne8alY1BcDoA2PCxjhiFXWJ96tba09NTTPYRH3AtwJUcV9BSu+8S68ZP67CUrYEHhQi
         pdKFBZje2nL9bik1Rf7F8fnK+Ju1ptnXg6R61JT304s+PUvM3NxkOAaBTGLNOxYUD733
         genYxlDbbQnIMLpqnIYFS0ZGH4tjjOcRDrjgfIGMz+04huQVwJDrFynQbUif+tMZ83DJ
         sOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hNM7Jx0ka9c89ARXL18Y6Yomz5BgQ3R+02Ck2gVejo=;
        b=qhFdaOhljQl+IfacsN9j2R00GRHATB+MhL+1qYruuLgojXJzUfXF1LxRBlHqXnGmwZ
         Zy+LDKOkL6E0Eb7lb992Yj9khQAMPpKFVLYWvD7NTzQGmBIXJgyhjbTNLfkoefS3JUHy
         BX5zQKO6rau1LYe5bzPdJdXav3Q3Na7C6hk1jHYSZwlMt5hZSzUMhx+P2h7/XMAf86uk
         0Iov+/P88z0UJR6mZeH8lwHbOqpxj6ZrLvHgGmx8F6wHRieAl8eRs7L/zLtLnzGhTd+7
         hFd0Jto+q/rmfkQyoDubqyYNcFHThiDNZpQ/LNhiG6LhvTIy8Nnee8id7ZvsHJMFkItT
         rtpw==
X-Gm-Message-State: AOAM531fk1c1u8YAIbQX987iDzHZcDcMAXcjukWZ78oAO81E1GooBI4H
        XtSbDlJ3qxAH5CAPa1/TCApYQ1EB393/hQ==
X-Google-Smtp-Source: ABdhPJwsYouaf+AyQmEepe6AEBBvuC5jNOW9Pb+QrOUDvWasENRXpdZ7054JoO1WwFi5HzBbNnHvhQ==
X-Received: by 2002:adf:f103:: with SMTP id r3mr5618982wro.555.1641567916256;
        Fri, 07 Jan 2022 07:05:16 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:fc89:e826:8938:cbde])
        by smtp.gmail.com with ESMTPSA id s194sm1848246wme.45.2022.01.07.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:05:15 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/2] phy: amlogic: Add support for the G12A Analog MIPI D-PHY
Date:   Fri,  7 Jan 2022 16:05:10 +0100
Message-Id: <20220107150512.614423-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.
    
This Analog D-PHY works with a separate Digital MIPI D-PHY.

This serie adds the Bindings and the PHY driver.

Changes from v2 at [2]:
- Bindings example fix

Changes from v1 at [1]:
- Bindings fixes

[1] https://lore.kernel.org/r/20201123145157.300456-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20210210080736.771803-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
  phy: amlogic: Add G12A Analog MIPI D-PHY driver

 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    |  35 ++++
 drivers/phy/amlogic/Kconfig                   |  12 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c

-- 
2.25.1

