Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56433500AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiDNKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiDNKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:10:49 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7365A71A02
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649930894;
        bh=AII3mZ4L8bVc9YedtITokvmDF0CoVT2yQ9iSUIZFtv4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=LzmJAPRE0vROtrkrCX+LAbcOIbg2MY1oZfPMxhCf5iPjN3aGpIYQFWUE/cqYXUoBt
         L4FvQWqFWxIlt+K+bP2qu8TNdP8zbTWe8fzNgE3YslLgD1vb/sOTjlWz9FooIoBQnH
         WUPr027+5kGQRiV6hACzplh4SZk8xxf179KuNrbo=
Received: from [IPv6:240e:362:4f5:2500:edff:6c6a:bd0a:88d3] ([240e:362:4f5:2500:edff:6c6a:bd0a:88d3])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id 20A1246B; Thu, 14 Apr 2022 18:08:10 +0800
X-QQ-mid: xmsmtpt1649930890t32ewonsv
Message-ID: <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7ZhoC4JiWo82lT32DZgeLIdKSdlzQzU5ZaBRhx5L47E4F+RUZrEp
         GrmudGyLVYMz2/9VgWEFP57XNZYt8zGt5qc+IaDLEoyegoJc2Gj7VSN2b8e0tKAcnTr8W3eiG+k+
         qA1tj6xh0whnnlO/l4BT9KU2A2BkwWxuHj225tdHFGZ0qo0p/MQgwbK0i9yzRKdPDY209hp1viur
         dCXJTikBaoJc8z8R75IBQv7lLnXxCNZVt/gr5i7cVwq0nZAEAHBwO+POAhvZaUiAgVT1ludyC34R
         yGsqQ4bRvIvnTblLxMSkwhJtxHbVGmdNCKYg5oRr10TibtuLnHMXcBcKmq3Tfn+6Jmq7sJwuKM8b
         kSc97/mnnkYLTyK1xTLRgJhEQds+sgg31uRlsjoovuEkPSp4Hz6GkZEW/msFIEtJUDoBTF1QRA1o
         Zun4I8PvkKOjsZCXXBHWe1AkwQDQtPQ+IQ/CSRnvyJuluj6x/uQaUzy1JRWevrM2GHb5cTebrxk4
         jaRd2x0V6soAFST35cr01TTgkDQDhOUIszHrOg5F3qG5O5gL06HsLZ3lXrmMJPxITTkInbAy55le
         gfheV+qOY/nSx33uhL3epUsZLaLSP1eFpd5aU/Lz8aqrK7qE9tl3WDazWz0/ZaJzwyLphsz4uYLg
         Dk63WJp9UG2or5bO4iP5HX4RRTGpiQffHBBxvfk4UCsHaY/52PxjeYsitvqWpnr1GPMwPuG/W2ns
         ZIAq+OoqY2+Wv1jl457FBJUwx2Y/A3I3QypAIR6kkny6+LropPCc3g5TICVuNyEtuyn2USCaxsDt
         hdwnO6Cd94f58Hsjn6R3npuLQjerCNE2sCHfQsPB0/wIPAz8iJ7rCfddmUlqjP1LRIQjwnesDkkn
         ngcBdPMJhyAwAZWu24ytY9s11E9DO8PansxU/dkC+XCSV0ybbjnX+Ss5jZZJdlargUwd0thCeJXi
         dPMxVtIcLzaiDPPpY82w==
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
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
        Thomas Gleixner <tglx@linutronix.de>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
