Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1BA50A11F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387173AbiDUNtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiDUNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:49:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955E30F7C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:46:46 -0700 (PDT)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kkf2G4P81z1J9rd;
        Thu, 21 Apr 2022 21:45:58 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 21:46:44 +0800
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.111.5) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 21:46:44 +0800
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
Date:   Thu, 21 Apr 2022 21:46:43 +0800
Message-ID: <20220421134643.41728-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CANpmjNM0qeKraYviOXFO4znVE3hUdG8-0VbFbzXzWH8twtQM9w@mail.gmail.com>
References: <CANpmjNM0qeKraYviOXFO4znVE3hUdG8-0VbFbzXzWH8twtQM9w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.111.5]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 15:28:45 +0200, Marco Elver <elver@google.com> wrote:
> On Thu, 21 Apr 2022 at 15:06, Alexander Potapenko <glider@google.com> wrote:
> [...]
> > This report will denote that in a system that could have been running for days a particular skbuff was corrupted by some unknown task at some unknown point in time.
> > How do we figure out what exactly caused this corruption?
> >
> > When we deploy KFENCE at scale, it is rarely possible for the kernel developer to get access to the host that reported the bug and try to reproduce it.
> > With that in mind, the report (plus the kernel source) must contain all the necessary information to address the bug, otherwise reporting it will result in wasting the developer's time.
> > Moreover, if we report such bugs too often, our tool loses the credit, which is hard to regain.
> 
> I second this - in particular we'll want this off in fuzzers etc.,
> because it'll just generate reports that nobody can use to debug an
> issue. I do see the value in this in potentially narrowing the cause
> of a panic, but that information is likely not enough to fully
> diagnose the root cause of the panic - it might however prompt to
> re-run with KASAN, or check if memory DIMMs are faulty etc.
> 
> We can still have this feature, but I suggest to make it
> off-by-default, and only enable via a boot param. I'd call it
> 'kfence.check_on_panic'. For your setup, you can then use it to enable
> where you see fit.

I agree to give users the option to use this feature.

> Thanks,
>-- Marco
