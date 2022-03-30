Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0C4ECF65
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbiC3WQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbiC3WQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:16:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4024080
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E7B0B81C23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D522AC3410F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648678500;
        bh=+MqfinD5zpbYCPYjVIreefTaBYjg2GrTn2WA/RLrRfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s+mwTw03AIB2SoALqqAjJYslntDVPesHGpEvc+T0Y1Cg0pBY8jfcDqVvmSf1GfTBK
         le/e2srLdYGheSlA6r3zCd5Tr8a8v0bSWcJeOfL4a1eBfNUfmsusQo2OiZi7EVyPeu
         VeoLFjEMDAHY9chvVhHdbvskMstmpNPdY+Tpmd9vfsgyUOr2XPDJAPoEZmPIolAp0V
         vKKZ68dtQxPTgyOQvMJvnzMfm5xChyLo48wDcmBX3ZVsPWwu+XzZK1zQ2QLIP5Sk5V
         3zBhsK/3vZIftswnKVWZC+5rum9VpX7wlErn+v3ogVuqF6wi8sfrfWT8dz/bD4gsOZ
         Bi5NvPWml4rKQ==
Received: by mail-il1-f179.google.com with SMTP id b9so15483917ila.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:15:00 -0700 (PDT)
X-Gm-Message-State: AOAM5311PNX/z7wPrXUqvGwL6lZJzFoL5wrv4MUDvmw5CQJkYgwEXUKW
        ZuOs771fdfwXPSnZEx9FyU2vh4jrLYVotPJCag==
X-Google-Smtp-Source: ABdhPJymzYUK41vhjgTa/TKwyst/6S3q9rqOqMl3Fumu9XyEkiOIcoX+B76c2345o9s2VCiE10FD3Hzar0LuCGUqIYM=
X-Received: by 2002:a92:cd8c:0:b0:2c7:e86b:5139 with SMTP id
 r12-20020a92cd8c000000b002c7e86b5139mr12789911ilb.144.1648678499961; Wed, 30
 Mar 2022 15:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com> <20220311101940.3403607-6-tarumizu.kohei@fujitsu.com>
In-Reply-To: <20220311101940.3403607-6-tarumizu.kohei@fujitsu.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Mar 2022 17:14:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+TvPMZLeBx5Xi4pUNKueGUG9pSTXO2DzWov401w4a6Qw@mail.gmail.com>
Message-ID: <CAL_Jsq+TvPMZLeBx5Xi4pUNKueGUG9pSTXO2DzWov401w4a6Qw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Mar 11, 2022 at 4:23 AM Kohei Tarumizu
<tarumizu.kohei@fujitsu.com> wrote:
>
> This patch create a cache sysfs directory without ACPI PPTT if the
> CONFIG_HWPF_CONTROL is true.
>
> Hardware prefetch control driver need cache sysfs directory and cache
> level/type information. In ARM processor, these information can be
> obtained from the register even without PPTT.

What registers? CCSIDR register is no longer used. You must use DT or PPTT.

> Therefore, we set the
> cpu_map_populated to true to create cache sysfs directory if the
> machine doesn't have PPTT.
>
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  arch/arm64/kernel/cacheinfo.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
