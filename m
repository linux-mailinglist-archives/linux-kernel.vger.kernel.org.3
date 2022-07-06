Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E129E568766
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGFLzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiGFLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:55:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6632872E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657108521; x=1688644521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9/V+jeecOKQ9buv2Jjb6PxTGk0efO8S6cyBl2B3zFEA=;
  b=YI9Hcz3pokaCpnGtHzeBd69MF60SNL/+IQq3eltIeYJlzrydIBVsqebI
   pUVPe/c/mxvuZ51Rt6GIWVbn/pcm0T+/K8hw/l/tGGI65NZA8hwZcClYW
   tJ2QDbfs8KMNZ86qb+gyQt+rmPeBBJCiT9Ra0lwvIH7dMQTx5BMR5t31V
   IJjeDtgW3V4062fIM0B5Ogg1rQ4TI47lYUkOJcubYkEfDVLiErIPgRd+L
   dp+t8JGellvBanNCho/33It1W12FbUuj7gPFoCr/I3ZEZievCkbHhSrA/
   TOj3/EO/U3xPD7eJHyi+X8CaoazlAHwB32zCutxXnxEp8iYeTrgc4dNlL
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="317104792"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 19:55:20 +0800
IronPort-SDR: PII+8mNsJChBVPl+C/vglih1JxEGi0A0pKBZBFKrT5AxqJiIKGWThi5DmSxieKvSuemuEv7tLU
 E7fOPTzB48gM/eVMzx7sGHvxyXCIKam4sq7flWYCLjcrE8v8StiXD0xoPtIU01nUPH+rqcergf
 D+m/0eO2Ld1uOWJ+gOV1dKo1Y+qRr7WfA+xF+h1FVEz4z0I8vv2tS05+1RUH1P4duMB7B7WXbE
 hvhuK7P+4jiPnenxpBVj5dCjgihyiExrHLTCByx/q+akGzDvYnOp0yr1Tdhmj1Y0yn7+TsCzkQ
 Yz91Khita93Vqlb5DHFgHEEc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 04:12:35 -0700
IronPort-SDR: n/0D79jwtCAVks1ZCjO4b0R+XmFG3ncAwrigT0cV3WuHG7tFO8gY+85hg8QJ/zKu1pXZysXcZU
 /fwUB40SUj/OW2dXzLtcj2bhszfOmc9G6gmTshmP2DjnY9bppsXBe/zzmEg2pUlI0EVpKZNNGC
 IlIoiEXL6GV3WWmsmPpBH6sunAh/OxHXCNfPBhFnLNdsNAUe90pcMV30cdZvphWYjXj85wAzLU
 LwWUU6W1euBzkaMmL/1Jcj+pThmAoTxQcA++SrG1UwV6ZvGBknFtJ4YgJ2E/Mi/IahzxX3Fu/M
 WXE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 04:55:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LdHzX18DFz1RwqM
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:55:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657108519; x=1659700520; bh=9/V+jeecOKQ9buv2Jjb6PxTGk0efO8S6cyB
        l2B3zFEA=; b=NQqp5LElpaPKjMMZjQfdqYiZ5oumHP+P3Xd9GbrdNrgubcqbuFF
        adZTCfmZR2OSi/yQBwGd1r9Fyz9gtX1zz2Edg5JvjbZ5+jAU55bzfaD8vxC0iJxK
        FjmDyQOzpQU2eV1RvmsxAylj+iyL3S0HnnEsdADgICDknHx7sSIwr0GbZvgJaV3n
        PJ1Og/9rjksgt7jbSeDxdiawvaeos+wfkUYIkw3pCwPtPk5D+S/PnvyyeBpIoXg+
        9y3tCzBiOMlQoUtJ3MRp853f+H9VMlDdbTwFDYdYZu9QNWBTBFn9K5BHwTTYfw13
        JQXd2jB5amVQD43Q+484ebY5u5692zA2SIw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZxPPFwWjHzLI for <linux-kernel@vger.kernel.org>;
        Wed,  6 Jul 2022 04:55:19 -0700 (PDT)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LdHzQ65N7z1RtVk;
        Wed,  6 Jul 2022 04:55:14 -0700 (PDT)
Message-ID: <160267df-2f3f-02f7-4a4d-21baf60c4a44@opensource.wdc.com>
Date:   Wed, 6 Jul 2022 20:55:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/13] Canaan devicetree fixes
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20220705215213.1802496-1-mail@conchuod.ie>
 <CAMuHMdVOK+iHeTfRLDeMF1mwZoeH1KH_GHuCY72YnhQibGqhwA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdVOK+iHeTfRLDeMF1mwZoeH1KH_GHuCY72YnhQibGqhwA@mail.gmail.com>
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

On 7/6/22 17:03, Geert Uytterhoeven wrote:
> Hi Conor,
> 
> On Tue, Jul 5, 2022 at 11:52 PM Conor Dooley <mail@conchuod.ie> wrote:
>> I *DO NOT* have any Canaan hardware so I have not tested any of this in
>> action. Since I sent v1, I tried to buy some since it's cheap - but could
>> out of the limited stockists none seemed to want to deliver to Ireland :(
>> I based the series on next-20220617.
> 
> Digi-Key does not want to ship to IRL?
> The plain MAiX BiT is out-of-stock, but the kit incl. a display is
> available (97 in stock).

Seedstudio is out of stock on the MAIX bit, but they have maixduino, which
is the same, almost (pin wiring differs, everything else is the same).

https://www.seeedstudio.com/Sipeed-Maixduino-Kit-for-RISC-V-AI-IoT-p-4047.html

And you can still find plenty of MAIX bit on Aliexpress too.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


-- 
Damien Le Moal
Western Digital Research
