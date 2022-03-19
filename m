Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F7A4DEAAC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiCSUhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiCSUhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:37:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A9018F236;
        Sat, 19 Mar 2022 13:35:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w25so13862646edi.11;
        Sat, 19 Mar 2022 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOMRj1XVqYhfRtL+8zbvkj9G0h1ouLrO0mIz9DEaP/E=;
        b=TvlksU+FJkEucyu3UgBU4m6nfRwZuyAMLjIXpohgdKCofMKVS5LvjF+bIXTrJPsLOc
         y8WCJxgDdmHw042HSGqEjFEqFTfZSIpJg4L5KqLEbsz9vEWSQxkTP+HvIRYiw1E6j2aq
         FbApQMa9hSO0zP9vyO+wxG+9Zmmsve/z+y771TUIaqj8tgxEQ3mmRRFdOAhGLtvwkpjQ
         /56SP3xmKbhVSOr0RnviOc7WYySYYxcAfnZt/fW8LDu0Ex7ROsb3tt/zDYAkAKq8HHus
         tuFd7/Sd/Ia2cX1CPA9c4c7rhIHKU4R4hgccO177OPNN9+dCDmLfEBt06H1WHQk44rQt
         TE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOMRj1XVqYhfRtL+8zbvkj9G0h1ouLrO0mIz9DEaP/E=;
        b=d08IVXJ+QUxKe2QVFIXPdEtNugsHjrrP+fdckCfD5V07SjqqjsRdILjst/wthMX8/U
         SWO31/mov5NkeQsukys1EEFa/WOnx1lsMKpX3WiCMfM/Ale4oqbnHZwjUFTxgJX3S1QW
         cWos9NrH6M+yUDZI9FUm09hjM4KY64mcjxviBzgJNq+ZfCE8eseF9nv/d19Dx5m88LEE
         Lwjdt7vgE6l/0PrN2MkBxWRY/Xy/y6kyBHISMiidcLD+ZJGVo2Brb4pX6cv0jOAmCdSj
         U9kHXeOvPtb9Fk/t9ZUJ9+btetJoAlwsu9iQDdCLIR1Xvd8212JmCYdyRAzF2DHe241L
         bsHA==
X-Gm-Message-State: AOAM533lt9QUJhu2yvaH8gxLh5JU+SUx4ehIeARik7UnisNSKanGm0H/
        zUr96WTyA3avL7kpGuCsloY=
X-Google-Smtp-Source: ABdhPJxEpg9Gmkt07PqFpEehx1FIoR0dX7G45r78ie8gajWqaZ8/PF49pd6BwbUiE9b82V1TUIChfg==
X-Received: by 2002:a05:6402:2794:b0:419:2ed8:f36e with SMTP id b20-20020a056402279400b004192ed8f36emr856674ede.44.1647722151064;
        Sat, 19 Mar 2022 13:35:51 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm5181902ejd.18.2022.03.19.13.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:35:50 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] s390/zcrypt: fix using the correct variable for sizeof()
Date:   Sat, 19 Mar 2022 21:35:28 +0100
Message-Id: <20220319203528.2552869-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

While the original code is valid, it is not the obvious choice for the
sizeof() call and in preparation to limit the scope of the list iterator
variable the sizeof should be changed to the size of the variable
being allocated.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/s390/crypto/zcrypt_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index 3e259befd30a..fcbd537530e8 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -90,7 +90,7 @@ static ssize_t online_store(struct device *dev,
 	list_for_each_entry(zq, &zc->zqueues, list)
 		maxzqs++;
 	if (maxzqs > 0)
-		zq_uelist = kcalloc(maxzqs + 1, sizeof(zq), GFP_ATOMIC);
+		zq_uelist = kcalloc(maxzqs + 1, sizeof(*zq_uelist), GFP_ATOMIC);
 	list_for_each_entry(zq, &zc->zqueues, list)
 		if (zcrypt_queue_force_online(zq, online))
 			if (zq_uelist) {

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--
2.25.1

