Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A774EE36D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbiCaVrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiCaVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:47:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0017A5A2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:45:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d5so1480175lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ll8wDYl9yPkVg3Kd+CZ9FcT778mQ4RwkoMnntxvyVZ8=;
        b=PFGro6VMa21mKPJKeSVTJVjR3NE/pwaa1U+bmujSaRD+Neww2xigiSjFNhL45z2pbF
         ST2B4yEbHQbPEODoXvQieVQmO2v52Sr9t6uBZOIcRQKt8sX04qxAdbsPieQFFi79lbQ2
         laMpQKDRaSjyl0TUOFqEWh7c0L8L9y3vjzXfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ll8wDYl9yPkVg3Kd+CZ9FcT778mQ4RwkoMnntxvyVZ8=;
        b=BirwsRyKANedfBj1hY9Vur3PejBK1+zHtBimE4PMWEaRLLsP8M1GzwuPXWQAVPhhUm
         tOVrTuft8hKGS44XSWPJ1b1LchK+e9SIzJ+p4PSB9wUPDuOuS/25JYe6oNkV94KaZIX+
         ArxopweDLk+CtcXG4tCp2g+wt3uBzvzOOAOlG6UhcFsOJ8GM9xUnXsb79N9R3xYYhUAq
         CTbWQJ1RdSXajV1JtniqP5iXoTdVYqgBsMvhYLRjE4OXJcLoLWU3bnUJchB58BjFy6hd
         QGaknIS0d+vGrhM4+HjaKRAqY4Q9q0Qh+JgPiKlyhNsg4rPgWt5tGXnf8eS0Ho/0WxfN
         khCA==
X-Gm-Message-State: AOAM531njlqTU/66mv3acvBKdGJWhaOPLTnpmtZDXcOgix4qyWygCM02
        /faLZTL/3tHjS9gHQoVDsQrRptb5/GIxZMZCF1Y=
X-Google-Smtp-Source: ABdhPJzBMSPeWSROL9WNOR/uyPgIMxyDWaC/OsiDinbrx4SHK8DR07pEl65PTLh+IN8S1hU7wZdTZA==
X-Received: by 2002:a05:6512:3f99:b0:447:1ef5:408a with SMTP id x25-20020a0565123f9900b004471ef5408amr12241251lfa.490.1648763157110;
        Thu, 31 Mar 2022 14:45:57 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x1-20020a056512130100b004484c116de3sm50998lfu.246.2022.03.31.14.45.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 14:45:56 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id o16so1533368ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:45:56 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr11993057ljc.506.1648763156044; Thu, 31
 Mar 2022 14:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220331212352.182168-1-Jason@zx2c4.com> <CAHk-=wjZys1fehfPCF2utXb_fthJwLywKO1ZsjiK2GsDu_e7dQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjZys1fehfPCF2utXb_fthJwLywKO1ZsjiK2GsDu_e7dQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 14:45:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirV0p6VSqrCbwLx+1kW7hQ3mk7LxDCY7XqfZGcPG-L3A@mail.gmail.com>
Message-ID: <CAHk-=wirV0p6VSqrCbwLx+1kW7hQ3mk7LxDCY7XqfZGcPG-L3A@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc1
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 2:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The standard templates I tend to aim for are

Note the "tend". No guarantees.  The numbered lists do exist, and do
still get through.

For example, Davem used to always do them all the time for networking
pulls, so that actually used to happen more often. Now Jakub uses the
"Headers with bullet lists" format, so it's fallen out of use
somewhat.

         Linus
