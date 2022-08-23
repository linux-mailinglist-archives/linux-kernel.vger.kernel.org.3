Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC459D05A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiHWFQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiHWFQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:16:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F764B490
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:16:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x15so11526869pfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MXPT1lY8hsrBMANrjrg5CqtErhku/jy7GXIWUn5wzuU=;
        b=4KSc1T/mHWBDCwzaDm+z0AtdLesPLctv+jklMmsoTTMH7ugk35S6xm61XUV9owsGb9
         aJ4+cVdfXoh8pC/gsgiO5CQteJrU9P4EkTZGZv26Ul5tpvfI3o5o2g37R6gZQlor8pp8
         qlZ8XangLoxwUhCUhvPeCZLWNyhyRIoveVRSmlYAiocUyJut17MKEgL7/jRzmaDkUuCt
         sLCEJriD4iPtBOTPu6gXL3er47v88Xzp07/DQPe0mp+PODHmXUs/R47Yyx6UN+ztMHvu
         K1dPTwdToqt9gttl7FqqMe69uT8Dpf6MDR+zpjEzf+6+aOJNZo92anHl5Z6VzYLmxLtI
         UNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MXPT1lY8hsrBMANrjrg5CqtErhku/jy7GXIWUn5wzuU=;
        b=2gSa0xMM5/rENG7X7CivNXkGs/x/DC+8uAR0DMW71o6cfkKBD4SmjMmhhDFFkji6aT
         nszVcd/Wdl9FHtEvpB7MT/jcMA3x+ZmeVbKwelvC8k0GURAUe4pqrVdDTN4ZkOhOHsaH
         9lG6/MosSQnkHo+XtlpiV86AjOJ26w0E9Q38YhBGpvGkALS82hQV9Y7N4uNRzTIK2Tx3
         yBVplQQWRmkVrqv8gZV6i6p6Fmweiwfrx7tbNMmF0wzGMJ95XxXK3PRgTVvAFZjs5e3o
         0MTDxNQsee+YKbGLcU7N0vjo8/a7n6uBz89mx2LWcu9Y7VTqvcuzVg7ybchu450lUj0d
         RsHw==
X-Gm-Message-State: ACgBeo294h8kZ6pjJr3AyJyE5LHR9p6npxRRFN48eY6gq3QMAdqS7Gzi
        cdqNkeDrZYpaJfOpos24JW/Spg==
X-Google-Smtp-Source: AA6agR7lpQwjA64GSeFOM7sRG8qwpHOPVH+MqbS4Ub3ir2mJ5/fgurfX2B8/lNbN8ywD66yCw05ZmA==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c83 with SMTP id d22-20020a056a00199600b0052eb0f78c83mr24049056pfl.59.1661231763948;
        Mon, 22 Aug 2022 22:16:03 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79591000000b0052aaff953aesm9654401pfj.115.2022.08.22.22.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 22:16:03 -0700 (PDT)
Message-ID: <1c295aaa-6977-d41c-c7eb-61cc398961e5@bytedance.com>
Date:   Tue, 23 Aug 2022 13:15:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 2/7] kernfs: Drop unnecessary "mutex" local variable
 initialization
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-3-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/20 08:05, Tejun Heo wrote:
> These are unnecessary and unconventional. Remove them. Also move variable
> declaration into the block that it's used. No functional changes.
> 

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> ---
>  fs/kernfs/file.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 32b16fe00a9e..6437f7c7162d 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -555,7 +555,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>  				struct kernfs_open_file *of)
>  {
>  	struct kernfs_open_node *on, *new_on = NULL;
> -	struct mutex *mutex = NULL;
> +	struct mutex *mutex;
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
>  	on = kernfs_deref_open_node_locked(kn);
> @@ -599,7 +599,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
>  				 struct kernfs_open_file *of)
>  {
>  	struct kernfs_open_node *on;
> -	struct mutex *mutex = NULL;
> +	struct mutex *mutex;
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
>  
> @@ -776,9 +776,10 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
>  {
>  	struct kernfs_node *kn = inode->i_private;
>  	struct kernfs_open_file *of = kernfs_of(filp);
> -	struct mutex *mutex = NULL;
>  
>  	if (kn->flags & KERNFS_HAS_RELEASE) {
> +		struct mutex *mutex;
> +
>  		mutex = kernfs_open_file_mutex_lock(kn);
>  		kernfs_release_file(kn, of);
>  		mutex_unlock(mutex);
> @@ -796,7 +797,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  {
>  	struct kernfs_open_node *on;
>  	struct kernfs_open_file *of;
> -	struct mutex *mutex = NULL;
> +	struct mutex *mutex;
>  
>  	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
>  		return;
