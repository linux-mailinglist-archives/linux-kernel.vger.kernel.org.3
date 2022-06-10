Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8E54679D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiFJNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiFJNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:48:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB57B85A;
        Fri, 10 Jun 2022 06:48:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A21B66016C3;
        Fri, 10 Jun 2022 14:48:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654868899;
        bh=BilRyir/crWErV5fDo+jnVnwBSywHk1bpFGWraz5JfE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DrRRUOEsNVSqutVev5GSgPTtKnxmDE8RX1DeJEFL8ZR0X2MWoUbUH5056NeZupqrg
         Q7y+G+GkFsWuHQYaStTi5HJJnTOGHNJkZpZssd6lQgCVDWvotuHXl5kmjRPEmVJgLy
         2A9O5IQfEgY6b3R2WemU2ybfZMtOt3dPIKmA9F+B2c81AtjyLXJKBZFUlzhq44SB5J
         5AMP2gzYPYrtLTYS7o/bSDcoUWmMEqQa/EwolszCkRAz8JbWIIb82lHm30bxg0wKge
         eUHTILodjzMFTrVizRWtclUjANnqI8Uu4OCyh1BLR35kmM93XWvxEMZ/kKjsjQt9lV
         +iZTu+0qbmyCw==
Message-ID: <1cfcfa52-923d-fa4b-05c8-88635f8d93e5@collabora.com>
Date:   Fri, 10 Jun 2022 16:48:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 4/5] media: rkvdec: Re-enable H.264 error detection
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
 <20220610125215.240539-5-nicolas.dufresne@collabora.com>
 <20220610132017.GD2146@kadam>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220610132017.GD2146@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 16:20, Dan Carpenter wrote:
> On Fri, Jun 10, 2022 at 08:52:14AM -0400, Nicolas Dufresne wrote:
>> This re-enables H.264 error detection, but using the other error mode.
>> In that mode, the decoder will skip over the error macro-block or
>> slices and complete the decoding. As a side effect, the error status
>> is not set in the interrupt status register, and instead errors are
>> detected per format. Using this mode workaround the issue that the
>> HW get stuck in error stated and allow reporting that some corruption
>> may be present in the buffer returned to userland.
>>
>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> ---
>>  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> index 55596ce6bb6e..60a89918e2c1 100644
>> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> @@ -1175,14 +1175,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>>  
>>  	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
>>  
>> -	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
>> -	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
>> +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
>> +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> 
> This reverts the changes in patch 1/5.  Could we just skip patch 1/5
> instead?

The first patch must go to the stable kernels, hence we couldn't skip it.

-- 
Best regards,
Dmitry
