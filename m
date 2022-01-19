Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D279494279
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 22:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiASV14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 16:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiASV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 16:27:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C92C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 13:27:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v123so7840470wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=avo5ZU/4d3ledcXQGjLRI4MWmFV84MWjZbdkjnrRnoY=;
        b=e/QtK09h7oRwdH2JjLU21Bb2qbBJ6UJx3ErH1DsCnFgFzwxUijwed1xnKX6P3A7pWR
         KiutQTn1w86uZ44H+uKBCoLUAKe5MBKumfnbNjWLOJHsHizoHzgGHaAV6P5tmuZZzxxX
         zDNs9eRHOJP699gDDVWOB83seqg1Ou4Cao2CkcHaHWfv/z9J45H9GeTW6RGOiDs+pFvY
         mo/wLCMUqmA/8iL8OZ8IC7QbvpjllhFkfS9hVoMjVQ3OR2oRU3y6ydyBZDhRJR04j6kM
         +8a3EorNwrGWVc93lY0X89VPw+uAqEHCeTPNfiJbPO4OgDOx2DUpRz0A6/Tolhv5eP+J
         tS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=avo5ZU/4d3ledcXQGjLRI4MWmFV84MWjZbdkjnrRnoY=;
        b=VTDvopUKl53PknUWZb7UmyvlE5/1kW+ROP6M5m3eJcw58BApgFQqGkcd6BT2lIC5/G
         kmn0DrNLIGFHwhrrbaHNePX5erflyPBRXAmvNG+aEMxoOMXAF9Vv/5kpL7W6aNWNxWB2
         qe0PJ0oPZWBhQZx5LBc/iIwwCBm3S87w2AxgFwLVvGJdN1RWy4eWVU3n1mFZetO5+FWC
         XPeTmU4yM4+bJTYgool8sZJRBJP5NSRi9g6xF9qloSUbxmAv0RGuWo38Ny3Bvv0xPzY6
         fALDs1QkkzGPrLBTPH7nRyePvvGxghUkfxguly+eoQtmU/H35bvaaFqzchrQDdxQvkaE
         1vdg==
X-Gm-Message-State: AOAM533SQ5JhqBhRVlbO+eCwqwnRynCqbspzJutljNEsDG5hRMgsQ8kp
        syuzYUDYKsgMW1ByY9InKxo4nQ==
X-Google-Smtp-Source: ABdhPJzworTR5h9GQNQh8lAHDMdibHymP81fW0QJeouN9jiuWORxb8k869VAtIbqoAvE0RArFAltQw==
X-Received: by 2002:adf:9dc5:: with SMTP id q5mr6205175wre.272.1642627667694;
        Wed, 19 Jan 2022 13:27:47 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id e16sm836300wrt.61.2022.01.19.13.27.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 13:27:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <87y23b5t9g.fsf@igel.home>
Date:   Wed, 19 Jan 2022 21:27:46 +0000
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD64D67C-613B-495E-9FB7-2AFB6FA15308@jrtc27.com>
References: <20220117154433.3124-1-changbin.du@gmail.com>
 <C2470F2D-9E45-49D7-A03B-E6A7BB4B9738@jrtc27.com> <87v8yg6lhf.fsf@igel.home>
 <AAAA7852-EBCA-47A3-B74E-A425023468C6@jrtc27.com> <8735lj78wu.fsf@igel.home>
 <8F8D535F-3637-4BC7-8853-B709EC5D14C9@jrtc27.com> <87y23b5t9g.fsf@igel.home>
To:     Andreas Schwab <schwab@linux-m68k.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2022, at 21:07, Andreas Schwab <schwab@linux-m68k.org> wrote:
>=20
> On Jan 19 2022, Jessica Clarke wrote:
>=20
>> My point is that the only thing that can possibly read the incoming
>> frame pointer of a leaf function is the leaf function itself, and =
since
>> it knows where it=E2=80=99s putting it then there is no ABI issue, it =
just
>> remembers where it put it and loads it from there.
>=20
> llvm sidesteps that issue by always saving ra when creating a frame,
> even in a leaf function, so it can use a constant offset.

What=E2=80=99s your point? That=E2=80=99s a correct implementation, just =
a simple one.
If it wanted to RISCVFrameLowering::spillCalleeSavedRegisters could
easily save that information, or recompute it when trying to load s0,
it just doesn=E2=80=99t because there=E2=80=99s no need. Also saving s0 =
alongside ra is
deliberate, it aids debugging when calling noreturn functions (e.g.
panic in an OS kernel). So yes, we avoid complexity in LLVM by not
doing things we don=E2=80=99t need to; there=E2=80=99s nothing wrong =
with that and it
doesn=E2=80=99t mean other toolchains that do need that to be correct =
should
just do something wrong.

Jess

