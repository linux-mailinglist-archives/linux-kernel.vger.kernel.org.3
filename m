Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7AF507316
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354696AbiDSQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiDSQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0AE1409E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:38:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so30383454lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQBJCdM90hvT5S/zAE5vLjVmVTwzQZE/0kHANhU68o4=;
        b=mlAAnQdt5ZbjW5hkIOjAqKQ5iX4QuiTTeQ0I0cdeISpwbgIbmg3RUkkjFw4KpohCbP
         8RGIByLJCRx2KA0kJsWTv1C/o6B7u0CXk+JrwaIWzh48UoWwa9uJakuvcBRHH6bFB/Ls
         tX/58Bs+DDYjM2dLCVv6lqqTOUYnJ9PZUOv6ULGKhZceGWjGcHSGQPxkVpBiBs8F9Qnp
         r07KFTHwyo7HRXZVntsjq1z3BLmxs7I/fJXElyz2uoOWD7csCPeiGFt/JWwuDWWr5NeM
         urr+wNHsjgoNLx2FkaKlnQvDSUqXKDNBLrjpyvlsa+kZ0ya916mz3qV427umdREsO18+
         xuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQBJCdM90hvT5S/zAE5vLjVmVTwzQZE/0kHANhU68o4=;
        b=OkUE5oka/IUnzmFq6I/BzkOm799SfiktAXxrUiJ1gF1qr1Jqxlb6ojCtPc+pPUZ9Zp
         tX/lxFEdBb96MJVx8JW2l198D6oj4REw8pbdNgyw+QcS81n0j33VxI0PLwGwHsPPknZL
         jJbLZd2OyV8oMaj5FnjhOjHa6/yDHPqm9RbRCLEkiZwY0mMNEeVH2/o3Ctve9khPshQ6
         CGOaIVG/lyk2wnnkvK2k0BKkfS+bH0ObYs7PVoVN0zD5bmNZCz6SN0ACtIBHzQrOS7E4
         A2Qjy9S5KPS1m1dbV3rb1KMjEjupeV29fPI/ebNXM5bGfEB79n6TXwSWDszP1xDRopr8
         Blvg==
X-Gm-Message-State: AOAM533SaSqeiCtDG65cRG8sOCyamuXztfD0z3WsYzEc3Ld8U/+VLtwJ
        LyWjPaRClAWCGa9wKRwtIFht/Dvgok7B43wBjLps6Q==
X-Google-Smtp-Source: ABdhPJy7I2GKesc7liKjiMsmsfYQ2u7aN/j0jHnPAFWYKa/qL6Bwrbr7ipVhkCDdP45fYwSBJO2iIe+zNJ/l2AeXGP0=
X-Received: by 2002:a05:6512:3d8e:b0:471:b4d4:32f with SMTP id
 k14-20020a0565123d8e00b00471b4d4032fmr491452lfv.288.1650386310460; Tue, 19
 Apr 2022 09:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160407.1740458-1-Jason@zx2c4.com>
In-Reply-To: <20220419160407.1740458-1-Jason@zx2c4.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 Apr 2022 18:37:54 +0200
Message-ID: <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
Subject: Re: [PATCH] random: add fork_event sysctl for polling VM forks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Alexander Graf <graf@amazon.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 6:04 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> In order to inform userspace of virtual machine forks, this commit adds
> a "fork_event" sysctl, which does not return any data, but allows
> userspace processes to poll() on it for notification of VM forks.
>
> It avoids exposing the actual vmgenid from the hypervisor to userspace,
> in case there is any randomness value in keeping it secret. Rather,
> userspace is expected to simply use getrandom() if it wants a fresh
> value.
>
> For example, the following snippet can be used to print a message every
> time a VM forks, after the RNG has been reseeded:
>
>   struct pollfd fd = { .fd = open("/proc/sys/kernel/random/fork_event", O_RDONLY)  };
>   assert(fd.fd >= 0);
>   for (;;) {
>     assert(poll(&fd, 1, -1) > 0);
>     puts("vm fork detected");
>   }

This is a bit of a weird API, because normally .poll is supposed to be
level-triggered rather than edge-triggered... and AFAIK things like
epoll also kinda assume that ->poll() doesn't modify state (but that
only _really_ matters in weird cases). But at the same time, it looks
like the existing proc_sys_poll() already goes against that? So I
don't know what the right thing to do there is...
