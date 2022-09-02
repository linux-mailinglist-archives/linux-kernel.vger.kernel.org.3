Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354C85AB6C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiIBQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiIBQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:44:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C5F72E0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:44:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kk26so4952372ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VmUnMpMx9FCpdgOfRQX0qdDo5Ev0z9Y827Nqgg69gqA=;
        b=C9WaGds13KebfDZBCKtuewhv6eHNZKasIwrABJm8q88TgSSillzYLfRXxuIkeWJ+EE
         ATXb5NU2GQZXcTPBfK0lU7BTe8a0OK1fE8MMAFockFtrlxQjFA7bjr1tHm+FWl1M0jfB
         bsQB3zJpW2YyG0sGyLHuO2fvRrTjl9vsriR8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VmUnMpMx9FCpdgOfRQX0qdDo5Ev0z9Y827Nqgg69gqA=;
        b=HqX9V2cxctlZ58d+nBg1Chl5zXOXQ8gd32z0eEq3spS7Wb+3ZoyJkUQjICiwr0f3Fz
         6s2RrB4KZ6JinaRI66cGIFBh3RFWcbNo1HHkpOS9pzqpU/okNHCoTEeprTge/0cZunAO
         Q/Ks5o30dKa/6iN0O0Y5cO59d9AsE3qHsKllxUVk8AI+dhJplyt3IlYmYxWvB2jYrv2G
         Kwev4dvSSXjMWulKGhPRWo3e129Crr8aoF7GMdHCnuU7GIDFnnUoRuqrHMjzom1RnrWb
         M78GoA+lC4lS8deekCHWfGd5M6xRHIdyecOfExeSIrRd39E6Hl9qZok6m7de+oTtp4Dt
         86wA==
X-Gm-Message-State: ACgBeo0bYQC0cbwF1suGj6b5Ph/Pzt0citZIAHeu5nGrZrC6ma7uLnh2
        cmCfnQjUHG02aVz9Nw2t5F/tMeTTidh7fjD/
X-Google-Smtp-Source: AA6agR481b+7l4ai4nfWxuekmNFsH8/bGVLtLNz8GWpPRz6BkxmLl7uCtU92GhHPDxiVK7DalTxYJg==
X-Received: by 2002:a17:907:9693:b0:73d:cc84:deb with SMTP id hd19-20020a170907969300b0073dcc840debmr27666238ejc.552.1662137043405;
        Fri, 02 Sep 2022 09:44:03 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709067f9100b0073a62f3b447sm1508351ejr.44.2022.09.02.09.44.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:44:02 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id c7so3000483wrp.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:44:02 -0700 (PDT)
X-Received: by 2002:a5d:4052:0:b0:225:8b55:67fd with SMTP id
 w18-20020a5d4052000000b002258b5567fdmr17701419wrp.281.1662137041789; Fri, 02
 Sep 2022 09:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130950.205726504@infradead.org>
In-Reply-To: <20220902130950.205726504@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Sep 2022 09:43:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
Message-ID: <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
Subject: Re: [PATCH v2 37/59] x86/putuser: Provide room for padding
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
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

So I don't hate this patch and it's probably good for consistency, but
I really think that the retbleed tracking could perhaps be improved to
let this be all unnecessary.

The whole return stack depth counting is already not 100% exact, and I
think we could just make the rule be that we don't track leaf
functions.

Why? It's just a off-by-one in the already not exact tracking. And -
perhaps equally importantly - leaf functions are very very common
dynamically, and I suspect it's trivial to see them.

Yes, yes, you could make objtool even smarter and actually do some
kind of function flow graph thing (and I think some people were
talking about that with the whole ret counting long long ago), but the
leaf function thing is the really simple low-hanging fruit case of
that.

            Linus
