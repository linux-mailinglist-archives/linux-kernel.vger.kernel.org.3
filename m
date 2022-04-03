Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7664F0876
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355651AbiDCIqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiDCIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 04:46:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44935DCB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 01:44:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k2so410533edj.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xfVP9oZn0/BE7WrrGSxvCysoPKHtw6VApFuE82wzSUY=;
        b=fuyvg/Rki7ORmk6z35agkDIa3JB+Kcq0XudQdz+cdYkCdy6eMJpqcjCm0M4h6Yu3qk
         0lWRGUxd5stxr52H+cb2cs1PLw/z5UBU0V2kvESeBRaffBXsi3MCTkp1Txl8n9wdHggi
         YtGiTGcvKvNDeTe/xKmfozTqZK/y6rFXHhl9RC7WB7NRkTD822NsfDLNTg5glmnkBFX5
         MnmyMQzTsv808Aywg0tcE9QOquqimyB/sKIMqTGqcrL2CyLUctTkKDn5/9uRnQ2AvYr6
         pWe6MmfPe0FK8fD3IL3+UfTJyl8/VejC/OHhhK3tMYy3FlzKT+iNgyyVSq4immMGJzU5
         ++1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xfVP9oZn0/BE7WrrGSxvCysoPKHtw6VApFuE82wzSUY=;
        b=tGYIp/ZZpFiMiLAylR6NdVLzPF3eMgf6Q44nrByN0BwWB/an4aeYwbe6v+1dU3JL8r
         cpt+sRGScx7kC2S62boJvBy93f6T19fz/fy786HQ9B7oCBr+GWCAI5nza1RzWHTKhdp6
         agTrjD/OxfRCrh1Io+lB+YCxfk0iOVIK0gRhwO8mWu8DGLFGDnXhASdelSeGXqYh5ZFU
         fxOrgndXZzYe7s9AzV+mdNPihTvfLNITzfWKrClOrxUcnZQ255GgltsGDVkfUdHPhrYL
         TctdFm7uU7HWwocOa4+ieTHvH4QEeGjuHb56oU9LsmaTfWaf8UemVMpWZ6wGs+atPHfd
         gB3Q==
X-Gm-Message-State: AOAM533BRPgWYeAeBLO/fRinB8q3J2rW9nsJHljIZHK4I4AMIXntzF87
        OS3UtSo3g82GRqLUXmB6Rks81ejDsyQ=
X-Google-Smtp-Source: ABdhPJzjC+z6DqdTw+gOo/2sJOoWVqhf1eSPznjPBrvXeqqUPef50/kVxo8PaF7nhyKgtQmCLwGWaA==
X-Received: by 2002:a50:954b:0:b0:41a:c9cb:8778 with SMTP id v11-20020a50954b000000b0041ac9cb8778mr28075200eda.165.1648975488355;
        Sun, 03 Apr 2022 01:44:48 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402280e00b0041957289726sm3775622ede.79.2022.04.03.01.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 01:44:47 -0700 (PDT)
Message-ID: <6a1d7485-d405-d9a6-fefd-5a10d038d493@gmail.com>
Date:   Sun, 3 Apr 2022 10:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <d9c7a2ba-288a-d81a-cd59-5b002489d821@lwfinger.net>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <d9c7a2ba-288a-d81a-cd59-5b002489d821@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/2/22 23:32, Larry Finger wrote:
> In drivers/net/wireless/realtek/rtlwifi, we had a similar problem. There 
> it was handled by putting the lps_enter() and lps_leave() operations in 
> a separate workqueue. In this case, the routines were rtl_lps_enter() 
> and rtl_lps_leave(). Each of them sets a variable to indicate whether 
> enter_ps is true or false, and schedules the workqueue. In the 
> workqueue's callback routine, the routines to start/stop ps mode are 
> called. The code is in drivers/net/wireless/realtek/rtlwifi/ps.c.
> 
> This solution is only one of many, and there may be a better one.
> 
> Larry
> 

Thank you for the explanation Larry.

Michael
