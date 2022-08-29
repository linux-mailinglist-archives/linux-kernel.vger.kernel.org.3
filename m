Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6905A54D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiH2TyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH2TyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:54:00 -0400
Received: from mail.stoffel.org (li1843-175.members.linode.com [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4E80524;
        Mon, 29 Aug 2022 12:53:59 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 85A4E2172C;
        Mon, 29 Aug 2022 15:53:58 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id A805FA7E37; Mon, 29 Aug 2022 15:53:57 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25357.6485.659159.476926@quad.stoffel.home>
Date:   Mon, 29 Aug 2022 15:53:57 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/3] md/raid10: fix improper BUG_ON() in raise_barrier()
In-Reply-To: <20220829131502.165356-2-yukuai1@huaweicloud.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
        <20220829131502.165356-2-yukuai1@huaweicloud.com>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Yu" == Yu Kuai <yukuai1@huaweicloud.com> writes:

Yu> From: Yu Kuai <yukuai3@huawei.com>
Yu> 'conf->barrier' is protected by 'conf->resync_lock', reading
Yu> 'conf->barrier' without holding the lock is wrong.

Yu> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Yu> ---
Yu>  drivers/md/raid10.c | 2 +-
Yu>  1 file changed, 1 insertion(+), 1 deletion(-)

Yu> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
Yu> index 9117fcdee1be..b70c207f7932 100644
Yu> --- a/drivers/md/raid10.c
Yu> +++ b/drivers/md/raid10.c
Yu> @@ -930,8 +930,8 @@ static void flush_pending_writes(struct r10conf *conf)
 
Yu>  static void raise_barrier(struct r10conf *conf, int force)
Yu>  {
Yu> -	BUG_ON(force && !conf->barrier);
Yu>  	spin_lock_irq(&conf->resync_lock);
Yu> +	BUG_ON(force && !conf->barrier);

I don't like this BUG_ON() at all, why are you crashing the system
here instead of just doing a simple WARN_ONCE() instead?  Is there
anything the user can do to get into this situation on their own, or
does it really signify a logic error in the code?  If so, why are you
killing the system?


 
Yu>  	/* Wait until no block IO is waiting (unless 'force') */
Yu>  	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
Yu> -- 
Yu> 2.31.1

