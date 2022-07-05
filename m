Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D7A56672F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiGEJ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiGEJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:59:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF713E16
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B81FCB8172B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC89C341C7;
        Tue,  5 Jul 2022 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657015135;
        bh=qlzS2NkwMaPG5LKejFq3JGLW/HtM6gXJ4fwHVgmljJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfg9926Smyj1YBjSOUpeIidtWvBSz9dSATKfncWvXm+bTNIQDOEpFyf++17KuGU6s
         4lO9LFO54djG04v20BHN4EZkY3WJaOAg7pfX9Y41m9KVN5GPJlIgJwGmg76OXR8Q2f
         5+vnL8NElAa8fRfoalRWxI3qLAM4h+/b8D/pJKZerbmoqCceYHyilPjRs/r5/O4T7G
         ZEiEq0fzuv6wswQ38PyZwMh5FmAeSQAiesm/nyYPIg2k5IIe0oBMA+5OP9Dg3TSQxx
         5VG7r/XIc/SD5IBNZiOEej+RbvGG6LbXALabM9hH+EZURGof9j7Wstn3xiOOh8MYWC
         JjuHhlOmLjATg==
Date:   Tue, 5 Jul 2022 10:58:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yee Lee <yee.lee@mediatek.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Xie Jiyuan <xiejiyuan@vivo.com>
Subject: Re: [PATCH] scs: Fix a wrong parameter in __scs_magic
Message-ID: <20220705095849.GA608@willie-the-truck>
References: <20220704070405.2768538-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704070405.2768538-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:04:03PM +0800, Wan Jiabing wrote:
> __scs_magic() needs a 'void *' variable, but a 'struct task_struct *'
> is given. 'task_scs(tsk)' is the starting address of the task's shadow
> call stack, and '__scs_magic(task_scs(tsk))' is the end address of the
> task's shadow call stack.
> Here should be '__scs_magic(task_scs(tsk))'.
> 
> Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
> Signed-off-by: Xie Jiyuan <xiejiyuan@vivo.com>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  kernel/scs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/scs.c b/kernel/scs.c
> index b7e1b096d906..4c1ce6a6172d 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -125,7 +125,7 @@ static void scs_check_usage(struct task_struct *tsk)
>  	if (!IS_ENABLED(CONFIG_DEBUG_STACK_USAGE))
>  		return;
>  
> -	for (p = task_scs(tsk); p < __scs_magic(tsk); ++p) {
> +	for (p = task_scs(tsk); p < __scs_magic(task_scs(tsk)); ++p) {
>  		if (!READ_ONCE_NOCHECK(*p))
>  			break;
>  		used += sizeof(*p);

Acked-by: Will Deacon <will@kernel.org>

I'm assuming this will go via Andrew or Kees.

Will
