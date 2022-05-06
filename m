Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1351D273
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389641AbiEFHpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbiEFHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:45:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68D5DA4D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:41:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y32so11196730lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/nebMqVfT+54zsFtvKohJbYf+QR1kkUWhZbfriasr58=;
        b=OroYPBv6tDt222Zrkqx2eB3zMfsQ3LD8gGdxVqOuIp7Klct/n0Q9UDLe9rDcUaTRvA
         y5srW3JLT1UVXGlrrDt9uEWSl6x0AhPjgXzCARhQ8iRM6u85SC7td3+aiPd2cIdh3+OD
         MHGkA37r+Wo5NxNMmXo8uTYnMICTylbSvEFBQdbHiiO1ctrp5ygMnfpp6Ym92F9YFVbh
         LSksaGVz8sQDxh3M3qR8h6qLpe/9tm1w+NktYZXbHEQrUUwcaeXlffaPQKoIwsEEFQDa
         LK461sWoOujgfAvtowg/IXrpRJQtXjYJg94/aKWHp/ywIrpSQ3D3yv/GdTnhA8MCBQ0b
         LjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/nebMqVfT+54zsFtvKohJbYf+QR1kkUWhZbfriasr58=;
        b=HG4y/4kO871SbCq/8VxWOcORqC4gpjkRNelZcHOa/lPBu3SQDl0rUkzImrdtmWhUWf
         5HrO3cwAOKDAImjlCxVOR8+MapMMsUgLZ+PJ8oNUKv4+8Xs6vGBjxQTHWnRkvPrqKLXd
         w6RLWVQbE+EnZhEMoJEWTk9b9kwI7A47FPK2zQIVz0lHD6NB+wYwZCJr0gEBflrMK1dk
         f8ZARKAFkT/NG1WWWoKEEAUA4ajDx/wp54kOhEFC/+hAOVsKvlibrg292XlDBZXRbk1T
         r8p+nhvfqI2PlTS6dYUiL+sRUdzPj8pbtTzNMokgm1+n2sWFbR33n2raPTbmB4RLStda
         vDxA==
X-Gm-Message-State: AOAM530pgTNAEwN28Y/atY81+KF3NoidFEz8ImJEIMDRJ8VZhwT2ZdGR
        BL7CMM6au8eTu0/nqcZNN5MLknMbkAk=
X-Google-Smtp-Source: ABdhPJz8zlQiMb55eBpfZxzaMpDiMUi7EpuQODK+4Q6oV9xgysymwHt2dbOXi4olkQzPMsEemBYvwg==
X-Received: by 2002:ac2:4e14:0:b0:473:bdfa:e48e with SMTP id e20-20020ac24e14000000b00473bdfae48emr1567859lfr.230.1651822880808;
        Fri, 06 May 2022 00:41:20 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.114])
        by smtp.gmail.com with ESMTPSA id p21-20020a05651212d500b0047255d211dbsm567937lfg.266.2022.05.06.00.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:41:20 -0700 (PDT)
Message-ID: <46b89616-5ec7-fb04-f561-2647efd968c4@gmail.com>
Date:   Fri, 6 May 2022 10:41:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <14c3886173dfa4597f0704547c414cfdbcd11d16.1651760402.git.wanngchenng@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <14c3886173dfa4597f0704547c414cfdbcd11d16.1651760402.git.wanngchenng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On 5/6/22 06:16, Wang Cheng wrote:

[snip]

> 
> Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
> ---
>   drivers/staging/rtl8712/usb_intf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> index ee4c61f85a07..50dcd3ecb685 100644
> --- a/drivers/staging/rtl8712/usb_intf.c
> +++ b/drivers/staging/rtl8712/usb_intf.c
> @@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
>   		} else {
>   			AutoloadFail = false;
>   		}
> -		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
> +		if ((!AutoloadFail) ||
> +		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
>   		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
>   		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>   		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
>   		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
> -		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
> -		     (!AutoloadFail)) {
> +		     (mac[4] == 0x00) && (mac[5] == 0x00))) {


That looks ugly. I mean mac checks. Can we, please, use sane kernel API 
like is_valid_ether_addr()?


>   			mac[0] = 0x00;
>   			mac[1] = 0xe0;
>   			mac[2] = 0x4c;




With regards,
Pavel Skripkin
