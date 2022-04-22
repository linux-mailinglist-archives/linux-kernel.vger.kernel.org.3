Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF29B50B09A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444355AbiDVG34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiDVG3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:29:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6196050B0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:26:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c23so8773544plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Y1YHaeXBfTbZfoBkSkWzaPdDe8ew5e9JhA6bfb6pRoE=;
        b=fhDY+Gu1VdlyMnkVxX8ZSA+fulTIKGS1pUFJKkEwCBZfAXOAQ1b24SC36olqknBP/4
         hQm8Fryq5s4n2AwOmTEchOXe3pHKJZttQq/3GGotS37ho3UsFMtVzOioJeqXB0HV03dK
         rwkwQ/H/+5pF/+jJZHuUBmNTUlIAxK+vW8+7+VL6d2YbjUuyseKlrUWY0avncLbDZkLf
         Qen3ZRACqL7ATPJ0jrTP4w/iMCfzHYIQryWsMTVfzSOAt2jHT4GsdDAC+IL82gl7CBP+
         nRQV4jLpTtLFamcSHv/6iEfSqzZ0TU6eqUr65GROcBfS3HzskiOAK9g3KzUfZNoCJt4e
         Gq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y1YHaeXBfTbZfoBkSkWzaPdDe8ew5e9JhA6bfb6pRoE=;
        b=4mNMl/rJgy0fkOjDD0SUn/OXqQrwNVQflCbQ+EWKdHNZ2ehFl6EC/oVQVYR8apzF0p
         I9m4HJbrgcFZL5EF217TEML5AcaIKa35D09xLFay4JHNY6uUjV3Fus+zAr1Zj393jtKn
         JzZwn3ZbctK6EG558wt6GjJqbWDXj1mxep8CBPVsZGPPJ3Yg/scE6keXuZUdJnV1EegI
         U1Ru2fXQh2um5Pd3qWVTzJOe6iQ6syh3JF9BEEgh4qJFD7aD/D064BagwZCJW8ExutuJ
         oL3ih9iaydPr0HbXXp8q/mhTey75Ly5ExViIPCsdjZpoTOSfKRQy0+uCAVlqkVl1f4dt
         xCmQ==
X-Gm-Message-State: AOAM531QUTBFIZdl6dZVgNxzGkEu65ROZyIWtdtb3IU3tJZ3d9/Jo60O
        GLaneJOV5C6LKYB6LemEKYQ=
X-Google-Smtp-Source: ABdhPJxlKzf+MZG6ybuWwrjftcHjKzx28RfjZXreCxWvDH1j7z8ZhQAAp6VzX1pfWf/O1RTMUWYiHw==
X-Received: by 2002:a17:902:d717:b0:156:20a9:d388 with SMTP id w23-20020a170902d71700b0015620a9d388mr3104594ply.19.1650608817581;
        Thu, 21 Apr 2022 23:26:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:477:11a5:b8c8:12d2:abba:7a5c])
        by smtp.gmail.com with ESMTPSA id 76-20020a62194f000000b0050abaf80f99sm1159200pfz.114.2022.04.21.23.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 23:26:56 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        cy_huang@richtek.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt9120: Correct the reg 0x09 size to one byte
Date:   Fri, 22 Apr 2022 14:26:50 +0800
Message-Id: <1650608810-3829-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Correct the reg 0x09 size to one byte.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Sorry, in the original datasheet, reg 0x09 size is marked as 2 bytes.
But actually it's one byte RG size.
---
 sound/soc/codecs/rt9120.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index 7aa1772..6e0d7cf 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -341,7 +341,6 @@ static int rt9120_get_reg_size(unsigned int reg)
 {
 	switch (reg) {
 	case 0x00:
-	case 0x09:
 	case 0x20 ... 0x27:
 		return 2;
 	case 0x30 ... 0x3D:
-- 
2.7.4

