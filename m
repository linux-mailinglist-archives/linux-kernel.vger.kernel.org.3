Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812D4571CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiGLOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiGLOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:35:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0D24F12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:35:28 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lj3Cg4LvdzlVpR;
        Tue, 12 Jul 2022 22:33:51 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 22:35:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 22:35:24 +0800
Message-ID: <8efb2c6f-f00a-ea02-d5ae-ac454bb721f5@huawei.com>
Date:   Tue, 12 Jul 2022 22:35:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "John Stultz" <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>
References: <20220705083934.3974140-1-saravanak@google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220705083934.3974140-1-saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/5 16:39, Saravana Kannan wrote:
> The uevents generated for an amba device need PID and CID information
> that's available only when the amba device is powered on, clocked and
> out of reset. So, if those resources aren't available, the information
> can't be read to generate the uevents. To workaround this requirement,
> if the resources weren't available, the device addition was deferred and
> retried periodically.
>
> However, this deferred addition retry isn't based on resources becoming
> available. Instead, it's retried every 5 seconds and causes arbitrary
> probe delays for amba devices and their consumers.
>
> Also, maintaining a separate deferred-probe like mechanism is
> maintenance headache.
>
> With this commit, instead of deferring the device addition, we simply
> defer the generation of uevents for the device and probing of the device
> (because drivers needs PID and CID to match) until the PID and CID
> information can be read. This allows us to delete all the amba specific
> deferring code and also avoid the arbitrary probing delays.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> v1 -> v2:
> - Dropped RFC tag
> - Complete rewrite to not use stub devices.
>
> v2 -> v3:
> - Flipped the if() condition for hard-coded periphids.
> - Added a stub driver to handle the case where all amba drivers are
>    modules loaded by uevents.
> - Cc Marek after I realized I forgot to add him.
>
> v3 -> v4:
> - Finally figured out and fixed the issue reported by Kefeng (bus match
>    can't return an error other than -EPROBE_DEFER).
> - I tested the patch on "V2P-CA15" on qemu
> - Marek tested v3, but that was so long ago and the rebase wasn't clean,
>    so I didn't include the tested-by.
>
> Marek/Kefeng,
>
> Mind giving a Tested-by?

Hi Saravana, I tested on my qemu, and previous panic[1] disappeared, so

Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>

[1] 
https://lore.kernel.org/linux-arm-kernel/CAGETcx8RLor0JcboBuMrB96xUot14P1CAcqoen7ZHnYRi7KMEQ@mail.gmail.com/

