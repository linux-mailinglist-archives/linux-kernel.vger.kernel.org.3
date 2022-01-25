Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD77C49B351
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386577AbiAYLwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383390AbiAYLpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:45:06 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0206C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:43:46 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z7so12051188ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BDBFL5JIOOXEC88FG9umwmchk2ZH3tOEfx2IraU854=;
        b=SmmggTwKnKNHbzLGUmGyVQBuEjiPL+PXqlPQtFJJFYypUCwVpxXBgFtqCKFWYqHhvF
         NDaD3Bat/y77y5CWU5xBYPLZOoy9gNmLeuE4Mjr1eidaLp8ulxZKVigZJZimuBCkmp1S
         85jYKhSKSlEIHQ7NAii/pZN7lUBdyZ43p0YEeheOg9LhlzCyXNuhdvZAzI/Bod4t4QjU
         SbHF+HrOp5dXx+zu1lTYX6+09PViM+1xOhTHlUMfGabb2ImmWvsChgRveqOPiB3NAvUA
         vUzl7KFGss4QYUR6hDjz1w4j0G1ws52NhS6R3lHf4s4KZOyL6I2Ou8dSkr0FbMN1EVZ9
         oh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BDBFL5JIOOXEC88FG9umwmchk2ZH3tOEfx2IraU854=;
        b=L5utqQHsGhQY90ypUbHO9dVwg3dMlhQYlu3+3Xcmsn26w2d67FCSMmmFNevE2RcCv2
         zH+jAc577EDKOUi4wLpMFJRyQMRcyfix9dkWtrA7R+bVCRIU8cXbzGiuiAn6o0FSDaAH
         BoLpUR4yrrzwF4slj+wc6ox7GG7LK2S7yEDyTAjT32FLCS+6kPfphud4JA1Y0NoxXZsW
         EbAoNcnuIRRnAxaqjf1l82YrQGk7PYZo/ZaJZZZ2YLSu+BUPoU+ARiHglbMaRfMEz3OD
         WOYI4a8ETBobwgHuUd4vFP7NaIkd0Ef7fgEbaRisrt1hjtN0tCS6XeHw5bxe+mPVP6Zr
         +zDQ==
X-Gm-Message-State: AOAM530/e8LKtAFP72pjTKj2Mt2oDmSLv1tGdB7z07LLJOKQqM90RvG0
        eHNDDw1JmhUtnu7DmEv5dm0CXmHapG0HoO8KvNm2p940b5Y=
X-Google-Smtp-Source: ABdhPJx7E8IjVq131eFKlm4A4DtcfJW9VA4MciAg9ydVGYucOl9s+PrL/Ylz7eBO9HSvQ/wVTm6rOIxhZosi0bHfjTw=
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr14190159ljk.347.1643111024872;
 Tue, 25 Jan 2022 03:43:44 -0800 (PST)
MIME-Version: 1.0
References: <202201251943.TPk8Y7Ob-lkp@intel.com>
In-Reply-To: <202201251943.TPk8Y7Ob-lkp@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 25 Jan 2022 12:43:18 +0100
Message-ID: <CAG48ez0Yso71nssZtojpPUNoLUtq=k8yisYEp=v5KKsSOdqcUA@mail.gmail.com>
Subject: seccomp __user annotation fix backported too far in Android [was: Re:
 [ammarfaizi2-block:google/android/kernel/common/android12-5.4 3638/9999]
 kernel/seccomp.c:2041:41: sparse: sparse: incorrect type in argument 3
 (different address spaces)]
To:     Jeff Vander Stoep <jeffv@google.com>, Todd Kjos <tkjos@google.com>
Cc:     kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@gnuweeb.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:25 PM kernel test robot <lkp@intel.com> wrote:
> tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
> head:   3307e1a058380163f1a11c8f7632706168f9fcb1
> commit: 5444477e8a4d31f6e6ff720c2d018d06e405bcc1 [3638/9999] UPSTREAM: seccomp: Remove bogus __user annotations
> config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220125/202201251943.TPk8Y7Ob-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/ammarfaizi2/linux-block/commit/5444477e8a4d31f6e6ff720c2d018d06e405bcc1
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.4
>         git checkout 5444477e8a4d31f6e6ff720c2d018d06e405bcc1
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

It looks like this was a bogus backport -
fab686eb0307121e7a2890b6d6c57edd2457863d is marked as 'Fixes:
32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")', but
Android incorrectly backported the patch further
(https://android-review.googlesource.com/c/kernel/common/+/1535131/).

> sparse warnings: (new ones prefixed by >>)
> >> kernel/seccomp.c:2041:41: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void *buffer @@
>    kernel/seccomp.c:2041:41: sparse:     expected void [noderef] <asn:1> *
>    kernel/seccomp.c:2041:41: sparse:     got void *buffer
>    kernel/seccomp.c:2059:40: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void *buffer @@
>    kernel/seccomp.c:2059:40: sparse:     expected void [noderef] <asn:1> *
>    kernel/seccomp.c:2059:40: sparse:     got void *buffer
> >> kernel/seccomp.c:2115:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *buffer @@     got void [noderef] <asn:1> *buffer @@
>    kernel/seccomp.c:2115:54: sparse:     expected void *buffer
>    kernel/seccomp.c:2115:54: sparse:     got void [noderef] <asn:1> *buffer
>    kernel/seccomp.c:2119:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *buffer @@     got void [noderef] <asn:1> *buffer @@
>    kernel/seccomp.c:2119:53: sparse:     expected void *buffer
>    kernel/seccomp.c:2119:53: sparse:     got void [noderef] <asn:1> *buffer
>
> vim +2041 kernel/seccomp.c
>
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2025
> 5444477e8a4d31 Jann Horn   2020-11-20  2026  static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
> d013db029491b4 Tyler Hicks 2018-05-04  2027                            size_t *lenp, loff_t *ppos)
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2028  {
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2029     char names[sizeof(seccomp_actions_avail)];
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2030     struct ctl_table table;
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2031
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2032     memset(names, 0, sizeof(names));
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2033
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2034     if (!seccomp_names_from_actions_logged(names, sizeof(names),
> beb44acaf000c9 Tyler Hicks 2018-05-04  2035                                            seccomp_actions_logged, " "))
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2036             return -EINVAL;
> d013db029491b4 Tyler Hicks 2018-05-04  2037
> d013db029491b4 Tyler Hicks 2018-05-04  2038     table = *ro_table;
> d013db029491b4 Tyler Hicks 2018-05-04  2039     table.data = names;
> d013db029491b4 Tyler Hicks 2018-05-04  2040     table.maxlen = sizeof(names);
> d013db029491b4 Tyler Hicks 2018-05-04 @2041     return proc_dostring(&table, 0, buffer, lenp, ppos);
> 0ddec0fc890020 Tyler Hicks 2017-08-11  2042  }
[...]
