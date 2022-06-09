Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB4544BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiFIM37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiFIM3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:29:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AD140F8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD2961932
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71365C3411D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:29:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BTa3ImG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654777790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ZKCPkatmZQhMUqvjXsixnwwHTDth2O7Ki+YyHfUIdw=;
        b=BTa3ImG/q/FDhj2K9CGLypM1xgoxQSph866PKzoVsxVcHgCCqeaOcfLpa/KLeVFVYXgGTT
        fCWU9e6qcnH3QL+wsskpht5KQcX3b1MohkN+EypJS9z2QwT5toUmaZq+faUyVKTXH19NI4
        p2l4s8st1KOoWPWo6bioytmRT3bQdN0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 52557b63 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 9 Jun 2022 12:29:49 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-30c143c41e5so239294967b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:29:49 -0700 (PDT)
X-Gm-Message-State: AOAM533gatbTNgBaR3jbhHwbKnfAcfnStHxwHJKEqHkoi6WYldx3SB/n
        hOc9yg9un1cuDbIiRIqfmy8h0nx523NQSTmCtww=
X-Google-Smtp-Source: ABdhPJyb0QIJ7TWICAPZCiS2OJY6lap9/tFDuzmweUf578cIz3SS7SYKHoZT+c4EehPz7vXw/aTl77QcI36HThOsARg=
X-Received: by 2002:a0d:ef03:0:b0:2fa:245:adf3 with SMTP id
 y3-20020a0def03000000b002fa0245adf3mr44088700ywe.100.1654777788720; Thu, 09
 Jun 2022 05:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220609121709.12939-1-Jason@zx2c4.com> <CANpmjNMKEP246YyDDqW5TPb090f4Fr-PY3Kn2X7N62wTRCEUrw@mail.gmail.com>
In-Reply-To: <CANpmjNMKEP246YyDDqW5TPb090f4Fr-PY3Kn2X7N62wTRCEUrw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 9 Jun 2022 14:29:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9rkQDnsTu-8whevtBa_J6aOKT=gQO7kBAxwWrBgKgcyUQ@mail.gmail.com>
Message-ID: <CAHmME9rkQDnsTu-8whevtBa_J6aOKT=gQO7kBAxwWrBgKgcyUQ@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: select random number before taking raw lock
To:     Marco Elver <elver@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 2:27 PM Marco Elver <elver@google.com> wrote:
> The compiler should elide this branch entirely if
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0, but not sure it'll always do so
> now. My suggestion is to make both new bools consts, to help out the
> compiler a little.
>
> Otherwise looks good, thanks for the quick fix!

Disassembling reveals it still does elide. (gcc 11.3) But I'll make
them const just in case and send a v2.

Jason
