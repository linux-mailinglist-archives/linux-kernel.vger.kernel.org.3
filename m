Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027A14EE376
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiCaVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbiCaVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:51:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FD15EBE0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:49:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r13so2042990ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+AgZQKUqsq1+AnGBtVl0q4kI8qPtf+1eQPHxbS6XOY=;
        b=a8QlGEuODtv7dv6tAXvEwp/hJmqzAXzu3j8YvyRaRz+AGeH4Ax4n7TL8vntDeIee1T
         nvp8i8+M7TMbyEv/5n9PURopEXrSB4OEgv6cu0VMMubbQSgnU4tt+6wg3IVam5gMyLID
         gObWZhKryebIn9UjSVEPp8764IumrJQi/+zy0QPzAaz7EjkZGgF4dDu/5ep2a7Tqty1i
         fDvCq1nljLV/mhqmBz2NWO5J29QjoaouoQYEPnofuI1AfbDTorotYY6+Ppk6aGwE1YT0
         /hcQyFxogsc31xpTXYKAAoPGIVKE2+JBXY64uVMNBdyMe+o7RcJEbz2uDgqisO5Tv6ig
         6KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+AgZQKUqsq1+AnGBtVl0q4kI8qPtf+1eQPHxbS6XOY=;
        b=ICS2AMvBTOvGoZHCAuwrtPUrSZeDe/AgikxpDQ+M5t9045TCe33ZJgFtBLZI+69zRA
         Ub8hVbbkNSjs0Jtu0F14/Kq9fMin2zRgbCU9u9rFr/80hy4ZZdoT2kEWnBgJg4nZMHDe
         VOVmycVroY3Cl/VvBYn4vF96tl2NCfJk8UlHcpWp5HicFw/qdd/3tiekb4/RCw4YXqIN
         PyD4q7QtMRnI4jrYKvHIhoNReR98VkKlG1VJi9PGr3gjVRgopLmuRbCmqtauy8gLNo9J
         2k2cpv20mNM2RGQC4BoEUs2oKM8Jbj9AVqTnnquGKqF46P0buTKNtG3xMaAxXynSdDG9
         mahA==
X-Gm-Message-State: AOAM530bq4WZdNlqLiPYRPd82N5DdEe+l5PW5zY/3X7VuGCmE5NUfSFe
        EUBIF9TSAYuTwzR9eJbGfwU=
X-Google-Smtp-Source: ABdhPJy3q6eQ1vwita+F9yugcGNCCiJ/l7XGlqcR9ZMt4+x3aGUEAtAQsxv2gnBH05HSNmNDlAqSzA==
X-Received: by 2002:a17:907:da7:b0:6df:9ff4:10c7 with SMTP id go39-20020a1709070da700b006df9ff410c7mr6609920ejc.106.1648763387998;
        Thu, 31 Mar 2022 14:49:47 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id b8-20020a056402350800b00419407f0dd9sm311698edd.0.2022.03.31.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:49:47 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 3/3] ARM: mmp: remove check of list iterator against head past the loop body
Date:   Thu, 31 Mar 2022 23:47:19 +0200
Message-Id: <20220331214719.881886-3-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331214719.881886-1-jakobkoschel@gmail.com>
References: <20220331214719.881886-1-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/arm/mach-mmp/sram.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index ecc46c31004f..f0c175903c41 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -39,19 +39,22 @@ static LIST_HEAD(sram_bank_list);
 struct gen_pool *sram_get_gpool(char *pool_name)
 {
 	struct sram_bank_info *info = NULL;
+	struct sram_bank_info *iter;
 
 	if (!pool_name)
 		return NULL;
 
 	mutex_lock(&sram_lock);
 
-	list_for_each_entry(info, &sram_bank_list, node)
-		if (!strcmp(pool_name, info->pool_name))
+	list_for_each_entry(iter, &sram_bank_list, node)
+		if (!strcmp(pool_name, iter->pool_name)) {
+			info = iter;
 			break;
+		}
 
 	mutex_unlock(&sram_lock);
 
-	if (&info->node == &sram_bank_list)
+	if (!info)
 		return NULL;
 
 	return info->gpool;
-- 
2.25.1

