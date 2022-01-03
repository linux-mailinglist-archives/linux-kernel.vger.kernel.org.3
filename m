Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBD48376B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiACTKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiACTKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:10:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E5C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:10:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so139380950edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nQs++6ARsQ/FQX35cmcGfQB+Ie2xqkMpCT+P3NLo+M=;
        b=QM6D3TrqzO9EDKiGfZ9vsXBkxBqOzY9LMJSsqdVD8KvGasOv3GkMGGKO3cK4JIib8e
         cVfhhDtLgi7LGOVCzPJ2kdU6Rwb616XgI/RovCleUusUmAcaA3tfH/wFNMfGpvJV59Ry
         OO7xzrcobUZQqzzDQsHwwFqnzjxrqxWD96BNqTJ8Jiv591Uc7h3WYLTYLhLGIFUX9JqG
         TggC5PB6u2ZsvBfTw526pnXZA6hNT4Z1Yx64hExmnaw7ozLpyV9g4+qRdjs3MuQ1A6dD
         utk0j5ykiWjxJ7AMx28PX6rq/chkqc2wF3EiAbjXACbtNxW2tJQW69GPPHWjSAY8MPmm
         sObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nQs++6ARsQ/FQX35cmcGfQB+Ie2xqkMpCT+P3NLo+M=;
        b=2xI67CT/NMmATvBRxUDUlsrP38ZlvXqlEF7BVISPis1cGbl7zKAEvIw6JmIyCPW5Wg
         cb21/6Wo01Egr9XMhihwadSqkhQLZXajRo+AnYFo3xyAXe+9oA7LYbMaitFu+3LoUMv9
         XQytToma9c8V7gdjxlGX6gejrU+QT0JHlwL4gdItpo+JCJcXbovRxUzT6A1C3OfXZzVL
         rclSLpEB1Hxc3fm57g95QJFch/x0oNLdBcYCumLCexIqrnSwCEOPPqtESTeYTot4AU+5
         hwnzkXAiftxVwG4aR8q0WDWeBv1h85wpHz5XmU2PIZXOdrqnFUa02N+GrX7KbVCynjJG
         jzcA==
X-Gm-Message-State: AOAM533GMWXrmj2HrG8jizjUgMVKb+Hu+7AyTwQIg9Z3Wu+DoflFaUwk
        q+o410hleipfxaVPiQ19ruE=
X-Google-Smtp-Source: ABdhPJy65f9It0Qoju2jk7GIwJeKX3ISQrdEZeMturN/4vLMy763sNT6ZSaMDRfiaXqHqn7POYZFXA==
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr39545489ejc.15.1641237044813;
        Mon, 03 Jan 2022 11:10:44 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:10:44 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/56] staging: r8188eu: remove dead macro ClearFrDs
Date:   Mon,  3 Jan 2022 20:01:41 +0100
Message-Id: <20220103190326.363960-7-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro ClearFrDs.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index fd70b9513329..1d24d798c5f9 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -173,9 +173,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
 
-#define ClearFrDs(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_FROM_DS_))
-
 #define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
 
 #define SetMFrag(pbuf)	\
-- 
2.25.1

