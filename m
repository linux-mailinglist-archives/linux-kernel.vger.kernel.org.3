Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF08E52EB75
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbiETMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348908AbiETMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:01:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135149920;
        Fri, 20 May 2022 05:01:35 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L4QH04bTnzQkBG;
        Fri, 20 May 2022 19:58:36 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 20:01:32 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 20:01:32 +0800
Subject: Re: [PATCH -next v2] blk-mq: fix panic during blk_mq_run_work_fn()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220520032542.3331610-1-yukuai3@huawei.com>
 <YocOsw6n3y11lNym@T590> <2b7a82e0-1e33-e2ff-74d7-d80f152fdc75@huawei.com>
 <afe9dec4-733d-88e9-850d-5c36e9201119@huawei.com> <YodSlSm/sIC8G2iG@T590>
 <dbe2deec-b007-470f-eb5a-35fae63ad134@huawei.com> <YodlGOo7vrUa7DZK@T590>
 <0e7967de-0c32-790d-fa08-b0bc9ef5923d@huawei.com> <Yod93DOdYosa+SvS@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <8e6a806b-f42e-319b-e6c8-de1f07befce2@huawei.com>
Date:   Fri, 20 May 2022 20:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yod93DOdYosa+SvS@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/05/20 19:39, Ming Lei 写道:

> 
> In short:
> 
> 1) run queue can be in-progress during cleanup queue, or returns from
> cleanup queue; we drain it in both blk_cleanup_queue() and
> disk_release_mq(), see commit 2a19b28f7929 ("blk-mq: cancel blk-mq dispatch
> work in both blk_cleanup_queue and disk_release()")
I understand that, however, there is no garantee new 'hctx->run_work'
won't be queued after 'drain it', for this crash, I think this is how
it triggered:

assum that there is no io, while some bfq_queue is still busy:

blk_cleanup_queue
  blk_freeze_queue
  blk_mq_cancel_work_sync
  cancel_delayed_work_sync(hctx1)
				blk_mq_run_work_fn -> hctx2
				 __blk_mq_run_hw_queue
				  blk_mq_sched_dispatch_requests
				   __blk_mq_do_dispatch_sched
				    blk_mq_delay_run_hw_queues
				     blk_mq_delay_run_hw_queue
				      -> add hctx1->run_work again
  cancel_delayed_work_sync(hctx2)
> 
> 2) tagset can't be touched after blk_cleanup_queue returns because
> tagset lifetime is covered by driver, which is often released after
> blk_cleanup_queue() returns.
> 
> 
> Thanks,
> Ming
> 
> .
> 
