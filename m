Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078544837B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiACTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiACTro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:47:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82782C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:47:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so139696942edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7tVUFA5BpbcszbRDi/MJAUYJgI4RLmmnTJgCcr9+0M=;
        b=heyFdRRYgg7YwVoWeFAfVJ5q1HLtYbbPR3kC2W690sFeL2+PTDmeBqVVoCHpH+Vs5A
         DP8MYQmx6swGjQp5VrVSZ4Bk1bQYxKOd65PqaJArhKWOKiTHhUoZzVG05KX4XTGloXef
         auibkdNMME6R8bZkA83dIK7L6CuruUEJN8alVad4PoSoP4MWfUTC0ZwsShRCxak/tDj7
         59xKVVd2a4uSY1IYOpBDa2wNRmdg1Gk1ttXPObD0bxi/nZAawDZzwhNPmzOggYtSruKq
         YvKAFx7O63CMG6thd4Ja41gi86sP+ubajlZkzCuoKuXa0D9cXLgfoDQ97SNivaT5p3yN
         zHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7tVUFA5BpbcszbRDi/MJAUYJgI4RLmmnTJgCcr9+0M=;
        b=3tkEtuR0QF6dP0e8AvDqlGj58Hicun36gSp9VrkdjWjRd15RTNoTd3duOkXdJfPyqF
         uZIpLF260mpL/nIx0ZOJokYUQjVyBz0pnuMINYkY5E1aFXW60JBYJv/vgE7UlQ/nb91S
         VZSqHaf+y5Vc7qAX+8KcjZ7sBCHGzLymgbcQwUWLIBieL50qC6gvdN4HxHPNm98TDu2M
         Fle3Kr5wre2Y6854SPPuABZvEwRxH+1iOCZZW3c67H+ijTGHBDGjmKBvltS/xOoTtFl2
         8YJAn1Pg5KZka3b45UisWWhoMJSrZrLQN4rqOD5jtMnX9gnrpE+Cvcnae2rPsQRoceyC
         PsoQ==
X-Gm-Message-State: AOAM532bZOwNqwhCvy4h/kKIIbTHrlZrCJm36v4xVewJXJS6Zwe3WzVz
        vH61TrYqVlSaLat12IhI6PM=
X-Google-Smtp-Source: ABdhPJx/R4XNYPl1hQTuzzTIphVncq5o9AATQcvUa9xDOlrYm81FtXo83qeLTVGar0j/NB/apUSvuQ==
X-Received: by 2002:a50:e608:: with SMTP id y8mr45111653edm.39.1641239262141;
        Mon, 03 Jan 2022 11:47:42 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:47:41 -0800 (PST)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 45/56] staging: r8188eu: add parenthesis to macro set_eosp
Date:   Mon,  3 Jan 2022 20:02:20 +0100
Message-Id: <20220103190326.363960-46-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro set_eosp

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 45774d7a6429..8364b16dfd36 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -239,7 +239,7 @@ enum WIFI_REG_DOMAIN {
 #define get_priority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
 
 #define set_eosp(pbuf, eosp)	\
-		*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4)
+		(*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4))
 
 #define SetAckpolicy(pbuf, ack)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5)
-- 
2.25.1

