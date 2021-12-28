Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2C480581
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 02:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhL1BhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 20:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhL1BhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 20:37:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F33C06173E;
        Mon, 27 Dec 2021 17:37:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so9194928wmd.5;
        Mon, 27 Dec 2021 17:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gz2aWCWCCEe1u6rggzLlG69EStj3M0dnJRBR5Ximccw=;
        b=fJzZNkNM4erOMQpEfC6XXJ1Ys0wicByRHCuoxx+SNzf9DJu5WrVeDeqVpTlETcHtkd
         I0xEfW/fAapdGn0UyN7laeO9T1asr+s16RhMD3kSJjqP55OTAWrYuXHUbx4ZvflZakze
         GdQYZafOf6u+FvZdyYt3uFNS2TaKcsoOXDLIQkIO8TmUzfFqDyPyJD4cXcPh3VFdPCWS
         +Uf+3g9nJdhV5UCyHswFIpGLHqmuF4suXQyRmwlQKF+VYGpYlpQGZTFb0GOOAGHwb28Q
         BtOKrY9KtE24jcNvbWzLfCYHK1DlgaBcOaB7iXTPmVwauLKPzJzVGvYnxK4lAMJfjkBV
         lkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gz2aWCWCCEe1u6rggzLlG69EStj3M0dnJRBR5Ximccw=;
        b=YQ33d9WeRw1FPi9p8tilM8WzfN1zmjSilawxOpwulmqGUTQb+DYFGE+3ztTschqH8L
         INq4XR2W9jOcO9IlcZ86LfRFx0zw5fLF+tcjO/UZgc2Kwv11oY7AHMQ2e2Q5+nTh360u
         7UPz0RNfNtm6uubOtexJYdoB8Nx6JrFGY2xPFolf9r08ick2ryUMBc3AMMOhkZk5Av3z
         eaGoUpfOcHu61xKNl/XjYXWjy4y/hIym2tmuYL9Nh7LtlVqm2kbHeJd8Oe7q0qdsDZ6w
         7w42zUlbKxm/X1Gk6E09hZeCBVbhIgDwUqUawzu5LWVWTvpbcvJDrdqmnuoP5j+cAM1a
         bqvQ==
X-Gm-Message-State: AOAM5333SALTHGXhcMXtp8m5hHKoFrnPs5TQR7sPeVPgPpkLrD391FSO
        YJHoIhEHRAXz8UKB0oUBowY=
X-Google-Smtp-Source: ABdhPJwt3E5e6JEYid1bQ9uErzNt9j2HwKXRmQtTVQlaN1HB2xhvYgvpPGTPCMc/Ha93d7PP1/+HSQ==
X-Received: by 2002:a05:600c:384c:: with SMTP id s12mr15396846wmr.108.1640655440417;
        Mon, 27 Dec 2021 17:37:20 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o2sm16179695wru.109.2021.12.27.17.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:37:19 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: remove redundant assignment to pointer root_bh
Date:   Tue, 28 Dec 2021 01:37:19 +0000
Message-Id: <20211228013719.620923-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer root_bh is being initialized with a value that is not read,
it is being re-assigned later on closer to its use. The early
initialization is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ocfs2/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index bb247bc349e4..bf9357123bc5 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -2040,7 +2040,7 @@ static void ocfs2_complete_edge_insert(handle_t *handle,
 	int i, idx;
 	struct ocfs2_extent_list *el, *left_el, *right_el;
 	struct ocfs2_extent_rec *left_rec, *right_rec;
-	struct buffer_head *root_bh = left_path->p_node[subtree_index].bh;
+	struct buffer_head *root_bh;
 
 	/*
 	 * Update the counts and position values within all the
-- 
2.33.1

