Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838E517667
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386815AbiEBSVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiEBSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:21:22 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3160F6E;
        Mon,  2 May 2022 11:17:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m6so12625264iob.4;
        Mon, 02 May 2022 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wAIjQGETcUB4eLK5tbJdGRIYcuRUrIg4vtorlo42Z1I=;
        b=JwtyvoKYogOYMpCj7lGplQEI3PZYVpRGTYfgL61/5JsRwZRt8Qndgu3iM4AB31yAKt
         lLFSVdlWUhJcEKKoQvcOLCNPt16VlNjvxoDXEEiCLsL4ot6UI5jFGuDr/nax22CiO8Iy
         Sj3UDFimot+G1P2uyQc73kPPU4Whh4WfqzySiekoo+4t8GoA0EAX5k2MrQGnKfZ/XWw3
         fmBOIb6j5kCgMTh1pd//IiotilhJPigKzeWRrRySEIrUW6KaEWzZGTvJ2hgSPhAF4WU4
         qaXui1w9D36xqctJr7u5XnC1i+vh+gZsPKSh/8/JSc3MJ8VxuE+/up06wLXblF9GRYq7
         b19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wAIjQGETcUB4eLK5tbJdGRIYcuRUrIg4vtorlo42Z1I=;
        b=CTkflJGbop7JWHPui6Re4Zc4oQL573EYqBkofHn2KD0gFUJ0HMg1zOzwEL2lVCxFHp
         1Rsl7aFunPDD6vLzMjsJOyL/K4yLEzjLgiqw2DLDRN18otM1CVEN/bmcPNsQ3ly5VK7x
         PoHwrmNI5GXhIPJmdF91HzIyNZjMeyc4PaBzLZjBAY+whdeFZ3u6I7X8FWc3Cty6MLvV
         frdV7jz8xj7qIC3CcxIy3D3Oc21NLznUrSVPQj5sSe9WcSnmGHlOSzkXg4nJQHhE47+E
         FZTiahMiWUQDbIm28qivaw8ZzAKf7DpR3eoYKTf577njIzCMVmwb26F+gXJtNZ1fxo1Y
         7N2A==
X-Gm-Message-State: AOAM532HqCA7yWzIZ8AItRMY3eL86cgoZjkp+ULlnFTpNXHn81r0q1eG
        9lpezZ3DJjs45n9parN8jLc=
X-Google-Smtp-Source: ABdhPJxlOIB1wLu6aGWW+XZwx12yvdoRUV0X7Z/B4KXY5zQ6ctIGL6TvhoJUnRb1QUQeKdfBtYOjHA==
X-Received: by 2002:a05:6638:238d:b0:32b:7bda:c64f with SMTP id q13-20020a056638238d00b0032b7bdac64fmr670089jat.83.1651515473134;
        Mon, 02 May 2022 11:17:53 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:2d25:3fcb:9ffb:5d5a])
        by smtp.gmail.com with ESMTPSA id f43-20020a02242b000000b0032b3a7817a9sm3230678jaa.109.2022.05.02.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:17:52 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/3] of: overlay: unittest: fix overlay notify error, add overlay notifier tests, fix bug revealed by new unittests
Date:   Mon,  2 May 2022 13:17:39 -0500
Message-Id: <20220502181742.1402826-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

patch 1/3: fix bug in overlay notifier handling
patch 2/3: add overlay notifier unittests, expose another bug
patch 3/3: fix bug exposed in patch 2, update unittests for fix

Changes since version 1:
  - patch 1/1 v1 did not apply on Rob's dt/next branch, rebase on top of
    5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}

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

