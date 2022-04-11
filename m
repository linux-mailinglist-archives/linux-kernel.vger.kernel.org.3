Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB94FBEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbiDKOXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347448AbiDKOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:23:08 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22931DF5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649686850;
        bh=PMJEWnBJEevCLXSBOAMnHQrSxTYZtwjQrgG2Fk8vdfU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=tNeV9Vky+I2voL6UPI4RB7Vg3pRbwUplty4VcXnZdXrqCTsIlFWcKij1O/BMQhWC3
         zw5ZT3IPB8ai5R7KdQFxTl8nAxh3p3sG0/6ORcXUn398YwJYGP+l2EYlEUuUbeUDjC
         nHD9s0hXEfVSYhrC/+zCXPxuIZDAuEzKEiGNLgSs=
Received: from [192.168.0.110] ([36.57.147.99])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 52D8364F; Mon, 11 Apr 2022 22:20:45 +0800
X-QQ-mid: xmsmtpt1649686845tjojd7udb
Message-ID: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieHPHoHPzlRiET1OZCkc0WHmzMcbYdy3YLswmmjhd0B0r17XprQF
         lQ9f9emH5ARFpozrW6m5MhEh4335PkSWivTHd4rS4/5gDdjzoNGU9ssatGGUftnOUpWtjb1ZXkT9
         ooh+gni2Hd9EDQ/WiWNZEMBnJnvHfLHlKWepbEOD+ontczw8BVK1N1Tc1M5CLRUDtAy9PyzUIcYV
         Bnt3F/CWa8da19xLoeDILU790qmUcgaWP4HX83fQtnD8t/sFaaqgESZccpb4ynZH4/4ABJ6rCFyc
         oAONlDEIkY1aUeVTfR2InNrk4MTHZfN+ireEerWAZhmPCujv0YtWwdi9dGPPT22wnUdTLb6lF2YG
         Qt4oeEgPrShpiauRtm1Z85CeQ4MvxqEoh6ANy+oJwHk0Pk0KXxeREkdak1GpVRsdofrMT02J3Il0
         TpHoaBLdlfx+t/vXDJz9YCRuh22Vaf39caxAvmz+z8FbfFfDcv96iW8o49NrEN43OuOnDjWJLAGg
         Iy72RnVVsijpnqKIhSrLKmkuQTJ1KdB/moKqjZ65s2NkGuDcBw/mfu/ilppNO2Kxq4V9HU9ppptq
         Qh8v9mesCHLhatJD7GtjcT/ulR5fegh1wfUQJsgrKTXnhmROZ6O2C6Kladi3UU2bTwvvqfZcxCzv
         qb/7UkMT5cwxHO/G7jNVGnLjcsGi29Pb50VwXfd7TuSQ4a6HdHriqrPj5AIa+7K91fz6Gx0NF1BB
         4N+Ly6pvy5tkJsX3ezC+xsoxE+6/g3WZXA34p2iZVVjP67+Vib/8+X58UtkEwIttLvogVFrI8dj5
         KNchLOd8787rXQ9GCAFt1hpIVO2BIucSMRfODeX4weGH/ODINpnYXo3fejoNhgUph/7VCmHRcID0
         ysuaFNTLIIf1v2GA0pYZjEm5GTAyW9H4+5mFrJTvNWtG9yYb2pPl4FmLRZGmdFxIHZNF0cz7Z7Ll
         YZ2UtIQIu7WNfTXs6/dw==
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
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <11c9764b-c9bf-4521-b3e8-58250059ae2b@foxmail.com>
Date:   Mon, 11 Apr 2022 22:20:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/11 下午10:10, Dave Hansen wrote:
> On 4/11/22 07:00, Zhangfei Gao wrote:
>> with this patchset, each time after  sbin/nginx, ioasid is freed
>> immediately. lynx test will alloc the same ioasid=1.
> That doesn't seem right.  Isn't 'sbin/nginx' still running when lynx
> runs?  How can they get the same ioasid?
Yes, sbin/nginx is still running,
root        3228  0.0  0.0  31316 13476 ?        Ssl  12:50   0:00 
nginx: master process sbin/nginx
nobody      3230  0.0  0.0  32296 16456 ?        Sl   12:50   0:00 
nginx: worker process

Since ioasid is freed, so lynx can get the same ioasid.
>
> This sounds like a refcounting problem, like that the ioasid wasn't
> properly refcounted as nginx forked into the background.
Yes, in checking, thanks
and this patchset removed the old refcount.
>
>> To verify, hack comment mm_pasid_drop in __mmput will make the issue
>> disappear.
>>
>> log: after sbin/nginx.
>> [   96.526730] Call trace:
>> [   96.526732]  dump_backtrace+0xe4/0xf0
>> [   96.526741]  show_stack+0x20/0x70
>> [   96.526744]  dump_stack_lvl+0x8c/0xb8
>> [   96.526751]  dump_stack+0x18/0x34
>> [   96.526754]  ioasid_free+0xdc/0xfc
>> [   96.526757]  mmput+0x138/0x160
>> [   96.526760]  do_exit+0x284/0x9d0
>> [   96.526765]  do_group_exit+0x3c/0xa8
>> [   96.526767]  __wake_up_parent+0x0/0x38
>> [   96.526770]  invoke_syscall+0x4c/0x110
>> [   96.526775]  el0_svc_common.constprop.0+0x68/0x128
>> [   96.526778]  do_el0_svc+0x2c/0x90
>> [   96.526781]  el0_svc+0x30/0x98
>> [   96.526783]  el0t_64_sync_handler+0xb0/0xb8
>> [   96.526785]  el0t_64_sync+0x18c/0x190
> Is there nothing before this call trace?  Usually there will be at least
> some warning text.
I added dump_stack() in ioasid_free.

Thanks

