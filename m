Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0210350C988
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiDWLQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiDWLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:16:48 -0400
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32566BA0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650712424;
        bh=+7VnTMAvj4C28OEILNT3dhdWx4ONbyFVnB8idZPZUfk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hZ1VRVplfpK/1ll46iyhW4+jUxJHnjTdTBa0aviWL0xLsv1MfYRVW8l/6E1/m7Q64
         nboYvdelItyAEFvptk9DEwjhH5Xh+zfioCt5jNQtOTPqpLhQ6KiVptmNu1gD5Hivfc
         Qu+OSraPCMldV8Rkh2jo8H2/AcoQZxrrmhDfmYTg=
Received: from [192.168.0.110] ([36.57.134.8])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 3679A236; Sat, 23 Apr 2022 19:13:39 +0800
X-QQ-mid: xmsmtpt1650712419tjjfr8ek0
Message-ID: <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
X-QQ-XMAILINFO: MKPSrEIbElLqQamjPv0ecbEGyFZP81f1fAj6O5j4qXvMSnjDIQ5a+AHWBJeYwZ
         MIow/FglXG9oJMflNCE8fA0RHkfaOOE4JOyUsthCK0MRQlOv+KejPZRrKR80pmrLofrYnQK8emai
         BE5hbiSoAW0RvUost+0NeBcOie7owMyq9sN02gDb4Cz/vTFPE6SHeHTxa1xqykD0wOZKCZ+3pnNn
         54eKUJ8BTND9+YIYnpho3sXsBhiQXoACtxBj6v4hrD/O6K+GX7WSIHZfl1J0HxN60TZaBKPjlUJI
         i0+Hjvwsbrub7vBiLjPN6crtNW8VhJ/IKQq4j/2Wyrf8IK8GpcdglmzM1/2JiEoG5nHNFxjmpWOR
         vH1GciqFkuvKkddlxG/chlmwCha+y4EIyGJuGOK1S0h7m03uzcXGVafwV7xG8JcB9R2WXOeE41XI
         fPDtNkLz2RP7YACetot9C96xnMazm7OSthsIrSXxPzMhH55VDlE47Rc/bElv/B0Q3h/k+Ir2zd0o
         SawWtrpDtM4JVl8YkVqwLwpsbXTNgy1KRemTYznK32oACfx7FELrmxoI9HJD5Zf2luLl5NFCjG/L
         UrZx+HM7diL1b/o39Ee43rpkusWED5G3pkZVdIVlblGwRkf04tv6mEmPPMMN3Pj3C9s2pqfU3/XC
         RgEwdVWKBKSYYf+RnM2m71m6cp/lULcGiEurhiwP75j/eKEkbwrmxX7EBt1baw6HUZ7+oBxdQkCX
         1k3kAZhu+IJR9MPkCsnesXjdj5bSBffHysFvnPqhxIsWSSKyqEsK9rvOwfyKmwBgl7USsqHW4dke
         5qhxUYZKQ/n7H9/SsQHHSoTAUDLvNpJBCFhsRR32IlGLl08lrBHEuGvVZGs8JFsmOBeMlvcafsFu
         GUnYQDHFmtT7cSpwG68L93Fmwk7wwjLVNFHW3v+SH4/iQTaiexeQTVhD8O17JKbBYnkHn8sP4JRc
         wfDns9nguH+CiK7l0isuylPRpyJE/eDjWhRfdpynY=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
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
        robin.murphy@arm.com, zhangfei.gao@linaro.org
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
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <940439f7-33e5-ba32-c977-6517271c9445@foxmail.com>
Date:   Sat, 23 Apr 2022 19:13:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmLOznyBF0f7COYT@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean

