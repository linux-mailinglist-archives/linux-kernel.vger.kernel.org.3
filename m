Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB1549DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350116AbiFMTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349240AbiFMTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:30:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B43AA7B;
        Mon, 13 Jun 2022 10:55:52 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g15so3212801qke.4;
        Mon, 13 Jun 2022 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1Pc6hRYC4rxtooxyM7/YSQoCVphSsBsKYzZCiGbgBwo=;
        b=NHedRiTOluSlKdlkfloHbszUpNhcsUAob4OQWchXPrS15ln7j81SEaRx0j82fIhGS2
         BB3B7mPS9wILuicHE4AwhdoKIf5TkbEkeStrcQ7JNQ1+eyXeDGqIleGe6N+ShB1/WvpL
         TxqdkIBcJfkjeajA01l4484kk3K6bxW5bwU+WvQLB1mSX12yKcO7zh8qwG4sQ4G5JGx9
         hF6hKEroFguQBgV3o4d0BY25fmhHSEVz9JZrL/WfkVfPi0zRdfaeFHb5UC1lkOGteEPu
         A01+pgg7zzXCyiaUDXTrEbvtIqTrXfxSEoAERt9SO7YUmLMDOYNKcO2iY5yi54tqjxw5
         aFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Pc6hRYC4rxtooxyM7/YSQoCVphSsBsKYzZCiGbgBwo=;
        b=eXoau6I2ZLnYBK8emDez6j99t0SwMJtDvfLdYWiqyP9QLdBA6KLvEtnKTGulcjSVZ8
         i3z41d4snTbgwlGob1BZiS9osqcO48cyWbwsZb2r4JXMuHGVwO5C+V6pYM3DQEhDcPHX
         cIqMQGdEGRWEcNZRi80vEsSiZ6JYP5g4ZKmRLiqYgNAn73j0+7Sq+1KUBTANed9Jqj+m
         /feNyJRHPy5654ovC6ZrunkrpFJRv/WIgVdkYFzFu6rV9dtYZR9bwvZx3FeikYjYArbH
         5dx77s0t7ggO+UArK9EqNjLBKZyiQYWe6TD5VBuUMZhR0xmCtSNAmhwmLXmQ3UYhx27b
         HjxA==
X-Gm-Message-State: AOAM531lBSddPRYjdIhSjP8Q/hsHT/iXB+Xjd5AtnsUaiMaHtYlq+byC
        IykCi1CsWSEcFTUuhOIW3ek=
X-Google-Smtp-Source: ABdhPJyQlPebYQo8foZhKRh7sqp7VBuXiVEpt3Q7DGxRzs+fqeIulnUb+A7p+UEUAl9zsgK8dDMq0A==
X-Received: by 2002:a05:620a:24d4:b0:6a7:1d74:d8e6 with SMTP id m20-20020a05620a24d400b006a71d74d8e6mr915132qkn.379.1655142950966;
        Mon, 13 Jun 2022 10:55:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006a785ba0c25sm4437788qki.77.2022.06.13.10.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:55:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/48] ARM: dts: broadcom: correct gpio-keys properties
Date:   Mon, 13 Jun 2022 10:55:47 -0700
Message-Id: <20220613175547.245095-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609113938.380466-3-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113938.380466-3-krzysztof.kozlowski@linaro.org>
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

On Thu,  9 Jun 2022 13:39:31 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> gpio-keys children do not use unit addresses.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
