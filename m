Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299D566A15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiGELpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiGELpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:45:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953317077
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:45:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i18so20063138lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r/4T324lD8keVZQ5PYxI+TWmPc+ll7mlIbj/tyFipEg=;
        b=URNJuoOpk11cwvlncuWTNnZWX81XgDdSq2sk4ggVSqyshGUOyttDiBZMAMrUZ53cdS
         UxEdb5yao8x82Cg67KkBx3UBW2EOZZwnfULw31Cb5x1mfD0LiE8DszQYOLDpI0djx6gx
         qGb+FfCvIeu17sB4bz3twfxNlnsuI0jkWr24PA38Lmyyb3Y2lszeV+ZVOekbRZRYxOYA
         /g5VVucsOKKGkttArP7gS0ROtvWAtTC3UghlCgsVbvNB8BXEaihcyZ6KEHR6dZa0OhmX
         w3uCjaYyUcDT71MZbTYAxiDn4Jux2e1iVVgp+ZOl35ENoD8WBqUOZPoj64XKEL5apYgs
         zy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/4T324lD8keVZQ5PYxI+TWmPc+ll7mlIbj/tyFipEg=;
        b=0mBOPUGbB+ic/FkFSyEW2IJ16Lkq2kxRmEGNsr5XLPXmszOZvR8Auxu/rb1kwlQGIp
         iYGhOWSCGnm4w7AHb6doNcw7UoVYrZGo1hATbU+9ryhAfVFOV7V8gKH9lPGze9RNNeuJ
         9q0ND22azxqFduJMP9uaoev5SOc52QvFdlKVeO4DC656ibz3vI5fjm5z9qsb54JE3FsY
         ta2I7sfuQMwID8fJ2pltZEiZeSWRHe0AZufXFGgwn2OcfXw1jVth9DzEfsQ8O24piLwW
         qNbsHG8hN2h/Wv51spdFBivuCsF6XsPxS3ouC4QTE769L6oW9N3SnHlI3FpxMlMB2/ti
         6Itg==
X-Gm-Message-State: AJIora9gXK48OXDTWk7e1ZZz7DhSA56E8vBN0VFJD03NcxagDAkIF9Pm
        z1R9Yw71+7XkDNMO+l9dCyt9bg==
X-Google-Smtp-Source: AGRyM1t2xrKflh6+ZDUqgZrUw23+6BNtmn1uXO9uRraUJ8CvQFIBVL3fJqJJsi41XYxhjs43M9wogw==
X-Received: by 2002:ac2:4c56:0:b0:481:16b8:637c with SMTP id o22-20020ac24c56000000b0048116b8637cmr22631447lfk.87.1657021545341;
        Tue, 05 Jul 2022 04:45:45 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512374c00b0048137a6486bsm3543694lfs.228.2022.07.05.04.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 04:45:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     olof@lixom.net, krzysztof.kozlowski@linaro.org, arm@kernel.org,
        andrew@aj.id.au, soc@kernel.org, joel@jms.id.au,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 36/40] ARM: dts: aspeed: align gpio-key node names with dtschema
Date:   Tue,  5 Jul 2022 13:45:42 +0200
Message-Id: <165702154046.92998.7201310803196878513.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-36-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-36-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:29 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> 

Applied, thanks!

[36/40] ARM: dts: aspeed: align gpio-key node names with dtschema
        https://git.kernel.org/krzk/linux/c/7bd809eee4290ae7277f4fb20f270fcedd74737b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
