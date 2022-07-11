Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5757570E67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiGKXmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:42:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66852BB0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:42:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 145so6060358pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bnCCYKAlf34Sg+kmgPicgrgZwDCBCN/6mpuu/tveLZM=;
        b=NhZD35R2jIr/+pYFJV8v2G/1ZJ1lzWKeOYsAFk5nls8vHDm+aveo/Vs/h2dhm/vTtv
         dAlbaYqDQetlCTPzg1+VnNLFB//09zQr2r20Eb6AkNt238rJUinl1qEknwPzYgv8O/VS
         io5+F30aaVeGXT5Smo2pvRYP3iEpk2sjys90gKeCxM6uzqBe+dNAwhsiJCo6q081dq3T
         3pEpPXUtAXYwcRNDg7FgfD0MFb+4EkVZVs64wp8xz/POtYT+j0p4NWvmlimRY8CAOv3d
         yvdoYQU3/16iyGb82RGJoUt2ewSyxyXofVw6tmguG5aXWRwEJhTTfQNgYXW8lemtulJg
         Jmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bnCCYKAlf34Sg+kmgPicgrgZwDCBCN/6mpuu/tveLZM=;
        b=fNBFJu0WVDBhpCc8RmGuJogcHS3NwD42wY3+LHJe9/Xr6N1ohdOk7Sfhdpb4GR00jz
         XbJIyyFBjS+N9S7fa55s8cN/c/u9wdmuVySKFAw0DpSD/5Iny4fj17mM4aSUMibUyJQn
         g1HmdyXJi/2leK4elJTmpqu+/aaMW5VYCX83j2T8eaWM9rVUHt0A48U0Z8oCnDt4tC4P
         NIh4ifZfhWs8IIsvLF/y7/q8vdxtPT+b1ptyroMzo7YpgQvouZpqgFQfRIKDUeLZ5f3W
         7SGJNpYP+VZ74BQR2idCn1j/tqnptb6Njka2/tmQd8Y2/QSNJS6JlZXLCreOMK1gurTK
         p80A==
X-Gm-Message-State: AJIora+sBCYIGp4c9JFZvmHpkHgXOugiy1fe7cK5KLn4NWg+zdrN0rUS
        ffRhc4gROtz0Us2wPyNxw68=
X-Google-Smtp-Source: AGRyM1uxlynBlGQZ3VNm7BbLV8JfjadXXhdpuTpcbhsXX6wz70fzlJlnbv/oZuUT6NcPDhSuneTC3Q==
X-Received: by 2002:a63:4c61:0:b0:416:1e62:953c with SMTP id m33-20020a634c61000000b004161e62953cmr3219575pgl.24.1657582936007;
        Mon, 11 Jul 2022 16:42:16 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090a115000b001efff0a4ca4sm5331457pje.51.2022.07.11.16.42.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 16:42:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] x86/mm/tlb: Skip tracing when flush is not done
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1c58c7e1-2c21-e0d2-34c7-252074ecc70d@kernel.org>
Date:   Mon, 11 Jul 2022 16:42:14 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <798B000F-043A-4C5A-82C0-D7CF1BCDEDE1@gmail.com>
References: <20220710233355.4066-1-namit@vmware.com>
 <1c58c7e1-2c21-e0d2-34c7-252074ecc70d@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 11, 2022, at 3:50 PM, Andy Lutomirski <luto@kernel.org> wrote:

> On 7/10/22 16:33, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> Currently, if flush_tlb_func() does not flush for some reason, the
>> tracing of the flush will be done only in certain cases, depending on
>> the reason of the flush. Be consistent and just do not trace in all
>> cases when the flush was eventually not done.
>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>=20
>=20
> Can you remove this comment, too?
>=20
>>  	/* Tracing is done in a unified manner to reduce the code size =
*/

Yes. I will send v2.

=E2=80=A6 And if you have time, can you please review the other TLB =
patch that I
sent? It is a really urgent one.

Thanks,
Nadav

