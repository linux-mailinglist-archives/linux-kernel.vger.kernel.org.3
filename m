Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4C516D19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354499AbiEBJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384157AbiEBJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:14:08 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F3113CD9
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:10:39 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id x22so5546191qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 02:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmxOQDJKFTK/iawU/I+kdr0daxKW3a1js0+xQBoBccA=;
        b=il9uzdRpPv7TxeKdvNCIRDrt47OJYm9Op3sViKhJuVTESK27AQcgdj7zfbDiPFXlXr
         LFTnOlIMxGJKL+yZR7mAQ8vZGB88t+X0cOulNyWJnP7hjgLOcFY4HzaCJ7Rump4TzE/0
         b7KwDn9aVj+6CKxZpS2hcEfSLSYgTi2vhsZnonBtsKQZKuotlC1XDausmq9/Cpehl/SX
         HjPBCGTMuDI9+mM1025tn4gteWWUs1lBAH9I+SqROY5JPw1whAOrbFcNSoKWRnPt467K
         GuXpxqvMDi1tCEOsBOxvuguiVeCY6gcOXDjH7BZtPKtm2VgJeysW87cU1PkdthLD+EY/
         sQew==
X-Gm-Message-State: AOAM530lwQ1ayMbqYHV7E6xicOl83EEOPy5d14RWrtEunY00h6zex4tT
        2FC+DNUBQDpPWiZHQSpup7DPOQcs1+HQ8g==
X-Google-Smtp-Source: ABdhPJyxiJYMVHJEZEWZTW3bfpS0GLY2z86ccK+Q6gVzfY4m87Bv//151JsZRpcmIzE/VZwD47u0YA==
X-Received: by 2002:ac8:5c15:0:b0:2f3:ab24:ee75 with SMTP id i21-20020ac85c15000000b002f3ab24ee75mr576147qti.67.1651482638245;
        Mon, 02 May 2022 02:10:38 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id h81-20020a379e54000000b0069fe1fc72e7sm1496566qke.90.2022.05.02.02.10.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 02:10:37 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f7c424c66cso141451147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 02:10:37 -0700 (PDT)
X-Received: by 2002:a81:547:0:b0:2f8:6e8:19d7 with SMTP id 68-20020a810547000000b002f806e819d7mr10394893ywf.383.1651482637269;
 Mon, 02 May 2022 02:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <20220429130146.kxhxmi5jquzw56wy@revolver> <Ymvjt7GEXE306WyE@osiris> <20220429161813.oe55p4akkinjcarq@revolver>
In-Reply-To: <20220429161813.oe55p4akkinjcarq@revolver>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 11:10:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-afrvM9KpEBSGaaLQzQSzjez7bCgtxXEp49OdcAXKhw@mail.gmail.com>
Message-ID: <CAMuHMdW-afrvM9KpEBSGaaLQzQSzjez7bCgtxXEp49OdcAXKhw@mail.gmail.com>
Subject: Re: [PATCH] mapletree-vs-khugepaged
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Liam,

On Sat, Apr 30, 2022 at 1:58 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> * Heiko Carstens <hca@linux.ibm.com> [220429 09:19]:
> > On Fri, Apr 29, 2022 at 01:01:53PM +0000, Liam Howlett wrote:
> > > * Heiko Carstens <hca@linux.ibm.com> [220429 08:10]:
> > > > On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
> > > > > On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> > > > > > Fix mapletree for patch series "Make khugepaged collapse readonly FS THP
> > > > > > more consistent", v3.
> > > > > >
> > > > > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > >
> > > > > This patch causes all my sparc64 boot tests to fail. Bisect and crash logs
> > > > > attached.
> > > > >
> > > > > Guenter
> > ...
> > > >
> > > > FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> > > > bisect, but given that the call trace, and even the failing address
> > > > match, I'm quite confident it is the same reason.
> > >
> > > This is worth a lot to me.  Thanks for the report and the testing.
> >
> > Not sure if it is of any relevance, and you are probably aware if it
> > anyway, but both sparc64 and s390 are big endian; and there was no
> > report from little endian architectures yet.
>
> I was aware they are big endian, but thanks - the more info the better.
> sparc64 is technically bi-endian but I think everyone runs it in big

Sparc64 is big-endian. It has support for accessing little endian data
in memory, but that's merely an optimization.

> endian mode?  Is alpha the same?  There was a report of alpha having

Alpha is little-endian.

> issues too. m68k is also big endian - but also nommu, so that makes
> testing difficult.

M68k exists with and without MMU.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
