Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB94B16ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbiBJU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:28:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbiBJU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:28:16 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F5CB85;
        Thu, 10 Feb 2022 12:28:16 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id j14so9690531lja.3;
        Thu, 10 Feb 2022 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAkfLqS1mn3oAfFq28iNQnGWVtiunNgv+AFmscduaNg=;
        b=XUKFP8rJPo9/aEd2lZb/1SLDebOiI5bN08CSRObyr0TipJnB++WKsWZNipwulLBg5h
         rLBh5j4A9JMD1CLTs/pbCDuHWPYsFGp2HgsuaQOt41mpegXKt69xayhBbKbhBs83dTCi
         52bhXpyw+YHnNr12FRi+PD/Pr7Aiptpz0v4cz11nW+SfTcllK6v4A/XVFOI3HnsCS2A2
         0JZ0Hmq9T+IIb/tQm3P5oIkADalBdldEQBs24ysc+scYr5D1uPcvLHYcmHnjb+fvQ1g/
         WiZDKQy6VjjvZjPoEQHZ0A4nsmw0CFeVa0x+qXPlKwZt2wFS+VTwigCkDfQd89M27yDH
         TG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAkfLqS1mn3oAfFq28iNQnGWVtiunNgv+AFmscduaNg=;
        b=MkxxMS2J1l+37i+NmeGgI3hpJ4LPAgmekC2udS7ZWCl7xFe3KirArGfYQc7cPDt5RW
         a6Y6MafaE377/ipZ2ZR+RmnzGRb5XUZ5AixAuxkEdSt/u4VXGKl8an+q5PAyy84jzIQt
         CMfqJtY+EE2fxJTzJveFf/d7NQh/S7xPdrhFafLYJvbGjO01E2cedONF8swV21ayF5nF
         gDeiBwCJwjRVdZHqCFKt7+dJ6OYA4iml7blp6FIzQYXFoHedZj/mrcPVhxl2Ry76KvEi
         zreg3w8nD8VZh3nhFtd2CaKngShYslG9Yb1IpO4jfIUjGsF8kCpnPMWBrCNKUuPaoksW
         oSig==
X-Gm-Message-State: AOAM530QJHCxvKow+yV2HiqhWc9VO66D7bFYHT0zJpqPwlXEuHQbm0/V
        uX3jlrrTYxrUlzrdc5gUXyQ=
X-Google-Smtp-Source: ABdhPJwkyCZXBAi5XHnv9zFxw7zDY3V2YycrQwOLfPm7C4KciMKRmBBZQt6l+06emCum+AlV+5o7Mw==
X-Received: by 2002:a05:651c:1413:: with SMTP id u19mr6114885lje.240.1644524894855;
        Thu, 10 Feb 2022 12:28:14 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d19sm1223881lfg.108.2022.02.10.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 12:28:14 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] crypto: omap-aes - Constify static attribute_group
Date:   Thu, 10 Feb 2022 21:28:03 +0100
Message-Id: <20220210202805.7750-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210202805.7750-1-rikard.falkeborn@gmail.com>
References: <20220210202805.7750-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of omap_aes_attr_group is to pass its address to
sysfs_{create,remove}_group(), which takes pointers to const struct
attribute_group. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/crypto/omap-aes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index a196bb8b1701..581211a92628 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -1093,7 +1093,7 @@ static struct attribute *omap_aes_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group omap_aes_attr_group = {
+static const struct attribute_group omap_aes_attr_group = {
 	.attrs = omap_aes_attrs,
 };
 
-- 
2.35.1

