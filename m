Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97810588719
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiHCGDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCGDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:03:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2D17A8D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:03:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ss3so29519819ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTj4TmBw1tO+s+/E622v1pc0c4D1v+OSObDkqpLLc1Q=;
        b=Kjtj2j7Rz3OIlku0tpUDJ/ObZMtg4OlvZ2wGAUwzDXRw/S20lSlIiGkgZfS4mBx3Iv
         WTN9C3cyOfi68EsojmWc3d6iz/tfws8SNd5trGJ+Sz/0VGh0PRY9UojGb5SJpHhSUuMJ
         k8Cvq3nKK69REeNEcVP+IKi45zM/f1nOsr0my6kTbBm1GtXtASmljWg2eShpGEkIWxFE
         BRcveCFRXNa/QKYZ0JR8YPGNvnObPPQL/e1Om9YLYocwPRcUY0tPFhJq0rLpnKSrgvpx
         Fe+CxNA35b45VtEdVkb2VI9wXuyXpsNN4P4h/t/jBsPxkvoCb1GWsbUvP2e6tMTaUX/M
         Y4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTj4TmBw1tO+s+/E622v1pc0c4D1v+OSObDkqpLLc1Q=;
        b=L2UrPvELbww20onrl0be5f5cMVoVqq0EBYXegcZD9nNaPMBviJlc/gSxlM1pO8ErMx
         lpzGZnQ6i+2xbRl3Zg93Too8tGJYLYzjXygIvZ0ZVzKdT8IJi2V69CkeoMDE6a6Teblh
         77+oGfA1gGk5m31hEHIS+Y+gp6wOyyR4/bM07qGqxDdxPpHP5niReOj2/6PfwkN1y+Xd
         powK9QNEKNhsA9ZPhkjfqjKkw56QZXgTZd/D1KJmpou/AJpuPUgVSK9gU+eoiIPwP6ea
         xHBryD4uaqCpJRfUpy15C2DPjtKhqhBTX3FiPw9PP58lswgnlPgGGRvN/I2kb0jCpE+y
         LOHw==
X-Gm-Message-State: AJIora8SRBUPLm7qR+uAY365KMwLfhfZn2xMw796BEs2EiuvAivmVDPf
        ItW352ZNXtuXNJwTsVGKnJIbxVxzZlKIZSb0vGY=
X-Google-Smtp-Source: AGRyM1uCK81RAEqXiBmO2EIzhypQxUIlr239lYiNo/9nXBq0084bUhbDXRpBqWRalkCn3onW4J1LbdDavAsumgDm9uw=
X-Received: by 2002:a17:907:3e11:b0:72b:49d1:2054 with SMTP id
 hp17-20020a1709073e1100b0072b49d12054mr19202140ejc.78.1659506618976; Tue, 02
 Aug 2022 23:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5Y+98u3R9zATF_VQnxCGzmg59O1sNnTc1sH-wgWFJbLrQ@mail.gmail.com>
In-Reply-To: <CANX2M5Y+98u3R9zATF_VQnxCGzmg59O1sNnTc1sH-wgWFJbLrQ@mail.gmail.com>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Tue, 2 Aug 2022 23:03:27 -0700
Message-ID: <CANX2M5ZEFGToH42rW+yndG59Uebcj-Eiv21Q2ykvHj=eVjpn+w@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ntfs_get_ea
To:     almaz.alexandrovich@paragon-software.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 5:51 PM Dipanjan Das
<mail.dipanjan.das@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
>
> ======================================================
> description: KASAN: slab-out-of-bounds Read in ntfs_get_ea
> affected file: fs/ntfs3/xattr.c
> kernel version: 5.19-rc6
> kernel commit: 32346491ddf24599decca06190ebca03ff9de7f8
> git tree: upstream
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=cd73026ceaed1402
> crash reproducer: attached
> ======================================================

Here is our initial analysis and findings regarding this crash (when
we run the repro attached to our original report):
In `fs/ntfs3/xattr.c`, the memory size `size` allocated to hold all
the extended attributes is `60` bytes which is pointed to by `ea_all`
in `ntfs_get_ea`. `find_ea`  iterates over the `ea_all` by adding an
`offset` to current `ea` address to find a matching `ea`. The offset
is calculated either using the size of the extended attribute in
`ea->size` or using struct size of the `ea`, if `ea->size` is 0. The
loop terminates if (1) one matched extended attribute `ea` is found or
(2)  The calculated offset is greater than `size`.

In this case, at one point the calculated `offset` becomes `56` which
does not satisfy any of the terminating conditions and therefore it
still attempts to find the next `ea`. In order to do that, it
calculates the size of the current `ea`. Since current `ea->size` is
0, struct size of the current `ea` is used. During that calculation,
the field value `ea->name` is dereferenced to calculate the size
occupied by that field and the address of  `ea->name` falls beyond the
`60` byte slab range. Hence, the slab out of bound occurs.

Please let us know if this helps, or we need to dig in further.

-- 
Thanks and Regards,

Dipanjan
