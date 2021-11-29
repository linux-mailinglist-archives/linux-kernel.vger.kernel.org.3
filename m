Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6913F4625AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhK2Wmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhK2Wlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:41:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E3C0C2348;
        Mon, 29 Nov 2021 09:43:48 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A40AF2223B;
        Mon, 29 Nov 2021 18:43:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1638207826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zcBAIJC1gEdwdFwYhBfmFtG4nq+PNV+zj3GqYfXilOM=;
        b=bBITAg9/diu3gzSDjjVSbwaDvx6Y9xpGylCfdfVejq/X5usbKpbp6+dw6PgN/SlbKMOylm
        GQU2HldM0qe62TPJFMSy0r2bedLEJAU0sobkh5+cgZ2BvTyjvxU1yURH4hPUzf9WG7etEf
        9FdXMbhyS1eKvg+EnBWizH9Xr6dAMEk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Nov 2021 18:43:45 +0100
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH] dt-bindings: nvmem: add transformation support
In-Reply-To: <7807ac74-5b5c-f0a0-804a-497b67d2c985@linaro.org>
References: <20211123134425.3875656-1-michael@walle.cc>
 <7807ac74-5b5c-f0a0-804a-497b67d2c985@linaro.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <31ee8f287bb410fabae11f31c42d5c86@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Am 2021-11-29 13:54, schrieb Srinivas Kandagatla:
> On 23/11/2021 13:44, Michael Walle wrote:
>> This is my second attempt to solve the use case where there is only 
>> the
>> base MAC address stored in an EEPROM or similar storage provider. This
>> is the case for the Kontron sl28 board and multiple openwrt supported
>> boards.
>> 
>> The first proposal [1] didn't find much appreciation and there wasn't
>> any reply to my question or new proposal [2]. So here we are with my 
>> new
>> proposal, that is more flexible and doesn't fix the ethernet mac only.
>> This is just an RFC for the device tree representation for now to see 
>> if
>> this is the correct way to tackle this.
>> 
>> I'm also aware of the latest post process hook support [3]. This 
>> doesn't
>> fix the base mac address issue, but I think it also doesn't solve the
>> case with swapped ethernet addresses in the general case. That hook 
>> will
>> involve the driver to do the swapping, but how would the driver know
>> if that swapping is actually required. Usually the interpretation of 
>> the
>> content is opaque to the driver, after all it is the user/board
> 
> But this is the path for any post processing hook, which ever
> direction we endup with(using core helpers or provider specific
> post-processing).

Mh? I don't understand. My point was that the driver is unlikely
to know what it should process. Take the mtd (or the mtd otp)
nvmem provider for example. If I understand it correctly, it just
gets the nvmem name, for example, "mac-address". How should
the post process hook know, what it should do? IMHO that just
works for very specific drivers, which tied to the content
they provide.

>> manufacturer who does program the storage device. We might be lucky in
>> the imx-ocotp case because the IMX reference manual actually states
>> where and in which format the mac address is programmed.
>> 
>> Introduce a transformation property. This is intended to be just an
>> enumeration of operations. If there will be a new operation, support 
>> for
>> it has to be added to the nvmem core.
>> 
>> A transformation might have multiple output values, like in the base 
>> mac
>> address case. It reads the mac address from the nvmem storage and
>> generates multiple individual addresses, i.e. on our board we reserve 
>> 8
>> consecutive addresses. These addresses then can be assigned to 
>> different
>> network interfaces. To make it possible to reference different values 
>> we
>> need to introduce an argument to the phandle. This additional argument
>> is then an index into a list of values.
>> 
>> Example:
>>    mac_addresses: base-mac-address@10 {
>>      #nvmem-cell-cells = <1>;
>>      reg = <10 6>;
>>      transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;
> 
> IMO, this is totally redundant. we could probably encode this info
> directly in the cell specifiers, something like:
> 
>>    }
>> 
>>    &eth0 {
>>      nvmem-cells = <&mac_addresses 0>;
> 
> nvmem-cells = <&base_mac_addresses NVMEM_T_ETH_OFFSET 0>;

I had he same idea, but keep in mind, that there could be more
than just one nvmem cells:

nvmem-cells = <&phandle1 arg1 &pandle2 arg2 arg3>;
nvmem-cell-names = "name1", "name2";

So you'd need the #nvmem-cell-cells either way.

> And value of #nvmem-cell-cells is dependent on the first cell 
> specifier.

What do you mean with first cell specifier? the phandle 
(base_mac_address
in the example) or the NVMEM_T_ETH_OFFSET? I guess the latter, because 
the
arguments depend on the transformation. But this is not how the
of_parse_phandle_with_args() works, it will look the '#nvmem-cell-cells'
property up, to see how many arguments it should expect, which is a
property to the referenced node. Thus I've come up with the additional
indirection. The number of arguments for the reference cell is either
0 or 1 and the transformation is part of the nvmem cell.

> I understand that these 3 bits of info is required for this type of
> post processing and this can only come from DT and its not possible to
> determine this at runtime.

ok :)

> Would this address other usecases?

I think so, but see above for why it can't work. Or I am missing
something.

> Are you in a position to test few of them?

Sure (at least after my vacation). And TBH I think the imxotp mac
swap should use the same or it will be likely that there are future
SoCs which will always swap the ethnet

> Lets wait for Rob's opinion on adding #nvmem-cell-cells property with
> cell specifiers describing the encoding information?

+1

Thanks for looking into this,
-michael
