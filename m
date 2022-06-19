Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93956550DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 01:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiFSXjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 19:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiFSXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 19:39:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCD695AF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655681941; x=1687217941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+r2le/0cYQHWtPMNeCxIXB43Y8pcNDHfGVPeVoKPk1w=;
  b=ODvQIvsj4/inldhW2r1OICP7j5m22R0DDYoHUC0D4cr3lHjciYU6Zbkl
   vDGymfV380l91uJmDkp/jwY4ykNtAoYC8vt5nyv10KJmQhDaWkx8j7l0j
   Lup1N8BU/pifgZbDy1t9rNBF50Pj99+s00pyHEcBf2Ul4Bd/kTeJTS076
   X43SyyQIsQtid5/fl0SSZ3MJ5nqcjNMfitL1cE9fka3QS0mpYJdgTbg0J
   5n2Zt0nXfe2C/BscIILk9ivuwcV1EiQmvLkaW4Fe1C5mttdlZ5SyEuNq0
   JKzidrVF8wxSjVXGk30GWMPjvqtYYgsGUDCFR0dOq/7ausjdEGeazQkE6
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204332795"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 07:39:00 +0800
IronPort-SDR: QCYeH+A9l/cmivQLMKSU7mg+dpvCr6PDKSW4Wp3EtMtNxvcXCoLFzFH40quorTaz1bxHVJc0tS
 q6gmNRArajJTv6Gv+PfXfaxpF/gKl1h3S2guEB9AjX6orEt9qEvh0EB5kDyWajevMFG8lTgenS
 1opvIcOZjU/PNvze/YhPDB5KVIgU03W21u3O2Gfgdn8qzPqpw5HLfNct1Icts6uyreALcCYruX
 RxQpy2MZEuEzXQqdCI95aX1hJh5IjQ/oC59KgKzqqv8i847BLIKhpi+MQ3aF+n2epry92pSnX1
 ngGa++p+MokkTkukJcFwupDj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:01:31 -0700
IronPort-SDR: bP9EGVddfuEE8MJWuVne+3EV8rSpPRS5kb0q9ncodyK6RO6jyvYf41BvWCTKFqSl9jNyZ6GFC2
 3aLq8IqkEZEmY5w9o2H6lIXydetVROp1IvlHRrd8NuEsI1KJJ+ZXZo81LjtzvA9UpF38J60lIq
 yjeyAr3PG9ZExiXgVOpXwYoSKcmNMtb0glOt1pB7aujSmAh0o2cwWGeVsMYbFCY8QeyBu2K+ji
 KTETqqcvJRpxS3daZ9W2HaNBlDXAAeGDoUCqXuS/fLAOhSeNS/nb1wlRRme8185oQ4LOc9Sx1m
 tA0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:38:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR8PG6rcSz1Rvlx
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:38:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655681938; x=1658273939; bh=+r2le/0cYQHWtPMNeCxIXB43Y8pcNDHfGVP
        eVoKPk1w=; b=N/n66b6ClqCR6Od52OpL/EjMQwa7gGRAGjE1Ujgk9H7xtwRIW25
        EZRWVGhphTf0s9eYUdMH0D7THn1PazXSs6q2M/FS5hiPVHp3V1G2l/aQ2rfqc//u
        wKPEmQvqQwcU4CICmUM9WSF730D03I82SE1u/8QwSsguDWkjwYt4EdQR7MJGR8He
        kYe7+a259CQJSHTSSRoNNZdV7b7cnCdwVJe19lwMoFXtlVUFjge0fMpLIXsn2unv
        iBw8XBXi7i+yunFeX7USJpxA8MUtNICuwAOR6EbBSo5onKDz/7XlWDr5D+0QNafI
        XAaH0chJm4oPHzPOs9sKI97+WCZ54PG+37Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wxmyRtyww3SR for <linux-kernel@vger.kernel.org>;
        Sun, 19 Jun 2022 16:38:58 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR8P82TBvz1Rvlc;
        Sun, 19 Jun 2022 16:38:52 -0700 (PDT)
Message-ID: <9cd60b3b-44fe-62ac-9874-80ae2223d078@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 08:38:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 07/14] riscv: dts: canaan: fix the k210's memory node
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-8-mail@conchuod.ie>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220618123035.563070-8-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/22 21:30, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The k210 memory node has a compatible string that does not match with
> any driver or dt-binding & has several non standard properties.
> Replace the reg names with a comment and delete the rest.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> ---
>  arch/riscv/boot/dts/canaan/k210.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
> index 44d338514761..287ea6eebe47 100644
> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
> @@ -69,15 +69,9 @@ cpu1_intc: interrupt-controller {
>  
>  	sram: memory@80000000 {
>  		device_type = "memory";
> -		compatible = "canaan,k210-sram";
>  		reg = <0x80000000 0x400000>,
>  		      <0x80400000 0x200000>,
>  		      <0x80600000 0x200000>;
> -		reg-names = "sram0", "sram1", "aisram";
> -		clocks = <&sysclk K210_CLK_SRAM0>,
> -			 <&sysclk K210_CLK_SRAM1>,
> -			 <&sysclk K210_CLK_AI>;
> -		clock-names = "sram0", "sram1", "aisram";
>  	};

These are used by u-boot to setup the memory clocks and initialize the
aisram. Sure the kernel actually does not use this, but to be in sync with
u-boot DT, I would prefer keeping this as is. Right now, u-boot *and* the
kernel work fine with both u-boot internal DT and the kernel DT.

-- 
Damien Le Moal
Western Digital Research
