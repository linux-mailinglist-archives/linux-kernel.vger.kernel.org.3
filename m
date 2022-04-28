Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7B95128AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiD1BUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiD1BUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:20:12 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88464BE1;
        Wed, 27 Apr 2022 18:16:59 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] md/raid5: Refactor raid5_make_request loop
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651108617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Xwu3P+Vnz59GR97kf/BPusICnrHsO9eK/MxwfaNVe8=;
        b=GxJBrNDCCEotL1plDVrJvTIiBUPGVoKGhfZ46HVPAbiZ8fz+ck1dSOLokSaYis/nMVAMIq
        Bz0wmYcnBP2cKhl/e7yfxxUZtYKygq9BLBcQw4AWQOX3vYv3Zypm45ZZetVPhd6jLqPTgE
        oZAbFGZvnNppF1kdkRogYh2B/EYtRdo=
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-3-logang@deltatee.com>
 <eb1d70f6-0cfc-20e9-8fb3-84e3076025f7@linux.dev>
 <7db3cc87-c491-1ba4-d778-1c7dbbf34c47@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <ac112584-ae97-f7e6-a593-f75c5d22d3b9@linux.dev>
Date:   Thu, 28 Apr 2022 09:16:49 +0800
MIME-Version: 1.0
In-Reply-To: <7db3cc87-c491-1ba4-d778-1c7dbbf34c47@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 4/28/22 12:08 AM, Logan Gunthorpe wrote:
>
>>> +        if (unlikely(!sh)) {
>>> +            /* cannot get stripe, just give-up */
>>> +            bi->bi_status = BLK_STS_IOERR;
>>> +            break;
>>> +        }
>>
>> Nit, I would suggest to keep below original comment.
> But the original comment was plainly wrong...

I think it was for get stripe for read-ahead.

https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/md/raid5.c#L5869

And it deserves a separate change if you think the comment is wrong, but
just my $0.02.

Thanks,
Guoqing
