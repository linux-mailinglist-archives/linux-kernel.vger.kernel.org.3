Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48D4DE201
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiCRT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiCRT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:58:13 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 507E014003
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:56:53 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id C1C2415F939;
        Sat, 19 Mar 2022 04:56:52 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22IJup2T021603
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 04:56:52 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22IJupYL069791
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 04:56:51 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22IJupoG069790;
        Sat, 19 Mar 2022 04:56:51 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jonathan Lassoff <jof@thejof.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add FAT messages to printk index
References: <c11c5c259d5e53afe5b20fa761002e7edd48277f.1647624190.git.jof@thejof.com>
Date:   Sat, 19 Mar 2022 04:56:51 +0900
In-Reply-To: <c11c5c259d5e53afe5b20fa761002e7edd48277f.1647624190.git.jof@thejof.com>
        (Jonathan Lassoff's message of "Fri, 18 Mar 2022 10:23:51 -0700")
Message-ID: <87v8wbvxto.fsf@mail.parknet.co.jp>
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

Jonathan Lassoff <jof@thejof.com> writes:

> In order for end users to quickly react to new issues that come up in
> production, it is proving useful to leverage the printk indexing system. This
> printk index enables kernel developers to use calls to printk() with changable
> ad-hoc format strings, while still enabling end users to detect changes and
> develop a semi-stable interface for detecting and parsing these messages.
>
> So that detailed FAT messages are captured by this printk index, this patch
> wraps fat_msg with a macro.
>
> PATCH v1 -- Fix indentation with tabs in fat_msg macro
> PATCH v2 -- Define FAT_PRINTK_PREFIX
>
> Signed-off-by: Jonathan Lassoff <jof@thejof.com>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/fat.h  | 9 ++++++++-
>  fs/fat/misc.c | 4 ++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 02d4d4234956..2a20a21f2fb9 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -433,8 +433,15 @@ void __fat_fs_error(struct super_block *sb, int report, const char *fmt, ...);
>  	__fat_fs_error(sb, 1, fmt , ## args)
>  #define fat_fs_error_ratelimit(sb, fmt, args...) \
>  	__fat_fs_error(sb, __ratelimit(&MSDOS_SB(sb)->ratelimit), fmt , ## args)
> +
> +#define FAT_PRINTK_PREFIX "%sFAT-fs (%s): "
> +#define fat_msg(sb, level, fmt, args...)				\
> +do {									\
> +	printk_index_subsys_emit(FAT_PRINTK_PREFIX, level, fmt, ##args);\
> +	_fat_msg(sb, level, fmt, ##args);				\
> +} while(0)
>  __printf(3, 4) __cold
> -void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...);
> +void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...);
>  #define fat_msg_ratelimit(sb, level, fmt, args...)	\
>  	do {	\
>  			if (__ratelimit(&MSDOS_SB(sb)->ratelimit))	\
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 91ca3c304211..a3f1e4f8bed3 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(__fat_fs_error);
>   * fat_msg() - print preformated FAT specific messages. Every thing what is
>   * not fat_fs_error() should be fat_msg().
>   */
> -void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
> +void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
> @@ -53,7 +53,7 @@ void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>  	va_start(args, fmt);
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> -	printk("%sFAT-fs (%s): %pV\n", level, sb->s_id, &vaf);
> +	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id, &vaf);
>  	va_end(args);
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
