Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBE568408
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiGFJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiGFJrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:47:46 -0400
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858CBDC;
        Wed,  6 Jul 2022 02:47:33 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.4.171])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1o91cy-0000jJ-LW; Wed, 06 Jul 2022 10:47:24 +0100
Message-ID: <ec401a51-5895-fce7-1075-a2c964466d2b@codethink.co.uk>
Date:   Wed, 6 Jul 2022 10:47:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] crypto: flush poison data
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>,
        LABBE Corentin <clabbe@baylibre.com>
Cc:     herbert@gondor.apana.org.au, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220701132735.1594822-1-clabbe@baylibre.com>
 <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk> <YsP0eekTthD4jWGV@Red>
 <20220705164213.GA14484@lst.de>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220705164213.GA14484@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 17:42, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:21:13AM +0200, LABBE Corentin wrote:
>>
>> I just copied what did drivers/crypto/xilinx/zynqmp-sha.c.
>> I tried to do flush_dcache_range() but it seems to not be implemented on riscV.
> 
> That driver is broken and should no have been merged in that form.
> 
>> And flush_dcache_page(virt_to_page(addr), len) produce a kernel panic.
> 
> And that's good so.  Drivers have no business doing their own cache
> flushing.  That is the job of the dma-mapping implementation, so I'd
> suggest to look for problems there.

I'm not sure that the dma-mapping code for non-coherent riscv systems
did get sorted. I couldn't find any when looking in 5.17.

I expect the flush of the icache is also implicitly doing a dcache
flush too as from what i've seen it is only being used when code or
tlbs are being modified.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
