Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABB5745F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiGNHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiGNHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:41:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDAD1F63D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:41:57 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E640B22246;
        Thu, 14 Jul 2022 09:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657784516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogFlYqmAqQxn6+1FR20t7h2PNmZxGGdMcvOHgoKXDus=;
        b=hEOd3Qbl+ejzDleZB42HjtegmxzoDlxldOSpYYz5UopFPl+JTTvk0V4TxayqnlK/TsZewn
        Mjsapjb+BR0iriYSZdgBMlBCaYSdUk30e0xkttEvrf54SVTaJa2scq2yMuH1YVvp7EEZ7x
        JS+DXe40yXDwPEEqsGHyLzgFUisYuJ8=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 14 Jul 2022 09:41:55 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Cc:     clg@kaod.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        quic_ggregory@quicinc.com, quic_jiles@quicinc.com,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
In-Reply-To: <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
 <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
 <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <00f0c9d480ef5a414f1c34492661bd9e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-07-13 23:01, schrieb Jae Hyun Yoo:
> On 7/13/2022 7:32 AM, Michael Walle wrote:
>> Am 2022-07-13 16:26, schrieb Jae Hyun Yoo:
>>>>> +    { "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024)
>>>> 
>>>> Please use INFO(0xef6020, 0, 0, 0) and test wether it will still
>>>> work correctly. We will then be able to convert it to SNOR_ID3()
>>>> later.
>>> 
>>> Tested it but it doesn't work with INFO(0xef6020, 0, 0, 0). I'll keep
>>> it as is.
>> 
>> Can you please look into this? I'd expect this to work if the SFDP
>> tables are correct because all this should come from the tables.
>> You can look at /sys/kernel/debug/spi-nor/spi0.0/params and see
>> what is changing there.
> 
> I tested it again but result is still the same. I can check the parsed
> info like below if I use INFO(0xef6020, 0, 64 * 1024, 1024) but I can't
> even check the debugfs info if I use INFO(0xef6020, 0, 0, 0) since it
> doesn't boot at all. I think, this patch should go as is and the size
> parsing issue could be fixed using a separate fix.

What does "doesn't boot at all" mean? Are there any kernel startup
messages?

Just to be sure, you have PARSE_SFDP set, right?

The entry should be (skipping OTP to make sure that isn't
the problem here):
{ "w25q512nwq", INFO(0xef6020, 0, 0, 0) PARSE_SFDP }

-michael
