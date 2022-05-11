Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83AB522CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiEKGvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiEKGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:51:27 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882357128;
        Tue, 10 May 2022 23:51:19 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id d5so1527136wrb.6;
        Tue, 10 May 2022 23:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1wEl4hKP70nqNM7+s33aDLROWITXXzeuUXQCyFgNxKQ=;
        b=fL0QpNLjw5Bu1FPrB1EV69pKMr1WMiaxGDyNCVRaUu88Bdh1KTpsixQhD9bddg7O+u
         6Rvz0mzL/8eE4ABC986jenh9G4Kw7NCZqqmkwbDj02D2UNWsh14SR/maEjFDo2OxI2gj
         Lk+rHMVrXcEl+uIjjiaaY5mMAGV2ypdg4W7V20ejr8UNBYDll3HZv9lktTcS1Lnz+sPn
         0Mwf2Y6F08Nq5wTIm31d8qBM5kyCtuiX7JEsILRPAeDBk6KglhUDvYf03Z1RfpUG1jfF
         WRxTmTq866PI9cwsOBGHYQyf2C7eRHcvciooxoepfEylwhINYPyqS8KGR8xoLro166J9
         VTwQ==
X-Gm-Message-State: AOAM530BpgUxgyylrVAGSsY/zJipdAQrKOw5EMpW/1mQrb6Hj/7i2q9j
        g6JLWtUKKY1Y3eLDXkJG0jE=
X-Google-Smtp-Source: ABdhPJzvSiFXK+Pkx1A+5Jgez3pwE0NnwYeWyDPJFd2IMdUv3cDPSfUbrL34eucFRES0Ji7AeRNSEg==
X-Received: by 2002:a05:6000:144a:b0:20c:6b73:804 with SMTP id v10-20020a056000144a00b0020c6b730804mr21963700wrx.88.1652251877878;
        Tue, 10 May 2022 23:51:17 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c424500b003942a244f3asm4242899wmm.19.2022.05.10.23.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 23:51:17 -0700 (PDT)
Message-ID: <e9a112f8-a35b-1df4-0567-9fddf80c8e17@kernel.org>
Date:   Wed, 11 May 2022 08:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Content-Language: en-US
To:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-serial@vger.kernel.org, sumit.garg@linaro.org
Cc:     arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, gregkh@linuxfoundation.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, peterz@infradead.org
References: <20220511062113.2645747-1-hasegawa-hitomi@fujitsu.com>
 <20220511062113.2645747-2-hasegawa-hitomi@fujitsu.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220511062113.2645747-2-hasegawa-hitomi@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 05. 22, 8:21, Hitomi Hasegawa wrote:
> --- /dev/null
> +++ b/drivers/soc/fujitsu/a64fx-diag.c
> @@ -0,0 +1,155 @@
...
> +#define BMC_DIAG_INTERRUPT_STATUS_OFFSET (0x0044)
> +#define BMC_DIAG_INTERRUPT_ENABLE_OFFSET (0x0040)

And I noticed here, I would:
* remove unneeded parentheses
* drop the "_OFFSET" suffix
* just write 8bit values (0x40, 0x44), given they fit
* order them numerically, 0x40 goes first

thanks,
-- 
js
suse labs
