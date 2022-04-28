Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20C513C52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351627AbiD1UIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351417AbiD1UIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:08:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A4BF949
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:04:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c15so8090591ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5qmgQrDnLOtncZ3275YmjeZwKcNo9SSdnjrjUy1pJA=;
        b=KvOxfE7bSF0qLmFgJXMr8pvaHcnvILpnzZmoVuGpiZZqrPs/kqyqRPpWxOQ+YqUul4
         9IUgQhjWtFc7FP87uRkOwOLJM8Oa5iY/v9kA4uBcqtjrpCuSW6QMt7WwBGqAV3jdX3mC
         1FQ/VCEfH6H4+EGcvAlentzQ3soQ5rMe/36gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5qmgQrDnLOtncZ3275YmjeZwKcNo9SSdnjrjUy1pJA=;
        b=ICIVNh5ghnpe8iPE/gN0cQwgmfIv47ZM4x/8VV2jN2c/hxjxljYp4DyCnG9w8oavGY
         0aldiUDtxzUG1S0U+H7xuZE8a8I358dK3qg60Oi6Ga127GSMdcBVgR7NcgmNNPKyKn+X
         Bo4kxoiXBp1PmeQzhbhWVdwuIeiz/NbTZBG+rE+6eYcJA9wUJof0FZo9njRHUDGY1nKU
         TJRuHrMi0z63ncPbUGqaK8G9i7lvpxz27rqp3jIUhJJ6+AHPYM/73mRkpWFk3yfwrQWu
         FjYwbBQw+R8E6BshDsN5qXlX3RlHx/XFSSA9ol/FC2iSsjrWF3zJTseyWGeSC1odhoQg
         nwpA==
X-Gm-Message-State: AOAM533Jy1tH645c91qlkikui9oae/1+VBojcY2DX9H+GSeunA85Jyci
        Bo4FM9S75Us+t+MFM4iSp9AMVoay1dKRPAPQUYg=
X-Google-Smtp-Source: ABdhPJwu8WSsPbWjYcd8aFjyvdGpS20dkCtF5bXsIFZdo97LxVbu3FeLwcNbVuF5VnOafXsx2EAqxw==
X-Received: by 2002:a2e:bc03:0:b0:24f:3b39:e805 with SMTP id b3-20020a2ebc03000000b0024f3b39e805mr1031939ljf.432.1651176293004;
        Thu, 28 Apr 2022 13:04:53 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a10-20020a19ca0a000000b00472172909fasm83918lfg.20.2022.04.28.13.04.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 13:04:52 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id p10so10509387lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:04:52 -0700 (PDT)
X-Received: by 2002:a05:6512:690:b0:472:4430:8f8 with SMTP id
 t16-20020a056512069000b00472443008f8mr256487lfe.531.1651176291646; Thu, 28
 Apr 2022 13:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
 <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com> <CAJZ5v0jpaAwq0Ad-ZA60bA5AU8JG1Y2muYtXy-bA4LapX8_dJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jpaAwq0Ad-ZA60bA5AU8JG1Y2muYtXy-bA4LapX8_dJQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 13:04:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiABQnUatiSozcckyK+NLaUZ=PZZqgTxbN0d6wsBKzarA@mail.gmail.com>
Message-ID: <CAHk-=wiABQnUatiSozcckyK+NLaUZ=PZZqgTxbN0d6wsBKzarA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.18-rc5
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Apr 28, 2022 at 12:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> The bug was that if acpi_idle_bm_check() returned 1, it would "fall
> back"  to the same state via safe_state_index.

That's actually quite hard to see in the source code.

Looking closer, the code calls "acpi_idle_enter_bm()" only when
"cx->type == ACPI_STATE_C3", but that is very non-obvious in the
context of that function (other than the comment).

It might be clearer if the function was actually called "enter_c3()"
rather than "enter_bm()". Particularly since it will continue to do
that "c3_cpu_count" stuff even if the actual power state it goes into
_isn't_ C3.

And the the C3 case doesn't seem to take that "demote C2 to C1" rule
into account, so now that code will go into "safe" C2 mode even if
ACPI_FADT_C2_MP_SUPPORTED isn't set.

It's all very confusing.

But whatever. I obviously already pulled the changes.

                Linus
