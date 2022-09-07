Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F85B098B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiIGQED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiIGQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C67518E05
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662566499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9pHqkBQHX8167MxA1KNcgyy5zsR5NBPOvaAz5NiOX4=;
        b=dG2Z3UiyITdw7HEoU0xA4KAx/Vg+ec7EAE6yokgkRADsKBhOjRAxdgs3fbVxXAAyYgzuHP
        pd9HWETYcLIZENhs+PykSNe3TkUA9AeMerNmas8Tjy1Jmjs+Mo4IXWRssaqA1QQhsTi1IQ
        ni159lEfUAU09vOaVZ/V5zk3AK3oh4I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-OtG3oDeXMEKAZsg5lk1GwQ-1; Wed, 07 Sep 2022 12:01:37 -0400
X-MC-Unique: OtG3oDeXMEKAZsg5lk1GwQ-1
Received: by mail-pf1-f198.google.com with SMTP id f16-20020aa782d0000000b0053e242136bfso3078541pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=h9pHqkBQHX8167MxA1KNcgyy5zsR5NBPOvaAz5NiOX4=;
        b=NZu56djyGd2ZXjlggD8bb48w+I0CFrzkFp+LJI2evpXp/flkqKcDB00uAb/CpD4UY9
         2MWf/0ZB+eT29DGR9tGGQd+5bIB/+QJOWZnTxRTbiCbzd8DGH5k2b6D3wSH5pYm/wDLN
         C14rORARyDMIz6+eChiindCwkz0JiHHCdJM6btuCpWd/F7YynDmz31qjhkkAY8MLeViQ
         1Jz/4VeoCrbvPDBUsqX9zuyrEXGz/8/cqjw988XwhQP6QAdaSyl9tCtCia7n8rFIHFDn
         zjYqgnikWWOvzMEuUXT55PkVV8MxDR6bPO3BC7LT6Cn2SmjgTXl5GWJYxilgCf11moKj
         jFYw==
X-Gm-Message-State: ACgBeo0xmRXZ5c2SRu+feZ7Mn1OcqPfH2vy/yraP/vol3QF2ONhB7yOS
        /b4wAHb7dqPo02FNVoUSqyWTBbU2fKWac7mOndvD7VVdZ8ZbalyWILsBl8n8iX4TTFKzkiRbZRr
        sfigWioxkFaGBAkp8xu5bvh6K
X-Received: by 2002:a63:de07:0:b0:434:d973:5dff with SMTP id f7-20020a63de07000000b00434d9735dffmr4035111pgg.44.1662566496668;
        Wed, 07 Sep 2022 09:01:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4A/tpFmu7id03CRio33v4errht27tacIBTZ0QSJ6m/c1znAJf/jOKMP7VahH/QiazNIZpWiQ==
X-Received: by 2002:a63:de07:0:b0:434:d973:5dff with SMTP id f7-20020a63de07000000b00434d9735dffmr4035088pgg.44.1662566496417;
        Wed, 07 Sep 2022 09:01:36 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b001752cb111e0sm12706532plg.69.2022.09.07.09.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:01:36 -0700 (PDT)
Date:   Thu, 08 Sep 2022 01:01:32 +0900 (JST)
Message-Id: <20220908.010132.1804908388305469820.syoshida@redhat.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        syoshida@redhat.com,
        syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/ntfs3: Fix memory leak on ntfs_fill_super() error
 path
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20220823103205.1380235-1-syoshida@redhat.com>
References: <20220823103205.1380235-1-syoshida@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Tue, 23 Aug 2022 19:32:05 +0900, Shigeru Yoshida wrote:
> syzbot reported kmemleak as below:
> 
> BUG: memory leak
> unreferenced object 0xffff8880122f1540 (size 32):
>   comm "a.out", pid 6664, jiffies 4294939771 (age 25.500s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 ed ff ed ff 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81b16052>] ntfs_init_fs_context+0x22/0x1c0
>     [<ffffffff8164aaa7>] alloc_fs_context+0x217/0x430
>     [<ffffffff81626dd4>] path_mount+0x704/0x1080
>     [<ffffffff81627e7c>] __x64_sys_mount+0x18c/0x1d0
>     [<ffffffff84593e14>] do_syscall_64+0x34/0xb0
>     [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> This patch fixes this issue by freeing mount options on error path of
> ntfs_fill_super().
> 
> Reported-by: syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  fs/ntfs3/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 47012c9bf505..c0e45f170701 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1281,6 +1281,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	 * Free resources here.
>  	 * ntfs_fs_free will be called with fc->s_fs_info = NULL
>  	 */
> +	put_mount_options(sbi->options);
>  	put_ntfs(sbi);
>  	sb->s_fs_info = NULL;
>  
> -- 
> 2.37.2
> 

