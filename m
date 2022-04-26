Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA8C50F023
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiDZFWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiDZFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:22:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF8E15838
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:19:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u6-20020a17090a1f0600b001d86bd69427so1493355pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ECxlRdPBkrkKMb5BBakDNfPI3kNTo9GDiWWWzCDwUgs=;
        b=XvVcXIeuHS3H4nVboFfXVUOb4S1b5fWr5kvOUCcwc9H9BkEERtMw9ICUnzj7H4a7Qo
         mJu/rn3UYjQJVVget/AYA2ujXxSCxyXZW29HLToMLQFzm0/au0kwbAmZg2pgcBjvfTpp
         9yNGnWzLKII2jaL0A9lo6eJuu87Il2qs9NKQlUNJYkVGXOK099nZmj1GpmFaB8MeLXHM
         7iiyhkYpJirWkAM6r/RblIwjClb3a3MxfjLfJgWexd0t7NYDY6EO1p2dRThrYavYvKcr
         7vSVrxVC79iGpOrEdBGpOgfKG9aTFynX7W6SqdDB7wIoZbOJIN0le2hE5vXWD9YvEB2n
         ODOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ECxlRdPBkrkKMb5BBakDNfPI3kNTo9GDiWWWzCDwUgs=;
        b=WRdPxMUFC7i1QjFlmdoYb4s52vo1KJykd5/gg7fb9s4kMvhrnW4v/3qXARig5FQN5Q
         kjoGjnmVlGuRUo3BmznKl8fDClzAJjjXgvUU3JdcOZvvQtvYp83a2GWP4LLwj4kp5p0h
         cQOyT5lI7YQ4z0rv0B9ZHL3Nv8NzpIqRYIlT6Mxey2zwf9nDHf38ozBKemKvYk5si2nT
         6UH1JXnNAkX9mgy4AjvMoNHjy3eF+5QA4C19HIRih2Wp3g3nc7ZIcFjpALQTEcYbWFCM
         3+y47WkcaGsRNJQY4OZmLsWmq5lzH7/Y0v6lIrCysoEVXhCFMdiF3bvAWEec7RcAhElx
         ls5g==
X-Gm-Message-State: AOAM530m7Oy5Zx9/4pUENXFwnEaptQAggYTM7429JeW8jGWN1VvtN5OK
        vC3FpXHuGAEHB16EJpNLQE1wGA==
X-Google-Smtp-Source: ABdhPJyhEAYlOo+kBdVUQuo6fad1zeTwCcRGFOZ8UwxJdulGi+QpoSwVb3c41jqVnG0Wwzf9rlEpZg==
X-Received: by 2002:a17:903:14a:b0:15c:f657:62d0 with SMTP id r10-20020a170903014a00b0015cf65762d0mr13053218plc.81.1650950363137;
        Mon, 25 Apr 2022 22:19:23 -0700 (PDT)
Received: from [10.69.0.6] ([94.177.118.37])
        by smtp.gmail.com with ESMTPSA id nm6-20020a17090b19c600b001cd4989fedbsm1113346pjb.39.2022.04.25.22.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 22:19:22 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <cf27bf82-ca68-86f1-ac8f-a138713edd5f@linaro.org>
 <Ymd2w30dkiKX1VfL@fyu1.sc.intel.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b420d92e-e6ea-9506-764d-e430be5c8bb0@linaro.org>
Date:   Tue, 26 Apr 2022 13:19:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ymd2w30dkiKX1VfL@fyu1.sc.intel.com>
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



