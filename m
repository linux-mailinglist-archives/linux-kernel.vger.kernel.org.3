Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AFD58EF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiHJPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiHJPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:43:08 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBA5C366
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:43:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10dc1b16c12so18245442fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=FlmWTYw3/xh3vpaf0ITQZcFdn3jiWTilvaIzda+vquA=;
        b=gP8IopvwF++4nHY5g9Q9M2/EZO4hp9snQqbqx6iZCX3S0KMDC+fE3+6GgXGXIfjyue
         Zxz/asDdYOcuqwbFiHPzAL1kv8EsrIyRgdUDMKAFMHKb8wqHHdP12zxUiufqRC16+Hdq
         Fz+ELgZRml0tCpsH6m80xhthiwaBCQSuVqQj6pPlPRsfxisn5vAn5TUkXkwmWRD8NaO+
         fe40cB4eUKnxl+FOqZf1LOnAsjZ1FayTzToqBjW4uxOl8SEvMTZtIoFETiDaew6kMiSU
         f/qKaul2i0jIm4S521mgbbR1A9h9GdguRF6rpzDtiB7eIqLmcL4j97alPU0m0Qlgsv6S
         mB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=FlmWTYw3/xh3vpaf0ITQZcFdn3jiWTilvaIzda+vquA=;
        b=VUf103OarVTVR70SkMcLmHSmXhosm/nsBFu7ELoDI+nzHKashph8Slj9glAIVu+io8
         NqDH7t6WKOQuq4mXbdU5dV8GBdhuwLSwtAftO9VbAr1uVn6wLyDoLJfQ4HfqtGeZ0mmj
         lyTRQ70GwzzGfUEkloo22oo5jQ7hxzm80wiG7uqLV26y/Qy+qNyF8mGjnMQTwRlqni+F
         Ro3XH6PjWwlVbxTI7SjxA4qwKq/A2gAD+VTP+Cg0U8FEbLlS8votWhDif9OT8SpgKY2k
         t53vig9DZ72Ze2+5Ht0VjdA2voEjyC4auHL9Hk0FkIBEaW+LmlV27RkwzPbWcplXvaf/
         Axlg==
X-Gm-Message-State: ACgBeo1e18K8lwzkxgSUaZGGmBSx63Q3yaoTNk8Ey8xVScriok3MEDga
        URUL49p/I+YkKMtILJ8fxBA/W1Rfrh3uig==
X-Google-Smtp-Source: AA6agR525BCxU7jVP2f3Ax1rwULslvscxmIdsGURzbMK84D9WkeX+w6/rxBEuj/LVdsvgO5k9Ugjnw==
X-Received: by 2002:a05:6870:961f:b0:10b:ad08:8909 with SMTP id d31-20020a056870961f00b0010bad088909mr1657778oaq.269.1660146186397;
        Wed, 10 Aug 2022 08:43:06 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 12-20020aca0d0c000000b0033b15465357sm682644oin.5.2022.08.10.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:43:05 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: smd: reference SMD edge schema
Date:   Wed, 10 Aug 2022 10:43:04 -0500
Message-Id: <166014617672.2836654.2552710779449608400.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
References: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 23 Jul 2022 10:23:57 +0200, Krzysztof Kozlowski wrote:
> The child node of smd is an SMD edge representing remote subsystem.
> Bring back missing reference from previously sent patch (disappeared
> when applying).
> 
> 

Applied, thanks!

[1/2] dt-bindings: soc: qcom: smd: reference SMD edge schema
      commit: 568f83ffe69ba38cc10f36417d6cbb6eee4dc802
[2/2] dt-bindings: soc: qcom: smd-rpm: extend example
      commit: 56e07c0c9e4a4b59a47a848b021a42cf203c982c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
