Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE564B3685
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiBLQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:37:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiBLQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:37:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E320F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:37:14 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 46298402D3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644683833;
        bh=7ys9/qjzPiU3SC/qBsUq9U2CJFdyL7K5ET3RMyCWmA0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ROUv8aLzhoTOJEDA7rN4kRKkSVduuiAXqIxLE85zeM3FC+0CgPfXm4XJOA5timhnK
         3urM2MjgwFYRGHa05vccgYpMhg+EcPlDRuefwzCPVhh9V/3i9eTeqUY/anHy5H7DJL
         qOnGZQ7VSC58cxciYrSdteO9vFsF7HDFdAGJ6AHVTk3b/XX0wm9KokF4GZW7n4TZDs
         fTQkRb52OHYzZXeGfRak8Kv5DAGZTqxdJbI3CLZ6RBlPAqmszn6jitlzVoIuAvR6Yg
         f0DkTcR4pIsLZt5JdxeT9jjgTIyLeiUL0gd9hBzQ+G2MezG59/PGbz/k9Jv0O5iPIR
         2PPkMGi5yeuTQ==
Received: by mail-ed1-f71.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso7262017edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ys9/qjzPiU3SC/qBsUq9U2CJFdyL7K5ET3RMyCWmA0=;
        b=MhXYH73ZYFDE/GMIaSi7LN+lUFz6SPnP8HAY5amBYrHN6iRWjSuxT9JjrBd0ZUnYXA
         BWZRETAt90ZCkOuJ7fjnfyaoB7UEQ0S/c1wp9MFjqNTGXsCX0sPU4WsskKaENezSv0My
         nd3Oi6qf4YXeZrvaRcKAefA7e0EItgq1hXrRTsJBeGTCVae5jT7hNtzKE7v/95uKlonF
         4UzqZGzjpXTtYvYQ4XFG/5wi1gH/DIlmc7QEmrAXMW5KCnhWoIzCDPDR99dYK9CzKbMC
         s9N7hsm3mdNYuHK935/GB3ZRIQtKENYZ9UYoAPObnLqMJk8ROR8oRHiO4QTlw3S6DjIc
         Ua+w==
X-Gm-Message-State: AOAM533XxZmWQq4ex6H1rkE2668+0EDRUslIf195wMYZ6xxf50Gz+7iw
        4BlFpNkZgZuhxDGD1ouhSObw1XfIIj3YlkFLEhUrNKTtpZ0JBw+LOni5TbSHsFiamo25MCbA9jM
        myyDbA4j9AI6iV8/3QKtLdvdHNvm2Lj5estFZUMQ5TQ==
X-Received: by 2002:a05:6402:280b:: with SMTP id h11mr7446509ede.402.1644683833016;
        Sat, 12 Feb 2022 08:37:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUIS5XZJwcH/oXPkDCwlaYXgS9xWXGSa3hZYgN6Ichr2oZbBytnhatpKpWIWOfF2w+YAttqg==
X-Received: by 2002:a05:6402:280b:: with SMTP id h11mr7446498ede.402.1644683832858;
        Sat, 12 Feb 2022 08:37:12 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id x10sm2494443edd.20.2022.02.12.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 08:37:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: soc: samsung: usi: refer to dtschema for children
Date:   Sat, 12 Feb 2022 17:37:05 +0100
Message-Id: <164468382250.54495.10506365677169420285.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220211164716.120880-1-krzysztof.kozlowski@canonical.com>
References: <20220211164716.120880-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 17:47:16 +0100, Krzysztof Kozlowski wrote:
> Explicitly reference the dtschema for USI children implementing specific
> serial protocol (I2C, SPI, UART).  The SPI schema is not yet accepted,
> so it will be provided later.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: samsung: usi: refer to dtschema for children
      commit: e465ea5cc05d1d0b45c315fca0254bd2ee04b661

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
