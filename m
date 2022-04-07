Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8114F8475
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbiDGQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiDGQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:02:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910FE1CEA5C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:00:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q12so2292166pla.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6a4H8HV1J1GWRBIi4IGbWGv8XxIGXLwrXto7pFoaICI=;
        b=6m9mi3vVxxLf3dcis67u5E5YSBGmN8iT0b28RQFOuZvE2djmgulr9ENEXauJ5+2Ewz
         dVgvmRwzBaagyCHmpTjRZTq+RMx3ajYMcTd5XKFwJSErsWTwCewmFWr+zVy97GrNu3Mw
         U6+SAPd25JkyWHARZES9Pk0Eie8wwXyNLhoyLUkgK/cf5vWcR8EfIw9n8aihvfFe6+we
         btl9OU/KuGGB0fgAsDNL2zvH9O4z4bpzHvqTUb+ZANxHt2Z/k/QjpUW5tMMP7GAE5/RS
         AB8hS/nr15x1+H5YElFKi+K9tlGF3bCIv9F0PN3xiFJ0la4ZMH1/L2sZ7uXoz0u5puRw
         Tf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6a4H8HV1J1GWRBIi4IGbWGv8XxIGXLwrXto7pFoaICI=;
        b=EOcge4/ZLsb+DR6SX6l1Uz+uoWUWCIT4UjAMVGCqgHTe4HTpmHXMLYJEj24Hi+5Vxz
         1yJWaWiEIkY+43bvSUAtqtpvW+Pw5cyOJTt4RUepRs6qKLBJ4/7w7fC6OggsTJQPci2l
         IzKgeKgIG3LIw50VHdgZViSNQdwyOero7ewmV3dJaZxY3ax7ucxJjSrPCslP6ZKIHjHQ
         kPCf/Bck6UuWKBQU4DsmFvljlInE2fL6LenXmSLm0aEddRWC9Q/Qh8ts6cN8tmJdkKym
         VLkrsiAEBU9U1NBXHAArqLe+pYS5cSztOygzeQMH9xhSzXYox8Shzfz4oyEe49oWMiGe
         VIxQ==
X-Gm-Message-State: AOAM533jY7/zqix9IAzESZX/L3U1cDY9e1q+ZB7UpJ1B3dXawhBP7aLk
        EHEK8Nj+WgFmkeYjTimlSodsPfzFK39dgw==
X-Google-Smtp-Source: ABdhPJwI5u1tLe7Koa1GVWuqpDc8QwpaIfxSQBk3a/zEQdqfjz6ZvDKCdBQ5iBGZfXI8BP+4wpd/+A==
X-Received: by 2002:a17:90a:6945:b0:1cb:f39:5096 with SMTP id j5-20020a17090a694500b001cb0f395096mr5086624pjm.42.1649347220042;
        Thu, 07 Apr 2022 09:00:20 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:172d:8708:69ef:da3a])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090ae38700b001ca8947e73csm8949640pjz.0.2022.04.07.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:00:19 -0700 (PDT)
Date:   Thu, 7 Apr 2022 09:01:06 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: soc: ti: wkup_m3_ipc: convert bindings
 to json-schema
Message-ID: <Yk8KwohcR3I3UzVp@x1>
References: <20220407141750.2289293-1-dfustini@baylibre.com>
 <27f5eed0-e59f-9441-4e2f-3a2c5d8dddad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f5eed0-e59f-9441-4e2f-3a2c5d8dddad@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:18:25PM +0200, Krzysztof Kozlowski wrote:
> On 07/04/2022 16:17, Drew Fustini wrote:
> > Convert the wkup_m3_ipc bindings documentation to json-schema.
> > 
> > Link: https://lore.kernel.org/linux-arm-kernel/20220221125522.l3tntb6i7yjxp6vb@flattered/
> > Suggested-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  .../bindings/soc/ti/wkup_m3_ipc.txt           | 57 -------------
> >  .../bindings/soc/ti/wkup_m3_ipc.yaml          | 81 +++++++++++++++++++
> 
> Changes look good, thanks for fixing, although I forgot about one thing
> - all other files are using 'hyphens' in file name, so please keep it
> consistent with them.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you for your fast responses. I've submitted v3.

-Drew
