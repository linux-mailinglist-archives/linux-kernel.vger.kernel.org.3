Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8CE49F4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbiA1IDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiA1IDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:03:44 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E262C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:03:44 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id y8so4541049qtn.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Wg7XwhpkBlxQ7Zn7O+lCnTmNTHWAdRJsDjrjJqJaew=;
        b=fQ221tAsQg+pKiAcm8TATyw1dOzqu37v2bzND6Aq0J0TGNG4dOdJEUqjYje/IrotmG
         P/pe2btc2C4icZHt18vTpc0FoRNxwanIjkBffykfDyGCd1Cn/Skoy8wW+CxtBX2ih052
         mAZzqwxv1SW+pvkMOOjTxJkgJt6iBH+dYQZJmt7GtA5TbBg2g8vLJUlenZMVSuF/60P1
         xN+zgHleO7QkrAKi/Rgva3UkNdO9j1xpTcYtW2z8rpFK4PuL0DKeCgl31TSW+8gIuq3I
         QB8qBOBB4B/7nzngHgzmbnb37LPlWYjcVr3ZboQBuPLOeASNeb1Kf0vfdqI8OED9guwv
         dBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Wg7XwhpkBlxQ7Zn7O+lCnTmNTHWAdRJsDjrjJqJaew=;
        b=AmhxtNg3jnmhTVsAjC1QN+N02o17wRAL3fA0ATQXICAR1nAZIND57J25g+Gql2u4RG
         IszKAbkUpViJ81Lc2v10LEqyj9HXLK+hPyiXByZ87SqQhATjQ317JHQYVfy6AwotULUF
         GRpxBbtbaqWuSXrNhiRWWTrT2hRLo0F3dLsMUJvnEFxjhowpR420Ld4Uo2I1MC3spH0S
         JtQLPilFpxHxu6BamUREhU3OeIfzgvzA88CD1G3Aj2hiUgtk0m2K3Ds6NFPoBs7NCwfX
         FxH+YOSHprDqtmS0+7yWe1KgrGrPrExvu4JoPKYgIq4CIDOXVVqZsjJyC0eKVziFEEyN
         XeaA==
X-Gm-Message-State: AOAM532UdL052vsv1UE5IHI2fMkfmGgzIs02NNC6HWQNfVOCirKTqCiY
        IpoHeeUHRMOmcHKpbQYIfouJoMccXAI=
X-Google-Smtp-Source: ABdhPJz9pVE6aeCVWJ4muL82r2uwIymglsccSxGIFVQel4wWMSYxuJWH+4/rPhXwXx6QRJC1RzLJUA==
X-Received: by 2002:ac8:5c49:: with SMTP id j9mr5389792qtj.365.1643357023692;
        Fri, 28 Jan 2022 00:03:43 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 195sm2779409qkf.30.2022.01.28.00.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 00:03:43 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/firewire: use struct_size over open coded arithmetic
Date:   Fri, 28 Jan 2022 08:03:36 +0000
Message-Id: <20220128080336.1211525-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kmalloc(). For example:

struct fw_request {
	...
	u32 data[];
}

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/firewire/core-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index ac487c96bb71..2e9dd988ed0e 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -777,7 +777,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 		return NULL;
 	}
 
-	request = kmalloc(sizeof(*request) + length, GFP_ATOMIC);
+	request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
 	if (request == NULL)
 		return NULL;
 
-- 
2.25.1

