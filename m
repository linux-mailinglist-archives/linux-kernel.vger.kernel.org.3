Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05584DBFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiCQHEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiCQHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:04:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EF144B64;
        Thu, 17 Mar 2022 00:02:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o26so1989104pgb.8;
        Thu, 17 Mar 2022 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RowpWHpBzdZby6lbDdZdHo0oA7i+6jR2OZYJkKI99A8=;
        b=a9VwsHkRtiyfeUv56P65QTHs4B+k58upVXJSzFMHI/3WTbUpg/sD04K6s5auP+0yn1
         se4ao6HYGTORbprmmN2F8Nf6G7cWH67zYJisrmf6RTexNieADdivxFDoDlGwqDqPYiWn
         Eb9tPtNIporS3YEQF/2Ua1jlLkVTLqhSJwBfTohNl/EjCYsymKNwnAXP+GBu+aCiFbd1
         sI+2rK9a3XFjvI4nwHWQ5MnNpM1AiCm2FxjMlPJDdVG9T+qLeb3OuzjJtgzqjqsPXunK
         NZtn5VN06RG9cRxNtsSAJK5yQlILXGQvoX8t3ahgrb4FPC0RTX5FTaZSWmb1tYQ8o0nd
         sHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RowpWHpBzdZby6lbDdZdHo0oA7i+6jR2OZYJkKI99A8=;
        b=Uv6nl6VT7OT3tR/6/XAc3Y7fZCAwHAO9iGoSr7nPTDWxuA3LmAPCbDNbtE3k4bRPq5
         7VzPu+uOHymmftVQQ0BZC1a9DMmMDD0MatWewJzBJpZ0pi3XPfSXTTIiTRFV/fDQUr/e
         ffJ1hMLDt4MwijBMu2fBl9pC5Xw0DDw7mY2R19RN0cWK52qPLLmDq4VK99WIFzFOh1DZ
         KxhxcRMvkzuVtjtQRM5aSiMQesqEgw5hV7Hz/8tCqDvmeSlMHttwcnvZTiOeNxHN1DqI
         vHPGI3Ansy77omCLCuqOyjpM54YSywkzivMjWGVmk9tR6LIKcNEYjHwlmDUKaS1pm86K
         /g4A==
X-Gm-Message-State: AOAM533DaxmXXANLMBpqS/KtonRY17YSMm3nZKf0nwa/tm/OQVNeb1Ah
        NVSBthbTFF4fPJY8NQx6jUQ=
X-Google-Smtp-Source: ABdhPJxEk+fScQPzqKGaEohScukM8ZAsCc6cKV7mISxWXhnbnPfJVVi2UowstuagvJ3fexynNm5nrg==
X-Received: by 2002:a05:6a00:1a89:b0:4f7:b90b:17ee with SMTP id e9-20020a056a001a8900b004f7b90b17eemr3657896pfv.46.1647500568879;
        Thu, 17 Mar 2022 00:02:48 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a0024ce00b004f7281cda21sm5935779pfv.167.2022.03.17.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 00:02:48 -0700 (PDT)
Date:   Thu, 17 Mar 2022 12:32:42 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: Rearrange compatible entries of
 arch timer
Message-ID: <20220317070242.GA9239@9a2d8922b8f1>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-2-singh.kuldeep87k@gmail.com>
 <01ff2432-b8d6-3bfd-efa9-c61b1fdce19d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ff2432-b8d6-3bfd-efa9-c61b1fdce19d@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:29:07PM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2022 10:54, Kuldeep Singh wrote:
> > Compatibles entries of arch timer includes few extra items and enum
> > pairs which are redundant and can be simplified in a more clear, concise
> > and readable way. Do it.
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> >  .../devicetree/bindings/timer/arm,arch_timer.yaml    | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 

Thanks for your time in reviewing this.

- Kuldeep
