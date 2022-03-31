Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10C14ED7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiCaKRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiCaKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:17:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFDAD92
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:15:16 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KTfLR6pDZz1GDHw;
        Thu, 31 Mar 2022 18:14:55 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 18:15:09 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 31 Mar
 2022 18:15:09 +0800
Message-ID: <c5a918fd-5700-267d-3159-6a034cce0a73@huawei.com>
Date:   Thu, 31 Mar 2022 18:15:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: module: Add all unwind tables when load module
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <alexander.sverdlin@nokia.com>, <ardb@kernel.org>,
        <linus.walleij@linaro.org>, <nico@fluxnic.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220325011252.55844-1-chenzhongjin@huawei.com>
 <YkVQXPYkae41B7Z2@shell.armlinux.org.uk>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YkVQXPYkae41B7Z2@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hi Russell,

Thanks for comment! I've pushed v2 patch with your advises.

>>   
>> -	memset(maps, 0, sizeof(maps));
>> +	INIT_LIST_HEAD(&table_list->mod_list);
>> +	mod->arch.init_table = NULL;
>>   
>>   	for (s = sechdrs; s < sechdrs_end; s++) {
>> -		const char *secname = secstrs + s->sh_name;
>> +		const unsigned int sectype = s->sh_type;
> Please loose this local variable.

Also I moved "txtname" inside func params.

+		const char *txtname = strcmp(".ARM.exidx", secname) == 0 ?
+				".text" : secname + strlen(".ARM.exidx");
+		const Elf_Shdr *txt_sec = find_mod_section(hdr, sechdrs, txtname);

 >>>

+		const Elf_Shdr *txt_sec = find_mod_section(hdr, sechdrs,
+				strcmp(".ARM.exidx", secname) ?
+				secname + strlen(".ARM.exidx") : ".text");


