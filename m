Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D58509C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387348AbiDUJPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiDUJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:15:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C6B15FC6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:12:14 -0700 (PDT)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkWxV1CzCz1J9wK;
        Thu, 21 Apr 2022 17:11:26 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 17:12:12 +0800
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.111.5) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 17:12:11 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <elver@google.com>
CC:     <akpm@linux-foundation.org>, <chenzefeng2@huawei.com>,
        <dvyukov@google.com>, <glider@google.com>,
        <huangshaobo6@huawei.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nixiaoming@huawei.com>, <wangbing6@huawei.com>,
        <wangfangpeng1@huawei.com>, <young.liuyang@huawei.com>,
        <zengweilin@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH] kfence: check kfence canary in panic and reboot
Date:   Thu, 21 Apr 2022 17:12:10 +0800
Message-ID: <20220421091210.27068-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CANpmjNMAT_DaiOoz=k6Z13nVR_2A_5fck12h0JKQSmNQRSKwGg@mail.gmail.com>
References: <CANpmjNMAT_DaiOoz=k6Z13nVR_2A_5fck12h0JKQSmNQRSKwGg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.111.5]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 10:50:10 +0200, Marco Elver wrote:
> On Thu, 21 Apr 2022 at 10:37, Shaobo Huang <huangshaobo6@huawei.com> wrote:
> [...]
> > > >  static int __init kfence_debugfs_init(void)
> > > >  {
> > > >     struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
> > > > @@ -806,6 +832,8 @@ static void kfence_init_enable(void)
> > > >
> > > >     WRITE_ONCE(kfence_enabled, true);
> > > >     queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> > > > +   register_reboot_notifier(&kfence_check_canary_notifier);
> > > > +   atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
> > >
> > > Executing this on panic is reasonable. However,
> > > register_reboot_notifier() tells me this is being executed on *every*
> > > reboot (not just panic). I think that's not what we want, because that
>> > may increase reboot latency depending on how many KFENCE objects we
> > > have. Is it possible to *only* do the check on panic?
> >
> > if oob occurs before reboot, reboot can also detect it, if not, the detection will be missing in this scenario.
> > reboot and panic are two scenarios of system reset, so I think both scenarios need to be added.
> 
> That doesn't quite answer my question, why do you want to run the
> check during normal reboot? As I understand it right now it will run
> on any normal reboot, and also on panics. I have concerns adding these
> checks to normal reboots because it may increase normal reboot
> latency, which we do not want.

as you said, the detection will indeed increase normal reboot latency, and the
detection of normal reboot is not very meaningful. considering the cost and benefit,
I agree with your suggestion to only detect in panic.

thanks,
ShaoBo Huang
