Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9C4B16EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbiBJU21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:28:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbiBJU2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:28:17 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A0B84;
        Thu, 10 Feb 2022 12:28:17 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o9so4826728ljq.4;
        Thu, 10 Feb 2022 12:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JFFc8Y8S/MJQV0pUH9CkbsR9iY9FpiUIqHH7t3EabQ=;
        b=iZl4wrtmPfNa48F4sIiGoav74iUIdFBNW7q/gQ7yUbZdO5dNdDExqFSlRI0u9Jhzef
         PM18OYFiAweR7Jh9wQbKV4Aixul3Dr1IzqSxmREUOgnPNGCUWfe+TZ3xmQO9gvr/Uaij
         S2/NhG9r2raBmVJK4GgsUxshaC773FXD2CP9y12gj1uznvuwMNAPnB4Co4d5dX9Ke4eH
         PERH7sBAGPvgWZ6xWTL0S+2EuI+vntZY+hhmCbJKc/po8s2wq8HR4mAo+A28RiL5pkiC
         u4y5rpUQwvdjxjdxlCzKMPLqz9ks5/YY9l+y7/LW7Fgt6CsyyKIzr4V7vrgk6DS7I0qU
         UYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JFFc8Y8S/MJQV0pUH9CkbsR9iY9FpiUIqHH7t3EabQ=;
        b=S1peldujEHPjQbkUtD2q2iiwrMjdiL+rXcDB1BRzI4aroUHHzLy1NwpABGuXIJ3S2m
         guHokoeyvgC/piKC9+OtlpppHDgwDS+zdabkoumMkARUtBaZPWhwAzQXwEBCVvumTAg6
         vdwKODRZ0BorLyIkCBCUwxkhTQMpp2+DTB7AFV+bvzZTVXkYW+yO4agfJQbvHAV1jk74
         wor5k0mCbQkcFEgHaSOwkQamzn8o0VMLDXMxI356aihp0Ars0JvtUyEHuB8LaJzz7ywL
         2axiU/OLcEEyf4xgztLfiyE+cXbYsQQz16q1k0o7uVroE7wGbAa6lFCAZFzOSYxdh7DC
         WXnw==
X-Gm-Message-State: AOAM532+mvIdl0G4PG22XTJ2tonmsA/Kyf5yAq0I4WEvozfQ9G+jP7ji
        x7Z2xzhmmUtIZ2Cg7HFSX+E=
X-Google-Smtp-Source: ABdhPJxcR4HoAHzNcSWE2AHYc1G0dBt+nW2gRreDLBkUU1o2TFUZIlk4JdcwFpJMibKBogBF9NjTuw==
X-Received: by 2002:a2e:bc05:: with SMTP id b5mr6306919ljf.10.1644524895942;
        Thu, 10 Feb 2022 12:28:15 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d19sm1223881lfg.108.2022.02.10.12.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 12:28:15 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] crypto: omap-sham - Constify static attribute_group
Date:   Thu, 10 Feb 2022 21:28:04 +0100
Message-Id: <20220210202805.7750-3-rikard.falkeborn@gmail.com>
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

The only usage of omap_sham_attr_group is to pass its address to
sysfs_{create,remove}_group(), which takes pointers to const struct
attribute_group. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/crypto/omap-sham.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index f6bf53c00b61..4b37dc69a50c 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2045,7 +2045,7 @@ static struct attribute *omap_sham_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group omap_sham_attr_group = {
+static const struct attribute_group omap_sham_attr_group = {
 	.attrs = omap_sham_attrs,
 };
 
-- 
2.35.1

