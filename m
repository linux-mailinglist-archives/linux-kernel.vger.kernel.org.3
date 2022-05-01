Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C438516110
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 02:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiEAAJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 20:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiEAAJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 20:09:18 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF11DA5E;
        Sat, 30 Apr 2022 17:05:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z26so13171326iot.8;
        Sat, 30 Apr 2022 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olmFDK3PCE9W9EMoH9XCZnhEV6UjvWUIK+XTGkwGEFk=;
        b=m0e2dfMtE1eEn+2qOKm442U6AyOrqe3iE7E7lyfB+ll65lTQWnoq7x62x96oAdHERH
         D0/KU2qvp2i9QRt4DqMUBDoU6majxXJmnqLbvTTbfjZ2BiPr7Rj1+3KTJVYMwaQLHEZr
         idwOrNNbjS8qtl+13riqKlD6DESQY8sVQU6VQY0PO0Z8jKpLBdWP1zkijEJK9+qBHddF
         jWIe20H16I54zjYJzBtUn1sKe7o968/5xLJuaLv/N6CKl3LBFiL8VEUOITQ2iqr6sMq4
         CGkrpLZGqVZkaKRzpO1r7vbSxJB08/cR5AszlOXyDddD4GfvkNiXYJY4BBSCQYBHM13j
         p2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olmFDK3PCE9W9EMoH9XCZnhEV6UjvWUIK+XTGkwGEFk=;
        b=v8qkLLdB4D/Z17gcw3do/OigO4OkBeOEFzFvGZ77HSdnxC+Q6aA6xmi9e4dVoIMqw3
         qKTr8PKzIlRJoeFg94xwI+/kb7bCEkl0J1Hn7iuVH/PbKk0eOsWmlauGXLoysx4mNrrQ
         FHfu2CGUuF1X3Ym9JX1p+XnxX/h9gcrgVVulhq+J2H2xafkRohaB1Ko2lr130+6RvAH4
         clzo374gzKyYQku5aIH5eFZ9Fk5us+0AoEHemW6lj6zlDk+XKtWBbPlYnj7Prcrrd64b
         /sDkO5C20paZcqM/4me7jqr8fIv5eyC5wSvby8By9E17kMK/T6WuoClmQ4UJ+HhW/ATZ
         rXVg==
X-Gm-Message-State: AOAM532BReyyMpunpa1/FTPPsrk/T3vniXX89p70XwbfipDufFCddma4
        AIHuhyaORVLJy/oHbwZZB3A=
X-Google-Smtp-Source: ABdhPJw4FjncvCL4LUw0F/7lEWHc+BhRrRo4/M9dHH0JwLUcHWwcPHzCvu/6IKJ2Fa0Vsvn4r/SAbw==
X-Received: by 2002:a05:6638:3709:b0:32b:5fdd:8f1b with SMTP id k9-20020a056638370900b0032b5fdd8f1bmr315054jav.171.1651363554550;
        Sat, 30 Apr 2022 17:05:54 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:809b:de5d:7e0a:bf83])
        by smtp.gmail.com with ESMTPSA id n13-20020a92d9cd000000b002cde6e352dcsm1567160ilq.38.2022.04.30.17.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 17:05:54 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] of: overlay: unittest: fix overlay notify error, add overlay notifier tests, fix bug revealed by new unittests
Date:   Sat, 30 Apr 2022 19:05:40 -0500
Message-Id: <20220501000543.1368005-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

patch 1/3: fix bug in overlay notifier handling
patch 2/3: add overlay notifier unittests, expose another bug
patch 3/3: fix bug exposed in patch 2, update unittests for fix

Frank Rowand (3):
  of: overlay: add entry to of_overlay_action_name[]
  of: overlay: unittest: add tests for overlay notifiers
  of: overlay: do not free changeset when of_overlay_apply returns error

 drivers/of/overlay.c                    |  56 ++++---
 drivers/of/unittest-data/Makefile       |  10 ++
 drivers/of/unittest-data/overlay_16.dts |  15 ++
 drivers/of/unittest-data/overlay_17.dts |  15 ++
 drivers/of/unittest-data/overlay_18.dts |  15 ++
 drivers/of/unittest-data/overlay_19.dts |  15 ++
 drivers/of/unittest-data/overlay_20.dts |  15 ++
 drivers/of/unittest.c                   | 204 ++++++++++++++++++++++++
 include/linux/of.h                      |  13 ++
 9 files changed, 333 insertions(+), 25 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_16.dts
 create mode 100644 drivers/of/unittest-data/overlay_17.dts
 create mode 100644 drivers/of/unittest-data/overlay_18.dts
 create mode 100644 drivers/of/unittest-data/overlay_19.dts
 create mode 100644 drivers/of/unittest-data/overlay_20.dts

-- 
Frank Rowand <frank.rowand@sony.com>

