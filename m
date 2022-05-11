Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD2523A30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbiEKQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245354AbiEKQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:20:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E02380E1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:20:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c12so3162252edv.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svG1L/bGhyxGAlocPxyHJusAcsDTJHaGb4g7JRnLN34=;
        b=SLYn3yafpxhPinrhVN+KvALYpBdGm6IPDJeU17IYRguThw4zYzuAUMO+wgE8mES8b4
         TAvhOMEIzlAjl54FO2fajRhHHQdSYqfX00mqyItYDD3jbYNbNda6kImAMtKkUrF3hSa2
         naE7anfld7oOW69AFhZbUG91usyzFIculkTzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svG1L/bGhyxGAlocPxyHJusAcsDTJHaGb4g7JRnLN34=;
        b=s8/yt0btqjDdEbNiduYuQr8zl6jivpfaM7o8AXcHvS9EmNyVyIt9RaxB3Snk7b9suh
         GpLQlX2UcXQ4BaPAV0XH4gQOPG1xzn6QiWr40MaS24M8yz36PUy8sjoHeuxOMXH+1q0t
         hj5DU9NA1AFpfKPhvsBEGowS6ORVJDzblJ1iPJ9ECXwyAfxelH55vpeViZ/degtu6UYq
         Q1zE3H9707PFlO9TzCRxo8g/KvnAFHODlFg8VNDdF6cM+zoCKZXcYw5r3ET8ngaUXl0B
         RNBX3Zya+V8AuqmXtteSI8pMOKU23HWjYyv1J5uqPYrVbxCrWGF+geY6adhM80SpTr5n
         akNA==
X-Gm-Message-State: AOAM530fWrButcPqdL4UiQVh2kOTR9aQGp7Yu0H+YuzZUKBH/glX+yjL
        wxe1rdn/9Tz7g5MntJs+7Co9F4ox00lSqwUQb8Y=
X-Google-Smtp-Source: ABdhPJyS9h9LYgYn2gzBJ52tP8MmEKJiuLvmNWxpgF8Yeb64i80ef92yAzZkupfb5hW7224W/MSnmg==
X-Received: by 2002:aa7:c318:0:b0:426:4aae:de6d with SMTP id l24-20020aa7c318000000b004264aaede6dmr29696132edq.208.1652286021976;
        Wed, 11 May 2022 09:20:21 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id s4-20020a056402164400b0042617ba637bsm1389066edx.5.2022.05.11.09.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:20:20 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id u3so3733729wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:20:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2c2:b0:20c:7329:7c10 with SMTP id
 o2-20020a05600002c200b0020c73297c10mr23431402wry.193.1652286020296; Wed, 11
 May 2022 09:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com> <87czgk8jjo.fsf@mpe.ellerman.id.au>
In-Reply-To: <87czgk8jjo.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 May 2022 09:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
Message-ID: <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: last minute fixup
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mie@igel.co.jp
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 3:12 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Which I read as you endorsing Link: tags :)

I absolutely adore "Link:" tags. They've been great.

But they've been great for links that are *usedful*.

They are wonderful when they link to the original problem.

They are *really* wonderful when they link to some long discussion
about how to solve the problem.

They are completely useless when they link to "this is the patch
submission of the SAME DAMN PATCH THAT THE COMMIT IS".

See the difference?

The two first links add actual new information.

That last link adds absolutely nothing. It's a link to the same email
that was just applied.

                   Linus
