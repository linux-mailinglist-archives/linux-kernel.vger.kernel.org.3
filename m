Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C850D746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiDYDBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbiDYDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:01:18 -0400
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739B84ED6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650855488;
        bh=HucfxWg7WLzKK33ibHuCmIEtwQY3NwivHh2WljaMSPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QZdi3CdCyKj1C4fVLcPcm4rK4IBLJ0vsJp5yBIiUw9Td4uqxZdbVvLk5ANwrG7ucN
         5H07mqKtK089BFQ2c+FeO1RAgoICcN5A/5yAUVZfOyeQZ6nAYO0WGrD3dtiwUqiTO3
         vQup7Se/15B7oorh7+kshRjaW9lorhNF5k8AXvOw=
Received: from [10.27.0.6] ([94.177.118.128])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id E7715EE1; Mon, 25 Apr 2022 10:57:55 +0800
X-QQ-mid: xmsmtpt1650855475te67wfj42
Message-ID: <tencent_5151C34BC7D86055C4C7768C1A4653505A06@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQC/KJV6LaTwBj061LhYfOrByOSpey+K3S1udv28bAJjd5Bdllfd
         pNb7IEi0EY/cpHk10CYCm+d4cYqiCLcqqx/UcZ9XIVctITwZhcaxrq4AXXKFmiHMzFmtOaxWriNQ
         4hCNKjJs4cvj9qjSwWboYISnOiamhpm3yGXZ+WAmnQqWDDu5uS8Y7eYFmxHJwuwcHHM4B6Qaz2mI
         wWuVLmL0i/W/vSNlo3/tQiiviDuSL2NxALnbXwUkBqHNAuxFAEjZnZZYRF5kfCz9bvnys4jlOYBs
         bMlE2272nyI0aVjUA4mnUxCdHyImXVnpX+fzFlSwpcGJHmuVPt4j5WEfL7Ybo1XI4WBnq0Bn3lV4
         iE6jqCw3iMWqKMtshFuaHGNoUP5Uetko1WTX/8KW49AOaE9ix1IUdW2q7EP8sxF3iC+IRoCgTZ6t
         3YWYr6gLxB6mwTgHj/j7aQrqNhECc1f0hGC5xfxUVPTTvnRDXgLi8Y8qE9/eIHoWC56ibR9x/W/I
         zTOkiWDLBTv0L5Ba+/J/ZF3GrVEuBYuoHZSsWYASi4WTqhFmT/wBikEosE422A4nweHtC7ao5Gqc
         6eHmokCHPzg4hk0QMnGLXm7jD/Xj8ey9dgYk6UC8Uq3CPMxaDNl1LpTXeDVxxWsTjcILOZKuo2xp
         F8pvRpJDYBHcV7xhV8+OxlftqHtBYLJoGQKeFnLRufsIcTLkw/yR6LFWtLZkitCdUEF0Fa3JmEeT
         m6wjurCIXKFXX1wQOMsa+yb/OcBI0a+/VnCxpH0gWGLg84Aa7qAN4Y0C1CVwRIiX5CJE9Y+jHRxv
         h244I2/fM5O5tmDQ3142Jof8BbQa69HKjH8fmK8bdFk/g3BNNOrK54rWxGiId5ajoz4cy3UuCiqs
         mRjBozcKxwJifU8C3We0p/Xkouf5HGrEi4elXPN5nNbrYRzFmUkMyI2YPSE9oMzXcF5S934HkO
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Dave Hansen <dave.hansen@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Fenghua Yu <fenghua.yu@intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        zhangfei <zhangfei.gao@linaro.org>
References: <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com> <YlWWavIDMNpbD3Ye@larix>
 <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <6daae664-fad2-fe1f-0c22-b8c8aceab841@foxmail.com>
Date:   Mon, 25 Apr 2022 10:57:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave

On 2022/4/12 下午11:35, Dave Hansen wrote:
> On 4/12/22 08:10, Jean-Philippe Brucker wrote:
>>> I wonder if the Intel and ARM IOMMU code differ in the way they keep
>>> references to the mm, or if this affects Intel as well, but we just
>>> haven't tested the code enough.
>> The Arm code was written expecting the PASID to be freed on unbind(), not
>> mm exit. I missed the change of behavior, sorry (I thought your plan was
>> to extend PASID lifetime, not shorten it?) but as is it seems very broken.
>> For example in the iommu_sva_unbind_device(), we have
>> arm_smmu_mmu_notifier_put() clearing the PASID table entry for
>> "mm->pasid", which is going to end badly if the PASID has been cleared or
>> reallocated. We can't clear the PASID entry in mm exit because at that
>> point the device may still be issuing DMA for that PASID and we need to
>> quiesce the entry rather than deactivate it.
> I think we ended up flipping some of this around on the Intel side.
> Instead of having to quiesce the device on mm exit, we don't let the mm
> exit until the device is done.
>
> When you program the pasid into the device, it's a lot like when you
> create a thread.  We bump the reference count on the mm when we program
> the page table pointer into a CPU.  We drop the thread's reference to
> the mm when the thread exits and will no longer be using the page tables.
>
> Same thing with pasids.  We bump the refcount on the mm when the pasid
> is programmed into the device.  Once the device is done with the mm, we
> drop the mm.
>
> Basically, instead of recounting the pasid itself, we just refcount the mm.
This has issue, since refcount the mm will block  fops_release to be 
called, where unbind may really happen.

For example, user driver are ended unexpectedly,
usually system will end all applications via close fd -> fops_release -> 
unbind may happen here.
Now mmget is called, fops_release -> unbind has NO chance to be called, 
so ioasid can NOT be freed.

Thanks

