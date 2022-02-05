Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC984AA59F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378950AbiBECTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355924AbiBECTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:19:17 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6269C061347
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 18:19:16 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so6721457ooq.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 18:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cwAvPdmH6i1eqh2dUujon6iMut8KAmem6g6qtz93bHg=;
        b=eDhXz2upav5A0sO+ukPvPUIGLlbSZKwXKI6rcj1G9cNWo8hk3Ux6tGIElvsVzn410s
         qZH4bruGvicuFk80Y86GYy8Yztk0syKklEGUgQ/vVhEQ4P9tzsGHrmxHDzHCl4egmc5N
         GQV9V/bYJcVoGnSVFSmR3zhkB4JrJVJkrIYvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cwAvPdmH6i1eqh2dUujon6iMut8KAmem6g6qtz93bHg=;
        b=ZLGvSoLSIqGXGlP/ztUe79u+ABA+rwz7+DOIaChcCzRwVuOKFbHmb8nGIKfmoSsOdm
         T/lhFgS2a1pr22Kr/uVRBwoGB6GqpFJqST38VmWhKBVis7FcI7ezrvF5fzngD8uU1A0B
         pQENreWIfmfViAX7TfjtMw4ubkf+RJZncQxACYSRZy0BOi6g0B8+HZ9IwiSynEkbBcIW
         aWVT1IhlQGNuajg74Bv41owXJztkVQKNS8UZ4Fxp4NN5UQlxaL7nKUG8G7EoxZuySzLO
         8BWz768QO8NcTmkB9KW7CSybBoWksj2s+bFWCRoP0rLjYDvJyiqtrLX7Wr4Gdo8mgjCg
         vilA==
X-Gm-Message-State: AOAM530bRqgenk0Yrhl6MhaNQFk4KvPr3MaQJhDafWuEZgYu4NvoWvbe
        bVAHkwMzUsBS9uGdfNs4qwCqGLSH492dHRt8tUQR1g==
X-Google-Smtp-Source: ABdhPJx0s9TlZNnm+o8py20JIb6f4e7uTGOQYfrnUwMZnsyDa/bhriTxwJEUszfVCOqfvKTrhz6N0cjGITCoxPbYbwk=
X-Received: by 2002:a05:6870:6256:: with SMTP id r22mr484173oak.8.1644027556039;
 Fri, 04 Feb 2022 18:19:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 5 Feb 2022 02:19:15 +0000
MIME-Version: 1.0
In-Reply-To: <202202050807.BvUyitVE-lkp@intel.com>
References: <20220204202021.895426-4-swboyd@chromium.org> <202202050807.BvUyitVE-lkp@intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Sat, 5 Feb 2022 02:19:15 +0000
Message-ID: <CAE-0n518HoYDBiMFQ_2evXi3e+GYP2XVfY3raqs0cckiZ2bjgQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: Extract vivaldi hid feature mapping for use in hid-hammer
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernel test robot (2022-02-04 16:15:59)
> Hi Stephen,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on 26291c54e111ff6ba87a164d85d4a4e134b7315c]
>
> url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/Input-HID-Consolidate-ChromeOS-Vivaldi-keyboard-logic/20220205-042211
> base:   26291c54e111ff6ba87a164d85d4a4e134b7315c
> config: x86_64-randconfig-a004-20220131 (https://download.01.org/0day-ci/archive/20220205/202202050807.BvUyitVE-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/83759eb892fd16fd0bb7ff4bb0c4baa4e7a0283e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Stephen-Boyd/Input-HID-Consolidate-ChromeOS-Vivaldi-keyboard-logic/20220205-042211
>         git checkout 83759eb892fd16fd0bb7ff4bb0c4baa4e7a0283e
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    vmlinux.o: warning: objtool: mce_start()+0x4e: call to clear_bit() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_read_aux()+0x41: call to mca_msr_reg() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: do_machine_check()+0x39d: call to test_bit() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x53: call to on_thread_stack() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4e: call to on_thread_stack() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
>    ld: drivers/input/vivaldi-keymap.o: in function `vivaldi_hid_feature_mapping':
> >> drivers/input/vivaldi-keymap.c:73: undefined reference to `hid_alloc_report_buf'
> >> ld: drivers/input/vivaldi-keymap.c:90: undefined reference to `hid_hw_raw_request'
> >> ld: drivers/input/vivaldi-keymap.c:108: undefined reference to `hid_report_raw_event'
>

Ah I see. CONFIG_HID=m but CONFIG_VIVALDIFMAP=y so we need to make the
whole file into a module when CONFIG_HID is a module, but then that
means the atkbd driver would need to be a module too. Probably best to
move this hid part to yet another file in drivers/hid/ to keep things
tidy.
