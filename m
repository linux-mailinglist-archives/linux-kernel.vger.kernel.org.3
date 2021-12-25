Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE6547F284
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 08:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhLYH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 02:26:35 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15973 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhLYH0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 02:26:35 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JLb4m1C5tzZddv;
        Sat, 25 Dec 2021 15:23:20 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:32 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>
Subject: [PATCH 0/4] kdump: add parse_crashkernel_high_low() to replace parse_crashkernel_{high|low}()
Date:   Sat, 25 Dec 2021 15:23:23 +0800
Message-ID: <20211225072327.1807-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bootup command line option crashkernel=Y,low is valid only when
crashkernel=X,high is specified. Putting their parsing into a separate
function makes the code logic clearer and easier to understand the strong
dependencies between them. So add parse_crashkernel_high_low() and use it
to repalce parse_crashkernel_{high|low}(). Then make the latter static,
and reduce two confusing parameters 'system_ram' and 'crash_base' of them.

All four patches in this series do the cleanups, no functional change. This
patchset is also a preparation for supporting reserve crashkernel above 4G
on arm64, and share code with x86.

The main proposal was made by Borislav Petkov.
> As I've already alluded to in another mail, ontop of this there should
> be a patch or multiple patches which clean this up more and perhaps even
> split it into separate functions doing stuff in this order:
>
> 1. Parse all crashkernel= cmdline options
> 2. Do all crash_base, crash_size etc checks
> 3. Do the memory reservations
>
> And all that supplied with comments explaining why stuff is being done.


Zhen Lei (4):
  kdump: add helper parse_crashkernel_high_low()
  x86/setup: Use parse_crashkernel_high_low() to simplify code
  kdump: make parse_crashkernel_{high|low}() static
  kdump: reduce unnecessary parameters of parse_crashkernel_{high|low}()

 arch/x86/kernel/setup.c    | 21 +++++++--------
 include/linux/crash_core.h |  7 +++--
 kernel/crash_core.c        | 54 +++++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 26 deletions(-)

-- 
2.25.1

