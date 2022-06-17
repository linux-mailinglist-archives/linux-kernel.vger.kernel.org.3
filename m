Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5654F855
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiFQNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiFQNby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:31:54 -0400
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5CBCF5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:31:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09729436|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0811532-0.0012695-0.917577;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.O76jcEA_1655472657;
Received: from 192.168.220.136(mailfrom:victor@allwinnertech.com fp:SMTPD_---.O76jcEA_1655472657)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 21:31:31 +0800
Message-ID: <ecabcfa6-7408-d10b-7d88-b1a202b2a90d@allwinnertech.com>
Date:   Fri, 17 Jun 2022 21:30:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
Content-Language: en-US
From:   Victor Hassan <victor@allwinnertech.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
        yanfei.xu@windriver.com, ardb@kernel.org, tglx@linutronix.de,
        mirq-linux@rere.qmqm.pl, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CACRpkdabVpD8fQYowCFibdc-r7of6JQnUJAeo0Quqg=cCuOjAQ@mail.gmail.com>
 <0fa192d1-b6cc-4a8a-c319-36471cba79e8@allwinnertech.com>
In-Reply-To: <0fa192d1-b6cc-4a8a-c319-36471cba79e8@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2022 11:08 PM, Victor Hassan wrote:
> On 18/04/2022 07:21, Linus Walleij wrote:
>> On Wed, Mar 16, 2022 at 3:33 AM Victor Hassan 
>> <victor@allwinnertech.com> wrote:
>>
>>> earlycon uses fixmap to create a memory map,
>>> So we need to close earlycon before closing fixmap,
>>> otherwise printk will access illegal addresses.
>>> After creating a new memory map, we open earlycon again.
>>>
>>> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
>>
>> I think noone really noticed this because everyone on Arm systems
>> use CONFIG_DEBUG_LL, and that makes printascii hammer out
>> stuff on the console very early, it even accounts for whether we have
>> MMU on or not.
>>
> Hi Linus,
> Thank you for the reply. I used earlycon, in early_fixmap_shutdown, the 
> base address of earlycon is in the critical stage of release and 
> reassignment, so early_fixmap_shutdown -> create_mapping should not call 
> earlycon in this process, and create_mapping has a lot of conditions 
> that trigger print, memblock=debug just makes it easier to expose problems.
> 
>> How are you using this on Arm even? What system and what serial
>> driver?
> I'm using serial driver 8250 on arm32, with cmdline: memblock=debug.
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8520_CONSOLE=y
>>
>> That said, it looks correct.
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Hi Linus,
Sorry to disturb. Is there any question about this issue? Thank you :)
