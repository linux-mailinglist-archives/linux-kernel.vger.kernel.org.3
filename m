Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C287350D685
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbiDYB0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiDYB0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:26:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8EC0E52
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:23:38 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmnMd32KSzhYf0;
        Mon, 25 Apr 2022 09:23:25 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 09:23:36 +0800
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.111.5) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 09:23:35 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <elver@google.com>
CC:     <akpm@linux-foundation.org>, <chenzefeng2@huawei.com>,
        <dvyukov@google.com>, <glider@google.com>,
        <huangshaobo6@huawei.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nixiaoming@huawei.com>, <wangbing6@huawei.com>,
        <wangfangpeng1@huawei.com>, <young.liuyang@huawei.com>,
        <zengweilin@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH v2] kfence: enable check kfence canary in panic via boot param
Date:   Mon, 25 Apr 2022 09:23:34 +0800
Message-ID: <20220425012334.46364-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CANpmjNPEErc2mZMSB=QyT3wq08Q4yGyTGiU3BrOBGV3R5rNw-w@mail.gmail.com>
References: <CANpmjNPEErc2mZMSB=QyT3wq08Q4yGyTGiU3BrOBGV3R5rNw-w@mail.gmail.com>
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

On Sun, 24 Apr 2022 15:31:42 +0200, Marco Elver <elver@google.com> wrote:
> On Sun, 24 Apr 2022 at 13:00, Shaobo Huang <huangshaobo6@huawei.com> wrote:
> >
> > From: huangshaobo <huangshaobo6@huawei.com>
> >
> > when writing out of bounds to the red zone, it can only be
> > detected at kfree. However, the system may have been reset
> > before freeing the memory, which would result in undetected
> > oob. Therefore, it is necessary to detect oob behavior in
> > panic. Since only the allocated mem call stack is available,
> > it may be difficult to find the oob maker. Therefore, this
> > feature is disabled by default and can only be enabled via
> > boot parameter.
> 
> This description is still not telling the full story or usecase. The
> story goes something like:
> """
> Out-of-bounds accesses that aren't caught by a guard page will result
> in corruption of canary memory. In pathological cases, where an object
> has certain alignment requirements, an out-of-bounds access might
> never be caught by the guard page. Such corruptions, however, are only
> detected on kfree() normally. If the bug causes the kernel to panic
> before kfree(), KFENCE has no opportunity to report the issue. Such
> corruptions may also indicate failing memory or other faults.
> 
> To provide some more information in such cases, add the option to
> check canary bytes on panic. This might help narrow the search for the
> panic cause; but, due to only having the allocation stack trace, such
> reports are difficult to use to diagnose an issue alone. In most
> cases, such reports are inactionable, and is therefore an opt-in
> feature (disabled by default).
> """
> 
> Please feel free to copy or take pieces above to complete the commit message.
>
> [...]
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/string.h>
> > +#include <linux/notifier.h>
> > +#include <linux/panic_notifier.h>
> 
> Please keep these includes sorted alphabetically.
> 
> [...]
> > +/* If true, check kfence canary in panic. */
> 
> It should be "on panic". E.g. "If true, check all canary bytes on panic."
> 
> [...]
> > +/* === Panic Notifier ====================================================== */
> 
> Blank line between /* === ... */ and function.

thank you so much for your suggestion!

thanks,
ShaoBo Huang

