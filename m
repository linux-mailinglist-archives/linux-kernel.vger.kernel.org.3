Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122805A3250
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345424AbiHZXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiHZXE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:04:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD9E831A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:04:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so2875802pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YVzdgHOnLRCNMj/Dtne4+E3xVYm73UAJFVxl5UM+dlI=;
        b=OR3CneSkHlCbKJtEcgpCri2+tewlhv5awjvREMp6AT1onwJcFk7obSWy94WM0oQrpv
         yCATqf2ZpkIPoo+j6Ds7kJ5gnpYDSczm0KyMMyXxOOo6UaMALxVVtM1PNYNhFI+atjkS
         +dHnatNk6iEnWkWjMzBIsLR24kZQ0jh2iwnFXHrmGWcWe/+lhPKX1duhOpUivlMPuUXZ
         edOMppqD/Ur7AN6XS51CbAoQqorPrf1MLHB6ypbPsLAe4I7t+hx22seAzy1OfgFCo8EN
         EcyLfxfloosq9fYL8FFTKEZnWST3q4frXOvZ3gNSC0P3Tmq/IZ1OmrJHvw9tCR9X3YIs
         9SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YVzdgHOnLRCNMj/Dtne4+E3xVYm73UAJFVxl5UM+dlI=;
        b=EgpjCmR90PACDghTySavUAauEIz7yxW8FgRWeSNehmV3gRJKsvEPtMoIKJISNDYfYM
         WE1VQcCDYiTKa5G3SzoVXGfkU8AJ4sOMVGG+VYYRVqjazCIHacLbS3eqqfA3KwIlCsas
         7/qFNa19Mh8F3xb4Vv/5eb6WdTUoZF/3XB9fMbBFYrqplWjyMdByt2kp0Q2rdjZ8nPrk
         3FNKkYZj7eHIj07UcOL+vVeSG0R9BfZuMKZlMOnlsml32vzH/eEyUB7zP6ZdbBGpNifI
         2t1HRpDRA1JT/cFWQzseg3Hf7M80QawCEjzBagG2xvpz6FSIdawV55ahJAjQlQLZR+6m
         CSqQ==
X-Gm-Message-State: ACgBeo2JxbabdoIASneKQhU/uKbquxDyh5GT/4zEH6nfE9SApzUHamAY
        zynf1SQru3ZiRdvdyIysjWMx9Ojvkcf5tpaDXC/aBQ==
X-Google-Smtp-Source: AA6agR5Btn0kkT/W3Cm9G0jt5/A14WqjaQI43EO2Vm1tLNohfq+llHJYBMuDof+O/M6OBJ6FLaaXr5STR5kpKb39RGo=
X-Received: by 2002:a05:6a00:1d1a:b0:537:d750:65b5 with SMTP id
 a26-20020a056a001d1a00b00537d75065b5mr3114362pfx.85.1661555067845; Fri, 26
 Aug 2022 16:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220826224812.550793-1-shakeelb@google.com>
In-Reply-To: <20220826224812.550793-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 26 Aug 2022 16:04:16 -0700
Message-ID: <CALvZod6HwDR0w4fYPkoKJeyoM6_DbHvrrHooeY+SaDAcpjjXxA@mail.gmail.com>
Subject: Re: [PATCH] mm: deduplicate cacheline padding code
To:     Michal Hocko <mhocko@kernel.org>, Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 3:48 PM Shakeel Butt <shakeelb@google.com> wrote:
>
[...]
>         /* Write-intensive fields used from the page allocator */
> -       ZONE_PADDING(_pad1_)
> +       CACHELINE_PADDING(_pad1_)

This needs a semicolon with the common definition. (I had it in the
definition but checkpatch made me remove it just before sending).

Sending a v2.
