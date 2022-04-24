Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7050D0F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiDXJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbiDXJzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:55:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A982ED47
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:52:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k4so9077145plk.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=StCrJTegHmOv0psmLd6dnd441ryrL2i9pR+a6rFpSy4=;
        b=FFCndrfL0JSmVQ5+PqXBaLSzweEk/+pPQvMIbHxQPlDbxZUxtxx3szRtJIqlCof8ks
         xmz1FU7crDpZyzb/64dkxb52Uan/VqpdnniL+FCGGf9lcsvfBqQSw4taTOmpKcGqdoux
         vu+59ASZ7Dh26ufDLr5hAXayZu/O8dEwJrw4tp/srXM1AM9VHNuAk3xiL4HhrZla5aR+
         VCTI+YkEAwi3CZJ/HDlGlN3vruSq1tXYWfNBfuYkX6VdUPjCBLYXhS+1ysGTSAs5meFq
         fCfqO/tfRNRcgQr1Dx4DjOmeLibOZrpsSE+i0aXHTBZTIE+uN+XbXLrLbPhkC2YAaobv
         vGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=StCrJTegHmOv0psmLd6dnd441ryrL2i9pR+a6rFpSy4=;
        b=hhoeAHAgafsJgCezt0t4KulslKYH9dWQdSDpRCfbFez0WMXeZKMJ1uVqxWIiyCPNhA
         cOQSIBZgVZiDbah/h8gAgSn28HjsuOE4+DamMwwEyOv/912TtQ8/3VJu5LtxFDvKjm7r
         e3dnD797bB2zFPiZFy9OUwBElm/dL/TVHhtdMxl5w2M1zCoofAKtMN/9YEHaACGFEyKC
         up5XacYhLsMVKrveK7Mb3+7ed3XBkNJ4tNshe1Lp0j/VnnSrUdfaDeJ9t5B4Q6gq9WeT
         DIjfaWguoXnjyNuGePwGx2saC/F/6mgxMaxcEs1ntXsh9lCV2BmfbyLa/tA75amKUch7
         q5Aw==
X-Gm-Message-State: AOAM531luC0+XKwv1IKf8gWYbl6u2UIjnY3i67m4P6LHKi8rZ2t8Oaf4
        jdza9NJC03T9bL8IO+nsNB0VXw==
X-Google-Smtp-Source: ABdhPJyq7jjqAyq3opQ4ZXTjyxmgbAJz1w1hJUxpSnHTQWENqHqGu/EUJ+di010rrVG3QS1tC5FZ2A==
X-Received: by 2002:a17:902:b48d:b0:15c:df43:ac0d with SMTP id y13-20020a170902b48d00b0015cdf43ac0dmr7790030plr.118.1650793939000;
        Sun, 24 Apr 2022 02:52:19 -0700 (PDT)
Received: from [10.152.0.6] ([94.177.118.104])
        by smtp.gmail.com with ESMTPSA id u12-20020a62d44c000000b0050d17e069f2sm4782141pfl.10.2022.04.24.02.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 02:52:18 -0700 (PDT)
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
References: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <CABQgh9GzuQqsuPVyur+QurN8p+1BciMfOw0TccwiZSvvtrcowg@mail.gmail.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <7fd31518-83b8-5c0f-e817-49c3f77e91d8@linaro.org>
Date:   Sun, 24 Apr 2022 17:52:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABQgh9GzuQqsuPVyur+QurN8p+1BciMfOw0TccwiZSvvtrcowg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean & Fenghua

The issue of "iommu/sva: Assign a PASID to mm on PASID allocation and 
free it on mm exit"
is mm_pasid_drop in __mmput only ioasid_free(mm->pasid), but keep all 
related resources,
like cd tables etc.

This introduces many strange issues.
For example, if application does not use close fd but exit directly, 
mm_pasid_drop is called first,
then fops_release->unbind is called, when mm->pasid=-1, 
arm_smmu_write_ctx_desc will get error.

And in nginx case, pasid is freed when fork daemon, but cd table is 
still there,
then next time, same pasid is allocated.

So either __mmput free pasid as well as all related resources like cd 
table,
or convert back to rely on the original unbind method to free pasid and 
resources together.

Since SVA is main feature on ARM, which has been developed for years,
It is already used in the product.
It will be horrible if SVA is broke on 5.18.

Any suggestion?

Thanks




