Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5063C4E5D47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347808AbiCXCnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiCXCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:43:44 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D27939CD;
        Wed, 23 Mar 2022 19:42:13 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id y142so6100858ybe.11;
        Wed, 23 Mar 2022 19:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bq+5q/LUFVvKeFoA9Q8Sa2EEy5fY9kO3b6Q0RwFcT+M=;
        b=NeTZ/xoEakoE9tymnST82PXzga/NTsC+AurpGjR1Wyt+KIolWF/FqaEV7hzaQohUP5
         HwTe7PrKTiw4puxCGeX6KAGEvLLZ4JkYxggAvoULjAzsKaJiNGWsBDqXgFMwNNHgAabz
         qwQPUOOz2Pz3lNnf2AXmH3ckngp1a8lXBAUm+eZF83D3VApmtvE1gFF+9cJQAACq1Quc
         6GN87dNCxNp9R4lCiBZTBgnditFebZkmkgFRMrehneEByAP88DLkE2gGd25opikqaZDT
         GLU/R0YF7b3dChCFBZaJL/cF8mT5xlV39vvnHuB6aQIaAB3dyhrOBO1dIa8fOXx/Kv4b
         eSgA==
X-Gm-Message-State: AOAM532aHPOmCJKF1t6NiFy1SCb4Oail1zGg9UDgDsQMFxLmZHsAExuc
        PLmwuPmEgjVeghTPtHqXQoXjz0xt5Xm3tb9hlYK+1YpC/c0z7g==
X-Google-Smtp-Source: ABdhPJziSYCyql+0Kv8XlVNqbr2ofruuie+pCnMX37bMuuM+FvKjDm9W3ej9ZdR3kL6WfSaqPniODXBiYtiM3+EupHY=
X-Received: by 2002:a5b:8cc:0:b0:634:7343:9953 with SMTP id
 w12-20020a5b08cc000000b0063473439953mr2807315ybq.142.1648089732442; Wed, 23
 Mar 2022 19:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFGhKbyifH1a+nAMCvWM88TK6fpNPdzFtUXPmRGnnQeePV+1sw@mail.gmail.com>
 <CAKwvOdmSV3Nse+tGMBXvN=QvnOs6-ODZRJB0OF5Pd6BVb-scFw@mail.gmail.com>
In-Reply-To: <CAKwvOdmSV3Nse+tGMBXvN=QvnOs6-ODZRJB0OF5Pd6BVb-scFw@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 24 Mar 2022 11:42:01 +0900
Message-ID: <CAMZ6RqJ7B_Yqs0jE0nmkX2Z=xh7Jj6J_ihP=ybLVn5VXY+5kTA@mail.gmail.com>
Subject: Re: [PATCH] x86: bug.h: merge annotate_reachable into _BUG_FLAGS for __WARN_FLAGS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Charlemagne Lasse <charlemagnelasse@gmail.com>,
        jpoimboe@redhat.com, adobriyan@gmail.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
        llvm@lists.linux.dev, luc.vanoostenryck@gmail.com,
        mingo@redhat.com, nathan@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org, Sasha Levin <sashal@kernel.org>
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

On Thu. 24 Mar 2022 at 04:41, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Wed, Mar 23, 2022 at 12:30 PM Charlemagne Lasse
> <charlemagnelasse@gmail.com> wrote:
> >
> > > @@ -75,9 +77,9 @@ do {                                \
> > >   */
> > >  #define __WARN_FLAGS(flags)                    \
> > >  do {                                \
> > > +    __auto_type f = BUGFLAG_WARNING|(flags);        \
> > >      instrumentation_begin();                \
> > > -    _BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));        \
> > > -    annotate_reachable();                    \
> > > +    _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);            \
> > >      instrumentation_end();                    \
> > >  } while (0)
> >
> > This causes following sparse warning on x86:
> >
> > make allnoconfig && touch init/version.c && make CHECK="sparse
> > -Wshadow"  C=1 init/version.o
> > #
> > # No change to .config
> > #
> >  CALL    scripts/checksyscalls.sh
> >  CALL    scripts/atomic/check-atomics.sh
> >  CHK     include/generated/compile.h
> >  CC      init/version.o
> >  CHECK   init/version.c
> > init/version.c: note: in included file (through
> > include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h,
> > include/linux/utsname.h):
> > ./include/linux/rcupdate.h:1007:9: warning: symbol 'f' shadows an earlier one
> > ./include/linux/rcupdate.h:1001:47: originally declared here
>
> Thanks for the report. There was already a fix sent for this:
> https://lore.kernel.org/lkml/20220317065743.8467-1-mailhol.vincent@wanadoo.fr/
> but it doesn't mention that sparse is warning about this, too.
>
> I think if Vincent sent a v3 that mentioned that sparse is warning
> about this, too, and cc'ed you, you could then supply
> signed-off/tested-by tags (or just do so on v2, though it doesn't
> mention sparse), and maybe Josh would be so kind as to pick that up?

Thank Nick, I did as you suggested. Here is the v3:
https://lore.kernel.org/all/20220324023742.106546-1-mailhol.vincent@wanadoo.fr/

Yours sincerely,
Vincent Mailhol
