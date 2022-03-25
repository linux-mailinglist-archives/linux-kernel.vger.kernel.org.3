Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826874E798A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbiCYQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbiCYQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:58:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54ABE5404
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:57:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qx21so16513444ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0UQKC4XvJrnNZ34RKfPyoVwW+Xt8hmyBlbU2fjx7Uo=;
        b=U5ErH/Ei9vW9Ct/h0mTTdFrb7CaghHjJJS5OTfWSWdJTV3Ot+ASAdDbdpM/EcdR4Ag
         J5CRH0gZcoZKlIuqUrJJoAw/UeW3+K+sWS6e8wI7OIXUnABHH0beilnzIVpeEWyBQ0Fb
         c8/+tq4frvVfZxsERqLsqIIJs9l9bzJ71+pyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0UQKC4XvJrnNZ34RKfPyoVwW+Xt8hmyBlbU2fjx7Uo=;
        b=yVoSi4T2XLqDPVZwNy7R7swVpRJIuRQ5Uw7HpKwuUmrVI6nNjqJBPp0t0aVYodFfgq
         uzsPLhxeSzcaroDMjF3hmcS18jq9A/cJQytX5XSwqYoeoWrFfqIGvnA1VN95h5fjFENp
         BaVCU/3/HKMzd8hPiPC3X8kWqmhqJ3bI+8PGcS51+pbAYrGaJof/1JnDBhDgqiKnJbtj
         m2ZTdvEn4WawuVAYV9YFDhg5co5VR9DPkctw/YNU1yzTLP8nVjAF9uTFMOwixuezI0Uh
         Fm6JtirQ9QN8rCcyVDb4+OMPBRcDoxU0W0wNgbYCG1S+IKrnyj9azMOG78NiwF8Vhtu4
         F3UQ==
X-Gm-Message-State: AOAM531JatCPBmMxvn8tVI5xy+M+ny86lkK5iqyB2X/aVJTRSg46P3ma
        pGLJ7hjQCYicPJGxGJHl3s0JI7mYpOVCv73TCJ/ilA==
X-Google-Smtp-Source: ABdhPJzE8ZUcHzwZw6+GoDoNNg8RDCTDtv3FC6NLZK33ZF4gcIZ3KTofKCH1VOR1LPjKYX66t6P3Iw==
X-Received: by 2002:a17:907:97cf:b0:6df:846f:ad0a with SMTP id js15-20020a17090797cf00b006df846fad0amr12888922ejc.286.1648227422054;
        Fri, 25 Mar 2022 09:57:02 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402004300b004162aa024c0sm3033970edu.76.2022.03.25.09.57.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:57:01 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id lr4so8134531ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:57:01 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr8597932lfs.27.1648226962360; Fri, 25
 Mar 2022 09:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <87zglefhxd.fsf@mpe.ellerman.id.au>
In-Reply-To: <87zglefhxd.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 09:49:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com>
Message-ID: <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        bigunclemax@gmail.com, cgel.zte@gmail.com, chenjingwen6@huawei.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Corentin Labbe <clabbe@baylibre.com>, danielhb413@gmail.com,
        Helge Deller <deller@gmx.de>, farosas@linux.ibm.com,
        ganeshgr@linux.ibm.com, Geoff Levand <geoff@infradead.org>,
        guozhengkui@vivo.com, haren@linux.ibm.com, hbathini@linux.ibm.com,
        hbh25y@gmail.com, Jakob Koschel <jakobkoschel@gmail.com>,
        jniethe5@gmail.com, Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>, kernel.noureddine@gmail.com,
        kjain@linux.ibm.com, ldufour@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        maddy@linux.ibm.com, mamatha4@linux.vnet.ibm.com,
        Miroslav Benes <mbenes@suse.cz>, mikey@neuling.org,
        Michal Suchanek <msuchanek@suse.de>, nathanl@linux.ibm.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>, oss@buserror.net,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Petr Mladek <pmladek@suse.com>, psampat@linux.ibm.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>, rmclure@linux.ibm.com,
        sachinp@linux.ibm.com, sourabhjain@linux.ibm.com,
        tobias@waldekranz.com, Thierry Reding <treding@nvidia.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, wangborong@cdjrlc.com,
        Wedson Almeida Filho <wedsonaf@google.com>,
        YueHaibing <yuehaibing@huawei.com>
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

On Fri, Mar 25, 2022 at 3:25 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Livepatch support for 32-bit is probably the standout new feature, otherwise mostly just
> lots of bits and pieces all over the board.

Heh. I would have expected 32-bit ppc to be entirely legacy by now, so
it's a bit surprising to see that being a standout feature.

That said:

> There's a series of commits cleaning up function descriptor handling,

For some reason I also thought that powerpc had actually moved away
from function descriptors, so I'm clearly not keeping up with the
times.

Anyway, unification in that odd area is all good. Pulled,

               Linus
