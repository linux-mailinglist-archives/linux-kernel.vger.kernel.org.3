Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0640558406F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiG1N5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiG1N45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:56:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C801EEE6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:56:55 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8D0B822249;
        Thu, 28 Jul 2022 15:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659016613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ey/90lOx4wMpw43TX64tvVeDePycWmEHff+P7HYmJcM=;
        b=fR0dfNP64VUq13hcIS81FiKnIvkOI8R2MUuhOAjqOZuednKNaTu1XFcR05hj+M1rmqva3L
        8jfKyi7GydRS5x4L7gQSYc3jBTpIwzZCAGs/LzA0k6ZafTWLOODdQfROsKipA5SFr94Ted
        KOK1JNk46Tby+WxQlVCAqPeaJQpnPDU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Jul 2022 15:56:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, quic_c_sbhanu@quicinc.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
In-Reply-To: <29f4cff4-edc5-3838-2495-253e794178ae@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
 <41e6b74d-6973-60da-1556-82a1e879ffd4@microchip.com>
 <ff6ffb3f8e77b29b44883d30c9b4385e@walle.cc>
 <29f4cff4-edc5-3838-2495-253e794178ae@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <902917c39041fc9c0a2695de0f7382a0@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-28 15:31, schrieb Tudor.Ambarus@microchip.com:
> On 7/28/22 16:12, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>>>>> +#define SNOR_ID3(_jedec_id)
>>> 
>>> How about SFDP_ID3 and SFDP_ID6 instead?
>> 
>> Yes, probably a better name. I was also thinking about splitting
>> the id in vendor, device and additional bytes. But I haven't
>> thought of the actual implementation that much. Such as:
>> 
>> #define SFDP_ID(<u8 vid>, <u16 did>, <variable aux bytes>)
>> #define SFDP_ID_FULL(<num_continuation_code>, <u8 vid>, <u16 did>,
>> <variable aux bytes>)
>> 
>> Couldn't make up a better name than that _FULL for now. Happy to hear
>> suggestions :)
>> 
> 
> You mean splitting the ID in manufacturer ID, flash ID and extended 
> flash ID?
> I'd like to understand the benefits of splitting this, can you give me 
> an
> example? In the past I though about introducing some flash info macros 
> for
> families of flashes of the same vendor, it will reduce the number of 
> lines
> on flash definition, but not really related.

First, why would you combine the vendor and part id into one three byte
field? Isn't it natural to have these as two fields? We know the did is
8 bit and the vid is 16 bit. And there might be N continuation codes. So
putting that all in one value is error prone. See also below for the
is25cd512.
Second, the extended (so maybe SFDP_ID_EXT?) bytes is variable. I've
seen flashes with one additional byte.

If you want to have per vendor convenience macros you could do

#define WINBOND_SFDP_ID(did, ...) SFDP_ID(0xNN, did, __VA_ARGS__)

I don't see much benefit here. OTHO "#define SFDP_VID_WINBOND 0xNN"
might make sense. But then we'd need to come up with support for
continuation codes. So mhhh.

As for the examples:
  SFDP_ID(SFDP_VID_WINBOND, 0x6019)
  SFDP_ID(SFDP_VID_MICRON, 0xba19, 0x10, 0x44, 0x00)
or maybe
  SFDP_ID(SFDP_VID_MICRON, 0xba19, 0x10, 0x44)

Currently we have the is25cd512 which (correctly) uses
continuation codes. So, we'd need have something like
#define SFDP_VID_ISSI_LEGACY 0x9d
#define SFDP_VID_ISSI 1, 0x9d

And preferrably we'd have something like:

  SFDP_ID(SFDP_VID_ISSI_LEGACY, 0x4013)
  SFDP_ID(SFDD_VID_ISSI, 0x20xx)

(note that "xx" is unknown here.. we are lacking that because
the entry is just using INFO() and I'm too lazy to look up the
datasheet now.)

Now I know that above probably won't compile, but maybe someone
could come up with macros which actually work :)

The following might work, but feels awful like a hack:
#define SFDP_VID_ISSI_LEGACY 0, 0x9d
#define SFDP_VID_ISSI 1, 0x9d

-michael
