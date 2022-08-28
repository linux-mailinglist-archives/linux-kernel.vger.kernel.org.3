Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6345A3E23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiH1Oj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiH1Oj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:39:57 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF168DECB;
        Sun, 28 Aug 2022 07:39:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so11120291ejb.13;
        Sun, 28 Aug 2022 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=NiFjRnJ7bmsU2lD4aMveRp5plMLktr2LgNRjl6l+jhE=;
        b=M4015tYDLw44HNicDgwwvu9foENd8yg5HyBuwomctyUeYp3edbsOzGrYypvWdapDdl
         jE68ZSqArQpWj9t8DDrXZ8VSiaz61q1htHtPq1NWlW/Eg3vb5MlOpmsfo59vGAWsH9JB
         yzWRunkEB3KEmvpV98eCHhPXR/s9XjyWQRfkB7sHBfGKYWvS09ezg303JvwQUDvpwqHT
         Ul8CbsA698qNE1PwykbFslLlf+Tm52fnNTE9n7On9Qq2dwdX3oqqOtP74MpVOK7cYbVs
         M1FRXJCfR6BHHbjNUXostnybeMIdBEmCvagnVOySI2X1B0XVqARmBtNtnVBR5XnzBu7i
         pm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=NiFjRnJ7bmsU2lD4aMveRp5plMLktr2LgNRjl6l+jhE=;
        b=uZ29gLp8aPT3Mn/eMAEOlyhDr/k7ylqwiPvoDEmf9VG+XhdJ3w7M5j4pNqz5YRywnc
         s7tMu0Byjr4QL/y7YcdiLAnZ61HbQWAObuYQQwq7lfjJmnkdMaBHXOYWJfkrptu4sqH0
         06c0ol5iNJgBBU8ANaLSVzaHdR6orczKJEBWk7fDjHrKtRiIwriu1A3rxhfoIb7hsjED
         vyiSCulimwxJWdKlcaDyKD5otxLTu6KzuuupbvTShYNMqJV2BfwuzKVORfRtdYuNyym1
         QrBe/t70OO2Z9EazL9LGYJVQPEo+amHt0kqCTSeyXANbpCBbj7I+cDytiQbrSaaJCk86
         gv6Q==
X-Gm-Message-State: ACgBeo1WQ0dQDWZqeUyZ+QhWATCE03pgCYMVWI9U59U2yaSTnpQmJALD
        WD9wZUfmXxkm275CpDLNa00yhbXrCpQ=
X-Google-Smtp-Source: AA6agR5kjZSHoe83cjdYdIPjeB+aIz0ODZaPfeQaFxNA11X0rQN5FZ3hhvmMy8NJrl7nssvR/KuqLw==
X-Received: by 2002:a17:907:a068:b0:741:3cb1:9ffe with SMTP id ia8-20020a170907a06800b007413cb19ffemr5516745ejc.293.1661697594533;
        Sun, 28 Aug 2022 07:39:54 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id o1-20020a170906768100b0073d5e1edd1csm3236547ejm.225.2022.08.28.07.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:39:54 -0700 (PDT)
Message-ID: <7be3df2e-2250-8542-1707-121373213fe1@gmail.com>
Date:   Sun, 28 Aug 2022 16:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: fw_devlink=on breaks probing devices when of_platform_populate()
 is used
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>
References: <696cb2da-20b9-b3dd-46d9-de4bf91a1506@gmail.com>
 <22bc845c-dffc-7967-a542-f0697feec603@gmail.com>
In-Reply-To: <22bc845c-dffc-7967-a542-f0697feec603@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.2022 09:36, Rafał Miłecki wrote:
> On 16.07.2022 22:50, Rafał Miłecki wrote:
>> I added of_platform_populate() calls in mtd subsystem in the commit
>> bcdf0315a61a2 ("mtd: call of_platform_populate() for MTD partitions"):
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcdf0315a61a29eb753a607d3a85a4032de72d94
>>
>> I recently backported that commit in OpenWrt to kernels 5.10 and 5.15.
>> We started receiving reports that probing Ethernet devices stopped
>> working in kernel 5.15. I bisected it down to the kernel 5.13 change:
>>
>> commit ea718c699055c8566eb64432388a04974c43b2ea (refs/bisect/bad)
>> Author: Saravana Kannan <saravanak@google.com>
>> Date:   Tue Mar 2 13:11:32 2021 -0800
>>
>>      Revert "Revert "driver core: Set fw_devlink=on by default""
>>
>>      This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
>>
>>      Since all reported issues due to fw_devlink=on should be addressed by
>>      this series, revert the revert. fw_devlink=on Take II.
>>
>>      Signed-off-by: Saravana Kannan <saravanak@google.com>
>>      Link: https://lore.kernel.org/r/20210302211133.2244281-4-saravanak@google.com
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> For me with above commit kernel just never calls bcm4908_enet_probe().
>> Reverting it from the top of 5.13.19 and 5.15.50 fixes it. I believe the
>> same issue happens with other drivers.
>>
>> Critical detail is that in DT Ethernet block node references NVMEM cell
>> of MTD partition (see below).
>>
>> Could you help me dealing with this issue, please? Can you see something
>> obvious breaking fw_devlink=on + of_platform_populate() case? Can I
>> provide some extra information to help fixing it?
> 
> Any ideas about this problem / solution?

I didn't get any reponse for this bug for 6 weeks now. Is that OK if I
send a revert patch then?


>> Relevant DT part:
>>
>> partitions {
>>      compatible = "fixed-partitions";
>>      #address-cells = <1>;
>>      #size-cells = <1>;
>>
>>      partition@0 {
>>          compatible = "nvmem-cells";
>>          reg = <0x0 0x100000>;
>>          label = "bootloader";
>>
>>          #address-cells = <1>;
>>          #size-cells = <1>;
>>          ranges = <0 0x0 0x100000>;
>>
>>          base_mac_addr: mac@106a0 {
>>              reg = <0x106a0 0x6>;
>>          };
>>      };
>>
>>      partition@100000 {
>>          reg = <0x100000 0x5700000>;
>>          label = "firmware";
>>      };
>> };
>>
>> ethernet@2000 {
>>      compatible = "brcm,bcm4908-enet";
>>      reg = <0x2000 0x1000>;
>>
>>      interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
>>              <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>>      interrupt-names = "rx", "tx";
>>
>>      nvmem-cells = <&base_mac_addr>;
>>      nvmem-cell-names = "mac-address";
>> };
>>
>> OpenWrt bug report:
>> https://github.com/openwrt/openwrt/issues/10232

