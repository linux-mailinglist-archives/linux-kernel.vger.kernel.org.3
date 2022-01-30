Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743EB4A3743
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355446AbiA3P1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355439AbiA3P1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:27:07 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A92C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:27:06 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id u14so8878097vsg.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=QX+g1hCOW91cXXnSggcw6gj04u3NWBZ31aKJT4qy8z4=;
        b=HD/4qz2z/NdjjLU1lR4H3U15s5msIFLg7DBqWhui4lujSGMlzrXXW637fmJHyj7rJg
         9ZSLBqe0C+Gv5VtDiUFNtMoyYHNHXkH1NpFo+NqijUSbm0XwOJGMaZ5h+0pmGbWRKG28
         QnPjy7wB8St3ENbSz7Gx/BOgxWyQ04LuBZggu9IcCAiI3HQNAYvlPeZ8tTB9kxKwOZxb
         E4HRukFXNvmbOGDV1Vgfj7yxjC6SEy1wIsQ8jtKL4zdIx4x9GJP+TTiN2ONPMM9M0tYf
         zIqUquFg4g0eiezyCtsEWtknBXBlTPEUfphOElqsiWhlniImPrlSNO89ou/k6U1S+FFZ
         ShwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=QX+g1hCOW91cXXnSggcw6gj04u3NWBZ31aKJT4qy8z4=;
        b=D4nr5r7asqWYhER/f2w2FVL8O+Bj9NsDXkUId2OqixSg/yyb4LvZFAP+ui1pyw68dv
         MzowqOXcdvq+r5YfQyO4+Tt/bu9fcK0spgOPD52XFrXf3pVjSyVAp8a8ku6niEAVVThh
         /ACJ765+QMVJGQSn5mJ0ts7ijT5kWGHTUYsbNZZBroKUZChsR7iAo9T48BW4Ksujdyxg
         KdkFowHwScarzXHcMowUdI+PkTTLdpofbHrOMsxTjjn5raYW+uyCEMw1W2O39Bsn0O+g
         HxiRsWV6SIrOjx2/nRe9O7pHHFJDpFswmTTKf7BKXxMxcdvfxalM5lt6FF5rGljAdKLO
         YamA==
X-Gm-Message-State: AOAM532MeLRkHh8RhFHKp5CLsVesjUPZpPuYnGGAkzzTXWUL25qDw5zU
        gxPhfshM2yelX3ovhpXDLu7nrA==
X-Google-Smtp-Source: ABdhPJxkGrsc+o2xJu08YhAkeRNFOz6+5hhYb5WDUPUWhPpwgPKwhiHccgAA6hO+d1qRqqhfQPS+dQ==
X-Received: by 2002:a05:6102:5490:: with SMTP id bk16mr6607320vsb.33.1643556425648;
        Sun, 30 Jan 2022 07:27:05 -0800 (PST)
Received: from fedora ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id w5sm3139815vkf.12.2022.01.30.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 07:27:05 -0800 (PST)
Date:   Sun, 30 Jan 2022 12:27:00 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] seq_file: fix NULL pointer arithmetic warning
Message-ID: <YfauRJpYiAT3yEnK@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement conditional logic in order to replace NULL pointer arithmetic.

The use of NULL pointer arithmetic was pointed out by clang with the
following warning:

fs/kernfs/file.c:128:15: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                return NULL + !*ppos;
                       ~~~~ ^
fs/seq_file.c:559:14: warning: performing pointer arithmetic on a
null pointer has undefined behavior [-Wnull-pointer-arithmetic]
        return NULL + (*pos == 0);

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 fs/kernfs/file.c | 6 ++++--
 fs/seq_file.c    | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f..3a6990c7fe8e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -120,12 +120,14 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 		if (next == ERR_PTR(-ENODEV))
 			kernfs_seq_stop_active(sf, next);
 		return next;
-	} else {
+	} else if (*ppos) {
 		/*
 		 * The same behavior and code as single_open().  Returns
 		 * !NULL if pos is at the beginning; otherwise, NULL.
 		 */
-		return NULL + !*ppos;
+		return NULL;
+	} else {
+		return (void *) 1;
 	}
 }
 
diff --git a/fs/seq_file.c b/fs/seq_file.c
index f8e1f4ee87ff..7b6165d5d829 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -556,7 +556,7 @@ EXPORT_SYMBOL(seq_dentry);
 
 static void *single_start(struct seq_file *p, loff_t *pos)
 {
-	return NULL + (*pos == 0);
+	return *pos ? NULL : (void *) 1;
 }
 
 static void *single_next(struct seq_file *p, void *v, loff_t *pos)
-- 
2.34.1

