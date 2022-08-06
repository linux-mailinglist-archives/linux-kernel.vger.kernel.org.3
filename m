Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6B58B654
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiHFPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiHFPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:12:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172A11462
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:12:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y11so7062641lfs.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nJgH9jf4zBqYwN75WuYtVCH/zXqe5QbnFpiXQzfdY5s=;
        b=SVRdA9uHWGTsPpW3/cdWa00CNDtzXkiAv4zLVZfQSoCPFWG5n3C4mUe+bAPlu0NvsY
         fvMQaNIqamwQ8WgLAA1CR4/boCSLiVa6IO+ja99AK84GOqBcaCtKdxmHeEfvhJnp9YTw
         DQ1EoxCp9xQudZYniFJ1H00ctuPzuyMXv+9c874AWhVYaJTTN1El57u+ZOK9UpaKwGfA
         apqNIDOJ7rlrJ0McfyQXjak2OcOFrJKDpw7ncU00cGdJJYvCoEnY4nf1jyamATbCjQUm
         zUuwCOrNLcGyHNh9zVQ7YOoiEDJEOw1ByrW5kckg+RHSJ2y7e5xJ3d9hUWyloROodSvm
         O5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nJgH9jf4zBqYwN75WuYtVCH/zXqe5QbnFpiXQzfdY5s=;
        b=dUpzw5RVqcHx/6ZfKQR8kePdyT5UpsU4+myvzs8ECFyEYa0EHN+6+RLFckT/vk0dFT
         JTGYteK7fK0WseF6y+/YoCQvuCFCf72akkWcp1nR8z87IbdGtL6rkmmx84H6kublL++F
         08qVFd0R4+h/cFCS3tio1Yn8nWbltpqXKY+QEJeCyyqvfgngeWa/Z5KzaerY4LRBfMmR
         ED035jQc/2txP3q2irs/5PSG3t4xJjkeiawcpISIe9pzTMkMjaqMgiiOwk92a3P4NkPo
         wwbAz++4S7HC7/nEo3qzYpJ8PxkhEswG9HaUiJd48HLCPQV0FVhRNKnfyj6MGYa7qf92
         f6mw==
X-Gm-Message-State: ACgBeo0vQVR+lbhf+uV5xhr0X05Fp9qArq8PXdIbZaS1dR9ndimWgAtT
        cm1xjF3lbhdoqwJNHOwaHCw=
X-Google-Smtp-Source: AA6agR4Y48V6kj9oUiw+hf1wcL4y13ve/lCuQWvn+H+481b10At3fNvO7jGtq2gEeiE21UfgLPFhVQ==
X-Received: by 2002:a19:6414:0:b0:48a:eb80:816b with SMTP id y20-20020a196414000000b0048aeb80816bmr3535339lfb.360.1659798772429;
        Sat, 06 Aug 2022 08:12:52 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id f11-20020a05651c03cb00b0025e0c352465sm525998ljp.82.2022.08.06.08.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 08:12:49 -0700 (PDT)
Message-ID: <ad252b8b-d9b9-f1c4-a853-39d483d1c0d4@gmail.com>
Date:   Sat, 6 Aug 2022 18:12:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] maple_tree: Fix mas_alloc_nodes()
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220802193612.2886170-1-Liam.Howlett@oracle.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220802193612.2886170-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.08.2022 22:36, Liam Howlett пишет:
> Use MAPLE_ALLOC_SLOTS, which differs on 32bit.  This was causing an
> out of bounds issue on 32bit bulk allocations
> 
> Fixes: 06b152b7980a (Maple Tree: add new data structure)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4e41f3394114..032e7bb0d44f 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1242,7 +1242,7 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  
>  	node = mas->alloc;
>  	while (requested) {
> -		max_req = MAPLE_NODE_SLOTS - 1;
> +		max_req = MAPLE_ALLOC_SLOTS;
>  		if (node->slot[0]) {
>  			unsigned int offset = node->node_count + 1;
>  

Hello Liam,

This fixed the bug, thank you!

Tested-by: Dmitry Osipenko <digetx@gmail.com> # ARM32 Tegra
