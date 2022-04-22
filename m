Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A050BD47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449771AbiDVQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449755AbiDVQns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:43:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4DD5AA63
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:40:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc2so17404989ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoGqA9rNsKJzYU/Obb8AAvf20gVKLeXNXFwl6nZ00rM=;
        b=puSEmprmz1nabSt+ml3920aGPKkUVGoZm9P1z5qEs6WOb5oaEqNdPuB+XnBF/+pdaO
         BVteA6H2VgQlmb0Vq/J/n/1XVZvrvGQjt3mVj7lbZ/55jU+YzyVz0YPnKdWjffXAa8Sz
         MZZheTPjT0XiMePlwtP5H2lntWYI8T7f3sghXXsJd3g7Ti463gREa1RRPDULw3YuULJU
         V2eu6FowolcgcwIpjbYp+q6SYrrPz3TtrfOdT2/aZwIAQaPxpVJyN7CzTxgTka8GC3Wa
         WXEDYA8EWuQGKrc2twCsC4WwQ7w8TiQWt2zr4dmLhdutg4v2XDEey0Wxj5JTGpSZAciX
         TulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoGqA9rNsKJzYU/Obb8AAvf20gVKLeXNXFwl6nZ00rM=;
        b=sd0c187MN+dePLArOis5fA/1SKiyT2CLoYY52UcULq8wJTUgteLwYYsjb0YbybxMIf
         XEZLDGjweDLZwTNlQf/XZf5CF+e7LtTahULP2hUwNw5Z9NQsJ4imXe07dfED73gD8h6W
         xW0aBhZGzobBHbK9HJ8Ys4lh6w7rhc+5jWSJqfEfd9Fd/0KMnG22iOGzJzmxHl29aVlz
         Q2cSujEcCpZpuvDR55HRyS4nuI4SAuUjBuMB2PGlKeiPz7AwTaNW/bqOzH0N1S+W6hdp
         fABU7ByZ5IzbzJE0nhrqlBaxnZpFNjQ3XJWQHa25BNvNy558ijnkAJpF4pnXWFeuVKpl
         UTag==
X-Gm-Message-State: AOAM530lj2xpWDiRm/+32/vGUiSiNy8W1SU0r72twFyuXictefs3eCBS
        gtBR0dQkPDVPmzGV/hNT6eC4pAf8oi6ILQKiFr3GIg==
X-Google-Smtp-Source: ABdhPJzoLmBU5Xg3Lxmb7MT8CNOOwTwJf10BbLeuL2aNNlpJcThtRrea/0k1l5jXVtMthl5n+035wmUrG4QqfMQQfso=
X-Received: by 2002:a17:907:60c9:b0:6f3:47fb:df26 with SMTP id
 hv9-20020a17090760c900b006f347fbdf26mr3107234ejc.159.1650645652344; Fri, 22
 Apr 2022 09:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420235228.2767816-1-tjmercier@google.com> <YmLBTBd+5RHzr9MK@kroah.com>
In-Reply-To: <YmLBTBd+5RHzr9MK@kroah.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 22 Apr 2022 09:40:41 -0700
Message-ID: <CABdmKX2X6VqK4rw90+OtSOF+aFZELefuzd=YOY3+cqiOqqYALQ@mail.gmail.com>
Subject: Re: [RFC v5 0/6] Proposal for a GPU cgroup controller
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 7:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 20, 2022 at 11:52:18PM +0000, T.J. Mercier wrote:
> > This patch series revisits the proposal for a GPU cgroup controller to
> > track and limit memory allocations by various device/allocator
> > subsystems. The patch series also contains a simple prototype to
> > illustrate how Android intends to implement DMA-BUF allocator
> > attribution using the GPU cgroup controller. The prototype does not
> > include resource limit enforcements.
> >
> > Changelog:
> > v5:
> > Rebase on top of v5.18-rc3
>
> Why is a "RFC" series on v5?  I treat "RFC" as "not ready to be merged,
> if people are interested, please look at it".  But v5 seems like you
> think this is real.
>
> confused,
>
> greg k-h

I'm sorry for the confusion. I'll change this to PATCH in future revisions.
