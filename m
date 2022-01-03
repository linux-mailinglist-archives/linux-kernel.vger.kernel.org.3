Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0622E483797
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiACTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiACTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:31:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A2C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:31:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j21so139505719edt.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyNG+ZjpWqtCeXlTaZ0dPbSnFKzzoe17vf1JNoxFiQc=;
        b=TecXSHWQHDZQ2/FCfV6MKHj+9rw4v+iniWhpyugWuo6jJoDS26cTFTjSmptocnK7yT
         D6nnWS20Z2L9aNW4pwVfGlwJz80TLlHcYDFb7yMD0IhHIESgYa70YhlBc7IhwhUdZP/z
         2X5zIzIXPZGq26gMrZHi9Bup6ctE8ik0jCsnbuougHvZzmxYpI22Xv7hb39C/ZFza5fD
         gchAkwGomeDPCQo2k0nC7uuw3kBUe8cFu01XCftepwvzyItI2UueDgz1suuTC8m6tG4q
         3xS9vDkGde9An0ZRMtDbv6oYQpa9J7tytX24eB3vb+5ze/Szy3YyYWB4baBJGow194LP
         Eyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyNG+ZjpWqtCeXlTaZ0dPbSnFKzzoe17vf1JNoxFiQc=;
        b=12+GolG7/26BqIkhmFxHJAxhAjazQJMJKDCdo7aWNDfHxCCwOMvmTBHPXzDuc+RBoG
         xqFMuGvcZEuqW6nC7IajIKsRxihU6Rhu7ORYusMZfM0rFnkHXFekWGw8/Zy8AMJTwchP
         HOkviWzcvCRaroUS+TOOwFro7kP8bTzxSIVjoplb8DCjdzsfdUf/zG1sXRmD+TNraAn8
         /7yvJIgcAFmuA3TLZhocu7NQc6OCeFiEoLMgTge3hbTIEhu1EwH565AvN/uwFhyMLa9w
         cbWdIgpxr2tmKZyFQhJQqRo11cKSe/13mrBAVZl4OAL+DtTlpQ9BL6+3MrRr+vAu45iM
         R5Pw==
X-Gm-Message-State: AOAM532a/8ejozBpJJ1Rnqfa2JvwWIZ7BDYSZsvuqsauu//pBWTrnq7J
        BQdIKncvohRlu8lLbapEtzQ=
X-Google-Smtp-Source: ABdhPJyqRykrUy6TouhbrTxrIGws7U5bdoQLbKZ+BoLFOEQGf17Ys8ZmHZmGjHpJjfVQMnnFkk812w==
X-Received: by 2002:a05:6402:b68:: with SMTP id cb8mr44951618edb.141.1641238303827;
        Mon, 03 Jan 2022 11:31:43 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:31:43 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/56] staging: r8188eu: remove dead macro ClearPrivacy
Date:   Mon,  3 Jan 2022 20:02:03 +0100
Message-Id: <20220103190326.363960-29-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro ClearPrivacy.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index da8a5bd12646..7eb4da42d5a7 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -201,9 +201,6 @@ enum WIFI_REG_DOMAIN {
 #define get_privacy(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
 
-#define ClearPrivacy(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PRIVACY_))
-
 #define GetOrder(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_ORDER_)) != 0)
 
-- 
2.25.1