On 2022/4/22 下午11:50, Jean-Philippe Brucker wrote:
> On Fri, Apr 22, 2022 at 09:15:01PM +0800, zhangfei.gao@foxmail.com wrote:
>>> I'm trying to piece together what happens from the kernel point of view.
>>>
>>> * master process with mm A opens a queue fd through uacce, which calls
>>>     iommu_sva_bind_device(dev, A) -> PASID 1
>>>
>>> * master forks and exits. Child (daemon) gets mm B, inherits the queue fd.
>>>     The device is still bound to mm A with PASID 1, since the queue fd is
>>>     still open.
>>> We discussed this before, but I don't remember where we left off. The
>>> child can't use the queue because its mappings are not copied on fork(),
>>> and the queue is still bound to the parent mm A. The child either needs to
>>> open a new queue or take ownership of the old one with a new uacce ioctl.
>> Yes, currently nginx aligned with the case.
>> Child process (worker process) reopen uacce,
>>
>> Master process (do init) open uacce, iommu_sva_bind_device(dev, A) -> PASID
>> 1
>> Master process fork Child (daemon) and exit.
>>
>> Child (daemon)  does not use PASID 1 any more, only fork and manage worker
>> process.
>> Worker process reopen uacce, iommu_sva_bind_device(dev, B) PASID 2
>>
>> So it is expected.
> Yes, that's fine
>
>>> Is that the "IMPLEMENT_DYNAMIC_BIND_FN()" you mention, something out of
>>> tree?  This operation should unbind from A before binding to B, no?
>>> Otherwise we leak PASID 1.
>> In 5.16 PASID 1 from master is hold until nginx service stop.
>> nginx start
>> master:
>> iommu_sva_alloc_pasid mm->pasid=1      // master process
>>
>> lynx https start:
>> iommu_sva_alloc_pasid mm->pasid=2    //worker process
>>
>> nginx stop:  from fops_release
>> iommu_sva_free_pasid mm->pasid=2   // worker process
>> iommu_sva_free_pasid mm->pasid=1  // master process
> That's the expected behavior (master could close its fd before forking, in
> order to free things up earlier, but it's not mandatory)
Currently we unbind in fops_release, so the ioasid allocated in master 
can only be freed when nginx stop,
when all forked fd are closed.

>
>> Have one silly question.
>>
>> kerne driver
>> fops_open
>> iommu_sva_bind_device
>>
>> fops_release
>> iommu_sva_unbind_device
>>
>> application
>> main()
>> fd = open
>> return;
>>
>> Application exit but not close(fd), is it expected fops_release will be
>> called automatically by system?
> Yes, the application doesn't have to call close() explicitly, the file
> descriptor is closed automatically on exit. Note that the fd is copied on
> fork(), so it is only released once parent and all child processes exit.
Yes, in case the application ended unexpected, like ctrl+c
>
>> On 5.17
>> fops_release is called automatically, as well as iommu_sva_unbind_device.
>> On 5.18-rc1.
>> fops_release is not called, have to manually call close(fd)
> Right that's weird
Looks it is caused by the fix patch, via mmget, which may add refcount 
of fd.

Some experiments
1. 5.17, everything works well.

2. 5.17 + patchset of "iommu/sva: Assign a PASID to mm on PASID 
allocation and free it on mm exit"

Test application, exit without close uacce fd
First time:  fops_release can be called automatically.

log:
ioasid_alloc ioasid=1
iommu_sva_alloc_pasid pasid=1
iommu_sva_bind_device handle=00000000263a2ee8
ioasid_free ioasid=1
uacce_fops_release q=0000000055ca3cdf
iommu_sva_unbind_device handle=00000000263a2ee8

Second time: hardware reports error

uacce_fops_open q=000000008e4d6f78
ioasid_alloc ioasid=1
iommu_sva_alloc_pasid pasid=1
iommu_sva_bind_device handle=00000000cfd11788
// Haredware reports error
hisi_sec2 0000:b6:00.0: qm_acc_do_task_timeout [error status=0x20] found
hisi_sec2 0000:b6:00.0: qm_acc_wb_not_ready_timeout [error status=0x40] 
found
hisi_sec2 0000:b6:00.0: sec_fsm_hbeat_rint [error status=0x20] found
hisi_sec2 0000:b6:00.0: Controller resetting...
hisi_sec2 0000:b6:00.0: QM mailbox operation timeout!
hisi_sec2 0000:b6:00.0: Failed to dump sqc!
hisi_sec2 0000:b6:00.0: Failed to drain out data for stopping!
hisi_sec2 0000:b6:00.0: Bus lock! Please reset system.
hisi_sec2 0000:b6:00.0: Controller reset failed (-110)
hisi_sec2 0000:b6:00.0: controller reset failed (-110)

3. Add the fix patch of using mmget in bind.
Test application, exit without close uacce fd

fops_release can NOT be called automatically, looks mmget adds refcount 
of fd.

So the fix method of using mmget blocks fops_release to be called once 
fd is closed without unbind.

>> Since nginx may have a issue, it does not call close(fd) when nginx -s quit.
> And you're sure that none of the processes are still alive or in zombie
> state?  Just to cover every possibility.
It can also reproduced by a simple application exit without close(uacce_fd)

Thanks

