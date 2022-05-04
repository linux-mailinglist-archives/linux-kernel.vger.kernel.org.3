Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3851AD00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377015AbiEDSjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376989AbiEDSjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:39:39 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017115837
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:32:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e189so2030113oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65qkexODXFqidEs+0JxzFuC9AWtFII/iXZ/G5z0aLFA=;
        b=pmy4b5BdwF5P0xy1c6YQkSK9RZEc7k6jqmxKwQM5QVcv4HvuygB6hXFJXUjKTGyApv
         51RKL/y6n2mg2BlVELLf6GHyBeN3734UIHtn8KOYShwg/wBH+2gZL4Ez94APSxZVChAg
         WCDhKYyQ046imtjMYGWv/dgW9ncuBq10xVLaHhA7oumDkmO6aYUx9tgQ5FeFW+QIMv6K
         xIXLo2aJdX/xOWZBgplgCR58ApNdEydSEvDVFXMBltgsoLWR+He6PVpL/h1tZ8x3ThcO
         uAjI78jU3ts2fn7mr9beCVqQkMg8+DOG8QHp4KDOArNWroVhLCazBh9gMndGwVSqgGiN
         5syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65qkexODXFqidEs+0JxzFuC9AWtFII/iXZ/G5z0aLFA=;
        b=Vwn/qbdFltisd8Mi5yNyrZUFoNj6utyNWAot+vqHiWUfrBiuwcC7C1bZD099H1N7gp
         TdcPewlusI60RYUEvjVf4fOxqSBsnZ5X98j357PFijAdJI5apIBvxldgZ7wOkRe52Q7N
         39su8zaQ6zG76/uzCRLL2GhuH6x4/Rsfbj30lBpAaDrcN+a+cHvMHDgYko+27vBo26z5
         G2D7oOmr6GT9lUaCJadGGSLcHQLoXgXnECkeUiCTsb/JxJ1wqENqcltKt1wuPz2s9tCH
         QTnuKABtek/BCMx8q+3a8UB/fQtmg/am6v0DbqACC1xVrZ1s/HuP8cEwmDi3BgX0tdF1
         Ujig==
X-Gm-Message-State: AOAM532PkN2m4WFb7LPqXR8HaXRhVErT9KrhjpY9Mea2k4v0Jcyx89Tz
        hVbFU8LwGo3jhrmLaus7q81VOIspOfblZVw4A0ob7w==
X-Google-Smtp-Source: ABdhPJwL5H8DpOf06AYB4JVxtydmEfrTSCJx1VjV/OLy8Vc1ROWpY4ICRTPPZlPPmbhLIc8rk56WEI8yilKJg0U1lXc=
X-Received: by 2002:a05:6808:577:b0:325:8089:eb8b with SMTP id
 j23-20020a056808057700b003258089eb8bmr417081oig.126.1651689157543; Wed, 04
 May 2022 11:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220504001153.119485-1-sj@kernel.org> <20220504182908.1322874-1-yuanchu@google.com>
In-Reply-To: <20220504182908.1322874-1-yuanchu@google.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Wed, 4 May 2022 11:32:26 -0700
Message-ID: <CAJj2-QE4ee=N9wYXVQc6gyZYC3zgAsWVwWJ7DMaS2B9q2WqBHw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi SeongJae,

Instead of adding the exception to the Makefile, these two pragmas can
be added to the offending c file instead. Although it is fairly minor and
either one works but I think this is cleaner.

Thanks,
Yuanchu
