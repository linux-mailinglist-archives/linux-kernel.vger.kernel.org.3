Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF7567CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiGFDv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiGFDvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:51:03 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF71E3FB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657079399; x=1688615399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nWXv72h/88bA9KDqkdclJQLLn1UNVvDpSy3/LQXeW3c=;
  b=Qm3LRsZXeUUOBBaYEB9HLsJiaBSCcrcutWr7Z46AhKe+9k3ZwBGEHRI2
   +2G3GxNJCz58f0SZmQejTCJdK3cOpIgNB0Xq1B6kdx8yjDf1KH+fDQxcI
   CuFAul04TyjK9Ms/SKyTSI5Mp62NjNCy2w7jktpM9mLBn1Skvg3+VUAWq
   ECL9YOYu4+KCn7GtsMEs3/0/3RzmxRjAoCXmfTU8BE4TI7dVSJzrWRlOI
   t5CRzchbznlypMtiKR9SAlHzWYZR7C7Xo5j6DIFZ9esQtLwNZejW6/NFX
   iNDx3pwxJGnqYQhyLZF0xC+5BLBN8fWriYvTWZpbRaU3yQyarRnEGBN39
   g==;
X-IronPort-AV: E=Sophos;i="5.92,248,1650902400"; 
   d="scan'208";a="205653587"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 11:49:58 +0800
IronPort-SDR: 63CFAoHyGhzzSDQHagMtnu2ReKoyH3zZvAluyKdIpgYPwSDEEphEnbn4wOmE6+M9UoUineVkXi
 oUl5nz/5kENmo6td+mORQyUaRYvnpr9VGr9JBJ5jNdFR8xg3epfSjRylYmnVpm2uqorzJpAgKE
 Yr4xefFc5rOTI5pzMN6iCXy3a04Il4odKWeYg3Etw0ZrYAqnTJO5sDshGO1LqdmAnhB0mwo9qA
 Vkp1KLEdU3fnlWGF6UKLpRZl1kkIODaUWCv3f5AChAZh0VHIV4W+w0ckVc5JgfSH0WtRgG95sH
 9oMWzt/I5lDTMrvPyiO/R5MK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2022 20:07:16 -0700
IronPort-SDR: eSV4xuAWo+hdTfnqnO7G1J2G4J1iTJ/v32GyE7DHK+b/4KLySSMA2qOldO9steFyothqeT2Npo
 VVVLkWR8v3t8JSvIfluHucE26x6Wl80s+im6pbMJQoI3MLhMVgT4yRzOECv49eMUNg7qR0LkLI
 JZ9DNjo5p+76wSctz9AdC1NGS077qRnTpsQ0yGnqygmynGpmUSYcU3TsqLquOwg6Q3rXC8SzMq
 bGv3cFrjjIT7bvc9DqIgqZMKu4VzBYSVxeEq9dFTqfwUxt0JI7yDzQtrr1yY+yjbghQltGoien
 t14=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2022 20:49:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ld5CN3fPpz1Rws0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:49:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657079391; x=1659671392; bh=nWXv72h/88bA9KDqkdclJQLLn1UNVvDpSy3
        /LQXeW3c=; b=nsPEh3kxlE7MqhvN3ZaDyASIGDCsqRg1j2EfcgKLG7Vy/56o+nO
        gTH2/zWFVqqi/8O91Lt2+Ne0RNdzEdBhpu6VbUqoWACPLWwx1OIniYii0AB2/Uyu
        H/uPpkOILPvsZYZCrZVkDTP5Cvyh/J+5y2e9azvx6X/wZkUamLwakVCSueTTqpfh
        4yNO76Ic1bibrnnbqYS52T/TPW4kT6e22aepwGJsEeVZx8fAKyH6AS8Evx7mYCVj
        PHhpDMgw8x3qXycgDjWY9Ai+Yx6fJHxL+122RCb+ALDPD8jM1NqrSBH9PKxtoxgH
        p2797YK5vNvqIsrIz56kcxEjGygqerYWYwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xIFnJhWQ3Q2q for <linux-kernel@vger.kernel.org>;
        Tue,  5 Jul 2022 20:49:51 -0700 (PDT)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ld5CJ61Zxz1RtVk;
        Tue,  5 Jul 2022 20:49:48 -0700 (PDT)
Message-ID: <53aa543b-a109-046d-beda-91a15ef5a487@opensource.wdc.com>
Date:   Wed, 6 Jul 2022 12:49:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] riscv: dts: canaan: Add k210 topology information
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Brice Goglin <Brice.Goglin@inria.fr>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705190435.1790466-6-mail@conchuod.ie>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220705190435.1790466-6-mail@conchuod.ie>
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

On 7/6/22 04:04, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The k210 has no cpu-map node, so tools like hwloc cannot correctly
> parse the topology. Add the node using the existing node labels.
> 
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Link: https://github.com/open-mpi/hwloc/issues/536
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  arch/riscv/boot/dts/canaan/k210.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
> index 44d338514761..ec944d1537dc 100644
> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
> @@ -65,6 +65,18 @@ cpu1_intc: interrupt-controller {
>  				compatible = "riscv,cpu-intc";
>  			};
>  		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +		};
>  	};
>  
>  	sram: memory@80000000 {


-- 
Damien Le Moal
Western Digital Research
