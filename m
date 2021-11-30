Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8D462978
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhK3BLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhK3BLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:11:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F802C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:08:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so79434482edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZu7UjvJplufOF9+7fh7DwgasTNaeysf/GdFPm1qyhk=;
        b=iw4X3fGjUe5H07MsNmn9YgtKzZVgL109OYBQHlRqUvg6dxUG8j1Ryn+WS/5Wg9r8ho
         USFW84+FRix+l3o0urzdIfseFnrHr7XZBh4ldwRHFvnVGs2wevPXnrCUBVlHWW0YqmFi
         sL3PmsPm3goprIyy1pzfO51dmNmtoowA3os14p9CzueRCpziJN3OFZcMAkpRayz5VX/r
         jZ7qagYaSY6hyL5pYQhtIcE2YBBrMG9MqxBv1Ot9io+e4EPcs/8gT/VYu1ZHtcpx93ak
         sUeYdrE0JwINtEQnTKGYJDdZdYhUTqJ38Gl7IgKs3pToERTupH3qtgx9Op9q/R+7bDwW
         gtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZu7UjvJplufOF9+7fh7DwgasTNaeysf/GdFPm1qyhk=;
        b=BnBxDsGqVlrgSRsIQcZCz3LGVW5Cjb6BFBiDBmo1zgGYSra999IlUbfO4aYzu+seXg
         S19cID8wLscUbFFcSj5GRwBsvACE5bq3Agq0p/A4g0beSH50UyHT2SCqb1wOKZb43PTt
         UdftVa+0FaxveBwLaDk8D/9KffJL8RnsTo1iijFULP/wXNsw+0weaTq40Ayl/DB0gBMa
         lY/VXbL45YwIA5qxEWWPmngZMrIPffQrtIiAB0B/uKhfPKYM0fKH9XiKwevjGGF+iN5A
         GORIImtT7Et45z6op/kcF9yONBqoRaI3mIFi56Nbayp78yZ3CH62bMI6nnc2G4+TNcNn
         AhZQ==
X-Gm-Message-State: AOAM533OMfitjO/4tWBbvOGeyNuJxhuDkotUYQ9b7v9+YsBXb7zwFIkY
        70/o1izxfOS9KfTajQaAToS0iRzAHfmDX83pHHY=
X-Google-Smtp-Source: ABdhPJy3VpD7CpiS0ih0miEanV7BErsqoi8QIsiJJa8kqY2mH4AWPMQAt9ZZd/bRdIprlOIYOSNo+wWpCKecrBeQXVs=
X-Received: by 2002:aa7:c353:: with SMTP id j19mr79602672edr.227.1638234505147;
 Mon, 29 Nov 2021 17:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
 <YaELI8+QnBeXXIVm@kroah.com> <20211126183954.scu2wfirrzlgqxxi@bogus> <YaH1ZOr36chJ4DdB@kroah.com>
In-Reply-To: <YaH1ZOr36chJ4DdB@kroah.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 30 Nov 2021 14:08:14 +1300
Message-ID: <CAGsJ_4yX2eiJ3hu8rNXZ5b7dkFm3bw8yTQmRNC26p9UPKMrLcw@mail.gmail.com>
Subject: Re: [PATCH] arch_topology: Fix missing clear cluster_cpumask in remove_cpu_topology()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, weiyongjun1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 8:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 26, 2021 at 06:39:54PM +0000, Sudeep Holla wrote:
> > On Fri, Nov 26, 2021 at 05:28:19PM +0100, Greg KH wrote:
> > > On Wed, Nov 10, 2021 at 05:58:56PM +0800, Wang ShaoBo wrote:
> > > > When testing cpu online and offline, warning happened like this:
> > > >
> > > > [  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 build_sched_domains+0x81c/0x11b0
> > > > [  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
> > > > [  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79 08/21/2021
> > > > [  146.751213] Workqueue: events cpuset_hotplug_workfn
> > > > [  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > [  146.752048] pc : build_sched_domains+0x81c/0x11b0
> > > > [  146.752461] lr : build_sched_domains+0x414/0x11b0
> > > > [  146.752860] sp : ffff800040a83a80
> > > > [  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800448ae00
> > > > [  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000000000000
> > > > [  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000000005f
> > > > [  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: ffffffffffffffff
> > > > [  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800011f92b48
> > > > [  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686373204c4c
> > > > [  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000000000000
> > > > [  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000000000002
> > > > [  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000000000001
> > > > [  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000000000001
> > > > [  146.757070] Call trace:
> > > > [  146.757421]  build_sched_domains+0x81c/0x11b0
> > > > [  146.757771]  partition_sched_domains_locked+0x57c/0x978
> > > > [  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
> > > > [  146.758460]  rebuild_sched_domains+0x2c/0x48
> > > > [  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
> > > > [  146.759114]  process_one_work+0x1f4/0x480
> > > > [  146.759429]  worker_thread+0x48/0x460
> > > > [  146.759734]  kthread+0x158/0x168
> > > > [  146.760030]  ret_from_fork+0x10/0x20
> > > > [  146.760318] ---[ end trace 82c44aad6900e81a ]---
> > > >
> > > > For some architectures like risc-v and arm64 which use common code
> > > > clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
> > > > is set, cluster_sibling in cpu_topology of each sibling adjacent
> > > > to CPUx is missed clearing, this causes checking failed in
> > > > topology_span_sane() and rebuilding topology failure at end when CPU online.
> > > >
> > > > Different sibling's cluster_sibling in cpu_topology[] when CPU92 offline
> > > > (CPU 92, 93, 94, 95 are in one cluster):
> > > >
> > > > Before revision:
> > > > CPU                 [92]      [93]      [94]      [95]
> > > > cluster_sibling     [92]     [92-95]   [92-95]   [92-95]
> > > >
> > > > After revision:
> > > > CPU                 [92]      [93]      [94]      [95]
> > > > cluster_sibling     [92]     [93-95]   [93-95]   [93-95]
> > > >
> > > > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > > > ---
> > > >  drivers/base/arch_topology.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > What commit id does this fix?
> > >
> >
> > v2[1] has the information and all the tags IIUC.
>
> Odd, I don't see that in my queue :(

Greg, this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cc4cc28ec4154c4f1395648ab67ac9fd3e71fdc
which is shaobo's v1 patch lacking fixes tag.

Thanks
Barry
