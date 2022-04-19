Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8B507965
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354045AbiDSSvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiDSSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:51:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45167369E9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:48:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so30988520lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQbAaRe8NJnlCt5Bb8Ku9ZbJ6FQr9jKFCTgPm8QEEpw=;
        b=p2SDYUiDCVg+YHTaDRHg6yt0L0mH9Q4Ew+t/CctKSjkIirUgbOSGrblEoF9SX3UKxQ
         cjtgprX6J4Gmn80P8eLC9I5FMRf/ZT+hTDr6hnBNarjqeS40gVqv1ephG77XgJ1VJAcc
         xmZWBglThm/m4eQHKWzC8kltvM1LkMTHhMoZnaTDo83QKWfWSX4THjPmXAsLm95M9+MZ
         TDcwwhh7D4oR6J3wtmvDO+l+lxV+HiMYBdFJj4mnDC+LmAqaNsZ/9vYglybAYfVgxtqo
         b/Tq9BjRhXIHwzwMMXmLOkvQ+JPurGQ2Rdo4IczlOzfg+5XqlL+p3qEvoMSH4n7dIiXb
         SbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQbAaRe8NJnlCt5Bb8Ku9ZbJ6FQr9jKFCTgPm8QEEpw=;
        b=nQ7MiM2bDKaaPn9Totiwql9+Z1FwceDFwO13sUt7qhsUslY9fXU8Tz4WQsom/MaY6K
         tSmLCiFy2dcNSh8bbaFTGeb80Ds0A1GUC6Z9hcVEV3CoG6KLUSPBiqUBv+IzsgVewmfi
         kfY5w30sQUIKINVPPxKliJUG4Rd8RZ9+9cv6CGluyjGr4w4vBjJXv3KZZ8QNN4kSbG2l
         7ss74y7IPxjZH7M4RfViXej4gq4E8IbnStn1h8gde4z5L0m34zIx4l6z5lS9IjRKgmsD
         bv5REom6Ocut0d3y7AmfG/dxKNspqBFvp1tlc2Jp9dBLUyihcoa/ZQl4JwBNqjzM2kyR
         BPBg==
X-Gm-Message-State: AOAM531uTow1gdiReivXoYx7rcEazxjPcdgSF/hWK3n8ZyFo7eyyGGhK
        924xdRNElWEiZy3hRVND4UmzVJXLI8DIIddiDdyitw==
X-Google-Smtp-Source: ABdhPJyF7GVftAwAoV0/oyTXzOlyzS+DhBBQm8So3RspaaiyMXXfm4uz1CXENxB7rGah6vzrAtGd46+qbT848qJ9eTE=
X-Received: by 2002:a05:6512:3fa1:b0:44a:f351:5a00 with SMTP id
 x33-20020a0565123fa100b0044af3515a00mr11632046lfa.19.1650394106356; Tue, 19
 Apr 2022 11:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220415120015.52684-1-ales.astone@gmail.com>
In-Reply-To: <20220415120015.52684-1-ales.astone@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Apr 2022 11:48:14 -0700
Message-ID: <CAHRSSEyK+-FFCOSNvohuTVyWo4fncsPMoC5xtthpr2ooY45MpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] binder: Gracefully handle BINDER_TYPE_FDA objects
 with num_fds=0
To:     Alessandro Astone <ales.astone@gmail.com>
Cc:     tkjos@android.com, gregkh@linuxfoundation.org, brauner@kernel.org,
        arve@android.com, linux-kernel@vger.kernel.org, maco@android.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 5:00 AM Alessandro Astone <ales.astone@gmail.com> wrote:
>
> Some android userspace is sending BINDER_TYPE_FDA objects with
> num_fds=0. Like the previous patch, this is reproducible when
> playing a video.
>
> Before commit 09184ae9b575 BINDER_TYPE_FDA objects with num_fds=0
> were 'correctly handled', as in no fixup was performed.
>
> After commit 09184ae9b575 we aggregate fixup and skip regions in
> binder_ptr_fixup structs and distinguish between the two by using
> the skip_size field: if it's 0, then it's a fixup, otherwise skip.
> When processing BINDER_TYPE_FDA objects with num_fds=0 we add a
> skip region of skip_size=0, and this causes issues because now
> binder_do_deferred_txn_copies will think this was a fixup region.
>
> To address that, return early from binder_translate_fd_array to
> avoid adding an empty skip region.
>
> Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
> Signed-off-by: Alessandro Astone <ales.astone@gmail.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 31176edb1069..f3b639e89dd8 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2491,6 +2491,9 @@ static int binder_translate_fd_array(struct list_head *pf_head,
>         struct binder_proc *proc = thread->proc;
>         int ret;
>
> +       if (fda->num_fds == 0)
> +               return 0;
> +
>         fd_buf_size = sizeof(u32) * fda->num_fds;
>         if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
>                 binder_user_error("%d:%d got transaction with invalid number of fds (%lld)\n",
> --
> 2.35.1
>
