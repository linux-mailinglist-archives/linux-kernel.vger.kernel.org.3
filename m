Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE7476D28
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhLPJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhLPJOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:14:50 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B57C061574;
        Thu, 16 Dec 2021 01:14:50 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 36F7181184;
        Thu, 16 Dec 2021 10:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1639646087;
        bh=4KGuTwhojZAMWLlAy5DjgLUqaT2ZYVoaf+TvkydJd6g=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ry1NwOreBD5Fe9kQOZopFc9TvTpmrIth2ygVZpeDfr6aTJx1VpTSKFVDxhmdMHb/4
         TcrlwAE8nzgtFB+okKjLeukYCAh2I8v+jPXVXXrjZsxvC1so8XiJRXgZv3ha4e6IN+
         1FwibcMnBppdrAl5dMInx4KoVz8VHCWVUB/wTXbNNmQyYgHO82aVf1RKJz0LBjDy8E
         fTniyOFhZof+egJs8XoT5h6580xX6qpGop+ROnMIyUHq9VOhL0ki9jkTsqnkGHEi5f
         S18AscO+GQJ85tpuHBu4LEto9Tkcuvfnp1kUSRl7Y7QmWreKz/Itq4xX302Ya9SL+v
         jZ1q1G+adstkQ==
Message-ID: <c4528bc5-a826-a4ed-c4d6-e0ab84651ea2@denx.de>
Date:   Thu, 16 Dec 2021 10:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] mmc: mmci: add hs200 support for stm32 sdmmc
Content-Language: en-US
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
 <20211215141727.4901-5-yann.gautier@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20211215141727.4901-5-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 15:17, Yann Gautier wrote:
> Use feedback clock for HS200 mode, as for SDR104.
> The HS200 mode can be enabled through DT by using mmc-hs200-1_8v.
> It is possible to use it on STM32MP13, but not STM32MP15 platforms.

HS200 is possible even on the MP15, it just doesn't yield any 
(performance) benefits due to the slower bus clock (125 MHz or so?), so 
it isn't worth enabling it on MP15. It is nice to see MP13 can do better.
