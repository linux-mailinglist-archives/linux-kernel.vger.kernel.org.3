Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400085AABB0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiIBJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiIBJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:42:51 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472BCC313;
        Fri,  2 Sep 2022 02:42:50 -0700 (PDT)
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662111768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8Kc9a6IYh+B0uDdB9rP/9drAY2TjHfazB76nPQof7U=;
        b=orfit9U619DEt+cBr/qS9fufKhUpDPvnWSqYsi2vUmbT/lqX3GxdtrW0vtGOGHx4/8ffyR
        xhe5pqH4rXVKxSNsmaKptuAZAMmr7uNPdBL86UyusxFt9fpY3HqfyHF6fFdInvj+R1SYnn
        7fo4AGd/nxb18wBP2jJbmBXX68XuMTM=
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <3d8859bc-80d6-08b0-fd40-8874df4d3419@linux.dev>
Date:   Fri, 2 Sep 2022 17:42:42 +0800
MIME-Version: 1.0
In-Reply-To: <20220829131502.165356-3-yukuai1@huaweicloud.com>
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

Hi,

On 8/29/22 9:15 PM, Yu Kuai wrote:
> +static bool wait_barrier_nolock(struct r10conf *conf)
> +{
> +	unsigned int seq = raw_read_seqcount(&conf->resync_lock.seqcount);
> +
> +	if (seq & 1)
> +		return false;
> +
> +	if (READ_ONCE(conf->barrier))
> +		return false;
> +
> +	atomic_inc(&conf->nr_pending);
> +	if (!read_seqcount_retry(&conf->resync_lock.seqcount, seq))

I think 'seq' is usually get from read_seqcount_begin.

> +		return true;
> +
> +	atomic_dec(&conf->nr_pending);
> +	return false;
> +

Thanks,
Guoqing
