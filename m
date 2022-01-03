Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696CA483783
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiACTWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiACTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:22:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED671C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:22:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z9so69611611edm.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EsOC6AZp5IFXMmkUsnZBB2WWUEffS5Y6nVu2ADk4ouM=;
        b=H62SBRjlrcRZMuo2L/YNFUx3qY3HVkDSVKGIG5rF433j5fr83aKtefwsH9Wj8SOaQg
         d88Pb8qoIpYEME0njVzqZDWCzyEdm3CmA0SwexwpcohLJLeo1SbQ/+Z6DcbfX0cpCWXF
         dtW94gyaoeMQj8pNivYHBiYQj5uDONYJpl8zsXn7fUDa0kpRe6h6h4gh6qBknxB1mdMQ
         Q1jh6FUFbnh7mwDs7FQ0Uj5VfUiU7oMZmELvYRY2B8BTu7s2CqfD/J7maqP7aIa41EuV
         03R5WOBYE4iRN4sfoDphCfWYMNQ1g0NOoFjA7GY/zhL5HHeO6cTykBkuO9xAGhQlQVBl
         oYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsOC6AZp5IFXMmkUsnZBB2WWUEffS5Y6nVu2ADk4ouM=;
        b=7Q+v7u/irptWjlDdwcr1vYMeaBxCOEqFB98TjKDl3gkQj2149n9c4W54YYHvfrx6ts
         ijvNcBmzyxqlXEo8613fv2gZfKLGO1fQb2baR2PmlPf0gUFuwrJf9H+xCxK0iPPNcAlN
         gVJBxKqc28AqtB9yTo1K+Wqy7DVfe9GYAaU6U2oOxERFELVqNzW2ufbQi8clylRfquB4
         j3OW5Spy0NXw18YUWIxOb25r1rTeuF76u0imb6eKHZZedZtye6oUWVaCTUmwK2flzS4R
         gSG0z/+zw2oT9wWFdSN6mRLo+Go9pJMgVDTZX9PoPFQ2TK4IqIVgOLV930g+p7XIsaGZ
         11Nw==
X-Gm-Message-State: AOAM5336CB7tmGD/b+C7wBxwQVBwJOvBnV6RJiB1zMTVy+Uz2TtqRgbs
        zcruO4h2B0JpSSj5Al8Kyy0=
X-Google-Smtp-Source: ABdhPJzFY9oNfYe+aeuwQoycP2Xo9a7p7VphlwmMqQk2ZX/+W9EqtVKhgtxUIpcdqUbpEGRPm2mvkg==
X-Received: by 2002:a17:906:7d96:: with SMTP id v22mr7636512ejo.538.1641237741505;
        Mon, 03 Jan 2022 11:22:21 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:22:21 -0800 (PST)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/56] staging: r8188eu: add parenthesis to macro set_pwr_mgt
Date:   Mon,  3 Jan 2022 20:01:53 +0100
Message-Id: <20220103190326.363960-19-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro set_pwr_mgt

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 3f16e9b9c342..4b52c4205a2f 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -186,7 +186,7 @@ enum WIFI_REG_DOMAIN {
 #define get_retry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
 
 #define set_pwr_mgt(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_))
 
 #define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
 
-- 
2.25.1

