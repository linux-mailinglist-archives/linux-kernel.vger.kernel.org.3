Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18A858A0E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiHDSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiHDSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:52:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648015A0A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:52:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m4so930310ejr.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=d9A+1UrQLh0WcW9MhwNlbIKjJoOc9nVaeZ+f3kn5XJg=;
        b=Wghr6irArPcwVSc+CNnhrrsEu9dnr4MgYqspEvpRuXFzsOtqFWg2OW0RZw0DsbJhbG
         7KYJuxI+hGsaf1e3eCH86NhWL3mKYHLchNkwelwizVdbqx2TCHmSyTmd7/UiTNDRDtqj
         1bkDxMnc43SYw+VE+NmTMF0O+9AkEy2ziVWdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=d9A+1UrQLh0WcW9MhwNlbIKjJoOc9nVaeZ+f3kn5XJg=;
        b=CXEjwFaHGJnx1AnDmbdlXZUqj7eLSNUlng1b1njWq6Xazc0qE60xHb//B3fCx5/VZg
         VWZwHfaEvUJGzEtVRz5FPmnh964QDcLCQnrwolwBfkBNCh+2sNRukDGtEqYDUI9Z/Ew6
         xGdpoTm8yTb51GenSe24Zqzl43WnbxIGJRGyN/iV4Xvfmm0ZJF9y5p2lWmGBiHhcHyKe
         WL8r5qX4MmV1KUC1zmTe03ezUH9ArGYDOyM2wmD92RxVbo07IAw0V41y5QaUswO4aDRA
         nAHR6nEF5d1TqK4TT12o5qygJH6bKCbjRPboQMG8gbnczc0pAXQSa5xIg7ujDgwtq6mM
         2ukA==
X-Gm-Message-State: ACgBeo1HMwMKKMYKzbO/QxJXNq5OZaTtU13/BfvWwjHTgygsUnXQqoh5
        PFPyv3s/Pe5fxipnV+72v6UfmGRmAko10v4D
X-Google-Smtp-Source: AA6agR6EINyJukn2W2sH/R57jRmbwGxpwtX0pZarH5B2/x6XuDsubXCre7w7b5AWlgK9eozBlVupqw==
X-Received: by 2002:a17:907:da0:b0:730:d0ba:7b13 with SMTP id go32-20020a1709070da000b00730d0ba7b13mr2545120ejc.332.1659639146153;
        Thu, 04 Aug 2022 11:52:26 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id o19-20020a1709061d5300b0072af4af2f46sm637058ejh.74.2022.08.04.11.52.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 11:52:25 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id l22so785338wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:52:25 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr2265646wro.274.1659639145076; Thu, 04
 Aug 2022 11:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian>
In-Reply-To: <YuwRyQYPCb1FD+mr@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 11:52:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
Message-ID: <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 11:37 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> git bisect points to 3876a8b5e241 ("drm/amd/display: Enable building new display engine with KCOV enabled").

Ahh. So that was presumably why it was disabled before - because it
presumably does disgusting things that make KCOV generate even bigger
stack frames than it already has.

Those functions do seem to have fairly big stack footprints already (I
didn't try to look into why, I assume it's partly due to aggressive
inlining, and probably some automatic structures on stack). But gcc
doesn't seem to make it all that much worse with KCOV (and my clang
build doesn't enable KCOV).

So it's presumably some KCOV-vs-clang thing. Nathan?

              Linus
