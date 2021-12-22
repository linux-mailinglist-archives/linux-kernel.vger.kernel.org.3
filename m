Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B047CDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhLVIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhLVIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:10:46 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:10:45 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id m186so1600464qkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2Rk94nf565LddAF7EYKJaCNRwFl5wCwDaRnRIBOzFk=;
        b=cuP2l9x99Pvf4LycxbeTwH650cIeTkpJ69/XVt+Ae5fCqft6C7vdCoG3dpG8aAeBS2
         ok5QGYt9bb2BNW1q6CqfVQfZnObG96X/DBAfDZqxdU5qOrJJUJEG+QHIAHSsNYtglK2x
         isFgPSSLfd9U/k3OmEY9fFw1tTADwjMmco7CWoMA9MrO+xsiyp4ye9QzvKS/FCXqweQc
         ohdF41t5rw0yJlPKlx0TayuPV619lcRl+uUQlCEiqADU3HPKmVsRYXX5LUQ0VhyKHhrB
         ICypjqGChq5pzc5VcI73GxXUVjntVQaElYhQ45ER0hiDrMOCUlES6MCXKpJPG41dXtgF
         g3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2Rk94nf565LddAF7EYKJaCNRwFl5wCwDaRnRIBOzFk=;
        b=QylPuxVSNr5z6dyQpvNhznd7twUm7yCdBsWUYZEn36tzXIr7qhXzyGZ6RlufUS37Ga
         h5SNdKxX0du0mJtFkvMsBVyzZTZx6/tFey5ijS3IiEfTA7n56DN8HbZYjd2wSC3qE7yT
         0Rlzi751oS+jRuqxyAdyqtYBUvGV4EjPxp2kFh0WfVLAqiEUfUTVOxYztqZgdT9qoaI0
         HmqdJzb6TLAeC+asO8K+bmY7zX5HNU7l7JAkNV1Ux/WH1enWkPiURqIqA4THlvB1LwrW
         FkhUUsYwzNn67DY6b4C8th2Abkzr3H++v3yPpM1phLilMvzQuAMJ8AlAw/Qs5YqKC4ua
         /2Og==
X-Gm-Message-State: AOAM531lj/WazJ6ehODjdhgUOp7qItuh3UpFBnfX3+8438GPqQC62buW
        K/6r615GI+BzWbINemBChqM=
X-Google-Smtp-Source: ABdhPJx6RDc5gDCyALnGuLN+nlKbivRfiAsp0iygWe36lnXgft/8luzMSrd+xN/kYnQE+GJp1Ad7xA==
X-Received: by 2002:a05:620a:1789:: with SMTP id ay9mr1261298qkb.572.1640160645011;
        Wed, 22 Dec 2021 00:10:45 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s2sm1207786qtw.22.2021.12.22.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:10:44 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     vvs@virtuozzo.com, shakeelb@google.com, rdunlap@infradead.org,
        dbueso@suse.de, unixbhaskar@gmail.com, manfred@colorfullife.com,
        chi.minghao@zte.com.cn, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ipc/sem: do not sleep with a spin lock held
Date:   Wed, 22 Dec 2021 08:10:26 +0000
Message-Id: <20211222081026.484058-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

We can't call kvfree() with a spin lock held, so defer it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 ipc/sem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 6693daf4fe11..0dbdb98fdf2d 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1964,6 +1964,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	 */
 	un = lookup_undo(ulp, semid);
 	if (un) {
+		spin_unlock(&ulp->lock);
 		kvfree(new);
 		goto success;
 	}
@@ -1976,9 +1977,8 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	ipc_assert_locked_object(&sma->sem_perm);
 	list_add(&new->list_id, &sma->list_id);
 	un = new;
-
-success:
 	spin_unlock(&ulp->lock);
+success:
 	sem_unlock(sma, -1);
 out:
 	return un;
-- 
2.25.1

