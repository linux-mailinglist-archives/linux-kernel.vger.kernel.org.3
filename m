Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB86483794
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiACT34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiACT3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:29:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8426C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:29:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f5so139615187edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjfPnUXitcaEyLb5Ye8HhEqApHDKZLLqufapqIWXgL8=;
        b=WpZWufid1BkMKY0o7xAk1Be2l6GDX4tbkOg383xcIHd7ohxo/bDv7yu98h+BmUYb9b
         k1WsNNk6MQPnPaYAf0CjZiiVsxG9BttwKvJi0og2wm4bOhYkW36WyDYmnEk/RZv6pwm1
         bbp4Oe2uQTu6phgQWtaIU/PgT210DeRw/K6YeFk2FdB2FdbPmWIwGxdamsn9iA1HMDLG
         Qq7LuTF/pNqnk/RX0M7a2vU+Vjp3tkp4MNCS/jJvdg/G7rYOoXLt7SI5q9EaUtkK9nTk
         KUJ6E5TMzH8Qh8aJzAKJAHovMK+QXD4PHLxOJFF8NzS1JCAcPAzRZwA6Y8Wv4b3/Q0gr
         FYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjfPnUXitcaEyLb5Ye8HhEqApHDKZLLqufapqIWXgL8=;
        b=QwfPJWy3di5xhALw0Ns3hYlO9HBOSNdvVco6Ii+yEXJHo8/g9j2ACJ4oGhI10CRQbw
         2uC2DjzLCikvhJDMbGED6gubeMre7Zh5jy6n/dHPSQbWGBNlKXp2hx5vKYxuDXUZOR4P
         58GLGAtg/10gUqX7+QZp01dhy7dA7gfK3DfK6XDM+K9utkZ7AeApdKm+vdfBo+YDjQ0V
         7BwCzy5IVQX7cx4uh2y3QcMcbJUKthCUXE6wyDgaoJnsMWUrt4eI/QxVR4aAfFgjIdNr
         5yo6swOiznxJDQ2DuD3f7OUulhZBUKaMkwaELajE0nfvws8ilSPzlnA11Vd5y873qaqa
         OhQA==
X-Gm-Message-State: AOAM531SIJYkclSt8yGRGYcegqF278gXYJ6Hku550blcXhbbBvRk9m+M
        9qqODiy19mBO17cxFuYUwkk=
X-Google-Smtp-Source: ABdhPJykYbDkLpeUh1OJK+m0GtK/62kLfNDDSNy3r871av3yDIGG2DFAjjVURBVdlmskAV5cgw80hA==
X-Received: by 2002:a17:907:97c7:: with SMTP id js7mr36071189ejc.84.1641238191535;
        Mon, 03 Jan 2022 11:29:51 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:29:51 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/56] staging: r8188eu: add parenthesis to macro set_privacy
Date:   Mon,  3 Jan 2022 20:02:01 +0100
Message-Id: <20220103190326.363960-27-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro set_privacy

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 32ff5b2aed34..75a69323e787 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -196,7 +196,7 @@ enum WIFI_REG_DOMAIN {
 #define get_m_data(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
 
 #define set_privacy(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_))
 
 #define GetPrivacy(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
-- 
2.25.1