X-OQ-MSGID: <80dfcb87-0cb3-3282-79ba-d6b733f12302@foxmail.com>
Date:   Thu, 14 Apr 2022 18:08:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/12 下午11:35, zhangfei.gao@foxmail.com wrote:
> Hi, Fenghua
>
> On 2022/4/12 下午9:41, Fenghua Yu wrote:
>> Hi, Zhangfei,
>>
>> On Tue, Apr 12, 2022 at 03:04:09PM +0800, zhangfei.gao@foxmail.com 
>> wrote:
>>>
>>> On 2022/4/11 下午10:52, Dave Hansen wrote:
>>>> On 4/11/22 07:44, zhangfei.gao@foxmail.com wrote:
>>>>> On 2022/4/11 下午10:36, Dave Hansen wrote:
>>>>>> On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
>>>>>>>> Is there nothing before this call trace?  Usually there will be 
>>>>>>>> at least
>>>>>>>> some warning text.
>>>>>>> I added dump_stack() in ioasid_free.
>>>>>> Hold on a sec, though...
>>>>>>
>>>>>> What's the *problem* here?  Did something break or are you just 
>>>>>> saying
>>>>>> that something looks weird to _you_?
>>>>> After this, nginx is not working at all, and hardware reports error.
>>>>> Suppose the the master use the ioasid for init, but got freed.
>>>>>
>>>>> hardware reports:
>>>>> [  152.731869] hisi_sec2 0000:76:00.0: qm_acc_do_task_timeout 
>>>>> [error status=0x20] found
>>>>> [  152.739657] hisi_sec2 0000:76:00.0: qm_acc_wb_not_ready_timeout 
>>>>> [error status=0x40] found
>>>>> [  152.747877] hisi_sec2 0000:76:00.0: sec_fsm_hbeat_rint [error 
>>>>> status=0x20] found
>>>>> [  152.755340] hisi_sec2 0000:76:00.0: Controller resetting...
>>>>> [  152.762044] hisi_sec2 0000:76:00.0: QM mailbox operation timeout!
>>>>> [  152.768198] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>>>> [  152.773490] hisi_sec2 0000:76:00.0: Failed to drain out data 
>>>>> for stopping!
>>>>> [  152.781426] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>>>>> [  152.787468] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>>>> [  152.792753] hisi_sec2 0000:76:00.0: Failed to drain out data 
>>>>> for stopping!
>>>>> [  152.800685] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>>>>> [  152.806730] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>>>> [  152.812017] hisi_sec2 0000:76:00.0: Failed to drain out data 
>>>>> for stopping!
>>>>> [  152.819946] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>>>>> [  152.825992] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>>> That would have been awfully handy information to have in an 
>>>> initial bug report. :)
>>>> Is there a chance you could dump out that ioasid alloc *and* free 
>>>> information in ioasid_alloc/free()?  This could be some kind of 
>>>> problem with the allocator, or with copying the ioasid at fork.
>>> The issue is nginx master process init resource, start daemon 
>>> process, then
>>> master process quit and free ioasid.
>>> The daemon nginx process is not the original master process.
>>>
>>> master process:  init resource
>>> driver -> iommu_sva_bind_device -> ioasid_alloc
>> Which code in the master process/daemon calls 
>> driver->iommu_sva_unbind_device?
> Our calling sequence is nginx -> openssl -> openssl engine ->  kernel 
> driver
> The calling entrence should be ngx_ssl_init : OPENSSL_config(NULL);
>
> nginx:
> src/event/ngx_event_openssl.c
> ngx_ssl_init
> if (OPENSSL_init_ssl(OPENSSL_INIT_LOAD_CONFIG, NULL) == 0)
>
> I add some print.
>
> /usr/local/nginx$ sudo sbin/nginx
> ngx_ssl_init pid=2361
> bind_fn
> ngx_openssl_create_conf pid=2361
> hisi sec init Kunpeng920!
> ngx_ssl_create pid=2361
> ngx_ssl_certificates pid=2361
> ngx_ssl_certificate pid=2361
> uadk_e_wd_digest_init
> hisi sec init Kunpeng920!
> ngx_ssl_ciphers pid=2361
> ngx_daemon pid=2361 fork daemon
> master pid=2361 will exit                                // here 
> master process is exit
> fork return 0 pid=2364                                       // here 
> daemon process started
> ngx_daemon fork ngx_pid=2364, ngx_parent=2361
> $ ps -aux | grep nginx
> root        2364  0.0  0.0  31324 15380 ?        Ssl  15:21   0:00 
> nginx: master process sbin/nginx
> nobody      2366  0.0  0.0  32304 16448 ?        Sl   15:21   0:00 
> nginx: worker process
> linaro      2371  0.0  0.0   7696  2048 pts/0    S+   15:22   0:00 
> grep --color=auto nginx
>
> nginx
> src/os/unix/ngx_daemon.c
> ngx_daemon(ngx_log_t *log)
> {
>     int  fd;
>
>     switch (fork()) {
>     case -1:
>         ngx_log_error(NGX_LOG_EMERG, log, ngx_errno, "fork() failed");
>         return NGX_ERROR;
>
>     case 0:
>        // here fork daemon process
>         break;
>
>     default:
>       // master process directly exit, and release mm as well as ioasid
>         exit(0);
>     }
>
>      // only daemon process
>     ngx_parent = ngx_pid;
>     ngx_pid = ngx_getpid();
>>> Any suggestion?
>> ioasid is per process or per mm. A daemon process shouldn't share the 
>> same
>> ioasid with any other process with even its parent process. Its 
>> parent gets
>> an ioasid and frees it on exit. The ioasid is gone and shouldn't be used
>> by its child process.
>>
>> Each daemon process should call driver -> iommu_sva_bind_device -> 
>> ioasid_alloc
>> to get its own ioasid/PASID. On daemon quit, the ioasid is freed.
>>
>> That means nqnix needs to be changed.
>
> Agree with Dave, I think user space should not be broken.
>
> Thanks

Any plan about this regression?
Currently I need this patch to workaround the issue.

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05bbdcd..2d74ac53d11c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -4,6 +4,7 @@
   */

  #include <linux/mm.h>
+#include <linux/sched/mm.h>
  #include <linux/mmu_context.h>
  #include <linux/mmu_notifier.h>
  #include <linux/slab.h>
@@ -363,6 +364,7 @@ arm_smmu_sva_bind(struct device *dev, struct 
mm_struct *mm, void *drvdata)

         mutex_lock(&sva_lock);
         handle = __arm_smmu_sva_bind(dev, mm);
+       mmget(mm);
         mutex_unlock(&sva_lock);
         return handle;
  }
@@ -377,6 +379,7 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
                 arm_smmu_mmu_notifier_put(bond->smmu_mn);
                 kfree(bond);
         }
+       mmput(bond->mm);
         mutex_unlock(&sva_lock);
  }

Thanks

