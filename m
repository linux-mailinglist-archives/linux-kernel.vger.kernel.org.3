Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E04C944D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiCATcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiCATcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:32:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A6F69CFA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:31:32 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v28so23214533ljv.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 11:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBCWb7PwbT43VGHxFqcKndIr9KxLErVmYKG+r9qe67A=;
        b=f89A2pypRpCoKxJg+cX6HSFQZ2dRsjtqJGJCHwDCo/XiFoXB+LtkLg5nOUSLTR7Zlo
         eU+bGhmL2KmRlodVlqD6+ODrBfKQi7i3b2vylG4PKun7taOdLlkSbD39LAvUPRJ43APt
         TWn29lEYeNWRPtm0JolOXmvAqWcF+Dr7e0y1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBCWb7PwbT43VGHxFqcKndIr9KxLErVmYKG+r9qe67A=;
        b=F+7YykuewhUzJdURBRJtUrU4U2HfX1HQtFHFfMNOTQz+hO2DXnDfhfu9w5QpoajG+q
         5jvajRHCFmw04RHUCfpT6Zv9pjn61KEPjNRlo/8mIz8s2JfhTY8fz31bsaA4KjCgeh/+
         4tti+yE1rz1B5RqgaFQUsQyxmfoFT7708sOO+lDyVeMApXXOImE/5FPKgRZG9yIaJuYk
         nuPQ97Ipa6oekqGXzuEltprHQGriYB7i4oZdQoKlIM9kyBMPwY0VGpaVOJZQSf2fa0EB
         AOkr8H3dX+IFHhY4FOtsMjq3uPs3di1ly6b94/aMBgmrf5SIQu/fK+Gd48kQTQsG2B7O
         0NLQ==
X-Gm-Message-State: AOAM532Msh96h3xjkozU6YlG1WCpsUbLAsZ19saam8P6YkGps2IGPYfR
        uiUelA2JwKWkAw1jgC6NuEaR6ckUB3P/IZ83MWk=
X-Google-Smtp-Source: ABdhPJw2CAhWz6BcPAenT3HTy5wX2oHY2SEnh0cUi2UxTOiED31mlIYVKDYyLpSzB0lmaTS6g75b3w==
X-Received: by 2002:a2e:2e0d:0:b0:246:2b96:b003 with SMTP id u13-20020a2e2e0d000000b002462b96b003mr18300211lju.465.1646163090617;
        Tue, 01 Mar 2022 11:31:30 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b00443cd5b013fsm1633577lfo.244.2022.03.01.11.31.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 11:31:29 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id j7so28617986lfu.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 11:31:29 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr16542590lfb.687.1646163089338; Tue, 01
 Mar 2022 11:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20220301130815.151511-1-pbonzini@redhat.com>
In-Reply-To: <20220301130815.151511-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 11:31:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1LV8MoSNXQE9kiaFSUHdyMhLpAiQ0JW=JGZKmrORQ4Q@mail.gmail.com>
Message-ID: <CAHk-=wg1LV8MoSNXQE9kiaFSUHdyMhLpAiQ0JW=JGZKmrORQ4Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 5.17-rc7
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Mar 1, 2022 at 5:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
> The following changes [..] are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

Nope. Not there.

When I do a 'git ls-remote' on that thing, the 'for-linus' tag still
points to your previous pull request from last week.

Forgot to push?

              Linus
