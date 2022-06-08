Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613C5427CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbiFHHTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiFHHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:06:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99463B3DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:50:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq6so26456649ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q3uqwWR5TDfVq8mIE3XSiAy0XCktsNQOd1dNc8KMqlU=;
        b=qOACvBLytlSPu/voOY0sdKTL1YDDNSi0+JU81j2PcNE3DkvGLmP21vYDv2yz/58PUN
         gwG/QDqTwvIweE6bVAfiYbOTUgBBbB+ja+7nkZNN6hvU8qPkPRKqcM4yOe3h9QdCCMXt
         ufaXncTIRX3ZGLRuttTfRdEyraOLT5UI7HQp8cu6ohOJQkJ/PQkj8HgkfSHLiL7O2lq9
         1GNPngVI2GsSpiZR4ZSfsex65ECMVbsnuooxxyuRNd0sgagcW8OdWVrySgsLQCnag29S
         FNO92oUW1QvSS05d1rzZzPOSlOc6ykOw2MUXiaDuFZT/BJLCC8T0mNecvP87fNw4UFUN
         2FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q3uqwWR5TDfVq8mIE3XSiAy0XCktsNQOd1dNc8KMqlU=;
        b=7wTq/ze8y2se++E6XKlUyFfhD4SFi7U+JnW3YrakAfTMQFyI9RjqpkYHv2MHHvreF2
         jn3/1WnBcALVVrZkkMQeRXvhh31/RMRwR92/vXWp+sBs2bUoq0hUmDiSAOfXbVT532t1
         E0X+NgaHqWiUTKIapNlMo/HsA5HYXy9dUQr6tR09VRan7/AKWNNlRGvWvzl1shlokfBq
         gBTa/G7GR6nT12MVKWvLtVmaHV57H2nT75yUBHeQx2rQuToSZgQeS7EXAZl1AdSULx58
         7FhkE7clgwn253kZXjvWj0xOWTpaSFEJCGdJSrtlPqMLz1z3z/4TJfsIXUBXLOfoAVKM
         05GA==
X-Gm-Message-State: AOAM531XdgSxL/RqYdL30XUzLtWeDHQ45g4gI69mgQhhmhZyIaM2KbAQ
        8hFaksa6rUyDKckiagP+E6PECHfdBLs=
X-Google-Smtp-Source: ABdhPJx7gCFrR+QW3nkbkg/yiim77GsgeBcvxudU20b03iN266b+VCXaYZk8nUvYwtdIoj83yFX4Vg==
X-Received: by 2002:a17:907:60cc:b0:6f4:ffba:489 with SMTP id hv12-20020a17090760cc00b006f4ffba0489mr30434407ejc.666.1654671007136;
        Tue, 07 Jun 2022 23:50:07 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb79.dynamic.kabel-deutschland.de. [95.90.187.121])
        by smtp.gmail.com with ESMTPSA id vj3-20020a170907130300b00705f6dab05bsm1691081ejb.183.2022.06.07.23.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 23:50:06 -0700 (PDT)
Message-ID: <ded4b3f5-a9bc-4612-33cc-68bd85cb92fe@gmail.com>
Date:   Wed, 8 Jun 2022 08:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [BUG] staging: r8188eu: driver stopped working with commit ("staging:
 r8188eu: add check for kzalloc")
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
References: <20220606064055.12565-1-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220606064055.12565-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The driver does not work anymore on my system. In dmesg there is:

"r8188eu 1-4:1.0: _rtw_init_xmit_priv failed"

I bisected it to commit f94b47c6bde ("staging: r8188eu: add check for 
kzalloc").

~/kernels/staging> git bisect bad
f94b47c6bde624d6c07f43054087607c52054a95 is the first bad commit

At the moment I have no time to look further into it.

regards,
Michael


dmesg after plugging in the device:

[15075.514705] usb 1-4: new high-speed USB device number 4 using xhci_hcd
[15075.750717] usb 1-4: New USB device found, idVendor=0bda, 
idProduct=8179, bcdDevice= 0.00
[15075.750729] usb 1-4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[15075.750734] usb 1-4: Product: 802.11n NIC
[15075.750738] usb 1-4: Manufacturer: Realtek
[15075.750742] usb 1-4: SerialNumber: 200DB02CEF8F
[15075.767685] Chip Version Info: 
CHIP_8188E_Normal_Chip_TSMC_D_CUT_1T1R_RomVer(0)
[15076.121994] EEPROM ID = 0x8129
[15076.123218] r8188eu 1-4:1.0: _rtw_init_xmit_priv failed
[15076.321389] usb 1-4: reset high-speed USB device number 4 using xhci_hcd
