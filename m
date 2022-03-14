Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD344D7C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiCNHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiCNHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:37:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1740E53
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:36:29 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B64983F1A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647243388;
        bh=iAtSOaeLKxQsN9oiK9IKSKgSGPin9K0zGNTzo54gjLk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fW7mgzPlpFdlSxgoPf6Hl9E9FLnWnMQ179nl9GXke2u/9tiptQkHrB5xqbzuM9Uhs
         Hzhr0HussrdLI7abMsDvL7yBPeuJyxCi5dPIyJUoiyLZ5B1rMRcChfii1pxJTGssNk
         2DFBYUwnor7hqYy94lI+3fdiBWr2KruND48wM/lLwWdxhM9XLjhZRxGGahuH5Fqp12
         UZEldJFI3y21PQ1QBWq4ZUr8mUpeP9c56fT6tMAdEurf+sar4qa5Na4DX5fQ0a9Q7h
         40/4suXF5w1vM/YFEFh9PgkgAATq21x4sGv7UOT7rmzAQqdNydQNpRMlnAGjDY90Cf
         aFwBRuhHsygrQ==
Received: by mail-lf1-f72.google.com with SMTP id bq6-20020a056512150600b0044840cccf4bso4394872lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iAtSOaeLKxQsN9oiK9IKSKgSGPin9K0zGNTzo54gjLk=;
        b=vArBQHZJhjJ0GUVe71Cp+05+DGxhWX2CoUkdvT2HWa/SOSUXgZacdFSt264b3HbfHi
         m9iUNj4+befydJy2ZjhW98PM1kqSMWsNB7tcwMkHMyv/3WWXA+P83NvvBhumLw43iBkf
         ifhk8/xhbN6GIlj24/CONnhwnGRJx6sgU6NFsv3VZZ+GuymuV+yasImV/dow8Gb2Xjek
         C7GoTYrusyz7TKwTxW2WHA0ayQH/Lp6Qgb6GXukDMNTuIxrwu25DTOGeLLn9by6f9Cw2
         Q9sRfQ+TipsCYVIzRZmtRMNMV1TnNFQN3JiTUK6jArKrQB7e5d9TIilZUH9xL8QXSBgR
         VSjw==
X-Gm-Message-State: AOAM533Ovvk/nrtOuah4MsBHxhwsNiSgBaEVqQBu3XGtMBSJcooro7rN
        qPo9Jpeqf3JpCwKfimAwQ3/+m5Afba2MAv4evVOkpH+IQmY60niS+UpZFvrZeM3tkY4vTHUHMkO
        wDHOf0iDjdg1bbEuBV7p1LJIAlmWmappiPkF47Jhz/w==
X-Received: by 2002:a17:907:1614:b0:6db:e3f7:2cb4 with SMTP id hb20-20020a170907161400b006dbe3f72cb4mr255444ejc.435.1647243377971;
        Mon, 14 Mar 2022 00:36:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycCN76EHq9M0eAQGZvA10vpA52jlIoM5/wMGxfvQsd+ClzDaAgk2gAPmK0IIzzn0h6WBnHrQ==
X-Received: by 2002:a17:907:1614:b0:6db:e3f7:2cb4 with SMTP id hb20-20020a170907161400b006dbe3f72cb4mr255415ejc.435.1647243377741;
        Mon, 14 Mar 2022 00:36:17 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm6448816eje.173.2022.03.14.00.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 00:36:17 -0700 (PDT)
Message-ID: <143db512-0223-1553-c141-2dc24a23c430@canonical.com>
Date:   Mon, 14 Mar 2022 08:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Content-Language: en-US
To:     Medad Young <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-4-ctcchien@nuvoton.com>
 <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
 <CAHpyw9dHau348qJB6g+fCcKqWByUsRHAGwb_mdUg=hjhW+xNsw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAHpyw9dHau348qJB6g+fCcKqWByUsRHAGwb_mdUg=hjhW+xNsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 06:32, Medad Young wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> 於 2022年3月11日
> 週五 下午5:15寫道：
>>
>> On 11/03/2022 02:42, Medad CChien wrote:
>>> Add support for Nuvoton NPCM SoC.
>>>
>>> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
>>> ---
>>>  drivers/edac/Kconfig     |   9 +
>>>  drivers/edac/Makefile    |   1 +
>>>  drivers/edac/npcm_edac.c | 714 +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 724 insertions(+)
>>>  create mode 100644 drivers/edac/npcm_edac.c
>>>
>>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>>> index 58ab63642e72..757e1d160640 100644
>>> --- a/drivers/edac/Kconfig
>>> +++ b/drivers/edac/Kconfig
>>> @@ -539,4 +539,13 @@ config EDAC_DMC520
>>>         Support for error detection and correction on the
>>>         SoCs with ARM DMC-520 DRAM controller.
>>>
>>> +config EDAC_NPCM
>>> +     tristate "Nuvoton NPCM DDR Memory Controller"
>>> +     depends on ARCH_NPCM
>>
>> || COMPILE_TEST
>> (and test if it compiles)
>>
>> (...)
>>
>>> +
>>> +MODULE_DEVICE_TABLE(of, npcm_edac_of_match);
>>> +
>>> +static int npcm_edac_mc_probe(struct platform_device *pdev)
>>> +{
>>> +     const struct npcm_edac_platform_data *npcm_chip;
>>> +     struct device *dev = &pdev->dev;
>>> +     struct edac_mc_layer layers[1];
>>> +     const struct of_device_id *id;
>>> +     struct priv_data *priv_data;
>>> +     struct mem_ctl_info *mci;
>>> +     struct resource *res;
>>> +     void __iomem *reg;
>>> +     int ret = -ENODEV;
>>> +     int irq;
>>> +
>>> +     id = of_match_device(npcm_edac_of_match, &pdev->dev);
>>> +     if (!id)
>>> +             return -ENODEV;
>>
>> Why do you need it? How such case is even possible?
> this driver is used for two nuvoton SOCs, one is NPCM845 and the other
> is NPCM750

Yes and how NULL can happen for OF-only driver? Unless I missed
something and this is not an OF-only driver? Do you allow any other
matching methods?

Best regards,
Krzysztof
