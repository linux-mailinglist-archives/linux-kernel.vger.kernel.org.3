Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3504C0D49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiBWH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiBWH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:27:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8E34B42B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:27:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h17-20020a17090acf1100b001bc68ecce4aso1374744pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=BldfynokRvz62dncg11oZ7YrMf1Z9QulmMKUgm0rknI=;
        b=oLqTQWu8eBOzIncRd8bffVRrc8raq3YWp/3phT2VVSApiYhiV/wSCdPD0YVKrieBO0
         rlhchBD51iCEl0cb3jIOmq7Op6xB+xfb1DMkyIdtPMRKWolFbyqSqMpZ2gtX07ayOb6m
         USwMjlFPiSo8Lg3AcDz/UcP/Y47s1zs8s68hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=BldfynokRvz62dncg11oZ7YrMf1Z9QulmMKUgm0rknI=;
        b=DdrGpByh+JsI+YodrinPR4AfcT/VnqjXeaG34vRz6RxHuIXsb17uTWx7GFAyEYHKRl
         RydEPnCuKwX5NfJLzxS8gWjoEeQ2hGCEN8uGLaSfnCnOs8kMF3Kbp7FnTx6+LywFFg1I
         MW30Pcb4Oti2wc0hIY4QTRMrmaaAuiySmqvcnzcNp8J1SSkJx9Gvl+Zr5iFrvAacWAWA
         5YjUBQCh63bIyCvwVGmJWUsENbri0XbE4dazvUOxTzh2bgSPrChO7qwie/fmiIhFZPDF
         UkZG77SKBcMwit+ODfRN2VYxTL/SvgZW+3PzJPef4iHOr3PgH8sldJKjAmxQ8xWpgSFs
         ByHw==
X-Gm-Message-State: AOAM532rbe/BvJ+mcZmUu9JLIQuPbpKPD1Ob85UJi/LpRcGZRXtxc3K8
        eDRLTgyiU0VErDJvz3v7sRts7yK24mODaQ==
X-Google-Smtp-Source: ABdhPJwSY7K/P28Ehgrxp6ET1uXysp4H8bvCgWAmyUlwacRRpGhkz5Z/w6OY6pEZV9E7cromW61JDg==
X-Received: by 2002:a17:902:758c:b0:14f:c842:eaf6 with SMTP id j12-20020a170902758c00b0014fc842eaf6mr10319475pll.152.1645601221209;
        Tue, 22 Feb 2022 23:27:01 -0800 (PST)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t2sm19910096pfj.211.2022.02.22.23.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:27:00 -0800 (PST)
Date:   Tue, 22 Feb 2022 23:26:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 00/29] x86: Kernel IBT
User-Agent: K-9 Mail for Android
In-Reply-To: <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
References: <20220218164902.008644515@infradead.org> <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
Message-ID: <420C3057-8359-4303-9E25-0C25FAB9203B@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2022-02-18 at 17:49 +0100, Peter Zijlstra wrote:
> This is an (almost!) complete Kernel IBT implementation=2E=20

BTW, I've successfully tested this on what /proc/cpuinfo calls an "11th Ge=
n Intel(R) Core(TM) i7-1165G7 @ 2=2E80GHz" (in a Lenovo "Yoga 7 15ITL5")=2E=
 Normal laptop-y things all seem happy and it correctly blows up on a new L=
KDTM test I'll send out tomorrow=2E

So, even though the series is young and has some TODOs still:

Tested-by: Kees Cook <keescook@chromium=2Eorg>

One thought: should there be a note in dmesg about it being active? The on=
ly way to see it is finding "ibt" in cpuinfo=2E=2E=2E

-Kees

--=20
Kees Cook
