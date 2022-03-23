Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D074E58BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbiCWSvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbiCWSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:51:26 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92EA652CF;
        Wed, 23 Mar 2022 11:49:51 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so1686968otk.8;
        Wed, 23 Mar 2022 11:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1jRfgCA6HYKNBHH0oOGdmPolkRMIm0BBTXMi4QIsc4=;
        b=3h+deXGpOUJB2GLSc5WvirIFbXqGRFNfNSw4X2rCb7FZnqxQXwwtVFRE+cp0cDzqOb
         fnbv9mAwg05NRTUm097xeOQlHjeqGzZC64ua+DrNed/bP/PA333UCT27Xr0wrbZTPqrp
         GoBysBDbi5skW5MmQv1JPy1rfkAFMwOUmgrmMy8k7LIoJYSIiz61ejlt+fjdxDLGqzZ2
         GFHDyn4wgqYUktEaSw3zTWRSVjwfbUPUhJs52sNnoPathhRuJ/EiEsFcWr+aaUzJSncF
         o3mU1+yG8lYx3V4n/pVm/b+zuBeg4yomap5UNskagi1pXmcNDsaVIYbuIHuGnDkSCu2a
         z75Q==
X-Gm-Message-State: AOAM533dVviaG8nVA20zSXxo8hfh4Zdyb5lLsUXSIFZCx9/6zKYn1hv2
        ID5GHINw1rBeZ2KJi6GgsxwupHVLQg==
X-Google-Smtp-Source: ABdhPJxp8gog6x73KsM+b7yt7SY+QyD+8XRmcuCcMS1qTfi2jOJ5tYrIKCRupqLiV8jN4uGY1z3FHA==
X-Received: by 2002:a9d:2051:0:b0:5b2:20d1:b38c with SMTP id n75-20020a9d2051000000b005b220d1b38cmr630472ota.167.1648061390928;
        Wed, 23 Mar 2022 11:49:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gk6-20020a0568703c0600b000de4880b357sm293918oab.50.2022.03.23.11.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:49:50 -0700 (PDT)
Received: (nullmailer pid 245037 invoked by uid 1000);
        Wed, 23 Mar 2022 18:49:49 -0000
Date:   Wed, 23 Mar 2022 13:49:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH -next v2] dt-bindings: kbuild: Make DT_SCHEMA_LINT a
 recursive variable
Message-ID: <YjtrzaOLaA8dJbak@robh.at.kernel.org>
References: <20220315202542.2071351-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315202542.2071351-1-nathan@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 13:25:43 -0700, Nathan Chancellor wrote:
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
> 
> v1 -> v2: https://lore.kernel.org/r/20220315202032.538911-1-nathan@kernel.org/
> 
> * Fix stray "i" in commit title (I promise I know how to use vim...),
>   sorry for the mistake and extra patch.
> 
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Dropped v1 and applied this one, thanks!
