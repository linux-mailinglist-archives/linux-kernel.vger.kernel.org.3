Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A429650CEC5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiDXDBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbiDXDBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:01:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10E13FB45
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:58:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i38so2310183ybj.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OfK0tpH8kjdC9aBzVRfEMO2JK1yjN5Ywppuc5BMNAlk=;
        b=ZrqpxbfZ3cuZUK51/uH7rLYXtNAJAp/IxiV2Sv4efZ2FMmEUNn1nY5gEFyS4300vqQ
         nSwbu4hfi3bY+mbLS8sSPdqR0jbU+LWXgwB4RS4bluGWteiR7swukscJPG9E0ulfg34d
         Q/CIQdjpYzQJjlaBv3nTMrHX47NnG8ADeEnzGZrjYtUligyqJWVKKJMxoKQRU8cpGcXF
         bAJp8b8V7MCArs6ZqKiiuQcNvGpaO/LKBN2nO/2nFqwWA6fswqAcGILOBl4VDAXo0sOj
         Yo52+gZnB8DYDi93Qe6vI39XcFFbYCO4keXyepqotVBWRgXHv5Z4x9AgUIfIOPbbJcyG
         K4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OfK0tpH8kjdC9aBzVRfEMO2JK1yjN5Ywppuc5BMNAlk=;
        b=CKMS05imkDCFGnn+lN+3ulS5n3TwJ54IqwpQA6uiubADbMxKkq8pfadqrzF5suoTUa
         ofZh/XI4LFHKR+JpO+EsqXhwE65Y99/iJbhCyGr7SBUyoUfaQ8dxCB4kK5dNuprd6wHW
         VeXoIE9DWI0DgtBghq74r22lzLYo+LNZDbooZHpcKOZ/xxlumAui7vdi8xH4LS/PVD5U
         QHZ4f/CrfFpP4V8AfgODyIz9WPvMXTMmql4FcU6Of6Hlk8RERQ4MDPJTBn5uZh8MtD+P
         dHZTZCDDH55HZS6BswWpfomyAnoT3fxd1fH2DXLNFwwDHC0SP0xrLnV55idr8Bwuyxed
         Xt8w==
X-Gm-Message-State: AOAM5333DbXZhuwD6UdVUlLQeV8gQGPTnE6KCjMJSnnrc0MjAr5QOD/Z
        Z+cdFrBd8kEB83lDZp1ImNpttY3/rxbGgjG/R25lbA==
X-Google-Smtp-Source: ABdhPJzBUuieShvMs1DnGCSDEbXdoma89RFUbZZE+ByU8fSZ14hp0IRrf2Vx+c2nvRmHjMngeES6o3xSHEQNeAOu7sc=
X-Received: by 2002:a25:b952:0:b0:644:f4a4:4c23 with SMTP id
 s18-20020a25b952000000b00644f4a44c23mr10764420ybm.171.1650769101726; Sat, 23
 Apr 2022 19:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com> <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com> <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <YmA4pbgevqln/jSO@myrica> <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com> <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com> <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
