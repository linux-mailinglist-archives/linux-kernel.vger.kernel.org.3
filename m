Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3F4D45B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbiCJLc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbiCJLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:32:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C20141E2E;
        Thu, 10 Mar 2022 03:31:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0F81691;
        Thu, 10 Mar 2022 03:31:53 -0800 (PST)
Received: from [10.57.43.53] (unknown [10.57.43.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700AC3F7D7;
        Thu, 10 Mar 2022 03:31:47 -0800 (PST)
Message-ID: <3021738c-06e4-6760-5a70-5b3dc57f1e96@arm.com>
Date:   Thu, 10 Mar 2022 11:31:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [EXT] RE: [PATCH] media: amphion: fix some error related with
 undefined reference to __divdi3
Content-Language: en-GB
To:     Ming Qian <ming.qian@nxp.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220309050221.971-1-ming.qian@nxp.com>
 <ab877a4470324d20b558538b52f69391@AcuMS.aculab.com>
 <AM6PR04MB63417FD1C3EE77BBE1649B47E70B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <AM6PR04MB63417FD1C3EE77BBE1649B47E70B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-10 08:36, Ming Qian wrote:
>> -----Original Message-----
>> From: David Laight [mailto:David.Laight@ACULAB.COM]
>> Sent: Wednesday, March 9, 2022 9:27 PM
>> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
>> shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
>> Cc: hverkuil-cisco@xs4all.nl; kernel@pengutronix.de; festevam@gmail.com;
>> dl-linux-imx <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
>> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: [EXT] RE: [PATCH] media: amphion: fix some error related with
>> undefined reference to __divdi3
>>
>> Caution: EXT Email
>>
>> From: Ming Qian
>>> Sent: 09 March 2022 05:02
>> ...
>>> 3. use 'val >> 1' instead of ' val / 2'
>>
>> The compiler should do that anyway.
>>
>> Especially for unsigned values.
>> And it has the wrong (different) rounding for negative values.
>>
>>          David
>>
> 
> Hi David,
>      Yes, you are right, if the value is negative, the behavior is wrong.
>      But here, the value type is u32, so I think it's OK.

Well, it depends on the semantic intent, really. If you're packing a 
bitfield which encodes bits 31:1 of some value then a shift is the most 
appropriate operation. However if you're literally calculating half of a 
value for, say, a 50% threshold level, or the number of 16-bit words 
represented by a byte length, then semantically it's a division, so it 
should use the divide operator rather than obfuscating it behind a 
shift. Constant division is something that even the most basic 
optimising compiler should handle with ease.

One more thing that's not the fault of this patch, but stood out in the 
context:

@@ -1566,7 +1568,7 @@ static bool vpu_malone_check_ready(struct 
vpu_shared_addr *shared, u32 instance)
  	u32 wptr = desc->wptr;
  	u32 used = (wptr + size - rptr) % size;

-	if (!size || used < size / 2)
+	if (!size || used < (size >> 1))
  		return true;

  	return false;

That's not safe: if "size" is 0 then the undefined behaviour has already 
happened before the "!size" check is reached. If "size" really can be 0, 
then it needs to be checked *before* it is used as a divisor to 
calculate "used".

Robin.
