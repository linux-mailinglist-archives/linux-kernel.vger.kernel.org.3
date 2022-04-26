Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517E750EFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244068AbiDZEba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiDZEb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:31:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7FC60D99
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:28:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j17so16831482pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6121FvL1Agui+jgRIK6EJfVDrfD9B0AZyGQp+izN9SA=;
        b=kwmtSIA1VzkwnttMblbAzz+kfXu5zKeua/C1D14z0Lj3ag9aMXEahifhUWeMXmyYyc
         H6tvlpdOhTtY7YWchWX6mOMF6GBXnVBYKvHKF187+rJojcg5JpOPbdIpBZtJcuCYHF6T
         Tb0FmBSqDB+A5xXuN8UhhSs2Hormaf8rAmpwb1Ol16/E57b1IwA0VF7L3cpF45wUweHQ
         NGO+chxvQOcfs8ngbr+f+X5A2CmlK6z5g5kSbOcyKAIG/e6fu7I5EnpQIpd6DRkMxHbF
         di5QnHvorEf1RBW/zUlOXIK0RAA1z4JxE0jIR24/8Q6e2W4gKW8QDF4iE91ZEwq7orb4
         V8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6121FvL1Agui+jgRIK6EJfVDrfD9B0AZyGQp+izN9SA=;
        b=1wnYVePVET2S5evPwHfFfndchzMdSc0hRL4sS/QPY17C225q04vrdNhf63juCsyGWw
         RyydPga9d5lBx8ryvFeWbSGM+XTCSo9uPk7XV0wkVZtAPPylsRnv9EKox7QBlUGRNIt9
         pJwxBr6pPZpGkC3mW+bEn9bQXPXoPoWb1K34fsUN0VjfxsUdZRwgn990alModXY8Dg8P
         sT34gE5p4RY5LUZqAuQNoY2UDRUnKkpyUq4RbY/69WIIrcgrKoq9L8hz3DrzowfN2O5D
         hnvPeGZcBgzQEOJnWs8wkgP0NfbCyUKajj7J+ODFAmMtqB/2CFBQKi5k7wRkp+qDCNzd
         s8Zg==
X-Gm-Message-State: AOAM5328aE1eirqSunudf/eAKyLnRZWsFo1P3LrX0JXC44nCfKzuHzrp
        WTu4e58triZdWVkXVSRxp/pDBg==
X-Google-Smtp-Source: ABdhPJy8YhdEawCfwyIt1VWkYEmpxyAh1A1QAW/EycthB6WVtxCO83zxGEHNA81bt6nJQEVSmZsDew==
X-Received: by 2002:a05:6a00:2442:b0:4fd:8b00:d2f with SMTP id d2-20020a056a00244200b004fd8b000d2fmr22379519pfj.39.1650947300994;
        Mon, 25 Apr 2022 21:28:20 -0700 (PDT)
Received: from [10.72.0.6] ([94.177.118.64])
        by smtp.gmail.com with ESMTPSA id t29-20020a62d15d000000b0050d42864753sm4690106pfl.49.2022.04.25.21.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 21:28:20 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
References: <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
Date:   Tue, 26 Apr 2022 12:28:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmbIjnHtibY7n4Wb@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean

On 2022/4/26 上午12:13, Jean-Philippe Brucker wrote:
> Hi Jacob,
>
> On Mon, Apr 25, 2022 at 08:34:44AM -0700, Jacob Pan wrote:
>> Hi Jean-Philippe,
>>
>> On Mon, 25 Apr 2022 15:26:40 +0100, Jean-Philippe Brucker
>> <jean-philippe@linaro.org> wrote:
>>
>>> On Mon, Apr 25, 2022 at 07:18:36AM -0700, Dave Hansen wrote:
>>>> On 4/25/22 06:53, Jean-Philippe Brucker wrote:
>>>>> On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com
>>>>> wrote:
>>>>>>>> On 5.17
>>>>>>>> fops_release is called automatically, as well as
>>>>>>>> iommu_sva_unbind_device. On 5.18-rc1.
>>>>>>>> fops_release is not called, have to manually call close(fd)
>>>>>>> Right that's weird
>>>>>> Looks it is caused by the fix patch, via mmget, which may add
>>>>>> refcount of fd.
>>>>> Yes indirectly I think: when the process mmaps the queue,
>>>>> mmap_region() takes a reference to the uacce fd. That reference is
>>>>> released either by explicit close() or munmap(), or by exit_mmap()
>>>>> (which is triggered by mmput()). Since there is an mm->fd dependency,
>>>>> we cannot add a fd->mm dependency, so no mmget()/mmput() in
>>>>> bind()/unbind().
>>>>>
>>>>> I guess we should go back to refcounted PASIDs instead, to avoid
>>>>> freeing them until unbind().
>>>> Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
>>>> nothing else simple we can do.
>>>>
>>>> How does the IOMMU hardware know that all activity to a given PASID is
>>>> finished?  That activity should, today, be independent of an mm or a
>>>> fd's lifetime.
>>> In the case of uacce, it's tied to the fd lifetime: opening an accelerator
>>> queue calls iommu_sva_bind_device(), which sets up the PASID context in
>>> the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
>>> destroys the PASID context (after the device driver stopped all DMA for
>>> this PASID).
>>>
>> For VT-d, it is essentially the same flow except managed by the individual
>> drivers such as DSA.
>> If free() happens before unbind(), we deactivate the PASIDs and suppress
>> faults from the device. When the unbind finally comes, we finalize the
>> PASID teardown. It seems we have a need for an intermediate state where
>> PASID is "pending free"?
> Yes we do have that state, though I'm not sure we need to make it explicit
> in the ioasid allocator.
>
> Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
> we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
> also part of Lu's rework [1].

Move mm_pasid_drop to __mmdrop looks workable.

The nginx works since ioasid is not freed when master exit until nginx stop.

The ioasid does not free immediately when fops_release->unbind finished.
Instead, __mmdrop happens a bit lazy,  which has no issue though
I passed 10000 times exit without unbind test, the pasid allocation is ok.

Thanks


diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..60f417f69367 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -792,6 +792,8 @@ void __mmdrop(struct mm_struct *mm)
         mmu_notifier_subscriptions_destroy(mm);
         check_mm(mm);
         put_user_ns(mm->user_ns);
+       mm_pasid_drop(mm);
         free_mm(mm);
  }
  EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1190,7 +1192,6 @@ static inline void __mmput(struct mm_struct *mm)
         }
         if (mm->binfmt)
                 module_put(mm->binfmt->module);
-       mm_pasid_drop(mm);
         mmdrop(mm);
  }

>
> Thanks,
> Jean
>
> [1] https://lore.kernel.org/linux-iommu/20220421052121.3464100-9-baolu.lu@linux.intel.com/

