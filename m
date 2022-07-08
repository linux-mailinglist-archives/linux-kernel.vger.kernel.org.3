Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B056C312
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiGHV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiGHV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:58:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D52B251;
        Fri,  8 Jul 2022 14:58:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l12so12015882plk.13;
        Fri, 08 Jul 2022 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YODHnO1LmCBGqiPd708FrHJXkxopJIk81fB6obZ4ipk=;
        b=dKiG0skLfUXrwBkuhfhGS/K/FVDLj0T0Z5NYcO2Amexs9lSbkpTQAli5ZQQh0gYDEt
         pXTPMEALSBLPfXEjF9DTbSEVsuu8lpummbmX4yEUkcZLSomFWAps4cQFoUHh2PK+UKso
         K68/ntKYXEmWFQldoCzlbL6gQbxPk1uEweF1OmBYUCk1YjxkYl/vFjWpA++f9vDW5avX
         9BI6fwc4zTLAI8WrAQdCJ+itPZdhvZYRNALGW3yXyANil6buqbDmB/JTPL56c3PKBbjv
         Df6kTBpV0odjbA9iQftamRN+U+Q+N11CEeyw2wVhE9e2C0YAOum1P/QhFrcahyKNkhea
         jcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YODHnO1LmCBGqiPd708FrHJXkxopJIk81fB6obZ4ipk=;
        b=lbWn6qZrBIHM2cu1W8CLOZX4uXtiJC6VZ9EYFiAei+lpLPRE9ESGVWU/RuidCZGX1j
         sB1/RdW/mMpWXbfzDpmM+Eg1HdHIesMjrTMRKmqZnJiai1FRblmmYP9oa9yeCsHTb0s3
         X1hl8X+jyKH5buqN1R6QZJ5WLpcGcZ6VZ7AQvCgAhl0013NsJOcLHfjfXQHp5nfUg9lC
         SFYCSsstWhE0Jz1Tj4fmQkStzMgIXlOhA1f2YHp2yM/21ysDU6y7LJWheCsEJjFHNaU7
         QI1QNTIwtc9zLK48xkpxqfE7V90HQKmy6oahShWfVZ6h21FiJks5T0TdU8ui2/JEv8iA
         EGhw==
X-Gm-Message-State: AJIora8XmDMcc73+tzutXrjGVxj1/YkA1z2epfpju8GjddAZIAGZ+F0Z
        8n7756y/7rwVWo6k4Cqv9P8=
X-Google-Smtp-Source: AGRyM1tV0ms11Blf9Ccca6UETulhUQLXnofCrR3mMxa5QaQjJzpLhRlM4R+p2uTFI9JajQ3TBWv+Pw==
X-Received: by 2002:a17:902:f543:b0:16a:54cf:3da9 with SMTP id h3-20020a170902f54300b0016a54cf3da9mr5558669plf.1.1657317503525;
        Fri, 08 Jul 2022 14:58:23 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9707:b37:49b0:77c2])
        by smtp.gmail.com with ESMTPSA id n4-20020a6546c4000000b0040c9df2b060sm28291903pgr.30.2022.07.08.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:58:22 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:58:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <parent.f@gmail.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/2] Input: mt6779-keypad - fix hw code logic
 and row/col selection
Message-ID: <YsiofJQBZvLgQKSh@google.com>
References: <20220707075236.126631-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707075236.126631-1-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:52:34AM +0200, Mattijs Korpershoek wrote:
> Input: mt6779-keypad - fix hw code logic and row/col selection
> 
> This serie is the first follow-up on the mt6779-keypad in
> order to enable it on the MediaTek mt8183-pumpkin board.
> 
> To fully enable it on mt8183-pumpkin, we still need:
> * double key support
> * dts changes
> 
> To ease up reviewing, I preferred sending this first.
> 
> The first patch fixes a logic bug based on the (non-public) datasheet
> I have.
> The second patch configures the keypad correctly in order to not
> report bogus values.
> 
> Thank you,
> Mattijs
> 
> Changes in v3:
> * reworked row/column logic as discussed in [1]
> * Dropped Angelo's review since patch 1 changed
> 
> Changes in v2:
> * Simplified SEL_COL/ROW_MASK macros as suggested by Dmitry
> * Added Angelo's Reviewed-by on patch 1
> 
> Mattijs Korpershoek (2):
>   Input: mt6779-keypad - match hardware matrix organization
>   Input: mt6779-keypad - implement row/column selection
> 
>  drivers/input/keyboard/mt6779-keypad.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> [1] https://lore.kernel.org/r/YpMDZORAlHmg/x/0@google.com
> 
> base-commit: c4bcc1b99b8b8acdfe673e4701a9c2acb6b8b2fb
> -- 
> 2.34.1
> 

Applied the series, thank you.

-- 
Dmitry