On 2022/4/24 上午10:58, Zhangfei Gao wrote:
> On Sat, 23 Apr 2022 at 19:13, zhangfei.gao@foxmail.com
> <zhangfei.gao@foxmail.com> wrote:
>> Hi, Jean
>>
>> On 2022/4/22 下午11:50, Jean-Philippe Brucker wrote:
>>> On Fri, Apr 22, 2022 at 09:15:01PM +0800, zhangfei.gao@foxmail.com wrote:
>>>>> I'm trying to piece together what happens from the kernel point of view.
>>>>>
>>>>> * master process with mm A opens a queue fd through uacce, which calls
>>>>>      iommu_sva_bind_device(dev, A) -> PASID 1
>>>>>
>>>>> * master forks and exits. Child (daemon) gets mm B, inherits the queue fd.
>>>>>      The device is still bound to mm A with PASID 1, since the queue fd is
>>>>>      still open.
>>>>> We discussed this before, but I don't remember where we left off. The
>>>>> child can't use the queue because its mappings are not copied on fork(),
>>>>> and the queue is still bound to the parent mm A. The child either needs to
>>>>> open a new queue or take ownership of the old one with a new uacce ioctl.
>>>> Yes, currently nginx aligned with the case.
>>>> Child process (worker process) reopen uacce,
>>>>
>>>> Master process (do init) open uacce, iommu_sva_bind_device(dev, A) -> PASID
>>>> 1
>>>> Master process fork Child (daemon) and exit.
>>>>
>>>> Child (daemon)  does not use PASID 1 any more, only fork and manage worker
>>>> process.
>>>> Worker process reopen uacce, iommu_sva_bind_device(dev, B) PASID 2
>>>>
>>>> So it is expected.
>>> Yes, that's fine
>>>
>>>>> Is that the "IMPLEMENT_DYNAMIC_BIND_FN()" you mention, something out of
>>>>> tree?  This operation should unbind from A before binding to B, no?
>>>>> Otherwise we leak PASID 1.
>>>> In 5.16 PASID 1 from master is hold until nginx service stop.
>>>> nginx start
>>>> master:
>>>> iommu_sva_alloc_pasid mm->pasid=1      // master process
>>>>
>>>> lynx https start:
>>>> iommu_sva_alloc_pasid mm->pasid=2    //worker process
>>>>
>>>> nginx stop:  from fops_release
>>>> iommu_sva_free_pasid mm->pasid=2   // worker process
>>>> iommu_sva_free_pasid mm->pasid=1  // master process
>>> That's the expected behavior (master could close its fd before forking, in
>>> order to free things up earlier, but it's not mandatory)
>> Currently we unbind in fops_release, so the ioasid allocated in master
>> can only be freed when nginx stop,
>> when all forked fd are closed.
>>
>>>> Have one silly question.
>>>>
>>>> kerne driver
>>>> fops_open
>>>> iommu_sva_bind_device
>>>>
>>>> fops_release
>>>> iommu_sva_unbind_device
>>>>
>>>> application
>>>> main()
>>>> fd = open
>>>> return;
>>>>
>>>> Application exit but not close(fd), is it expected fops_release will be
>>>> called automatically by system?
>>> Yes, the application doesn't have to call close() explicitly, the file
>>> descriptor is closed automatically on exit. Note that the fd is copied on
>>> fork(), so it is only released once parent and all child processes exit.
>> Yes, in case the application ended unexpected, like ctrl+c
>>>> On 5.17
>>>> fops_release is called automatically, as well as iommu_sva_unbind_device.
>>>> On 5.18-rc1.
>>>> fops_release is not called, have to manually call close(fd)
>>> Right that's weird
>> Looks it is caused by the fix patch, via mmget, which may add refcount
>> of fd.
>>
>> Some experiments
>> 1. 5.17, everything works well.
>>
>> 2. 5.17 + patchset of "iommu/sva: Assign a PASID to mm on PASID
>> allocation and free it on mm exit"
>>
>> Test application, exit without close uacce fd
>> First time:  fops_release can be called automatically.
>>
>> log:
>> ioasid_alloc ioasid=1
>> iommu_sva_alloc_pasid pasid=1
>> iommu_sva_bind_device handle=00000000263a2ee8
>> ioasid_free ioasid=1
>> uacce_fops_release q=0000000055ca3cdf
>> iommu_sva_unbind_device handle=00000000263a2ee8
>>
>> Second time: hardware reports error
>>
>> uacce_fops_open q=000000008e4d6f78
>> ioasid_alloc ioasid=1
>> iommu_sva_alloc_pasid pasid=1
>> iommu_sva_bind_device handle=00000000cfd11788
>> // Haredware reports error
>> hisi_sec2 0000:b6:00.0: qm_acc_do_task_timeout [error status=0x20] found
>> hisi_sec2 0000:b6:00.0: qm_acc_wb_not_ready_timeout [error status=0x40]
>> found
>> hisi_sec2 0000:b6:00.0: sec_fsm_hbeat_rint [error status=0x20] found
>> hisi_sec2 0000:b6:00.0: Controller resetting...
>> hisi_sec2 0000:b6:00.0: QM mailbox operation timeout!
>> hisi_sec2 0000:b6:00.0: Failed to dump sqc!
>> hisi_sec2 0000:b6:00.0: Failed to drain out data for stopping!
>> hisi_sec2 0000:b6:00.0: Bus lock! Please reset system.
>> hisi_sec2 0000:b6:00.0: Controller reset failed (-110)
>> hisi_sec2 0000:b6:00.0: controller reset failed (-110)
>>
>> 3. Add the fix patch of using mmget in bind.
>> Test application, exit without close uacce fd
>>
>> fops_release can NOT be called automatically, looks mmget adds refcount
>> of fd.
> Test application, exit without closing fd.
>>>> kernel driver
>>>> fops_open
>>>> iommu_sva_bind_device
>>>>
>>>> fops_release
>>>> iommu_sva_unbind_device
> 1.
> 5.17 kernel, no mmget & mmput
>
> wd_release_queue no close
> Compress bz=512000 nb=1×10, speed=139.5 MB/s (±0.0% N=1) overall=122.9
> MB/s (±0.0%)
> [   16.052989] do_exit current=d380000
> [   16.053828] mmput atomic=1
> [   16.054511]  __mmput atomic=0
> [   16.070382] exit_task_work
> [   16.070981] uacce_fops_release current=d380000
> [   16.071999] CPU: 0 PID: 176 Comm: test_sva_perf Not tainted
> 5.16.0-rc1-27342-ge5f9f3f99a88-dirty #240
> [   16.074007] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [   16.075530] Call trace:
> [   16.076069]  dump_backtrace+0x0/0x1a0
> [   16.076887]  show_stack+0x20/0x30
> [   16.077629]  dump_stack_lvl+0x8c/0xb8
> [   16.078441]  dump_stack+0x18/0x34
> [   16.079176]  uacce_fops_release+0x44/0xdc
> [   16.080060]  __fput+0x78/0x240
> [   16.080743]  ____fput+0x18/0x28
> [   16.081447]  task_work_run+0x88/0x160
> [   16.082259]  do_exit+0x52c/0xa50
> [   16.082974]  do_group_exit+0x84/0xa8
> [   16.083768]  __wake_up_parent+0x0/0x38
> [   16.084597]  invoke_syscall+0x4c/0x110
> [   16.085435]  el0_svc_common.constprop.0+0x68/0x128
> [   16.086501]  do_el0_svc+0x2c/0x90
> [   16.087243]  el0_svc+0x24/0x70
> [   16.087928]  el0t_64_sync_handler+0xb0/0xb8
> [   16.088854]  el0t_64_sync+0x1a0/0x1a4
> [   16.089775]  arm_smmu_sva_unbind
> [   16.090577]  iommu_sva_free_pasid mm->pasid=1
> [   16.091763] exit_task_work done
>
> 2. Add mmget in bind and mmput in unbind,
> Since application do not close fd, so no unbind,& mmput
> And fops_release is not called since mm_users account.
>
> log:
> [  101.642690] mmput atomic=3
> wd_release_queue no close
> Compress bz=512000 nb=1×10, speed=40.3 MB/s (±0.0% N=1) overall=38.7
> MB/s (±0.0%)
> [  101.671167] do_exit current=d9daf40
> [  101.672003] mmput atomic=2
> [  101.672712] exit_task_work
> [  101.673292] exit_task_work done
>
> Thanks
>
>
>
>> So the fix method of using mmget blocks fops_release to be called once
>> fd is closed without unbind.
>>
>>>> Since nginx may have a issue, it does not call close(fd) when nginx -s quit.
>>> And you're sure that none of the processes are still alive or in zombie
>>> state?  Just to cover every possibility.
>> It can also reproduced by a simple application exit without close(uacce_fd)
>>
>> Thanks
>>

