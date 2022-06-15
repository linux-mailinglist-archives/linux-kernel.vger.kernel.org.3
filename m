Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C654CE98
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbiFOQ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFOQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:26:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33214338B7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F56B81C28
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878E3C385A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655310388;
        bh=FD5j4SKfub77EhFvGLVSiVhWZYONVp84mYDANSKecr0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zf3Ixdc9JVVtzOVDLBkdgrrEkbHHA23IEPGkAK83gmhTwq8hehnNWPYQsIEbt8ngh
         wa928nlgQk1cC1wMKy/acg5wAjj+R1h+Os/aqxFsFeqA0C0EuYP4ePwpqses3TUy64
         RwaUHLjlqpAzKqSmsvoe+51Z/dNVWE9nXGpMF3yNEg03OMEIAjX8wbXRiiy84szyMk
         D693OF+4gTWNG78Z4g6zNcGH0dhMKmDsRDAcs/7X10oww4SimfCTtMXoBI8HPaSedU
         s2nQoyG7d5q7ZpkTO9TwQOqaMAQN/OkGbZcgQ7cmgr+yhCsrLZdWRwDTJmWr8t4DAR
         w2oywSzsvimzw==
Received: by mail-vk1-f170.google.com with SMTP id b13so5623643vko.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:26:28 -0700 (PDT)
X-Gm-Message-State: AJIora/d4YXrzOtVxsVzRFlNBeEk3tmojhlz5RVCKgFh/C8xPLeqNylz
        nC874wwVNRB00gyudVRd18aZM8luRgfTCm3mIw==
X-Google-Smtp-Source: AGRyM1uoT28wvd0wfJS4n1kBA5lobK0uR1O3Cix7qoUfXaP8/ysFZKfn5X6uTe6vGYb0oX7MK+7iSlD4Dhp97pCWaao=
X-Received: by 2002:ac5:c4d8:0:b0:368:9f90:50a5 with SMTP id
 a24-20020ac5c4d8000000b003689f9050a5mr304037vkl.14.1655310387414; Wed, 15 Jun
 2022 09:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220615150325.3969911-1-windhl@126.com>
In-Reply-To: <20220615150325.3969911-1-windhl@126.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Jun 2022 10:26:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfzz=Pxk=GaOyLpDf1u5WaMGE=UYSVf4MCp+7RRQSBeg@mail.gmail.com>
Message-ID: <CAL_JsqLfzz=Pxk=GaOyLpDf1u5WaMGE=UYSVf4MCp+7RRQSBeg@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: kernel: Add missing of_node_put() in devicetree.c
To:     Liang He <windhl@126.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 9:03 AM Liang He <windhl@126.com> wrote:
>
> In dtb_setup_hpet(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when it
> is not used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/x86/kernel/devicetree.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 5cd51f25f446..6a386424ddf7 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -120,6 +120,9 @@ static void __init dtb_setup_hpet(void)
>         if (!dn)
>                 return;
>         ret = of_address_to_resource(dn, 0, &r);
> +
> +       of_node_put(dn);
> +

You don't want a put on success. If you are using the device, then you
want to hold a reference to it.

I would guess that if you have an error here and don't have your
timer, you're not going to finish booting anyways.

Finally, wouldn't dtb_lapic_setup() and dtb_add_ioapic() also need a
similar change? But again, if those aren't initialized, you probably
aren't getting very far.


>         if (ret) {
>                 WARN_ON(1);
>                 return;
> --
> 2.25.1
>
