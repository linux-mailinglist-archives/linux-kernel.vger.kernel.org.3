Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E38552D38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347526AbiFUIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiFUIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:41:00 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294A25EBA;
        Tue, 21 Jun 2022 01:40:58 -0700 (PDT)
X-UUID: 3d5c3b1c444f432aaf165b63d2ee9f5a-20220621
X-UUID: 3d5c3b1c444f432aaf165b63d2ee9f5a-20220621
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <xiehongyu1@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1520558665; Tue, 21 Jun 2022 16:43:16 +0800
X-ns-mid: postfix-62B18413-1929898908
Received: from [172.20.4.10] (unknown [172.20.4.10])
        by cs2c.com.cn (NSMail) with ESMTPSA id E10173848654;
        Tue, 21 Jun 2022 16:40:50 +0800 (CST)
Message-ID: <13e54c18-7a58-b6bd-0399-273a109ee42e@kylinos.cn>
Date:   Tue, 21 Jun 2022 16:40:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 -next] usb: xhci: disable irq during initialization
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Hongyu Xie <xy521521@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn
References: <20220616083852.1264261-1-xiehongyu1@kylinos.cn>
 <bf133cfd-8d9a-474e-989e-48fe383ecfbd@linux.intel.com>
From:   =?UTF-8?B?6LCi5rOT5a6H?= <xiehongyu1@kylinos.cn>
In-Reply-To: <bf133cfd-8d9a-474e-989e-48fe383ecfbd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks fine.
Thanks for all the advices and cleanups.

On 2022/6/21 16:25, Mathias Nyman wrote:
> Hi
> 
> On 16.6.2022 11.38, Hongyu Xie wrote:
>> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
>> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
>> It's possible that you will receive thousands of interrupt requests
>> after initialization for 2.0 roothub. And you will get a lot of
>> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
>> disabled?". This amount of interrupt requests will cause the entire
>> system to freeze.
>> This problem was first found on a device with ASM2142 host controller
>> on it.
>>
>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
>> --
> Thanks, added.
> Did some non-functional cleanups, mostly to the old debug messages this patch
> moves around:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-linus&id=2d1fa9b0b08bb841fde9136c249f632eb04a1e00
> 
> Let me know if you disagree with the changes
> 
> -Mathias
  -Hongyu
