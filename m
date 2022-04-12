Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2244FD6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354798AbiDLIF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353785AbiDLHZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:25:54 -0400
X-Greylist: delayed 60956 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 00:04:19 PDT
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2916256
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649747054;
        bh=+Nw/81EzAzg32b0b63hZbzdAlSaSPQJFfPDQ8bOr+dk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WHDhRlFLuUtf+6qTzyJUKuWWTm6bnZVNTBSWGCX+2v67SVOCTiMyZ29lCUUuzJLKA
         Aa6dPwx66T/YxtIdPvwmc9CaEr56j1Ep5w2IDuEcmbf5C+yW/iiFdM8woqYRGrQ44X
         Ck0LZ9SjG7iO7jZcH/Fsc1ay7IvkP3+7RFanF5io=
Received: from [IPv6:240e:362:406:cc00:1037:1d58:2ba:46b6] ([240e:362:406:cc00:1037:1d58:2ba:46b6])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 10A1781B; Tue, 12 Apr 2022 15:04:10 +0800
X-QQ-mid: xmsmtpt1649747050t25c06aya
Message-ID: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjkkO1MRHXn0IzBI/HiOM9PhWrX0Q2YE3pYwi5OJHPJwDADUq060
         vN3f2kY/K3AoMyxnFfz+KUdn/3oa1F2UFhhm+Fk217AR30+hGKu58xLK6H1ct8aOp8SwHdqaNbjU
         Ar2QQCFmrOcGNaNDoo58jF2+jMsJkeOs59nreUY9Jtr9YDeOxMKiHjGeRO3vCSUmGfs0y5TlT1GD
         f3Exyc0uE9ubv0Eof325Jq7rqD9e4UV+ggOA/3+eD7IoMn2DriA1RbxYNA3nktXX+UUoJG86HqbM
         qCIrQjLM/VkhR76cuSlwVDML7Pm8sAxsTF2Zy6JzCtzK3nfllO/aStqIdYzOUC7+r4GDJLaGgVl4
         X1yBFXzvfZcpmihWgHsm27aeBnW3xlAteQIJoXy+GdBBu4DPbfHKDmwnMuf5+dLbMiToz1+NHFmM
         FQt0aYat1iIF5WSUL0/A2wI5vsW9/Fy7O7g3SoXvs9/MEk0ALYqCWLv+IkH7ZA//F7ncfxvi7IqW
         TGNTY1u9M0IHj4rjr5r4By0oVG/8pkou+wnUns4mjdxsUgTFapjVV+QeWshgHh3tl7DKTUZVQtW/
         RCfogvyi15C87hQ47jC0jCPb4tQ7xgRmmVgphFSR8DJJhMYuKVRIHdykJMYSpiPckIbQsLA3sjGx
         piIpA1ivk1K52u1h39hyT3LST29Cf36FpFMc11FZKb7tPDNm3BFkOgBQUKqHeMZ8ZF6ed9oFZuUD
         HhtR1HEFR0mxZjOffYQzvC6xgPvNIpH6RxbSzXyFrJo9vJHKYQZUAKhOYPNesLOzu5OPho5V1aAR
         n8J0UuhisSqvlq6FKL3IHNLsB3s6ny/r8IcjLHF8/vieoWFV7AZYAH9GRmYvBEpgSp+ILrI/xzk8
         nhYwrHHpUyI1EFlXZHDx+VCHHdSUGUiBhbvqJ2/3DmxqNKyxvxog3W1TDrnqT9rVJILKA2RTAdnq
         WPz1Q2HZc=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        jean-philippe <jean-philippe@linaro.org>
Cc:     Ravi V Shankar <ravi.v.shankar@intel.com>,
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
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <dfc3a641-ed8a-a534-f80c-f391f5e825c8@foxmail.com>
Date:   Tue, 12 Apr 2022 15:04:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/11 下午10:52, Dave Hansen wrote:
> On 4/11/22 07:44, zhangfei.gao@foxmail.com wrote:
>> On 2022/4/11 下午10:36, Dave Hansen wrote:
>>> On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
>>>>> Is there nothing before this call trace?  Usually there will be at least
>>>>> some warning text.
>>>> I added dump_stack() in ioasid_free.
>>> Hold on a sec, though...
>>>
>>> What's the *problem* here?  Did something break or are you just saying
>>> that something looks weird to _you_?
>> After this, nginx is not working at all, and hardware reports error.
>> Suppose the the master use the ioasid for init, but got freed.
>>
>> hardware reports:
>> [  152.731869] hisi_sec2 0000:76:00.0: qm_acc_do_task_timeout [error status=0x20] found
>> [  152.739657] hisi_sec2 0000:76:00.0: qm_acc_wb_not_ready_timeout [error status=0x40] found
>> [  152.747877] hisi_sec2 0000:76:00.0: sec_fsm_hbeat_rint [error status=0x20] found
>> [  152.755340] hisi_sec2 0000:76:00.0: Controller resetting...
>> [  152.762044] hisi_sec2 0000:76:00.0: QM mailbox operation timeout!
>> [  152.768198] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>> [  152.773490] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
>> [  152.781426] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>> [  152.787468] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>> [  152.792753] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
>> [  152.800685] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>> [  152.806730] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>> [  152.812017] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
>> [  152.819946] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>> [  152.825992] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> That would have been awfully handy information to have in an initial bug report. :)
> Is there a chance you could dump out that ioasid alloc *and* free information in ioasid_alloc/free()?  This could be some kind of problem with the allocator, or with copying the ioasid at fork.
The issue is nginx master process init resource, start daemon process, 
then master process quit and free ioasid.
The daemon nginx process is not the original master process.

master process:  init resource
driver -> iommu_sva_bind_device -> ioasid_alloc

nginx : ngx_daemon
fork daemon, without add mm's refcount.

src/os/unix/ngx_daemon.c
ngx_daemon(ngx_log_t *log)
{
     int  fd;

     switch (fork()) {
     case -1:
         ngx_log_error(NGX_LOG_EMERG, log, ngx_errno, "fork() failed");
         return NGX_ERROR;

     case 0:        // here master process is quit directly and will be 
released.
         break;

     default:
         exit(0);
     }
// here daemon process take control.
     ngx_parent = ngx_pid;
     ngx_pid = ngx_getpid();


fork.c
copy_mm
         if (clone_flags & CLONE_VM) {
                 mmget(oldmm);
                 mm = oldmm;
         } else {
                 mm = dup_mm(tsk, current->mm);    // here daemon 
process handling without mmget.

master process quit, mmput ->  mm_pasid_drop->ioasid_free
But this ignore driver's iommu_sva_unbind_device function,
iommu_sva_bind_device and iommu_sva_unbind_device are not pair,  So 
driver does not know ioasid is freed.

Any suggestion?
Or can we still use the original ioasid refcount mechanism?

Thanks
