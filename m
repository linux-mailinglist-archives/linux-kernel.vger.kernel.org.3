Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A651E528C85
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbiEPSFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344526AbiEPSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:05:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B628E3A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:05:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ch13so30133275ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBfJCGFmnmHFyZCsMK3wiFpbhBcHWLVoHbOFzHKjGMQ=;
        b=OHPDgsoJ9Bun/JRtnlaDF+u3/KFPL+fwQx/BSD+2OcqFjFx/QGXobcm1CRZy7TMtVP
         0LuUnPFijF5+ItJrprEGEPSFe1bpieia/XbLg9lqUOCLhUNssSdIi1+lTGNznxxZwaBL
         2P03KdZI/jfFFNnuJgTizzalP59ckfHmlB4ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBfJCGFmnmHFyZCsMK3wiFpbhBcHWLVoHbOFzHKjGMQ=;
        b=CJLq17WK1NegAPPUfF5X4Hnt0DFUDKf1dwGBlF13+8laBOhKlxdSWrqyboxWlSzmJA
         /ob0GCXn/pqszy6yOXx3Q0WGmcX0WFvi5cRiKFiSMtDwChdsOHyJiaHai4zx9M6lxOAU
         2tQRRiqOGzydE0eMXPoFKQvSPRNWaCaLnPyFmY3M+oKKF6puLTDnuihjwjZGkYE9yjRX
         7zubQkTM8P08BR+rNNp38dtGKC5806LK4rxVPRtkeNVHptjR2gi6FRjGfVI211ro4McE
         sPhwvbY0knDSmFY5EHjv7MA/3BFXAUZCTT0gAahIVWex7XZ+9NBIeXP7uQ1rzHqqf2yD
         eQfw==
X-Gm-Message-State: AOAM532VGbDgqFUqhi0TVFVXPdNY85LNMI82n6D7wh9SVEaSGlb5GF5W
        EZ/gp2+gi/hNy30v03OvGNAssVH9McrVmLJ4
X-Google-Smtp-Source: ABdhPJzdz3YzgWs+8o3Q07hbgoE/oc6iJoUHdlFr+UsKW7ZJGk3Cam/CK3Ko6gIq06QRs39ZPanBug==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr15862877ejx.339.1652724309479;
        Mon, 16 May 2022 11:05:09 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id el8-20020a170907284800b006f3ef214e51sm8939ejc.183.2022.05.16.11.05.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 11:05:08 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so30208wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:05:08 -0700 (PDT)
X-Received: by 2002:a7b:c8d6:0:b0:394:25ff:2de with SMTP id
 f22-20020a7bc8d6000000b0039425ff02demr27938988wml.154.1652724307865; Mon, 16
 May 2022 11:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFRbGmGr2Z_sbYmE0SZT48CFkNAWVABnC_4V6x9PzZw-LJO4w@mail.gmail.com>
 <0db186ce-f789-f306-46ed-74ba75dec028@prevas.dk>
In-Reply-To: <0db186ce-f789-f306-46ed-74ba75dec028@prevas.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 May 2022 08:04:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi4ARjYWqoStREpT9EEGWEVsEknRJX5z2OGoSDcKor8ZA@mail.gmail.com>
Message-ID: <CAHk-=wi4ARjYWqoStREpT9EEGWEVsEknRJX5z2OGoSDcKor8ZA@mail.gmail.com>
Subject: Re: ERROR: drivers: iscsi: iscsi_target.c
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Test Bot <zgrieee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 10:48 PM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Hm, looks like cpumask.h should also expose a wrapper for
> bitmap_ord_to_pos ...

I'd rather delete bitmap_ord_to_pos() entirely. We have something like
two uses of it, and both are illegible.

There's a comment about a possible third use, but that one says that
it's not using it because doing it differently is more efficient.

And honestly, that more efficient non-ord_to_pos implementation is
actually a lot more legible to any sane person too.

I think it's a huge mistake to create these kinds of obscure "helper"
functions that have odd semantics that almost nobody needs. It only
results in code that is completely obscure, because nobody is used to
those very unusual functions, so to understand the user you almost
have to go look at what the heck the helper function does.

That "bitmap_onto()" function (another crazy helper) is a great
example. Not only doesn't it use that ord_to_pos helper, the "helpful"
comments that describes the algorithm in terms of it is just much
harder to understand than the actual code.

NONE of those functions should exist at all, imho. That
"bitmap_onto()" function is some really specialized stuff that is used
in *one* single place, where it implements *another* really
specialized helper function, and that *other* helper function also has
exactly use use.

That should have clued people in.

I really think those functions should go away, and just be folded into
mpol_relative_nodemask(), where the semantics for it can actually be
explained.

Helper functions with one single use-case shouldn't be helper
fucntions. They should be inlines in the one single file that uses
them. Trying to make up abstraction layers is not "helping", it's just
making code harder to read, and trying to convince people to use
specialized helpers just causes more cognitive load.

                   Linus
