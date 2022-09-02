Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8E5AA4AA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiIBAts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiIBAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:49:46 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03BDA346C;
        Thu,  1 Sep 2022 17:49:43 -0700 (PDT)
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662079781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tfKxGEYrA0RBCCtx0QWA44gG7pan/FKXmz4kkJLuMg=;
        b=domX3+D/CcCUokpt8f3DKgU6FIdsOVqYte6ENDaUHk2/J4u6HpfQHkqTgdF+RFLQI/Xrpz
        Ik34IbDRuo852jbWQYdjM8LwKB7xjktuvluX2bSV9YPynEX/i0DEMod7H7txypzblnAcMo
        351pFc/7CcnIzf0kGw+AYczU4ttOok0=
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <917c01c1-1e2b-66f9-69f1-ed706b7ffc8f@linux.dev>
Date:   Fri, 2 Sep 2022 08:49:37 +0800
MIME-Version: 1.0
In-Reply-To: <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
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



On 9/2/22 2:41 AM, Logan Gunthorpe wrote:
> Hi,
>
> On 2022-08-29 07:15, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, wait_barrier() will hold 'resync_lock' to read 'conf->barrier',
>> and io can't be dispatched until 'barrier' is dropped.
>>
>> Since holding the 'barrier' is not common, convert 'resync_lock' to use
>> seqlock so that holding lock can be avoided in fast path.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> I've found some lockdep issues starting with this patch in md-next while
> running mdadm tests (specifically 00raid10 when run about 10 times in a
> row).
>
> I've seen a couple different lock dep errors. The first seems to be
> reproducible on this patch, then it possibly changes to the second on
> subsequent patches. Not sure exactly.

That's why I said "try mdadm test suites too to avoid regression." ...

Guoqing
