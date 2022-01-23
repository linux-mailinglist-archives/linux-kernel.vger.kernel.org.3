Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665A54974C3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiAWSnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbiAWSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:28 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D86C06176F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t32so13141428pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ouatn2R2XSrlqBb/cl6QBZlhDkWXWZjR0T2HBFMF8GM=;
        b=Pg+6hPzMUrdJ2L0XacgOuQCKjl4jmD1DkA4Uft+PyFR3TG54sPD+Vgh5++LQcbqVcV
         ylxUcOCGkUe7IWVmwD2RuZYGjfzClUYynm95FBXzxuFGgIkfqk4jW7AKoYK9A5FUGhuJ
         sVukEpWtFRuWctbRULsmwXelbY2fsOOfcIhFUJjs+cBsQM+cs6jGbbA2cbh5zVnDfKsu
         k9dmhPbTZOq7mJM6vn095szshkPUxZNrubKcCMQxWn/W19NNa79wsYTpwCY8ol+XoPgt
         7DPidvWsROJ378WbseEcbhSy28SO0NcPuyDD1CYAhMjsFte3s3JcqDUnJ8tRB7EuhjY0
         8hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ouatn2R2XSrlqBb/cl6QBZlhDkWXWZjR0T2HBFMF8GM=;
        b=dJf9cQKgKHEhxy1XkjJrcmb45OMUk1cdwFSfOwjg7B/vP2vAZz739zfpYYvGJBuQRO
         WhVW0SwHHBJMtgRAXVBep/M4CVr7C6x1CMJo8rtPsrugtX00QSzmQqO+ao8cWPt+dQnI
         QRG63a+GfITZnuZdQZt92uURV8bHG/X2baSZRtwRVN97Au8IoGy4YTtqeceCOs/uIiU3
         Tccb2ATFZTHehPYEZA+dRmZR0sx9RS7weUF7/MGuqV+DxOCEluXQob6ZQItftQkODhIu
         E89P17KSxIQc9Xt+WlEUSstX+DOBVX73Uxk8wYFXg7QmNLGGBCH/MBGjb0WyLtQph8n1
         6E0w==
X-Gm-Message-State: AOAM5321czyqHUTX5IaHMfRarCq8fxPxfB+q7W9KRmfP7xguSUKGwfjh
        i8lYtIKcK2yZbxY59TZo6Kk=
X-Google-Smtp-Source: ABdhPJy0WTtp3rHcuax4YIT+LcH4DXFc3zkfPiLxk2xJ70kkMzrkhq/X13/68EEM7x8rgLqZZjwFPg==
X-Received: by 2002:a63:b34c:: with SMTP id x12mr9392573pgt.541.1642963348406;
        Sun, 23 Jan 2022 10:42:28 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y20sm2328066pfi.78.2022.01.23.10.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:28 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 51/54] mm: replace nodes_weight with nodes_weight_eq in mempolicy
Date:   Sun, 23 Jan 2022 10:39:22 -0800
Message-Id: <20220123183925.1052919-52-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_migrate_pages() calls nodes_weight() to compare the weight
of nodemask with a given number. We can do it more efficiently with
nodes_weight_eq() because conditional nodes_weight() may stop
traversing the nodemask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a86590b2507d..27817cf2f2a0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1157,7 +1157,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			 *          [0-7] - > [3,4,5] moves only 0,1,2,6,7.
 			 */
 
-			if ((nodes_weight(*from) != nodes_weight(*to)) &&
+			if (!nodes_weight_eq(*from, nodes_weight(*to)) &&
 						(node_isset(s, *to)))
 				continue;
 
-- 
2.30.2

