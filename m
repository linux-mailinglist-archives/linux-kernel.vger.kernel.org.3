Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726DB4837BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiACTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiACTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:50:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D2C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:50:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f5so139792726edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBCtfraAmRgogN+TWk2b+fgrpyt6FHhijN3lm5IyMGo=;
        b=JzwE8OC+fCMIVb3rBIi/xQH4TYFNbUi8v0d5H78d7WUSWqRTtbrdU22axLUwCTVngR
         wMmjtxQyRYDHHMf/iLecPAjUm/O2L8wQznXROEYsC2dPSGLP8TvHqBhAJf4d1w01GFyM
         nclmr4Mb4B1GFDWTasgqPNbf8UO35b9NlW9IStmOinMIipN5BgJ+/wn2NxH5R7wtluFX
         tKEuEGwppVgVgZABG9XBjq9YJA1ygWDMZFupnIWxaUJKFKJEhScmJ7gZTZSsQFtVrr0/
         Bcj/Jc6djvExOAg50xTEujsALlX3jS5pOfiL5Emu+L5dfN4BEsGLi1dL3/5yWA5QL7uU
         52AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBCtfraAmRgogN+TWk2b+fgrpyt6FHhijN3lm5IyMGo=;
        b=j45XsM0H8xS+/oP0uQtg3oDQZywYgH08mVJCsbKfZneQ3cAKaeBPnwj6N64TsUWTJI
         OZcFm68Cs8uLOw1xR8AsO9eu/rA7Tfd4k4aoiK7Q1yy1zmMtb5qf2gQ49w0NKPsOkm2t
         kLNdex1FuYM8jk0hKxlLf8esUJgUK1fyTMMqc4xWdp+QGiKiN2b1G1vfn8Huq5h9U33M
         s7+O9eo0LxLNYw+BIfyoyCMVFbSZlS4KvwGyiS8c6xIi/KRxG0OF8Y6vcihmvYGtMhs7
         albu3Tt10BIfLzg+IdJODTOF7fQUa60UzUD3PwTL5iqXs1LEw3Wf9EZh8O1TP/dhVRTG
         RhCQ==
X-Gm-Message-State: AOAM533OHOW+hMQR0abp9CtknklbGI4j0uokv+RbB4zd0YFZqCFSfgJK
        fBwUUpqg1URg50CcbQ6Xt+k=
X-Google-Smtp-Source: ABdhPJxXdT44TSAg1vs0//faejxwIDsltTZMMfc0YXca1vWx4ZXdQGUkDuvnESkhyU7BNbNDLLpzfQ==
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr6730576edt.379.1641239430745;
        Mon, 03 Jan 2022 11:50:30 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:50:30 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 48/56] staging: r8188eu: add parenthesis to macro set_ack_policy
Date:   Mon,  3 Jan 2022 20:02:23 +0100
Message-Id: <20220103190326.363960-49-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro set_ack_policy

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 75b54ab0fe9c..584161c9b5c5 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -242,7 +242,7 @@ enum WIFI_REG_DOMAIN {
 		(*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4))
 
 #define set_ack_policy(pbuf, ack)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5)
+	(*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5))
 
 #define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
 
-- 
2.25.1

