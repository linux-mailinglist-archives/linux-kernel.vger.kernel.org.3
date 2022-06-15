Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A37454CCAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349082AbiFOP0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244124AbiFOP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:26:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0A377C1;
        Wed, 15 Jun 2022 08:26:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o10so16704547edi.1;
        Wed, 15 Jun 2022 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GA+lb0s1Ij1JLSWYJXX4ZOUvdN6/e+a0skrIG7B/rE=;
        b=mVOii0QRcqNupgkgpLCIIoHG884gBkD+5Nbs2IzE/B/iYGaNeYpq2lmsYmT5RFnbCG
         rw8vt37D1B/3uMAEIyY8KlN6/8lpGtLjQNv3+nF04r3c6cU1lu1DOFBw22xM2sQM8prv
         vZrWZO82PyfOrlsrwCkIq8x1knfhuHL0V7KAKdT6qQJCpgJ9M8AcsZZZ2KiOSRVKMwK5
         XoT7HaVwdC/PUj6ULwoEqxQM4rxZGEzEuw8m5MPWJFe/6pZ//Xs8kPaBD6ew78ttGv5C
         OvbxBS2u5W5gp/2uS/PZ21I5YXg2XQ4Emm8ce83tfwq3bOFOiI7RK275Yw4Y9YRo44dt
         3T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GA+lb0s1Ij1JLSWYJXX4ZOUvdN6/e+a0skrIG7B/rE=;
        b=nVo66+WukxJYLr+aQExuJOPj15GaRZj7YYvBHcG+bpWryvVjQNzTJS1D+DrwwS2po+
         tdB94EJkjm1TXC9RNcE03sVxm+rTVglkeEw4lz4PJx/VLon1ikT0HSUpmvE2SussZVnw
         Ggdzamk8GkXEvRiIzct9ksKsJNp4eykksTx0XyPNWPt3jcT0oYLG11/ZxuytA/D4dAKg
         /FbKUgTu0dGkzhcNjOeL3EnfrTyyF45+IqHY4HoeTrGC1AbiMFdahGZIXKc0asztNB78
         tsdS61832+HuZpw+yxNfChs9APB1+sZtMRUYOFhPJNrwjvmviyi+n8XnFagYODe0FsRe
         /33A==
X-Gm-Message-State: AJIora8UIt9pEPcGsdEFyaiCJ/1YpQj7ttUGrNikJhZmHSfbtqGuNxUP
        4iOCQdp3fCiPV9oGmCAnF91yKoSL48OkcA==
X-Google-Smtp-Source: AGRyM1ud+rPWhipCRl8iB6S+yDEvKVKF5PxYzoyeiAwtnhXEghcZEjl0Pb7LRyGKH84e9r8KzJgscA==
X-Received: by 2002:a05:6402:459:b0:431:665f:11ce with SMTP id p25-20020a056402045900b00431665f11cemr320886edw.35.1655306796013;
        Wed, 15 Jun 2022 08:26:36 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7d9ce000000b0042bc97322desm9501224eds.43.2022.06.15.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:26:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge@hallyn.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alistair Delva <adelva@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 3/8] block: use new capable_any functionality
Date:   Wed, 15 Jun 2022 17:26:17 +0200
Message-Id: <20220615152623.311223-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615152623.311223-1-cgzones@googlemail.com>
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Reorder CAP_SYS_ADMIN last.

Fixes: 94c4b4fd25e6 ("block: Check ADMIN before NICE for IOPRIO_CLASS_RT")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   rename to capable_any()
---
 block/ioprio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 2fe068fcaad5..6441c052f837 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -37,14 +37,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			/*
-			 * Originally this only checked for CAP_SYS_ADMIN,
-			 * which was implicitly allowed for pid 0 by security
-			 * modules such as SELinux. Make sure we check
-			 * CAP_SYS_ADMIN first to avoid a denial/avc for
-			 * possibly missing CAP_SYS_NICE permission.
-			 */
-			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
+			if (!capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */
-- 
2.36.1

