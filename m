Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024058472E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiG1Upk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiG1Upb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3285A3EF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3349851pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=3VreCZyHHh+WzAldTMIrv+f0+ZRGj5qK/tBAl8Rh9YU=;
        b=FwRN+Dz/EkdantL+2MuehBxRu34vE2XcB9JJwAKV1+CF9A8W4YNymfzAbHnrbk+L2U
         fR4wNZ+kuA+iAYL+rFBDO2riXI3h0eYhrjVGXQyktY2XHPh3TfoRUdsV8h5ekA0eKkdv
         z7kpAxEMJG2bbBCVPlhHWuM7BvjkVok8aSEVxBSDukYAzf+WgLda4xfSw/OT3A291gdg
         ou48O7q9cfHkv/RQWombHOHxI6eODfqLFNqZtaJQOzuI2qjxcEstXuCibnuZX36hWZMm
         e5EfiwYzC/IamfAWRITnYup9JSvjEVdahnDfoxZD7ktMOsUQNCdQme/sfeOx+rupiVkJ
         +jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=3VreCZyHHh+WzAldTMIrv+f0+ZRGj5qK/tBAl8Rh9YU=;
        b=dq7OP2YboSivZbH8/Xm25yQaNqrXwOtFHzI+IAmwEWuEHe4uOV2V0wkPays+UWN+yI
         SUz4fVNqVm3OIWlduoa29anG7kviwQmjDeIc1JYDEIZ4KlrxJsocpqx1dd9oJ4CY5lpX
         A4kGezypBSotMultXXp7iP1scKLO+NjvAza4JIrW1tj4dFkOsTpa59Be48wSkkGXgKtt
         nWlBRANscBuKQbKkxEWoso4Q5dxB2vX6J/giW7XcOwO70GWGaVNutIaZNcJEXI2w22ms
         BWAgwOFxouNxp2B6Dx4fRnPoGN31a8KVgah1kQwMWIBRc+zsvOQt70FJRWaKxCztMJf8
         pxvw==
X-Gm-Message-State: ACgBeo0/8eod8C672L9C1qkHGzGtBqq9HtjLx/Jx/lUI9igtkxrjSaf7
        UuabUYtqyomceO88X8iI54jLKsgBhQk3Nhk3uFQ=
X-Google-Smtp-Source: AA6agR40gp1BRqPQFl5cX7Tmvlv/+x70OfYLiw3CrWsQmCd4n0R6k3976B5hXnfHCoAHyxuIlaWKiw==
X-Received: by 2002:a17:90b:b03:b0:1f3:6fb:bd20 with SMTP id bf3-20020a17090b0b0300b001f306fbbd20mr1215431pjb.38.1659041125076;
        Thu, 28 Jul 2022 13:45:25 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:24 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 3/7] mm/headers: change emun order of MM_COUNTERS
Date:   Fri, 29 Jul 2022 04:45:07 +0800
Message-Id: <20220728204511.56348-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220728204511.56348-1-ryncsn@gmail.com>
References: <20220728204511.56348-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

get_rss reads MM_FILEPAGES, MM_ANONPAGES, MM_SHMEMPAGES. Make them
continues so it's easier to read in a loop in following commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm_types_task.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index a00327c663db..14182ded3fda 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -43,8 +43,8 @@ struct vmacache {
 enum {
 	MM_FILEPAGES,	/* Resident file mapping pages */
 	MM_ANONPAGES,	/* Resident anonymous pages */
-	MM_SWAPENTS,	/* Anonymous swap entries */
 	MM_SHMEMPAGES,	/* Resident shared memory pages */
+	MM_SWAPENTS,	/* Anonymous swap entries */
 	NR_MM_COUNTERS
 };
 
-- 
2.35.2