On 2022/4/26 下午12:36, Fenghua Yu wrote:
> On Tue, Apr 26, 2022 at 12:28:00PM +0800, Zhangfei Gao wrote:
>> Hi, Jean
>>
>> On 2022/4/26 上午12:13, Jean-Philippe Brucker wrote:
>>> Hi Jacob,
>>>
>>> On Mon, Apr 25, 2022 at 08:34:44AM -0700, Jacob Pan wrote:
>>>> Hi Jean-Philippe,
>>>>
>>>> On Mon, 25 Apr 2022 15:26:40 +0100, Jean-Philippe Brucker
>>>> <jean-philippe@linaro.org> wrote:
>>>>
>>>>> On Mon, Apr 25, 2022 at 07:18:36AM -0700, Dave Hansen wrote:
>>>>>> On 4/25/22 06:53, Jean-Philippe Brucker wrote:
>>>>>>> On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com
>>>>>>> wrote:
>>>>>>>>>> On 5.17
>>>>>>>>>> fops_release is called automatically, as well as
>>>>>>>>>> iommu_sva_unbind_device. On 5.18-rc1.
>>>>>>>>>> fops_release is not called, have to manually call close(fd)
>>>>>>>>> Right that's weird
>>>>>>>> Looks it is caused by the fix patch, via mmget, which may add
>>>>>>>> refcount of fd.
>>>>>>> Yes indirectly I think: when the process mmaps the queue,
>>>>>>> mmap_region() takes a reference to the uacce fd. That reference is
>>>>>>> released either by explicit close() or munmap(), or by exit_mmap()
>>>>>>> (which is triggered by mmput()). Since there is an mm->fd dependency,
>>>>>>> we cannot add a fd->mm dependency, so no mmget()/mmput() in
>>>>>>> bind()/unbind().
>>>>>>>
>>>>>>> I guess we should go back to refcounted PASIDs instead, to avoid
>>>>>>> freeing them until unbind().
>>>>>> Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
>>>>>> nothing else simple we can do.
>>>>>>
>>>>>> How does the IOMMU hardware know that all activity to a given PASID is
>>>>>> finished?  That activity should, today, be independent of an mm or a
>>>>>> fd's lifetime.
>>>>> In the case of uacce, it's tied to the fd lifetime: opening an accelerator
>>>>> queue calls iommu_sva_bind_device(), which sets up the PASID context in
>>>>> the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
>>>>> destroys the PASID context (after the device driver stopped all DMA for
>>>>> this PASID).
>>>>>
>>>> For VT-d, it is essentially the same flow except managed by the individual
>>>> drivers such as DSA.
>>>> If free() happens before unbind(), we deactivate the PASIDs and suppress
>>>> faults from the device. When the unbind finally comes, we finalize the
>>>> PASID teardown. It seems we have a need for an intermediate state where
>>>> PASID is "pending free"?
>>> Yes we do have that state, though I'm not sure we need to make it explicit
>>> in the ioasid allocator.
>>>
>>> Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
>>> we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
>>> also part of Lu's rework [1].
>> Move mm_pasid_drop to __mmdrop looks workable.
>>
>> The nginx works since ioasid is not freed when master exit until nginx stop.
>>
>> The ioasid does not free immediately when fops_release->unbind finished.
>> Instead, __mmdrop happens a bit lazy,  which has no issue though
>> I passed 10000 times exit without unbind test, the pasid allocation is ok.
>>
>> Thanks
>>
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 9796897560ab..60f417f69367 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -792,6 +792,8 @@ void __mmdrop(struct mm_struct *mm)
>>          mmu_notifier_subscriptions_destroy(mm);
>>          check_mm(mm);
>>          put_user_ns(mm->user_ns);
>> +       mm_pasid_drop(mm);
>>          free_mm(mm);
>>   }
>>   EXPORT_SYMBOL_GPL(__mmdrop);
>> @@ -1190,7 +1192,6 @@ static inline void __mmput(struct mm_struct *mm)
>>          }
>>          if (mm->binfmt)
>>                  module_put(mm->binfmt->module);
>> -       mm_pasid_drop(mm);
>>          mmdrop(mm);
>>   }
> Thank you very much, Zhangfei!
>
> I just now sent out an identical patch. It works on X86 as well.
>
> So seems the patch is the right fix.
>
> Either you can send out the patch or I add your Signed-off-by? Either way
> is OK for me.
Thanks Fenghua,
It does not matter. Have added tested-by.
I was in stress test for checking the pasid free, since it was freed lazily.

Thank all for the help, a bit nervous, since it is rc4 now.


