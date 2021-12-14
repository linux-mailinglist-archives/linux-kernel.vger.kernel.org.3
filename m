Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECF4741B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhLNLnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhLNLnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:43:08 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A04C061748
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 03:43:07 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso20588908otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 03:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kzNagy7hBzCdCfqV03aZwUrfDgDRjqikfmgdS8jC3s=;
        b=hWJ+21QigemGZlYwQCkAuxCnUZwlsG1U4Fs+zLa+fsjCvMUg7C+cKkLdsGzVU/dS8Y
         UStK/AbEtUkAzf5x3SSZR7+xrwIf51reDc5yNsOKTXT6F9SP5ymCZ8MFBnQ04fPGOYXC
         AAMAn1OOOP+TMhwuQgwGWuc1nKyE12F8Bwmnlm3I+7yBLCiAIW2ZuggYYpMJkuRyIKrU
         Gs80XproGlUXhxva1eU11BxZhDUaQ1TqSBDyd0nc/LYvm5cSOW1i6BGt2IyBlPxYcAan
         xw8hDxll9z/bDfQO+MSgSQThYcnTU9CxVFzAIUvVmp/pWJbR/EYBZGhW4SSYwL+9N8OD
         J5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kzNagy7hBzCdCfqV03aZwUrfDgDRjqikfmgdS8jC3s=;
        b=2hHNungwrCwUOXCSKL3VYvTus9ZZXL6H7XE96skKPtQZlpkk9GZzJYmILBys7C079J
         Fx4I7ebhcbmbUUZJ710IzFq9XcrrziZwPsm6qVdX3/m7aBJIe2pJLmS3yqVRvyzqU+Kp
         b9BGL6pqmjcbyCHPJkR4wbiWcDCq28fJWsdwVr6jgojJpUlcfXSSv2laRYIH+Weqvy7t
         F9J358ZlehN78hO2T+R5F/hWFRJdGNvb1rJ2GmZrJdUvOqEEzyraDtqz3quod9KS7ZSJ
         ao1+tM25K3pmIUKvn9oe1cVj8IWws1FTx6Zswixof8N1wlEirYKhvJ99/fqZcmLBn52f
         lRWQ==
X-Gm-Message-State: AOAM532K5rWucaQGv+cqoJ25xt/Nn6g22lSTbmvwllHBKeek0qtCj2pH
        J/x68Nz7HyZ0fA7XTkLpkM92fwVwpe/MTxVtkCAmFA==
X-Google-Smtp-Source: ABdhPJxDzahE/es0w4xiffD0dHBpBKdidpJTy5helH9TNnFDhjsyxCvYphAn4pXj2eZ8pB0X1pMHAfWCN28nnT0XIpE=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr3799973ots.319.1639482187006;
 Tue, 14 Dec 2021 03:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20211214094526.2442154-1-dvyukov@google.com> <4ad30f21-9955-a72c-d7f0-912de6c205be@i-love.sakura.ne.jp>
In-Reply-To: <4ad30f21-9955-a72c-d7f0-912de6c205be@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Dec 2021 12:42:55 +0100
Message-ID: <CACT4Y+Z63jk9cFgkcKeU0HN6ES_CBhrotY0Zabae17R-gqG6SA@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: Check exceeded quota early in tomoyo_domain_quota_is_ok().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     takedakn@nttdata.co.jp, jmorris@namei.org, serge@hallyn.com,
        nogikh@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 at 12:36, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/12/14 18:45, Dmitry Vyukov wrote:
> > If tomoyo is used in a testing/fuzzing environment in learning mode,
> > for lots of domains the quota will be exceeded and stay exceeded
> > for prolonged periods of time. In such cases it's pointless (and slow)
> > to walk the whole acl list again and again just to rediscover that
> > the quota is exceeded. We already have the TOMOYO_DIF_QUOTA_WARNED flag
> > that notes the overflow condition. Check it early to avoid the slowdown.
>
> Thank you.
>
> This patch will make a slight but user visible change.
>
> When tomoyo_profile(domain->ns, domain->profile)->pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] is
> increased (or domain->profile switches to a different profile which has larger
> pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value) after domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true
> is called, tomoyo_domain_quota_is_ok() will continue returning "false", and ACLs are no longer
> appended.
>
> Therefore, administrator will have to manually do domain->flags[TOMOYO_DIF_QUOTA_WARNED] = false
> after increasing pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile).
>
> But since the message
>
>   WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.
>
> is a hint that tells administrator that "you will surely fail to try the enforcing mode on this
> domain because the kernel has failed to automatically append at least one ACL to this domain",
> administrator would have to retry the learning mode after increasing
> pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile) even without this patch.
>
> Therefore, asking administrator to also clear domain->flags[TOMOYO_DIF_QUOTA_WARNED] after
> increasing pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile) would be
> tolerable...

Should we reset flags[TOMOYO_DIF_QUOTA_WARNED] on any writes that
change TOMOYO_PREF_MAX_LEARNING_ENTRY?

If I am increasing TOMOYO_PREF_MAX_LEARNING_ENTRY because I observed
the warning, it's useful for me to receive the warning again.
