Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912BD494216
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiASUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiASUsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:48:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCACBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:48:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so684045wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VUx/FixPaEe6YT7F4YysqIz+YufT/bqww2Y78WeYZFs=;
        b=mDIxsahHNCOZMq2u6spiErkwTPbcHGPtRXj5dQGR5QmB0ZU56Z5BoDCoj6iItpBlpP
         JEf8jxKyVWUNnSHQQPp/RGtng9w0DuZWAIy34RvdVllTdACcMBuD7IMtFvR2XOxiwj1A
         OUvbAW/JQyzGfe/uxCb51JZL9WRfbnvJ0DPXIdjR5dey5yZtYGtPVcxGbHzNDGx7f0Tm
         L6nEnANQCuzEiaN5epZkXOHaiwT/mLdsO4qK5A2PF2DnrfcbNuAnVrWzlZe7T2NL1jZe
         bU1mWXESbAHBJcI7wjw+VaPQB7pgKQPfgZamh5otlqTcLIQw8nRGUsDNJRqTONOaWgpk
         TQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VUx/FixPaEe6YT7F4YysqIz+YufT/bqww2Y78WeYZFs=;
        b=phA+eoGiHdU9qWjaIjc2OHmSz1krG+GOImT2uzcey7ePzwQBBEgyqLyiM8am/RiSQO
         sz3/XQ8cqgqQnwKrDg5PXe8fsPyM7CXk58hlBj8wF+90y9lRqcCR6Byn5t9UCz96T0kz
         1hm1WU/mahpg0hbDwbe5oA9Qd9Bz+yfE72R0PwZ1SAjbAjfBpuZ1Wd6qCYUkru08SSkL
         Q9ZqcNB56FpO7UfNZhnHmN+3gEZExtiLW8vFk9u+DC6mv9TbARNjDfYIGek0VG+FCxUQ
         dnc6nheVMajL2YpXJ+9Rt7cHWM/7a09kU+eBAaS9eGAoi0iSi7J1M35JDv5kHCZl3ZZ+
         OdTg==
X-Gm-Message-State: AOAM530bKA49ISGFBMkZm6PAiv0TIef57fYKcrflv0+gVeUxzlrwq0uL
        Xt7+ycq6kt79LKxTrxWaSgju5g==
X-Google-Smtp-Source: ABdhPJxNQ7+g3Z8/6ZFolPPK7IHxtQZ8opBbkLpaHkG7DAXF52LD+FGIve4H0T+pKSZfKCmggxi1ew==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr5402464wmh.22.1642625329512;
        Wed, 19 Jan 2022 12:48:49 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id d11sm1134397wri.65.2022.01.19.12.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:48:49 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <8735lj78wu.fsf@igel.home>
Date:   Wed, 19 Jan 2022 20:48:48 +0000
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F8D535F-3637-4BC7-8853-B709EC5D14C9@jrtc27.com>
References: <20220117154433.3124-1-changbin.du@gmail.com>
 <C2470F2D-9E45-49D7-A03B-E6A7BB4B9738@jrtc27.com> <87v8yg6lhf.fsf@igel.home>
 <AAAA7852-EBCA-47A3-B74E-A425023468C6@jrtc27.com> <8735lj78wu.fsf@igel.home>
To:     Andreas Schwab <schwab@linux-m68k.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2022, at 20:44, Andreas Schwab <schwab@linux-m68k.org> wrote:
>=20
> On Jan 19 2022, Jessica Clarke wrote:
>=20
>> Leaf functions by definition don=E2=80=99t have callees that are =
trying to read
>> their frame pointer so aren=E2=80=99t relevant here.
>=20
> ??? __builtin_frame_address(1) is about the caller, not the callee.

My point is that the only thing that can possibly read the incoming
frame pointer of a leaf function is the leaf function itself, and since
it knows where it=E2=80=99s putting it then there is no ABI issue, it =
just
remembers where it put it and loads it from there. The issue of whether
it=E2=80=99s part of the ABI or not only arises when you=E2=80=99re =
trying to read the
incoming frame pointer from a caller, which by definition is not a leaf
function.

Jess

