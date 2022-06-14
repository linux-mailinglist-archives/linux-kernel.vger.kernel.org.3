Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D471054B41D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiFNPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350701AbiFNPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:01:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A3C41989
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:01:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v19so12062606edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODxKv9DXEzyXisW4L2tDdOPQuT/fUgqqrwiPKscw3fY=;
        b=dkRLuS0K2v319PcXm79Yz14PlggFsMt6Q4N5YFB5jl+SHs7stUFsx+coHokzgJJH3h
         299y17G/0dbEqff95oaV0FYeWPzppSBxZuXGaB+HZwvVQ6d2j7M+J8kroFyNVqQW0P7K
         AZy2aV48j43OARlj0tuXcNA05O42ayDB13CF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODxKv9DXEzyXisW4L2tDdOPQuT/fUgqqrwiPKscw3fY=;
        b=R/FBO4IA6Jh/V56WbfbKt4xxJ3zp3ynw0qwaG3N0pnsw/vFWbLxkp8+njItBTDkzOb
         7o/ZuajQO+OyQzrPKdEd1Hcmtn4QMzbAjKBoom9haTPl8eTz/rq/BtaWou8fC72jhRzs
         sMbe08+IbfV3zH+2oCvVdVzcCDl0rtYVL0s3w4gmYEbW/HOZ6QgM2286bS+HPgPQU0c/
         wjC0cwoio84PRd9XUH0KALz2w7l0sRFF1BSplBpIcUzX1kOeTAHvSmhG6SyJOxV17Ul8
         RYrS6lf3WiQLuN2TsGbxAN8sGJ0Y777QyGAJZiuV+Xh1vdKqwy2CQDGdyVlIiJNoVMx1
         KJtQ==
X-Gm-Message-State: AOAM533iU6U67FzbYo47GsPAICCw4Zn0hO4AguaxGAvDJ7HlQa1aedqL
        s9GSpgoLdG+8iwcLEE+gAnmKn2Mzgmm3sdRH
X-Google-Smtp-Source: ABdhPJxgC4cV08pDVzTZ3v2MT40BgrH5uFW1hOIEqGIK467RnBdUdVI04Jruf249NMw8cNHO5riESg==
X-Received: by 2002:a05:6402:2710:b0:42e:28c9:fa7 with SMTP id y16-20020a056402271000b0042e28c90fa7mr6699588edd.2.1655218900022;
        Tue, 14 Jun 2022 08:01:40 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id zj11-20020a170907338b00b006ff0fe78cb7sm5123879ejb.133.2022.06.14.08.01.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:01:39 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id o8so11684626wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:01:39 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr5170207wrq.97.1655218898671; Tue, 14
 Jun 2022 08:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220614083552.1559600-1-pbonzini@redhat.com> <YqihVgV1AHGJ1GKw@google.com>
In-Reply-To: <YqihVgV1AHGJ1GKw@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jun 2022 08:01:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZWxdfY3Ks7E_G0=8TmUyc0nnGGiBij_ARsk4JNZiQeQ@mail.gmail.com>
Message-ID: <CAHk-=whZWxdfY3Ks7E_G0=8TmUyc0nnGGiBij_ARsk4JNZiQeQ@mail.gmail.com>
Subject: Re: [GIT PULL] More KVM changes for Linux 5.19-rc3
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 7:55 AM Sean Christopherson <seanjc@google.com> wrote:
>
> This patch has a bug that breaks 32-bit builds, and undoubtedly does weird things
> for 64-bit builds.

Thanks, you caught me just as I was merging it.

I fixed it up in the merge itself.

                 Linus
