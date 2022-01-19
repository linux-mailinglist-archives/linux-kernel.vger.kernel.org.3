Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7390849404A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356968AbiASTFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356952AbiASTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:05:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F68C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:05:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so7616388wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DWOJ/x2qrYLClfcPkF95pUctzsp1LecGRHAyU49C+UA=;
        b=YK6o8hD5gFGRAp8tp4YVQydGmIMHSwCHo+EwL5lNkcog2WDKT/73n765xQdnecSYKf
         ydcDvZZpXdBNdRB7+pOXnWXKLQlEpPpd0H1TA+eR74v5jFUQGhWVRhaf5m/pzUflgLjq
         NVlH3Eea3+IZPtdPK/jGlMcE+c5LYQsjPOE0KrjIoUJc+r0i6d+dvsxQvgnTgbDsJnqs
         r5Yz47O5inARvd25H8B6EXPIOogkmFNtHCIFbUZwNf/xJoV1oinP8YZx7oKSspS0J3aW
         eFzytT/xM+nL7lUP2B3Rgsu7Iq/bc65yywCyb6xstCsG+TxXro4RZumdwsJpgEHgeN8q
         0+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DWOJ/x2qrYLClfcPkF95pUctzsp1LecGRHAyU49C+UA=;
        b=vfwC2O8NNAFdRHnzQ87Xnso+lskEjm+GV8KMaTSH/mQNO5cfeG5XlvG3cXtmMCPbJG
         ozmiPJdnJTcIQacg1z8mNj3Er7q/zZjaBnHviO3jpaQoN0FYkV5aRE8d53hOJg47S9nj
         qc1PmU4iyrclcnbMkUmNzBUSNppLcHvMY8dhlSyRQYFuPb38z1OsrfY7wK9FH5qGL405
         8xzm8hYLVSV573uSnwhfhe9AoMGM+DACA5xZM5BMH/xRZAGtqinbWQio+YJ0mtjb7veU
         RFEquN9FHFczgAZl581syagVuUDIg7D+AL3fcl5/nGoZYJAtCQi8kH76FVziphJSOV0v
         8B2Q==
X-Gm-Message-State: AOAM533VQXXAqWSb/0UvCoQbApWSDGTUVLiFFKV+RdotL4S/0weJ8cU5
        rp7A8Bwel9QZZ17jqPxTuZn0Tw==
X-Google-Smtp-Source: ABdhPJy7WMRSFCbTTVL097hhPPluIeFYXq1Tf/b63unQ25AnpQTFmG0xnV5NAe7lOXBhrq+T/8X9Sg==
X-Received: by 2002:a05:600c:4f8c:: with SMTP id n12mr4976974wmq.108.1642619114821;
        Wed, 19 Jan 2022 11:05:14 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id p4sm856793wrr.4.2022.01.19.11.05.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 11:05:14 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <87v8yg6lhf.fsf@igel.home>
Date:   Wed, 19 Jan 2022 19:05:13 +0000
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAAA7852-EBCA-47A3-B74E-A425023468C6@jrtc27.com>
References: <20220117154433.3124-1-changbin.du@gmail.com>
 <C2470F2D-9E45-49D7-A03B-E6A7BB4B9738@jrtc27.com> <87v8yg6lhf.fsf@igel.home>
To:     Andreas Schwab <schwab@linux-m68k.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2022, at 10:58, Andreas Schwab <schwab@linux-m68k.org> wrote:
>=20
> On Jan 17 2022, Jessica Clarke wrote:
>=20
>> Yes, this is a bug, that is always wrong. LLVM gets this right.
>=20
> Is that an ABI requirement?  In case of a leaf function, gcc saves the
> caller's frame pointer in the first slot, not the second (it doesn't
> save the return address).

Leaf functions by definition don=E2=80=99t have callees that are trying =
to read
their frame pointer so aren=E2=80=99t relevant here. The stack frame =
layout
isn=E2=80=99t specified by the ABI, only that the in-memory outgoing =
arguments
be at the bottom when calling other functions. However, GCC knows what
layout it uses, so it should be consistent and follow that layout for
walking back up frames. Especially for __builtin_frame_address(1), that
just pertains to the current function=E2=80=99s frame, which it clearly =
knows
without a doubt, so there=E2=80=99s no reason to get that wrong. =
Accessing
0(s0) is just straight up wrong, that=E2=80=99s accessing past the top =
of the
stack frame, which is never going to make any sense.

Jess

