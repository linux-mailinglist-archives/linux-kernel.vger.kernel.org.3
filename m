Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F1507ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358940AbiDTCeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358939AbiDTCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:33:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758411EEC6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:31:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id be5so471000plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YNSgtDutgXBKFRUzsOLQYL/Y2ayJ1UKMXk1V0nRM3dI=;
        b=DQs/mb56MKVnT+JWASoC/4hBPp1+3eGdQy+CDXoiqsVITkb7mU1pePfify1OL9PWa9
         Q/7dGTJsn80TGm0THysvzwU5AzjqqaR7skn1FqhBi7u2tm+fqwlQ2RUNqicsePzp2Yj/
         Uhdbn0RLchkkWdIvSwAV2QYP8dMRFFaILOxd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YNSgtDutgXBKFRUzsOLQYL/Y2ayJ1UKMXk1V0nRM3dI=;
        b=wS8OUyBfQRw0pBv6hw5zBQyPurtB5mxwsuWKwCHpCtXnbTahtwppfrttLSveBjHa5Q
         xcImUJ2Ytssyo5bwAO/UseGwCuQDI9F1pLPxI7uNxxha5hP28Fm6VnAvw6qkC6C97rjk
         BN0xDChWGq1RPHhUCN6wZl4kDQ8/wKdBxIHGYHwL5TTmuXa1Fd0U931icHJawn6yYnfE
         fkD62lxD/adBI4El+n6gX2u7VIpHDWQ/MPAZYH9LZgT6pdE6HR7ydQ/eAszroSvfbHae
         0IdxTV0IkTGZw2ZDtkVjzzs5Ghkp+obsyfIwyiUYGKh5aClFK/wMS1V2S2Z3oiREe6SH
         LkuQ==
X-Gm-Message-State: AOAM530K6bGYw81lAMCx95QkXxw2UzYWM+gc1mdQudL1wRjxQobiSQpn
        oPEXmR4EQHiVKNE3ED/974HXOw==
X-Google-Smtp-Source: ABdhPJxD2MfHzupL3ykU1Eg6xehmtnzuJEVeaeSjUuI6tlVuWazxT+JMxZqIJHqhrE7w2+bvF0jbWg==
X-Received: by 2002:a17:902:7205:b0:156:1a0a:2c39 with SMTP id ba5-20020a170902720500b001561a0a2c39mr18791861plb.88.1650421872674;
        Tue, 19 Apr 2022 19:31:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm16576294pfn.204.2022.04.19.19.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:31:12 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:31:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
        linux-hardening@vger.kernel.org, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Message-ID: <202204191929.B475B3426@keescook>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:16:58PM +0000, Allen Pais wrote:
> The tasklet is an old API which will be deprecated, workqueue API
> cab be used instead of them.
> 
> This patch replaces the tasklet usage in drivers/dma/* with a
> simple work.

Thanks for working on this! Can you describe the process for the
replacement? For example, was it a 1:1 replacement from one set of
functions to another, or something more nuanced? Did you do this by hand,
or with the help of something like Coccinelle?

Including these details will help maintainers with review, and will help
others do other conversions in the future.

Thanks!

-Kees

-- 
Kees Cook
