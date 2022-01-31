Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54824A4DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiAaSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiAaSMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:12:32 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892DC061714;
        Mon, 31 Jan 2022 10:12:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id z19so28492795lfq.13;
        Mon, 31 Jan 2022 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdIVNwv67nmAZn6Meg0bs0vVT2lvEaPKcRD9PPeIdYY=;
        b=LRrh0REUWFjKtcauuGh5jfhwq1TtfPUpAStoxGh1BuSp7MsRpHJTISGtIbjRnH7L5i
         eeyqNbaTmOSlbfURgVH5suiBUeL6SE7xSWvhAw7/2usSofMOgQ83xlWtlULaE//UwSX+
         f2Kor2JCpnHUhVr3qcY94IfepImszFbyz7xXm3+U15ruu+VA7gA037hG9h2XFqP/iMO1
         ByX/j/ASQjcUx0XeNHZe2L2h3pZ7TEozWncTnL4Q5fS/e4GQgX5If5u/d0n942B8YXnf
         nDOgrwW8XJcy+mG1XyDknjG/U9Ts6ikFSR6bGxIv1avfHVyZnaisFFwveo+kqVXl8Kcx
         +JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdIVNwv67nmAZn6Meg0bs0vVT2lvEaPKcRD9PPeIdYY=;
        b=0JbmDqSZTMR07/byDP8wv2bC+7MW2koAvVkXdQlhrkhpKl8r5fy+rikT5H6H3SU1Bt
         vQsdf3AbfsT+8DIt4hzDJxv0s28rlDmp7H+Ufzhm8lnbanJHu/cXre31lEyCVE3LlSsk
         gDFY+bSjsXipcqiBrAk7QPZJKYh1T7UHxjyY1eT3jNkY7uXzEY7zSpAMyydEgpnxJ/38
         0b6LINCx8zhD3cLE4X2QojiUcQstCQG4iVifT/sRhaU9XXMM0E4tlRoK5Wkzg+p+Ca9v
         tq8llAL1B6GMr+bnK8T4hBv55j5FsJxWCLOT//N0apvpM7BqILjCy6VqiV67cNSd7r1W
         o0lA==
X-Gm-Message-State: AOAM530a1yhYxlhd8O99l6OQrtzLNNrgkEqfZ7f9kMytfqHiXTeiPsd2
        ooAb5E2ckUOnCpoMrYbb8vo=
X-Google-Smtp-Source: ABdhPJyArIphe7sL0+h3OTFg6e6Oc0MyMPpil5i3WNsyQo6pmmqGBZ9Unfn1LqzepY2cXIixtyIbFg==
X-Received: by 2002:ac2:5190:: with SMTP id u16mr14837853lfi.257.1643652749969;
        Mon, 31 Jan 2022 10:12:29 -0800 (PST)
Received: from localhost.localdomain (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.gmail.com with ESMTPSA id r17sm3391297lfg.237.2022.01.31.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:12:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Support Sharp LQ101R1SX03 and HannStar HSD101PWW2 panels
Date:   Mon, 31 Jan 2022 21:12:05 +0300
Message-Id: <20220131181208.27101-1-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Sharp LQ101R1SX03 and HannStar HSD101PWW2
display panels that are used by Asus Transformer tablets, which we're
planning to support since 5.17 kernel.

Changelog:

v4: - Added r-b from Rob Herring that he gave to the LQ101R1SX01 DT patch
      of v2. I missed to add it to the v3 by accident.

v3: - No changes. Re-sending for 5.18. Device-trees of devices that use
      these panels were merged to 5.17, so we're missing the display support.

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
2.34.1

