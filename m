Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8885B1531
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiIHGxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiIHGxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:53:35 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A796C77B;
        Wed,  7 Sep 2022 23:53:33 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id h27so12208298qkk.9;
        Wed, 07 Sep 2022 23:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gmy5/+4JSKjjn31BCUCNFwApzR9XPUHVEEwjpPd0TFU=;
        b=D6u3Hzr+/7aEbAjCLrTckGPDHBJo6R8d9uBPPxVbcpawzXV1aiP+al/j2WFiNnuF6R
         wm0R3Y/GA8rX9ktPsGDFDO2Lcs3XNA6avLDb4VmUa8JUh0dtH0IRNEp1t+32e7ZgI9CO
         TC/Z76HqaCQZNho2H6hwOhlFADsmIMRQV6Qz0+OSxHZhmKpnJFWj5WpDOdkUt8gwbO9S
         5UpnIGztsrClXQp30cKmrAYvqCud8WDExn8uHwxh7GCyNp+JjfIcDtYp5VHi98X05dXe
         I6uy6l9PQDIVkaPITAgf1PTTqGmcX40NDolmHFSvM/JG4Ybm87woDGbEoJjQ97TFU1Sb
         1JSw==
X-Gm-Message-State: ACgBeo3MUvi957vxOqG6byczPNrP6iG3+Xw/KA5pW1jG6qnbeDXjCwax
        YBnYWxiPrYH9JLtsHuZN2ejh1tn5AXu/9A==
X-Google-Smtp-Source: AA6agR6BfIS2tTdC/6V6owURSibEQZ/Bm97oiIXHd8UZFgIcCtHy+SVkYTTxgcnnPZZzvluZ0PCwCg==
X-Received: by 2002:a37:2d05:0:b0:6be:8620:57f with SMTP id t5-20020a372d05000000b006be8620057fmr5123469qkh.688.1662620012282;
        Wed, 07 Sep 2022 23:53:32 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id t24-20020a37ea18000000b006b95f832aebsm15881888qkj.96.2022.09.07.23.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 23:53:31 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id b136so4255111yba.2;
        Wed, 07 Sep 2022 23:53:31 -0700 (PDT)
X-Received: by 2002:a25:e64c:0:b0:6a9:89cf:155 with SMTP id
 d73-20020a25e64c000000b006a989cf0155mr5445388ybh.365.1662620011556; Wed, 07
 Sep 2022 23:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220907234345.96798-1-keescook@chromium.org>
In-Reply-To: <20220907234345.96798-1-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Sep 2022 08:53:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTWgEttXyCggiUjc29zbsJ9OvKJa1WC+4V9RZQCQro7g@mail.gmail.com>
Message-ID: <CAMuHMdXTWgEttXyCggiUjc29zbsJ9OvKJa1WC+4V9RZQCQro7g@mail.gmail.com>
Subject: Re: [PATCH] sh: machvec: Use char[] for section boundaries
To:     Kees Cook <keescook@chromium.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
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

On Thu, Sep 8, 2022 at 1:43 AM Kees Cook <keescook@chromium.org> wrote:
> As done for other sections, define the extern as a character array,
> which relaxes many of the compiler-time object size checks, which would
> otherwise assume it's a single long. Solves the following build error:
>
> arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg/
> Fixes: 9655ad03af2d ("sh: Fixup machvec support.")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
