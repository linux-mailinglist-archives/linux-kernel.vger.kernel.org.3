Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6329E471CC5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhLLToR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:44:17 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:46893 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhLLToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:44:16 -0500
Received: by mail-wm1-f43.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso10316108wmr.5;
        Sun, 12 Dec 2021 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LRousCXFOC0F6QOu13tbWukFrc1SAj/+edjxroiXx+E=;
        b=A7tyUFhmaS3hRJtsUMJboj9hGAaAkJbaMlW9gttUsdbX+mG/bR7OKk937t+rLhuFwr
         Wzgt5u6WR1FuuP8LQLVAzRgfCBPo+n6Sqt8S+xYnPNw6vwKCa4PjfF1X/MOqrdgmpvIL
         gE+WmUxwyCmZagtUeQ4M1B78JvVE4ngei7RCuwcrYyrFKQ2UJEga91tHhuLLgVEqXsHY
         hxyiQOCBQOnhPRers+vKsiMWCenaDdHDcgERPs1uConfp70XfJypPwM9kLUpUv6vf2ia
         mdRhJS/zOWhVdQD/qvg0E7eA7h6on/biskmrCnSPpKNAf/B8vLwinxEvLJ3h5bxkRsbT
         vgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LRousCXFOC0F6QOu13tbWukFrc1SAj/+edjxroiXx+E=;
        b=spUHdtEGnXcWBvvtzohiPmeeihfUc1yaxqk7/eHuVYKv0K9x4l0VvrTxZH3Z8+YySe
         QQPfJnydosRhhD2MEuSkwMiH8h1nB4HbwNXRxTvYpErzWYsIK/B6wzW18vaq05+EIy4Y
         t6UhDnZxYDKXbIR9+L0nRx0IhvW2vr8pHtAj4YSdAAVI1LitxxxFCAhFgkcVWJTbV4gM
         m1ZpYahJEjwaYMGQ/gwKY27QNuru9LgQRtDbuaPAQEhOMxQwEdGOCV+YDo6mqmo0hyY/
         S4y8wrlKbtVJgfAPO1xbB5w4+l0PCJFummtH/9w7CaC270FzR4C9KKFzGGOWGmNXOQAJ
         dUqw==
X-Gm-Message-State: AOAM5316FIsyfqYEtPT1SI6w92/LvJTw6W5OVAw5GHaLN21E6lLL1H9y
        S8Y5OhdPnm0FaMQQdsGmQoJTQnuhxzFPKA==
X-Google-Smtp-Source: ABdhPJzw7b4cFWTxEdHQTvrN/Om1kmk5Ahc1qxaJM4OEsjKxT2D/0tvAzprvE+WPm/MOYKI9Aa2ucA==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr32712478wmq.195.1639338195132;
        Sun, 12 Dec 2021 11:43:15 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id h27sm5372370wmc.43.2021.12.12.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:43:14 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] Input: atmel_mxt_ts - fix double free in mxt_read_info_block
Date:   Sun, 12 Dec 2021 20:42:57 +0100
Message-Id: <20211212194257.68879-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "id_buf" buffer is stored in "data->raw_info_block" and freed by
"mxt_free_object_table" in case of error.

Return instead of jumping to avoid a double free.

Addresses-Coverity-ID: 1474582 ("Double free")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 05de92c0293b..eb66cd2689b7 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1882,7 +1882,7 @@ static int mxt_read_info_block(struct mxt_data *data)
 	if (error) {
 		dev_err(&client->dev, "Error %d parsing object table\n", error);
 		mxt_free_object_table(data);
-		goto err_free_mem;
+		return error;
 	}
 
 	data->object_table = (struct mxt_object *)(id_buf + MXT_OBJECT_START);
-- 
2.25.1

