Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379554EE3B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbiCaWBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiCaWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:01:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB815C862;
        Thu, 31 Mar 2022 14:59:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o10so2125893ejd.1;
        Thu, 31 Mar 2022 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwHbdjP10TRRqI+6Tt9UEWSARGjNpA5V3m4oa6S5RlQ=;
        b=aASkEwbkLgFVJ3ep87CW9QgvRZdGtSX052nEzPHRP51D9EaleRKeUfsayNKhOkNg/8
         0cdjUc0ZaW0o7HjCU6Unzo3m/DLfVVqgiryrJE4QcCt9gBLiJNW38hcui0Lmq3OYqPj/
         8DR1WNyKoAuQb9zQ34GR7ZpGqiV+B0s91iBCkkFIVT5MAdIQSHcL1UwG2Jg6xk6tRSSF
         0a+8krq1QY0MfnzBv/HDtAT6vrY36Q9cvOn7fWBd0CiVOJgQCjChGLsE1N8loauow3q+
         ly2V0YOkfI5813+wqRSxobBRSX5mO20BvV6l+SCDUl98Hzbk0wYkbD77gmN2OpZYA+yy
         0QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwHbdjP10TRRqI+6Tt9UEWSARGjNpA5V3m4oa6S5RlQ=;
        b=lhnApqAqWgwn3/9ulcMd4MSfWIPlEQmvli6A6HmbK67pIN6v5aVEqgIgiMezCElsjW
         Mb3C1JlWvMQKwzRZXyUuLsYSorD9KRgfjyZzfQFRtieBMt4eBsgH9Ok0jc+jBHA8oOdm
         RwLZWV/A1ouKiScHWKh/SKuzxjGyn5I4Ems/HNtA5sdbQSawCMOEIZZv7Fb+hCER8Um+
         GQKeLvNgT82wNzfCoVhA89K9Ip5WDz6DhhtuTCH4iIzqI6CzWPyI3DHlVDpGmz+w5GdD
         eezVuNFPHDKXmZ1VsbbX1YPP7ZAvhUlGzZTbOqQQO0yrGoSzE8DTpNeN5M62wyLLcQHQ
         DzcA==
X-Gm-Message-State: AOAM5306avRJiAQi5raDDktLzfMDqFbawpWhS3MxI9k0gEyP4Dv9Ety0
        V9pSeow1TkPDWkjkdbx+z1k=
X-Google-Smtp-Source: ABdhPJxFKZ+BPTbRvDqwWxkLmLmqzNgHdtbJLCGlKtGaAZgT4VKqZKOI3TgvhAoAoCOOVpxIwVHzXA==
X-Received: by 2002:a17:907:971e:b0:6da:8221:c82f with SMTP id jg30-20020a170907971e00b006da8221c82fmr6683849ejc.443.1648763991136;
        Thu, 31 Mar 2022 14:59:51 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id m20-20020a056402431400b00419315cc3e2sm287799edc.61.2022.03.31.14.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:59:50 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee.jones@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] crypto: cavium/nitrox - remove check of list iterator against head past the loop body
Date:   Thu, 31 Mar 2022 23:59:10 +0200
Message-Id: <20220331215910.884374-1-jakobkoschel@gmail.com>
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
 drivers/crypto/cavium/nitrox/nitrox_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 6c61817996a3..432a61aca0c5 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -269,15 +269,17 @@ static void nitrox_remove_from_devlist(struct nitrox_device *ndev)
 
 struct nitrox_device *nitrox_get_first_device(void)
 {
-	struct nitrox_device *ndev;
+	struct nitrox_device *ndev = NULL, *iter;
 
 	mutex_lock(&devlist_lock);
-	list_for_each_entry(ndev, &ndevlist, list) {
-		if (nitrox_ready(ndev))
+	list_for_each_entry(iter, &ndevlist, list) {
+		if (nitrox_ready(iter)) {
+			ndev = iter;
 			break;
+		}
 	}
 	mutex_unlock(&devlist_lock);
-	if (&ndev->list == &ndevlist)
+	if (!ndev)
 		return NULL;
 
 	refcount_inc(&ndev->refcnt);

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

