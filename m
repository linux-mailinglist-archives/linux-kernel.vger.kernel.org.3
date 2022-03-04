Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7264CCFC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiCDIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiCDIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:14:18 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E4665D2A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:13:31 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 45EA33F614
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381609;
        bh=PN+MwFyyD7KNKhN3V9sTc9ozhjbNqMNAeFcwOrkH/Mc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=jQLZrH58hWlRQirutLmFiWPu4+xkDTRoSVsohYkU5Qbg2tOzNcCOilU/ZgG1pyA7z
         KZ+1Y4rrxdEBoDbBune7YWUpbGGLe0W8MFlGdRhX9p7Vh6SiR0qhqxCZIfF1kwApOf
         OYDhZr80irR0CmKpITNYJ6vboRR3cx3rE8kpAVrvozRnQA3pLL1kAa46a9UH6GBMu/
         22Vffzlml/Wgmj35JV4Xuk65B9+AlDgvFsM3qeNVxM757ukWfEHVX4IuBBCmoXoPRd
         l55QKz/SSVks4pmZfLZYQnYAz9lZP8RSl5YiaZg5kRhmk0F8SsLG1dmwOx4Wx+JZ3/
         bcl+Plt2EmB9A==
Received: by mail-ej1-f69.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso4030793eje.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PN+MwFyyD7KNKhN3V9sTc9ozhjbNqMNAeFcwOrkH/Mc=;
        b=PbydmeORW9k7x1dtYwVd8Ezonaf3w6OQUHk8M+eQauv8Fi3qou0v1uKb0wfQJgeKLi
         grYmRT9I4SCaUT5r2YYHaBvcILC64xOb2YDWyKJ9mPI5ZPt/RwzIOE8U5VotKv6MvDOh
         lAawUPDKQxAPg4JSKcBdKNZI+rsAoUS68eEeGAo8rcgmLsHPYKnoNFOasGDMTG+yKUg4
         Uqxq4JsL96XASpbeS+q4AaNFb70XlmaJALHX/LOTp+bsUJJiTD9LG9gg5Ad6MwWdn8mn
         AXV4+DWBQStXOYjKwYnOBlNwixhiv8uV9Ka11Cb9+J5kKzNgqGonyWwVKDTgQQHVquVD
         +5eA==
X-Gm-Message-State: AOAM5312IIglMhMCPOyR14DARktBIaWuEf1KDgjECuHAe62V5Mw4KU8z
        bObKMHGc7pCtSvqbZBE1Z9gwnghdLbEgS/Q9MkGtqBEtjpTwkNq7Y1HOK/uzbg32ExREfIbaEG2
        MdUowP5R6dxinSj4wU3CdaOBVnmKiehuWh6KA9wOZ5A==
X-Received: by 2002:a17:907:d0f:b0:6da:63d6:b84f with SMTP id gn15-20020a1709070d0f00b006da63d6b84fmr9408978ejc.302.1646381608976;
        Fri, 04 Mar 2022 00:13:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtmf4M0vAgtkkJF2MjO14bSsPEfmcjiMMhZeu+y4rewMDiaaGtcHGsndvzz05ZBZ+o9hJiUg==
X-Received: by 2002:a17:907:d0f:b0:6da:63d6:b84f with SMTP id gn15-20020a1709070d0f00b006da63d6b84fmr9408960ejc.302.1646381608738;
        Fri, 04 Mar 2022 00:13:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id z2-20020a05640235c200b00415cec386a5sm1889584edc.16.2022.03.04.00.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:13:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
Date:   Fri,  4 Mar 2022 09:13:23 +0100
Message-Id: <164638154584.220122.4689452706717484391.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220301123527.15950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220301123527.15950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 12:35:26 +0000, Lad Prabhakar wrote:
> Document RZ/V2L RPC-IF bindings. RZ/V2L RPC-IF is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-rpc-if" will be used as a fallback.
> 
> While at it, drop the comment "# RZ/G2L family" for "renesas,rzg2l-rpc-if"
> compatible string as this will avoid changing the line for every new SoC
> addition.
> 
> [...]

It's late in the cycle so I might not be able to push it out to SoC folks. If
that happens, I will keep it for the next cycle.

Applied, thanks!

[1/1] dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
      commit: 69d6941949ea8a113ffc89410b0cb79bc7b35a0b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
