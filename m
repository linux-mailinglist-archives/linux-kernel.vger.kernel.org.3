Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD35A5BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiH3GcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiH3GcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:32:11 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1CBBA46;
        Mon, 29 Aug 2022 23:32:08 -0700 (PDT)
Received: from [192.168.0.6] (ip5f5aea19.dynamic.kabel-deutschland.de [95.90.234.25])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2C87B61EA192A;
        Tue, 30 Aug 2022 08:32:05 +0200 (CEST)
Message-ID: <684887c7-c5a7-12d7-2975-d027802de4de@molgen.mpg.de>
Date:   Tue, 30 Aug 2022 08:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 1/3] md/raid10: fix improper BUG_ON() in
 raise_barrier()
To:     John Stoffel <john@stoffel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-2-yukuai1@huaweicloud.com>
 <25357.6485.659159.476926@quad.stoffel.home>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <25357.6485.659159.476926@quad.stoffel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear John,


Am 29.08.22 um 21:53 schrieb John Stoffel:
>>>>>> "Yu" == Yu Kuai <yukuai1@huaweicloud.com> writes:
> 
> Yu> From: Yu Kuai <yukuai3@huawei.com>

The quoting style is really confusing, as it does not seem to be the 
standard, and a lot of MUAs won’t mark up the citation.

[…]

> Yu> 'conf->barrier' is protected by 'conf->resync_lock', reading
> Yu> 'conf->barrier' without holding the lock is wrong.
> 
> Yu> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Yu> ---
> Yu>  drivers/md/raid10.c | 2 +-
> Yu>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Yu> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> Yu> index 9117fcdee1be..b70c207f7932 100644
> Yu> --- a/drivers/md/raid10.c
> Yu> +++ b/drivers/md/raid10.c
> Yu> @@ -930,8 +930,8 @@ static void flush_pending_writes(struct r10conf *conf)
>   
> Yu>  static void raise_barrier(struct r10conf *conf, int force)
> Yu>  {
> Yu> -	BUG_ON(force && !conf->barrier);
> Yu>  	spin_lock_irq(&conf->resync_lock);
> Yu> +	BUG_ON(force && !conf->barrier);
> 
> I don't like this BUG_ON() at all, why are you crashing the system
> here instead of just doing a simple WARN_ONCE() instead?  Is there
> anything the user can do to get into this situation on their own, or
> does it really signify a logic error in the code?  If so, why are you
> killing the system?

As you can see, the BUG_ON() was there before, so it’s unrelated to this 
patch and Yun is not killing anything.

[…]


> Yu>  	/* Wait until no block IO is waiting (unless 'force') */
> Yu>  	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
> Yu> --
> Yu> 2.31.1


Kind regards,

Paul
