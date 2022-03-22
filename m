Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963184E3798
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiCVDiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiCVDiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:38:06 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A17130;
        Mon, 21 Mar 2022 20:36:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V7tw9PW_1647920194;
Received: from 30.240.116.16(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V7tw9PW_1647920194)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Mar 2022 11:36:35 +0800
Message-ID: <57665787-66f1-1d5a-a190-e73f4b941dce@linux.alibaba.com>
Date:   Tue, 22 Mar 2022 11:36:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [BUG] kernel side can NOT trigger memory error with einj
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "myron.stowe@redhat.com" <myron.stowe@redhat.com>,
        "Brown, Len" <len.brown@intel.com>
References: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
 <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
 <f93a5532-3e07-edf4-38ca-142a0f1d78d7@linux.alibaba.com>
 <1421c3ac3d3c4438a6ff18f193f8a41c@intel.com>
 <78cefd4c-f735-2ec4-0c09-35c8191280c5@linux.alibaba.com>
 <87wngoc9ff.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <87wngoc9ff.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/21 AM10:43, Huang, Ying 写道:
> Shuai Xue <xueshuai@linux.alibaba.com> writes:
> 
>> 在 2022/3/18 AM12:57, Luck, Tony 写道:
>>>> -       rc = apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR);
>>>> +       ptr = kmap(pfn_to_page(pfn));
>>>> +       tmp = *(ptr + (param1 & ~ PAGE_MASK));
>>>
>>> That hack works when the trigger action is just trying to access the injected
>>> location. But on Intel platforms the trigger "kicks" the patrol scrubber in the
>>> memory controller to access the address. So the error is triggered not by
>>> an access from the core, but by internal memory controller access.
>>>
>>> This results in a different error signature (for an uncorrected error injection
>>> it will be a UCNA or SRAO in Intel acronym-speak).
>>
>> As far as I know, APEI only defines five injection instructions, ACPI_EINJ_READ_REGISTER,
>> ACPI_EINJ_READ_REGISTER_VALUE, ACPI_EINJ_WRITE_REGISTER, ACPI_EINJ_WRITE_REGISTER_VALUE and
>> ACPI_EINJ_NOOP. ACPI_EINJ_TRIGGER_ERROR action should run one of them, I don't see
>> any of them will kick the patrol scrubber. For example, trigger with ACPI_EINJ_READ_REGISTER:
>>
>> apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR)
>>     __apei_exec_run	// ins=0
>>         => apei_exec_read_register
>>             => apei_read
>>                 => acpi_os_read_memory
>>                     => acpi_map_vaddr_lookup    /* lookup VA of PA from acpi_ioremap */
>>                     => acpi_os_ioremap
>> 		    => acpi_os_read_iomem
>> 			=> *(u32 *) value = readl(virt_addr);
>>
>> As we can see, the error is triggered by access from the core. However, the physical
>> address can NOT be mapped by acpi_os_ioremap.
>>
>> If I missed anything, please let me know. Thank you very much.


> If you write a device register, the device can kick the patrol scrubber
> for you.  This device behavior needs not to be defined in APEI spec.

I see, thank you. In our platform, patrol scrubber triggers deferred error, and the fatal
error is triggered by an access from CPU.

> As the name suggested, ACPI_EINJ_READ/WRITE_REGISTER are used to
> read/write device registers via iomem.  They aren't used to read/write
> normal physical memory.  If that's needed, you can try some other method
> I guess.

I think so, should we add new injection instructions to address this problem,
e.g. ACPI_EINJ_READ_MEMORY implemented by kmap?

By the way, commit fdea163d8c17 ("ACPI, APEI, EINJ, Fix resource conflict on some
machine") removes the injecting memory address range which conflits with
regular memory from trigger table resources. It make sense when calling
apei_resources_request(). **However, the actual mapping operation in
apei_exec_pre_map_gars() with trigger_ctx. And the conflit physical address
is still in trigger_ctx.**

		// drivers/acpi/apei/einj.c: __einj_error_trigger
		trigger_param_region = einj_get_trigger_parameter_region(
			trigger_tab, param1, param2);
		if (trigger_param_region) {
			...
		}

If the trigger_param_region is valid which means that the triggered address is
ACPI_ADR_SPACE_SYSTEM_MEMORY, then we should not use apei_exec_pre_map_gars to
map like a register, right? If we have ACPI_EINJ_READ_MEMORY, then we can directly
run ACPI_EINJ_TRIGGER_ERROR through ACPI_EINJ_READ_MEMORY.

Best Regards
Shuai






