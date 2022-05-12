Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ECB5246F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350995AbiELH31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351021AbiELH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:29:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A279013C1F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:29:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d22so4085234plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P5HUXEPOvBMLE8fEsuwCBiB+Q1qgQLDGbaTHhCwoMe8=;
        b=o5Z5fV0XV36DZH9ayGrfnl8qVxiWuzspeT5gnxwUrHidCaa+tEthe7DF0xG8IhHRnH
         jbDAxfFA+vFhlKs8TliSi7SNZQNw2cTItQSYVMabTBsOE6/aN6wtu6u+mpUqn1RUfgFS
         979KmVpZazbdbBvOVinimrA1IoyyO+lowJnL5WpIoDN5cmF9z5vmc7Jz2eFRtDEzfp1t
         L6pxr8VVt02arwTG33X8AwuJImwvj+620Bi8T9JcN48MEr0bxM6TEj/nyvTI7cyJECCb
         HGuduVAUgYq1F7DQagX3YRgMoRXkXQdgYIQV7Tk+BeX4HJfnPiCxdaRg2lMuW7zN3U8C
         Sl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P5HUXEPOvBMLE8fEsuwCBiB+Q1qgQLDGbaTHhCwoMe8=;
        b=xExPROkHvIHGkA0h2HuLWNv8jPAhVW+l6h1lKPpSqwx9pXn7rG15k7T31Y0yXkdIY/
         n34eMgnyaWTXEbYUnUm9rWkzGJu3SqpHeSH7kk+UZvDPthwo3iuUAMnIEyLwvQ0+LsmV
         joByOE8Q1xXvD0jhHIURavXzOkiDs9A3oQSbUTsNPdsfY2D19ULSUjC0YfnhJ2UXTXUh
         7EnfVHgjL81ExDX4Tb499WOqi5r1sbGul/y/BkpUxSoO+j7Pm8pVttFldeQcLgkMNfHA
         l8LmDsC+fBDo6btLEqhanQZ6PUwTGADMCd5XuS16NLRJu+0QrM2EFXrpj78H9w68Vn1c
         u25Q==
X-Gm-Message-State: AOAM532Q8PDSAG56y0QBL/j94pjeBmw6SShB5bedoRVemO03GQP7TsVa
        zhYhBEsOCvOpL0rfD3QrApdQpA==
X-Google-Smtp-Source: ABdhPJypLn7YyngE6rmboJLB85iyymD1k6g9lMwHwVnR3EpfOxbp8POTUSTQMDHng1V/ia/kWWRoKA==
X-Received: by 2002:a17:902:b189:b0:15f:3f5e:b61 with SMTP id s9-20020a170902b18900b0015f3f5e0b61mr3417397plr.49.1652340562190;
        Thu, 12 May 2022 00:29:22 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b0015e8d4eb2b0sm3139958plb.250.2022.05.12.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:29:21 -0700 (PDT)
Date:   Thu, 12 May 2022 12:59:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ARM: dts: sun8i-r40: add opp table for cpu
Message-ID: <20220512072919.hkggxbqmovebdych@vireshk-i7>
References: <20220512071858.10805-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512071858.10805-1-qianfanguijin@163.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-22, 15:18, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> OPP table value is get from allwinner lichee linux-3.10 kernel driver
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
> Changes in v3:
> - remove "allwinner-r40" compatible from allowlist.
> - split dts in two part.
> 
>  arch/arm/boot/dts/sun8i-r40.dtsi | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Both the patches can go via SoC tree now. I will not pick them. Thanks.

-- 
viresh
