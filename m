Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05384E1BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 14:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiCTNN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245124AbiCTNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:13:26 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108A1F630;
        Sun, 20 Mar 2022 06:12:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V7f.E1k_1647781918;
Received: from 30.240.112.73(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V7f.E1k_1647781918)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Mar 2022 21:12:00 +0800
Message-ID: <78cefd4c-f735-2ec4-0c09-35c8191280c5@linux.alibaba.com>
Date:   Sun, 20 Mar 2022 21:11:58 +0800
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
        "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "myron.stowe@redhat.com" <myron.stowe@redhat.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
 <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
 <f93a5532-3e07-edf4-38ca-142a0f1d78d7@linux.alibaba.com>
 <1421c3ac3d3c4438a6ff18f193f8a41c@intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1421c3ac3d3c4438a6ff18f193f8a41c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/18 AM12:57, Luck, Tony 写道:
>> -       rc = apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR);
>> +       ptr = kmap(pfn_to_page(pfn));
>> +       tmp = *(ptr + (param1 & ~ PAGE_MASK));
> 
> That hack works when the trigger action is just trying to access the injected
> location. But on Intel platforms the trigger "kicks" the patrol scrubber in the
> memory controller to access the address. So the error is triggered not by
> an access from the core, but by internal memory controller access.
> 
> This results in a different error signature (for an uncorrected error injection
> it will be a UCNA or SRAO in Intel acronym-speak).

As far as I know, APEI only defines five injection instructions, ACPI_EINJ_READ_REGISTER,
ACPI_EINJ_READ_REGISTER_VALUE, ACPI_EINJ_WRITE_REGISTER, ACPI_EINJ_WRITE_REGISTER_VALUE and
ACPI_EINJ_NOOP. ACPI_EINJ_TRIGGER_ERROR action should run one of them, I don't see
any of them will kick the patrol scrubber. For example, trigger with ACPI_EINJ_READ_REGISTER:

apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR)
    __apei_exec_run	// ins=0
        => apei_exec_read_register
            => apei_read
                => acpi_os_read_memory
                    => acpi_map_vaddr_lookup    /* lookup VA of PA from acpi_ioremap */
                    => acpi_os_ioremap
		    => acpi_os_read_iomem
			=> *(u32 *) value = readl(virt_addr);

As we can see, the error is triggered by access from the core. However, the physical
address can NOT be mapped by acpi_os_ioremap.

If I missed anything, please let me know. Thank you very much.

Best Regards,
Shuai


