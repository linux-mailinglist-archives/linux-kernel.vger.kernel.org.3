Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2448A035
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiAJTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiAJTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:32:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:32:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u21so35286167edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oy9tjlQ/BLaocnyNi1zxTSuYn4RmLGrxcg8evYZSOA8=;
        b=TRxbF/w/MdpXNE2ymtpXjd6hlkB9A8U3pgXRUx/tz50zmXH23stt63qlOIU3yT89Ud
         shFyW5NFjTLz01KQEHekGyCUs+AB4shVV/TMgJpHGznB10AH9dlbCE3h3CuzSqKR/REd
         Oqgvc8POhfkJ8L9uctZfXqgbyV69kBbfPTFVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oy9tjlQ/BLaocnyNi1zxTSuYn4RmLGrxcg8evYZSOA8=;
        b=xxyOneP+CUtAj+LVt4GUElM2eyp7rtUjt7+bNRgwHNsxT38g95Hg3ieN2BY7VL2ReX
         cdMjmGEhRozY53U3T4OS2zGMB5ehz4op7n/JJErBlbMpj+to27GuK0VouYvvWH9JMBkg
         oh/3m3ur+t3WADCKWb14CryBSGmDaDBhatCVP44k/E8lPUuiu3/WjY5FrcNZqR5NPbs7
         pwh2jPBdeHwazXebbMTmYQUy3C13gOlk02nqUps3VwSpn8LlFOGBL8zZI0b7C0Ag2RLs
         2vf7H0gP5dpTvCHnMPphwLxgtCWIo01QMGqgL8oMLuQUB7rkQyVr7u9E3R2M3UfXnPXK
         n+Vw==
X-Gm-Message-State: AOAM532ZqqWtcPDfAT4+mRar5kKkmzRuesjUEyLvea79Bhv5fNXIBeEV
        6iUh0BA5hMSp4VK4/eZ6k0uKJI0Luftx0Qy+owo=
X-Google-Smtp-Source: ABdhPJyuDB0pcqlNJkbtaTR/L82uSdDZwo9XBb1rLyy8zFFKzP/EA9DaVc9/fAW2Vd55yLbb8kj9xw==
X-Received: by 2002:a17:906:140e:: with SMTP id p14mr927781ejc.440.1641843164731;
        Mon, 10 Jan 2022 11:32:44 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id 6sm2753895ejw.0.2022.01.10.11.32.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 11:32:44 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id q8so28669379wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:32:43 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr911498wrh.97.1641843162805;
 Mon, 10 Jan 2022 11:32:42 -0800 (PST)
MIME-Version: 1.0
References: <YdwVl0H54fmUIux0@zn.tnic> <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
 <Ydx8fUCotPI++UEW@zn.tnic>
In-Reply-To: <Ydx8fUCotPI++UEW@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 11:32:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=who9Rebh4dU0NXWxroMshuf8nCX3vqhr-kk0Cen=ypOLA@mail.gmail.com>
Message-ID: <CAHk-=who9Rebh4dU0NXWxroMshuf8nCX3vqhr-kk0Cen=ypOLA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cpu for v5.17
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:35 AM Borislav Petkov <bp@suse.de> wrote:
>
> Right, the only point for doing the vendor check I see here is, well,
> because it is Intel who doesn't have CSTAR, let's check for Intel. But
> yeah, we do avoid the vendor checks if it can be helped.
>
> We can do a synthetic X86_FEATURE flag but that would be a waste. So the
> _safe thing and keep the comment sounds optimal to me.

I agree that a new feature flag for just this would seem a bit
wasteful, and just using wrmsrl_safe() would seem to be the natural
thing to do.

Particularly since that's literally what the wrmsrl's around that
thing do (ie MSR_IA32_SYSENTER_CS and friends). So that vendor check
really stands out as being the odd man out.

               Linus
