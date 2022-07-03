Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7EA564488
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiGCD73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiGCD6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:58:30 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200FDBF4C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:38 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so8768369fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2k/Fgz9AophWhcoIr519sZ69V4V1BiY/dYo09eq3joA=;
        b=En+hg1z5WrvULu1uNEZ6rtyfbDF/DZBOhfhOoSNIScEr8zQk0H0P76GLf2rTeqUwcg
         o0wftojb56p14cwueNRBf6CoqF9X6zN6Yc1hoUolKyYxDKB6mYvrOG/BCsCd07Z7MCcq
         7iEzIFnSbAP1dOs3Zy4baH7d4C3IDqh10sRND49ZlAqmK2EuPdmxniCWyF0ls4q/x2w7
         mE257gI77Nd1werdzliQ5AS9emjEcnhMdu2tW4euZw991uXNL8gWIu6LKmpFDXMoKs30
         8kUpXQPFJMmEW+DqFj41263/7rRjLSh/3Ytz59IO45/niPzk0mgJidW+1zDwCnFtODCZ
         YT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2k/Fgz9AophWhcoIr519sZ69V4V1BiY/dYo09eq3joA=;
        b=U2F3y7uFl8ibt6HynxKVOfxRDcdtF0ELMEdu30cHHXaA1dpJ54DbVNgUTYlmS3cRVG
         CIXqUqQxuAXGj3dAHM1DxDVsKGdY/w8o5lM2jpfi6YIxKF9UmrPRQdXvYHBbquh5LwIJ
         h0k+h3pUzpPlgPSMaouh3IZCjN5xU7hhWgSi5BCYd34JhmdtTiUpXwpGZxGxVfkEJB1i
         hZ+TuEix51Iv9aFVvNMhjT9f3LbewAWZxpyq0d5gbYE8TnZysnpbGwJZ/avLMxifptQL
         Oi5U2gouYeZcsRi6QLx8cp3J7GFV6hidxbI6mrzx7FHJJzonYTgcpqM7XUizQCewW3zm
         ZcoQ==
X-Gm-Message-State: AJIora+PjqrfNPQSIQGViEo+pPuGhYA8kfBe2FomagZwqCGQjXp3KRGv
        RKtkFUKaw2K+qSBV2P+7q4B4og==
X-Google-Smtp-Source: AGRyM1uKpVtgkHXxjyx68+94KRjsKPFxPkGxNK2SdQajmGJ0T+lNpKGyxY37Lp5e/vdYSv8gDzlHTw==
X-Received: by 2002:a05:6870:45a9:b0:10a:9ebc:63ab with SMTP id y41-20020a05687045a900b0010a9ebc63abmr12506689oao.209.1656820657789;
        Sat, 02 Jul 2022 20:57:37 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        soc@kernel.org, Arnd Bergmann <arnd@arndb.de>, arm@kernel.org
Subject: Re: (subset) [PATCH v3 24/40] arm64: dts: qcom: align led node names with dtschema
Date:   Sat,  2 Jul 2022 22:56:31 -0500
Message-Id: <165682055969.445910.9416568186177824296.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616005333.18491-24-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-24-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:53:17 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> with 'led'.
> 
> 

Applied, thanks!

[24/40] arm64: dts: qcom: align led node names with dtschema
        commit: 3cfe94d660a8ebc19e78ea0a4781d7e9a1054c65

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
