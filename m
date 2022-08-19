Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C765999B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348319AbiHSKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348304AbiHSKUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:20:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD0BEF9DF;
        Fri, 19 Aug 2022 03:20:09 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M8Hn24YPHz67h3l;
        Fri, 19 Aug 2022 18:19:50 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 12:20:07 +0200
Received: from [10.195.34.98] (10.195.34.98) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 11:20:06 +0100
Message-ID: <1a5eb773-d339-512f-7c5d-7ef72edfdc2a@huawei.com>
Date:   Fri, 19 Aug 2022 11:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH PoC 1/3] ACPI / PNP: Don't add enumeration_by_parent
 devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
 <1660649244-146842-2-git-send-email-john.garry@huawei.com>
 <CAHp75Vc4vT==hB=svhDBhSpNFCQXwzZ1RMxy4mQspFhmSjQ03g@mail.gmail.com>
 <366fd6dd-a37b-c7ec-fdf3-48f8a8024834@huawei.com>
 <CAHp75Vd-6mfK=Or4MjXswUZsovHhMyDDJCv8srBH70f24MGvpA@mail.gmail.com>
In-Reply-To: <CAHp75Vd-6mfK=Or4MjXswUZsovHhMyDDJCv8srBH70f24MGvpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.98]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 10:59, Andy Shevchenko wrote:
>>>> The hisi_lpc driver also creates a platform device serial device for uart,
>>>> which is the actual uart which we want to use - see
>>>> hisi_lpc_acpi_add_child(). That function does not check
>>>> physical_node_count value, but acpi_create_platform_device() does check it.
>>>> So if we were to move hisi_lpc_acpi_add_child() across to use
>>>> acpi_create_platform_device(), then the change in this patch is required to
>>>> not create the PNP binding (so that physical_node_count is not set from
>>>> PNP probe).
>>> Hmm... The flag, as I interpret it, is equal to "the device in
>>> question is a peripheral device to the non-discoverable bus, such as
>>> SPI, I2C or UART". I.o.w. I do not see how PNP suits here. So, from my
>>> point of view it seems like an abuse of the flag. Not sure the current
>>> state of affairs in ACPI glue layer regarding this, though.
>> Sorry, but I'm not following you here. Which flag are you talking about?
> "enumerated by parent".

ok, right. So I thought that PNP0501 was a standard cid to describe 
16550-compat UART which may be on an LPC bus. And a LPC bus is 
non-discoverable, like SPI or I2C, which also use "enumerated by parent".

Indeed, using PNP0501 for hisi lpc UART cid would be without problem, 
apart from the fact that we can't do all the PIO translation (so need 
"enumerated by parent").

Thanks,
john
