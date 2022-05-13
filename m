Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8378F525A02
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376699AbiEMDU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376711AbiEMDUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:20:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB813630B;
        Thu, 12 May 2022 20:20:49 -0700 (PDT)
Received: from kwepemi500017.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kzv3T5p4TzGpZj;
        Fri, 13 May 2022 11:17:57 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500017.china.huawei.com (7.221.188.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 11:20:47 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 11:20:47 +0800
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
To:     Matthew Ruffell <matthew.ruffell@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
 <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
 <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
 <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <0eb5ff67-b1f0-a8c4-281c-55a5ded58662@huawei.com>
Date:   Fri, 13 May 2022 11:20:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/05/13 10:56, Matthew Ruffell 写道:
> Hi Josef,
> 
> Just a friendly ping, I am more than happy to test a patch, if you send it
> inline in the email, since the pastebin you used expired after 1 day, and I
> couldn't access it.
> 
> I came across and tested Yu Kuai's patches [1][2] which are for the same issue,
> and they indeed fix the hang. Thank you Yu.
Hi, Matthew

Thanks for your test.
> 
> [1] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
> https://lists.debian.org/nbd/2022/04/msg00212.html
> 
> [2] nbd: fix io hung while disconnecting device
> https://lists.debian.org/nbd/2022/04/msg00207.html
> 
> I am also happy to test any patches to fix the I/O errors.

Sorry that I missed this thread. IMO, if inflight requests is cleared by
ioctl NBD_CLEAR_SOCK after my patch [2](or other callers for
nbd_clear_que()), such io will return as error. Thus I don't think such
io errors need to be fixed.

Josef, do you have other suggestions?

Thanks,
Kuai
