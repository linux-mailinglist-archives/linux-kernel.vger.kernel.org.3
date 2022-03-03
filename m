Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1504CBC3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiCCLPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiCCLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:15:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6615472B;
        Thu,  3 Mar 2022 03:14:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b11so7790739lfb.12;
        Thu, 03 Mar 2022 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s/D0SgAxUR3VSzGSe6y/eEiPzY/klLlpFUguwYZhOco=;
        b=QFCOHPqu0k6ef3uTAMQ85AgvdJkHyZ8H/Gh7zy/Xy/pA0QzglqkYbTNi8bPIfk7A/H
         wr2ihUk89QkfuzP/lBJMHHmlj0IvyF1dlNxd4ZHG2AyIeoSbhytZibMm8hbtoCxwTtpF
         IVx7sB6iPn+4yu0X6jTXuH/Z+eUbY0mMSbrbTB058mVTjNC8XJFYyYO2gSZA0/BxfizI
         ZYDojTK4yreR6imUbIyrcDHYyW5sO6KucaUBIXLWdoMFCHFaNgnUvD/gP6AtEDTtRsBP
         pVpcWW8fqjGgVaZ6lHo5rF9a0ybYSeZZQkrhns1NSyIbrOV5FqfybWZPTIEKsvcU6NUq
         qkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/D0SgAxUR3VSzGSe6y/eEiPzY/klLlpFUguwYZhOco=;
        b=fpsFdWjtALPXo1Mr7JTe/bKPuWIwf+SNUsHUJvue38H99x7OPJA49lC+Wu6lnG4yiT
         h7KBrfckQjE7oX/AQAX1kX8sPL2mXdhOpHoIXBYg6jfyY5A0ipKK2jtc/N0UWswr/GIn
         QWRCRxTMYkVzqyHjH9us8Q5YPrEOtYW+csZ4DFNL2+YOAuNAOmqh9pJrVvEAb4vIUHTk
         KwtVkXXcBkTL5iA5E/H4G1DPiUFXJ7oTHh2EE3nZH66gmaRbRC8h/pbRNnpOLxTXtakc
         AiFzGD0byGhCkVSMWgbQkKjPWKZ8XqzbhcEXJzdWDaXMKOM4Jvx9L2C6dH0IYcW//Kxy
         bsfQ==
X-Gm-Message-State: AOAM5305eYe3tKUaGtr7XhbsHFoVyq8mGC9/lEFFMQUg0AJ1aVOvHij8
        /PTmUaT0m5PDpS5QYNYD6GTcSEsjlAY=
X-Google-Smtp-Source: ABdhPJxpRCvkaXhNiwJqXp2IUYH0TYamY/1/yk7j8QFFWhZ/sotzPBr6Eau1BA0mdM1kMKKBBn5fDw==
X-Received: by 2002:a05:6512:689:b0:43e:da3e:42c3 with SMTP id t9-20020a056512068900b0043eda3e42c3mr21665276lfe.543.1646306055594;
        Thu, 03 Mar 2022 03:14:15 -0800 (PST)
Received: from [192.168.1.103] ([31.173.85.105])
        by smtp.gmail.com with ESMTPSA id q1-20020ac24a61000000b00445ba5b66dcsm367403lfp.220.2022.03.03.03.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 03:14:15 -0800 (PST)
Subject: Re: [PATCH 1/2] ata: ahci: Add new board low_power_no_debounce_delay
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220303100453.30018-1-pmenzel@molgen.mpg.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <74abdd89-863d-19a7-d90e-525036ca6a51@gmail.com>
Date:   Thu, 3 Mar 2022 14:14:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220303100453.30018-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 1:04 PM, Paul Menzel wrote:

> Some adapters d onot require the default 200 ms debounce delay in

   Do not. Perhaps could be fixed while applying...

> `sata_link_resume()`. So, create the new board
> `board_ahci_low_power_no_debounce_delay` with the link flag
> `ATA_LFLAG_NO_DEBOUNCE_DELAY`.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
[...]

MBR, Sergey
