Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB634B5C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiBNVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:03:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiBNVDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:03:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E45F8B92
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:03:07 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 886D94033B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644872586;
        bh=2bp2Rosxu6+8ZhH/EAY6coxFH5lGR8Dxl8BwV5vJAno=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GyBG5qnie5SYEK6t+mzBwe6I+QC3QBsorZzTpJy741H0Px8qrnxVpeA4TzMgJ+l4J
         u2KwdmVIOARsCHYbIG4KHaVYON+soBEfR1WROzxUbshV8cCy3ox7XhAKqPxesQuiUo
         pmbIOwGoC5I1TrkX68d3osnFbDbRutE1EjumwQhBeAbAV4b4SyjuBKOVpsJEMllP8/
         2o5DNKNUbAVb4vMOJVnhiw2aGOLXJuLuCkXst/n741ahbScziWtLnCJQTBG1LCoM7W
         KjvKjYYoED4JI0CvxcIdQn2DiZ+4wdnGg20W+j9B98az8ySbF9hmqKduhCj52aEtsD
         I4V7EFAc5YZ5g==
Received: by mail-ej1-f70.google.com with SMTP id ho37-20020a1709070ea500b006cd51be5cd8so6381645ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2bp2Rosxu6+8ZhH/EAY6coxFH5lGR8Dxl8BwV5vJAno=;
        b=v6EZng97YmNU2GQuMWtV2SrooaS2XFvpMN6ALcFwhRx6CYA0hgSWkZsxP2ePPYiNw9
         EThCM6F6aOg19h82BmVPgvwzYgwS9yjkqbgBEVX5vX9FxzH1EVzvTdpC1/Pwf78qr5Pq
         5FoWsMgocpN4GM0QyS70oH7DgjLHqlVsbERClGj+5AM/AibUu9M52Mll2RWpFKLzfupU
         W0dHpspNW+VubH8wlYYlErMth3fR8B5/C4xeEe9w683bwMJvZIoYXUtX/pz/zupf+p/C
         t6Doj1UjeKZ6F0cbDqVIP7tjpU0oZ9eCnK4tt8O6aNTCBE0RoOysMuY8ZqD+Q4Gvrso7
         PXBA==
X-Gm-Message-State: AOAM533Oc3uYYK6IaCau8PI1tjtbolSAgm0eGUUm100OKHN5zCZxn0NL
        KWrIh/4Eg5sGgOjoyLylNGp6gmm7WaO2nsyQvRAdh246Auyc5cieiMRkeEpOrIPvtHhP1NxeKHb
        6ENic7KPzT/icvousvAHxzJlAflflpiZctBj1yrbL7Q==
X-Received: by 2002:aa7:c3da:: with SMTP id l26mr727082edr.294.1644872586069;
        Mon, 14 Feb 2022 13:03:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2FJZ3WFrmr3yKtdBu95hKE7kW2/adNT3dVxtT4u/B6q+4CQFvbOXViM594Gt5SL7EJZdGvA==
X-Received: by 2002:aa7:c3da:: with SMTP id l26mr727056edr.294.1644872585884;
        Mon, 14 Feb 2022 13:03:05 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id j21sm1153464ejj.193.2022.02.14.13.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:03:05 -0800 (PST)
Message-ID: <f9cdef5e-a52b-03ba-a069-e0bc16ccd595@canonical.com>
Date:   Mon, 14 Feb 2022 22:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 11/15] dt-bindings: pwm: intel, keembay: do not require
 pwm-cells
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
 <20220214081605.161394-11-krzysztof.kozlowski@canonical.com>
 <20220214182824.gevtqbtv4qrddjqb@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214182824.gevtqbtv4qrddjqb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 19:28, Uwe Kleine-König wrote:
> Hello Krzysztof,
> 
> when I read the subject line I thought the patch intention to be wrong.
> Maybe make that:
> 
> 	dt-bindings: intel,keembay-pwm: Don't require #pwm-cells twice
> 
> ?

Ah, yes, this sounds better. I'll send a v2.


Best regards,
Krzysztof
