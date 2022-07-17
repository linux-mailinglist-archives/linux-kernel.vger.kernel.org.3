Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5407577833
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiGQU3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGQU33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:29:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057C2640
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:29:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so12926873edd.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5n4kSbt+tDnJOmMOFdBXx2xa6DkOaFuSU52FmmeggU=;
        b=aJ0ySncRL5xwy3/WJRusOdK8nCOceATdsP/LrESQ+9olCuwbS7L0orcpD4kg4D4J+f
         KbkqgAwS/00KYAzWOUWUp64AdQklzywMgBC25bxwJEUp2t8R4RI5hI6drZwEdRnOVoxi
         fCWhU2soygB4BoKsZzC3n71dPyEKBWfwoYlmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5n4kSbt+tDnJOmMOFdBXx2xa6DkOaFuSU52FmmeggU=;
        b=0VyMTm0qegzYamgnejxMbDKqlm4yWiwUzrLvY2DpXxMuEenyX3GKSt9C/Y1BtDbSMP
         ZTr8RYDGtdiyJl7rXh+TDDiboxT/zeVWz8CLzI55N1/QzlF/Z4bzR+srdk0vPSmp3a8m
         JNbud+u/vxEgAWPpIOLTeYVRYjCRJiBOxqnLLSeaMXNnqgBuKXnHX612xZTStgchbQxm
         bvwwNaPwCON3y7UZqJGSNZPekpZyaSFWN3ObefF02vJunn03xfzxAdf/4c2q8sgCF6If
         YNAwljcV/hRQnJ5UkMVs9QktDRah/3aIvWG8nzFHd8uCGKGBFpaWATFwmbSCIkj+VzPi
         BiKQ==
X-Gm-Message-State: AJIora8e2viN7HHffd/jHziQsTSMykBdWpD3WucXCYqj7SciQkW6zdvv
        pq+L9mCnbNfq3YLcFATWBqIrSCNLd2Y0Do8AWQ0=
X-Google-Smtp-Source: AGRyM1tUHkQxEkjsVydKlHpCXkRdknDbstXuW+Pxxj+/fT1bDlHHcDVshc/vYag+/duQcIl1vpD/3g==
X-Received: by 2002:a05:6402:3202:b0:43a:86f5:a930 with SMTP id g2-20020a056402320200b0043a86f5a930mr32462371eda.389.1658089766109;
        Sun, 17 Jul 2022 13:29:26 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b006feed200464sm4651872eje.131.2022.07.17.13.29.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 13:29:25 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id r2so13460390wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:29:24 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr20430637wrw.274.1658089764088; Sun, 17
 Jul 2022 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com> <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
In-Reply-To: <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 13:29:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
Message-ID: <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 1:25 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> And the generated assembly still has the memset for "struct prom_args".

Strange. That smells like a compiler bug to me.

But I can't read powerpc assembly code - it's been too many years, and
even back when I did read it I hated how the register "names" worked.

Maybe it was never the args array, and it was about the other fields.
Not that that makes any sense either, but it makes more sense than the
compiler turning a series of volatile accesses into a memset.

              Linus
