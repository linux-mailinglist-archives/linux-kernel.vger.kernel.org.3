Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50A74BBC73
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiBRPtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:49:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiBRPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:48:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1932790AA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:47:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so12683406pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R7TNHVy3VEleA7R3NGQqJ4zyGtuvT0iWporTmytRR1U=;
        b=KON7l6sZDqK4j+UT/SLLl9wF0aR06ZernKJUjbdRwbfCJF4h8uSdazOttrU1iG8NaU
         aDhQOQ0jYzLFylcXFA+taa/4jHZodaAoym1QARbYZmSzL/dtrbqDNyP1bH7glXmkRDNB
         FgykfB4u+o0F5Wf7FQZatjp2JwJiMs99Jds6X9y6FTpVYUQfDJmJw4lwcpv/Bke0AcGM
         I9KzBB297Tq9W0BEPf3DdlvRXIJTreFFHtgRJxEyLP/qthEggEsUGDqsx4vOGXTbMXQj
         6pfGH4+qTrnMgO7msiSZaQu4ZEWxJe8HvXUAiuDmXrGYvJCHe3iaponKD1TLutiDi3YY
         +hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R7TNHVy3VEleA7R3NGQqJ4zyGtuvT0iWporTmytRR1U=;
        b=ETM/AEgJIzz1iqbiPIgqaT3QFrEJ24ciS6AGUfVGwpl4wkIBBOniknmEZYf+Ukvcvt
         SZg7MJDNHtData6LIBL1GLUL3/blukDb/K3zwF30eB8l56AL7WEMfpBjhFZKQhx1SI3V
         0n3YKx4aHj0xeqpzf0hHANuzDAuPjMY9K0/h1WpRUg/auuZCNx/XwVGE+tsckcuARsfG
         nQ4XNjtn9sCfEJhyoub/kWN3o7BPFXvScDm5hPR2Rx3aBKFt5/qP1SUoMAUAKsS6sVPn
         vPtxAkFbV6dVOUl4ZqKbnKgXwcn0eWJqF6Z5abwraQoz9yb6fSCHfX6X9Sx5RU3MPmKV
         SXZg==
X-Gm-Message-State: AOAM5302LWwpIOFmkrRRPlVZE9ueC2/evJq8w997yE/Lf8UDPxnaLnyT
        BAHwQCsuscdx9DS/9vMNTz7EqgLf87bHUiYpBwJs
X-Google-Smtp-Source: ABdhPJzodkaf8k/ZT66s8Hyu+Nb97VQ60hfUBvzEFWPT3b+9kE7PaFflndfYJBSvH3GRCP/p8PpArYs83Tx8ZDOUlPU=
X-Received: by 2002:a17:902:b94b:b0:14e:f1a8:9b99 with SMTP id
 h11-20020a170902b94b00b0014ef1a89b99mr8066539pls.28.1645199276295; Fri, 18
 Feb 2022 07:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 10:47:45 -0500
Message-ID: <CAHC9VhSuVr6NPVToScGQ=6Ugm1BFbijtzXxuTW3bs4ze57fn6g@mail.gmail.com>
Subject: Re: [PATCH 2/5] selinux: use correct type for context length
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Austin Kim <austin.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> security_sid_to_context() expects a pointer to an u32 as the address
> where to store the length of the computed context.
>
> Reported by sparse:
>
>     security/selinux/xfrm.c:359:39: warning: incorrect type in argument 4=
 (different signedness)
>     security/selinux/xfrm.c:359:39:    expected unsigned int [usertype] *=
scontext_len
>     security/selinux/xfrm.c:359:39:    got int *
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/xfrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
