Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA144837BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiACTxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiACTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:53:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE77C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:53:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w16so139895664edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3thxqyHADyILlOXoWfVQ/+L3dqIHOY8Hktm+9JrG0s=;
        b=RA3fHvP6sjzHRO13u27hOQbt4NTcNKrqKM1apv8sk2jSB/+dnIj+HcT1qgoL1dSmRW
         L53OgO9FULFiszzhO+6ifkXo/FXiVnNPWmaKT6UT64jAoZdYZDml90M/q8YpfpoCkQsl
         fA9dOs1N08Xytk0QJhgUX4+c31w9myiASEAQteMvz2BgpEpIRpMYQgGUkbQ0FSlVZ4g3
         KOE5JK4VogH9BZ9lrb0ohgOuRzzn44Zb9/nbwZkGgQB2tI7gKiP28Rwb1/VAtbyvAGV4
         1OQ8WvdiSVXGKuvM7f0XdpufyrBxD44r6c3lYeSRUrUvfc66j8wfYx0ZCEke4XJVyfAV
         WVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3thxqyHADyILlOXoWfVQ/+L3dqIHOY8Hktm+9JrG0s=;
        b=NE6KdthPyJDeJZt0lkorrxDV4c7RRXo8rtE/MJR31EKglG3PvVxSn5iHiph4O+158m
         L6WbDspRZEMQN+X8GXXOwwIiLID+0xUSM/6SWR21/QeRpcsO/Mkk+yS2DVOsIDMAjHay
         WWlUtfJ+fcwIEMcJF+44Fd9ZlHEiBbNWf7CMEZl5wFE849zIbopFXCiuwsnZh/tYchtt
         7fQDz+/AxVAfgSzP7JdV+VwrQ6OFzvpo8b1gXnJZefWXxTB6vK+HLjClJLwwdE6rrGe5
         7o6f8z7v68b9AWj+C0Ji7MmG3MoFwss2UzSIwilme/dZfgkofAKNuzN7h09pKl4EMc31
         haVg==
X-Gm-Message-State: AOAM533qqvwDMh5HWMIEkIfXqao8JeVuuA775wmB5bdthh6Mo9/qUlut
        sRJ29kyqkcgcuR1JiAEQLhI=
X-Google-Smtp-Source: ABdhPJyt0OQmgAjebYtBz6OL0xisq/ruU5K/LA7kf0th1Bmzl1jkAziDG2afDGYQSvEC9KRw0Zty7Q==
X-Received: by 2002:a17:906:26cb:: with SMTP id u11mr21082371ejc.630.1641239598514;
        Mon, 03 Jan 2022 11:53:18 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:53:18 -0800 (PST)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 51/56] staging: r8188eu: remove dead macro SetAMsdu
Date:   Mon,  3 Jan 2022 20:02:26 +0100
Message-Id: <20220103190326.363960-52-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro SetAMsdu

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 7a42031ebc15..63f1b0a974f4 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -248,9 +248,6 @@ enum WIFI_REG_DOMAIN {
 
 #define get_a_msdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
 
-#define SetAMsdu(pbuf, amsdu)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16((amsdu & 1) << 7)
-
 #define GetAid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 2)) & 0x3fff)
 
 #define GetAddr1Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 4))
-- 
2.25.1

