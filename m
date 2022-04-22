Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAA850BD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449742AbiDVQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354009AbiDVQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:35:55 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E85DA79;
        Fri, 22 Apr 2022 09:33:02 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id EFEFF8393B;
        Fri, 22 Apr 2022 18:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1650645180;
        bh=H6Ng9dU4SgWEq5Ejz5YMWUlWTgL9RMB8+WAFzJPrCxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wUbVqSkmAaXvc7xWxOapahlsTdkDRDpelDR7H+PXo3O5FiNGmx2hWE/rkBi47POK4
         dYthtV04SJcZwaJ+TncknDAUP2CdcL7Aaej2VaPuzUwy0Y8e9u+ikVG92hXT7lZUl9
         xa33paX4YmxlkY5HgiuGHlK8vp/cv+Nf/VkMrCc5pX76x8GWYITkf+2H5n/ysuqqSK
         4YQGIQlIkYF/VHtnBVHBC7LhcYslwfv5DkoqVnKb1lmq71oK0/TWDLp1Ig/oHVYu8r
         j2VY7861GFMg5zvKxn4KNwe6b1MMOwa8srhjVVHTK/XZbwAjOjY+jeJi65FdpBTJ6j
         WBJW0NZ2TPa0Q==
Message-ID: <174bea56-3e99-e01c-4133-f1350d34448d@denx.de>
Date:   Fri, 22 Apr 2022 18:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 6/8] ARM: dts: stm32: enable optee firmware and SCMI
 support on STM32MP15
Content-Language: en-US
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        robh+dt@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        soc@kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, etienne.carriere@st.com
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-7-alexandre.torgue@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220422150952.20587-7-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 17:09, Alexandre Torgue wrote:
> Enable optee and SCMI clocks/reset protocols support.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 7fdc324b3cf9..1b2fd3426a81 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -115,6 +115,33 @@
>   		status = "disabled";
>   	};
>   
> +	firmware {
> +		optee: optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +			status = "disabled";
> +		};

Doesn't this TEE node get automatically generated and patched into DT by 
the TEE ? I think OpTee-OS does that.
