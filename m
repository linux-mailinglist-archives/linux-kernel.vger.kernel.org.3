Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C6B5B0A23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiIGQcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIGQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:32:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87887E814
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:32:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l65so15165392pfl.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hy0JMuvgsYU9oiVlHedY7uh5S6R+8D09pDCmcrh8eeM=;
        b=ENnC5GS6K1p3inohTizFFKGqfyjiDX6+L1sT+Vpn+HJFCsouTkxw0zg3Qkl0MaV2Wc
         WatsHsrw4toDD+8BAnvhKl60P/NjJHeawMbBv9djKlHbpyDmd84MMXtt6RY2m9e7xZRS
         FMhS12g+/nVaanBMz1HgIg2QbFewJP9eV0L562lQ7vnTbfrvh91lKzeQNAB9LgOTfVXB
         qA7eYEdwn+lq5KyNJ1ZzEdOia4GBdQpHnVHgOOCzDLrmMWpCmHcVTxERP7K8tmJ9XETC
         Q63UXxQW7jzX3to8l8ggqTATcQdFplvwjqdO6yrwfXgr07o3y1YAFqwTgFjAQP0qqQj8
         Vz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hy0JMuvgsYU9oiVlHedY7uh5S6R+8D09pDCmcrh8eeM=;
        b=k2FWhh9o5Bx1LRtNq0OmyyFWG/3FMNbYFX8DR6+YjBXMWMKJ+HIZiYIqC2sapvcOfZ
         Q9klYDWyBmbpONrcjqFxkIthAq/FZPu509DTLFozj2bMRS3VBrSzWUb1gb7iZqSgFkP5
         59Kw//DiqYKkL8GIVYU4MIg0tzkqJ0GaIIG1f1Pagm+3W6VJmXDb+ZOo3DQnXClMBnQ9
         CHuENBhujNwmjLV98sWxyptD4uon8Bzj8OrWMDax1rtSbSgQzu9OEPLEwCuTIRoBk3Sv
         QMGC7F0VRtJthUu3tEygiB9W3MtdZokHfJGMWzKBztP0YrsY5cdVl71xGSmUTqszX4HR
         LEFQ==
X-Gm-Message-State: ACgBeo2ltbM9+S0EvfhlEq68IQeWjAT8sjBm8hbBE+SHVfIe5p1hjAsx
        oHr8cQa+KLA9Dz2p6aiHyg==
X-Google-Smtp-Source: AA6agR59HjdcsLeUSVZtu7YrVUnrrWCUSdAgco5n0+TJvIADJMhDAjBtFCKtITcU8jtU9+7Ymj/dLQ==
X-Received: by 2002:a65:604f:0:b0:434:7885:6944 with SMTP id a15-20020a65604f000000b0043478856944mr4073675pgp.562.1662568326202;
        Wed, 07 Sep 2022 09:32:06 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b00177ee563b6dsm121754plk.33.2022.09.07.09.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 09:32:05 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/vaddr: remove unnecessary switch case DAMOS_STAT
Date:   Thu,  8 Sep 2022 00:31:02 +0800
Message-Id: <1662568262-20925-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The switch case DAMOS_STAT and switch case default have same
return value in damon_va_apply_scheme(), so we can combine them.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..94ae8816a912 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -643,8 +643,6 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
-	case DAMOS_STAT:
-		return 0;
 	default:
 		return 0;
 	}
-- 
2.27.0

