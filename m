Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F018B5ADF62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiIFGHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiIFGHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:07:15 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890776EF37;
        Mon,  5 Sep 2022 23:07:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] md: Remove extra mddev_get() in md_seq_start()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662444431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1CvBcxrHvkaMLJk5BCgtnP/bQwD8Zm5U2RwKt6uWao=;
        b=kOyQ4jXN8FYJcHCE6RT1CkOxgPt/OJ2qu67NYxffw5ImSjOgHdTEM1GaYxLhnafgSrfFb1
        8C7dg6Mpw2rK2VTD8Ytln5grtPk4AYoU3HZahU5gLhL6J9pk1py2c2IdvOgYO1rp218zZ9
        bKn42dPBBPv5Pw6i6GC9hgIY7iN/CM8=
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220902171609.23376-1-logang@deltatee.com>
 <20220902171609.23376-3-logang@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <09bd3888-db60-3221-6820-055c0ee9e29a@linux.dev>
Date:   Tue, 6 Sep 2022 14:06:51 +0800
MIME-Version: 1.0
In-Reply-To: <20220902171609.23376-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/22 1:16 AM, Logan Gunthorpe wrote:
> A regression is seen where mddev devices stay permanently after they
> are stopped due to an elevated reference count.
>
> This was tracked down to an extra mddev_get() in md_seq_start().
>
> It only happened rarely because most of the time the md_seq_start()
> is called with a zero offset. The path with an extra mddev_get() only
> happens when it starts with a non-zero offset.
>
> The commit noted below changed an mddev_get() to check its success
> but inadevrtantly left the original call in. Remove the extra call.
>
> Fixes: 12a6caf27324 ("md: only delete entries from all_mddevs when the disk is freed")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/md/md.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index afaf36b2f6ab..9dc0175280b4 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8154,7 +8154,6 @@ static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>   	list_for_each(tmp,&all_mddevs)
>   		if (!l--) {
>   			mddev = list_entry(tmp, struct mddev, all_mddevs);
> -			mddev_get(mddev);
>   			if (!mddev_get(mddev))
>   				continue;
>   			spin_unlock(&all_mddevs_lock);

Acked-by: Guoqing Jiang <Guoqing.jiang@linux.dev>

Thanks,
Guoqing
