Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D49509342
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383035AbiDTXCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiDTXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:02:16 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25B167E8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:59:29 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2eafabbc80aso34345097b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jt59HgPlqQAbr+xBdeeNro2Km6rxUizJSG+/mwm8z3E=;
        b=blu42izeVLIH3FXNDbCVq2ndCMOVQ9SJ3WJyJSkxXProNxLuAorEcr6LwjjxidBT28
         DNGQFJzQFTs8mj5YFTVd46sGALbKQpOcBk3gbbOLkuR6Skd07v+hntehB/ckdG9uIiFv
         eCRCsczYN95hr72PjOZghvAtC0Fr0HPUyj1hK//r/ls7j+YdOWY5F93ROpmBgZpbi4/2
         bPTWbjPuFCvb22O/OCSX2DfwQ3pjxakpKM4LgNptWSlo/C3wF37pRXHstsipHuNC7TeQ
         rNf29nyc882QymgvmJP5EHYso1pymKG1TpOMF2SspxrlcvCPsQ5gsCd8gxFtmHpRscOA
         8Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jt59HgPlqQAbr+xBdeeNro2Km6rxUizJSG+/mwm8z3E=;
        b=Zl/Byix0DygVU0AUAk7kZSpq00rVRrEyC2PaBanLRbxEfdtgew9dfrY80XuhgcCOZ1
         4keNMLLiCAkTltaUvYJQ+NXu1GLd3ZfDijUPuNvy1n1oQqohQo7Infph0aWhz+Dn6k1a
         yVzKEe2VrEObReOPgMmJHFrfmvo8l8tAP80xO+K1mOBAKrXOE1uhQJuSa0r05zePLk4I
         vKx4eaNH7vI4LX1dU2uuUscotuNIuZ0oJBMUQc0GkUNTZFOj7eAF2XOQWFaEGP5jviAy
         B8WmnW4ozv3h1ZccCN1FSRqOiWtPN1mFYrAE1ZuNH+aE6o3Jmvpy7u7IzOjlsIVVpqiC
         4A3A==
X-Gm-Message-State: AOAM5334lEx7Tjrgzwg/lsavtZRsvdOCYqCk1dinQ6a0K2Ztj14pqy6l
        7BbeG553cFqdxTOfCpzwO638YyCeZKfN3/yp0jx7aA==
X-Google-Smtp-Source: ABdhPJyn2wybiF1pnlECeltJsdd/1vPuT3IiA7a4+EHW/h3tOZ429Z0M6li8MuC966gZ+LHB7Urlzp/VJJx7WC6Dk9o=
X-Received: by 2002:a81:1cd5:0:b0:2f4:c3fc:2174 with SMTP id
 c204-20020a811cd5000000b002f4c3fc2174mr4041623ywc.512.1650495567045; Wed, 20
 Apr 2022 15:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220416081355.2155050-1-jcmvbkbc@gmail.com> <CANpmjNNW0kLf2Ou6i_dNeRLO=Qrru4bOEfJ=be=Dfig4wnQ67g@mail.gmail.com>
 <CAMo8BfJM0JHqh8Nz3LuK7Ccu7WB1Cup0mX+RYvO1yft_K4hyLQ@mail.gmail.com>
 <Yl/Mh4gjG1hYW2nA@elver.google.com> <CAMo8BfLANCoLa4zXO4aYmX0Wk7fV7_wei04MveLHu=d2RDZ77w@mail.gmail.com>
In-Reply-To: <CAMo8BfLANCoLa4zXO4aYmX0Wk7fV7_wei04MveLHu=d2RDZ77w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 Apr 2022 00:58:50 +0200
Message-ID: <CANpmjNO1WDCgv_cPVMKe3G31Kwqtbg__QqpsotkkVFY-5U2y6A@mail.gmail.com>
Subject: Re: [PATCH] xtensa: enable KCSAN
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 at 20:11, Max Filippov <jcmvbkbc@gmail.com> wrote:

> > Each test case is run with varying number of threads - am I correctly
> > inferring that out of all test cases, usually only one such run failed,
> > and runs with different number of threads (of the same test case)
> > succeeded?
>
> For most of the failures -- yes.
> For the test_missing_barrier and test_atomic_builtins_missing_barrier
> on the hardware it was the opposite: only one subtest succeeded while
> all others failed. Does it mean that the xtensa memory model is
> insufficiently weak?

No - KCSAN's weak memory modeling and detection of missing barriers
doesn't care what the HW does, it only approximates the LKMM. If the
test_barrier_nothreads case passed, there's nothing wrong with barrier
instrumentation. Regarding the test case failures, if at least 1
passed I'm guessing it's just flaky (not enough concurrency, or
unexpected barriers due to too many interrupts which can happen if we
enter the scheduler).

Unfortunately I don't know xtensa and if this is normal, but modulo
flakiness, I think it's fine. (I've made a note to try and deflake the
test if I can find time to try the xtensa version.)
