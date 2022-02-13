Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3A4B3CF2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbiBMSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:51:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiBMSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:51:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C802157B36;
        Sun, 13 Feb 2022 10:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79133B80B54;
        Sun, 13 Feb 2022 18:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B95C004E1;
        Sun, 13 Feb 2022 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644778262;
        bh=ajZGYvyhJa3wD0M5n+Jzb3hdgWrFy+cw5hwyaeUdVcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mo5Qq7v0KbYG7JASp6Ui4ZOYm01H43aZtdgy/gGmYOwP76CbNOGbVRD36yY5i8NOt
         QbKyBBg0o9XSsC6foLRZHnM9LSn+99rqQqJg5GiQIT+Ynu+LkwtNTmNJt/emVj3YxK
         6wo7hm0s+6N8m9up9Q/WrUoc8mHS93FTMuRELe5jzpifEalrZ7aHt416jWu0LCsmkD
         A+6FwVo2l3GxbEXD1JmRpzJy1nNymNMx74DnXnDcbaJgZggVN8Wf6y8dK8e9iiysbU
         nfG/YcNdFAxshgCK0BMSpgP54ju2d0Pvog9IcAgeANrsb2KEa1Rc3VdfnqXrhmkj3q
         eAGba/MMB+s/g==
Date:   Sun, 13 Feb 2022 18:57:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/12] iio: buffer-dma: Get rid of outgoing queue
Message-ID: <20220213185740.0322a83d@jic23-huawei>
In-Reply-To: <20220207125933.81634-2-paul@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
        <20220207125933.81634-2-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Feb 2022 12:59:22 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> The buffer-dma code was using two queues, incoming and outgoing, to
> manage the state of the blocks in use.
> 
> While this totally works, it adds some complexity to the code,
> especially since the code only manages 2 blocks. It is much easier to
> just check each block's state manually, and keep a counter for the next
> block to dequeue.
> 
> Since the new DMABUF based API wouldn't use the outgoing queue anyway,
> getting rid of it now makes the upcoming changes simpler.
> 
> With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and can
> be removed.
> 
> v2: - Only remove the outgoing queue, and keep the incoming queue, as we
>       want the buffer to start streaming data as soon as it is enabled.
>     - Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally the
>       same as IIO_BLOCK_STATE_DONE.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Trivial process thing but change log should be here, not above as we don't
want it to end up in the main git log.


>  drivers/iio/buffer/industrialio-buffer-dma.c | 44 ++++++++++----------
>  include/linux/iio/buffer-dma.h               |  7 ++--
>  2 files changed, 26 insertions(+), 25 deletions(-)
> 
