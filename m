Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2D4EE5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbiDACMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbiDACMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:12:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557371C6ECA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:10:43 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KV3SX15jmzBrtm;
        Fri,  1 Apr 2022 10:06:36 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 10:10:41 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 10:10:41 +0800
Message-ID: <05f01c58-d592-84ce-dd46-e9b281a82d47@huawei.com>
Date:   Fri, 1 Apr 2022 10:10:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ARM: module: Add all unwind tables when load module
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <alexander.sverdlin@nokia.com>, <ardb@kernel.org>,
        <linus.walleij@linaro.org>, <nico@fluxnic.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220331090909.113387-1-chenzhongjin@huawei.com>
 <YkWEpC4R1roLwlN/@shell.armlinux.org.uk>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YkWEpC4R1roLwlN/@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very appreciate for your patient review! For my first patch it really 
helps a lot :D

v3 update pushed now.

Sorry forgot CC for last mail.


On 2022/3/31 18:38, Russell King (Oracle) wrote:
> On Thu, Mar 31, 2022 at 05:09:09PM +0800, Chen Zhongjin wrote:
>>   	for (s = sechdrs; s < sechdrs_end; s++) {
>>   		const char *secname = secstrs + s->sh_name;
>> +		const Elf_Shdr *txt_sec = find_mod_section(hdr, sechdrs,
>> +				strcmp(".ARM.exidx", secname) ?
>> +				secname + strlen(".ARM.exidx") : ".text");
> In addition to my comments on the above...
>
>>   
>> -		if (!(s->sh_flags & SHF_ALLOC))
>> +		if (!(s->sh_flags & SHF_ALLOC) ||
>> +			s->sh_type != ELF_SECTION_UNWIND)
> Please align "s->sh_type" with the ! on the line above (don't use a tab
> for this!)
>
>>   			continue;
>>   
>> -		if (strcmp(".ARM.exidx.init.text", secname) == 0)
>> -			maps[ARM_SEC_INIT].unw_sec = s;
>> -		else if (strcmp(".ARM.exidx", secname) == 0)
>> -			maps[ARM_SEC_CORE].unw_sec = s;
>> -		else if (strcmp(".ARM.exidx.exit.text", secname) == 0)
>> -			maps[ARM_SEC_EXIT].unw_sec = s;
>> -		else if (strcmp(".ARM.exidx.text.unlikely", secname) == 0)
>> -			maps[ARM_SEC_UNLIKELY].unw_sec = s;
>> -		else if (strcmp(".ARM.exidx.text.hot", secname) == 0)
>> -			maps[ARM_SEC_HOT].unw_sec = s;
>> -		else if (strcmp(".init.text", secname) == 0)
>> -			maps[ARM_SEC_INIT].txt_sec = s;
>> -		else if (strcmp(".text", secname) == 0)
>> -			maps[ARM_SEC_CORE].txt_sec = s;
>> -		else if (strcmp(".exit.text", secname) == 0)
>> -			maps[ARM_SEC_EXIT].txt_sec = s;
>> -		else if (strcmp(".text.unlikely", secname) == 0)
>> -			maps[ARM_SEC_UNLIKELY].txt_sec = s;
>> -		else if (strcmp(".text.hot", secname) == 0)
>> -			maps[ARM_SEC_HOT].txt_sec = s;
>> +		if (txt_sec) {
>> +			struct unwind_table *table =
>> +				unwind_table_add(s->sh_addr,
>> +						s->sh_size,
>> +						txt_sec->sh_addr,
>> +						txt_sec->sh_size);
> blank line here please.
>
>> +			list_add(&table->mod_list, &unwind_list->mod_list);
> and here.
>
> Otherwise, looks good. Thanks.
>

