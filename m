Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553664F8C5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiDHBPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiDHBPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:15:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D212C269
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:13:00 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso5154868otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V186V90RiRmSVhYLVlMF6iiT3ecZIT/E9eNPXMmo4Eo=;
        b=KzqZ51TorGTr+EP4j1Irc0/l1JWL3v0ZeQeQ16VJYgSDkRq+sNxnwTlNRZVV0IWojs
         WQQVEYmPDmqd5F7C9pZsNAS84Ou89Bqhf5YQlEGOd2t6PWoUMk2GSVWugUns2w909MMV
         ERfuSP04FvFVGkG2W0L2aeh/Sp//gHF3AirJpN1DTp3JD6Osdoh2Syb7MQfU3ZMoIVgw
         6pRwPqDD5wu3HAcXMUNJ7jB614ZHPLlFGLl44NsADqzMYEOtr/LHZeM+FE8ukEo23+Kd
         jhdu5qIvBIUaKhV758KOxoiaTL68RIkDct02h70SB6xFg9SKlEeWDN2x4MbgeoEO9Rsn
         5hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V186V90RiRmSVhYLVlMF6iiT3ecZIT/E9eNPXMmo4Eo=;
        b=W1mopnITYPDmG2HD7B2VZ8ka5ZEY5qPRc90HPD4QBMRQSOm15kcYHhxgobTVXzjm1i
         8QfrIR/PfOMO8uIG+X4wqTktrjl0aephFR41qDhx3/JDOF/12E+z0YewMD0IEPBv/xtH
         ywX+A4nPxoh1ItYnLBU5Z8a/n/5oRR6F5kPWFDqD1eFtVuOeKGgDD6Cq9zJ6GUc1Veei
         XpTopw7g87uGGOkTqDJJezzWpUOS1IyfGcd82s7XwAFlXXUEv1o562d1Gs7O4zJWQ/U8
         qJoJKRwOaE4dAeVZ9CgPyN4CAsj+0av/UiaKQt0AH1eWwzGhJyU2FmpxE9uxZNSEFXy3
         WQEg==
X-Gm-Message-State: AOAM533zT70+Ws/tGL4w4Lb7klTwRDFURMW+qZCt4wiwHX4aNoNqHmKg
        2vHSzzQYxdnbwRLhk/AIKH8VX31jVyEbVw==
X-Google-Smtp-Source: ABdhPJzZKHIkem/74LcdemHmPZpBbGzGk5KDr+8SEfEHP2t0L22fTvCTXMa5FPyf+5uOklWnehas5A==
X-Received: by 2002:a9d:ed7:0:b0:5b2:236c:b6cd with SMTP id 81-20020a9d0ed7000000b005b2236cb6cdmr5878979otj.31.1649380379842;
        Thu, 07 Apr 2022 18:12:59 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id h59-20020a9d2f41000000b005e6bbde77a8sm602544otb.76.2022.04.07.18.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 18:12:59 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8192u: replace ternary statement with if and assignment
Date:   Thu,  7 Apr 2022 20:12:50 -0500
Message-Id: <36059ec66a2f3d58a8e339aa4f262772eabd3ef0.1649378587.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649378587.git.remckee0@gmail.com>
References: <cover.1649378587.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ternary statement with an if statement followed by an assignment
to increase readability and make error handling more obvious.
Found with minmax coccinelle script.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index 78cc8f357bbc..9885917b9199 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -470,7 +470,9 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
 		return 0;
 	}
 	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
-	erq->length = (len >= 0 ? len : 0);
+	if (len < 0)
+		len = 0;
+	erq->length = len;
 
 	erq->flags |= IW_ENCODE_ENABLED;
 
-- 
2.32.0

