Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A33F5454BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiFITRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFITRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:17:45 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C18C113A0A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:17:43 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 9C5AA2055F9A;
        Fri, 10 Jun 2022 04:17:41 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 259JHdn0009472
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:17:40 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 259JHdMq066467
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:17:39 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 259JHcxC066466;
        Fri, 10 Jun 2022 04:17:38 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Alberto Ruiz <aruiz@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Kellner <ckellner@redhat.com>,
        Carlos Maiolino <cmaiolin@redhat.com>
Subject: Re: [PATCH v5 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
References: <20220609093638.664034-1-javierm@redhat.com>
        <20220609093638.664034-4-javierm@redhat.com>
Date:   Fri, 10 Jun 2022 04:17:38 +0900
In-Reply-To: <20220609093638.664034-4-javierm@redhat.com> (Javier Martinez
        Canillas's message of "Thu, 9 Jun 2022 11:36:36 +0200")
Message-ID: <878rq54pf1.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> +static void vfat_update_nlink(struct inode *dir, struct inode *inode)
> +{
> +		if (S_ISDIR(inode->i_mode))
> +			drop_nlink(dir);
> +		else
> +			inc_nlink(dir);
> +}

[...]

> +	vfat_update_dir_metadata(old_dir, &ts);
> +	/* if directories are not the same, update new_dir as well */
> +	if (old_dir != new_dir) {
> +		vfat_update_dir_metadata(new_dir, &ts);
> +		/* nlink only needs to be updated if the file types differ */
> +		if (old_inode->i_mode != new_inode->i_mode) {
> +			vfat_update_nlink(old_dir, old_inode);
> +			vfat_update_nlink(new_dir, new_inode);
> +		}
> +	}

Looks like unnecessary complex (and comparing raw i_mode, not S_ISDIR(),
better to change before make dir dirty).  How about this change, it is
only tested slightly though? Can you review and test?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/namei_vfat.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c30f829..3aef834 100644
--- a/fs/fat/namei_vfat.c	2022-06-10 03:33:40.334212176 +0900
+++ b/fs/fat/namei_vfat.c	2022-06-10 04:11:30.817064192 +0900
@@ -1055,12 +1055,10 @@ static void vfat_exchange_ipos(struct in
 	fat_attach(new_inode, old_i_pos);
 }
 
-static void vfat_update_nlink(struct inode *dir, struct inode *inode)
+static void vfat_move_nlink(struct inode *src, struct inode *dst)
 {
-		if (S_ISDIR(inode->i_mode))
-			drop_nlink(dir);
-		else
-			inc_nlink(dir);
+	drop_nlink(src);
+	inc_nlink(dst);
 }
 
 static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
@@ -1112,7 +1110,6 @@ static int vfat_rename_exchange(struct i
 		if (err)
 			goto error_old_dotdot;
 	}
-
 	if (new_dotdot_de) {
 		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
 					    new_dotdot_de);
@@ -1120,16 +1117,18 @@ static int vfat_rename_exchange(struct i
 			goto error_new_dotdot;
 	}
 
+	/* if cross directory and only one is a directory, adjust nlink */
+	if (!old_dotdot_de != !new_dotdot_de) {
+		if (old_dotdot_de)
+			vfat_move_nlink(old_dir, new_dir);
+		else
+			vfat_move_nlink(new_dir, old_dir);
+	}
+
 	vfat_update_dir_metadata(old_dir, &ts);
 	/* if directories are not the same, update new_dir as well */
-	if (old_dir != new_dir) {
+	if (old_dir != new_dir)
 		vfat_update_dir_metadata(new_dir, &ts);
-		/* nlink only needs to be updated if the file types differ */
-		if (old_inode->i_mode != new_inode->i_mode) {
-			vfat_update_nlink(old_dir, old_inode);
-			vfat_update_nlink(new_dir, new_inode);
-		}
-	}
 
 out:
 	brelse(old_dotdot_bh);
_
