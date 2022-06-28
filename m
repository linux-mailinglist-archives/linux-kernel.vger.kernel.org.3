Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5755C8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbiF1JeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbiF1JeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:34:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1C22B3E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:33:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so12043008pjj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=GUy30TgrzVti2QWW1xO5cUga7m8+kuFp9faoxd/6OQw=;
        b=MSJzcLAq9eygHcRSlyOU7XMEWQRr5cBRQXh0q+ebDcJfSoRJdwjyn4gKCjfXKm6te5
         1uWMEhNgNvruuZX4CNfZEeo/XyaVgBe7uNJcP7Qq786hZX5KdqbeNuAcDAy4App+D4bn
         dhvGRG7tVFTWGRlhnLXghzC8GI4SrSpiW0JHCbMg5f5ZABVSF50CVsiolhKVpLzEkFuU
         HQdLtnX0fv/xqcTQbCzMV9LJIgRuyGJREV6ENHTYHa9o27WDH0BtZHz2Hv07qnjAjOfn
         6UGTRCtmTl4XdpubBhun0TcX0vI6eaxpw+VXD6zm2lCC3H84C9nS0jYDsDZZHYT3RSNw
         PbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GUy30TgrzVti2QWW1xO5cUga7m8+kuFp9faoxd/6OQw=;
        b=H/SWvLHeiWAr1aWx4qb/dUHH7m6xSag8f0Q6XHP528EDbGGja+i38hkz/1r9nqqvKg
         TcmkODBoM9+45ByJFoZNycPVK2kFFdFyfqxatprkrjUVLmj2WFtSADhV+MI4nj4I+5gQ
         fNbSj03/70ST9Zr4bO7nAHgsYVa113LiPMvg4IhROgk/F1FQ3yMneFODsKPxzf0mlG+1
         TQsJ3tqMQrke18X/RfQUCra6dI811wmz/VX5ggd1BzMceu2DQcVQoeIgdfa6eztrrWWl
         6Y93XEfgTerFYv9SKd3J4ERtOXfIeRUt7y3GDURZFM8PbsUsjOxfPErFMwNHbbULPmZM
         urAQ==
X-Gm-Message-State: AJIora+RIvW8B0UOpjgcZZaX0n4sappakZDQewPeD0cF0BDyN7sJEB0M
        C4YFCCSMBf3wsXydJNqoQ7oDunFrtoVE8dx6
X-Google-Smtp-Source: AGRyM1vrJ5dkEr7Gi0TbasFvechHWE7eC+bOTSpq1v1sMTu+2URrgmJ01TYTJ4UgADlOhORaB+hV3A==
X-Received: by 2002:a17:90b:380c:b0:1ed:2071:e6b with SMTP id mq12-20020a17090b380c00b001ed20710e6bmr21107479pjb.82.1656408839196;
        Tue, 28 Jun 2022 02:33:59 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b00525496442ccsm8931271pfm.216.2022.06.28.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:33:58 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>,
        Yangxi Xiang <xyangxi5@gmail.com>
Subject: [PATCH v3] vt: fix memory overlapping when deleting chars in the buffer
Date:   Tue, 28 Jun 2022 17:33:22 +0800
Message-Id: <20220628093322.5688-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory overlapping copy occurs when deleting a long line. This memory
overlapping copy can cause data corruption when scr_memcpyw is optimized
to memcpy because memcpy does not ensure its behavior if the destination
buffer overlaps with the source buffer. The line buffer is not always
broken, because the memcpy utilizes the hardware acceleration, whose
result is not deterministic.

Fix this problem by using replacing the scr_memcpyw with scr_memmovew.

Fixes: 81732c3b2fed ("Fix line garbage in virtual console")
Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
---
Changes since v2:

- add more information about this bug and which commit id this fixes
- use scr_memmovew() in both overlapping and not overlapping case.
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..dfc1f4b445f3 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -855,7 +855,7 @@ static void delete_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
+	scr_memmovew(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
 	scr_memsetw(p + vc->vc_cols - vc->state.x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
-- 
2.17.1

