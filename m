Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697D44F5C0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiDFLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245740AbiDFLVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:21:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93288548826
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:41:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n6so2385813ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvDX3kqlLsvwWpvH39s25kWK+Ue2MPPKZGZ4CtGKa74=;
        b=dzjS5Dnp2AgNeZxQXr6KxbAQ7LYkYbgODlPspVMrO+tqu0eA/4UxXouMDepdmZjkp7
         2SsXXjXSAt799+b9r3J/N2zNRdQpU0qfxVlaHevrqmPHKDqknfiFqrt1yHz2jgUdJtq4
         K/0lXFrm5pzcQoXLsw9xqmW0/0cQxZAdBXUkWQOTQG3JaREWv9Hg7whnGN3ojnc5TNNv
         LM5e1ZBxS74fM/7fApBMk9hyq5jd4DZ7DYgBhEtd8cFKgNFKdFZnJF4FfC2OrwbbUuRd
         nv+iFBaVf32TrTk1tprk0eeWD+2DTF4nOGad1r5JrzalkJj5Qf7U2btnE9AzkWskMdnj
         j6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvDX3kqlLsvwWpvH39s25kWK+Ue2MPPKZGZ4CtGKa74=;
        b=5FlHvj5mU36Nba6VOz3Iheb5pKkHeYfrOkLf29YepjaVZ1i4uHQrq1UlaTPIYIQUYa
         RstIM/+mScEfDVUfhDIEQcSE49y5NvBeGMMtKOCDqW0HeQQrVNgpNPyQvt7MK3r3XpFK
         Ldy55jwFvmxeb1taKlAjZDY4oVQscaykEFsbRFOxlmyFiDs5h+ylwvOKB8+bW74X40gx
         Nnvkht3q3myv034iKesvMpvh/xmn8ZQajAhDNiIgDK0lA7mf7qk3gogznYwIZ+REvOXx
         opm6BKDEJwC6jfq0OE0BR3kOkVOGPZZj8ECxfjBvilg/P2oVxv2EUyG5P6XM7gAMM7Gn
         nxpw==
X-Gm-Message-State: AOAM532u2zbsdWZ3GTBSJWqETv0uhEMs1mAOi9/5NkoYS60QvcXPcf/j
        JDUahSvn1faTjzIr/jy3s+7d3A==
X-Google-Smtp-Source: ABdhPJwMefSGt7p3g1TL6FQ5EJ+QANqPfr+S94kzFeANh+BVO6Z7I8zyrGJZwSgQmNw9KUBHHbx7Vw==
X-Received: by 2002:a17:906:7943:b0:6df:e5b3:6553 with SMTP id l3-20020a170906794300b006dfe5b36553mr7060849ejo.398.1649230889147;
        Wed, 06 Apr 2022 00:41:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gn33-20020a1709070d2100b006dfcce8be86sm6187536ejc.225.2022.04.06.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:41:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: fsl_ifc: populate child nodes of buses and mfd devices
Date:   Wed,  6 Apr 2022 09:41:21 +0200
Message-Id: <164923087779.11222.1123001919450990524.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307204118.19093-1-leoyang.li@nxp.com>
References: <20220307204118.19093-1-leoyang.li@nxp.com>
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

On Mon, 7 Mar 2022 14:41:18 -0600, Li Yang wrote:
> Commit 98f1323959b8 was trying to replace the "simple-bus" compatible
> with explicit bus populate in the driver.  But of_platform_populate()
> only populates child nodes of ifc without populating child buses and
> child mfd devices residing under ifc.  Change it to
> of_platform_default_populate() to fix the problem.
> 
> Fixes: 98f1323959b8 ("memory: fsl_ifc: populate child devices without relying on simple-bus")
> 
> [...]

Applied, thanks!

[1/1] memory: fsl_ifc: populate child nodes of buses and mfd devices
      commit: dd8adc713b1656ce469702eba8fc1adc4db91dc4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
