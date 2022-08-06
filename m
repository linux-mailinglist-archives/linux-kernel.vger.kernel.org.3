Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3830558B84D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiHFUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHFUwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:52:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD62DF5A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:52:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m4so10413068ejr.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ejl4Fw4csQ28JafX+tbP1+j0PeUTDEnEKLUntiXyZxI=;
        b=pwO348l0PLgh6TkcnRit2Zvydhhnv8O7Td2uk7nLP4AWc+zc1Au4nh8TaBTmWuyxPY
         /yXzelweKHS+ZHPa0Gx4XDs6KlYDEUDt+yTw2nOo0KJMbF3zyRuqcp9H6Zx2usVe80Kv
         +Q3YHSZaPLiL6aaR9SPvfKeCdFKah+Y0HCLp8VZpLEJaW+JO1exiqZZgMkD1wT4SiyGQ
         Z2nQ4K2BjdcbI+lz/L4AR061NeZeMW0DKu3PJVBAWAgUivCVrKNnHtiaW/cZ211I7xbC
         sytKSXdrxoWJV1LJ3yxV6R+JBs8veEcPjNq7b5WDy+rnKQmWW18fNsbuIBu/eSt3L3yU
         0mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ejl4Fw4csQ28JafX+tbP1+j0PeUTDEnEKLUntiXyZxI=;
        b=JrpwlFeY21qzoC9ow7IFBuRYRlHOptiKmK7JXJGMMG+3E2DwrkIT1N9pJW15U4sT08
         xCX3MPT4vXXerD/Y8qVUoO4OWjc6Y0fRwdnXMUlIhAaXI7qzz8F8ENOJWHjtiXtiJD3w
         +rYXDRIh7sl4bO2g1przWI2AKW6/MJVUUiu0wkpWAV9ZAnEVxwQHb0n9chKDssfCMnYd
         WxAiNTcLsv8p0pA2ZZFOqwgrpCrPZGvk07cRl6lBsE7ReNMR6SIYRAcb/xTUkCjjnkDa
         7BCSMe9wfZCYu21ON5wC6+J8UbAF0vaM/wYC4vSeT91nAqY27NMclHCT13/yE1QxK1AZ
         E/BQ==
X-Gm-Message-State: ACgBeo1WY816TsW0RuENKyvm1NKzmZPwWT9EJRj+tIHLDH6980mewc0l
        y6oLmtMf/DqpcTdn39O/fIc=
X-Google-Smtp-Source: AA6agR739AfRG5agbFx4YxJpK7ok3KdUhlOQWDAin82ct9OKbDSQ2BN9O3okgsq54PJ90TI5BUlYkA==
X-Received: by 2002:a17:907:7601:b0:730:3da4:217c with SMTP id jx1-20020a170907760100b007303da4217cmr8766621ejc.563.1659819164283;
        Sat, 06 Aug 2022 13:52:44 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6906:a6a:d0f8:1e63:5a72? (p200300c78f2e69060a6ad0f81e635a72.dip0.t-ipconnect.de. [2003:c7:8f2e:6906:a6a:d0f8:1e63:5a72])
        by smtp.gmail.com with ESMTPSA id fq32-20020a1709069da000b0072aac7446easm3003108ejc.47.2022.08.06.13.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 13:52:43 -0700 (PDT)
Message-ID: <a62826f1-a527-9fd3-fb3a-ba5ab3f7288a@gmail.com>
Date:   Sat, 6 Aug 2022 22:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] staging: r8188eu: use struct ieee80211_mgmt in
 OnAssocRsp
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220724153917.138848-1-martin@kaiser.cx>
 <20220806111352.690650-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220806111352.690650-1-martin@kaiser.cx>
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

On 8/6/22 13:13, Martin Kaiser wrote:
> Use a struct ieee80211_mgmt in OnAssocRsp to read elements of the
> association response message. This should be easier than parsing the
> message manually.
> 
> v2:
>   - rewrite the commit messages to say to more clearly why (in my opinion)
>     the patches change the code for the better
> 
> Martin Kaiser (5):
>    staging: r8188eu: replace a get_da call
>    staging: r8188eu: read status_code from struct ieee80211_mgmt
>    staging: r8188eu: read capability info from struct ieee80211_mgmt
>    staging: r8188eu: read aid from struct ieee80211_mgmt
>    staging: r8188eu: simplify the calculation of ie start offset
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

