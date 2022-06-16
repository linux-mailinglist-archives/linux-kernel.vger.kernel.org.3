Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602EE54DCCB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359678AbiFPIYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358831AbiFPIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:24:16 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472AB24587;
        Thu, 16 Jun 2022 01:24:15 -0700 (PDT)
X-UUID: 0e4756970467401aad7610504b449a05-20220616
X-UUID: 0e4756970467401aad7610504b449a05-20220616
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <xiehongyu1@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1040902029; Thu, 16 Jun 2022 16:26:41 +0800
X-ns-mid: postfix-62AAE8A9-3395959497
Received: from [172.20.4.10] (unknown [172.20.4.10])
        by cs2c.com.cn (NSMail) with ESMTPSA id 1B5013844001;
        Thu, 16 Jun 2022 16:24:09 +0800 (CST)
Message-ID: <ab92690c-c3ee-ab92-5763-376db208aebb@kylinos.cn>
Date:   Thu, 16 Jun 2022 16:24:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 -next] usb: xhci: disable irq during initialization
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Hongyu Xie <xy521521@gmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 125707942@qq.com, wangqi@kylinos.cn,
        xiongxin@kylinos.cn, kernel test robot <lkp@intel.com>
References: <20220616080933.1238309-1-xiehongyu1@kylinos.cn>
 <Yqrl3jGyUx7sZVdL@kroah.com>
From:   =?UTF-8?B?6LCi5rOT5a6H?= <xiehongyu1@kylinos.cn>
In-Reply-To: <Yqrl3jGyUx7sZVdL@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg,

On 2022/6/16 16:12, Greg KH wrote:
> On Thu, Jun 16, 2022 at 04:09:33PM +0800, Hongyu Xie wrote:
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
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> the test robot did not find this original problem, it only found
> problems with your original submission, which is different.
> 
"Reported-by" shouldn't had been put here.
Quote from the last email test robot sent to me，
"If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>"
Where should I put this? Or just ignore it?

