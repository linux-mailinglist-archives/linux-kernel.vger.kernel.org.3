Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BCF4F9D59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiDHS4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbiDHS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:56:43 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5C3CDB63;
        Fri,  8 Apr 2022 11:54:38 -0700 (PDT)
Message-ID: <ad3720df-73d4-5463-a538-d921cdf9f0b3@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1649444075;
        bh=NI/aS/Xl18zBGB6UNwYdVkjZZkzV5JXJXAX5Qar/WKo=;
        h=Subject:To:Cc:References:From:In-Reply-To;
        b=YK0/BRjVfbk85Kd2GTyqkUbxY6d7bd+cX9lm8GuyUI/Ls3kJ/WPMZGMP/KM06bCpb
         gMs2nGGyOpyDTQy+u8ORyeTnMTSmTHCN0sms7xQdGsgv7gaY2VH11gK7DmDWFjCAuc
         QLuAWcpAmm0lqIf9KjX5caGnMJYJIVLUt5uTnQZkP58pyw3BOb6wlMQmB+5/cbIj2i
         DjO4Rnu3OQYyEFu8gImEF9zjKNg/oTQcuijP5CqcRIJDxRXH2t6pnnEEflFpxBEmFc
         HCwpBFo63Cp6lPl3eb5U5hLTyyLCUeeZY7srY8ApP7Fi5qZs0rETPB6GjGmlflKyug
         0YfpKz4d5u4eQ==
Date:   Fri, 8 Apr 2022 20:54:34 +0200
Mime-Version: 1.0
Subject: Re: [PATCH v1 2/2] net: usb: cdc_ether: Add Fibocom MA510 modem
Content-Language: en-US
To:     =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        Lars Melin <larsm17@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org, oliver@neukum.org
References: <20220407074745.74195-1-sven@svenschwermer.de>
 <20220407074745.74195-2-sven@svenschwermer.de>
 <3b8a8497-df41-8bf4-6816-f4419cb7f950@gmail.com>
 <87ee27y9ym.fsf@miraculix.mork.no>
From:   Sven Schwermer <sven@svenschwermer.de>
In-Reply-To: <87ee27y9ym.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On 4/8/22 15:35, Bjørn Mork wrote:
> Lars Melin <larsm17@gmail.com> writes:
> 
>> Why do you add this modem to the whitelist?
> 
> I believe the clue is the
> 
>> +	.driver_info = (unsigned long)&wwan_info,
> 
> to set FLAG_WWAN instead of the default FLAG_ETHER | FLAG_POINTTOPOINT

Bjørn is right that this is the reason. The Fibocom MA510 and L610 are 
cellular modems, so they require to be labelled as WWAN devices. As such 
they require to be set up (using AT commands or similar) before the 
connection can be used. Furthermore, WWAN devices get a different 
routing metric assigned by the network manager than regular Ethernet 
devices.

>> The net interface has the correct cdc_ether attributes so the
>> cdc_ether driver should bind automagically without any need for the
>> modem to be in the whitelist.
> 
> Yes, this sort of works against the class driver philosophy.  But we've
> already started down that road, so...
> 
> 
> 
> Bjørn
