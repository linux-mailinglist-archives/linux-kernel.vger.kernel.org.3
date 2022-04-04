Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5894F1EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiDDWXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiDDWVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:21:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B8363A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:47:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r10so6991903eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvKxsafXL2Gat8gnxoPlSsJysAlo5fGZyeeEP4baNY8=;
        b=A9tjEjTQxL5uzMyZiDMZsByK+whBGLSB6qHE+uZRK7pVJilQTKdEsI9cEjxGRejl5b
         J71jC7xcvbNYqvYxcPtUkqcG/jeaBVt1hzrA68i4S37/iSwMfqtVSRk8JDPuGGLw6XZI
         nrysu96epRGW5riZujfcbHCnjDbtfn5ZsZrfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvKxsafXL2Gat8gnxoPlSsJysAlo5fGZyeeEP4baNY8=;
        b=OfvibGCYBZ+nzo0M+moaLkRiCbcCwJexObwxwfPFIqN+/ecv0LwubLJTSou17Lzv2I
         RhqYcyp8pOZyaqJYuN75Kzy7Y4y6eKMJYi0k4laQq4QsBlm92NjKZ1vKxpqy9/Y3r8Ph
         wKCBzKnQBkR5ahoBgR23yRpNE7l4BndBaDVLUiVHerIWDYlcUwenT2sKlzZa1V9jdSxB
         shKj/tvp2J0Tw3VVSE7GiD/5yzFRBnNETKvo6PpD7gq0+9zXDY3ZTlt2e8V9y1Ix7Vrz
         EOYllNC82qlO3aOTFkhVY4dlZ7J4g6Zj9vQGQPO5e7L1+14Ev1y3W4qiHVvuIIqcUoel
         nIPQ==
X-Gm-Message-State: AOAM530fkUnOkqNR6OrWd/8qD+rspaA7t+1hrQcHO04T268rr+6jiZ41
        eb5ZPuOnZxUqDNPiwYk5mtzCAMCRq7ERUyycvys=
X-Google-Smtp-Source: ABdhPJwTT3Xb5zSZ+CDxnePU1NqRZIi3MabNLkcrcsC2MglSmonkzEu40Qjo3FCO70KU64FX/rqzGw==
X-Received: by 2002:a05:6402:5211:b0:419:583d:bb58 with SMTP id s17-20020a056402521100b00419583dbb58mr233608edd.198.1649108844228;
        Mon, 04 Apr 2022 14:47:24 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b004197b0867e0sm5804890edv.42.2022.04.04.14.47.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 14:47:23 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id k23so3953944wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:47:23 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr239017lfb.435.1649108438583; Mon, 04
 Apr 2022 14:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220321161557.495388-1-mic@digikod.net> <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net> <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
In-Reply-To: <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 14:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFQCUto1LGo8Cozhe1n9KjoU_99v94ubU_QWSQob7ntw@mail.gmail.com>
Message-ID: <CAHk-=wjFQCUto1LGo8Cozhe1n9KjoU_99v94ubU_QWSQob7ntw@mail.gmail.com>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 2:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (4) maybe we want to add a flag for the "euid vs real uid", and that
> would be in the "flags" field, since that changes the actual *lookup*
> semantics

Duh. We already did that long ago, and it's there as AT_EACCESS.

I should have just looked at the code more closely.

But that "you didn't even check what we already do, Linus" thing just
makes it even more obvious that all of this makes perfect sense in the
confines of access() already, and a new "check _these_ protections"
should just be a new mode bit.

                 Linus
