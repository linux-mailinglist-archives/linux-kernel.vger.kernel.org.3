Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4A59CB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiHVV7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVV7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:59:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B7F19C13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:59:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so5456484wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=ynuYihZWZ0kAQ4LlyTu0kPhjqQvQSMdMHCz5+9btL4g=;
        b=h4r5N+9PCdNWJgiHHD7yNUcPqWeII/k4P0MZmgSg8+roBLCj2/qsTwG1ukd2RX9pZm
         Wu0ueIi+0F1SeHm4ZmBVTfm758BwjbIXGn2DrH6BrzpCtsxZbSExA1jZM0qtKPpuALfY
         TMQsl5XARCJIYpAcW5PUtjIfQviuHTOfCUeJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=ynuYihZWZ0kAQ4LlyTu0kPhjqQvQSMdMHCz5+9btL4g=;
        b=yIQdSU/CutSliVz8sslnO1nTyQnDdO7JDbl/JqbygxbKqFCGDLc0tbvkKkFDdUNB3m
         DAI33omXO7Vm74g/W6yB3AYyCscluq8Kihihjim3J8TsYib7KXl5+n8U2b/keXbQyzXg
         Go2lXLszPUoFdfeXPOjvZ8JVO7jrrut83MSaKPefP0vRWW1/jBMUoiPdY6wXdISzdHR2
         7PZVUyqHJmraniq4VrwQ0iW+T+PlT1q+Js3j8Q44L6w9g+mgGx9ce86fwAf+xQ59wBWM
         I1esQLhqlP3EXTVjZzrhVgLXPMOIXNlHUWOYcEidrbjjHjTZ+qqRy16POp0OLFfH8L16
         eA5g==
X-Gm-Message-State: ACgBeo1YKPGY07B2cHDadbAhFNrb5WhQmbLy8yQDChLnt9C/cyD7kFk2
        wk+T3ISXGap4G4MayXs43PxnN5ln40s3mg==
X-Google-Smtp-Source: AA6agR4eAgTgLnRn2o+SuA1/JZNb6CRhGYCvTA7EamJmIPnuQaM1HNboLADEpWmlb9w+zpnMGPybtg==
X-Received: by 2002:a7b:c016:0:b0:3a5:fff2:62f4 with SMTP id c22-20020a7bc016000000b003a5fff262f4mr218337wmb.104.1661205586484;
        Mon, 22 Aug 2022 14:59:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6994:a175:4613:7bc4? ([2001:8b0:aba:5f3c:6994:a175:4613:7bc4])
        by smtp.gmail.com with ESMTPSA id bg19-20020a05600c3c9300b003a5e7435190sm21569924wmb.32.2022.08.22.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:59:45 -0700 (PDT)
Message-ID: <4e6fa793f58e23bb53ab161b9ab119a35020b7e6.camel@linuxfoundation.org>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with
 dash
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 22 Aug 2022 22:59:43 +0100
In-Reply-To: <CAK7LNAQTHO3Za9UpeCCkdNo-mQS8ORgbfwXCJKKr4FCZ3VqT2Q@mail.gmail.com>
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
         <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
         <7eacd1d9-42ba-fd61-7f37-0635cebcb33d@infradead.org>
         <e902a360e3759c7f87d98d71d79a0d5cbe935e3e.camel@linuxfoundation.org>
         <CAK7LNART2XQYy2hN1afODbuCMj+_VX9Ojh5nVCoY-hwXRAwSWA@mail.gmail.com>
         <0725ccc9abce84695573539c5f3d9d061384469d.camel@linuxfoundation.org>
         <CAK7LNAQTHO3Za9UpeCCkdNo-mQS8ORgbfwXCJKKr4FCZ3VqT2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 17:40 +0900, Masahiro Yamada wrote:
> On Fri, Aug 19, 2022 at 6:46 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >=20
> > On Fri, 2022-08-19 at 04:31 +0900, Masahiro Yamada wrote:
> > > On Thu, Aug 18, 2022 at 6:14 PM Richard Purdie
> > > <richard.purdie@linuxfoundation.org> wrote:
> > > >=20
> > > > This problem is a little more subtle.
> > > >=20
> > > > As far as I could work out, exec() is used on entries like this in
> > > > kConfig. exec() falls back to /bin/sh so it is hard to see where th=
is
> > > > would be changed to be /bin/bash.
> > >=20
> > >=20
> > >=20
> > > Kconfig uses popen() to execute a shell command.
> > >=20
> > > See do_shell() in scripts/kconfig/preprocess.c
> > >=20
> > > popen(3) says that
> > > "the command is passed to /bin/sh using the -c flag.
> > > interpretation, if any, is performed by the shell."
> > >=20
> > > GNU Make is the same.
> > > Make uses /bin/sh to execute commands in
> > > recipe lines and $(shell ...) functions.
> > > You can change the default shell via 'SHELL' variable.
> >=20
> > That makes sense. I don't think we can easily change the shell popen()
> > uses.
> >=20
> > >=20
> > > BTW, Richard is here, so let me ask about BitBake.
> > >=20
> > > The manual [3] clearly says:
> > >=20
> > > "When you create these types of functions in your recipe or class fil=
es,
> > > you need to follow the shell programming rules. The scripts are
> > > executed by /bin/sh,
> > > which may not be a bash shell but might be something such as dash.
> > > You should not use Bash-specific script (bashisms)"
> > >=20
> > > I just thought BitBake ran shell code in bash before,
> > > but I might have misunderstood.
> > > Do OE/Yocto allow only POSIX shell code?
> >=20
> > Bitbake runs shell code with /bin/sh so we don't allow bashisms and
> > that has always been the case.
> >=20
> > Like this case in the kernel, we do get people submitting changes which
> > were only tested with bash which can be frustrating but the manual and
> > our policy is quite clear. We just fix any that do creep through and
> > have test systems that have dash to try and catch them too.
> >=20
> > Cheers,
> >=20
> > Richard
>=20
> Thanks.
> So, Bitbake is the same approach as the kernel.

Yes, effectively.
>=20
> This is a patch set to use bash forcibly. FWIW.
>=20
> https://lore.kernel.org/lkml/20220819065604.295572-1-masahiroy@kernel.org=
/

Thanks, I'm watching with interest to see what happens.

The original patch causing issues was backported into several stable
releases and this won't be so we have a bit of a challenge there but we
have also started carrying patches to fix that too so as long as things
get fixed in master we should be ok in the long run and I'm happy.

Cheers,

Richard

