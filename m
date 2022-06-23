Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0854F5587C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiFWSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiFWSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:40:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB960DE939;
        Thu, 23 Jun 2022 10:44:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n15so12550951ljg.8;
        Thu, 23 Jun 2022 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLUchrIOubSs10x5xtiDZcRvEe4xc2YtaLT4q8v3KIc=;
        b=HoyHPkXcI6iJBV1lvnAjM0fOa/XVWhe7zBsqVuDWL78EzMB3yfd2EoJe0Rd4CN4cBb
         9/5z0w0Sr949FJSwskmtonupgvM7FbBB4KFcUMvhWeTJ3gt4OXNgs3LPlFpTj1T2ZR6N
         xIP+4x3W9NE+SDa3wO3K0N4iyDYOCYWxp1S1nzACvfrzKCkNudEEUsyzZU7X6Eqru2gC
         DMrr6ayRkLnirAEeIAwc7EfXqQGc74kLi8xbP6wecJA6ug/+19D5jp8OPsKNcuahGdFg
         LgaUyuGh/t9LR/6MCohaIqhI/QVhACp49G27yLsJxGlCVaPfnqtWnhdcH/t1qQGU4BEE
         DmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLUchrIOubSs10x5xtiDZcRvEe4xc2YtaLT4q8v3KIc=;
        b=oXmKbzoy3HLm858B2/TTHJ+zMqXYPHr55S18iECJLj/83G4sszYl0umr+RzLmurfcC
         Ev1M0NVEwAPsxOkUAgsPrb16ZpVseoi7pk8HV+U4sDW1LV81MsyY0cg4kYjEa6qnTrer
         gEFrVnN8t4R9MGbeF9XLDqWDYLRQMNb6MZ6PexV7QApSC5UCZR4R87sVRnWOcKHMC0BB
         hcjdApQbxPrUalf/vw73lEBOwGHv+EKY8EEcDUliqHwkEuXcM0EzNMK//FsI1ogmv6QG
         mG1YOfDpvy4KfDzKB66J0tXqZPVF3xCxTdxDkvrUsnhs2LO+BPbOh1FHEGD4PqV9qvtP
         REww==
X-Gm-Message-State: AJIora8N1Jca+lFcWI3OGJaO3L6oJeMl48QldZi1M2yUUT5gNbkw0C8L
        91ydYhE+mJVRp4h+Y9VrDa0=
X-Google-Smtp-Source: AGRyM1sw3nkreR+af3BGIXfmPlInMWhWOBgFsXexGlQHCAxWOgx4Qj+rYioCaAVPEd17nNChvoqpeg==
X-Received: by 2002:a05:651c:1202:b0:25a:6096:bd7e with SMTP id i2-20020a05651c120200b0025a6096bd7emr5308591lja.304.1656006241352;
        Thu, 23 Jun 2022 10:44:01 -0700 (PDT)
Received: from sakura.myxoz.lan (2-248-181-228-no2390.tbcn.telia.com. [2.248.181.228])
        by smtp.gmail.com with ESMTPSA id h10-20020a056512054a00b0047f834120a3sm1139273lfl.33.2022.06.23.10.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:44:01 -0700 (PDT)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
Date:   Thu, 23 Jun 2022 19:44:10 +0200
Message-ID: <4765633.31r3eYUQgx@sakura.myxoz.lan>
In-Reply-To: <CAK7LNAQ_4QUfBxRu2HpPS99Ay7JTcqFTHsrBmrPk+d8So5tjOQ@mail.gmail.com>
References: <20220621133526.29662-1-mikoxyzzz@gmail.com> <2650588.mvXUDI8C0e@sakura.myxoz.lan> <CAK7LNAQ_4QUfBxRu2HpPS99Ay7JTcqFTHsrBmrPk+d8So5tjOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 23 June 2022 19:15:14 CEST Masahiro Yamada wrote:
> On Fri, Jun 24, 2022 at 2:00 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
> > On Thursday, 23 June 2022 17:44:57 CEST Masahiro Yamada wrote:
> > > On Fri, Jun 24, 2022 at 12:42 AM Miko Larsson <mikoxyzzz@gmail.com> 
wrote:
> > > > On Wednesday, 22 June 2022 03:57:34 CEST Masahiro Yamada wrote:
> > > > > If you want to say "use this option carefully",
> > > > > EXPERT might be another option.
> > > > > 
> > > > >     depends on ARC || EXPERT
> > > > 
> > > > Yeah, this would be a fair compromise, though I think it would be
> > > > better to use "visible if" instead of "depends on". I can get a v2 of
> > > > the series together if this is desired.
> > > 
> > > Why is "visible if" better than "depends on"?
> > 
> > Technically it most likely doesn't matter, but logically it makes more
> > sense, since we'd make CC_OPTIMIZE_FOR_PERFORMANCE_O3 be visible if
> > we're on ARC or if we have EXPERT enabled, instead of depending on
> > them. But yeah, it probably doesn't matter.
> 
> Did you write and test the code?
>

Admittedly, I didn't, since I had falsely assumed that "visible if" was
just an "alternative" to "depends on".

> "visible if" is only supported for "menu".
> This is clearly documented at line 207
> of Documentation/kbuild/kconfig-language.rst
> 
> 
> Using "visible if" for config entry will just
> result in the syntax error.
>

Oops, yeah, I wasn't aware of this. Sorry.

--
~miko


