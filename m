Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F86542BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiFHJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiFHJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:46:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD144994F2;
        Wed,  8 Jun 2022 02:13:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 187so17818960pfu.9;
        Wed, 08 Jun 2022 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YCm71yQ1aHpppu7Qyx6KCYcqHhXcfD7GUUOanT5OZB8=;
        b=n2MQ1YWh+m9tYO0E1/8JFp/WJnfEwBHe1fPWeoTwaa2oLXU6rYqy58k/JSXLdhmbTP
         v377y1QSjCtF4kaTv98GdxaNiqjndEacbxV4hWIYw5bXOZTSHfWPZJbVrRsLne7kH8iF
         GOhd0Yy934+obIyyNKJtev8077nPfzvNTpnZuqWllgh2mRHpk+WxNzBtWUIOdLZNkkMD
         21imI3m/KfwsrsZ+L+8XKcj0n2UzPcRI9QCQjX6w/GaDXZhdH5t2T2A+N50+6VVb5j96
         H53r1xKrQk56ly8bYrobw8mpJYs0C6W4RfUB5jC+Fu3Byijh7SF4saqi7a4McwGEVWx8
         MKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCm71yQ1aHpppu7Qyx6KCYcqHhXcfD7GUUOanT5OZB8=;
        b=OQVEBlPOZUFxyPkGWth3tSXl/pfTYoVQZQqecfZDjj+DUQJRMPtO2gtEH3+c3QVTuq
         46hvOtTzhU18YMLV42LHa715BVlU/kfto5mzTrZ2RbFuVxXnm44AVbNMiHzq5ANGmac6
         xkwQGrFZPLGyl+jVyssWWMRwYCC59r+ubkef02qkFpa7uURJhPtb/HB42c1hEFdg2UYL
         hU0lPWf1BNFA4fw0iG0G+5/S9bBnkwC6OdsXSSTyQTCS6q4QnUwr1qVQLLL0wtc5E2DR
         dOY5hOh0WGHq/p8FhT62SuTdDZlKYvqdZ4d2/tZ9qrdJspDCDBTbms67AFlAYK1FSLw/
         bTzg==
X-Gm-Message-State: AOAM533N4/IO+0/09mi5UUvx0IXfgLd4+94ORhA+jYQ+OrXrq1sev1f7
        wOWxCvBYkOy2M3yIxp7KwqE=
X-Google-Smtp-Source: ABdhPJwMoASgcHZ4y9He5hVn/vbAHm06vaoj2PR63DBVd0tSjst4qdg8tCVyebIXcechZp6MvTM+mg==
X-Received: by 2002:a63:8641:0:b0:3fd:94e8:a650 with SMTP id x62-20020a638641000000b003fd94e8a650mr15472183pgd.367.1654679581178;
        Wed, 08 Jun 2022 02:13:01 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709026f1000b001635c9e7f77sm13639515plk.57.2022.06.08.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:13:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: broadcom: adjust whitespace around '='
Date:   Wed,  8 Jun 2022 02:12:58 -0700
Message-Id: <20220608091259.1461365-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526204339.832296-2-krzysztof.kozlowski@linaro.org>
References: <20220526204339.832296-1-krzysztof.kozlowski@linaro.org> <20220526204339.832296-2-krzysztof.kozlowski@linaro.org>
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

On Thu, 26 May 2022 22:43:39 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
