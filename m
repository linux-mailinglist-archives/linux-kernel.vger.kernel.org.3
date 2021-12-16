Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04187476EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhLPKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:15:26 -0500
Received: from phobos.denx.de ([85.214.62.61]:33356 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235826AbhLPKPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:15:25 -0500
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2579E80379;
        Thu, 16 Dec 2021 11:15:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1639649724;
        bh=gWD5WvNP5qs1hnWasMOEH8Rjn74OwFdzLcr9XdOSUp0=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=K0Mx3OJDZJHzglJP+mtN6vFpO+v486fMRpjhMh/ccx3mkBkyPLP2+Q2h7wkJbZIpr
         xJQ7sQrHEkLIhcHWxn1eCfWOZjpYS9MPhtVByQEO6jIBCsr6w/cxVDLoUR260LZqao
         ni+USkXSZfU1bY7xM7RYNU4dVhg+mtICHxealVei64E/rz7O5Mq5C9VLjzRlgpMvFC
         kCRz6VUiKMxaC3OvszwtZP0w5yheJUnOV5P0sUHktFVuK7/W8hPcqicQrNbkUXbyyw
         7u5Sf0Krst7Lviv/Zr6gPyNfodKaKW2FByUJ2DwQUbRfOwkHS5GuANE2X72XNiV8Sl
         +cAgyCJGTa7bA==
Message-ID: <7137d4a9-6830-959d-1222-e63f5f618859@denx.de>
Date:   Thu, 16 Dec 2021 11:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] mmc: mmci: add hs200 support for stm32 sdmmc
Content-Language: en-US
To:     Yann Gautier <yann.gautier@foss.st.com>
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
 <20211215141727.4901-5-yann.gautier@foss.st.com>
 <c4528bc5-a826-a4ed-c4d6-e0ab84651ea2@denx.de>
 <b7ef5887-ce9e-9ba1-5819-765e68104cc5@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        u.kleine-koenig@pengutronix.de,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <b7ef5887-ce9e-9ba1-5819-765e68104cc5@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 10:44, Yann Gautier wrote:
> On 12/16/21 10:14 AM, Marek Vasut wrote:
>> On 12/15/21 15:17, Yann Gautier wrote:
>>> Use feedback clock for HS200 mode, as for SDR104.
>>> The HS200 mode can be enabled through DT by using mmc-hs200-1_8v.
>>> It is possible to use it on STM32MP13, but not STM32MP15 platforms.
>>
>> HS200 is possible even on the MP15, it just doesn't yield any 
>> (performance) benefits due to the slower bus clock (125 MHz or so?), 
>> so it isn't worth enabling it on MP15. It is nice to see MP13 can do 
>> better.
> 
> Hi Marek,
> 
> There is a limitation on MP15, please see errata sheet [1], chapter 2.3.19.
> HS200 (and SDR104) shouldn't be enabled on MP15.
> 
> Best regards,
> Yann
> 
> [1] https://www.st.com/resource/en/errata_sheet/dm00516256.pdf

Oh, I see, so I was lucky to even ever get it working at all.

Thanks for the info.
