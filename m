Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2B4BBC59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiBRPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:44:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBRPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:44:46 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C022B709
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:44:29 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x18so2606426pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=doT7bK7EPrJiz241mVjN8JSE6X0c4y1Cn7yH47MmQuY=;
        b=f7IrV8Co4YLWgbQabeAxKnaaARwhRRuipRCEkgrAJCQqP2XFBjrXQKuLiqPrbblMp4
         1I0PyweE1qWbuBRwiem9GlWvoesOq6Y1GB8AnDJbzrRXaD1VWQKp8irajqq+k55dCKAi
         CseUDopHDjNGPOjBaX9WvpduIweYhYqPDAMXxxYv0yiDD8iPLrA7BZIetCe3CCIYdVYV
         ASZLZRL6vD/Zv40jqnzmkhX/ZXHdMbZSSn8xdx8/UI1a++gVGYKlWrJhfahzStHzBbVt
         iFKohUn9z3TIl5lLqD6/ZqoBkVkbxJ6dRJy+TTq14nDy33ykAI0H/nBHragcZH98I9mN
         Pgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=doT7bK7EPrJiz241mVjN8JSE6X0c4y1Cn7yH47MmQuY=;
        b=T8bXt/YviUCX7d1FpIUrEM6TH0sPTiOcPeyy+DX5ttJNSEl/U2dIRkvYLtXLiMQbaW
         1hsN8ypARWkVnx5T2la2oeYFTF+c27/w8yeNnSIdCNKR15OPk1XbK7R38XCrhKXfKNVp
         x9dKFW2mDuJZwMLwSmBa5We9BXEUVi4wh5u0ZuyvAlgeP0GsMbtErQo9pmi7V2TkUDrL
         y7oCgQiLsz8btV3zprwxFDvamFagWFqSV7BvsenUITBhpOqcpay9KZgLJY6WH0VsgKOz
         bxM5zvnOZSYvaWEkJpvRsiP4fhFQIgefob9XyxCpeLplHopGd37+fFkLhD77/w/nuUPv
         4WFw==
X-Gm-Message-State: AOAM533Y8e4Ql1EbBRAuX864bw3g9Ef0xDOOO6FtSzlb8m1XAMMTZKZS
        02jUCTHeGBdclP23LKWPtHaE48UQ8iGb2735w8Pt
X-Google-Smtp-Source: ABdhPJzPTn2nMsDVP8pfZnyivdp+JN2LbHE/ubEBj9MgLJGKutLru+hZtPhdSKHgoM+BCyRoh2SY4sYUhFcJlHlQacc=
X-Received: by 2002:a63:da4d:0:b0:36c:2302:1940 with SMTP id
 l13-20020a63da4d000000b0036c23021940mr6764465pgj.261.1645199069118; Fri, 18
 Feb 2022 07:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-5-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-5-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 10:44:18 -0500
Message-ID: <CAHC9VhQ6hTa2ZrNHBWeE2hcr9uAbD1r351oZvxRzO6H357-H0g@mail.gmail.com>
Subject: Re: [PATCH 1/5] selinux: drop return statement at end of void functions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 9:22 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Those return statements at the end of a void function are redundant.
>
> Reported by clang-tidy [readability-redundant-control-flow]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c          | 2 --
>  security/selinux/ss/conditional.c | 2 --
>  security/selinux/ss/ebitmap.c     | 1 -
>  security/selinux/ss/mls.c         | 1 -
>  security/selinux/ss/services.c    | 2 --
>  5 files changed, 8 deletions(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
