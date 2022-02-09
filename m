Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EBB4AE5C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbiBIAJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbiBIAJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:09:16 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7EC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:09:16 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u6so1072434lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 16:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W19puUKhiHbEmWCxpE5TIFSUh7P9zJpCL7kz3pPFVgI=;
        b=fYaC0L0JyyaNU+LhqGMLn+efsEyae3kO7jiGuXumIrVBofnhAwpNjW9F3p/EJ2h0bI
         3JBqer8Zd9vnaYaZSxIIGbhHE/jmhyvFTyRVbZQYyisKQDOQ/O9OcJyABeCt6XjujJIL
         ZmEppE0GQw/l7oP3w/MnKSZ7eHTJmwru04lCfff6W7IU4ybwE9kq44sshLmt9Dq/B4L0
         84pwPtoY0w25HWnhZ5J4bqRxR+gwCtGYYdWogfKtXAiM2X4Us5jWVg+tvx3vVnMWe3ls
         uKM1HOPbuQ10xmZs0thcUT14kyim1NNFdaSPdsqlzWphfbPvyxPhSdPzxgW4j6n0eS1w
         pI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W19puUKhiHbEmWCxpE5TIFSUh7P9zJpCL7kz3pPFVgI=;
        b=Ekeh6szj0p7kZ+4c15vkJKUuJq+Y00NOFUr8BIHxL8iA223WlA+OGD2FGdtsvurMiz
         how/nXnKUyz2kQ+oxaKw4zVhNzGR6hKYcKMX33Dde4JNKRGxtkwHJePrwvh/Gc46IePg
         scHpuAZ0kHxxnKcJnuCOZn/Mv3Il7MkrzE9lgeGr4oJ7zJ6y2u3/VyLr+vGgDx8KCb+7
         YK/L9V1/SEYXwJjLXFnDCS8rd5D+Kmwmwmish0jeSjmYfLxmyiUWkGuAi9cjPw9pm7Ik
         NUSTu4SzXYV3khTUHoX+kYDWPwGMOVAPgOUR4MCzJ9Zju39ifZZoGmyfsOByMNPi6vd3
         HVJw==
X-Gm-Message-State: AOAM532x2LbvpcIlyNw359nTu9tB0/8JH3o2SRPyPW5J3Vr+Dhi1RLEW
        b0pt2oWlFcQTRLVKuybdCq8TJDca5a6Niy/mQSzOMw==
X-Google-Smtp-Source: ABdhPJxF2pldIArsg4Ym1I6TGdhw72v/mmazF7M6SaN1/N2nCMj+9r5lENIBGFEGMsXlU/H+Y+YSJytyZo4DYgLAZn0=
X-Received: by 2002:ac2:4e10:: with SMTP id e16mr4784298lfr.444.1644365354322;
 Tue, 08 Feb 2022 16:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20211122170301.764232470@infradead.org>
In-Reply-To: <20211122170301.764232470@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 16:09:02 -0800
Message-ID: <CAKwvOdm_-Gf=pTbM0ai6tn99Yxo4eV217R1j__36zOj0vBQ-PQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/6] x86: Kernel IBT beginnings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 9:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi,
>
> So I hacked this up on Friday night / Saturday morning and spend all of today
> cleaning it up.
>
> It is the very bare beginnings of kernel IBT support. Since I'm lacking any
> sort of actual hardware it even lacks fun things like code to write to the MSRs
> to enable the IBT tracker etc..
>
> However, it should have most of the ENDBR instructions in the right place -- I
> hope :-) That said; I would *really* like compiler support for this stuff to be
> improved, the amount of fixups done by objtool is obscene.
>
> The end result still boots on ancient x86-64 hardware, for whatever that's
> worth (when built with the below turd included that is).

Thanks for the patches!

Are there recommended command line args for qemu emulation to test
this with? Tigerlake and Alderlake should be required for IBT support
IIRC from our IRC discussion?
https://qemu.readthedocs.io/en/latest/system/qemu-cpu-models.html#preferred-cpu-models-for-intel-x86-hosts
No hits for:
$ qemu-system-x86_64 -cpu help | grep -e tiger -e alder
$ qemu-system-x86_64 --version
QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2)
Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers


-- 
Thanks,
~Nick Desaulniers
