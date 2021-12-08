Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8194346C9E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhLHB1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:27:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52979 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhLHB1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638926640; x=1670462640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VCGiztZFtP/C7WAR4vZboInQR6f3D8gnC6Ty8l58+Pk=;
  b=G4UQKq1UWou2meTMhg8PFRKELmSzM0xt0d6WzxQX5lqDVm/7M9+yoRgm
   ckdGzmnrxFXEwwTW7S37JBK9yAQfYOUvsfiNJY+Ex6JdZzf1mj1k5qe/d
   6zo2x7oTHXhuHtKi+6hQECZU5LcZ3gc+YT9rids3FFBav9tdcEqJcmFCb
   q+QXGndMH1HoU26pyaq6FSD1vjnwypelGf7LWxG4otMOhl0Pqs8nRvc25
   WCTLzY1UEH3XZHCZlXA6oVLvojSjzjtXLG9tnzz3mueAPjXT0AHFw7NRq
   9df0o3NLcW5YjBw9KiuLDNII0HTZhI0Dvzh91cuCMY4oOhTecQ6NPzDZ4
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,295,1631548800"; 
   d="scan'208";a="188713201"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2021 09:24:00 +0800
IronPort-SDR: c1X9sPtoqcOxmnIx2aJmSfhuGMqaI4zA0PIovRpfWasCTfRPPfzofn3kxPA63GvCmrBDEr9txE
 8h4mMftrwqQWJ2gn0IQFuAsZdD3nScRhP2H/lzGwdtmZB6gAEZKz9M5NL9AMfxAs8Fmeqgo5df
 tY7yEfue3fPNhn9qA+1jDiCfibFDgIE0fjtvFtwe0QQGWX21ystdE6twJH0G01PQVU7bP5y/zQ
 M7iHU+vj2as/B1KomgdqCJuc9FvV4jzvMKJPyeVrLLT9QjGT+O701rvjhZ++yWJsSQ/q4d+rO4
 sPbSqOCnVcWHWW3Z05CIGu2U
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:57:03 -0800
IronPort-SDR: kUFf+NJssOI8IlEIojjGjDAB6zHBAlDVgYxzpV3YEJS5OxKzraRDkHhfZvTFP7AqCF6UNwimEa
 8k95RkKT55Cyz9jw9dSCKrTmTTnqUVdJP7+NdTZtRisQ9cUThOeihQHJXd5GcN6iIXatHXgYng
 nW7uK2f95TPaBF2vd58orl5MhRwFOCFFBeSzU97YV+PwHCngsolYHO5vpQmbljKyLJeKAyvVLY
 mPo2SGzGIET5e3AVdyVLCdpMXNviI8TO1BG9s6cRIZyfeyQznHd1RC2PKy81oFAU37ipnG0Unh
 dJA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 17:23:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J7zvy5WfWz1Rwnx
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:23:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638926638; x=1641518639; bh=VCGiztZFtP/C7WAR4vZboInQR6f3D8gnC6T
        y8l58+Pk=; b=rpxfrWJ8PXl9z6N9wFjxz1y+enP6ivOnx1AZxKc15RSXhjgwss8
        ahgE5xaeskLqaqMjx+2wHUg+FPiuKijoFBgyB/eei6+Uf7PHBsjT3G7zQBmPM3ux
        UBT69nmG65j5I5gZZbNAZrG2hT13YWtPikFtm7tj+WlFkNwOyxDL72nkdsXdGdi3
        jpxS8RrsnMxEHVV9ofzkZYEI+aBmCJDKBeaLSgCvsxMnaeKf4QpoeRF2LLOnsCfg
        1wfwamePfnbBagkD81fW5/LVtpuMJPYPGrfvAFzI/0fIsY3OJ/HJwUlkdY12RTTM
        2WYL5/18F3NHKCi7q8mKJZK7kuZEaUhtsTA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l_XcRSbo8ZlA for <linux-kernel@vger.kernel.org>;
        Tue,  7 Dec 2021 17:23:58 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J7zvr1H1Wz1RtVG;
        Tue,  7 Dec 2021 17:23:51 -0800 (PST)
Message-ID: <a9cdc25e-8819-30a3-8d21-81a2d429b7c2@opensource.wdc.com>
Date:   Wed, 8 Dec 2021 10:23:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v3 12/15] ARM: dts: NSP: Rename SATA unit name
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-13-f.fainelli@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208003727.3596577-13-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/08 9:37, Florian Fainelli wrote:
> Rename the SATA controller unit name from ahci to sata in preparation
> for adding the Broadcom SATA3 controller YAML binding which will bring
> validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index 1c08daa18858..ded5a59e0679 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -534,7 +534,7 @@ sata_phy1: sata-phy@1 {
>  			};
>  		};
>  
> -		sata: ahci@41000 {
> +		sata: sata@41000 {
>  			compatible = "brcm,bcm-nsp-ahci";
>  			reg-names = "ahci", "top-ctrl";
>  			reg = <0x41000 0x1000>, <0x40020 0x1c>;
> 

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
