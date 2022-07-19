Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0E5793D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiGSHHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiGSHHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:07:14 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C1725C54
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:07:13 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0D0CF221D4;
        Tue, 19 Jul 2022 09:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658214431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hc/fgBpwn4nfyKBqGshJaCyj+0/ns0DEr+WNZ/nNBE=;
        b=hp7Q7Us9wZQRMYOhLaKFlYu1g61zrgdBCiRcLQp54CHRWhluJ7isCnS4MExQL3xtF52L1z
        TNuhUKLRPhMYgzepBS4MQ+yge8hNlHgIzwFUsNb8Z1m3ATNCDCbqJ4Qso4bsu77eOVxAY4
        D+u/dlGVwitW7ihSZsxLuo/ukGQlY+0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jul 2022 09:07:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
In-Reply-To: <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <02125e047cfbf347d81811224be3141e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-19 07:57, schrieb Tudor.Ambarus@microchip.com:
> On 5/10/22 17:02, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Up until now, flashes were defined by specifying the JEDEC ID, the
>> sector size and the number of sectors. This can be read by parsing the
>> SFDP, we don't have to specify it. Thus provide a new macro SNOR_ID3()
>> which just takes the JEDEC ID and implicitly set .parse_sfdp = true. 
>> All
>> new flashes which have SFDP should use this macro.
> 
> I like the idea, but you need to refine it a bit.
> Your assumptions are true only for flashes that are compliant with SFDP 
> revB or
> later because params->page_size is initialized by querying BFPT DWORD
> 11. I think it would be good to specify this in the comment section.

Sure.

> Also, I think you introduce
> a bug in spi_nor_select_erase() when CONFIG_MTD_SPI_NOR_USE_4K_SECTORS 
> is not
> selected. wanted_size will be zero, will you select an invalid erase 
> type?

You mean to squeeze [1] into this one? If so, sure.

-michael

[1] 
https://lore.kernel.org/linux-mtd/20220716000643.3541839-1-quic_jaehyoo@quicinc.com/
