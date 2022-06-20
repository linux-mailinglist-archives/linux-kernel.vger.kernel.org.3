Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8C550DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiFTAZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiFTAZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:25:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A5AE56
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655684750; x=1687220750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H0ulQrMBtA6pu622Zq7Ff/HeEgzOhbo0ZUSX4iWBZhA=;
  b=fh76NxPmRGOgyr/0xod1RKejvMvIuP8S9XN2kFMYpdFZermMuCqi62Za
   6H27kujaphN8hmkSmAuhLwFrIz4p02995RkG6G1xQZePYrF+A+YxixmKk
   jOPH3xBNArQDhmBh6xoz0U0wEEZWJPbWskgmf4prBL0qSqmGS/0XuXsR1
   coI3zkMLdsncDbXXy5UGJwBXYxBvrJhnGmYMiZKH1tPT/G7E8BiXjJ7nU
   1KQm084H6ULPsaI2LIH8gmtcsBpucNIQzXF1lWIJom/poF65vpxQhGPUY
   7liITyZpDZIJf7rDhyhyojVfpfxKHHPgLzW153oWobg0SK3Jcw7q3H0Dd
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="315672136"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 08:25:48 +0800
IronPort-SDR: Dn4MvH6iLy3mLCMRizYxaVkZbufTbEx3fy68kTeyIIo3CK98/Lz8eEButMT+b5rQfJGvUcPr6H
 OLSHSV6XsZUwJYg1zpAQ1wXqvCCYMbkl7O1tqq+kg9p36wH5VA2DsiAJxhhRN15uoGwEXVoe20
 r3Ao9jNNhDu7+X7SIQKjxzfHHVwdZGB9PIZehNKmJ5AVoU4YedOnjyJjuKBGOeXrf9TKLCDX+V
 ETf8x1SG3hZKbsV4zuPpcsL2avqW2ErBK08eqtWrywNJ5Uz1lkfUT75GXdJLY+UP287t1RTbVn
 ZSiBpddTOFpZwJZFusq2hvnl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:43:56 -0700
IronPort-SDR: G8Qqr7+gLYwTRcOuA3+oV5t6pgyp/5wvR1XfmlOBhLZ4d8kn2pE2EFb00TyTriPIJzqN4Gnekm
 tBYLHhii+WOrXDQQfYmmiZL4oJcVqzaBKaL98e53D410F2Q55E0Xva4CXgFwVzjWJb3Cy14L5L
 Lz5su1652s6eMQh7LUwHhXzT9qEDtuoZoNOMJqNGvkSp1tMbhFMAd7OEZbBHPAL7e2pINvwzqI
 IocE606w+ghuH2y/zQIzkGFAcCCjOgbLY9cENB8L/YP87BTkulBTtuqAfvULDdsr6VFByVXcrG
 Z+M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 17:25:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR9RH2CGDz1SVp2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:25:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655684746; x=1658276747; bh=H0ulQrMBtA6pu622Zq7Ff/HeEgzOhbo0ZUS
        X4iWBZhA=; b=C9w0xWLFB/KaDMQ+IzY1oZGaVKgyVSWgQTN/9sJJGaofpjPKWWt
        ZKKgIMwWS1Dy3N+AKNLls5E2/TsxAp6rP+S9l0Ik2SK7XIV5qtlSHKwhGAwp4LxJ
        6gePz+4huJUkrzHySdcijhxdigID+rEmfTDa4Wt/eP1LPIzIGKKw5KxzF3Dtmtap
        p5Va13Ox1XAtZ0OpzHoWucY1cenLs5OjDloywiS4JT1zdmVBZAj8Mo2U+pX+WsHX
        Xq2w2dDe0rAcZyAfGZlDDozsM67SwB5DYyhQRX3WWnevylp14JZ8tNudXLaciW4o
        qUyYE7ltn31FuS+79D85xj771kaXmkpnCiQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0rM3TSwnS-uS for <linux-kernel@vger.kernel.org>;
        Sun, 19 Jun 2022 17:25:46 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR9R75cZsz1Rvlc;
        Sun, 19 Jun 2022 17:25:39 -0700 (PDT)
Message-ID: <891cf74c-ac0a-b380-1d5f-dd7ce5aeda9d@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 09:25:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 07/14] riscv: dts: canaan: fix the k210's memory node
Content-Language: en-US
To:     Conor.Dooley@microchip.com, mail@conchuod.ie, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        sam@ravnborg.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, fancer.lancer@gmail.com,
        daniel.lezcano@linaro.org, palmer@dabbelt.com, palmer@rivosinc.com
Cc:     tglx@linutronix.de, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, masahiroy@kernel.org, geert@linux-m68k.org,
        niklas.cassel@wdc.com, dillon.minfei@gmail.com,
        jee.heng.sia@intel.com, joabreu@synopsys.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-8-mail@conchuod.ie>
 <9cd60b3b-44fe-62ac-9874-80ae2223d078@opensource.wdc.com>
 <e1fbf363-d057-1000-a846-3df524801f15@microchip.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e1fbf363-d057-1000-a846-3df524801f15@microchip.com>
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

On 6/20/22 08:54, Conor.Dooley@microchip.com wrote:
> On 20/06/2022 00:38, Damien Le Moal wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 6/18/22 21:30, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> The k210 memory node has a compatible string that does not match with
>>> any driver or dt-binding & has several non standard properties.
>>> Replace the reg names with a comment and delete the rest.
>>>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>> ---
>>>  arch/riscv/boot/dts/canaan/k210.dtsi | 6 ------
>>>  1 file changed, 6 deletions(-)
>>>
>>> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
>>> index 44d338514761..287ea6eebe47 100644
>>> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
>>> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
>>> @@ -69,15 +69,9 @@ cpu1_intc: interrupt-controller {
>>>
>>>       sram: memory@80000000 {
>>>               device_type = "memory";
>>> -             compatible = "canaan,k210-sram";
>>>               reg = <0x80000000 0x400000>,
>>>                     <0x80400000 0x200000>,
>>>                     <0x80600000 0x200000>;
>>> -             reg-names = "sram0", "sram1", "aisram";
>>> -             clocks = <&sysclk K210_CLK_SRAM0>,
>>> -                      <&sysclk K210_CLK_SRAM1>,
>>> -                      <&sysclk K210_CLK_AI>;
>>> -             clock-names = "sram0", "sram1", "aisram";
>>>       };
>>
>> These are used by u-boot to setup the memory clocks and initialize the
>> aisram. Sure the kernel actually does not use this, but to be in sync with
>> u-boot DT, I would prefer keeping this as is. Right now, u-boot *and* the
>> kernel work fine with both u-boot internal DT and the kernel DT.
> 
> Right, but unfortunately that desire alone doesn't do anything about
> the dtbs_check complaints.
> 
> I guess the alternative approach of actually documenting the compatible
> would be more palatable?

Yes, I think so. That would allow keeping the fields without the DTB build
warnings.

> 
> Thanks,
> Conor.
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research
