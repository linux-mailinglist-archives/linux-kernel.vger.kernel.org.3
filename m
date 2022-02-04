Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79E4A985A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358337AbiBDLYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbiBDLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:24:13 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:24:12 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id m10so8123931oie.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yM929w1wEQXlNZVcQ6bV6VyEJB9g2bIaBGcHgzuhGw=;
        b=fGy54+B5Ng+bTI8QeE7de1B7DSxwFFuUClhTSPgotgWq2yPiIi7bLq+Ey+4OVazN52
         JeDx0C80ofdh++NBXGljV67HuDWai4fOWY4BMdYfevYogrJ3A7mw8xJBcT1us+IgTeQO
         WT/CkEgjFsjxyPdOiAsN4AWOiIGfkf1MVaDUKgB1jeGMHZC8tYMYrz6kTnpzjrZzUZyv
         vUnNz9QDi7uz1YAVlXkbm8Mrjyh7weIMCGgWILydbEco+nQ18/IeqOOkuCed4tyBhQP2
         86qC2XAI0GODtjEgMfNQYkafQM1DTh/9vK7dDiLTUiBciWF2cjn21DZ6pKfpFK3XZvTS
         kbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yM929w1wEQXlNZVcQ6bV6VyEJB9g2bIaBGcHgzuhGw=;
        b=nyzUwc9P9ZUl/vGKhPWqb2ICvrthkkHJbSDQrcsD0F0mScX1zOHnNoViuvyt3Pmifu
         vQ9hvVZ0jLFx+uck5UBx9EVqSTcvqYg8CX6N9uLrU6rcXLVNUADLwZSpS2+plOeoh/5l
         zd30hCpGfGSiYLaRpqqq/2dYoy7Y3kj7gddEYuTcEmsKAOr1E/MtPIZSv677WXZp+cag
         wHgWbHr/QTIXU5qL69GB58yNsp6/OhiHaRDAoGyFsENv/oIS09M2c5vOPzoQ0aeLTzVk
         qXbuja4WqjPfO5M2uo8FtT+WQFNsZSZMsM9lXQ9u0KiQc9uR7rRHvCedWgnPQyv43m18
         UNtw==
X-Gm-Message-State: AOAM533vzVeHIKjtKz4oFOgYPYPzQMCOiqJseNer29o/uQLNP5zpHMix
        7gOX8VAyOBP3t3dcSPkX83cCX3FMPe9qQC57FjSb7A==
X-Google-Smtp-Source: ABdhPJw/36hl5Sxle1zLhavVg6DcTs7x0tkdCt0cgZoT2ncs6iAmZKV72LaXvMiH/2LpSgjHDDTfKOfD7AMnjXoU1gI=
X-Received: by 2002:a05:6808:11cf:: with SMTP id p15mr1020494oiv.209.1643973851832;
 Fri, 04 Feb 2022 03:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20220204083015.17317-1-bp@alien8.de>
In-Reply-To: <20220204083015.17317-1-bp@alien8.de>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Feb 2022 12:24:00 +0100
Message-ID: <CANpmjNOvf7z4BdPqrJH2iF0KnZmP58uUzSH0fFoc4VNg+2S=hw@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/mce: Fix more noinstr fun
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 at 09:30, Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Hi all,
>
> here's a second small set of fixes for objtool noinstr validation issues
> in the MCE code.
>
> It goes ontop of tip:locking/core where there are some more commits
> changing generic helpers to be always inlined.
>
> As always, comments and suggestions are appreciated.
>
> Thx.
>
> Borislav Petkov (3):
>   cpumask: Add a x86-specific cpumask_clear_cpu() helper
>   x86/ptrace: Always inline v8086_mode() for instrumentation
>   x86/mce: Use arch atomic and bit helpers

I guess to solve noinstr "calling" something else the only solution is
to make the other function noinstr as well, or __always_inline.

Have you considered making some of these other functions 'noinstr' as
well? I guess __always_inline works, esp. if there's just 1 caller.
And by the looks of it you're getting a net .text reduction, so

Acked-by: Marco Elver <elver@google.com>
