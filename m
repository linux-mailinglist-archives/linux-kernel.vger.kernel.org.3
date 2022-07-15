Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC61576A96
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiGOXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiGOXU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:20:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253BF92845
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:20:54 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C77A622175;
        Sat, 16 Jul 2022 01:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657927252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSxie2CEIzA/i7/xibzPAmDcNMxxLFuq+8fVYOpsh20=;
        b=PFe5tCjk2xQSS3mOEgj/bkzpUuy4IBe03UmFCqUq3fmYJHoAunfp0Tl6FKGxYdIAkEdYC/
        vI9YPMLYs6htvypVmO1nPZloCwF2f9hCONGHHY6lMkKLaYI0s4AEffljuy5jG9WqIdqqgY
        by+ZlGASU1/57ZjHUyP2bX9/bW+Ai4g=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 16 Jul 2022 01:20:51 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Cc:     clg@kaod.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        quic_ggregory@quicinc.com, quic_jiles@quicinc.com,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
In-Reply-To: <2e0f02f3-0e0e-8690-a58e-bb74a21ab63e@quicinc.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
 <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
 <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
 <00f0c9d480ef5a414f1c34492661bd9e@walle.cc>
 <63cedfce-34bb-ed63-3871-75a6c3dd5d73@quicinc.com>
 <6be710bb5c1bf0449e54a54b78f6f7a0@walle.cc>
 <47c01d768ea56edc9a2f9d317af7b495@walle.cc>
 <114fcde6-bdf7-68ee-d031-35a916027aee@quicinc.com>
 <b42cb229-f241-6e29-a138-29023ce316d9@quicinc.com>
 <c628e868-5c73-ca4b-1f99-60cc149806bf@quicinc.com>
 <b00410c825486ec406ed1ae773b11792@walle.cc>
 <2e0f02f3-0e0e-8690-a58e-bb74a21ab63e@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <00bdb7304cf479d21b87d4a35e908fb4@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index ce5d69317d46..a2c8de250e01 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2113,6 +2113,10 @@ spi_nor_select_uniform_erase(struct 
>> spi_nor_erase_map *map,
>> 
>>                  tested_erase = &map->erase_type[i];
>> 
>> +               /* Skip masked erase types. */
>> +               if (!tested_erase->size)
>> +                       continue;
> 
> Yes, it also works. Do you want me to update this patch with adding 
> this
> fix? Or is it good to go as is so that the INFO table can be replaced
> with SNOR_ID3 later after the fix is merged?

Please add this as a separate preceding patch to your original one
where you add the flash. Keep the INFO(0xef6020, 0, 0, 0). Then we
will replace it later with the SNOR_ID3().

Thanks for debugging!
-michael
