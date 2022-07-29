Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE68584FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiG2Lf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiG2Lfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:35:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D21DA65;
        Fri, 29 Jul 2022 04:35:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n185so2405219wmn.4;
        Fri, 29 Jul 2022 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=8gIozcoZFyuu9QfHBCL93y2nGRfLWqgwqwh/+psKNsQ=;
        b=ATLsXrHCkKzXWbd3RHEp81pkVdQ8CRtUqJ48NakBZpyOKycENFImrZwTOtiu4PJnX8
         V3tCfIA9R9x+exATIbut0uEqnbe9Ss3Zn6peP/j9nqkOSl8AaSdURKlv0qMP5cBXtV0P
         WZHDpUOg9DFGUC0yFigvXn952Rl5Zwy+uE3dyWXiyfEP3FI7vwSJxm/ZezJ0nNTyh0Hz
         /jSywgxe/hRbFoa9P9UL07AfVBLT9s0sa5+8sUDhSeLXVZHbSh8T9SMkOdeCFRgTxf93
         U+/vr7WNmJ+aL0wcW6iAkWX51HPefZ8PbSdUgAHvI7E/hQ0XVnufxnlkhDQkYFlsUU94
         48RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=8gIozcoZFyuu9QfHBCL93y2nGRfLWqgwqwh/+psKNsQ=;
        b=vILRy7KvFdXwZBZmHE3WUZvccnu84PGExlWceP3H4kTgsry4F1cZibpAoG/DQNi7fW
         iiWewH/NwEo8gV1CxuyHTnjQ03dG/iNKIhByuhRgDjzl2gC8xscBArxFZ5CF049kaeJv
         wC/rax+N6FhEvZcBLXPVzqnWPleH7kpqgiVucvzNGW/qMPY1uu0n0S8itQAde80gRDq0
         q9cXBM9muCMUl2AvcIuBDwfRBAWWobMfr3NoyR5s/tdc9PfFrqaVWq/2UAqSS6zJib1k
         qVoXWawtDBHMYZiXvC8KZbVPMnE9kVV+XoNzlHteGDuCgl/O3wcwM9OxILjayJ4yKRDi
         YehQ==
X-Gm-Message-State: AJIora+HsTH+mDnrfAjoaAumOAVCn5Zm95yyf2fakiv7qDjfCIV7YuMc
        fojGQJL6VqCBS03xprDpaS4=
X-Google-Smtp-Source: AGRyM1vdSla2IX3ll4UwbyvY1wMFHsGYiSCEUmPalF6rShKnzceGTxboyPlfuepWxuhzJlAwcwRTiQ==
X-Received: by 2002:a05:600c:4313:b0:3a3:2c86:9b5c with SMTP id p19-20020a05600c431300b003a32c869b5cmr2226842wme.65.1659094550550;
        Fri, 29 Jul 2022 04:35:50 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id v62-20020a1cac41000000b003a31f1edfa7sm8456053wme.41.2022.07.29.04.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 04:35:50 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 29 Jul 2022 13:35:48 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 0/6] Corrections to cpu map event encoding
Message-ID: <YuPGFNZNF+hAGWOa@krava>
References: <20220614143353.1559597-1-irogers@google.com>
 <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
 <CAP-5=fVyyj4nwam3grTAw94w8Ad+qZP6LDxYZv17vP2ph6pXwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVyyj4nwam3grTAw94w8Ad+qZP6LDxYZv17vP2ph6pXwA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 07:01:09PM -0700, Ian Rogers wrote:
> On Fri, Jul 15, 2022 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > A mask encoding of a cpu map is laid out as:
> > >   u16 nr
> > >   u16 long_size
> > >   unsigned long mask[];
> > > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > > after long_size. This means 32-bit and 64-bit builds see the mask as
> > > being at different offsets. On top of this the structure is in the byte
> > > data[] encoded as:
> > >   u16 type
> > >   char data[]
> > > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > > is offset by 2. Consequently the long reads and writes are causing
> > > undefined behavior as the alignment is broken.
> > >
> > > These changes do minor clean up with const, visibility of functions
> > > and using the constant time max function. It then adds 32 and 64-bit
> > > mask encoding variants, packed to match current alignment. Taking the
> > > address of a packed struct leads to unaligned data, so function
> > > arguments are altered to be passed the packed struct. To compact the
> > > mask encoding further and drop the padding, the 4-byte variant is
> > > preferred. Finally a new range encoding is added, that reduces the
> > > size of the common case of a range of CPUs to a single u64.
> > >
> > > On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> > > 0x9a98 [0x28]: event: 74
> > > .
> > > . ... raw event: size 40 bytes
> > > .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> > > .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> > > .  0020:  00 00 00 00 00 00 00 00                          ........
> > >
> > > 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
> > >
> > > Using the 4-byte encoding it is:
> > > 0x9a98@pipe [0x20]: event: 74
> > > .
> > > . ... raw event: size 32 bytes
> > > .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> > > .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
> > >
> > > 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
> > >
> > > Finally, with the range encoding it is:
> > > 0x9ab8@pipe [0x10]: event: 74
> > > .
> > > . ... raw event: size 16 bytes
> > > .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
> > >
> > > 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
> > >
> > > v2. Fixes a bug in the size computation of the update header
> > >     introduced by the last patch (Add range data encoding) and caught
> > >     by address sanitizer.
> > >
> > > Ian Rogers (6):
> > >   perf cpumap: Const map for max
> > >   perf cpumap: Synthetic events and const/static
> > >   perf cpumap: Compute mask size in constant time
> > >   perf cpumap: Fix alignment for masks in event encoding
> > >   perf events: Prefer union over variable length array
> > >   perf cpumap: Add range data encoding
> >
> > Ping. There was some feedback on this change but nothing to create a
> > v3. Feedback/acked-by/reviewed-by appreciated.
> 
> Ping. Feedback appreciated.

hi,
there's some unanswered feedback:
https://lore.kernel.org/linux-perf-users/YrwY3SP+jsTwrRBw@krava/

jirka