In-Reply-To: <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Date:   Sun, 24 Apr 2022 10:58:10 +0800
Message-ID: <CABQgh9GzuQqsuPVyur+QurN8p+1BciMfOw0TccwiZSvvtrcowg@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022 at 19:13, zhangfei.gao@foxmail.com
<zhangfei.gao@foxmail.com> wrote:
>
> Hi, Jean
>
> On 2022/4/22 =E4=B8=8B=E5=8D=8811:50, Jean-Philippe Brucker wrote:
> > On Fri, Apr 22, 2022 at 09:15:01PM +0800, zhangfei.gao@foxmail.com wrot=
e:
> >>> I'm trying to piece together what happens from the kernel point of vi=
ew.
> >>>
> >>> * master process with mm A opens a queue fd through uacce, which call=
s
> >>>     iommu_sva_bind_device(dev, A) -> PASID 1
> >>>
> >>> * master forks and exits. Child (daemon) gets mm B, inherits the queu=
e fd.
> >>>     The device is still bound to mm A with PASID 1, since the queue f=
d is
> >>>     still open.
> >>> We discussed this before, but I don't remember where we left off. The
> >>> child can't use the queue because its mappings are not copied on fork=
(),
> >>> and the queue is still bound to the parent mm A. The child either nee=
ds to
> >>> open a new queue or take ownership of the old one with a new uacce io=
ctl.
> >> Yes, currently nginx aligned with the case.
> >> Child process (worker process) reopen uacce,
> >>
> >> Master process (do init) open uacce, iommu_sva_bind_device(dev, A) -> =
PASID
> >> 1
> >> Master process fork Child (daemon) and exit.
> >>
> >> Child (daemon)  does not use PASID 1 any more, only fork and manage wo=
rker
> >> process.
> >> Worker process reopen uacce, iommu_sva_bind_device(dev, B) PASID 2
> >>
> >> So it is expected.
> > Yes, that's fine
> >
> >>> Is that the "IMPLEMENT_DYNAMIC_BIND_FN()" you mention, something out =
of
> >>> tree?  This operation should unbind from A before binding to B, no?
> >>> Otherwise we leak PASID 1.
> >> In 5.16 PASID 1 from master is hold until nginx service stop.
> >> nginx start
> >> master:
> >> iommu_sva_alloc_pasid mm->pasid=3D1      // master process
> >>
> >> lynx https start:
> >> iommu_sva_alloc_pasid mm->pasid=3D2    //worker process
> >>
> >> nginx stop:  from fops_release
> >> iommu_sva_free_pasid mm->pasid=3D2   // worker process
> >> iommu_sva_free_pasid mm->pasid=3D1  // master process
> > That's the expected behavior (master could close its fd before forking,=
 in
> > order to free things up earlier, but it's not mandatory)
> Currently we unbind in fops_release, so the ioasid allocated in master
> can only be freed when nginx stop,
> when all forked fd are closed.
>
> >
> >> Have one silly question.
> >>
> >> kerne driver
> >> fops_open
> >> iommu_sva_bind_device
> >>
> >> fops_release
> >> iommu_sva_unbind_device
> >>
> >> application
> >> main()
> >> fd =3D open
> >> return;
> >>
> >> Application exit but not close(fd), is it expected fops_release will b=
e
> >> called automatically by system?
> > Yes, the application doesn't have to call close() explicitly, the file
> > descriptor is closed automatically on exit. Note that the fd is copied =
on
> > fork(), so it is only released once parent and all child processes exit=
.
> Yes, in case the application ended unexpected, like ctrl+c
> >
> >> On 5.17
> >> fops_release is called automatically, as well as iommu_sva_unbind_devi=
ce.
> >> On 5.18-rc1.
> >> fops_release is not called, have to manually call close(fd)
> > Right that's weird
> Looks it is caused by the fix patch, via mmget, which may add refcount
> of fd.
>
> Some experiments
> 1. 5.17, everything works well.
>
> 2. 5.17 + patchset of "iommu/sva: Assign a PASID to mm on PASID
> allocation and free it on mm exit"
>
> Test application, exit without close uacce fd
> First time:  fops_release can be called automatically.
>
> log:
> ioasid_alloc ioasid=3D1
> iommu_sva_alloc_pasid pasid=3D1
> iommu_sva_bind_device handle=3D00000000263a2ee8
> ioasid_free ioasid=3D1
> uacce_fops_release q=3D0000000055ca3cdf
> iommu_sva_unbind_device handle=3D00000000263a2ee8
>
> Second time: hardware reports error
>
> uacce_fops_open q=3D000000008e4d6f78
> ioasid_alloc ioasid=3D1
> iommu_sva_alloc_pasid pasid=3D1
> iommu_sva_bind_device handle=3D00000000cfd11788
> // Haredware reports error
> hisi_sec2 0000:b6:00.0: qm_acc_do_task_timeout [error status=3D0x20] foun=
d
> hisi_sec2 0000:b6:00.0: qm_acc_wb_not_ready_timeout [error status=3D0x40]
> found
> hisi_sec2 0000:b6:00.0: sec_fsm_hbeat_rint [error status=3D0x20] found
> hisi_sec2 0000:b6:00.0: Controller resetting...
> hisi_sec2 0000:b6:00.0: QM mailbox operation timeout!
> hisi_sec2 0000:b6:00.0: Failed to dump sqc!
> hisi_sec2 0000:b6:00.0: Failed to drain out data for stopping!
> hisi_sec2 0000:b6:00.0: Bus lock! Please reset system.
> hisi_sec2 0000:b6:00.0: Controller reset failed (-110)
> hisi_sec2 0000:b6:00.0: controller reset failed (-110)
>
> 3. Add the fix patch of using mmget in bind.
> Test application, exit without close uacce fd
>
> fops_release can NOT be called automatically, looks mmget adds refcount
> of fd.

