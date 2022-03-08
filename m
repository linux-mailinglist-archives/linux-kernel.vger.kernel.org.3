Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599334D13E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiCHJwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiCHJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:52:40 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D67241F8D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:51:44 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KCVr23Nqxz9sXd;
        Tue,  8 Mar 2022 17:48:02 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 17:51:42 +0800
Subject: Re: [PATCH -next] powerpc/spufs: Fix build warning when
 CONFIG_PROC_FS=n
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "jk@ozlabs.org" <jk@ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220305123116.26828-1-yuehaibing@huawei.com>
 <860002a4-4e52-c399-fda6-054fa64df3ce@csgroup.eu>
 <CAK8P3a2p+Yryg1y5h=kTLP72WGYc2d4qctFuW+opR6F=1uYJPw@mail.gmail.com>
 <16b319ec-3d87-7ac1-6bc3-d6679e639426@csgroup.eu>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <7562505a-24ff-eac7-34ea-83cea5988fd0@huawei.com>
Date:   Tue, 8 Mar 2022 17:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <16b319ec-3d87-7ac1-6bc3-d6679e639426@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
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

On 2022/3/7 21:30, Christophe Leroy wrote:
> 
> 
> Le 07/03/2022 à 14:10, Arnd Bergmann a écrit :
>> On Sun, Mar 6, 2022 at 9:04 PM Christophe Leroy
>> <christophe.leroy@csgroup.eu> wrote:
>>> Le 05/03/2022 à 13:31, YueHaibing a écrit :
>>>> arch/powerpc/platforms/cell/spufs/sched.c:1055:12: warning: ‘show_spu_loadavg’ defined but not used [-Wunused-function]
>>>>    static int show_spu_loadavg(struct seq_file *s, void *private)
>>>>               ^~~~~~~~~~~~~~~~
>>>>
>>>> Mark this as __maybe_unused to fix this.
>>>
>>> Marking it as __maybe_unused doesn't fix it. It just pushes the dust
>>> under the carpet.
>>>
>>> proc_create_single macro should be fix to avoid that warning.
>>
>> We discussed that when proc_create_single() was introduced, but ended up
>> not doing it that way because there were already a lot of files using an #ifdef
>> around the function definitions. To change it back, one would have to audit
>> every user of proc_create_single() and remove the #ifdefs.
>>
> 
> Fair enough.
> 
> In that case, I'd prefer to go for a #ifdef as well for 
> show_spu_loadavg() instead of going for a __maybe_unused flag.

Ok, will do that in v2.
> 
> Christophe
> 
