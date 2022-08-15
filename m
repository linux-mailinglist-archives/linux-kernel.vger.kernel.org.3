Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9792F59339C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiHOQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHOQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:56:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8421220C3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:56:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f4so3940234qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Xit3WRnKTIm0LT/FsH+tn1HiQ0QF51a9rdFaoB3K4JU=;
        b=emDqgwl45cmf9z43SePCl2dVZmD1bsIhCcDeoXs9SGy81sZFpqqOcporPNjKH2b+7Y
         aDYnsnfBIeZzRq/bviPFmdbt+IjLkewLumRKBn/4oA6P3JLz9wXQdwd3OzdY0L4WEsvo
         s02ZtASFEo0u0zq2MPIkDLDWr3BuvCqfqdUkYwvTIP2h2gP2mIFcSU3MuRmB9bqVWmsO
         0CwJs1KAel2T9Ejo5rwz4HDFfWjj8Zz4U4Wtg24ogR4FFWMKeBroxW00UD23TV2RaXzr
         2JGyPXuLWwfLRlKxAM9lPrpO0jdywiHrM7bNzq83wGhNm93nddl8GvnadaWSd9Dw7g9m
         bl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Xit3WRnKTIm0LT/FsH+tn1HiQ0QF51a9rdFaoB3K4JU=;
        b=fINI8syTLgLpBN8a9hbL68ciY66PTBjkdz3s4pzBvOzcOGGS4NoBldZX3WhzohH1rl
         Q7t/E02Mt2TPwGS6q4yG6mOMsnVElHIs5DD+pZnc52jBUMP1tcHSswtkO03XkSFTjbKU
         wTZXMq6GaBnpYKYw8bYR2sbLtpEzGQHirREKGp8wMl0XIwm3d9F7tNb3OFWqela5+gRd
         75fqkpm8v3QuKniohdIh+jkdN7EOvWiUN+d1o09qajfJBWVhhvCAT9kNngBDpRLQca3+
         J+QTWMJ4W/+FSROXHFeyHOQpidpsqn3X09xHf2Ambe/zP2mvI+oqNOHjBP4NRAEHE1l0
         VN+Q==
X-Gm-Message-State: ACgBeo3HNkFUh7YxnfHdBjsvrfeirA7AGECS11hKedGloFPUGeYE9rtF
        1Mb6u059RchMLdxXu51hBwY=
X-Google-Smtp-Source: AA6agR43oxHRuC1r7D0rjKCCgQiRGxrxoTVVJrzdD/9o/MHDDB3R3ZU18Q5Y1hQOASh04ORjWVaoyA==
X-Received: by 2002:a05:620a:400f:b0:6af:53bc:7311 with SMTP id h15-20020a05620a400f00b006af53bc7311mr12035321qko.305.1660582574757;
        Mon, 15 Aug 2022 09:56:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006b5905999easm5398128qkb.121.2022.08.15.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:56:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        krzysztof.kozlowski@linaro.org, rafal@milecki.pl,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA
Date:   Mon, 15 Aug 2022 09:56:10 -0700
Message-Id: <20220815165610.2501854-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803175455.47638-8-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com> <20220803175455.47638-8-william.zhang@broadcom.com>
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

On Wed,  3 Aug 2022 10:54:53 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Delete ARCH_BCM4908 platform Kconfig for BCM4908 SoC as it is replaced
> by ARCH_BCMBCA and move its selection to ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
