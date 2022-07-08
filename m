Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228456C3AA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiGHVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiGHVHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:07:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7132BB2F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:07:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g126so102821pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrgnU9rBRpV7VjlZH7nKN6pRV+oJCyhzIiB9xLuP2Hk=;
        b=nT04YICxvirS5eMyobCQW6Ljh7CQOMzty9MGwbZXlz0AdvLFP1fBaPPhZq6TMgGlK+
         rs3a9nTGhRRFnNOTiG8teTAA+TKLd7UdSE9X+LkkL/hd2qam1R1aS3UQmUt7AhqVPfnA
         kRJH4dDFmbMQzPIrGzJSxL/yWvUtkgaySS6C7+bUqAkWvTQgTpswVfITKDhUcYXbGLkR
         P6ISwG8a93usIikhzCGKxY2yvfP9Kg3YHc4revPD5TzQXDxog5G77NQJEnH/eGyNrjO1
         q8UEwqKdzgqxlTeYG/CsRZwKcVPlEbczwvcD3zxpRNOXRMohinRzEF5wdhw9toVUumFo
         knNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrgnU9rBRpV7VjlZH7nKN6pRV+oJCyhzIiB9xLuP2Hk=;
        b=HNpUImBezIjvLBMNzp+RiZSzPqlh5+TXtOPYdwDQjzJc+paxSMWb59HBSZdyMXB8Co
         a0cVKzR8teUS/AyJ9YKz9hr74ziNp4XpHOREnxMl49rA/fYJA/yHHneRfhKl/jtYyb9u
         4+JaBfCmpFp8WkLcbLwt/7BZZH2sDRuBTK6XNkw93ppQjpVN9QrvFFH3vobcdyjigs0g
         lmPF/r819S7NZ/UksxH9qmdF3gjSW6mh4OQoMBF+kp5b07lFSPfEhZvZhKKQ7uCm0WUQ
         WTrdxyqSskvckbgfObn5ftDNM0OuTcYdkffXFVht2sff+Z89polUK2CWQAGQgurK1lwr
         sVuQ==
X-Gm-Message-State: AJIora8CDA+Znptl77qXddldOT7rJC75xzX//2KxVC8ev3t6zStejqR3
        OdYxQSO0o2bT8kUBuBJ/c3E=
X-Google-Smtp-Source: AGRyM1sLEs/pViEtguYkPWG/MK8mqD3mIJr9M7EOCNdWVxYP4VA4QpRcuN1Isg3J41b8pokTUG0HCA==
X-Received: by 2002:a05:6a00:2295:b0:525:6c57:8dea with SMTP id f21-20020a056a00229500b005256c578deamr5585188pfe.62.1657314441096;
        Fri, 08 Jul 2022 14:07:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b69-20020a621b48000000b0052ab42ea0c5sm8989pfb.147.2022.07.08.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:07:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Russell King <linux@armlinux.org.uk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] ARM: multi_v7_defconfig: Update configs for BCM63138
Date:   Fri,  8 Jul 2022 14:07:18 -0700
Message-Id: <20220708210718.2659303-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707070037.261532-9-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com> <20220707070037.261532-9-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jul 2022 00:00:38 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Remove CONFIG_ARCH_BCM_63XX and add BCMBCA sub platform configs.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/defconfig/next, thanks!
--
Florian
