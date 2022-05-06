Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF03451D22B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389498AbiEFH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389505AbiEFH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:27:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A006129F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:23:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h29so11148239lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r6iyqv+O3BjR0LvvZ2kt+RAWyYOrOIyELEXvFaehkhY=;
        b=avNdgqvAmXphqerrnxxbZNWJ4iRsKj5bc4yQpGTdt/8TuoqzPIXVSZhiLr4LI0bTvP
         zn8r84hICJhVGtw8x94s3F6LNbBMkHpLwxuiHaIT5bcdF04TVYrh5sUOukguTSXUHGjz
         MwAmw0OfmLqizYo8yOxGtiUeLCmMkhs36YIkOT1JXl/YiWLdOFKIuvT7cMx9yIufLdtU
         BxtmFJYdljzsqXu5UPejTx0qPoTyhdb5gL6aM4iZw30/wgYe2WEz8ZwOCDPJglOQw2k3
         oRYsEaJvOnCQJKV1Oewre/WpN0mr88A1w/5GNhVn6LtOVn9Ya4Td44jBvxTR6RU0Qhzc
         2hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r6iyqv+O3BjR0LvvZ2kt+RAWyYOrOIyELEXvFaehkhY=;
        b=YwJ4JAvk1YTJR7G0SwsoDrFCsFO7pM26ByM474pvYT2AxH6sAde6BYPx7hjbqQ2zt/
         JL3O+tilY+Wqa6x2g+0tfoA/piZdyetT7dcEY61BtW6ZGFS/8vJ7MOF5kLn9fAkex5Lj
         QdagEb0GUGHbYOJcxY7twRCaD36Tc1TSJWB73Z44E2xrAgrpLCidEGkXt2xHs9chm81z
         pYOGOR5gmlaWFDq4vrDguvKU/zcYVLW4EHtIykJMfVcoLalp5EUk5Q560jlAbNhQ3JNP
         MOcGAdYZ+zExczQ4uFYpdIlu5yKkdP0jZr5JgmT/VM1t4X+m0C2WAA+sKwue9f/4tD/M
         6qnQ==
X-Gm-Message-State: AOAM532WTqKpXbJROAu1c4cci9ecQO6dHBJXHqOMeuxAnwAkiMx285+e
        HBWG+CGyDoAuyPxRtPLnB84=
X-Google-Smtp-Source: ABdhPJwcESVaKWO2wnu9IRvlTmdKTIpQuIm3XGJanK0NWp68IunXwo+EYAUVloCDKeQgJugzRxhy4A==
X-Received: by 2002:ac2:5e86:0:b0:473:d044:60f5 with SMTP id b6-20020ac25e86000000b00473d04460f5mr1589063lfq.87.1651821820922;
        Fri, 06 May 2022 00:23:40 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.114])
        by smtp.gmail.com with ESMTPSA id u2-20020a197902000000b004725b9da82asm559848lfc.303.2022.05.06.00.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:23:40 -0700 (PDT)
Message-ID: <7dad295f-2ac4-d6ff-8d8a-17db8ef18c12@gmail.com>
Date:   Fri, 6 May 2022 10:23:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] staging: rtl8712: fix uninit-value in usb_read8()
 and friends
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651760402.git.wanngchenng@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651760402.git.wanngchenng@gmail.com>
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

On 5/6/22 06:15, Wang Cheng wrote:
> When r8712_usbctrl_vendorreq() returns negative, 'data' in
> usb_read{8,16,32} will not be initialized.

[code snip]

> +	status = r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
> +					 &data, len, requesttype);
> +	if (status < 0)
> +		return 0;
>   	return le32_to_cpu(data);
>   }
>   

Why do you believe that 0 is not valid register value? And if it's 
possible then how you can identify an error?




With regards,
Pavel Skripkin
