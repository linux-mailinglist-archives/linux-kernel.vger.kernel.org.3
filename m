Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947E34C129D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiBWMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiBWMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:20:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19C9F39E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:19:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p4so3429700wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yENY87GVxhnVs59gotAlnCoqMTQcS0MN/7taAo6T+OE=;
        b=ZbSi8r3ct6EIxFHNUtnzMeFgMTf7a1aHe+sZ6tp7hCrp0nYHaI9zCVDveC6cPwyC9H
         vk3VWTiUvDoQ3qjHY+eaJscRZ64KdwDi63KDvR6in6B5l+waAmR1+Wel+D8FYnBt0gMH
         Ls5/c2o9XidPAT7l9FstX3xWw/c6WnlvLL4w3Zpj2VQbtE0LwrtxaeaJRuJXnaA2Rkip
         CmBAlglTxZWA+iB5t8euO5CXw6MX2ipVe0zXOQ1TkswsoGlROcLN7LyZ9kklZBUxxzBb
         rYFQkuvsrNzZCa5JQwxZFRY9c2Qk+NDa/IEHh2ZobcNcG+1aGguXgHV2J1w7EMjEjPtw
         ZGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yENY87GVxhnVs59gotAlnCoqMTQcS0MN/7taAo6T+OE=;
        b=WKEGGUnRU/8bdl2Yhvoy4rOv3hKVfugsDWozUasXmHsUIu68I5bt+QVsbzDVqnj6zq
         DnVjSvKXG7wR7TtQ5Ne2nrWwaF8g9wk+L3pqmb72C7gvp9z771/gFjIXPAh9jzLTT+Sa
         SO9+xWeT93BXHCyNqC8NWw4RiJCpGb4NY+mcE7q5k/Vose1LSoHLDwqCjoFR2mK1OTJm
         dZqR+1VEw9EVhlESRAXU38YyWyXcmmLnqRcOITewt421/a/oX8SRxDg2eecNm1hOBDkH
         OTaC98BLjcgMNnXm/S0Q2bw0tkS6KCCzydHOYKy4GoH9mvX8IQYK0QjJdgempi7ufDvA
         zlzQ==
X-Gm-Message-State: AOAM532DFdCgBHitWyBcPncyjeQ4pXArKR9G9VUT8vLZGX4Z9Pam8GSk
        cy/3rJj8EWx8rT63zjyMjvPz+w==
X-Google-Smtp-Source: ABdhPJxWmZRXJhgOjvTOawuT0QAPRZTgIjalEOtBclclVTICYuEuu0wmgguos6gs7Alm6waRhIMGUg==
X-Received: by 2002:a05:600c:4fd6:b0:37f:2a37:87a3 with SMTP id o22-20020a05600c4fd600b0037f2a3787a3mr7233953wmq.152.1645618788506;
        Wed, 23 Feb 2022 04:19:48 -0800 (PST)
Received: from ?IPV6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b0037d1e31a25csm5630731wmq.26.2022.02.23.04.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:19:48 -0800 (PST)
Message-ID: <fc0ebb9b-4097-c5a1-cff3-bce7addf9b78@arista.com>
Date:   Wed, 23 Feb 2022 12:19:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] net/tcp: Merge TCP-MD5 inbound callbacks
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20220222185006.337620-1-dima@arista.com>
 <20220222161810.164f6d07@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <20220222161810.164f6d07@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 00:18, Jakub Kicinski wrote:
> On Tue, 22 Feb 2022 18:50:06 +0000 Dmitry Safonov wrote:
>> The functions do essentially the same work to verify TCP-MD5 sign.
>> Code can be merged into one family-independent function in order to
>> reduce copy'n'paste and generated code.
>> Later with TCP-AO option added, this will allow to create one function
>> that's responsible for segment verification, that will have all the
>> different checks for MD5/AO/non-signed packets, which in turn will help
>> to see checks for all corner-cases in one function, rather than spread
>> around different families and functions.
> 
> Please rebase on top of net-next

Thanks!
I've previously checked it on linux-next, was not aware that net-next is
not integrated or integrated with some delay?

Anyway, I've resent v2, based on net-next.

Thanks,
          Dmitry
