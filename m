Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DBC569E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiGGJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiGGJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:16:50 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257F2CDDC;
        Thu,  7 Jul 2022 02:16:49 -0700 (PDT)
Received: from usmail.veeam.com (colmbx01.amust.local [172.18.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id E5A3F40A6F;
        Thu,  7 Jul 2022 05:16:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1657185405;
        bh=lO0+ynw53umMSGxq4f6KEddvl3ZO5H+vLPy0wh+Kmqo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=L92dnU98ZSmTfOdwNQe427QO2VCUgXK/s+TcXmLUowzduFSLUP4cZBCazWLgrYM3K
         q+cGGOJvFbmJ35jcriJV7JbJnJ9ngMYY+a8rzVRfAH4a/3AycNZJK58lFJuQg0Jupd
         ENYelkQxeNp1yTGRn+B0vY6FX++v3woxbJr3JZG4xvr29xmuiKtQsqCaSc5lzhH5ak
         uHCAsoF0MWU2165u9EYfgik+StUnz4MiB++01p7ELm/oxmkMDooo/2rZcMTM82D/bL
         HlJ4LULqCRiQy6K8Zzuf77SyG7U8uim+/+2zB43QeWU3gkgPxkVqm2CQYhi0ttgvKC
         80VYjTY/WZCXQ==
Received: from [172.24.11.83] (172.24.11.83) by colmbx01.amust.local
 (172.18.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 7 Jul 2022
 05:16:43 -0400
Message-ID: <49039d2b-e4bc-62a1-7b4a-a78001a2f430@veeam.com>
Date:   Thu, 7 Jul 2022 11:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/20] block, blksnap: snapshot image block device
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-16-git-send-email-sergei.shtepa@veeam.com>
 <YsWKhjDV18DeyEZ8@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <YsWKhjDV18DeyEZ8@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.11.83]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 colmbx01.amust.local (172.18.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29078F7554657267
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>> +static int snapimage_init_request(struct blk_mq_tag_set *set,
>> +				  struct request *rq, unsigned int hctx_idx,
>> +				  unsigned int numa_node)
>> +{
>> +	struct snapimage_cmd *cmd = blk_mq_rq_to_pdu(rq);
>> +
>> +	kthread_init_work(&cmd->work, snapimage_queue_work);
>> +	return 0;
>> +}
> I'm a little confused on why this both has a blk-mq interface and
> the new bio filter interface.  Whow is going to submit I/O to this
> blk-mq interface?
> 

Sorry, it seems to me that I didn't understand this comment.

The module creates a block device for each snapshot image.
To make a backup of a block device, the backup tool reads snapshot image.
This snapshot image block device allows to mount a file system on it
and perform the necessary preparation. If not for this requirement,
it would be possible to implement reading via an additional ioctl.
But that wouldn't be a good design, I think.

Perhaps I have implemented this block device incorrectly?
Processing requests of the snapshot image block device is started
in the function snapimage_queue_rq(). And ends in the 
snapimage_queue_work() in another kernel thread. Therefore, when
the request is initialized in snapimage_init_request(), a kernel worker
is prepared.

>> +	//.open = snapimage_open,
>> +	//.ioctl = snapimage_ioctl,
>> +	//.release = snapimage_close,
> Please don't leave commented out code around.
> 
