Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EBD475986
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbhLONR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhLONRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:17:53 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD97C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:17:53 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so5917381ooe.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au62n4m8uRCaSs4+vVgR5PSbqPQx8MPEQSlKHv3tUvo=;
        b=aj3Sj5liapebe6SJRITNXLiI4KThaaqInZzt1i7hIMcEYfQBChC3pmnPuyo/QhSqGd
         w+qBZtYaSwZXwS3iv2DNaZBZXcu/KXH2LkO1SDZs3EPHQpQuyaDT7dMkqVp/ZSGBugLU
         hQLFsviUCObiQTbgbt00h0krz180Dl/L0DDUQkJz975590I9K3aYpjCnFaCuKB1VD4yP
         fv+5FM6+bpIo1c+c0X9F7i0ttHfPQCnE5Nsm/oLT37XcCBOVqpfPGg6TtaNe6ugIGVWa
         XeqpPhcMqc+W76crBy6NMiel0a2RDjhiHty4L8YVDo+/gbcwBfUjrm9iSuNDYHRaMJFm
         p6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au62n4m8uRCaSs4+vVgR5PSbqPQx8MPEQSlKHv3tUvo=;
        b=Byc3hJg20Ot5KSm7NYfx++LUvkj8UgrOf3f+eD+mNAeUiICf7d/IKwIeZ6hL9FXqxo
         oXZxGBIxFcLTAezKH436Zzpw3INt65HcDzhnojFQoYrryU/4/Wa9VyqTgELbreNFUKjA
         MZdEURKfsggk+kcPF0bRTOqAGF42JSUaNiHIVTZ5y5FqA93N271reyasQ74+g/WlY3pv
         AaC9AGksHu1Cp1bYhvPq0jQBh8y7brdwVI8GKiWyjZ/MqytmO8X5ryzGsbffmherv+od
         pX+az+5EKQ0sPzPDHRRVtbO94BGSnYQK3Bu0i/svfxHsKgKU9qGwj53U+d4LyWLF/YK8
         2JBQ==
X-Gm-Message-State: AOAM5320MT4925RNpciEUR5pnEV1QHeP0yKbVxlW9xoDlPkB7lF7oeY3
        HTOClQCw6/x395pcLxRqMBaVM0I1u3i03wmOKVSP7A==
X-Google-Smtp-Source: ABdhPJyKiNrM46sQnQOVNCpuufZLZX8vH6amPXzMUo6ihOAnqKOaK6XOQiIg+OSbQaN3W3LYcklzBmCcOWCR2/ChcDg=
X-Received: by 2002:a4a:96f1:: with SMTP id t46mr7147958ooi.53.1639574272532;
 Wed, 15 Dec 2021 05:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20211214094526.2442154-1-dvyukov@google.com> <4ad30f21-9955-a72c-d7f0-912de6c205be@i-love.sakura.ne.jp>
 <CACT4Y+Z63jk9cFgkcKeU0HN6ES_CBhrotY0Zabae17R-gqG6SA@mail.gmail.com> <8da31317-9306-70d0-2bf7-382ed157bc5c@i-love.sakura.ne.jp>
In-Reply-To: <8da31317-9306-70d0-2bf7-382ed157bc5c@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Dec 2021 14:17:41 +0100
Message-ID: <CACT4Y+ZyXhm39R-HBgcsLawQCtDsE5YRppxADjBG7NwkEwgn4A@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: Check exceeded quota early in tomoyo_domain_quota_is_ok().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     takedakn@nttdata.co.jp, jmorris@namei.org, serge@hallyn.com,
        nogikh@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 12:46, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/12/14 20:42, Dmitry Vyukov wrote:
> >> Therefore, asking administrator to also clear domain->flags[TOMOYO_DIF_QUOTA_WARNED] after
> >> increasing pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile) would be
> >> tolerable...
> >
> > Should we reset flags[TOMOYO_DIF_QUOTA_WARNED] on any writes that
> > change TOMOYO_PREF_MAX_LEARNING_ENTRY?
> >
> > If I am increasing TOMOYO_PREF_MAX_LEARNING_ENTRY because I observed
> > the warning, it's useful for me to receive the warning again.
>
> I decided not to reset flags[TOMOYO_DIF_QUOTA_WARNED] automatically, and
> applied your proposal as-is. Thank you.
>
> https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits/04e57a2d952bbd34bc45744e72be3eecdc344294

Thanks!

It will appear in v5.17, right?
