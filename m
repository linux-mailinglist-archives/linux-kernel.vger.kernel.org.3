Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7F50616F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbiDSBFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiDSBFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:05:44 -0400
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FACA286EF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650330179;
        bh=yQw6ERdnn3s8Fdav1zgTS27N91rjx8DazpHXI6e3k9g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=wX9u6xnU+1iU+RQWEeun9aJ9e0cu4jgZXT5HiunHslNoszXVkxD5tspBoz/oGw8JJ
         U7JkwdLi1Y7TtDD7V4xC27RSkWmWyhEEhlQNSvrME0oKhjWH6OqB3h/Pu8I83MAVVl
         8T0bqwywbYMlJ4UIkhTL7TbaGkbI1i5bv/gr1R8I=
Received: from [IPv6:240e:362:460:400:41fe:9861:6ad0:79fe] ([240e:362:460:400:41fe:9861:6ad0:79fe])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id B6A6E5A; Tue, 19 Apr 2022 09:02:54 +0800
X-QQ-mid: xmsmtpt1650330174tqi25minl
Message-ID: <tencent_2EB84D1A69750D821D1A8324112BDBCE6A08@qq.com>
X-QQ-XMAILINFO: Nt+cTZuZCMyik92w9EY9stqsGSh/CDo9X0G+qzdUtdySpM/m5C070YTOea1dBJ
         +2Bs3QwRxH60eS6D7F55+CEt7KqH6xFEoI+us5qSfF6MTwwKKMLoDplJJxWPzhxL5PtsjJYIcABA
         tyS4ORs0Bh/+sQe/P8QvmDPxqZBvsjzrpGRdERBJRB16184gIJixl7GwBBe5xeXNwLssJf6oWeU1
         pzeozIytl6psXz6SqUVdsbEGdwzR/2xDAa+cVTTrwZlXfM+VLY5KtTHfgqSsvqGtlV/81EjzdeTi
         RtVsm15vD6fgfbB+g2u5KRIuQXPJH7YuyeWSXdRrZuWk/jUkY47XnjBxy71UjGppv+vWxByeCXcp
         C6ikojnvEotPwJBE2N8ZGP70yEOzEzhUVgvP4RbrQO4cy9ttzMrO4CmIhUwoRC2gvo81J4J8yMu/
         08KS4CfdPd3plqPxrap8bvkZUo8P7wHwiuoHlVhqD5efu8yn37EH28CDuK6OfpnawbgpHeXGIsjy
         QrVPvheS0keXO6ngqUT3xL2r/351F/FKZ1ff1PC1IEzq6MCajzFU6n9V3pBfiw1KGywAvJMmlvWd
         8pV6RywoXRqfVZY4RloXNrf3Li6qQ0+UV65yxTC0X6Fmm96V25Je7wpSn7EJFiaIzPbIOgBCcMIA
         QzQFxTQuajKPH2t7ESXO/b0K4WrwBJU4M8MFdp7ZIXbdTaviwruDwb49si0xunA++m7pHLOYIR/F
         O9OmQ3Q3Yn8YDe62mwY51wrbiCDgi4doT+rUPIc7QJ5fRoKAhSoUQ5ezsp8/5xLKk7rLGQG9WRNi
         662Yx4nqx01lztk+5WARBDC8GGUqSjRrpekBEj01iay773/sptva6nTwTwhAzA82irt2ELAf0Usw
         RB2kCusSp/lydO6n2m3C6XwV0pBGSaCeyLpGtzi1cGqiQ/BlFIKVcYNvV0yeEI1KesL7VanIT6jN
         SctJrB4XE=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        jean-philippe <jean-philippe@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
 <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
 <20220418111456.2f1a1285@jacob-builder>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <16001fe9-34b1-e3aa-9aa6-ebcc9793c966@foxmail.com>
Date:   Tue, 19 Apr 2022 09:02:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220418111456.2f1a1285@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/19 上午2:14, Jacob Pan wrote:
> Hi zhangfei.gao@foxmail.com,
>
> On Sat, 16 Apr 2022 09:43:07 +0800, "zhangfei.gao@foxmail.com"
> <zhangfei.gao@foxmail.com> wrote:
>
>> On 2022/4/16 上午5:00, Jacob Pan wrote:
>>> Hi zhangfei.gao@foxmail.com,
>>>
>>> On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
>>> <zhangfei.gao@foxmail.com> wrote:
>>>   
>>>>>>> A PASID might be still used even though it is freed on mm exit.
>>>>>>>
>>>>>>> process A:
>>>>>>> 	sva_bind();
>>>>>>> 	ioasid_alloc() = N; // Get PASID N for the mm
>>>>>>> 	fork(): // spawn process B
>>>>>>> 	exit();
>>>>>>> 	ioasid_free(N);
>>>>>>>
>>>>>>> process B:
>>>>>>> 	device uses PASID N -> failure
>>>>>>> 	sva_unbind();
>>>>>>>
>>>>>>> Dave Hansen suggests to take a refcount on the mm whenever binding
>>>>>>> the PASID to a device and drop the refcount on unbinding. The mm
>>>>>>> won't be dropped if the PASID is still bound to it.
>>>>>>>
>>>>>>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
>>>>>>> allocation and free it on mm exit")
>>>>>>>   
>>> Is process A's mm intended to be used by process B? Or you really should
>>> use PASID N on process B's mm? If the latter, it may work for a while
>>> until B changes mapping.
>>>
>>> It seems you are just extending the life of a defunct mm?
>>   From nginx code, the master process init resources, then fork daemon
>> process to take over,
>> then master process exit by itself.
>>
>> src/core/nginx.c
>> main
>> ngx_ssl_init(log);    -> openssl engine -> bind_fn -> sva_bind()
>> ngx_daemon(cycle->log)
>>
>> src/os/unix/ngx_daemon.c
>> ngx_daemon(ngx_log_t *log)
>> {
>>        int  fd;
>>
>>        switch (fork()) {
>>        case -1:
>>            ngx_log_error(NGX_LOG_EMERG, log, ngx_errno, "fork() failed");
>>            return NGX_ERROR;
>>
>>        case 0:
>>           // the fork daemon process
>>            break;
>>
> Does this child process call sva_bind() again to get another PASID? Or it
> will keep using the parent's PASID for DMA?
The master process call sva_bind (PASID A), fork daemon process, then exit.

The daemon process does not call sva_bind again, only for managing 
worker processes.

The worker process will call sva_bind for new PASID (B), for real 
transaction.


The worker process will free the PASID (B) when worker process exit like 
nginx quit.

nginx -s quit does not free PASID A via callback, which may should be 
freed by signal handler in engine itself, still in check.

Thanks


