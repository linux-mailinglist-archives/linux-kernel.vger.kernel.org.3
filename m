Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773934E58AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbiCWStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbiCWStn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:49:43 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B365A0;
        Wed, 23 Mar 2022 11:48:11 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id j83so2563055oih.6;
        Wed, 23 Mar 2022 11:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=56J3GohQxdWaUNz7jQ2eEsIABoOTuL958gy1PE8F0ck=;
        b=DUoLoVZ/rDn9oQ/vFbbJicRa1l11n/zsCo8nr44vHks6jw/1v8rx9foY+hMjR+4fsp
         a0Haw2CAEChp97RUkywc58GHlcQfRYLTq2VtJh7rb46lDxQ5gDf7iwh3qtWkGa7K+kkr
         1VcM7FEPUMxqfHh1Yr3f4fS+5Ma/1PmGj/h6yrRLNPlfMnk6zEUeYTT90OQIAaC4gMn4
         n8w0iddJCBVW81pNaL93tZfgT9YVd9ihse6KsTwZws/Y0Px91GzDP5aPcgod5u1YP8gc
         fiW1hH6zps+RZleLiWSEM9wPYNzNRgPKjaHv+7LaoJDI0AMPM5hF1i+nB0LI1V3nodlN
         o/YA==
X-Gm-Message-State: AOAM531qwJoHJIfmhIqXBPDOU6BAHljLjlIECwZStMzLOFVapPpJ1Vb+
        sroIiEirhT8AydcFNxP14w==
X-Google-Smtp-Source: ABdhPJyFLHubkitJIKDgjYHSdLjgwJ/cuVQanHqprHw4EB6GVqxlaV8Sxw0nJfSrmHho34tIgDeGWw==
X-Received: by 2002:aca:ebd1:0:b0:2ec:91e4:f423 with SMTP id j200-20020acaebd1000000b002ec91e4f423mr804158oih.1.1648061291132;
        Wed, 23 Mar 2022 11:48:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q9-20020a4ae649000000b00320d35fc91dsm348675oot.24.2022.03.23.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:48:10 -0700 (PDT)
Received: (nullmailer pid 242466 invoked by uid 1000);
        Wed, 23 Mar 2022 18:48:09 -0000
Date:   Wed, 23 Mar 2022 13:48:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     patches@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dt-bindings:i kbuild: Make DT_SCHEMA_LINT a
 recursive variable
Message-ID: <YjtraaYJFuNG30xW@robh.at.kernel.org>
References: <20220315202032.538911-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315202032.538911-1-nathan@kernel.org>
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

On Tue, 15 Mar 2022 13:20:32 -0700, Nathan Chancellor wrote:
> A recent change added a warning when yamllint is not installed, as it is
> needed for 'make dt_binding_check'. However, it also changed
> DT_SCHEMA_LINT to be a simple make variable, which is evaluated when a
> Makefile is evaluated. This causes a warning when running 'make clean',
> as Documentation/devicetree/bindings/Makefile has a "clean-files"
> variable:
> 
>   $ make -s clean
>   which: no yamllint in (...)
>   warning: python package 'yamllint' not installed, skipping
> 
> Make DT_SCHEMA_LINT a recursive variable so it is evaluated only when it
> is used. The warning still triggers when 'make dt_binding_check' is run.
> 
> Fixes: b3e664a7f449 ("dt-bindings: kbuild: Print a warning if yamllint is not found")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
