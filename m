Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846485A327C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbiHZXS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345227AbiHZXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:18:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74560E9A95
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:18:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so5698787ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=a3WYMeaYaKAXqi2vNnTDqTlRNok0/Jvq98Wuc+dfeDo=;
        b=HEiGlMlGQUJaVg6lEvjGY+FKjsfHMo57rRYGePuvlcz/0r2RbwWl9AtQ0dGbw3JwQF
         3nm0V4DsSpmJ1F/Qb1N3WOegj48Mjuee1S0ycHZCQsGeThmAHohlwZ89qr/K5ZO79OUZ
         SfLgX1wpW84KIwtOyBasYRFkKxE4seAGCIO8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=a3WYMeaYaKAXqi2vNnTDqTlRNok0/Jvq98Wuc+dfeDo=;
        b=QN95ZQKlYqXkTsXShIhRTe3y2bTupMHRj5QOYBxruqAdO80GinrajIt3eRpUqxiwrY
         8JUOwSwwtTMLxmfyZ5aWOC17eWsPrXRDNbFYp/ZEWJuC9iqReTfdk6df5eqpTojY8SIm
         srhAV7EHBkcyVqDKRP4UnS/L+L7tl7GG+pzxexCuhXYeU1LMgdXFPcOsiOfNS0JImqJD
         aLw2pr68auSMPzlqb0O+Ke8oqnEfDKs9U6HkS7dTvNdHSJnhwF9nZDb8aP+9th9HiGpY
         7yvIDIqfo4O4CR1PKKRVg3TgZH1fzf00lWtqGZIr9ef/D0pd5oFtdhIiELcdfF8/Eiuc
         5fPg==
X-Gm-Message-State: ACgBeo2Tnu7VGQLGIifCHutBYhaUKakkAX2rhD90lSEZ3Fxu62UOdjUV
        AUyhVzGuIDe2csPouuSmjDXFKNRbB4shK6p8kcM=
X-Google-Smtp-Source: AA6agR7JYOtooa2Fyvn44kfW92bxb7MFeHBRrH0dhHrOYWj7L0z2VZ/oVCbShsW/+g8A1al24GlgPg==
X-Received: by 2002:a17:907:7fa1:b0:73d:8326:cd5 with SMTP id qk33-20020a1709077fa100b0073d83260cd5mr6507759ejc.522.1661555933663;
        Fri, 26 Aug 2022 16:18:53 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906328800b007414152ec4asm423556ejw.163.2022.08.26.16.18.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 16:18:52 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so4500594wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 16:18:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr923809wmq.154.1661555931704; Fri, 26
 Aug 2022 16:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
 <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
 <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
In-Reply-To: <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 16:18:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+vA+V_vYjC7gcy2mEJhwp6VB8u_RCizAF4rmH0TZb2A@mail.gmail.com>
Message-ID: <CAHk-=wi+vA+V_vYjC7gcy2mEJhwp6VB8u_RCizAF4rmH0TZb2A@mail.gmail.com>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
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

On Fri, Aug 26, 2022 at 4:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looks good to me, except I'd just do
>
> #define arch_test_bit_acquire arch_test_bit
>
> on hexagon rather than duplicate that function.

Oh, except you didn't quite duplicate it, you added the "memory"
clober to it to make sure it's ordered.

Which looks correct to me, even if the "almost entirely duplicated" is
a bit annoying.

                   Linus
