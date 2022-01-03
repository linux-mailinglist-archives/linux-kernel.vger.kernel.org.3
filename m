Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343564837AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiACTmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiACTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:42:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FFC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:42:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j6so139585778edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39Wwg7nzxy3GtT4f3IpfOYNOVPqDtDBOoO51LTom+cI=;
        b=nl0q0BmzrlY6u0fRr1zPHmw/tvcjfyE8Hwg3tm5jt3aBZR4qV/WuQYHg4LFFPHr3fD
         39jybTIu4PvEdWyGktk67NMa2attdKSin31FEO2UxoBdzugXKDPuR0TehMWkNeXHoMYE
         aPyVloy2ZUl9ZiJrfQE3GzOh84dqmc1DGz65eBSgnKHvgTUrz33afFUop5IcHC99Y/g4
         kEihHE2tTJ62SZsgtBKbHLYEZCc55hLAG8uLKPqWEz5JVXKFshOfNNXS73O+6dpsERqR
         u+ukYWWFZdldqKeblw+FZRsHnK6+0ka9b/GgdsMg2NeDJF5e5enyfeguwbkaCAPDDmlc
         9NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39Wwg7nzxy3GtT4f3IpfOYNOVPqDtDBOoO51LTom+cI=;
        b=hh4BJl/4u+sDiBxl5AJ0gpPJC8qqsBxCNRttYRYh5Y22XvcMwLgSKgkDtbwcsF15aR
         fH6bf5Zr577cxKyO5qcvGQawdefbcuBA93W8jLNZZCdso4GTodSXaBnSz5EviwMeF/M3
         ww/xU8wrqYh9CkkHqkAM8Zhjd3ekInrjsFYEGrrYjjBdmDoB7cUy1dFnv3q3mtx5jLIB
         cWvg20SAcWejPLh6MAbGSVgp3SL3BgYlPQ/hzKNOHPXVf2gFlOzbxmydfwlwIm1wrfLP
         NagjZlj6kSqRe1suCK797BHrkdGz26szwl4sX0zMOEObbFCJSaLQP5xMDexp2mf1XiYZ
         5EUA==
X-Gm-Message-State: AOAM531/pmc/hUTAr4Ti9cadnxmKoRd2DHqac2yNfs4L+jTM//lqYkuN
        FPqGg08jPNMMsvE1eh9bC+I=
X-Google-Smtp-Source: ABdhPJyZbdFy+lLevDUgsS/Q7/xL4wLbM789uHCHKsiiqN/MiktlmVozlIncgNp6APQZ/DVOfTbOSg==
X-Received: by 2002:a17:907:7d8f:: with SMTP id oz15mr36773355ejc.245.1641238925324;
        Mon, 03 Jan 2022 11:42:05 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:42:05 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 39/56] staging: r8188eu: rename camelcase SetDuration to set_duration
Date:   Mon,  3 Jan 2022 20:02:14 +0100
Message-Id: <20220103190326.363960-40-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetDuration into set_duration.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 502b3ee523be..45cc7cbed156 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -309,7 +309,7 @@ static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	set_frame_subtype(pframe, WIFI_PSPOLL);
 
 	/*  AID. */
-	SetDuration(pframe, (pmlmeinfo->aid | 0xc000));
+	set_duration(pframe, (pmlmeinfo->aid | 0xc000));
 
 	/*  BSSID. */
 	memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 5894d10c1652..275c6fb0cfc1 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -230,7 +230,7 @@ enum WIFI_REG_DOMAIN {
 			cpu_to_le16((unsigned short)(0xfff0 & (num << 4))); \
 	} while (0)
 
-#define SetDuration(pbuf, dur) \
+#define set_duration(pbuf, dur) \
 	*(__le16 *)((size_t)(pbuf) + 2) = cpu_to_le16(0xffff & (dur))
 
 #define SetPriority(pbuf, tid)	\
-- 
2.25.1

