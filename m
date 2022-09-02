Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65AE5AA4DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiIBBGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiIBBGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175366BCF1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3574C61AFA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A033C43470
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662080810;
        bh=G+foTZzT5RWnrPBOckb1rqSN5DWVDDelGqvcOVRSIqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jNsPI19q+QvWykkoUx5PxFYUfgsgSz4vQYP3jAfkz7LORKVnkNxod2kBsqcbk5e1B
         yHutRgDmiyU5kpWk7L1Ak4VbvOWtt09itG2gaN44vRJa4f6SbHNZltbYsC4boJWGIv
         7VNY34ibfeiHiyy2F/W+X7qMIUGLGsJuiT7MGAxEaKe4YEqoFwW+t6nV/noOCLfOqY
         27HAU5kE/5VhBl/MQwf7mXefI17AqeyRrsnJYLh5DnaxNg5yMTD569aayCudIYZUY1
         U2fla4esMHqO0iVbHb1wkmydIc7Wq9BTch8ucj24M839g5u7LwpB1cwhF87DS4HxGq
         sFj1QBoAI/qBA==
Received: by mail-ot1-f54.google.com with SMTP id v2-20020a056830090200b006397457afecso475047ott.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:06:50 -0700 (PDT)
X-Gm-Message-State: ACgBeo06nKTriL8ksJLZ1n59I+Mu6gEao2DmVPy2d7+L4lXTUO2BOmwK
        i9+Fe3BNj7fDAbD3q3+HmtXIECksu4YzgsD0T9M=
X-Google-Smtp-Source: AA6agR44Cj/JO76hEKeM9LNLPEJOtlwqxquNV83WJgiqhEaHfCY7qxg9sevAiryJmQzhjxEG5kL9o5LfAWGxcWxb1uI=
X-Received: by 2002:a05:6830:3482:b0:638:92b7:f09b with SMTP id
 c2-20020a056830348200b0063892b7f09bmr13288675otu.140.1662080809806; Thu, 01
 Sep 2022 18:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222744.2210215-1-heiko@sntech.de> <20220901222744.2210215-4-heiko@sntech.de>
In-Reply-To: <20220901222744.2210215-4-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 2 Sep 2022 09:06:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQsXMB+igwMiya-sqyku+3iQPop1JJuHwXtTToj163h-A@mail.gmail.com>
Message-ID: <CAJF2gTQsXMB+igwMiya-sqyku+3iQPop1JJuHwXtTToj163h-A@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: check for kernel config option in t-head
 memory types errata
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it a Fixes?

On Fri, Sep 2, 2022 at 6:28 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The t-head variant of page-based memory types should also check first
> for the enabled kernel config option.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/errata/thead/errata.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index a6f4bd8ccf3f..902e12452821 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -17,6 +17,9 @@
>  static bool errata_probe_pbmt(unsigned int stage,
>                               unsigned long arch_id, unsigned long impid)
>  {
> +       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
> +               return false;
> +
>         if (arch_id != 0 || impid != 0)
>                 return false;
>
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren
