Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0BC4825A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 20:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhLaT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 14:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhLaT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:27:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF644C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:27:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j21so111457339edt.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YU06RrU6q8sQBZyTzdprAi1+FG3h7shQoFSUPOjUgj8=;
        b=WUx8Mhhd4JwVQESuI9u7ibjcwyDeZgExAuH1BIuRaOVdHGHErUrYtd8S4F7h9peeqh
         8OvDto1JXS/Ie82GmFUdJQWquyftRBj+vshMMwgA2gwN1hOjJnuPUG5fhS0XeSdHGSHu
         vQalMh1yNNmYCULVdEgZQLxGfTbmoE08YWuvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YU06RrU6q8sQBZyTzdprAi1+FG3h7shQoFSUPOjUgj8=;
        b=QOrZZT+zNmTxTlpwXVdgPVPgIwNN04JFYdtVjGOoEXVPQhNg9BUVsNz9WWiG2AXv+9
         l3gWnVjbTqiEGbUMpArLbijt05BTomsoFZMxJ/hscDQ/do1cCac+dadkkt21PmYhSXW/
         R//tY6T21cu0oDRxWSqW0vDK/oXvKG+y4UY/8Lrx/4axQcaVWXGZANaOY4hgTYUj1HUm
         bi86XbChDdkyc/EpfLwGW12+pq6NE63Kv5PSGdf5Fk/i9nMlsqpzUbPAgWlEZpItCEpl
         Fo1yvkhVkAuknffIxYiQ0vaJbxOQXRpSDG727dvaScI8pk0NZeU1kvRZ/1fUQjqL2XQg
         nYaQ==
X-Gm-Message-State: AOAM531mliM6nz4Aiol8374ie67bEUlU9cMaIOwpXLoGSFBPpyBSFyed
        pTfkfxwjChfG4zLk6U1GAtkh1F+2JCaRtgBiRJQ=
X-Google-Smtp-Source: ABdhPJxO3Aj0k3yURMtk6SfnOH7rwm7V/vFRXzBvkmIRliyquKzbOWZ6dUm+Cwl70GgAeanhjBR9qA==
X-Received: by 2002:aa7:c1c1:: with SMTP id d1mr32665937edp.416.1640978831156;
        Fri, 31 Dec 2021 11:27:11 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id h10sm8549271ejx.115.2021.12.31.11.27.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 11:27:10 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id w16so111632765edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:27:10 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr30389617wru.97.1640978490358;
 Fri, 31 Dec 2021 11:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info> <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
 <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info> <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
In-Reply-To: <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Dec 2021 11:21:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
Message-ID: <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 11:14 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 31, 2021 at 6:24 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > If we get it into rc8 (which is still possible, even if a bit hard due
> > to the new year festivities), it will get at least one week of testing.
>
> I took it with Hugh's ack from his reply to this, so it should be in rc8.

Pushed out as 1b4e3f26f9f7 ("mm: vmscan: Reduce throttling due to a
failure to make progress")

             Linus
