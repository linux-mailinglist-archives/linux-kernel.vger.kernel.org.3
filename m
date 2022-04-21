Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D8509477
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383436AbiDUAfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 20:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383428AbiDUAfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 20:35:14 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D132C19001
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:32:26 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o18so2230963qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INPtuxJX22cS5P5/4/bkkKQpHzU+PTHXyMFJSOykm7k=;
        b=aPXcCM79WKRijXcj0HsaHrJgwNLhMvtTZC6vzwz4uPNpVBSEPeR3Yz7tLfAnqrcX6s
         O03tSsEF7z9+mYdMPa22T+/1bQj29whTjQTkrbmu9kqs0A46sAH44rS+WVHsg4lUnK4z
         nzS1GpO7LdaLq9HK2f648EtofABul7Yd1Scl46IypIKIfzXMZ5MfqF6dTtd6L8oh912h
         zHXEVmFoVcNHeQ+z/YkonQ4B0JMt4LiHG5yxmK+sSv33xH0S3ynnwNZI6ErB4fcxVC/K
         sXR7OiOzL+8OKDNeU0O1WON9ptxO1Cr3bP5kuC8NVTLokIx2ruFEe287Xedm3TpEiDBF
         61Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INPtuxJX22cS5P5/4/bkkKQpHzU+PTHXyMFJSOykm7k=;
        b=Wxek+75jdhaXJwp/8bwCgg6dYL6EMm183x2PCrbsiVLYD1l9HCNgwFq2Z7P2PPQVEV
         lVwb24YjtbCZuzHpjoo74lE77+tounGafG8LO+KOwKZRTnmVGJrzx3InMsU4c4olRIcM
         b+eGhHx+MJzyieMe/K5zvE08mgR3MfSDSmocqWr2jQuvvxtugBpsOvRtYQW1SOjx4USb
         b6B89yabmNuSFKezASQXrMk5kRDgI6PKFFsdHlbHp3Bfr6J3Nvff1YK07P6rSKvV8jhU
         eaV8WBFMRutdFboJ3DOfeUcLAIk/KtRYTxa1XFva7AeA8wMQ00tNXP7TSo5pJp7YQiW7
         bT/A==
X-Gm-Message-State: AOAM532D+YwD6zxrmCc3fr+bnKVRq3icwxspflJKhFkPZfrtnoJOG7mq
        /Sou0EJIzeFnKCcJmIwAz54mubeeU7XOQcuX8l74jA==
X-Google-Smtp-Source: ABdhPJxAGelvXh6pH3XeMdNwrpZBQSULChzyTenEOImaceS5SnpT4QCkMs+yXS1raMUddYHVtzD0uHb64bff0RApOZw=
X-Received: by 2002:ac8:5d8a:0:b0:2e2:f0f:4308 with SMTP id
 d10-20020ac85d8a000000b002e20f0f4308mr15944627qtx.618.1650501146059; Wed, 20
 Apr 2022 17:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220420235659.830155EC021C@us226.sjc.aristanetworks.com> <CANn89iJjwV2gAKMc4iydUt_MqtnB-4_EKdVrqQO9q4Dt17Lf9w@mail.gmail.com>
In-Reply-To: <CANn89iJjwV2gAKMc4iydUt_MqtnB-4_EKdVrqQO9q4Dt17Lf9w@mail.gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Wed, 20 Apr 2022 17:32:15 -0700
Message-ID: <CA+HUmGiGE9sp3fyfobU6kx73-4zKx=i3KeBHqcCyiru3Z+3jrQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: md5: incorrect tcp_header_len for incoming connections
To:     Eric Dumazet <edumazet@google.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 5:20 PM Eric Dumazet <edumazet@google.com> wrote:
> On Wed, Apr 20, 2022 at 4:57 PM Francesco Ruggeri <fruggeri@arista.com> wrote:
> This seems like a day-0 bug, right ?
>
> Do you agree on adding
>
> Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
>
> Thanks.
>
I also think it is a day-0 bug. Should I resubmit with "Fixes:" ?
