Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747B85692CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiGFToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiGFTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:44:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F6FDFE7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:44:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n8so20603645eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKmMBf94dqxoTjWi2eeMymoq1+LEzz8Mcbmk6X430xs=;
        b=QPubt1JaNqnaKlW47bNlowu/ISfn+jldi2xTy+EQoJxWPeFKU1fXtIqSlnaQ8geZHU
         MyvpCrrdhsuyiSBK+8oQiezGplmIzd1ibjpsPY7r1nTUJDsIiNTYLER5QwE1NLeFpA19
         iIrvQWcpJT0nLE+z508HT85iQwzfr5pljAOsy8D3idure2AMS1yrkyPmGOnTiRJnbR6y
         vfsitWxWiyV9kh0Z2Y/7UcBx17U28/UW7p9TCdRqChlAdRXvP9StjGp8cyWAWpSj1e8/
         ew2J8IUH9SX1FwlSZno2E428zLDu8QV6+yZB/5ZGOSQUFVF0oD3aERzIAc8AfrqM2KlO
         3h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKmMBf94dqxoTjWi2eeMymoq1+LEzz8Mcbmk6X430xs=;
        b=Nad6tzOscSW4lEjV7M3liZu9lvkdjVEp06UJ3CYTvWCOc7wYIhq1KQNQz4V4C581W/
         pYDR7mwxMHov2poFncJV4mCnuRXd/RFMCJd+ykye1avjRk9gTidoy3NcdEXCt6r0F6r/
         57NDil7az0y6x1hCeUrjhKnkzk5Gpu0iRr12ByjjPhxMCgMCMJFEjWT4Ol2iP05T/Fd1
         pZWJX6HIkWf3YXMq2vyYo/uR4Kh0A4n9eAPD0KHpmnAOre3JNT7sh2qdFRPhOHdlg3Zk
         9IVJNfJwgdMoKLUbeZqVu4n2yMmsk3rtJefIQQoiFipyJXSMmE3p1sfHnCDQ4sIMbwC1
         aqoQ==
X-Gm-Message-State: AJIora+A+3mRiGDL1nhjeYP7Qj+JoB1U64KHQpkTaPESXx8DaIIQ3YSB
        jzGH3bdOA8SM+vdaLrQZfY0hrTiLHfTkMwi6V+qgWA==
X-Google-Smtp-Source: AGRyM1tge25mCnt5shj9Yd6ABquNh8Ngrj9+FG84cVXYuPEcBT7yP71dGJsOKb6Fute1Sq/P9W4rWnjLnVhHKaJMjtI=
X-Received: by 2002:a05:6402:43c4:b0:43a:6309:6c9b with SMTP id
 p4-20020a05640243c400b0043a63096c9bmr22725476edc.91.1657136689614; Wed, 06
 Jul 2022 12:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com>
In-Reply-To: <20220518073232.526443-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:44:38 -0400
Message-ID: <CAFd5g44i2rQf8KVPc00bZzMx5zPtjoxesqyTd1aawVc10-0kyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 18, 2022 at 3:32 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add a new QEMU config for kunit_tool, x86_64-smp, which provides an
> 8-cpu SMP setup. No other kunit_tool configurations provide an SMP
> setup, so this is the best bet for testing things like KCSAN, which
> require a multicore/multi-cpu system.
>
> The choice of 8 CPUs is pretty arbitrary: it's enough to get tests like
> KCSAN to run with a nontrivial number of worker threads, while still
> working relatively quickly on older machines.
>
> Signed-off-by: David Gow <davidgow@google.com>

I know there is some discussion on this patch, but I think this patch
is good as implemented; we could always delete this config if we
change our policies later.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
