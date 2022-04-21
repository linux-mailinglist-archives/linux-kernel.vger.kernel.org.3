Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE2509F62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383726AbiDUMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383401AbiDUMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:13:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710BDBF49
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:10:21 -0700 (PDT)
Received: from kwepemi100020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kkbv119BkzfZXb;
        Thu, 21 Apr 2022 20:09:33 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi100020.china.huawei.com (7.221.188.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:10:19 +0800
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.111.5) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:10:19 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <glider@google.com>
CC:     <akpm@linux-foundation.org>, <chenzefeng2@huawei.com>,
        <dvyukov@google.com>, <elver@google.com>,
        <huangshaobo6@huawei.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nixiaoming@huawei.com>, <wangbing6@huawei.com>,
        <wangfangpeng1@huawei.com>, <young.liuyang@huawei.com>,
        <zengweilin@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH] kfence: check kfence canary in panic and reboot
Date:   Thu, 21 Apr 2022 20:10:18 +0800
Message-ID: <20220421121018.60860-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CAG_fn=Xs-OqpVCW5KyQLYKXNmQ4aH-KDjY0BrWpqMfPKcu-dug@mail.gmail.com>
References: <CAG_fn=Xs-OqpVCW5KyQLYKXNmQ4aH-KDjY0BrWpqMfPKcu-dug@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.111.5]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: huangshaobo <huangshaobo6@huawei.com>
> >
> > when writing out of bounds to the red zone, it can only be detected at
> > kfree. However, there were many scenarios before kfree that caused this
> > out-of-bounds write to not be detected. Therefore, it is necessary to
> > provide a method for actively detecting out-of-bounds writing to the red
> > zone, so that users can actively detect, and can be detected in the
> > system reboot or panic.
> >
> >
> After having analyzed a couple of KFENCE memory corruption reports in the
> wild, I have doubts that this approach will be helpful.
> 
> Note that KFENCE knows nothing about the memory access that performs the
> actual corruption.
> 
> It's rather easy to investigate corruptions of short-living objects, e.g.
> those that are allocated and freed within the same function. In that case,
> one can examine the region of the code between these two events and try to
> understand what exactly caused the corruption.
> 
> But for long-living objects checked at panic/reboot we'll effectively have
> only the allocation stack and will have to check all the places where the
> corrupted object was potentially used.
> Most of the time, such reports won't be actionable.
 
The detection mechanism of kfence is probabilistic. It is not easy to find a bug.
It is a pity to catch a bug without reporting it. and the cost of panic detection
is not large, so panic detection is still valuable.
 
> > for example, if the application memory is out of bounds and written to
> > the red zone in the kfence object, the system suddenly panics, and the
> > following log can be seen during system reset:
> > BUG: KFENCE: memory corruption in atomic_notifier_call_chain+0x49/0x70
[...]

thanks,
ShaoBo Huang
