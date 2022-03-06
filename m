Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B04CEC3A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 17:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiCFQ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 11:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiCFQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 11:27:45 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2173ED0B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 08:26:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so27108729ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2dDjTlTfEUCm91F+JQebdbRne3cQR+kMjBBSayN5Fj8=;
        b=nHOHc5o7/KlZmtU+HRXok9Ohf4nIlVZTSpbB8Q2UXDJDbjIuP8U3YYfe79cox50DpK
         htSHedokXfPJwu8+bZfGMbqYFS1hvVs4vjjgXlGZc1xuBhjRIzIx7wJkE0bkYpIGqHsC
         cxhJNaqyflpwoNamEmDUeUQeAKhctZQOb0CkYo5Gu0vhw0XXJtpmKGr7A0owkA9NIglQ
         9Xav26Eps6lhvQf6r18eaUN5FU8J6AO31pRUnxVuP0tVQUnDOVSfmWLnuFIjUB6TTRX1
         NNSGp8VPtE/RQIci+Y8VMYAOv42DI8JFtwsFbSYNBgrs2CqY2PeNabEsr+3/wmkgBXK0
         ZdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2dDjTlTfEUCm91F+JQebdbRne3cQR+kMjBBSayN5Fj8=;
        b=iNOwdGe0RULJsyKxFrZ0nGIIJMyyaglAd+6dqioiSjTX2R3hu3+uDamHqP3X9STE86
         6tLE+h6ynHHeQKyE/iViv1dY+33NsoBJLwbu6el3ibKFJdCM2eVTqC25mFzV0VWINBpC
         HOrsJKuxyx5PrpqqS/ZTo2gzYgrTJGZwxnNcSOpWmva2wCd3JdsZ5P2maz+fdJvVy2oV
         Vxe+G3vjvE8feIMOLMLR/kmgo8zLAm+SG3RLKmYqg1DF1l56wypI7P5Jhhh+JyBfM7+q
         STPEL2bh7pTX4wRuzO6+awNHCjer+5viWnMXPXgLJ8B8Sj/dL9jr/w90RDVOhW1dn9Mz
         yy6w==
X-Gm-Message-State: AOAM533I22bd7Atr2DzhZ6jiByZ2vfhCrHA7SojH9XTU6zSxF0jJXvPH
        knbfyOKaO83yvcSxRI2OBsM4tOo30Jer+w==
X-Google-Smtp-Source: ABdhPJzxglUiGXhUjIgtscx5rdThcMO9I6/t/ZwE1oSGMwL7TLLfaIJNahKoOwWnf+QABM2zhtLdmw==
X-Received: by 2002:a17:906:fad5:b0:6ce:e056:5918 with SMTP id lu21-20020a170906fad500b006cee0565918mr6315853ejb.562.1646584011591;
        Sun, 06 Mar 2022 08:26:51 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm3864043eje.180.2022.03.06.08.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 08:26:51 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] list: always set pos in list_prepare_entry()
Date:   Sun,  6 Mar 2022 17:26:35 +0100
Message-Id: <20220306162635.2930407-1-jakobkoschel@gmail.com>
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

In order to assign the result from list_prepare_entry() to another
variable, it should also be set when pos != NULL.

This will be useful once the list iterator is no longer used after
the loop.

The original code:

	list_for_each_entry(fl, head, list) {
		if (...)
			break;
	}

	list_for_each_entry_continue(fl, head, list) {

	}

can then just be turned into something like this:


	list_for_each_entry(fl, head, list) {
		if (...) {
			tmp = fl;
			break;
		}
	}

	fl = list_prepare_entry(tmp, head, list);
	list_for_each_entry_continue(fl, head, list) {

	}


The compiler should happily optimize away the
TRUE case if the variable being assigned is the same:

	pos = list_prepare_entry(pos, head, list);

and only do it in the case where the variable to assign
is different:

	pos = list_prepare_entry(tmp, head, list);

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index dd6c2041d09c..050747fb5ea8 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -659,7 +659,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * Prepares a pos entry for use as a start point in list_for_each_entry_continue().
  */
 #define list_prepare_entry(pos, head, member) \
-	((pos) ? : list_entry(head, typeof(*pos), member))
+	((pos) ? pos : list_entry(head, typeof(*pos), member))

 /**
  * list_for_each_entry_continue - continue iteration over list of given type

base-commit: 719fce7539cd3e186598e2aed36325fe892150cf
--
2.25.1

