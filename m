Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C524E1D79
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbiCTSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiCTSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:55:20 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E47CB3C;
        Sun, 20 Mar 2022 11:53:57 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id g8so10403825qke.2;
        Sun, 20 Mar 2022 11:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmOsJbPyga6zQgluB+IIS/scLFX/2Re7pJBCaeSEJkA=;
        b=ICd2LKBUgLYxyqVNDQCHQ94jqE+FesQS4g5PeNVpw4zJ20Npuk9RNJ81ngD6SnIAOP
         MAhMx0KFbm6ggs7wZBRTLEYP3ieR4ePQttJAEErJ6uSzWEcSwJd2UNfVbthccuyrJ8dP
         ovvAY9XsyXpVRiN1gX54XlkF+jKLnpCu1xvn/zZFR6hLDhIgeKdLWbDt9JzYGSbMxdbb
         Lk7XJ8PZ/BdSU930OJILJqN0wAcasuMxNE8KnqPdYSO/AuNvNePFHYRg/+LDO34YZKYf
         sblDIC6iPAQQkjW39cfKomO1BZpb/+iPxqY1pZi6rTJ0eY1L5r7S5/4SkPT5v+6w59Qk
         lBKg==
X-Gm-Message-State: AOAM530QjjQ5T3DcaG7QBq2p1O6qllnCrxcL/69gjrhqsbyjxyYTnB1t
        Y2qOqeCjhT8AR0v6mBTogttYBxllCg==
X-Google-Smtp-Source: ABdhPJwtWDuiS6IGhQbHb9YOQ8XUUmqPDJgpbsZYvAl2jV0HGyGmkofZL5TnPIkKRzvShaWPdnV0SA==
X-Received: by 2002:a05:620a:e18:b0:67d:7fcb:6244 with SMTP id y24-20020a05620a0e1800b0067d7fcb6244mr11161433qkm.42.1647802436533;
        Sun, 20 Mar 2022 11:53:56 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002e16389b501sm9892530qta.96.2022.03.20.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 11:53:55 -0700 (PDT)
Received: (nullmailer pid 3206691 invoked by uid 1000);
        Sun, 20 Mar 2022 18:53:51 -0000
Date:   Sun, 20 Mar 2022 14:53:51 -0400
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5 v2] dt-bindings: gnss: Rewrite common bindings in YAML
Message-ID: <Yjd4Pw8dvrtyom9b@robh.at.kernel.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317225844.1262643-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 23:58:40 +0100, Linus Walleij wrote:
> This rewrites the text-based GNSS common bindings to use
> a YAML schema.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Collected Krzysztof's review tag
> - No changes just resending
> ---
>  .../devicetree/bindings/gnss/gnss-common.yaml | 55 +++++++++++++++++++
>  .../devicetree/bindings/gnss/gnss.txt         | 37 -------------
>  2 files changed, 55 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gnss/gnss-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt
> 

Applied, thanks!
