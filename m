Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2628A4EB36F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiC2Si1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiC2SiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:38:25 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD6F1817B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:36:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k11so4332679ilv.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BCw6nbHB1HhY9C/SvU0SfIcx4iHjYcssyIjUbMoR1g=;
        b=pS1aGCcGSgnivTPCc+Il/56orxKx1GRGqaqXURoaGtCJJizQNsPh4IxTyQcze5fi8+
         56p8uP51n7/s/VVInLARqXwsvRQePbpi67+umg11D/g1Lppxv4xmiaSd38XfckQ+KfWw
         dK0qfPW8NCjDwSo+OK1e1VpOJVU3PU8nedbZ1FWU0AcqBBtaGsBvM7qbzjlluLVnWAJ+
         OrO9e0wnAxF3rWJGEnLkweq0YJNg860Dx8x/czKBdsvJKzfIjtraMEquEpNx1UdcvFCy
         mOvlJal56W7OqLZspczniHMcUJNevVGK/1EVRQQlV8pfKoBkD/53/gBEuTfL+P0tnMi0
         WXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BCw6nbHB1HhY9C/SvU0SfIcx4iHjYcssyIjUbMoR1g=;
        b=fyltH9mgbZJzYiKNkP4StgnIDP65rPkGEAiTBQ1CVQ03X1kCHU4AJTDASZASsCpRP3
         W+3Kl0rfZaIM0D9jgwpVY8tegF/VrF0vJhD/L28OHG1xMInLUmZQf6xmblBp0efG+u10
         Skg/rYx7c1K9+UOOZCfFplgEN56V3wIOQQmih3zTP3QdCCxKR7UQYerF/3/1Sc0XmCsS
         QxOHxakRDz29c0gAWqvVLooYNIJLWipQGDrBj/RoSo77jA6uNJWboUysptD9/rNDf9TB
         R626KQhjjsJZ1nseyvjsooRnNtjvrnCML8uXT3cLFQ5ESlWJIiX75ip3yeBWbvgBATE2
         u22A==
X-Gm-Message-State: AOAM530n+cidhkPEa8vp5NCXdxjPMoUcE7b5IEtrLqQjMI5nLiqdekM6
        9GmBZNfzVjKiY9v3+4G4agGqqNJf2+SaJ5pedU8=
X-Google-Smtp-Source: ABdhPJzAm+MEvlNtDTnmWisD3LBrjjfAOpYyxgIRIGE0iqWfov1hWQH7t/sgDi7qOlP/TE9Sfe5z60tm9LH77djx/vE=
X-Received: by 2002:a05:6e02:1a43:b0:2c9:8e7c:ed98 with SMTP id
 u3-20020a056e021a4300b002c98e7ced98mr9055749ilv.235.1648579000098; Tue, 29
 Mar 2022 11:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <CANpmjNP_bWMzSkW=Q8Lc7yRWw8as_FoBpD-zwcweAiSBVn-Fsw@mail.gmail.com>
In-Reply-To: <CANpmjNP_bWMzSkW=Q8Lc7yRWw8as_FoBpD-zwcweAiSBVn-Fsw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 29 Mar 2022 20:36:29 +0200
Message-ID: <CA+fCnZeiR4v72P1fbF1AP=RqViCnkdtES0NtcmN6-R-_9NS4kQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 2:36 PM Marco Elver <elver@google.com> wrote:
>
> > Changes v1->v2:
> > - Provide a kernel-wide stack_trace_save_shadow() interface for collecting
> >   stack traces from shadow stack.
> > - Use ptrauth_strip_insn_pac() and READ_ONCE_NOCHECK, see the comments.
> > - Get SCS pointer from x18, as per-task value is meant to save the SCS
> >   value on CPU switches.
> > - Collect stack frames from SDEI and IRQ contexts.
>
> Do any of these new changes introduce new (noticeable) overhead (in
> particular patch 2)?

I'll measure the overheads and include the results into v3. Thanks!
