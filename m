Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2839D4FC00A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbiDKPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbiDKPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:16:04 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DF3152B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649690024;
        bh=28M5lhAtnZOyUfE1LzLlkbiL5y+pZYDo9mGQ5Q/tvIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BSDt4mSkN4hjoijsc/dLY21pilM9yAooR3R/aAzy4aVTANA+0E964bY1+6pRulIYt
         2pFuuU3I8YZ0VZSS0A25BFQ2f+OAvOc179IKE7pnFcPwehHluNpeveXLWfnFAbmesh
         E10vnN6dpMMPeu1X1xXNodEuh1vI5U/AGSbLDz24=
Received: from [192.168.0.110] ([36.57.147.99])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 3681BC5A; Mon, 11 Apr 2022 23:13:40 +0800
X-QQ-mid: xmsmtpt1649690020ta5upzabz
Message-ID: <tencent_4D5A6753559A4D835707D1A06484CF369606@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9LEcvCo3XM0873Nsg49FRdhT228Ob+jseg4lPImmFyJDw0dyjq2
         1inUfGtSQpjOKkT1c+/th+IVe6qc1RFG/LSh8Gbi2z1qDOdz3I2UVGjj+pvEkcsElir20rb4OLvJ
         OG9mIlkZ33dyfiBswIrAx/A/guTUsRWelXSPyZlSyJSPA1tCro61SVyI2n8F9cPCu9x2CL4rI92N
         MhZvRHV2eiUjqIbW84A9EbMPX5nyxybB/D+lHI0eHN/w21qMD2xsoNsU/iNp3uATraiiKXf3KdfX
         QDUbEQKSDbof/qj6hx2eOhgw/Uy4hIwiggh/FoHURVSMScsEirhtJhhLfIvk75qIwNGO5dl5du8c
         O9MbA3imrNUtODhcDVzJQFk6zzwk8VhyVqDq1/e+7uZJycBxmzynGJk3mJfOgoWODYIKw8cSopLG
         9CTxaHU7MCpKG/gxksyFzWF2K8a0sppFTt3Pd9Tfrl8+Y1V9/k+5AmzD56hw1ztJ8kKtVo+du28J
         IV+dtyWKUFyaOUPJZH3MvL43gx9tDsrsFZ8LIEobkhqLu55s0PsGDjhXGuX+wCFTw/5+8EIIzVoS
         BtSWlJcwNvvOOtIUYyH6YHmPtPDsp0TUgae+XFxH4wBb0TrCI1k3e0Bu81qbTHwkLTCPT1ZbKs4F
         GuBegEHaryk2Q0nhvGrG5yOtPiSKQW3ECBpkglLyopCpmEZGGmKxwx0YhpoZhew1X9clMipXktu1
         Vs0GZta3wjJHsyKF0DLdntrRPfCGmFuCQQQEiRyH27uStAiqA6uddJfy/ABNgJWOgXu4Sqneh5sw
         PqWnJccEn8uEHFcZ+xqUiOPDBQDkN1xxopJtBO1NdW0Ct2aIZYjLO/H7/smEiIdJ3NYmYGTXzbKB
         Fb3eAQKcdT6rHg8JL34NOc3QLWm9wzn2cGwKQaWKIPA5Cz20MX/F9K4l/W8fTe/RPfdkQrBNoGnl
         h/YSHY29w=
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
X-OQ-MSGID: <0da0fea2-2b19-a9b6-910a-122ff57cb8f5@foxmail.com>
Date:   Mon, 11 Apr 2022 23:13:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
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
Sure, will add some trace tomorrow.

Thanks Dave


