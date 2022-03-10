Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857B4D5223
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiCJTem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbiCJTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:34:38 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3271514D707
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:33:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h14so11202744lfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4n6+idQ0426w+zkqVp6H2ORC9fnCFio1PZzrW8WKfUg=;
        b=OqorwzMtB49Fqip4wdm9stFVvynD2x0VggX/za+LSk2+cpHubYR90RJjOnsqoXAZJS
         PKEVUeYOlX9QtjBhjnUyqb2PSsDR+wETukIDxJkkWJI/DMsjfuTMhgIY8mWPWQI2oyra
         o9JsTO9TomWo7QJKLuNr0wMP8y/j0gAZ8MvjywUAmGwereXi3I5q/gwobTMAtCKGo3oi
         vt/8ah4AtRtGVIPPYFZ4mhGu4YhvT3BEEVZTIY2Bk+dPnS0QYjByJLaLoXqCs3CRn8kZ
         L0EpsvYejfkgMhc+/apIKBKxCkq9x+U6bH72wsz5pbyzAid1oMjnyYZpZwTlBQCy59QM
         HvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4n6+idQ0426w+zkqVp6H2ORC9fnCFio1PZzrW8WKfUg=;
        b=8KhynQ387iXZCx87xEhBIEAAebaKbAh/dfBSqCXGh3B5BO8kC8hkfWjd6mVZj/zlmp
         5R+gBmCpJ9B46pzQlgPTT25gtsmsHqujCdT7lRSNbyitDt98m/1UNvNSmqyQQAmEBucG
         uiZJo4OTWPxAEuhWCilHDUBy5TYePGdhA7pIWXY9Q6kEo041aHmaJcWschKkJetYuqtQ
         i0zS4WVEI+gagJzBEOh9ECVviu+vMJ7kML2kOLmBRDgqdFesa8uygP6vSqNQ7TUC20Vm
         hCBLFGvWChh8E0vzqIs0xjF+yHFVDHz3QEF5TmvkAlzdoRBe2F6SMzi2iS+9fE3n6lAs
         OYMg==
X-Gm-Message-State: AOAM533mlyNM7njCLwLvc0GQpgEQuWZPW7XKCRaDMCpbRpohve0WlYaY
        IUFVAuUsR/L2YiEsKl3viDhFrBZFIS7qDuKHgeNcRg==
X-Google-Smtp-Source: ABdhPJwMmlW87gYnDG08JkAcAdSJk0r0l+PhyvspUkMuuh2orjECrIymDRz2y9i5JbalSY67z7Cseau7s6pXnUeek3s=
X-Received: by 2002:a05:6512:5d2:b0:448:2e88:e9bd with SMTP id
 o18-20020a05651205d200b004482e88e9bdmr4058133lfo.424.1646940811350; Thu, 10
 Mar 2022 11:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com> <20220309165222.2843651-8-tjmercier@google.com>
In-Reply-To: <20220309165222.2843651-8-tjmercier@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 10 Mar 2022 11:33:20 -0800
Message-ID: <CAHRSSEy5_h9LJB4q5_OJA7fSq=ROo68UaK+hdPz-Vj-wac1Qhg@mail.gmail.com>
Subject: Re: [RFC v3 7/8] binder: use __kernel_pid_t and __kernel_uid_t for userspace
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, kaleshsingh@google.com,
        Kenny.Ho@amd.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
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

On Wed, Mar 9, 2022 at 8:52 AM T.J. Mercier <tjmercier@google.com> wrote:
>
> The kernel interface should use types that the kernel defines instead of
> pid_t and uid_t, whose definiton is owned by libc. This fixes the header
> so that it can be included without first including sys/types.h.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  include/uapi/linux/android/binder.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index 169fd5069a1a..aa28454dbca3 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -289,8 +289,8 @@ struct binder_transaction_data {
>
>         /* General information about the transaction. */
>         __u32           flags;
> -       pid_t           sender_pid;
> -       uid_t           sender_euid;
> +       __kernel_pid_t  sender_pid;
> +       __kernel_uid_t  sender_euid;

Are we guaranteed that this does not affect the UAPI at all? Userspace
code using this definition will have to run with kernels using the old
definition and visa-versa.

>         binder_size_t   data_size;      /* number of bytes of data */
>         binder_size_t   offsets_size;   /* number of bytes of offsets */
>
> --
> 2.35.1.616.g0bdcbb4464-goog
>
