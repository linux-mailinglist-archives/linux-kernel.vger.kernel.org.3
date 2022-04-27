Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D551510DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356735AbiD0Bfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354729AbiD0Bfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:35:33 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C946B27;
        Tue, 26 Apr 2022 18:32:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651023142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNundTitWrjHN9Al1s781albF2X/onqhV3Sz2DqMeZ8=;
        b=YRuf7WFtBwyQD9Ur4tUSqUSlzlK+bNkQoYqtV/wA8/auIQOmAgv4i+q8dni/impRbC/NPq
        Rggz+YEbEShz745x3N5mFgfrEd54UBrXZ+2Df+S551AXmMXVnVWcBk0mSo6HRurKz3EMHO
        kO2J1mik2kU9GoL2u5QFJC+U3kKpYJQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2 02/12] md/raid5: Refactor raid5_make_request loop
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-3-logang@deltatee.com>
Message-ID: <eb1d70f6-0cfc-20e9-8fb3-84e3076025f7@linux.dev>
Date:   Wed, 27 Apr 2022 09:32:14 +0800
MIME-Version: 1.0
In-Reply-To: <20220420195425.34911-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 3:54 AM, Logan Gunthorpe wrote:
> Break immediately if raid5_get_active_stripe() returns NULL and deindent
> the rest of the loop. Annotate this check with an unlikely().
>
> This makes the code easier to read and reduces the indentation level.
>
> No functional changes intended.
>
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>
> ---
>   drivers/md/raid5.c | 109 +++++++++++++++++++++++----------------------
>   1 file changed, 55 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 97b23c18402b..cda6857e6207 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5906,68 +5906,69 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)

...

> +		if (unlikely(!sh)) {
> +			/* cannot get stripe, just give-up */
> +			bi->bi_status = BLK_STS_IOERR;
> +			break;
> +		}


Nit, I would suggest to keep below original comment.

> -			/* cannot get stripe for read-ahead, just give-up */
> -			bi->bi_status = BLK_STS_IOERR;
> -			break;

Anyway. Reviewed-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
