Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED25547F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiFVKSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiFVKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:18:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4F3B009
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cf14so13434524edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySkJSlQo1QiWIR9DLd5CIrfBGUCsep0GFFfnEfKFKN4=;
        b=DnncSgJUOg++r/Npn4SZZ7gvSY+IV6yT74oWsTQmNIjVH+IpnLK7l0TlMlvlCDYZS1
         2tv6WK2RBy8Uprinq17piL0bsFWAsjrj5mpuLCyThG6jMiSZtIlFXzbWySzAn5b01SdU
         ebRY5CGjXu+p0ATuOK1noCYTrMi0aCKYOa3e51d/CZwhjJj+FL3LpfcI4g+hmevOWQU6
         RMFFOee9Nm21FAmDpCnOn88A99ZdocWvmS3yUMOEajmt0l9JE7QYUHd64CoXp6DB7MZV
         1XmfvmuDFO1JO5tUqwVASyzzgw/2NjMDdH///0c2D5eEUBkZmj5O2z5GTgxEJ208UUII
         vlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySkJSlQo1QiWIR9DLd5CIrfBGUCsep0GFFfnEfKFKN4=;
        b=fzUCNBprDW+OpAJ/zRyV4Wq6IIUzE/66I7nvWSugk+dsKBCrFXxDCF1geUhksIJMaA
         OObKo9HKsZ4GHIXiUTlvPiiTq0c4CSAHDZrE7nbGOIkIQfMBNXORfFYLrt4ONMxuomAx
         PCeda8F1ciX0V3LGHWA/9ZYxARBX5CuzfJmcX8pmUfzg8x2L1s6q0cwxgQgjsuDnJ8fG
         HgEOJI7qcqbOwZaFSNHhwj7CBR0kIkxLPlpzf+Uem4K7tcTKtxbQu7EYYmUvU3trpZOi
         a8HR7eUvk05QBie+U5ltGDJMC288Nx064mZSnD9sn9qmkqIPQ2IYkcsLVwl5sWCyhAzo
         DgVA==
X-Gm-Message-State: AJIora+8tj0cqauyXO1GkKHrwExxy5oJC1CqXlBE3fVqhPQpvT7zy/3Y
        mvVe5OmqfnMLNNz4vkZVpkAaOA==
X-Google-Smtp-Source: AGRyM1tVe9qPZdAXW/Yf6kb//4YtLCp5bqCUQK/D3F9haBOVm/B3p84N9+vNGIkS6zSOIQoSdRmmwA==
X-Received: by 2002:a50:fe15:0:b0:435:9155:f83b with SMTP id f21-20020a50fe15000000b004359155f83bmr3199554edt.391.1655893064356;
        Wed, 22 Jun 2022 03:17:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b006fe921fcb2dsm9028707ejc.49.2022.06.22.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 03:17:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     steven_lee@aspeedtech.com, linux-kernel@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chen.kenyy@inventec.com, linux-aspeed@lists.ozlabs.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     David_Wang6097@jabil.com
Subject: Re: (subset) [PATCH 6/7] ARM: dts: ast2600-evb-a1: fix board compatible
Date:   Wed, 22 Jun 2022 12:17:38 +0200
Message-Id: <165589305701.29629.16741118174396025883.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529104928.79636-6-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org> <20220529104928.79636-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 12:49:27 +0200, Krzysztof Kozlowski wrote:
> The AST2600 EVB A1 board should have dedicated compatible.
> 
> 

Applied, thanks!

[6/7] ARM: dts: ast2600-evb-a1: fix board compatible
      https://git.kernel.org/krzk/linux/c/33c39140cc298e0d4e36083cb9a665a837773a60

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
