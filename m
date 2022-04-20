Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AC5092B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356029AbiDTW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354750AbiDTW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:28:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C637F3FDAC;
        Wed, 20 Apr 2022 15:25:14 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id z8so3703787oix.3;
        Wed, 20 Apr 2022 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XeiHoEx0AaqlUzYhpKtNXM0TV0ZRH+WaaNWWuDW2gDE=;
        b=SFskunq2UUkXorAdDC6wahidsPTLatC0qmBxBT4RSEkPwJPDDwfYplhsSnuM6rfjVJ
         euvug7S5RJDs0rZr7sZsiuVAiv3ivgDAyS67G2hIdoIg8BfA3XlFzLirps4MncglTtOL
         GxzW+UrceJfvwW/8VMabOq87HwpQZ9bWEfV0XWbuERoGwlOyNUnlSZBHA6T3oJqY4Fhr
         gpw1XUT4bpw8DrssVXavolDqCw/gSZ2uz/yiD9XJWo5rryzWwbTtCBt0gUtwhqQ9G7O/
         VU8HuM8mRHM5VPbQ6b02esCCBoTI+WC+buqUkUf4DFK28nDxGD/xxCVEpLL/HAe8puDj
         HSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XeiHoEx0AaqlUzYhpKtNXM0TV0ZRH+WaaNWWuDW2gDE=;
        b=iR8DNzWIWQoFIWnlhHflgjGS08g7Sse2MTzyXLPp20Uy+6pH2Ee9o53FeAz0JJ2Mqs
         gFfQ3rTVL5QyK3pFqILu4BaggsSxJROh5W5t09PaApQra/EaIqRF4usxoa1SQTZ4rybH
         jcURuyLVbxUBeoPO2flHeTyyOC7MI7k1RDXtSwuvj68o/inmYmOJr5JpoBcR1zjEiR6s
         zhvMxffrbA7TaI4D0V0OlvX8kROfTWLK+bEElGAILENUQ68kYwbnlpHnn+zzhqXyhUf8
         ZbVEw273H2Ixf2M0M3W7GxTEnfMPDopWxRQ1QKaEbobytYf3nIfgk8wertYC55Nj7Q9R
         3GIA==
X-Gm-Message-State: AOAM532zHjuNdPDKS8nezvVmMklKHITYl+YfEDJUps1+J5yqY27gRMDM
        8m4Ll6sts6Hdh2gJInlcMEw=
X-Google-Smtp-Source: ABdhPJxtN+vfRqeOi3U+fwo3ry9dhVGO5p2GiIaOvtF5cxsJbXqOakRfJ/LX7vKM52x7USfwJiyk5g==
X-Received: by 2002:a05:6808:1a02:b0:322:fece:10d8 with SMTP id bk2-20020a0568081a0200b00322fece10d8mr1096740oib.283.1650493514172;
        Wed, 20 Apr 2022 15:25:14 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:3d22:92f4:9980:5ff8])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm6792744oia.31.2022.04.20.15.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 15:25:13 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 0/2] of: overlay: rework overlay apply and remove kfree()s
Date:   Wed, 20 Apr 2022 17:25:03 -0500
Message-Id: <20220420222505.928492-1-frowand.list@gmail.com>
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

Fix various kfree() issues related to of_overlay_apply().

The fixes revealed inconsist variable names for the same variable
across functions, resulting in difficulty understanding the code
that was being modified.  Doing both variable renaming and the
fixes results in a hard to review patch, so split into two patches.

The first patch in the series contains only variable renaming.
The second patch contains the kfree() related fixes.

version 4:
  - patch 2/2 updated, changelogs in patch

version 3:
  - All patches updated, changelogs in each patch

version 2:
  - patch 1/2 new
  - patch 2/2 updated, changelogs in patch

Frank Rowand (2):
  of: overlay: rename variables to be consistent
  of: overlay: rework overlay apply and remove kfree()s

 Documentation/devicetree/overlay-notes.rst |  30 ++-
 drivers/of/overlay.c                       | 283 ++++++++++-----------
 include/linux/of.h                         |   3 +-
 3 files changed, 163 insertions(+), 153 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

