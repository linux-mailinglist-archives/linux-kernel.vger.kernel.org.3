Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671FA4DD46C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiCRFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiCRFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:35:09 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35E7B16F059
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:33:49 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 4DD4A15F93A;
        Fri, 18 Mar 2022 14:33:47 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22I5XktY065595
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 14:33:47 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22I5XkSq137369
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 14:33:46 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22I5Xjht137368;
        Fri, 18 Mar 2022 14:33:45 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jonathan Lassoff <jof@thejof.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Add FAT messages to printk index
References: <d9aee29aaf11f4a26356e9f1c844b40cb4a7a63d.1647537330.git.jof@thejof.com>
Date:   Fri, 18 Mar 2022 14:33:45 +0900
In-Reply-To: <d9aee29aaf11f4a26356e9f1c844b40cb4a7a63d.1647537330.git.jof@thejof.com>
        (Jonathan Lassoff's message of "Thu, 17 Mar 2022 10:17:47 -0700")
Message-ID: <87r16zn7t2.fsf@mail.parknet.co.jp>
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
>
> Signed-off-by: Jonathan Lassoff <jof@thejof.com>

Looks good. I prefer removing duplication of message prefix though, not
strong opinion.

e.g.
	#define FAT_MSG_PFX		"%sFAT-fs (%s): "
	printk_index_subsys_emit(FAT_MSG_PFX, level, fmt, ##args);\
	_printk(FAT_MSG_PFX "%pV\n", level, sb->s_id, &vaf);

Anyway, if this is same style with others, it is ok.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/fat.h  | 8 +++++++-
>  fs/fat/misc.c | 4 ++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 02d4d4234956..9b7f917dfe68 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -433,8 +433,14 @@ void __fat_fs_error(struct super_block *sb, int report, const char *fmt, ...);
>  	__fat_fs_error(sb, 1, fmt , ## args)
>  #define fat_fs_error_ratelimit(sb, fmt, args...) \
>  	__fat_fs_error(sb, __ratelimit(&MSDOS_SB(sb)->ratelimit), fmt , ## args)
> +
> +#define fat_msg(sb, level, fmt, args...)				\
> +do {									\
> +	printk_index_subsys_emit("%sFAT-fs (%s): ", level, fmt, ##args);\
> +	_fat_msg(sb, level, fmt, ##args);				\
> +} while(0)
>  __printf(3, 4) __cold
> -void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...);
> +void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...);
>  #define fat_msg_ratelimit(sb, level, fmt, args...)	\
>  	do {	\
>  			if (__ratelimit(&MSDOS_SB(sb)->ratelimit))	\
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 91ca3c304211..b0808bb0c75f 100644
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
> +	_printk("%sFAT-fs (%s): %pV\n", level, sb->s_id, &vaf);
>  	va_end(args);
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
