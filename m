Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1894B5304FF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349943AbiEVRmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243789AbiEVRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 13:42:50 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BB183968A
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 10:42:49 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 37C9D20012BA;
        Mon, 23 May 2022 02:42:48 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24MHgj7L103712
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 02:42:46 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24MHgjs7296574
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 02:42:45 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24MHgiGO296573;
        Mon, 23 May 2022 02:42:44 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: Re: [RFC PATCH 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
References: <20220519092343.2776414-1-javierm@redhat.com>
        <20220519092343.2776414-3-javierm@redhat.com>
Date:   Mon, 23 May 2022 02:42:44 +0900
In-Reply-To: <20220519092343.2776414-3-javierm@redhat.com> (Javier Martinez
        Canillas's message of "Thu, 19 May 2022 11:23:42 +0200")
Message-ID: <87fsl1cvl7.fsf@mail.parknet.co.jp>
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

> The renameat2 RENAME_EXCHANGE flag allows to atomically exchange two paths
> but is currently not supported by the Linux vfat filesystem driver.
>
> Add a vfat_rename_exchange() helper function that implements this support.
>
> The super block lock is acquired during the operation to ensure atomicity,
> and in the error path actions made are reversed also with the mutex held,
> making the whole operation transactional.

I'm not fully reviewed yet though (write order and race), basically
looks like good.

> +	/* if directories are not the same, get ".." info to update */
> +	if (old_dir != new_dir) {
> +		if (S_ISDIR(old_inode->i_mode))
> +			if (fat_get_dotdot_entry(old_inode, &old_dotdot_bh, &old_dotdot_de)) {
> +				err = -EIO;
> +				goto out;
> +			}
> +		if (S_ISDIR(new_inode->i_mode))
> +			if (fat_get_dotdot_entry(new_inode, &new_dotdot_bh, &new_dotdot_de)) {
> +				err = -EIO;
> +				goto out;
> +			}
> +	}

It may not be linux coding style though, please add {}

	if () {
        	...
	}

for non one liner body.

> +	/* update ".." directory entry info */
> +	if (old_dotdot_de) {
> +		fat_set_start(old_dotdot_de, MSDOS_I(new_dir)->i_logstart);
> +		mark_buffer_dirty_inode(old_dotdot_bh, old_inode);
> +		if (IS_DIRSYNC(new_dir)) {
> +			err = sync_dirty_buffer(old_dotdot_bh);
> +			if (err)
> +				goto error_old_dotdot;
> +		}
> +		drop_nlink(old_dir);
> +		inc_nlink(new_dir);
> +	}
> +
> +	if (new_dotdot_de) {
> +		fat_set_start(new_dotdot_de, MSDOS_I(old_dir)->i_logstart);
> +		mark_buffer_dirty_inode(new_dotdot_bh, new_inode);
> +		if (IS_DIRSYNC(old_dir)) {
> +			err = sync_dirty_buffer(new_dotdot_bh);
> +			if (err)
> +				goto error_new_dotdot;
> +		}
> +		drop_nlink(new_dir);
> +		inc_nlink(old_dir);
> +	}

There are some copy&paste codes, for example above, it may be better to
use function and consolidate? If you had some intent, it is ok though.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
