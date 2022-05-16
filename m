Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32D1528BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiEPRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiEPRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:17:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDC335DC1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:17:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j2so28277901ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXOnPvl8QcJEDWbi0XN3Lq19sfoQAsf+gUr01P/rvlk=;
        b=OM8kgeKWnkTLRBZ7RTDJtDZ0OhbvjKtrtPVbHiJv9VobLZNWVHWGgo4QzJUZykXSZV
         S978AF1P+/+TQwUaWw5r4iAwDc1TIqRPVZfN1U/fYopNiHC0uAC28XABNd1kdXGW/Cn9
         Gzzz9IacrdlQD2sQ8SN0iUKwmUj7CDUv2AQqwHCBdIW+MTQRZO6d1YJo05tPskMcsXRK
         6bHxZTPRNql9kT25XB+YzCb9HV5qM8t/bbn/OP++K53Zdm1sI9eoAErldOq/3+coa2/H
         g7PnWG4un2TUvBbf5ZxcHBq0UFRQF7bpmF3t6OdWsOOkZt3u3dTwaYtW+RnaDr3VwLWH
         RLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXOnPvl8QcJEDWbi0XN3Lq19sfoQAsf+gUr01P/rvlk=;
        b=mSpT38NoIQ+xHij6qEf4O2EI1ONtgE3EjDCPGZcUSi+WOvCDTH2OpNpu99TA5iV0QO
         zIHS/2KjV3gUwR550lJe3OG/1kxdlickIYB6mazRPhf7UtbWgRIVxIgmx3DxbrlVU5BJ
         KWIvG/v+LQuR9xDEnZOFvYK+78XchOD66fwi3aRfxwZvmgDv3ZrVLwrnRScX1+HK7XCz
         /vGIL4chJb9q8pRuUcoFAIJEszUv0/+WO3NUGhKM8BTE9y5H8vcJx91PqT99Mb4F5bhK
         sqJElYg64LFeeYz4qw9OichSkY7dbSrcGnzKr/xphegUzoWjFkosFbVBHuItlJrNmC6R
         u9lg==
X-Gm-Message-State: AOAM532Ue3nqZnX9s4avRGQFtM3iTlMP0SluMBpmf7tIkb9q2RbGgPM2
        QtDwVY1CjPQWAuNJbSg/SGtR+p8Juex2d5KxoiBpeTiH0Fg=
X-Google-Smtp-Source: ABdhPJwErdMw9lIEVb8u38lNc4NgNXjt+kXxu9dBYmAQWe/u7yXSrIRYHJOVxdd0pqgjysXHBrZd7vzZ6OxxZCayB/s=
X-Received: by 2002:a25:dc93:0:b0:64d:9c5d:d43 with SMTP id
 y141-20020a25dc93000000b0064d9c5d0d43mr6954243ybe.560.1652721420662; Mon, 16
 May 2022 10:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-22-samitolvanen@google.com> <202205141503.3D87637B85@keescook>
In-Reply-To: <202205141503.3D87637B85@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 10:16:24 -0700
Message-ID: <CABCJKud1j8RCa2khJBcDxpJA-kmhb1XYU8rJLca658oduEMeoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 21/21] init: Drop __nocfi from __init
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:59PM -0700, Sami Tolvanen wrote:
> > It's no longer necessary to disable CFI checking for all __init
> > functions. Drop the __nocfi attribute.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Maybe move this up after patch 11 (the arm64-wide __nocfi removal)?

Yes, that makes sense. I'll move it.

Sami
