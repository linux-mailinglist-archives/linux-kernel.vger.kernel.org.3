Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330984DBD49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbiCQC6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347012AbiCQC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:57:48 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018EF12AD8;
        Wed, 16 Mar 2022 19:56:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V7PgVAo_1647485788;
Received: from 30.240.113.214(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V7PgVAo_1647485788)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 10:56:29 +0800
Message-ID: <f93a5532-3e07-edf4-38ca-142a0f1d78d7@linux.alibaba.com>
Date:   Thu, 17 Mar 2022 10:56:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [BUG] kernel side can NOT trigger memory error with einj
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        graeme.gregory@linaro.org, will.deacon@arm.com,
        myron.stowe@redhat.com, len.brown@intel.com, ying.huang@intel.com
References: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
 <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
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

Hi, Tony,

Thank you for your quick reply.

在 2022/3/17 AM1:29, Luck, Tony 写道:
> On Tue, Mar 08, 2022 at 01:19:12PM +0800, Shuai Xue wrote:
>> Hi folks,
>>
>> If we inject an memory error at physical memory address, e.g. 0x92f033038,
>> used by a user space process:
>>
>> 	echo 0x92f033038 > /sys/kernel/debug/apei/einj/param1
>> 	echo 0xfffffffffffff000 > /sys/kernel/debug/apei/einj/param2
>> 	echo 0x1 > /sys/kernel/debug/apei/einj/flags
>> 	echo 0x8 > /sys/kernel/debug/apei/einj/error_type
>> 	echo 1 > /sys/kernel/debug/apei/einj/error_inject
>>
>> Then the following error will be reported in dmesg:
>>
>>     ACPI: [Firmware Bug]: requested region covers kernel memory @ 0x000000092f033038
>>
>> After digging into einj trigger interface, I think it's a kernel bug.
> 
> I think you are right. This isn't the first bug where Linux tries
> to validate addresses supplied by EINJ for Linux to read/write.
> 
> I hadn't come across it because I almost always set:
> 
> # echo 1 > notrigger
> 
> so that I can have some application, or function in the kernel
> trigger the error. Instead of running the EINJ trigger action
> to make it happen right away.

Haha, I know your great test suit, ras-tools. All cases are not triggered
by EINJ tigger action. I have learned a lot from it.

>> I am wondering that should we use kmap to map RAM in acpi_map or add a
>> another path to address this issue? Any comment is welcomed.
> 
> Perhaps just drop the sanity checks? Just trusting the BIOS? Sounds
> radical, but this is validation code where the user is deliberately
> injecting errors. If there are BIOS bugs, then people doing validation
> may be well positioned to find the BIOS people to make them fix
> things.
> 
> Problem with this approach is that EINJ calls into the APEI code
> that is used for other things besides error injection for validation.
> So a blanket removal of sanity checks wouldn't be a good idea.

Agree. A blanket removal of APEI sanity checks is not a good idea. How about
requesting memory with kmap instead APEI API only in __einj_error_trigger()?
Then we would not break the validation of APEI code and could trigger the
injected error.

I have provided a rough code in last mail.

> A hacking way to address this issue is that map RAM memory with kmap
> instead of apei_exec_pre_map_gars, and read it directly instead of
> apei_exec_run.
> -       rc = apei_exec_pre_map_gars(&trigger_ctx);
> -       if (rc)
> -               goto out_release;
> +       volatile long *ptr;
> +       long tmp;
> +       unsigned long pfn;
> +       pfn = param1 >> PAGE_SHIFT;
>
> -       rc = apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR);
> +       ptr = kmap(pfn_to_page(pfn));
> +       tmp = *(ptr + (param1 & ~ PAGE_MASK));
>
> -       apei_exec_post_unmap_gars(&trigger_ctx);


Best Regards.
Shuai
