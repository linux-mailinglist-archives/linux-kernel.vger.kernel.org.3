Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49757797C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiGRCEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiGRCD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:03:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832FABC00;
        Sun, 17 Jul 2022 19:03:56 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g9so7868222qvq.7;
        Sun, 17 Jul 2022 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8HeezhA1+rURqP/2dwk+dtvymWGPZT82fuwhTRWBAk=;
        b=iI3Y9js01TFWu/vyEqnMLoMM07XRrNvcoLpLrW4c6Iu1RGYegIy1DgPGycZHSFK0Md
         hCmDaFndLX4Wzzkj4CHd+VQGpNQnojtedq+qbMq7KzIbkOtwAtQAhPrOkfn8mXUsCJc1
         pW0au86f/9CTJK+0K0t7/2huwTwr2zNfq6qKhbQY46NO7vuH3s4xR0zzFeZoKJPPzF3E
         mwYUQGH1CaFCSHKGmWJNQqMEqtPCsstRvOQAlebS7DAihjZVlL9rOcolvL6mU42lokDb
         im1AWWMuG1hbVC0FGJz2HU2tUQdLr+1LhL4fGwF0pBntc6cevCB4Odj2s/kQdWJovuo5
         8eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8HeezhA1+rURqP/2dwk+dtvymWGPZT82fuwhTRWBAk=;
        b=NZJWoULkd4anEhPMjijcc2EgKM7soYhKkJ9TLRHg0Rr/9K4rrK6fKvGVYkeYzjC/au
         N0UQqyA1x4ex96nv8C0JmeT6cqFLq8zntipw3M4PNVQAW4JYhChFVChgj2l1dbS8XeCP
         Dbk4y10tJDIZGdVujH8icWkk7JRnRZrjYynXAPcP6cc4pNOZQvqPlqQCZco+mLhVy1Uq
         CN95gmVUIoEazSBWfXJyVCFGnID2flLmdYv78SY0TRSfIUhE5eGroPz9Fe79839beYGi
         V05Ixl3Q16HxvT01UMZBIyOdMNQF2LWeu4ac+ZzRoa33sbiH6dW2lrp+ae3OC4cDxqI5
         bv4g==
X-Gm-Message-State: AJIora8xbAI8rsBHdZiGOlK57eT11sY26rZsnpjTANHW776lZyZRwdCA
        fjD77yVW6O1orhO1JVyqtNgZk4pQuJo=
X-Google-Smtp-Source: AGRyM1vfYu31Ixy74y1wUZ1W5v6QQ1gfe2Gq6Iamr73IyRB2aH7UxXv2GFlPENyGeqnztDAA/CYFuQ==
X-Received: by 2002:a0c:dc87:0:b0:473:84e6:b988 with SMTP id n7-20020a0cdc87000000b0047384e6b988mr19595552qvk.74.1658109835605;
        Sun, 17 Jul 2022 19:03:55 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id bz19-20020a05622a1e9300b0031e99798d70sm1668747qtb.29.2022.07.17.19.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 19:03:55 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH] iio: Be consistent with allocation result tests.
Date:   Sun, 17 Jul 2022 22:03:48 -0400
Message-Id: <20220718020348.32047-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make both allocation result tests use the same format

    if (!ptr)

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..e22c47f20b4d 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -369,7 +369,7 @@ struct iio_poll_func
 	struct iio_poll_func *pf;
 
 	pf = kmalloc(sizeof *pf, GFP_KERNEL);
-	if (pf == NULL)
+	if (!pf)
 		return NULL;
 	va_start(vargs, fmt);
 	pf->name = kvasprintf(GFP_KERNEL, fmt, vargs);
-- 
2.35.3

