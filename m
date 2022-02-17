Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17824B9CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiBQKC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:02:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiBQKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:02:23 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40270ECC53;
        Thu, 17 Feb 2022 02:02:08 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o2so8962005lfd.1;
        Thu, 17 Feb 2022 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D3X8rMgm33sZ6wTcPzoDFpEXwE3MFqExpXhdRt0yiFQ=;
        b=AeJIn95gvIWGLukrM5ykGOhMP8W1wLPsenoB1x1jggE0ez5lyVtTmOQgIOt2jo6gO+
         xc6RasYc7by1eSNu+xs9B8Mc8OmRre4vRSsZzqykr90Sj2v+IvzOeUt9Tk+NVHouIqdJ
         lAW4AP5jSdSo5EsVrdCfHCi1VVgKNE9r1M/GyojphGSrul66r9aEORrrY6frhUVLlGVT
         Lbybnaa0HCUlBnEkrWNAnQNHWpMv9IymOoJt39CND6Z7yFba/8azm91pveIVG4ZJgeO6
         8LwJnNEaJbEMQjfSapkEphuZGEBJESkLgfg6oqNqEh/ae6Ydvg0VOcar7fkNIT6FV6bb
         gYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D3X8rMgm33sZ6wTcPzoDFpEXwE3MFqExpXhdRt0yiFQ=;
        b=Js2CaVTQ6YW+fItmWC9gVAIFOfeSisZjhrW4Fac6leCthX5wDf5B2wHMDtBUQKH9H3
         MMn/izBBvYczLnbGYCgE7qwkGWPcwjwFXQ1UbsksY8HTM+1t9ImcIjHkBK/muFGBLZDj
         NXOzQKVJ9jc7rJCZOy+8xmTf2TLJ1T2yM9goX37+lQ7pjmHTL1DgDlpMJY5WUAC96Bp8
         9EKHG7QjJwce8xNLwCNW5HAhDEyu3CcGtxYRYpZKuyfRiRF8UPTp1pWJktLLEc9MEWSC
         RlAlrYAox5ztaqQhUY+PAvzPVorYL0v+M4Z5d9gk+FJqDfs/B/5HeXVbadx9Q+c3qi6N
         laww==
X-Gm-Message-State: AOAM531mMWd1C3bwEwnZE2WSdabEKZ/7idjStmmrhycBxIr8gyI4YLXL
        XqPUKBdUqWyqv/Y+qJMsOPx5zVt+9HI=
X-Google-Smtp-Source: ABdhPJzKVcD/hmeNm8ckSOZQj7wx+t4sqGoDxbDPgGa07YSUE85Apun4esTP5QR3d/yiue2mQ/aDkA==
X-Received: by 2002:a19:710a:0:b0:443:ad21:dcc0 with SMTP id m10-20020a19710a000000b00443ad21dcc0mr399015lfc.688.1645092126455;
        Thu, 17 Feb 2022 02:02:06 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id v11sm1643799lfr.3.2022.02.17.02.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:02:05 -0800 (PST)
Message-ID: <25e6658c-3241-198b-4240-1055c8a6c630@gmail.com>
Date:   Thu, 17 Feb 2022 13:02:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] PM: domains: Prevent power off for parent unless child
 is in deepest state
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
References: <20220204101657.233723-1-ulf.hansson@linaro.org>
 <dd7d0ebd-7bd8-9f2e-e212-5b597ec729d5@gmail.com>
 <CAPDyKFoDP-LT9nKwa0oKF0jW9DD3tZh4+v9zE0uS_KpJeFC-MQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CAPDyKFoDP-LT9nKwa0oKF0jW9DD3tZh4+v9zE0uS_KpJeFC-MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.02.2022 12:45, Ulf Hansson пишет:
> On Tue, 15 Feb 2022 at 22:49, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 04.02.2022 13:16, Ulf Hansson пишет:
>>> A PM domain managed by genpd may support multiple idlestates. During
>>> genpd_power_off() a genpd governor may be asked to select one of the
>>> idlestates based upon the dev PM QoS constraints, for example.
>>>
>>> However, there is a problem with the behaviour around this in genpd. More
>>> precisely, a parent-domain is allowed to be powered off, no matter of what
>>> idlestate that has been selected for the child-domain.
>>>
>>> So far, we have not received any reports about errors from the current
>>> behaviour. However, there is an STMicro platform that is being worked on,
>>> which can't cope with this.
>>
>> Could you please provide some technical info about why STMicro platform
>> can't cope with that?
> 
> There is a parent domain with one power-off state. The parent domain
> has a few devices attached to it, which means they need to be managed
> to together. The parent domain is controlling a shared power rail.
> 
> The child domain, which has multiple idle states to choose from, also
> has some devices attached to it. The child domain is controlling a
> system clock, but also relies on the shared power rail that is managed
> by the parent domain.
> 
> Obviously, these idle states are managed by firmware.
> 
> I hope that made it a bit more clear?

Yes, I see now what this patch does.

So "deepest state" in the code's comment means powered off state. Maybe
the comment could clarify it better a tad.

- * The children must be in their deepest states to allow the parent to
+ * The children must be in their deepest (powered-off) states to allow
the parent to
