Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8369502E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbiDOR5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbiDOR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:56:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DEB55AE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:54:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so15040508lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8j6DQTUcAh42nRu9idTCLduRhccqwL4NXaCCnAwTthM=;
        b=oWPmvl9fxuCMQG9XsarKTzhaPQfBl2x8QDf38KEL0Khe362XcbTxH081PHmImLaGI4
         btjHzeqNsrERfoHY/Sup7Uo7pjj/VZpyEtDh8frqUyL+gkA5ny+kij8BMUD37DGzxzaq
         8QX3QLhCzDYG4UIRCE9OLzCtVN3uY1QUcaYlNbn2Y5MQULTMluhDPrsS3TScul5aQi2K
         xPyBCGDcAxf7fVqCLwHU43kAZSiiJgHyW3piL+revWNbM1kmdqthvdIjCfBIiS4d5eks
         PE2MksLBdRy8TAzh7FjucgX53K0uI+qbNU5yL37U1piKMkJQDPC1yhEhlGpulxf2cUDe
         InTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8j6DQTUcAh42nRu9idTCLduRhccqwL4NXaCCnAwTthM=;
        b=H+Yu/liyCPYwKzDy5qtv/PMjhNVYQC7rKRvcBDIUDtB3X0t3onJojF3zr9Kn+a8+Yv
         T3KRIV+92RGPi2FJX9GhRcaSeu1ifSGn1HHJOSoh33aYb5B7PmxIULSS9HtCLd9fCPDE
         3b1d8fV2asd7sKARvhO2taE0cDc3pEeWE+tUf2dEJ594XnsaS0IUnvdrc5cNX+FVEWFT
         W2GY29rToNWjYowgTaUxo9dcXFeYT6xSZOGwdr2ta2jhU8fn2pqtjJGOO3PW51FxgXrQ
         g6ogPe6a1SFV6tZ6tkTfxsrQMQv1Ily+ulftTDV57PK0B117PkCfHLJH9xIfiNEuF7pu
         84UQ==
X-Gm-Message-State: AOAM5322J5fVJU1TIxsUySeCJhOq+r77kMLc85j3+Fhiw8oIQehL/QBC
        QXtmpdY5nvvTWajiWvNKcRABlCnAgb4x8AA08j4coQ==
X-Google-Smtp-Source: ABdhPJyt3eudvFkY6pMoGXVCyEl0Gf3r1kJue9lHNus9xlzo/im5d5X5WrcDcT/khUq9Df5+fAFg+wYBBlomBOrPkqc=
X-Received: by 2002:a05:6512:b9e:b0:44a:10eb:9607 with SMTP id
 b30-20020a0565120b9e00b0044a10eb9607mr104526lfv.626.1650045267276; Fri, 15
 Apr 2022 10:54:27 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Apr 2022 10:54:15 -0700
Message-ID: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
Subject: plumbers session on profiling?
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>, vladimir.mesentzev@oracle.com
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>
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

Hi Sami, Bill, Jose, and Vladamir,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

Would you all be interested in leading a session discussing various
profiling related topics such as:
* gprofng
* PGO
* AutoFDO

Would others find such a discussion useful?
-- 
Thanks,
~Nick Desaulniers
