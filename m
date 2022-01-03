Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50D4837AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiACToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiACTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:43:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DDC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:43:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id n30so27609788eda.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Hcx6qf2z8zaxKbx48tBFA06IHix8EgYxb5MO0mrtiY=;
        b=iNoZ9D2y7Y5bYPFu3dRhpKXnYE0flZ3dqJjUxElDlw7Y9ulebMOGRHVv9FMjQlaSm7
         uXZ4i6S1+SADLDgJBv/FLZqI4Ena5peEJVEHixaK+2AMwykJ5Uz3qg/R0Z18kKLgM4TW
         bnDNeR6qQYh9z6g8tRjDZkv170dhtif2M4eFW9CVm1CZXI034ImnPsbxvjb3WWIAFtbc
         azsHPeVxUl3oa2AMUgMiFfe4CuSbInbJ1kLDdRo0554TiXK20ZfhjyFqsy8yOKec9BP7
         qUyBWexHrmIakLebi1qAqnkFwBpR324hrv5d1i/JrAkEfQM9YCUl68yBIpTwI9G/jgbp
         kE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Hcx6qf2z8zaxKbx48tBFA06IHix8EgYxb5MO0mrtiY=;
        b=Z1p67gt0BrOtWhTks4S6x7ygrK3unIQ5a1msgBepfkCsD6Lk5DKyOJqdSvG3k1MLyf
         R1DI9k/w7Edhy2n8iRrxMwhXt0RViOXaQR+ithd6TRgaE1FbBlqimDQkb96fUH8ijYbi
         6V0byZ4jutzWm8PyOqn6DlD1IjXH+evUJPgkLLHxTKjH7bzOXPEV5f5Yl5+K+sJ3sIvZ
         bY3GmczDof/fjCLHYb3d/pnpfhQyNHgJAOvhOnjfExQPPvXvRLlV4Sy1VgZw1RiwrwKG
         BSioNcOJICt/T7FlyK8M9yka26kv2zFPyvrAlnWpUNQPuTC4Md4em92gtaAGZwn5m5bf
         OytA==
X-Gm-Message-State: AOAM531cna+oGYgFXOE89nmS51hAUWU0xMY7OGLgd7HWEPLvNRGYVWvt
        ht3e44VC1BzXs+0jI+lh5lU=
X-Google-Smtp-Source: ABdhPJyI9G9iuvccfJnFKinA+loTzbXmXADO0tOmibxDQlEkSYIhYkOzkxeBHfqaX3AEXSU+cRgvHg==
X-Received: by 2002:a50:e608:: with SMTP id y8mr45102596edm.39.1641239037566;
        Mon, 03 Jan 2022 11:43:57 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:43:57 -0800 (PST)
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
Subject: [PATCH 41/56] staging: r8188eu: add parenthesis to macro set_duration
Date:   Mon,  3 Jan 2022 20:02:16 +0100
Message-Id: <20220103190326.363960-42-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro set_duration

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index f1955ddb6460..c2edeefe452b 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -231,7 +231,7 @@ enum WIFI_REG_DOMAIN {
 	} while (0)
 
 #define set_duration(pbuf, dur) \
-	*(__le16 *)((size_t)(pbuf) + 2) = cpu_to_le16(0xffff & (dur))
+	(*(__le16 *)((size_t)(pbuf) + 2) = cpu_to_le16(0xffff & (dur)))
 
 #define set_priority(pbuf, tid)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf)
-- 
2.25.1

