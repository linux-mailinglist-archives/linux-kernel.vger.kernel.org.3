Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B0525350
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356919AbiELRMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356930AbiELRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:11:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F115727FD7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:10:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bv19so11524982ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loonHWmCtVeGx4aWVVUzPzapZ1t+QIqGsKXmCgmw6z8=;
        b=WD5qjD3n7PQ6Q1+OHYaSBYIXZyE3MSnd14hOsae1gMnqzXVow2TJFjREwN777Ig52q
         V4qfULfCcQ86ni9aAhSi7LjMQHCPkFJi+glv65R1S+sQR6oFUNEhVyq5JADGgBm6h1kT
         2hznSR7F9VZ12haH7nWz1Ev8hTm8abuX+I6D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loonHWmCtVeGx4aWVVUzPzapZ1t+QIqGsKXmCgmw6z8=;
        b=fB21s0bz0sorJAx4QzsaITGMVTsVzPYWIo3BwbmRIjs8i/gM3pm0+k7VE3i8VO4+20
         DSWiLsAWjdqcSWA+yaMq0KsP+AAddUfoWdWXnRw0jcyB604EpTfylc6vO6nE+jyDMRRu
         rtUqhGf+Wp3BZm7igDvfFR+M6dg0BihkDtqif3Fa3I1d/ZknI5azujoPyfE2gZ27XANv
         6kCHyXobeFJK/88Tqvy0Wfb+6qYWd9gafy5noQunOqYiQowLbtJwTItoLPRvhKhkbPO+
         OLRykOPGcYpu0Xana8ddSPSJ55M0tkd3KHZ725a5cYJ4jHVDireogMheGoXcgno57I1S
         Tcnw==
X-Gm-Message-State: AOAM531RDlwWEHU8u0aO+th2kW3Aa6YfGuIKvqT95EhWys7sANMHCTwF
        THAeU9ZE+QrFEUrJMpfzkZwfnnzrm/OGZcz5HpA=
X-Google-Smtp-Source: ABdhPJxDN6Hwhpo+ubYFdrhDW/6nWDfS/q/cQEARq7g11BvGA9uxioGKI5LNxvmbneDAucdR+OsBnQ==
X-Received: by 2002:a17:907:2159:b0:6f3:a307:d01d with SMTP id rk25-20020a170907215900b006f3a307d01dmr803565ejb.760.1652375454338;
        Thu, 12 May 2022 10:10:54 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id eg56-20020a05640228b800b00427ae00972dsm2892281edb.12.2022.05.12.10.10.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:10:52 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id d5so8169531wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:10:51 -0700 (PDT)
X-Received: by 2002:a05:6000:2c2:b0:20c:7329:7c10 with SMTP id
 o2-20020a05600002c200b0020c73297c10mr557896wry.193.1652375451235; Thu, 12 May
 2022 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <87czgk8jjo.fsf@mpe.ellerman.id.au> <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
 <87mtfm7uag.fsf@mpe.ellerman.id.au>
In-Reply-To: <87mtfm7uag.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 May 2022 10:10:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
Message-ID: <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 6:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Links to other random places don't serve that function.

What "function"?

This is my argument. Those Link: things need to have a *reason*.

Saying "they are a change ID" is not a reason. That's just a random
word-salad. You need to have an active reason that you can explain,
not just say "look, I want to add a message ID to every commit".

Here's the thing. There's a difference between "data" and "information".

We should add information to the commits, not random data.

And most definitely not just random data that can be trivially
auto-generated after-the-fact.

                Linus
