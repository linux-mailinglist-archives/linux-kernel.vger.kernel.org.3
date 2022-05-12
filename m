Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022452554F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357840AbiELTBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355699AbiELTBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:01:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E84C406
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:01:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so12010956eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pszSDfe0UbNgZW4RxKcUIgfomIDDQRx5VP5T7VUEGIM=;
        b=VQA5v8vqLahAK/ejzfmgUBIfDmleeuUyWizNuLo7eork68u0Kdo0mLk2LagPzvdFwu
         bPCS9pMREZcOLfpyQDK34HFBotdepKvHzCsAOrES5gBMNoFMkdTjhNWo3ROXCx8UIc6v
         BCV6hXpLKsRMRyhsT3mtXAL6JctiOwVyu0Mtk+yNpYb9O3TLaydg6GrpNp6If5JZq/2u
         rssY3r/WK4mSLTJQ7j7QHbvFf/6tkQnm06XpMa68d3wW/OykknmCFx3ve/RcoC7VmZQo
         aMmeuLlc6VWJC+vLFjNH6JHeTvcDMOyWHEaZB5+wgl5AgyD4B4DGg2VFzVrGtKgI1+lS
         OgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pszSDfe0UbNgZW4RxKcUIgfomIDDQRx5VP5T7VUEGIM=;
        b=LjdLwU/m2TLA3KQ5gPNP1QJmu1Ginau3R9zK4iUDZNyiKeOkbvqNDwQqN/qWUzDF2k
         1BLQNFzqkJOVIWC+6S14XY/qNkXmdOyHc7Sg7AouCWF3Eiju80inP9HofxQ38j9XvhSF
         WQt9xlLt+b6xe9xbTfwJJl4SzmZ1FcRmxg9e6Plsn5i1aoxyEoCyBGxLiMEJckpELBZT
         ofkQ6i08CDMSZb/1RQ1zE229PfjekXfvVjDPU2bkDSX+rEg7eL/eQ+EXkbXwed+7tHoX
         /sBOB9v46z2j2xMm6vGvWT2+8wCYmdNFEfR0x4pgb1pSpi1ovBPuLp3Vy0d0gHltAWRs
         O6DA==
X-Gm-Message-State: AOAM530vJQeH6nW0Uhu2hAINqPmMSpeicn1i5Ex9DEont13dboG2KfW4
        Bfg68ajsft3bO9i/Q+Ad4T0ZaKMX2CQT8OscXGWzN+dUoqw2GuDP
X-Google-Smtp-Source: ABdhPJwemMtr42pU2bJn8Gbt0kVxmOlvLYjum2OQe6Gv6T1/qdj76xgaaBMFoVVLZwHNnlZ+i3CiOANGsUxi8Hhu0qQ=
X-Received: by 2002:a17:907:8a24:b0:6f4:82c9:9adc with SMTP id
 sc36-20020a1709078a2400b006f482c99adcmr1202252ejc.223.1652382092846; Thu, 12
 May 2022 12:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-5-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-5-ojeda@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 15:01:21 -0400
Message-ID: <CAFd5g47skTReYjQDHdv=V52+E-1odLsTJMn6E3GV7N7mYia=bA@mail.gmail.com>
Subject: Re: [PATCH v6 04/23] kunit: take `kunit_assert` as `const`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Sat, May 7, 2022 at 1:26 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> The `kunit_do_failed_assertion` function passes its
> `struct kunit_assert` argument to `kunit_fail`. This one,
> in turn, calls its `format` field passing the assert again
> as a `const` pointer.
>
> Therefore, the whole chain may be made `const`.
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
