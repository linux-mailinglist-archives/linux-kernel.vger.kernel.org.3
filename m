Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD489488C5A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiAIUqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiAIUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:46:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E62C06173F;
        Sun,  9 Jan 2022 12:46:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t28so16273853wrb.4;
        Sun, 09 Jan 2022 12:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdDfINqY/U31B9QN69LwWjuvC8AdmHifCnhSwB7PwyQ=;
        b=UrfXGFL8xf58wU4p3/5tp3hTDKAYnTEmpa2WpGaZ3tY996tkJlY/70ffYDa7Z+KvvQ
         v03LcR1JAAm9q6XsHx7WLE4zR/gXnUD9nSQuTrbiWQYo84siuBjiDmtb1+zw91IkohOy
         ChxvdM9cyK0ibYzaOp9lyRpJvW9oLeJnA9B7+WoZ5ultXR0JpphAmnLsWQpPWGXpxt+4
         p8dKwr3QjFqdxpP3HtFr9fZxAo4S6pPy3rtO+wqvFX1wgnx0oZ2jORfqSS8NnLBvJFe7
         UY9j03bDxT6Q5+IJ/UmVzZ/ppPMxWzXkzQwjVBO9p5ZzfABQ/bMVRGj9zQlOVUxzQW0r
         IfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdDfINqY/U31B9QN69LwWjuvC8AdmHifCnhSwB7PwyQ=;
        b=nN3e9hiUn2mMPc3WtBmiAyKS1IwPNpAuk4vwdwoeJgRJkUa8cuzA1JXDIfuRBMOtwK
         Y8ysbeeiQY+JUisK3OWsMQDfFFQu89BLUrDMImm0JYTEjZwfpYTdMIjZ0rS8N+zebEys
         8VAyXH1d945lxNXnOP6CkE5/oFFAZM9OYr2qiBwTYGw7nAA4EDdNcV+/xdItN2v9mfGI
         S+yAtbe22dpahJX+rOj6Ux2sJEW6v38NhrwYSucRaVuK4IiQO0nkLh68Wul2kRJcqZns
         Voa6iRbW1tqJNSIRuzH4Q2db33llcDLUqj5SJL2+ovgYqvqgdNYkGml8hhswFRX4oN18
         qOBQ==
X-Gm-Message-State: AOAM531XLKzn30y+2sbuBGOau4maCf2j9Xa34r8xpSiVyh982+yzUEHZ
        +ArzkGBik9uStJncLH07/tk=
X-Google-Smtp-Source: ABdhPJzgidv5uPfyiw2ky2JEfj0t6PyunRD/JSHNrzPGyA6OTovo/GrJZW6vAKKAAczv571f3fyceQ==
X-Received: by 2002:a5d:5348:: with SMTP id t8mr62041232wrv.439.1641761158926;
        Sun, 09 Jan 2022 12:45:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m17sm4975174wmq.31.2022.01.09.12.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 12:45:58 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: gspca: make array regs_to_read static const
Date:   Sun,  9 Jan 2022 20:45:57 +0000
Message-Id: <20220109204557.52115-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array regs_to_read on the stack but
instead it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/usb/gspca/jl2005bcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/jl2005bcd.c b/drivers/media/usb/gspca/jl2005bcd.c
index ca12f33f3e12..a408fcc3a060 100644
--- a/drivers/media/usb/gspca/jl2005bcd.c
+++ b/drivers/media/usb/gspca/jl2005bcd.c
@@ -166,7 +166,9 @@ static int jl2005c_get_firmware_id(struct gspca_dev *gspca_dev)
 	struct sd *sd = (struct sd *)gspca_dev;
 	int i = 0;
 	int retval;
-	unsigned char regs_to_read[] = {0x57, 0x02, 0x03, 0x5d, 0x5e, 0x5f};
+	static const unsigned char regs_to_read[] = {
+		0x57, 0x02, 0x03, 0x5d, 0x5e, 0x5f
+	};
 
 	gspca_dbg(gspca_dev, D_PROBE, "Running jl2005c_get_firmware_id\n");
 	/* Read the first ID byte once for warmup */
-- 
2.32.0

