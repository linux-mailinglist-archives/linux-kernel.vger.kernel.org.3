Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E501542BD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiFHJqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiFHJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:45:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1D1CB73D;
        Wed,  8 Jun 2022 02:12:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bo5so17837244pfb.4;
        Wed, 08 Jun 2022 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fW/GsI6A8R+mvE9b7CONLo+jyj8NBZCnkmrcSV6IEak=;
        b=ohzQmVjPFUh12hG/i690v9W3BHDsT9l8y9sS8mA4RBOAjlr3MW5ium8/RAZ+UX5khS
         sCOG0IDkUNkt2bkp6v6xwMciw973fastwMqscU1e+u4bkHFG6wYyF2LLVRXJ1ULHmCBN
         bHEMRW6uOeNM1y+I63TSXbFBZ2e4EM8y/nIytphydYQUZR1rsM6ygCWjyig5kaubjHCO
         78lCxOpLQiAOe/lxfl0PkUxQBe2bz0MzWX6iBcr4TMMyhF9g9eVSKmm4teHeHYK1y7iH
         ksXOKVjvPSmpzRrTuoC3cvbvz/MxasVkiAwjqM1tkGpNpoBu8JZK6eHx2WvaWK8fkR+Y
         /8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fW/GsI6A8R+mvE9b7CONLo+jyj8NBZCnkmrcSV6IEak=;
        b=1MZvNgKckt1WnUtSqO3E5lLJ+Hsw/SnQNwRsodNiQlaYzSdmQo7xrsgYIjq7PFALtW
         kMgAZTRbxx2eg68vOGjwCMuVlq8CFpdVVvBK11Khh8+vJ6srNSL46z6FnmV86zyahbe3
         A/uN3KvNli+SHqeUwb1kevmzZRfwhLD+9worE0gdf80Sk2PxJJeJvLy1r70B9tIXnCoq
         Zl+7O5N0Um4emZqX4XYktFdz3L8BZwXRliG2WVuby+vbOqbKkuB4jp8fsIqridO2/HgC
         vwqoFiOjIR5BI674VrnCRbdw+Ymx0oJBF8ILGU6YJgg/Csk4hatCplxwWnjzSabJx0gT
         YqQg==
X-Gm-Message-State: AOAM532Irm6EYnO0eIpN9l4EV967d5Er2cnssKruHha5gXqZ1iQ9gKnJ
        56+B/QlefJkEYbdvwW/isx0=
X-Google-Smtp-Source: ABdhPJwiImHtG/1xmbPak4kelUGsGilLTjp7jGhE3AiEzmvz9x9KgNb4Lacvlz8VwSMAqOvv77jHeg==
X-Received: by 2002:a65:6d97:0:b0:3fc:af2f:7be8 with SMTP id bc23-20020a656d97000000b003fcaf2f7be8mr28652515pgb.246.1654679564765;
        Wed, 08 Jun 2022 02:12:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o20-20020a635d54000000b003fae8a7e3e5sm14301074pgm.91.2022.06.08.02.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:12:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: broadcom: adjust whitespace around '='
Date:   Wed,  8 Jun 2022 02:12:42 -0700
Message-Id: <20220608091242.1461212-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526204339.832296-1-krzysztof.kozlowski@linaro.org>
References: <20220526204339.832296-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 26 May 2022 22:43:38 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
