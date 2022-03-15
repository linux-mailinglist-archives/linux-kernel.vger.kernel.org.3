Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AC4D9903
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiCOKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347191AbiCOKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9862D2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:43:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s8so18940746pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=Q+oG0q/OqpLeOMe0H9+8fCVYgPq3RWnQ9esOTCEo9I4=;
        b=GmrNy/EK2El8Qw8A/91ozUTgFaBURa6uPzKvvy0YkvcyJS3P+iOJjGwbO4eG7Ctpri
         JWWHthx/4feeSYD+uhkMt+t13hDbnibm4lQo6cAYmEgOFi5B7Jsm04536KqB+JnBhimX
         S3ntghb/gA2uWNhPzbiuCl5wcK+SxR8ffu0egGVvPtdx6yUdq3UcxMwTy6U+j1j21K6f
         4XGvSC4iLgDV/cYn6W8yZKRh0aiZDJ0BrPLkDXtwkySV0B68UPhGGmRuXinE1UUiUj4k
         DbhIJHIovavmuCt0eSWgLp+tnqeJvuZ+OubQHOzWPM+gByqQfOM2JbfHUl+Wj6X05ZHn
         Uvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q+oG0q/OqpLeOMe0H9+8fCVYgPq3RWnQ9esOTCEo9I4=;
        b=3NBBshwlAsQvTJZLVpD3WkvVYYy/o3CzF++p8QKsBDAGNoce6Is7wPMmvp26Xh4huS
         zUDF3eNINgsQMF4jDwdOMhXFy1PPcV5qeNYaIEngXr8Jb25GPxRkxDo8f9O9K9BisrKN
         iMI+1ibkERtvwP/EiG03P3x47TNfcuJKdc33n6EhAd+JAeDlG0pHV4ZsYtjCthJyZoqh
         F/e+HiTxwxKuN6zDBRF4ysoJ16Yr+ctOIOqqPOUtk0TFoxLrTBXIoaMQuHycRvy07rw1
         C5OjfdM36RJ0hj4O/p4cH6vI/gAFJczremTCFX+P9YBl+F6RIeFO4+0l5u6s8JXgyvJH
         Ir5w==
X-Gm-Message-State: AOAM530pYAwqJWZ8ho+H2B9T8J1sq8FBfxFov/L43A3cqfZ38RAckaaQ
        Vxux3ZVBi01wV2WT8iWPzpI=
X-Google-Smtp-Source: ABdhPJy0ZY7pJoy5uStZDfEyHqVPsFxyURBpRlzb1QREakRD2kLUJZORdGMdmOXiYkJS5xKQh6yQTw==
X-Received: by 2002:a63:7158:0:b0:37d:f96f:3c78 with SMTP id b24-20020a637158000000b0037df96f3c78mr23048426pgn.378.1647340983404;
        Tue, 15 Mar 2022 03:43:03 -0700 (PDT)
Received: from [127.0.0.1] ([103.97.175.139])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004f776098715sm19768027pfc.68.2022.03.15.03.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 03:43:03 -0700 (PDT)
Message-ID: <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
Date:   Tue, 15 Mar 2022 18:43:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To:     Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
From:   Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <20220315075152.63789-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/15 15:51, Dongliang Mu 写道:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
>
> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> is triggered by injecting fault in kobject_init_and_add of
> erofs_unregister_sysfs.
>
> Fix this by remembering if kobject_init_and_add is successful.
>
> Note that I've tested the patch and the crash does not occur any more.
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   fs/erofs/internal.h | 1 +
>   fs/erofs/sysfs.c    | 9 ++++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 5aa2cf2c2f80..9e20665e3f68 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -144,6 +144,7 @@ struct erofs_sb_info {
>   	u32 feature_incompat;
>   
>   	/* sysfs support */
> +	bool s_sysfs_inited;

Hi Dongliang,

How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra 
member in sbi ?

Thanks,
Jianan

>   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>   	struct completion s_kobj_unregister;
>   };
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index dac252bc9228..2b48a4df19b4 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
>   				   "%s", sb->s_id);
>   	if (err)
>   		goto put_sb_kobj;
> +	sbi->s_sysfs_inited = true;
>   	return 0;
>   
>   put_sb_kobj:
> @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> -	wait_for_completion(&sbi->s_kobj_unregister);
> +	if (sbi->s_sysfs_inited) {
> +		kobject_del(&sbi->s_kobj);
> +		kobject_put(&sbi->s_kobj);
> +		wait_for_completion(&sbi->s_kobj_unregister);
> +	}
>   }
>   
>   int __init erofs_init_sysfs(void)

