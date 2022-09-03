Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC15AC004
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiICR1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiICR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:27:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E556BB1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 10:27:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb36so9442366ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6Zew9P4ZCPse5+99+pbN99tpIeaKYGurGm8E2KQ/Iqc=;
        b=cLoOMXVEzLAYI6/u/OLVdw/Cd5F6Ag28KB2pq2gZzugt2NlOgYAFEH+4THRyDfciWk
         WUh9eLW5+O/oVLjJn36zqO0hZp5iQlIc1ZMBBAL9xg7AGgTx0jGH/R4cSWVPM8mDR9gY
         R+Krqcgfx0+ZnW3d/8AWDjpCgyBNhnjUMmHhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6Zew9P4ZCPse5+99+pbN99tpIeaKYGurGm8E2KQ/Iqc=;
        b=e24Zj1ux5N4C0aB1BE9yTc9uSeaH+L6aT/+JP0jSk3YkfloG6Zc0lWHuedx5WBKZ2+
         asBDoq8gav4Eh2US84q7FpnSvlBrQsgF5dWlwpBRPKdCWR7tmSfClsgkzlxXxLu56Lzk
         5xUoSr96UoxkDjRHeMy9DGQdLXQHgUGWoHrR1KKLlNBHcYlPGdjPsm2qIXqAeligqyIs
         KLwBn+93fCKx8Y9neU8dPMvG+OOp/liqhUA2Mjs5UFnm53r1hon9x25I5LtOh0aBSqW1
         7gvXp1TIRu8nHOMPWYbvvfqYEqGgsVhNk8CyIlPhYwqpJFalKjpEO8wJzeGZJFu2Z4Rg
         Iwew==
X-Gm-Message-State: ACgBeo0nNiIuAj2NqrQJkOsjXGY3t8XPJ2gL2lVQRsK4adOMUa1oCE+L
        geuVxzeWAy79yxZoc0+4jSu6xk1pWzGP9A0Ycxk=
X-Google-Smtp-Source: AA6agR55w9rsnxxJ9AU1Y7V7W43fOpiMcDvrjtvZe7/JTIO6gEuOJpj4JIatgZqAg4Oy3q30nuMZiQ==
X-Received: by 2002:a17:906:c154:b0:733:197:a8c with SMTP id dp20-20020a170906c15400b0073301970a8cmr31222281ejc.483.1662226023582;
        Sat, 03 Sep 2022 10:27:03 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709064cd100b0073d678f50bfsm2706764ejt.164.2022.09.03.10.27.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:27:02 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id n17so6032135wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 10:27:01 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr19318106wri.442.1662226021197; Sat, 03
 Sep 2022 10:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130950.205726504@infradead.org>
 <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
 <YxI3Zf5drSHAkBL3@hirez.programming.kicks-ass.net> <YxJmdG9Ug7euJdZS@hirez.programming.kicks-ass.net>
 <CAHk-=wj-njE+DwycFcVQ=ouXZpgKU2rjG3G0keNXSFWa_etrEA@mail.gmail.com>
In-Reply-To: <CAHk-=wj-njE+DwycFcVQ=ouXZpgKU2rjG3G0keNXSFWa_etrEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Sep 2022 10:26:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbunYr933WanyFxjp_WkT-NWNtSE6pt5A9Jq9_DjymEw@mail.gmail.com>
Message-ID: <CAHk-=whbunYr933WanyFxjp_WkT-NWNtSE6pt5A9Jq9_DjymEw@mail.gmail.com>
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

On Fri, Sep 2, 2022 at 2:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. It doesn't look too horrible, but yeah, fi it still ends up
> getting the same padding overhead I'm not sure it ends up really
> mattering.

Oh, and I think it's buggy anyway.

If there are any tail-calls to a leaf function, the tracking now gets
out of whack. So it's no longer a "don't bother counting the last
level", now it ends up being a "count got off by one".

Oh well.

             Linus
