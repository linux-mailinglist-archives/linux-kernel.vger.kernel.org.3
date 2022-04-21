Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F55450ABD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442043AbiDUXNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392628AbiDUXNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:13:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471E49CAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:10:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f5so7520003ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k9JybJT2MUROhf8pXoPS8XkN0ZGy3V7ewjH68Jql+aU=;
        b=VhYyTtKdaoYxY+fMOA+egYbT4WrtkmFjY76dbsxzRSWoHTG/cSVc24ZCYgchDZSOz1
         MsijtCP0I6WMYg7UTTPiFMnRrpN5SQ+bpWkwoVvUM6FEDJ0ZxJlNVJS9Vyyk5H+kkyqH
         buc9rlIV/CBil6cdYtZs910FWMSW20lCdOP2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k9JybJT2MUROhf8pXoPS8XkN0ZGy3V7ewjH68Jql+aU=;
        b=3UuqAPtWzEhastRFjQ1fxMhEDICTMXYKV3dx9JAKiASl4umhL5ak/JbTRAUInaXaLC
         KnvHE+IRFPt/p25sphkuY1Ws6NOkGnXdkEGjEpsvcex0OcAD/+7hrtDk18YhjaT/qDBj
         tdKGImJASLw2UMQie6BJaaS7sj/Qr42bxUnCGVIWrodtruNv0rnQwDuHU/G+oyCHUlv/
         2HdOaPD8Yp7YSkuxkt7UlhPQ4++qwiaE9Qlo8a6O4nqQkQMoNRT+wuvY/RbdN94z5LI0
         xkp+FeUMgneklmc9iv0TC0wM2wX48XYa4d+gHORgUFqW5krlJgiFkIoC6jYlHO0+mSmG
         /V1w==
X-Gm-Message-State: AOAM532g4xgtejxU5s9E0+LUbYF7OH2wMCijNFj2oVtmnIyqHRsUj2C2
        VT1EGexIhoo94WLJNt2ijX2yI0tUMKRL3gxSxPk=
X-Google-Smtp-Source: ABdhPJybGX/Cn+jRW+qXsGAh9PY5ShrmBa0nSs1O6shdCgiSYkhCZclCoMi3oIKC4LU/weYRHQsptQ==
X-Received: by 2002:a2e:7e04:0:b0:24d:abc8:5b16 with SMTP id z4-20020a2e7e04000000b0024dabc85b16mr1112433ljc.390.1650582627321;
        Thu, 21 Apr 2022 16:10:27 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l3-20020a194943000000b0046b928d2795sm39586lfj.67.2022.04.21.16.10.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 16:10:24 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h3so6556289lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:10:23 -0700 (PDT)
X-Received: by 2002:a05:6512:108b:b0:470:90b9:fb51 with SMTP id
 j11-20020a056512108b00b0047090b9fb51mr1151040lfg.52.1650582623375; Thu, 21
 Apr 2022 16:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
 <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com> <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
 <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
In-Reply-To: <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 16:10:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW2vxREeH0Bgr8hGxVavfRsNAX3cyaS9eCcg9A77zhLw@mail.gmail.com>
Message-ID: <CAHk-=wgW2vxREeH0Bgr8hGxVavfRsNAX3cyaS9eCcg9A77zhLw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 3:52 PM Song Liu <songliubraving@fb.com> wrote:
>
> I think this won=E2=80=99t work, as set_memory_ro makes all the aliases o=
f
> these pages read only.

Argh. I thought we only did that for the whole memory type thing
(history: nasty machine checks possible on some hardware if you mix
memory types for the same physical page with virtual mappings), but if
we do it for RO too, then yeah.

It's sad to use that horrid machinery for basically non-live code, but
whatever.

                  Linus
