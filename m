Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262BB49F478
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbiA1Hjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346893AbiA1Hjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:39:32 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9E6C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:39:31 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ah7so13135110ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEcWsKqE5uYcNoVNkHmdsauLrUNyJ5ygZ3/BoJdf+E4=;
        b=Y40QCpfOeH6Aopx4c8hAvMEdk/M0A8zJpVVLmEsHKftkXSlelUuP1OWByO4mwfVtSN
         1hq/hh1gr/oeldhwCHxyuizYrRiu4msKg6qzqIgT7xtQKfjWgFO9AK9R5vYACW7xcXJq
         lsNEEBfaLWcp1No1QVnd1H9XOjW0/KgzoO6ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEcWsKqE5uYcNoVNkHmdsauLrUNyJ5ygZ3/BoJdf+E4=;
        b=rxkMlW0u0GPLo4SdviZJUqoF7Eed4kl5UXrHhnObeSq2hvgewoe1RlouiTAE2YQNSy
         VbtF+RYercD1stJPdzMadYAPXQGhKMCbY/2qoKXnsg+P6Zh6d4ybjRU7jDJyhNzrbwHJ
         GlzN9nNSkFxhj9wWczmvOFyhSY9tmgJtz1ClTFCpaS4k4Nm/A6rMyWNdr5TRr4fgdi8i
         fbOCT4Bs2IhHfIgZo1uRgUxaS3W0yNmYH1vupcHsip8XOyRLoLFq8hWUiVg5Lbgp7B4k
         73JzdmbV7auPfXZWEgGfT9bgQB65gN0j4JfHL2Nujj55h8V4d6B28KjB3/y4dzKwBstE
         INkA==
X-Gm-Message-State: AOAM532dBZp/QN8yX4M+hAi+0Nxu09LZBZbWn4wok+llQAcqMZ4YEVlA
        VsLc8jy+7k+L+7beCzCxBjUGqZDAEk6eYMQq
X-Google-Smtp-Source: ABdhPJzHLkkb6LdExapyBeqllqVlobpeBV4/Cj/kbHCFEa4Db7W5IpDkEnBi4lV5gwg8qrH8/oWjRA==
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr5839750ejc.493.1643355570341;
        Thu, 27 Jan 2022 23:39:30 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id fn3sm9574884ejc.47.2022.01.27.23.39.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 23:39:29 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so4925957wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:39:28 -0800 (PST)
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr14480558wmq.155.1643355568648;
 Thu, 27 Jan 2022 23:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20220127233953.2185045-1-ipylypiv@google.com>
In-Reply-To: <20220127233953.2185045-1-ipylypiv@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jan 2022 09:39:12 +0200
X-Gmail-Original-Message-ID: <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
Message-ID: <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on module
 init iff async is used"
To:     Igor Pylypiv <ipylypiv@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 1:40 AM Igor Pylypiv <ipylypiv@google.com> wrote:
>
> This reverts commit 774a1221e862b343388347bac9b318767336b20b.

Whee. That's from early 2013, more than 9 years ago.

> This works when modprobe thread is calling async_schedule(), but it
> does not work if module dispatches init code to a worker thread which
> then calls async_schedule().

Hmm.

You make a good argument:

> Commit 21c3c5d28007 ("block: don't request module during elevator init")
> fixed the deadlock issue which the reverted commit 774a1221e862 ("module,
> async: async_synchronize_full() on module init iff async is used") tried
> to fix.
>
> Since commit 0fdff3ec6d87 ("async, kmod: warn on synchronous
> request_module() from async workers") synchronous module loading
> from async is not allowed.

This does seem to imply that limiting it to PF_USED_ASYNC is largely
pointless, at least for the originally stated reason of deadlocks with
other module loading.

However, we've done this for *so* long that I wonder if there might be
situations that have ended up depending on the lack of synchronization
for pure performance reasons.

If *this* module loading process started the async work, then we'd
wait for it, but what if there's other async work that was started by
others? This revert would now make us wait for that async work too,
and that might be a big deal slowing things down at boot time.

Looking at it, this is all under the 'module_mutex', so I guess we are
already single-threaded at least wrt loading other modules, so the
amount of unrelated async work going on is presumably fairly low and
that isn't an issue.

Anyway, I think this patch is the right thing to do, but just the fact
that we've avoided that async wait for so long makes me a bit nervous
about fallout from the revert.

Comments? Maybe this is a "just apply it, see if somebody screams" situation?

                   Linus
