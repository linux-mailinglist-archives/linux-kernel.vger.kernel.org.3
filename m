Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C92C464FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349941AbhLAOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbhLAOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:04 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E200C061574;
        Wed,  1 Dec 2021 06:30:43 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1363222205;
        Wed,  1 Dec 2021 15:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1638369040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVaEf+1NM2So+kTq80FzpycJTmmcisqm5SIgbP3uITk=;
        b=Z06xCh7jTKgRnW/vb1qnGcdbE1jViZUV3y4N4iGqGk8kbsGKK3zz0B4Lcx2tmrZsDDrpCL
        AK5uLX/JnSjLISXONHE3/QgWnz4Bp97DAxH5ftbopwwUZWBRUA8EipQN27Oahznb/gpsV3
        XCnG1SQydX/+KfsAjawB/ur7DxZ3tn4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Dec 2021 15:30:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH] dt-bindings: nvmem: add transformation support
In-Reply-To: <YaZ5JNCFeKcdIfu8@robh.at.kernel.org>
References: <20211123134425.3875656-1-michael@walle.cc>
 <YaZ5JNCFeKcdIfu8@robh.at.kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <bc05fb3483cef4869ae390096bb95985@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am 2021-11-30 20:19, schrieb Rob Herring:
> On Tue, Nov 23, 2021 at 02:44:25PM +0100, Michael Walle wrote:
..

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
> 
> I still don't think trying to encode transformations of data into the 
> DT
> is right approach.
> 
>> 
>> Example:
>>   mac_addresses: base-mac-address@10 {
>>     #nvmem-cell-cells = <1>;
>>     reg = <10 6>;
>>     transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;
>>   }
>> 
>>   &eth0 {
>>     nvmem-cells = <&mac_addresses 0>;
>>     nvmem-cell-names = "mac-address";
>>   };
>> 
>>   &eth1 {
>>     nvmem-cells = <&mac_addresses 2>;
>>     nvmem-cell-names = "mac-address";
>>   };
>> 
>> The NVMEM_T_ETH_OFFSET transformation takes N additional (dt) cells 
>> and
>> will generate N values. In this example BASE_MAC+0, BASE_MAC+1, 
>> BASE_MAC+7.
>> An nvmem consumer can then reference the nvmem cell with an index. So 
>> eth0
>> will get BASE_MAC+0 and eth1 will get BASE_MAC+7.
>> 
>> This should be sufficient flexible for many different transformations
>> without having to touch the bindings except for adding documentation 
>> and
>> checks for new transformations.
> 
> The content and number of cells is supposed to be opaque to the client
> and interpreted by the provider. That's sort of true here, but not
> really because the interpretation is tied to 'transformation'. So I'm
> okay with adding cells, but not fixing the interpretation of them. A
> compatible should determine how the cells are interpreted.

What do you mean by "adding cells"? The additional argument to the
phandle?

So an example would be:

ethernet_base_mac: base-mac-address@100 {
     #nvmem-cell-cells = <1>;
     compatible = "nvmem-ethernet-address";
     reg = <0x100 0x6>;
};

&eth0 {
     nvmem-cells = <&ethernet_base_mac 0>;
     nvmem-cell-names = "mac-address";
};

&eth1 {
     nvmem-cells = <&ethernet_base_mac 7>;
     nvmem-cell-names = "mac-address";
};

Right? Any suggestions for a better compatible name?

>> I do have one question regarding "#nvmem-cell-cells" (aside from the
>> awkward naming): is it allowed to have that property optional if there
>> is no additional argument to the phandle?
> 
> We don't have any choice if we add "#nvmem-cell-cells". There's already
> cases without it.

Yes, that was the reason for the question. But I wasn't sure, whether
that is allowed.

-michael
