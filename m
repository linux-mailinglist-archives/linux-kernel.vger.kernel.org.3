Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4F502AED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353983AbiDONak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiDONai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:30:38 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDC495C37E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:28:10 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 5436915F939;
        Fri, 15 Apr 2022 22:28:10 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23FDS9K7063447
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 22:28:10 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23FDS9jn130716
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 22:28:09 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23FDS8fs130713;
        Fri, 15 Apr 2022 22:28:08 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-kernel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com
Subject: Re: [PATCH v3 2/3] fat: make ctime and mtime identical explicitly
References: <20220415094518.380543-1-cccheng@synology.com>
        <20220415094518.380543-2-cccheng@synology.com>
Date:   Fri, 15 Apr 2022 22:28:08 +0900
In-Reply-To: <20220415094518.380543-2-cccheng@synology.com> (Chung-Chiang
        Cheng's message of "Fri, 15 Apr 2022 17:45:17 +0800")
Message-ID: <87czhitr13.fsf@mail.parknet.co.jp>
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

Chung-Chiang Cheng <cccheng@synology.com> writes:

> -	fat_truncate_time(dir, NULL, S_ATIME|S_MTIME);
> +	fat_truncate_time(dir, NULL, S_ATIME|S_CTIME|S_MTIME);

fat_truncate_time() updates i_ctime too. So S_CTIME should not be
necessary here. And I think this is better to use only S_MTIME to tell
this is the point of mtime update.

(And, in fat_truncate_time(), I think S_CTIME is not required, because
we ignore ctime change, isn't it?)

Or you are going to update mtime on rename, etc too?

> +	/*
> +	 * ctime and mtime share the same on-disk field, and should be
> +	 * identical in memory.
> +	 */
> +	if (flags & (S_CTIME|S_MTIME)) {
>  		fat_truncate_mtime(sbi, now, &inode->i_mtime);
> +		inode->i_ctime = inode->i_mtime;
> +	}

[...]

>  	clear_nlink(inode);
> -	fat_truncate_time(inode, NULL, S_CTIME);
> +	fat_truncate_time(inode, NULL, S_CTIME|S_MTIME);

This is the point to update ctime. You want to affect ctime change to
mtime? As I said in previous post, I think we are better to ignore ctime
change, because it may become yet another incompatible behavior.

>  	fat_detach(inode);
>  out:
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
> @@ -415,7 +415,7 @@ static int msdos_unlink(struct inode *dir, struct dentry *dentry)
>  	if (err)
>  		goto out;
>  	clear_nlink(inode);
> -	fat_truncate_time(inode, NULL, S_CTIME);
> +	fat_truncate_time(inode, NULL, S_CTIME|S_MTIME);

ditto

>  	fat_detach(inode);
>  out:
>  	mutex_unlock(&MSDOS_SB(sb)->s_lock);
> @@ -550,7 +550,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
> -		fat_truncate_time(new_inode, &ts, S_CTIME);
> +		fat_truncate_time(new_inode, &ts, S_CTIME|S_MTIME);

ditto

>  	}
>  out:

[...]

> @@ -981,7 +981,7 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
> -		fat_truncate_time(new_inode, &ts, S_CTIME);
> +		fat_truncate_time(new_inode, &ts, S_CTIME|S_MTIME);

ditto

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
