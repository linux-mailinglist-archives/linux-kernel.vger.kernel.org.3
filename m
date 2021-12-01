Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4777464F89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349877AbhLAOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349876AbhLAOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:24:55 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE42C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:21:33 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id w22so31067016ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhRYkoevfD+4hPXuZNIpIu+nd0rhuouvnSdRBqeiQA4=;
        b=ehjMOqjvj6xAgicMM6rFgDeBqsmnuqZTCoyalS9Vc5lrDCbCVG4wS1WtMD5HoorLjG
         U9ozjG8yr7PHbPS1AHMYrxvXm3JmLD6QP7pREkK221I+nNzkpy6C+7YQtwzRWMkj/hST
         giBT3x7ZyyslGQHXtz26wah5LiZPZYw5cFUxjTiie/S7n0J+qWWl8l6B0gslc5HLv4wo
         bLFzqzzZ1w42Fz3ioNg+e/IYVOv8scviXUbLYAoDY86jonW9gWwiD5M0CTDddpFM28VQ
         /uzsPl6ELoy6cv4Hes4OaC0EwC0NvDk5dakyF2Vaq0lBpnGm5xIuIOmrQFL0qP8rH0Pc
         5P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhRYkoevfD+4hPXuZNIpIu+nd0rhuouvnSdRBqeiQA4=;
        b=mQ66iRR6lBAk/lj5NdxlkpxBUW3Z+Mg5xQXnGVoI/vE7Kb6iSr0dxJ2MXPjzf7r3mK
         129suiirKYwzBAS+4FFS+z8h9lgr+k3PB/ektnmcjwxqCUEp5C0oeglT5xl5BsfCqi4H
         PVBqLm5tGxcjMwD9QjoOhFBxpx/vdW/maXasxyO3L+pDMz3ZuALNz4sAVGM/Qlx/UXR4
         WA3MENtTYeEH/SW6pjptvsUMPfyXeg4FA6iQU6py+dI9kyAdaqmh8CzswATjY9LSAjuh
         y0xQNg2O0H/2fcyHOZ1Ts7iDR3GmLxUHp2kdgxHzplZM8UjhKnYuKHs0x8H4+xaUmtSd
         WxOQ==
X-Gm-Message-State: AOAM532TqvidUSQK9hoKTQo3e+N4sTSFjvrn9wT1f92doot+ohIgjq0X
        xwiTwN2f+9gAiVoKmX2IlwFjzTVUdTOxJhs8W2hjfmQ=
X-Google-Smtp-Source: ABdhPJzW7SiFniS9U/Wocvbg0ME+P1C4wO8yqUBI+PnNU5jfCno2ZK7XvLYjRIVgzW3f5aapHnc3ryzUqQ3dBUOmxm8=
X-Received: by 2002:a05:6638:2257:: with SMTP id m23mr10312797jas.17.1638368491421;
 Wed, 01 Dec 2021 06:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20211130205549.116673-1-brgerst@gmail.com> <20211130205549.116673-3-brgerst@gmail.com>
 <2c23335e98bc4a66b1fd779a78ddd821@AcuMS.aculab.com>
In-Reply-To: <2c23335e98bc4a66b1fd779a78ddd821@AcuMS.aculab.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 1 Dec 2021 09:21:19 -0500
Message-ID: <CAMzpN2hz=N5he_t2F0ns_TJ51QQdSc6Pq02pq6JW5PSYR-2zRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] x86-64: Convert stack protector to normal percpu variable
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 4:50 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Brian Gerst
> > Sent: 30 November 2021 20:56
> >
> > Older versions of GCC fixed the location of the stack protector canary
> > at %gs:40.  This constraint forced the percpu section to be linked at
> > virtual address 0 so that the canary could be the first data object in
> > the percpu section.  Supporting the zero-based percpu section requires
> > additional code to handle relocations for RIP-relative references to
> > percpu data, extra complexity to kallsyms, and workarounds for linker
> > bugs due to the use of absolute symbols.
> >
> > Since version 8.1, GCC has options to configure the location of the
> > canary value.  This allows the canary to be turned into a normal
> > percpu variable and removes the constraint that the percpu section
> > be zero-based.
>
> I didn't think the minimum gcc version has been raised as far as 8.1?

The first version of this patchset retained compatibility with older
compilers, but there were objections to the increased code size to
support both versions.  x86-32 already dropped support for stack
protector on older compilers, so v2 of this patchset does the same.
The benefit of removing the fixed location version is all of the
supporting code that can be removed when the stack protector becomes a
standard percpu variable.

--
Brian Gerst
