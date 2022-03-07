Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53074D0C14
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiCGXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbiCGXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:31:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302735521C;
        Mon,  7 Mar 2022 15:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA43B81737;
        Mon,  7 Mar 2022 23:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BA1C340E9;
        Mon,  7 Mar 2022 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646695858;
        bh=GLHZ0g7/ahjQIoT7Hjah1xiXd6M2mLb2IGNVLEJ/7Gs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=REJp/obTuejYpLoch8Hfxx/RSRxb6X5P89DxJtG7F3ptwSa1P7l+zjQrRftm1DR1U
         u1B5TqV2fiDfudWL6kn5MolHJtFHQutExXkVvcN9m+LbS6eFoCMObkkk3sHPLFiR/B
         kmDpmDZjLVVfKtD7HUAKe/Hbf+C17J2cD48B5+mw=
Date:   Mon, 7 Mar 2022 15:30:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2] taskstats: remove unneeded dead assignment
Message-Id: <20220307153057.3212144c1ba19a10573df079@linux-foundation.org>
In-Reply-To: <20220307093942.21310-1-lukas.bulwahn@gmail.com>
References: <20220307093942.21310-1-lukas.bulwahn@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Mar 2022 10:39:42 +0100 Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> make clang-analyzer on x86_64 defconfig caught my attention with:
> 
>   kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
>   [clang-analyzer-deadcode.DeadStores]
>           rc = 0;
>           ^
> 
> Commit d94a041519f3 ("taskstats: free skb, avoid returns in
> send_cpu_listeners") made send_cpu_listeners() not return a value and
> hence, the rc variable remained only to be used within the loop where
> it is always assigned before read and it does not need any other
> initialisation.
> 
> So, simply remove this unneeded dead initializing assignment.
> 
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change to object code.
> 
> ...
>
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
>  
>  	genlmsg_end(skb, reply);
>  
> -	rc = 0;
>  	down_read(&listeners->sem);
>  	list_for_each_entry(s, &listeners->list, list) {
>  		skb_next = NULL;

Yup.  It would be better to also reduce the scope of `rc' so later code
can't go and read it uninitialized.

--- a/kernel/taskstats.c~taskstats-remove-unneeded-dead-assignment-fix
+++ a/kernel/taskstats.c
@@ -113,12 +113,14 @@ static void send_cpu_listeners(struct sk
 	struct listener *s, *tmp;
 	struct sk_buff *skb_next, *skb_cur = skb;
 	void *reply = genlmsg_data(genlhdr);
-	int rc, delcount = 0;
+	int delcount = 0;
 
 	genlmsg_end(skb, reply);
 
 	down_read(&listeners->sem);
 	list_for_each_entry(s, &listeners->list, list) {
+		int rc;
+
 		skb_next = NULL;
 		if (!list_is_last(&s->list, &listeners->list)) {
 			skb_next = skb_clone(skb_cur, GFP_KERNEL);
_

(we could just elimiate `rc' altogether, but I think the above is OK,
perhaps a little more readable).

