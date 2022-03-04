Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63B4CDBD2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiCDSKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbiCDSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:10:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A421CA5E4;
        Fri,  4 Mar 2022 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646417350; x=1677953350;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=V/bZBUMsYnI85haLHW2qBk7fMPvFA3wzMy4PTN+iSoA=;
  b=tNfk8EABYo1yLD/z/pOhGPasey3ZMDOZKw72gWEm9mJ81VD9wZJ6Ghl9
   TzNDlWLfPj+S3aVgk0L8hzLvT2LlFLvCNR1rEQEC9sAiPoRONIAfdGD95
   sQzaGuaT08UQ+98F89+wFpPE5OVs0AhdAZP2pjQDyg87GnH833B571ZH0
   szjO2Q9JkP5dMjrlPqQ+u3CO/XX8KfNeInJCZyNyVTjURG2VcueQMRnRt
   z19JOrs/dw0KZcOdt2SN82MalFSUMnPbBgQvbZW78agIOww355NCX2M7S
   Gdsd+BRjlRL7H914fJEwk5eGFyUJQ6i9rleCg4EbImYS8+bm3xlMq9s43
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="164568479"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 11:09:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 11:09:08 -0700
Received: from [10.12.73.230] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 11:09:06 -0700
Message-ID: <d3dfbe45-00d4-2131-9d42-32ce11b5c2f5@microchip.com>
Date:   Fri, 4 Mar 2022 19:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: at91: sama7g5: Allow MCK1 to be exported and
 referenced in DT
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <mturquette@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
CC:     <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <rdunlap@infradead.org>, <unixbhaskar@gmail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220111125310.902856-1-tudor.ambarus@microchip.com>
 <20220125010554.BB92BC340E4@smtp.kernel.org>
 <deb6ace6-adfc-bbaa-d31f-16d02a5f762b@microchip.com>
Organization: microchip
In-Reply-To: <deb6ace6-adfc-bbaa-d31f-16d02a5f762b@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 at 11:31, Nicolas Ferre wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 25/01/2022 at 02:05, Stephen Boyd wrote:
>> Quoting Tudor Ambarus (2022-01-11 04:53:10)
>>> MCK1 feeds the External Bus Interface (EBI). EBI's clock rate is used
>>> to translate EBI's timmings to SMC timings, thus we need to handle MCK1
>>> in the EBI driver. Allow MCK1 to be referenced as a PMC_TYPE_CORE clock
>>> from phandle in DT.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
>>
>> Applied to clk-next
> 
> Hi Stephen,
> 
> I depend on the PMC_MCK1 definition for some of the DT patches that I
> must queue for my pull request to arm-soc, for 5.18.
> 
> Would you mind doing an immutable branch for me to pull from, so that
> the build doesn't crash while the clock tree is not integrated yet with
> my patches?

Stephen,

I added the needed chunk in the DT patch. I don't need this anymore.

Best regards,
   Nicolas

> Tell me if there's a better way, as well.
> 
> Thanks, best regards,
>     Nicolas
> 
> --
> Nicolas Ferre
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Nicolas Ferre
