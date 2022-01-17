Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0F4911C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiAQWeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbiAQWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:34:00 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1FC061574;
        Mon, 17 Jan 2022 14:33:59 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id m90so33227259uam.2;
        Mon, 17 Jan 2022 14:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6GKKmupfWWlnbgXJKPfzJduT4T53vFjxxafbxuWCWg=;
        b=petsnc8lPMN850o8bB7rXXqsr7jTek96Ibwh+lLVqGy1nC6IOknt0HnjXjpcmfOEqm
         N/8+yo35F8ZgjCaaeqzv1NMEfg7Pt8yXnHz6muenSeqEVoSTHjOUb8xy/SD9+ryVqwn6
         Fj5lk09WqWsy0Kf+4puiN1ivWTVcYpLYEq9dkw1ntuRXpuYJsqjg/5AdiWeRYvAMh/iN
         k7pZNkMA5uha61nx/Z/SLrNpCkLup0vmUItmGaIpaQHallceNw9mza3k38ierx/W2LY8
         aPSdCBM1OrasuuvSjuu8RVtTHKm6rIkCTLJs18gthrAO1slm8npdnXZLDIRFkAoEm8T9
         4tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6GKKmupfWWlnbgXJKPfzJduT4T53vFjxxafbxuWCWg=;
        b=Zk0L9Vy+w1wKF7NyZezZg6A0ZWJd4GAK12pysRr11xEoR8cBwR3qWAyFRermwB9chH
         i4N6RN0noLa8haNJD6whkT8CNpTkvlfuNe8WR5iB2SJfxxezOT/V950B/FDYKOsEONXb
         AjImBRD/1GShpHj8dYYnyJwkW5qV+22t4JrYosKcpdAsrqT3otEk3vfsTI02x2KToMjM
         HtxCd/Wrm7lzYc025XNHLJxsIrhY2OfzteulXqHEpCjKoNCi21pMRDN4U5rToGh6UD6v
         059cOFdJs20wzrvjv9D89j25DF4HSXdAziFijnRpAPAu9fBi/PP9msfyx0DfySzNwgbT
         zMJA==
X-Gm-Message-State: AOAM531LCUdEfe6HOx/pUsNy8Tx2MpgJ5rotVr4AIc/TC9AY7xOkhxRm
        4tkDCxEPaVYdYPoowTBkLP0s+l7q6tNhhQRvuUw=
X-Google-Smtp-Source: ABdhPJxWhkcwjL2R6hpGY61yBJ6r2FktnPVmLesfV1BZdfVRhtY/6a2CDJAHrMsl0L46bPttGQkAEE28ovqTC/SSiYI=
X-Received: by 2002:a05:6102:3f56:: with SMTP id l22mr7888725vsv.20.1642458839004;
 Mon, 17 Jan 2022 14:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
 <20220107052942.1349447-2-jim.cromie@gmail.com> <20220114115718.GB23983@axis.com>
In-Reply-To: <20220114115718.GB23983@axis.com>
From:   jim.cromie@gmail.com
Date:   Mon, 17 Jan 2022 15:33:33 -0700
Message-ID: <CAJfuBxw1scH7xS7-RfxZ369wVQ8umP+0MHqz1U_3cW-BLPsDkg@mail.gmail.com>
Subject: Re: [PATCH v11 01/19] dyndbg: add _DPRINTK_FLAGS_ENABLED
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "jbaron@akamai.com" <jbaron@akamai.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "quic_psodagud@quicinc.com" <quic_psodagud@quicinc.com>,
        "maz@kernel.org" <maz@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 4:57 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Fri, Jan 07, 2022 at 06:29:24AM +0100, Jim Cromie wrote:
> >  #ifdef CONFIG_JUMP_LABEL
> > -                     if (dp->flags & _DPRINTK_FLAGS_PRINT) {
> > -                             if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
> > +                     if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
> > +                             if (!(modifiers->flags & _DPRINTK_FLAGS_ENABLED))
> >                                       static_branch_disable(&dp->key.dd_key_true);
> > -                     } else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
> > +                     } else if (modifiers->flags & _DPRINTK_FLAGS_ENABLED)
> >                               static_branch_enable(&dp->key.dd_key_true);
> >  #endif
> >                       dp->flags = newflags;
> > --
> > 2.33.1
> >
>
> I haven't tested it so I could be mistaken, but when
> _DPRINTK_FLAGS_ENABLED gets two flags in the next patch, it looks like
> this code still has the problem which I mentioned in
> https://lore.kernel.org/lkml/20211209150910.GA23668@axis.com/?
>

Yes, thanks for noticing.  I missed that detail.
Apriori, I dont know why bit-and of bit-or'd flags doesnt cover it,
but I will take a careful look.

> | I noticed a bug inside the CONFIG_JUMP_LABEL handling (also present
> | in the last version I posted) which should be fixed as part of the
> | diff below (I've added a comment).
> | [...]
> |  #ifdef CONFIG_JUMP_LABEL
> | -                     if (dp->flags & _DPRINTK_FLAGS_PRINT) {
> | -                             if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
> | +                     if (dp->flags & _DPRINTK_FLAGS_ENABLE) {
> | +                             /*
> | +                              * The newflags check is to ensure that the
> | +                              * static branch doesn't get disabled in step
> | +                              * 3:
> | +                              *
> | +                              * (1) +pf
> | +                              * (2) +x
> | +                              * (3) -pf
> | +                              */
> | +                             if (!(modifiers->flags & _DPRINTK_FLAGS_ENABLE) &&
> | +                                 !(newflags & _DPRINTK_FLAGS_ENABLE)) {
> |                                       static_branch_disable(&dp->key.dd_key_true);
> | -                     } else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
> | +                             }
> | +                     } else if (modifiers->flags & _DPRINTK_FLAGS_ENABLE) {
> |                               static_branch_enable(&dp->key.dd_key_true);
> | +                     }
> |  #endif
