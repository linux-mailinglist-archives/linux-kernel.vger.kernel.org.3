Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF285627DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGAAw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiGAAwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:52:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D632A73E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:52:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r20so952438wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4H/JQv0YANN+hPh9ODN1ncO2/NlzH8kC6BmAsyJMU4=;
        b=HRDM8/nAthsEBmvQplb7AN4gKssujAuJE/5NiHh14+Xkr54gxCNvkyRz1MfG1eIb3x
         +0Nled6QMBbysJcew+8xPqUROz+4ZXRgEoX16pbfR9VwTxGWQGcDIABYUtEGzHoE1+RG
         aHyXGdYMLWduEj657qYTbdRAGPWRajqc9R4iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4H/JQv0YANN+hPh9ODN1ncO2/NlzH8kC6BmAsyJMU4=;
        b=N9hKXFySbKfjZqg0qTHiee6rH3jdZ0UPna53UHkr4fMh+wVJK+OtJJGawvTODcuj08
         x2STuCDTeNqabTlwzso+IwKEQ8JI8BPfpyv5RDdtot5/GbTNdPUCHXILmqGv9tPpr02h
         MKaVr4LzZbItcNJ9gIhW94kzYAoyi8BJRBii5lSTB5FjtIeDTxnH1oSmr0jiXHt99K6h
         3ow1QisH7jld3s7W05Hcjp8fBTKYR817OQhZLBN8H7z/YnQrDIL4tUJXV6/0K0IL1JGk
         3e4N2STRcMWuDIWYjq0Qu1oLsNrsoWMnF2W+u334x0pml3bHcbhaN7T4j3me8VX7hxf1
         /Bmw==
X-Gm-Message-State: AJIora9sB5ijxSDcBNXxhIjCMn/HesLLPlH+jCTjwPbNH+UQv7jwtMvW
        mq9uThrPppdmp2vVzPzMjNrQZYcBuPuB0WNS45Wm5g==
X-Google-Smtp-Source: AGRyM1vw0Tazaj/LQLdfeck4BvlftjKiz6E2rN+ufdkUb0NIAGAoskPo0hhCZWcWCYiMFk1y96uBMb+BE3NuOvIRb9k=
X-Received: by 2002:adf:fe81:0:b0:21a:3574:ec8e with SMTP id
 l1-20020adffe81000000b0021a3574ec8emr11089571wrr.410.1656636739432; Thu, 30
 Jun 2022 17:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org> <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
 <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org>
In-Reply-To: <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 30 Jun 2022 17:52:08 -0700
Message-ID: <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How the asymmetric SDRAMs report density? This is a field with
> fixed/enum values, so does it mean two-rank-asymmetric module has two
> registers, one per each rank and choice of register depends on chip select?

Yes, each rank has a completely separate set of mode registers.

> Manufacturer ID is taken from compatible. LPDDR3 has it deprecated.

Oh! Oh no, I only just saw that. I wish you had CCed us on that patch. :/

That really doesn't work for our use case, we can't generate a
specific compatible string for each part number. This may work when
your board is only using a single memory part and you can hardcode
that in the DTB blob bundled with the kernel, but we are trying to do
runtime identification between dozens of different parts on our
boards. The whole point of us wanting to add these bindings is that we
want to have the firmware inject the raw values it can read from mode
registers into the device tree (with just the compatible string
"jedec,lpddr3"), so that we can then delegate the task of matching
those values to part numbers to a userspace process. We don't want to
hardcode long tables for ID-to-string matching that have to be updated
all the time in our constrained firmware space.

Can we please revert that deprecation and at least keep the property
around as optional?
