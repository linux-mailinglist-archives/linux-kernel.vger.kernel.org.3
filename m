Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C1054F7CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiFQMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiFQMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:46:27 -0400
Received: from mail-m12736.qiye.163.com (mail-m12736.qiye.163.com [115.236.127.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278B2DD72;
        Fri, 17 Jun 2022 05:46:26 -0700 (PDT)
Received: from [172.16.12.167] (unknown [58.22.7.114])
        by mail-m12736.qiye.163.com (Hmail) with ESMTPA id CE3957E01C7;
        Fri, 17 Jun 2022 20:46:24 +0800 (CST)
Message-ID: <41af9d13-fff5-a416-87cc-4f69e77d6409@rock-chips.com>
Date:   Fri, 17 Jun 2022 20:46:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] spi: rockchip: Disable local irq when pio write out of
 interrupt service
To:     Mark Brown <broonie@kernel.org>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220613092744.9726-1-jon.lin@rock-chips.com>
 <YqcveggUU7yaXuk1@sirena.org.uk>
 <b97ee70c-70ee-6b15-65d6-a176125dcfd8@rock-chips.com>
 <YqxpTqvaQb4cohTh@sirena.org.uk>
From:   Jon Lin <jon.lin@rock-chips.com>
In-Reply-To: <YqxpTqvaQb4cohTh@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkpMVh0fQkNNHx9PH01DS1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6Fxw4Hz06F0kdARdREyMP
        DEMKCitVSlVKTU5OT01CQkNOSEpJVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFITk9PNwY+
X-HM-Tid: 0a8171b34ce8b20fkuuuce3957e01c7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/17 19:45, Mark Brown wrote:
> On Fri, Jun 17, 2022 at 02:24:10PM +0800, Jon Lin wrote:
>> On 2022/6/13 20:37, Mark Brown wrote:
>>> On Mon, Jun 13, 2022 at 05:27:44PM +0800, Jon Lin wrote:
> 
>>>> +	spin_unlock_irqrestore(&rs->lock, flags);
> 
>>> So this is effectively just disabling interrupts during PIO, there's no
>>> other users of the lock which is rather heavyweight.  What's the actual
>>> issue here?  We should also have something saying what's going on in the
>>> code since right now the lock just looks redundant.
> 
>> For lock: In order to avoid special situations, such as when the CPU
>> frequency drops to close to the IO rate, the water line interrupt is
>> triggered during FIFO filling (triggered by other CPUs), resulting in
>> critical resources still not being protected in place. For local IRQ
> 
> So essentially we're so slow in filling the FIFO when starting a
> transfer that the interrupt triggers in the middle of the initial FIFO
> fill?  Something that tricky *really* needs a comment adding.
> 
> Ideally we'd just leave the interrupt masked until the FIFO is filled
> though, looking at the driver I see that there is an interrupt mask
> register which seems to have some level of masking available and I do
> note that in rockchip_spi_prepare_irq() we unmask interrupts before we
> start filling the FIFO rather than afterwards.  Would reversing the
> unmask order there address the issue more cleanly?

This idea is workable, and it's more efficient than previous code, So I 
send a new commit:
https://patchwork.kernel.org/project/spi-devel-general/patch/20220617124251.5051-1-jon.lin@rock-chips.com/
> 
>> disable: Turning off the local interrupt is mainly to prevent the CPU
>> schedule from being interrupted when filling FIFO.
> 
> If it were just this then there's preempt_disable(), but what's the
> problem with being preempted during the FIFO fill?

I think
