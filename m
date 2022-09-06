Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51A5AF2C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIFRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIFRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67761327
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 057A1615CE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCECC433D6;
        Tue,  6 Sep 2022 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662485647;
        bh=c78Ljv59LKjc8ajv0M146fZb7j7a0Cv8JLzlWL1IQTY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U75+qXeCQBd7r6wuzBPzNQqALZiRKM4ycWzPHEK2F42soPoH/mzoLeKT0bZHfytHB
         8qnJ+ml1JiOHURgXY12EE2bfhRxU7SO6UoVFalVbvTWdoYlP+I3EDIILYBytMsZhwu
         zQnLOY/kV3ffMCDaiEn4tQJfNZjTuE6vop6bm6CLg7JP8R4goElK/FBPpcr30Veycj
         kd40927bvp1wLv7Jt4sC4yCiUT/A7Kk2y8O4OXHIWwjmJbU+IKRdd29MU+zuv6zMBY
         a4HwydQ1UerI5CFQ1nHLtUsgua2tNTLX5F3rG8Jy9KDlaPuVlUo2zE+Iu1h/IFpeA/
         tkx9eJHNYYlhg==
Message-ID: <5a1cb21c-61f4-8ae6-8689-126ed85891ee@kernel.org>
Date:   Tue, 6 Sep 2022 19:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] rv/reactor: add __init/__exit annotations to module
 init/exit funcs
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220906141210.132607-1-xiujianfeng@huawei.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220906141210.132607-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 16:12, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.
> 
> Fixes: 135b881ea885 ("rv/reactor: Add the printk reactor")
> Fixes: e88043c0ac16 ("rv/reactor: Add the panic reactor")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
> ---
>  kernel/trace/rv/reactor_panic.c  | 4 ++--
>  kernel/trace/rv/reactor_printk.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
> index b698d05dd069..d65f6c25a87c 100644
> --- a/kernel/trace/rv/reactor_panic.c
> +++ b/kernel/trace/rv/reactor_panic.c
> @@ -24,13 +24,13 @@ static struct rv_reactor rv_panic = {
>  	.react = rv_panic_reaction
>  };
>  
> -static int register_react_panic(void)
> +static int __init register_react_panic(void)
>  {
>  	rv_register_reactor(&rv_panic);
>  	return 0;
>  }
>  
> -static void unregister_react_panic(void)
> +static void __exit unregister_react_panic(void)
>  {
>  	rv_unregister_reactor(&rv_panic);
>  }
> diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
> index 31899f953af4..4b6b7106a477 100644
> --- a/kernel/trace/rv/reactor_printk.c
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -23,13 +23,13 @@ static struct rv_reactor rv_printk = {
>  	.react = rv_printk_reaction
>  };
>  
> -static int register_react_printk(void)
> +static int __init register_react_printk(void)
>  {
>  	rv_register_reactor(&rv_printk);
>  	return 0;
>  }
>  
> -static void unregister_react_printk(void)
> +static void __exit unregister_react_printk(void)
>  {
>  	rv_unregister_reactor(&rv_printk);
>  }

