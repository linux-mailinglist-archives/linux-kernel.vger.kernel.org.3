Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1374550821
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiFSDkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiFSDkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:40:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6CEE0A;
        Sat, 18 Jun 2022 20:40:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso9869151pjb.0;
        Sat, 18 Jun 2022 20:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=7+Qdxse151+cFPW4HdyqfeqoEPdOV150o5zOZtbT5P0=;
        b=UOGu8v1EaOqoKCKuU1V8GJcSf3HppPzeKIv0nQL//sy926Gs8yaT1Kr2Y86+un78WT
         QOlzLNpCeXQuOQQVku7mlb+u6XR/PyLy9JtDT7heQFhWBY6ExqOvUcYls70R0VLZ/5gs
         yz4OWZdqRRA7u2mr+BXpSTt2XUqG79ZxsQOC1J90+HJeDzVua+LjMqrV2fUoqlxO5NEN
         QIZyqcOz+t1Lr9d8yUlaeJbZ2/Ubh3J5UkAfmFo5rDVEOsCm5syFMTDE2pGfQ6OGi5ok
         jWC/xgU+uN+lecVUIc/n5dYGCvP6IfDcZ8UBF2tDCEWaGc4UlnibEWZFRdGWhVuAoYUH
         D/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=7+Qdxse151+cFPW4HdyqfeqoEPdOV150o5zOZtbT5P0=;
        b=ZKR2g0lUssZNxcKJAp4e8D9hNN0gfwIKMtwsmtR9mgPOKTqljlDu8qPXTJYog9lcEj
         2N2GUDZSw25/j6Ox6UZXktSiO21U5/3Z89aZyNS2eSb8N6xQliN5hFkCRKKj0/xb2uyF
         s+1CXE9xwIBqvxdkyRdrkcBr/4QS4APbEQMaEVLEDXQyd+7PyG51/DZIjkvsIu8pR8I/
         AD4dmk8ddslRVHTW/YqFI7ey9ETVXDTO9/tHYsOq5fXx32WxdDLRCK4EDOAD5sKI67+q
         4WVPbGSJogL/I73MjpAcDRCGdo1JTZXs2iL/y7kr24qXIKsHERYmukyfyqOKvFJOfnHD
         I8Cg==
X-Gm-Message-State: AJIora99wlZ1oksuw52G6HlYGcIYKsa794BbiAafqtD0aNbTVab4QQAw
        uaUjtgCokazLjQkR9X4U1ER1vj6Utm5NGQ==
X-Google-Smtp-Source: AGRyM1urMB7lo5JMS9xPfIi7KPeDm53GPYYNB3uOWzfW+rXV1Ke7TY6ugEnS5kAPqqalvFwmok2bQQ==
X-Received: by 2002:a17:90a:5b0d:b0:1ea:d1ed:186e with SMTP id o13-20020a17090a5b0d00b001ead1ed186emr19210449pji.240.1655610030426;
        Sat, 18 Jun 2022 20:40:30 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id v5-20020a63b945000000b003fadd680908sm6375694pgo.83.2022.06.18.20.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:40:29 -0700 (PDT)
Date:   Sat, 18 Jun 2022 20:40:26 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     tim@cyberelk.net, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] paride: Fixed integer overflow in pt_read and pt_write
Message-ID: <20220619034026.GA660729@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pt_read() and pt_write(), the "size_t count" variable is
assigned to the "int n" variable and then size check is performed.

static ssize_t pt_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
{
	...
        int k, n, r, p, s, t, b;

	...

        while (count > 0) {

                if (!pt_poll_dsc(tape, HZ / 100, PT_TMO, "write"))
                        return -EIO;

                n = count;
                if (n > 32768)
                        n = 32768;      /* max per command */

If the user passes the SIZE_MAX value to the "count" variable,
the "n" value is greater than 32768, but it becomes a negative
number and passes the size check.
In other words, we need to add a negative check as well,
since the size check makes no sense.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/block/paride/pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
index e815312a00ad..f37aa1349622 100644
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -787,7 +787,7 @@ static ssize_t pt_read(struct file *filp, char __user *buf, size_t count, loff_t
 			return -EIO;
 
 		n = count;
-		if (n > 32768)
+		if (n > 32768 || n < 0)
 			n = 32768;	/* max per command */
 		b = (n - 1 + tape->bs) / tape->bs;
 		n = b * tape->bs;	/* rounded up to even block */
@@ -888,7 +888,7 @@ static ssize_t pt_write(struct file *filp, const char __user *buf, size_t count,
 			return -EIO;
 
 		n = count;
-		if (n > 32768)
+		if (n > 32768 || n < 0)
 			n = 32768;	/* max per command */
 		b = (n - 1 + tape->bs) / tape->bs;
 		n = b * tape->bs;	/* rounded up to even block */
-- 
2.25.1

