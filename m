Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E204A8C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiBCTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiBCTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:33:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E852C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:33:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id me13so11904645ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKKVvcG+cC8bIALBnZZmaV3K37giZ1xa1O6hFf3r9uc=;
        b=Jkx2j0PYyKcGzbdzVprIgIK3c9UJTJU023+j8kMn6bFfwe79YvJheTw9qL5ryIRa80
         Lh9b7BpjrwhgQhd2J7+B1U+ZMFnZoZUWM9Ajp0Ad4vzpkBa6lrGGNVz1nkoLZyKgapv5
         0hx1nJz7ou0M7Q+16jCAsq70x2y43qYOvrTMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKKVvcG+cC8bIALBnZZmaV3K37giZ1xa1O6hFf3r9uc=;
        b=clKj+N+rwbPXeNTJdvyINyUkIs8uwXxYAfKaKb+bnj33VmcPMwbISsff6JM2/ejsl5
         dyo15XnStYQl1irki7k2zGBAKlR1jBbO0DUdto1uqE8PUyESqT/pDGaqdiBMQHz3ckG6
         InX9vpLZSmrjdJ5/5tM/uuoUIk1Qn1ehoe4u7OFHoIkWriHOOHb/lmAzr54sesqTD5hz
         hPsp+9PutQEkubFJDNAcEzsIVCshWAvFLDxOxfRXUJdZVNFRNvX1gR4jpnr7WGXZZs6C
         Wn5qukID0NWGb57Wp1Yx+b4XbrTRqovEMF0iJRltMIIRVh28ZREIm6yOzWqVDpwUGDU+
         PgoQ==
X-Gm-Message-State: AOAM532NhhdrguRU3qcwPRYtk4LRs5KCkeQjQ0ccF+D8KDPxA4pn/wBI
        fLOKHKRmawlr8tyI/+0yeyKcp1xrMB9yNe01
X-Google-Smtp-Source: ABdhPJyDivUXhhHPafXa3StNHYFdEHquccUbwYeFHJHMHockwJuDupRnuFroVwn1EYkHpThukJEs/w==
X-Received: by 2002:a17:907:d8a:: with SMTP id go10mr31569505ejc.242.1643916816685;
        Thu, 03 Feb 2022 11:33:36 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id cr8sm22490965edb.47.2022.02.03.11.33.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:33:36 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id a13so7002871wrh.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:33:35 -0800 (PST)
X-Received: by 2002:adf:d087:: with SMTP id y7mr29738280wrh.274.1643916815565;
 Thu, 03 Feb 2022 11:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20220202001918.4104428-1-keescook@chromium.org>
In-Reply-To: <20220202001918.4104428-1-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Feb 2022 11:33:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkwveB2HDOibk+chAWhpm8LyGBVVjZmV4CAeEdnezZ0w@mail.gmail.com>
Message-ID: <CAHk-=whkwveB2HDOibk+chAWhpm8LyGBVVjZmV4CAeEdnezZ0w@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was going to apply your patch, but then I read your note:

On Tue, Feb 1, 2022 at 4:19 PM Kees Cook <keescook@chromium.org> wrote:
>
> Is it correct to exclude .noinstr.text here? That means any functions called in
> there will have their stack utilization untracked. This doesn't seem right to me,
> though. Shouldn't stackleak_track_stack() just be marked noinstr instead?

... and yes, it seems like stackleak_track_stack() should just be
'noinstr' just like you made stackleak_erase().

So I've dropped the patch to see what happens.

If you decide this is the right patch after all, you can just re-send it.

                 Linus
