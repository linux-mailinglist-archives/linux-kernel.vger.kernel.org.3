Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8BB598FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbiHRVqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiHRVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:46:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116ECC88B8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:46:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k16so3135477wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=T4FxAgLCE9QwZk4TMfEghcY2HvZrdRqNYVhppforbHM=;
        b=h8dUR29V4y/7hTSjBNSHhlYF3GZvpq/D+g4hJeLb6uDZFP/pFCq/n4B3IyiF2VE3hz
         SNwukpeIba40x3vtlc8ZP9bpkFizGdvLCf9twZkWJXVFvZMoyVx5ShJ9NSJvqjw7UOUZ
         1mnRdXlwgDfkeCFNe7ls4YWMIlBwxlByGMGtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=T4FxAgLCE9QwZk4TMfEghcY2HvZrdRqNYVhppforbHM=;
        b=c14yxo458/RO2WWXAbzjLp+9RifAI1TBiol1PUIU+wAtHf4BCf8QyY7DMQgdMNF86J
         i0CenIdO3pQu1DUY1SelFsRqADI7aDQ76MPgeSx8k8fRqJJc0loD/qpvhjY7p8qTuxzv
         Tt8ZAt4CggKwJsIrXs/H4w+dOi/KorCUTUXG+sCyx9TIsgJPxvFcL0eVealiqEH4HzkS
         NNMerhVMbdi2RQ0uPYSTjnHpDqP+tYWqkgzpemMVu2JAlA0pqwBnOLLSW39pD4nDUciV
         0T37x0djGLWbJacQ+5pmzS2akqMpVyd22KvX7+NQ9uAI9Djgg+SQd95aGSIEire+ecp3
         pv2A==
X-Gm-Message-State: ACgBeo0eRN48RVIOcGiBRBcZZ4w6xMcAZJV6k/slfx/Axat5mCugpJRN
        7LjMOBReyYP1Z7Vl7W6LRRQfng==
X-Google-Smtp-Source: AA6agR5+QwxoZJFPP3mfGnxOE+wK1T0b/SJq3eMNCThbvK+rLt1oyCmwyPEnSvh92Fg219ABLIkdeA==
X-Received: by 2002:a05:6000:242:b0:225:30e0:ced4 with SMTP id m2-20020a056000024200b0022530e0ced4mr2096607wrz.114.1660859159615;
        Thu, 18 Aug 2022 14:45:59 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3de5:2579:8490:3720? ([2001:8b0:aba:5f3c:3de5:2579:8490:3720])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003a5f54e3bbbsm8018346wmq.38.2022.08.18.14.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:45:58 -0700 (PDT)
Message-ID: <0725ccc9abce84695573539c5f3d9d061384469d.camel@linuxfoundation.org>
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
Date:   Thu, 18 Aug 2022 22:45:58 +0100
In-Reply-To: <CAK7LNART2XQYy2hN1afODbuCMj+_VX9Ojh5nVCoY-hwXRAwSWA@mail.gmail.com>
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
         <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
         <7eacd1d9-42ba-fd61-7f37-0635cebcb33d@infradead.org>
         <e902a360e3759c7f87d98d71d79a0d5cbe935e3e.camel@linuxfoundation.org>
         <CAK7LNART2XQYy2hN1afODbuCMj+_VX9Ojh5nVCoY-hwXRAwSWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 04:31 +0900, Masahiro Yamada wrote:
> On Thu, Aug 18, 2022 at 6:14 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >=20
> > This problem is a little more subtle.
> >=20
> > As far as I could work out, exec() is used on entries like this in
> > kConfig. exec() falls back to /bin/sh so it is hard to see where this
> > would be changed to be /bin/bash.
>=20
>=20
>=20
> Kconfig uses popen() to execute a shell command.
>=20
> See do_shell() in scripts/kconfig/preprocess.c
>=20
> popen(3) says that
> "the command is passed to /bin/sh using the -c flag.
> interpretation, if any, is performed by the shell."
>=20
> GNU Make is the same.
> Make uses /bin/sh to execute commands in
> recipe lines and $(shell ...) functions.
> You can change the default shell via 'SHELL' variable.

That makes sense. I don't think we can easily change the shell popen()
uses.

>=20
> BTW, Richard is here, so let me ask about BitBake.
>=20
> The manual [3] clearly says:
>=20
> "When you create these types of functions in your recipe or class files,
> you need to follow the shell programming rules. The scripts are
> executed by /bin/sh,
> which may not be a bash shell but might be something such as dash.
> You should not use Bash-specific script (bashisms)"
>=20
> I just thought BitBake ran shell code in bash before,
> but I might have misunderstood.
> Do OE/Yocto allow only POSIX shell code?

Bitbake runs shell code with /bin/sh so we don't allow bashisms and
that has always been the case.

Like this case in the kernel, we do get people submitting changes which
were only tested with bash which can be frustrating but the manual and
our policy is quite clear. We just fix any that do creep through and
have test systems that have dash to try and catch them too.

Cheers,

Richard
