Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A453219F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiEXDhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiEXDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:37:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC74DFE4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:37:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so32670994ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yd71Rv+tVnuY+muzKaWvbV3tc5unX+qwJ1+3JmIpPjU=;
        b=eMFmyAB7yihZkrnGNaZ2Dxy1FDj6QVJhHppSroNTbRLwDs9BRmeWEeTTXbaN+y43X9
         o5sW5Y9GsjzOZyy3aw67NlkQhD+vmKJAoeSkujojaQOZVhP/qTlvmZAdoAksgaxdE9GV
         lLR1WjIV+ve3p99mzCAL9ixCf3/b53+DUupCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yd71Rv+tVnuY+muzKaWvbV3tc5unX+qwJ1+3JmIpPjU=;
        b=z4E7kAb6EXtj9xRK9bJj6lwMBHGpifHh+c6unXI1Pn4KolP4Ui6+NfKkjD+hUlrLqW
         W64go5DLBOxcjTLZokPDCmgsp8Zy6g1BquBfqYRLZSzd9z+17tILGUrlssejQgmELTq8
         7u2TIH3TruKolBVAj3o+OlGQhOuYqPgcy7+GG6YQ61D43IuZfH050HPbNLgYhhVue6ra
         +X2ZqqW3MMQBEXZVUwTwVAtuWF65QL1oTuBMNNbcPJBAtgXMjRFi6xV2R+G9VqAD2p+S
         ou2BqppfEW9x9DSUGAfyxxFGpEdU39qeMJhjWGCN5OVUJpNoIIi5ASY3Nkz43e3NXnOZ
         wJ6g==
X-Gm-Message-State: AOAM531UCnOdfQUT41xj0pkQf8Vk1iwja8u7Lkg2O6YvSEzSCYlhrffu
        iuTR0MRs0d8NTON1h3ONM/q6xvUEDCwqAA9KGaA=
X-Google-Smtp-Source: ABdhPJwmB2ynGWPl8lQv/mqCz1tHOf/Mt3/9F+n/Tvu6A7kV9rZ2TWhgQiv98jJFb1cYzYLo+DglPg==
X-Received: by 2002:a17:906:9749:b0:6f5:6cd:5bd9 with SMTP id o9-20020a170906974900b006f506cd5bd9mr23434373ejy.523.1653363421585;
        Mon, 23 May 2022 20:37:01 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id cq3-20020a056402220300b0042617ba63c2sm9003054edb.76.2022.05.23.20.37.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 20:37:00 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id c9-20020a7bc009000000b0039750ec5774so621332wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:37:00 -0700 (PDT)
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id
 m17-20020a7bcb91000000b0039732250244mr1803290wmi.68.1653363420446; Mon, 23
 May 2022 20:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <e9abfba4-d178-7ee5-da13-4cd9e07ba331@intel.com>
In-Reply-To: <e9abfba4-d178-7ee5-da13-4cd9e07ba331@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 20:36:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKem5Q6y2Ye+M8176mvmkRELBzrDUSZNvTea7RR-CD7A@mail.gmail.com>
Message-ID: <CAHk-=wjKem5Q6y2Ye+M8176mvmkRELBzrDUSZNvTea7RR-CD7A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/sgx for v5.19
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, May 23, 2022 at 10:23 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> It's my first pull request, signing tags and all that jazz.  I hope I didn't
> botch anything too badly.

Looks all fine to me,

                Linus