Test application, exit without closing fd.
> >> kernel driver
> >> fops_open
> >> iommu_sva_bind_device
> >>
> >> fops_release
> >> iommu_sva_unbind_device

1.
5.17 kernel, no mmget & mmput

wd_release_queue no close
Compress bz=3D512000 nb=3D1=C3=9710, speed=3D139.5 MB/s (=C2=B10.0% N=3D1) =
overall=3D122.9
MB/s (=C2=B10.0%)
[   16.052989] do_exit current=3Dd380000
[   16.053828] mmput atomic=3D1
[   16.054511]  __mmput atomic=3D0
[   16.070382] exit_task_work
[   16.070981] uacce_fops_release current=3Dd380000
[   16.071999] CPU: 0 PID: 176 Comm: test_sva_perf Not tainted
5.16.0-rc1-27342-ge5f9f3f99a88-dirty #240
[   16.074007] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/20=
15
[   16.075530] Call trace:
[   16.076069]  dump_backtrace+0x0/0x1a0
[   16.076887]  show_stack+0x20/0x30
[   16.077629]  dump_stack_lvl+0x8c/0xb8
[   16.078441]  dump_stack+0x18/0x34
[   16.079176]  uacce_fops_release+0x44/0xdc
[   16.080060]  __fput+0x78/0x240
[   16.080743]  ____fput+0x18/0x28
[   16.081447]  task_work_run+0x88/0x160
[   16.082259]  do_exit+0x52c/0xa50
[   16.082974]  do_group_exit+0x84/0xa8
[   16.083768]  __wake_up_parent+0x0/0x38
[   16.084597]  invoke_syscall+0x4c/0x110
[   16.085435]  el0_svc_common.constprop.0+0x68/0x128
[   16.086501]  do_el0_svc+0x2c/0x90
[   16.087243]  el0_svc+0x24/0x70
[   16.087928]  el0t_64_sync_handler+0xb0/0xb8
[   16.088854]  el0t_64_sync+0x1a0/0x1a4
[   16.089775]  arm_smmu_sva_unbind
[   16.090577]  iommu_sva_free_pasid mm->pasid=3D1
[   16.091763] exit_task_work done

2. Add mmget in bind and mmput in unbind,
Since application do not close fd, so no unbind,& mmput
And fops_release is not called since mm_users account.

log:
[  101.642690] mmput atomic=3D3
wd_release_queue no close
Compress bz=3D512000 nb=3D1=C3=9710, speed=3D40.3 MB/s (=C2=B10.0% N=3D1) o=
verall=3D38.7
MB/s (=C2=B10.0%)
[  101.671167] do_exit current=3Dd9daf40
[  101.672003] mmput atomic=3D2
[  101.672712] exit_task_work
[  101.673292] exit_task_work done

Thanks



>
> So the fix method of using mmget blocks fops_release to be called once
> fd is closed without unbind.
>
> >> Since nginx may have a issue, it does not call close(fd) when nginx -s=
 quit.
> > And you're sure that none of the processes are still alive or in zombie
> > state?  Just to cover every possibility.
> It can also reproduced by a simple application exit without close(uacce_f=
d)
>
> Thanks
>
