Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D04FFA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiDMPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiDMPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:42:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159141F8A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:40:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u19so2668770ljd.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgBA8s4Eh6rvde/t7B0/fiNRuz5n6J6jdeQ265aYyH8=;
        b=kpmOrV+KZsPfrkWLBVvU4FwmIyr5wmmpmnDQAUsPiQQOu16NkeZ2WtuBiM882G6/VU
         A6IyFgCWKc7DSGfE4MdQa1eczopD6TLLAIsjH4fnvhiIoRPkdVCl/92a4jVosMZOnVvb
         bTsEKLTuk/zR7e+Do+VVY0voHVMqBsnvtFViju+GZc0XutmNUncDv+N+pwW3K+ZZkA1Z
         y7SBT+/fdHZUPctOpOR/m1oD0SfcuBD7/N8kub9/clKXEeDyPGEouM3iu3OUJdnSmj1b
         U6oezOy5k6nJWprUM1vzUZp5ykPBOy7tUoN93D76aB2uqOFX6ldZbWpMm4ziIHaa2hdX
         JqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgBA8s4Eh6rvde/t7B0/fiNRuz5n6J6jdeQ265aYyH8=;
        b=Y5JEWuTduvvhBG5Dawv0qmx/xN1TOER30PCspbh6r+b6BuVYygi6E1AyWg8sgReiTK
         FhxbcKaPpwOvD0O+xIVLvLlwiWhu0LuUd8tzLCUKPKFqc7Vev5jPhp+kpyy6PeYK3VtB
         M9z5kPKDUKpGDMZUHXFRLRFeuNibDTu8hWXoDFXDr0CmbOADOYVqUTHD2EPEsBrR4cT6
         yRc2OiOWvK47+FYHOL+1hJ73pQeYOgTFlcWSr0gMypPzS4X/5vT6lLKW1KKxmHZVc3l6
         4N2pfB2SXT6qTtfdUcO19mAUtGJqKMcSc6rBQ65ZTcW0F12Hee5bWbA0pMo6qtm/mCfX
         41Hg==
X-Gm-Message-State: AOAM533ZOjTJAd/V65cvU6C9RbqYyGHmnQ16y4AzSKmRrDutgnZ0w1PY
        jqzCpFhIB2xbWHjak0UwwEpVRhrDasOlV0jwyDZa7A==
X-Google-Smtp-Source: ABdhPJxu82n1pQGboxGAUFIx7eeNpvAi4IMWEu1/u0r+gRGn56uFNSTXMnC3B4J/Y4WX0o0oIE2ZIbpRG7C0pPASMwM=
X-Received: by 2002:a2e:9017:0:b0:24b:6502:d63c with SMTP id
 h23-20020a2e9017000000b0024b6502d63cmr8831954ljg.426.1649864423326; Wed, 13
 Apr 2022 08:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220411180006.4187548-1-jackyli@google.com>
In-Reply-To: <20220411180006.4187548-1-jackyli@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 13 Apr 2022 09:40:12 -0600
Message-ID: <CAMkAt6rzVmi6iFM_phsCEtb1c-r2PYL9SYwSGX6JqWARnDWgWw@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp - Fix the INIT_EX data file open failure
To:     Jacky Li <jackyli@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:00 PM Jacky Li <jackyli@google.com> wrote:
>
> There are 2 common cases when INIT_EX data file might not be
> opened successfully and fail the sev initialization:
>
> 1. In user namespaces, normal user tasks (e.g. VMM) can change their
>    current->fs->root to point to arbitrary directories. While
>    init_ex_path is provided as a module param related to root file
>    system. Solution: use the root directory of init_task to avoid
>    accessing the wrong file.
>
> 2. Normal user tasks (e.g. VMM) don't have the privilege to access
>    the INIT_EX data file. Solution: open the file as root and
>    restore permissions immediately.
>
> Signed-off-by: Jacky Li <jackyli@google.com>

Reviewed-by: Peter Gonda <pgonda@google.com>

Agreed about the fixes tag.
