Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656A35AC900
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiIEDNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiIEDNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:13:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85412D1E7;
        Sun,  4 Sep 2022 20:13:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d12so7277747plr.6;
        Sun, 04 Sep 2022 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CFVA3mdW30a9MgHuLYsBSSEVijzUz21uQ97fTAkKvfU=;
        b=FeD+322Y0Cr7vdrETnHD2xt7HsYO8FiZ90h6dsQTZd88JW1kA92JT08xxVGOzIr6Tt
         1HokuoUlvDWIUsrFAzDIXsYBQ50inmpIfz87DiDgTx+8jD/V4UWhjBve+KxuBAO/ze0g
         XykAkIwXKErszseznAsdBpxkTptWTM3u1QtOwjVGPmxGKRcSPRO4/iLwzAnJfDWxZrxC
         IMP9YyMiHZJEpjGQmsJnstBanB2fJvyb6fPpClzg6w78Mh3pO67epVCC+Q8XrQSoFOzn
         /7h76WbGr1qoFCzHA+k/JS0BHd1BvS7ytQED14RwWaE3xWNeeu5gVCGZtFZsDXaMzHF0
         MEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CFVA3mdW30a9MgHuLYsBSSEVijzUz21uQ97fTAkKvfU=;
        b=YQqsXSpGjdl+BOQ3gJwdGInwF0DeGNl6lcwKu0jPgttVw+aiKr7/o/5Rn5KWXT6TiX
         IROg8Eo/SE74NKTAGdVXJzppYYT9gIOOkadCAxAFnhF9p0/ZAskH+6FJ6gHsm8l3uQDY
         3E+cx85u7cUfwuClrpWfVPQskW33p4DX1P/y3UYxfY/BgbpJN4PbbjEug4RbEbSn2so8
         I9JNOiiW2ASrr2qwq82AcLnVrSXflsSHyt2qfe027eSWfAmOHEtNnBDLCbcAZ6M45zQs
         U81v4eoyWTqwxku47r96iuVU0ug6JHqJllcv7IM6zLRr69FIjlowTBDnbBlFdRGTOQEN
         SKyQ==
X-Gm-Message-State: ACgBeo0f8A4EGIpQ+DkqGH6BsE60SD0WXOwyFHuXr0H+KQx+rZCQScIG
        GUWK36JyegyUhaWCmIbHLVND+6N1dvc=
X-Google-Smtp-Source: AA6agR48L+VhLtsmD6/6q2FLF6zYwai8Q/N37m3D6iaYkUVceRQLKEz9b5zfljwOYReGziemqnpTCg==
X-Received: by 2002:a17:90b:4b81:b0:1fd:bc88:680b with SMTP id lr1-20020a17090b4b8100b001fdbc88680bmr17247735pjb.19.1662347586589;
        Sun, 04 Sep 2022 20:13:06 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001755f43bc22sm6119538plg.175.2022.09.04.20.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 20:13:06 -0700 (PDT)
Message-ID: <d7932ec2-f3ee-8ea4-2723-5a281919e301@gmail.com>
Date:   Mon, 5 Sep 2022 10:13:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] USB: core: Fix RST error in hub.c
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     USB mailing list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220831152458.56059e42@canb.auug.org.au>
 <Yw9vYaqczVlWzONt@rowland.harvard.edu>
 <20220901075048.7b281231@canb.auug.org.au>
 <YxDDcsLtRZ7c20pq@rowland.harvard.edu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YxDDcsLtRZ7c20pq@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 21:36, Alan Stern wrote:
> A recent commit added an invalid RST expression to a kerneldoc comment
> in hub.c.  The fix is trivial.
>

htmldocs warning at that file successfully fixed, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
