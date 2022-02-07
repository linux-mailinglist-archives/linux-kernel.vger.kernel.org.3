Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0327C4ABF48
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448612AbiBGNML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358150AbiBGNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:06:42 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB501C043188;
        Mon,  7 Feb 2022 05:06:40 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id 60so22715473uae.1;
        Mon, 07 Feb 2022 05:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZStMkBCEdUkIJefmCWfZykazV+/zPRZRIGtWs+bRb0=;
        b=zVdog81bqfyQClBj3TjJwffNUnRqGYEEVIpDRMVlDr9RDc+EpYhhnE+FRsgLBvX/IB
         QL5/DEpfp9Skv3Z1x9duy4515pCf/sR/sMLQwFSjMUsWOYDlSTqTbRXLglnVjfETbqGE
         MBzNy9ZZfpsCs+gQN3+2YFlVk8oEwOWJzwgKQwnBTuLY2iCLLW2EIDB7dwVyF1qQGcYm
         S36oDCIoiOtkBuSV/w3RQmVF7TLG58pgD4gjUeKSX8G7tO1b5M+cS15K6zEgvAnejVQS
         clwBuKfNjoOLVyL1ATiQN77JC84wOjbkBNOXn/IqHpnXVtDMbeXWc99pUwnjzAg0HNPl
         7cxw==
X-Gm-Message-State: AOAM532CMcnYIwC1DqksPdcsl5Y85meiYP01b4V8fyJBSHjSYq+MHI99
        t6pBWM53xFJk0J8d7v2tmxAMUqbZc3hvdQ==
X-Google-Smtp-Source: ABdhPJzFQTtECeDvgEBcBOSXjqDqXP8RaSF++Sk1oQ1ZdlJX6MzhU4MqKtE0UqYWw/BSLoTtS2zJ7w==
X-Received: by 2002:a67:3341:: with SMTP id z62mr4394352vsz.70.1644239199785;
        Mon, 07 Feb 2022 05:06:39 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id w3sm2326819vkd.5.2022.02.07.05.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 05:06:39 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id g18so12473821uak.5;
        Mon, 07 Feb 2022 05:06:39 -0800 (PST)
X-Received: by 2002:a67:b00e:: with SMTP id z14mr4329049vse.57.1644239199108;
 Mon, 07 Feb 2022 05:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20220128173006.1713210-1-geert@linux-m68k.org> <c1034042-f8f4-b5c9-3b0a-8d1aa1efc8e7@gmail.com>
In-Reply-To: <c1034042-f8f4-b5c9-3b0a-8d1aa1efc8e7@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 14:06:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWS2Eh3c-=GPj8GpMwYesGXqSgwo3__cTfM5_5h5=qYyQ@mail.gmail.com>
Message-ID: <CAMuHMdWS2Eh3c-=GPj8GpMwYesGXqSgwo3__cTfM5_5h5=qYyQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: mm: Remove check for VM_IO to fix deferred I/O
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 3:22 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 29.01.2022 um 06:30 schrieb Geert Uytterhoeven:
> > When an application accesses a mapped frame buffer backed by deferred
> > I/O, it receives a segmentation fault.  Fix this by removing the check
> > for VM_IO in do_page_fault().
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Works fine on my Falcon030 when applied to v5.16.
>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks, queued in the m68k for-v5.18 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
