Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EA4B4E71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351280AbiBNL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:27:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351205AbiBNL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:27:22 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A142AE3;
        Mon, 14 Feb 2022 03:04:03 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id w18so7905646uar.8;
        Mon, 14 Feb 2022 03:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rp0B1fei6v9T28LSqNLRZlACCfpViLDLxNd62kYmmtU=;
        b=Zhs51U5Pc4S2qQ5r38L6lfXMqWqLdlbyC/hZtQESnMwqzByM0KHEJVPIMILz3Vt+ZA
         miA5YDnY8wvSF/pOU127DXwv3SYvZ3xzHmydlPOwOMN+r81LFCgcAwMspjc17eRjiU0g
         OJBO8n8uap4eh5aQVw/G128Fn6LZfMHYFzAk+lKtf8Fw9kFswWimRY2O4p2bxHmxOqnq
         2mensGqGNXZqrwA7cI8jP/VqoKczZvX60wCKGgIRJzrNwF5OXWjxQfxEgtWby9s5RVOy
         +zpN9LcSVfdfI8nJw0YwBEbFH1u1LBj9O0wLtTCsW/q5xxY+Or20c3vCTMOFRfeFHTZb
         NpZw==
X-Gm-Message-State: AOAM530iTCIQMeV6v0dFNODOmYafHoKTJRFdmesCoMuhxY3qvxbcRRnn
        NNr5vNWpn5XteZkCTVUSEen0SONJclZPRg==
X-Google-Smtp-Source: ABdhPJxizCVdcM8K3JForQeIf4vuvRe59ANPp5AIbN8KJKprqyQ5a9sXPzo/svbk0mxQIX0y6fu4Hg==
X-Received: by 2002:a05:6130:10c:: with SMTP id h12mr1779257uag.120.1644836642141;
        Mon, 14 Feb 2022 03:04:02 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id g9sm526657vkg.28.2022.02.14.03.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:04:02 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id g20so6094833vsb.9;
        Mon, 14 Feb 2022 03:04:01 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr1073580vsb.5.1644836640828;
 Mon, 14 Feb 2022 03:04:00 -0800 (PST)
MIME-Version: 1.0
References: <9382f3ca-b49a-e900-7f21-3f10b267ee4a@omp.ru>
In-Reply-To: <9382f3ca-b49a-e900-7f21-3f10b267ee4a@omp.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 12:03:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWv-ZuHttvXM7kAOeM1NoRUxita0ttXcAbHHzA9UvO4KA@mail.gmail.com>
Message-ID: <CAMuHMdWv-ZuHttvXM7kAOeM1NoRUxita0ttXcAbHHzA9UvO4KA@mail.gmail.com>
Subject: Re: [PATCH v2] sh: avoid using IRQ0 on SH3/4
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
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

Hi Sergey,

On Mon, Feb 14, 2022 at 9:32 AM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> and the code supporting SH3/4 SoCs maps the IRQ #s starting at 0 -- modify
> that code to start the IRQ #s from 16 instead.
>
> [1] https://lore.kernel.org/all/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> ---
> The patch is against Linus Torvalds' 'linux.git' repo.
>
> Changes in version 2:
> - changed cmp/ge to cmp/hs in the assembly code.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Works fine on rts7751r2d (qemu) and landisk (real).
None of them had IRQ0, though, but dmesg and /proc/interrupts
confirm the shift by 16.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
