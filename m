Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C4500783
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiDNHtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbiDNHso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:48:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD62F3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:46:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so5273596edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZACf14Zs4ghmlGixfvY80XJb14X/TIhq2Zk1CXUc0Q=;
        b=I0cbF59t7ZCgQYA0kYGOfxw8nnELP/Q6b+FdU3FMQbe/xZxZwQFZ7VUB/O7k+z5KBH
         fYPZBuEhgsM36w+2Epeykb7Jr+LyTR4iOXRi7cj2hiW4b66x/yggUVkERvM2eAKYtZNL
         Yez+IJXTiMQ4HS2qQOAP3ol++6KDw9W3wi1VkZL9gD74j3Xx3dy8XOgob0AHXXt47ud2
         ByfYBlBI/Lpq8PQ5QoJA9ZfHl1TQ6CLY995X1GH5P4ts85S0P8+Ardjs+AfBE6bOviK1
         QDK3qtYOlUeNlx/RVezsf1imLPNGSX9inx/ZAB9i1CwbCtk5GOys+zxfYaFICwlM5b7Z
         ywHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZACf14Zs4ghmlGixfvY80XJb14X/TIhq2Zk1CXUc0Q=;
        b=RQ+JJ1uxD+lj8hZVKx5+/PHo5yuTaWKvv63v8JUjHxzG/rofB/CyPyzR3rjwq75qmJ
         CpRvrdpxyMx2gedAtY3/GNYY2KurxfyLH+M+6oD4e9ZhlRgoVPj73NiSYyRSiJYSrYwp
         0KGbC9hlPlBl5lPEL96yS+Sq9i7M7NyWIudIwq5tUN2cuM3PN0dAfUGfP8Ykqe98TpBZ
         r97+zjKgnalvkZdixZhTJJ/fqb9CXyjWGzxaOsV7MDMc5XX8xui5npzLYP1U9HJCqAlp
         u/US+jvi+mfREZX5DTIGH2UiTIhRYfL8iBaZDugIuzCpK3Z2STsBtieTGnQBIbxkp8Lx
         8Oig==
X-Gm-Message-State: AOAM530DOMNpthEAWHRQSAcPsJcUMUHjqLo96lpLz99Ev1BWMQh+f8Ty
        vwGverirb5hoUKp0lhpntFSlLg==
X-Google-Smtp-Source: ABdhPJxyI8NKQhnAT+jqKW9ekCZzczQuBZwb175SSCOVY7zS38N987C/oKEs+Y+lRdq0VCGCzW2r5A==
X-Received: by 2002:aa7:c793:0:b0:408:4a69:90b4 with SMTP id n19-20020aa7c793000000b004084a6990b4mr1606455eds.58.1649922379386;
        Thu, 14 Apr 2022 00:46:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906310a00b006e834953b55sm375111ejx.27.2022.04.14.00.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 00:46:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mtd@lists.infradead.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Simplify single/double data register access
Date:   Thu, 14 Apr 2022 09:46:17 +0200
Message-Id: <164992231509.17172.5871980426499229486.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c3b2a8d1a69f1b1e8d1a460148406cfb83e52eb4.1649857740.git.geert+renesas@glider.be>
References: <c3b2a8d1a69f1b1e8d1a460148406cfb83e52eb4.1649857740.git.geert+renesas@glider.be>
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

On Wed, 13 Apr 2022 15:49:21 +0200, Geert Uytterhoeven wrote:
> For manual write and read, factor out the common access to the first
> data register by keeping track of the current data pointer.
> 
> 

Applied, thanks!

[1/1] memory: renesas-rpc-if: Simplify single/double data register access
      commit: 1f26a60b55aa654c73b5b9eb9eab8a7d687d429d


You can double check if hunks matched correctly:

https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git/commit/?h=mem-ctrl-next&id=1f26a60b55aa654c73b5b9eb9eab8a7d687d429d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
