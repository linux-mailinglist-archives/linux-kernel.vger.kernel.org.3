Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40774E7B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiCYWal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiCYWaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:30:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E8197
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:29:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bx5so8751937pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HiTDgMnXLNm+wa6aVm1WbatEUs7lymZcW/6uyKoS38g=;
        b=LZmmCOYQ3Cj3SABlu/kZ6RaqovKgmOzax+yNsn6pqzI4fYsxULdbv4n0bqoHanfJNV
         O3bCCDDYfltWu0OQnPSF4dZichdNB+PTktF0x7j/DOYpt+brOhgLKJuPGw8hQ9ti/M7p
         sIk4Jts2/QFmmrBObNMZPnS8+ta68zBHv5yd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HiTDgMnXLNm+wa6aVm1WbatEUs7lymZcW/6uyKoS38g=;
        b=ekrnKhuQ6RGSk2g3N6Ko+dO26bO2dkXSk79/EoW51fNmuJNvegfofw2ukMH/P4bXvL
         aTf9LIzLIUHpTq4SYIkDFnO9+TSfArkHGKFzrRXSq5Fn9LpDx3aMJWhKWiKrVUlL6ayx
         cq+ecRqnxba6SOSrqAQEMvaGAD3wnlAyVJzbxtdc5EeeWyEhuLPRqso2qU+sEfNJ9iif
         puZr9SvoyvGqlbFnB5gd9G/3VV021qHk7dLhwXbeBdvGFfOrCwTUINo3Y7lqICMOs9N0
         7AX7WBkmk9voCzyzYFXR4yGk8jtA8ynh8gBfFdQtj2C9zpraPDeGWqnVLixb6ZKj8Sfv
         /Bmg==
X-Gm-Message-State: AOAM530cMygDM5i9kubiFu3b99XEwmWOkZtGgHV8T6GOH3kVej1Jqnm5
        3sXiiegbFNnPb0IyURDfR35GSamhCSUkYg==
X-Google-Smtp-Source: ABdhPJyvPb+7hYespPatUYa7oqa4mkQ+ksPB+KW80CHaPKDl4fqCgd4Qmwy2USSOyTce1jqwIU3VEw==
X-Received: by 2002:a17:902:d5c3:b0:154:c472:de80 with SMTP id g3-20020a170902d5c300b00154c472de80mr12236634plh.87.1648247342758;
        Fri, 25 Mar 2022 15:29:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x38-20020a056a0018a600b004fafd05ac3fsm5269993pfh.37.2022.03.25.15.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 15:29:02 -0700 (PDT)
Date:   Fri, 25 Mar 2022 15:29:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] array-bounds updates for v5.18-rc1
Message-ID: <202203251511.4F76EAB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these array-bounds updates for v5.18-rc1. Like the
FORTIFY_SOURCE tree, I was waiting for all the various other trees with
fixes to get merged. It looks like scsi was the last major tree I was
waiting on. This enables -Warray-bounds and -Wzero-length-bounds, now
that the many bug fixes have landed all over the place in the kernel,
and in GCC itself[1].

Earlier build testing of this series merged against your tree didn't show
any new warnings, but as this option has been a bit of a whack-a-mole
over the last development cycle in -next, it's possible new cases
have appeared. We will remain vigilant. :) A couple fixes[2] for known
corner-case issues currently live in my "pending-fixes" tree which I'm
expecting to send next week if other maintainers still haven't picked
them up.

I'm also expecting we can enable -Wstringop-overflow next cycle, as
there are only a few stragglers[3], but it might even be possible for
this release.

Thanks!

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/pending-fixes&id=2d253138910eec553fc706379914243d71de9b85
[3] https://github.com/KSPP/linux/issues/181

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/array-bounds-v5.18-rc1

for you to fetch changes up to 00a4f836eb369723b148e3f250c850a028778832:

  Makefile: Enable -Wzero-length-bounds (2022-02-13 16:49:40 -0800)

----------------------------------------------------------------
array-bounds updates for v5.18-rc1

- Enable -Warray-bounds globally

- Enable -Wzero-length-bounds globally

----------------------------------------------------------------
Kees Cook (2):
      Makefile: Enable -Warray-bounds
      Makefile: Enable -Wzero-length-bounds

 Makefile | 2 --
 1 file changed, 2 deletions(-)

-- 
Kees Cook
