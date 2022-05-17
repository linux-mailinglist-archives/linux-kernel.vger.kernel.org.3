Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF852A88C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351196AbiEQQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351170AbiEQQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:48:08 -0400
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2FB94EF4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:48:05 -0700 (PDT)
Received: from c-24-16-96-21.hsd1.wa.comcast.net ([24.16.96.21] helo=srivatsab-a02.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1nr0Md-000E5Y-3n; Tue, 17 May 2022 12:48:03 -0400
Subject: Re: [PATCH v3] arm64: paravirt: Use RCU read locks to guard
 stolen_time
To:     Will Deacon <will@kernel.org>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Juergen Gross <jgross@suse.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Murali Nalajala <quic_mnalajal@quicinc.com>
References: <20220513174654.362169-1-quic_eberman@quicinc.com>
 <c24e405e-b5f9-d2f7-a629-1ee1beab3681@csail.mit.edu>
 <20220517085418.GA3169@willie-the-truck>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <1dc10835-e302-8ae7-c256-efb0c420f35a@csail.mit.edu>
Date:   Tue, 17 May 2022 09:48:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220517085418.GA3169@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 1:54 AM, Will Deacon wrote:
> On Fri, May 13, 2022 at 04:32:53PM -0700, Srivatsa S. Bhat wrote:
>> On 5/13/22 10:46 AM, Elliot Berman wrote:
>>> From: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>>>

[...]

>>>  static int stolen_time_cpu_down_prepare(unsigned int cpu)
>>>  {
>>> +	struct pvclock_vcpu_stolen_time *kaddr = NULL;
>>>  	struct pv_time_stolen_time_region *reg;
>>>  
>>>  	reg = this_cpu_ptr(&stolen_time_region);
>>>  	if (!reg->kaddr)
>>>  		return 0;
>>>  
>>> -	memunmap(reg->kaddr);
>>> -	memset(reg, 0, sizeof(*reg));
>>> +	kaddr = rcu_replace_pointer(reg->kaddr, NULL, true);
>>> +	synchronize_rcu();
>>> +	memunmap(kaddr);
>>>  
>>
>> The original code used to memset the stolen time region, but this
>> patch seems to drop it. Was that change intentional?
> 
> 'struct pv_time_stolen_time_region' only has one field ('kaddr'), which
> we're now clearing with rcu_replace_pointer() so the memset doesn't make
> sense.
> 

Ah right, never mind :)

Thank you!

Regards,
Srivatsa
