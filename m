Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C0586179
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiGaUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:54:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F7120BA
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:54:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kb8so2479760ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8udE8uoB93uvyZlPSO/At6OnaISC9AjkEA/Lil/8ZIc=;
        b=RXdA/hhOuYtjtLsjICxxWIPOCtIg9FAGmddkvsILWsPwpb2CImUOlXGktmIH0KWcUU
         Oi+dPDgXdKM3kJUXZa130UlR6HcKO/DW117bkUjTs7cpTnrtBvPipCqXDXhEufsyyWPE
         KMS5LcZVx0m9S0gYoEn1AX8EQhQAb2kyFXfX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8udE8uoB93uvyZlPSO/At6OnaISC9AjkEA/Lil/8ZIc=;
        b=GYPE9pJvAs2DDLlJNKaOXRIWNwlJBBZga/Ym8R26a5jtaWILP/4m9BvP2owb1cFtnX
         qH3ST9pn7JD9gQsQ0+Ja2b7jH+jhihnRdGOp7LZQk6vK8Q3It78cKeI/Pg94Ec2JqWGk
         tjepvksIu/RlJhBdpSsxrjyHnnGsDlQ/42y9jma5wrh5kR8m1wdr9aNBwu42dIJDXvNF
         2bPHKZX2Tls02aaPkplG85pEeLaaW3rREedz2n8XOcJVZJaadVf6wiQmfx14nNtEBRXk
         P7L8HYxMnD54MvP32rivgIJrxMTURD3DebV8B1XWk3Ls/6GfE2SM0vRbwOFikrNyP5KN
         Nxzw==
X-Gm-Message-State: ACgBeo3AEPYw/dUOWQx/bdAAnjuXSeUk8Omh7cGiw1u+PXmfCawJ79xV
        lvWxKS6auKy2sDEYFCDjyMroh0n5Ypznz4TGHO4=
X-Google-Smtp-Source: AGRyM1ukX2UTidFn/XRkDK8CdFxevAX8TghleFJSPYvbHfToi4x5uxOLwxRgkwkLsHtk+sjyomcDxw==
X-Received: by 2002:a17:907:1608:b0:730:5ad0:ae1a with SMTP id hb8-20020a170907160800b007305ad0ae1amr4888971ejc.222.1659300847275;
        Sun, 31 Jul 2022 13:54:07 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906301a00b006fec56c57f3sm4486212ejz.178.2022.07.31.13.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 13:54:07 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id i13so11479882edj.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:54:06 -0700 (PDT)
X-Received: by 2002:adf:fc02:0:b0:21f:c94:8bda with SMTP id
 i2-20020adffc02000000b0021f0c948bdamr8351235wrr.193.1659300392079; Sun, 31
 Jul 2022 13:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com> <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jul 2022 13:46:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY8Lfem5JvyUYMFwZVvE40=9fzDba_44au0w-hgaozJQ@mail.gmail.com>
Message-ID: <CAHk-=wjY8Lfem5JvyUYMFwZVvE40=9fzDba_44au0w-hgaozJQ@mail.gmail.com>
Subject: Re: [PATCH v2] make buffer_locked provide an acquire semantics
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 1:39 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Do you think that wait_event also needs a read memory barrier?

Not really, no.

__wait_event() uses prepare_to_wait(), and it uses set_current_state()
very much so that the process state setting is serialized with the
test afterwards.

And the only race wait_event should worry about is exactly the "go to
sleep" vs "make the event true and then wake up" race, so that it
doesn't wait forever.

There is no guarantee of memory ordering wrt anything else, and I
don't think there is any need for such a guarantee.

If somebody wants that guarantee, they should probably make the
condition for wait_event() to be a "load_acquire()" or similar. Those
cases do exist.

                       Linus
