Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB3472A26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhLMKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:32:59 -0500
Received: from mail.wizzup.org ([95.217.97.174]:44092 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242718AbhLMKcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q3wBe9qY4BB30nANlAR9vfoazoNiXcPXvVEwwQ+bgS0=; b=D49rpiwM6m+pRUxdhvOI12TdIc
        qZ2LkRy9V4o9qekgAGidOczJo4Tj5zBhOs8McU9x2o39KxcO3gnjaZxkoAOLu6TkW/Nf6/8V5yvTR
        KNjAqFVRXFm9b0Qx7YXaL/vjvHjJtLGyhb3yBu3s1F8oKrKXNSiHLAr6lNhfwpwMVHAsIpWGBG9RH
        sA8ubwqWgGo+d4ua5wirMcLIJoDWRG5U1bL73lZlMkQLnY2s4TcBMXuYi6M/ZufOK5E3ewHM2l45w
        iRejXIxiv1LAksBhCt58Drj97LgS8lBGOJgKYx9ywSNgvEthpvXgXE5QOxIckgojSH87M7PXGUAHG
        9xi3++gw==;
Received: from [45.83.235.159] (helo=[0.0.0.0])
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mwick-0001xV-P3; Mon, 13 Dec 2021 10:32:02 +0000
Subject: Re: [RFC PATCH 1/2] pmic-cpcap: add motorola,droid3 compatible
To:     Tony Lindgren <tony@atomide.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211212230459.13579-1-merlijn@wizzup.org>
 <20211212230459.13579-2-merlijn@wizzup.org> <Ybbg3GNwST5Cr9Br@atomide.com>
From:   Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <a89e329c-af4e-53ec-fdf1-77f3727a4376@wizzup.org>
Date:   Mon, 13 Dec 2021 11:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <Ybbg3GNwST5Cr9Br@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 13/12/2021 06:57, Tony Lindgren wrote:
> * Merlijn Wajer <merlijn@wizzup.org> [211212 23:00]:
>> The Droid 3 and the Bionic appear to share the same hardware, so add
>> the compatible for the Droid 3 as well.
>>
>> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
>> ---
>>  arch/arm/mach-omap2/pmic-cpcap.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
>> index 668dc84fd31e..b9188dde13b9 100644
>> --- a/arch/arm/mach-omap2/pmic-cpcap.c
>> +++ b/arch/arm/mach-omap2/pmic-cpcap.c
>> @@ -245,7 +245,8 @@ int __init omap4_cpcap_init(void)
>>  	voltdm = voltdm_lookup("mpu");
>>  	omap_voltage_register_pmic(voltdm, &omap443x_max8952_mpu);
>>  
>> -	if (of_machine_is_compatible("motorola,droid-bionic")) {
>> +	if (of_machine_is_compatible("motorola,droid-bionic") ||
>> +	    of_machine_is_compatible("motorola,droid3")) {
>>  		voltdm = voltdm_lookup("core");
>>  		omap_voltage_register_pmic(voltdm, &omap_cpcap_core);
>>  
> 
> Looks OK to me, however we should also add all the mapphones to the
> Documentation/devicetree/bindings/arm/omap/omap.txt so we can avoid
> dtb check warnings. Care to also do a patch for that? Looks like the
> others are missing too.

Sure, I'll do that and add the others too while at it. Shall I add those
to this patch, or make a separate patch?

Regards,
Merlijn
