Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A635A54B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiH2Tqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiH2Tqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:46:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE6A74DD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:46:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id se27so10082838ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=l3skwgcR8n0TOtdyqt/xNUW8nplEdhTPfhgsXZmnrKQ=;
        b=Yh6+YwaYs1PzKrQTJaAcU09TQYQ2BIGSMNIL6ouglFa+xuasecyb0lSAiJXHeXPe5W
         Bdi1x9neZ+kJNbCdv8uBNAPx+itz6RiwmysKHXqQJwccMnyO+wvtumLBctfPs2L5Mzxc
         lZtZSMj6NEgFT7vYzYwDw9bKvtsJ6ul7lXHFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=l3skwgcR8n0TOtdyqt/xNUW8nplEdhTPfhgsXZmnrKQ=;
        b=x7+FHCxMvM9qo5nHtEvvr9BhIFCrX3Fk4GeRBPTTzwFo35gW/LBjxIFcQDeepC8Dru
         tq8388fo1m3AaJLbN68KhbcXOsQvK+z8byErW4qXIw2em4IvgT2pE64KPkebCMg2mWVB
         Xa+zYowYOWl0Ll+oRH5VOyk3L/0OCF77E/ioli4/yC8Ntkjg6kcDl50OLkMX4cEdZBCc
         Q84+N9GxP4KBYwqzWd/PjRxo22zvKtchot4SWKvujQcD32I/D7sYNwzYqDP/ZXqLR10R
         P7+N1NQdNVeSjSioQBGt4J0SbBYB1z7wkskck8mm62JpuWx/BpZRKScDtIyFTXr3dY4v
         Frow==
X-Gm-Message-State: ACgBeo2XbfjOrPX1buo+3TpaRtclqJGsEUEh2547r8st56Ik+SQdMoIm
        peq7nWCUXcSbJFTBn23sXs4JSpFckPyi0A/OC/ZR7Q==
X-Google-Smtp-Source: AA6agR4AEPuuqNAvtj7VH5sf6JPa+hVk/+Aj2e2mnhnqmHmfyg0qi61fsdOXESAcq7oh5B/9ODgKCOxDrbIsiJdwxLQ=
X-Received: by 2002:a17:907:7f0b:b0:731:b81a:1912 with SMTP id
 qf11-20020a1709077f0b00b00731b81a1912mr14735533ejc.8.1661802387869; Mon, 29
 Aug 2022 12:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220829030521.3373516-1-ammar.faizi@intel.com> <20220829030521.3373516-2-ammar.faizi@intel.com>
In-Reply-To: <20220829030521.3373516-2-ammar.faizi@intel.com>
From:   Caleb Sander <csander@purestorage.com>
Date:   Mon, 29 Aug 2022 12:46:17 -0700
Message-ID: <CADUfDZpE_gPyfN=dLKB6nu-++ZKyebpWTvYGNOmdP1-c_BLZZA@mail.gmail.com>
Subject: Re: [RFC PATCH liburing v1 1/4] syscall: Add io_uring syscall functions
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Muhammad Rizki <kiizuha@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
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

On Sun, Aug 28, 2022 at 8:07 PM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> --- a/src/include/liburing.h
> +++ b/src/include/liburing.h
> @@ -202,6 +202,14 @@ int io_uring_register_file_alloc_range(struct io_uring *ring,
>  int io_uring_register_notifications(struct io_uring *ring, unsigned nr,
>                                     struct io_uring_notification_slot *slots);
>  int io_uring_unregister_notifications(struct io_uring *ring);
> +int io_uring_enter(unsigned int fd, unsigned int to_submit,
> +                  unsigned int min_complete, unsigned int flags,
> +                  sigset_t *sig);
> +int io_uring_enter2(int fd, unsigned to_submit, unsigned min_complete,
> +                   unsigned flags, sigset_t *sig, int sz);
> +int io_uring_setup(unsigned entries, struct io_uring_params *p);
> +int io_uring_register(int fd, unsigned opcode, const void *arg,
> +                     unsigned nr_args);

Can we be consistent about using "int fd"? And either standardize on
"unsigned" or "unsigned int"? Looks like syscalls should maybe be
separated by an empty line from the register/unregister functions in
the header file.

> --- /dev/null
> +++ b/src/syscall.c
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +#include "lib.h"

Looks like this include is unused?

Other than that,
Reviewed-by: Caleb Sander <csander@purestorage.com>
