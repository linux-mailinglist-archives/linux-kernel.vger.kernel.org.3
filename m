Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF45A2E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbiHZScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiHZSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:32:37 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8321DE3977;
        Fri, 26 Aug 2022 11:32:34 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11e9a7135easo596060fac.6;
        Fri, 26 Aug 2022 11:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fJ/8Ppmhz2rOgqo1WRAkAwO2X5ZqhRIREXlDqJL8Pas=;
        b=0B+pafSEg9i0qfBBgqq6txxOetF+tVdyMio+xmO163WoeF4TpD1+SgcDf/tQ9WkrpU
         KHgpOSzZfcxgISp6l6J+QoIKtzHqdwuhnhtZmcku9Q6iBfUKF34TuCqZW3hHbz+ktYcX
         BahYgL1zEyPm5W+vd6hJ99rSOJ4vKumn9SGHKYdRWZt0BW1Htk9XUSzWzgt3cacljqpz
         Bkgg5K4vv36feNSXwdPtFVJ/NPstWkbPR8nx1J/JX20bAbpeqYptpFKaJeW5vJ20dlI4
         4bK9Ztwm29CrgbxAIS4h3bVPrjqeCqxUKMl+QcBgBWreAiAuJyetZgTvTdGNIQUoCPym
         nfJg==
X-Gm-Message-State: ACgBeo1yMyivBwiqfp18xCpT4/1Hw4ntH03j4EfGuhoLT461ML2ddT0l
        RkCmUV7XA2yUHdKGvZzSuDK4FgAeqMvZ+eYXWcQ=
X-Google-Smtp-Source: AA6agR4WfanpQSFAHlsJ2gTSPjnKZ0xCn0qXF2r1Krud3tJ12s4bgt22/0hlIMmsjXvmHpIKXhkYGI7YyM9aOl6/kfc=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr2490201oab.92.1661538753637; Fri, 26
 Aug 2022 11:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABwm_eTnARC1GwMD-JF176k8WXU1Z0+H190mvXn61yr369qt6g@mail.gmail.com>
 <YwfYyLE3ajSFVHGQ@kernel.org> <CABwm_eSvcnygceTU0sNXLkBFaNfEfrThFVmwH=TS4hN=HVGrGg@mail.gmail.com>
In-Reply-To: <CABwm_eSvcnygceTU0sNXLkBFaNfEfrThFVmwH=TS4hN=HVGrGg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 11:32:22 -0700
Message-ID: <CAM9d7cjsbhHnaAiHSBb6qAfH0bNgdKrBHdg16esRCt+4DPmvtQ@mail.gmail.com>
Subject: Re: [PATCH] perf/genelf: Switch deprecated openssl MD5_* functions to
 new EVP API
To:     Zixuan Tan <tanzixuan.me@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Aug 26, 2022 at 10:22 AM Zixuan Tan <tanzixuan.me@gmail.com> wrote:
>
> On Fri, Aug 26, 2022 at 4:17 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Fri, Aug 26, 2022 at 01:00:58AM +0800, Zixuan Tan escreveu:
> > > Switch to the flavored EVP API like in test-libcrypto.c, and remove the
> > > bad gcc #pragma.
> > >
> > > Inspired-By: 5b245985a6de ("tools build: Switch to new openssl API for
> > > test-libcrypto")
> >
> > How did you test the end result? Can you please describe step by step?
> >
> > Also please consider adding a 'perf test' entry to make sure this
> > doesn't regress.
>
> Sorry but I don't get what you mean, what results do I need to test?
>
> These EVP_* APIs are just replacements for the deprecated MD5_* APIs in
> openssl v3 [1][2]. With the same input, they produce the same MD5 digest.
>
> And this patch just does the migration work for the upgrade and does not
> change the logic of the code. so...what should I test?

Yeah, I understand that this merely changes the MD5 APIs.
While it's good to have a test case for the genelf code, I don't think
it belongs to this patch.  So,

Acked-by: Namhyung Kim <namhyung@kernel.org>


>
> Links:
> [1] https://www.openssl.org/docs/man3.0/man3/MD5.html
> [2] https://stackoverflow.com/questions/69806220/advice-needed-for-migration-of-low-level-openssl-api-to-high-level-openssl-apis
