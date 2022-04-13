Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306984FF2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiDMJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDMJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:07:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A802A273
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:05:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so2705728wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NDtSKId3t6dVkA8YfqUQPPECjRhEPlDuS/Z/pAcPWM=;
        b=TuU29OnmVZBwDVSbKNjQMlspssMwQ0smsXVpvEekZAZYhMZ6rmcAtcUd71RRjOL277
         u6oyzNzv/A4ja7FzUqeBmT7WN1zE8/44iI/RvZ7P8smd6U4gAXVE8TQL/19+8C3+KPUv
         yBdRoUcWVJnyaqmXn/p5q9phVKTEcX9VLnba+gP/K4wx9g/FlU70zOXwqNnh5QQbNhqK
         nDYMONLJMbgaADuYmicO3KSDVch4RAKY461SnjN+MOe/GOELjayUmzGF/V1/T2RM2Mnv
         r/sGs1uE7Cvf9/P+VwBq0QFg4Qcavl40LxXI7JiXW34D5+6iGXS69QhIxsLs4kRvyi2f
         KhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NDtSKId3t6dVkA8YfqUQPPECjRhEPlDuS/Z/pAcPWM=;
        b=shFwbKghtCIzpwt0XWeuQd6eOG7GuDM8e9SWAYSu6W2LjYdrq3CQpIeVH5WxobI27M
         puSfEFXw2jFxhCJHbg4Fz5e3idaq7yTx0xZlNK0BNk3pxCSEc86IvOlzdqMBU4GfJguG
         75VEDNZU0fnXDNZc3g0X7mNKWF3YdBStId/RsEnM+GEB5gqTtUPccJr/p+jBkt9p60kh
         cnwfKG9wrnK4BGgw0tweMO91VV8H1pd65u037Kceh/gCEQszYAunwAqz9B4yIKoBvkFD
         80nxN+ySJaH6SuN5zb21b9UIacKwdSOAUKNv4A6OGCEj2VVAWYpHarI4UYnNCTm61i78
         U2fQ==
X-Gm-Message-State: AOAM532XRDrQ5UNpUuPHKGKePQ5NAKSDFODyYMcua8ckSIOKI2FQfjxo
        j6c1TMXwVgRJGHvd8TQoFRZ/8+3DgvSj1b2njrAs4w==
X-Google-Smtp-Source: ABdhPJylOEa/v15SyQPNZavNcci4UoiyZBtHsblEWuNg3HE6JBWlJPfFv0k6WcrfgqyGBjMmc+alxMQUkxaGdQ6vvWc=
X-Received: by 2002:a1c:3bd6:0:b0:38f:4e30:6c2f with SMTP id
 i205-20020a1c3bd6000000b0038f4e306c2fmr791293wma.66.1649840728817; Wed, 13
 Apr 2022 02:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-2-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-2-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:05:17 +0200
Message-ID: <CAAeLtUBrmBg1E=AdAkOQwMPYu74WtL2YuEacLdNA69PqqkDnyg@mail.gmail.com>
Subject: Re: [PATCH v9 01/12] riscv: integrate alternatives better into the
 main architecture
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:04, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Right now the alternatives need to be explicitly enabled and
> erratas are limited to SiFive ones.
>
> We want to use alternatives not only for patching soc erratas,
> but in the future also for handling different behaviour depending
> on the existence of future extensions.
>
> So move the core alternatives over to the kernel subdirectory
> and move the CONFIG_RISCV_ALTERNATIVE to be a hidden symbol
> which we expect relevant erratas and extensions to just select
> if needed.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
