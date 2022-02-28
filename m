Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938954C6D18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiB1Mre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbiB1MrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:47:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8548976E01
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id bd1so10587144plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qwzeJF2B6Di3rDERG8soz+b1Ps+s3Pm44BHmxxR7QCY=;
        b=qtbGBSdD/gQ1lKhk5tZ6TUn/GBPJmKrm1MxIxIzCPIGJqN+39MNgxuN9sqFmhVKrzr
         z291TCh81mpJult+1IktilWv0MmSSu6aapiTKrWFWGGSdPKbd346r3t7VNgjlXPUea5p
         OBZAa47+FhUnEKuD8YGJN8pD4xKnXuZ0O685ncSMMID8t2cv6lbOcX7GU//AhRb3eq1G
         HmMcE/Cy+kaNqMXQwLG6CnCPxUSixb4NiST+caV9tF9LlaEYfTlr5fH2vDrVSIeL7q8s
         KiOohITDLb4tu0K4yFNhLziuSdflP9d3VU9MDDhyBk5zcFUtIDQMAa1IJObVt02DR+71
         gJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qwzeJF2B6Di3rDERG8soz+b1Ps+s3Pm44BHmxxR7QCY=;
        b=ZV6n8kOG1RlZFtF5OcU4t8CQCzKQpERKAwKFB/vThwDRG/XLpO9OiMrSWqFSxGAK45
         3g1tpuX8w6SaJhwJLdzNBf+H3iD+u8WYCBMPDCeYZE7ZUa8h15pyxqCQtwH6hrmhYKaO
         STDlUqM8xjkYyxMPvFnKu/kI6P3s5cMqFWmQ65TPxjf9vfUlO8vjHlZWLEDcH//YNnWh
         nfGgIeYlh9KMxkvnI3Kl6UFJj8tm9wF8OdgKRJFy0LXpT2Tl1ZXArC6ZwW7I0+Rexhq+
         acR444M9/Lfy17aM7ywLANll513rpqhswy74IVXWtd1r1JQqCdiW9p9UqR1g1sycICYQ
         l+Ag==
X-Gm-Message-State: AOAM530t9vDhVyW40RxCilHplMmIeGjklsq0mMJkpPTrb/f1mNkKpx3y
        HI/fLkSE7Z4DSdsYFlmamv0YgHUzzuS1dsVVmD0ApHwJUzU=
X-Google-Smtp-Source: ABdhPJyPl3dOQnPhGsi+4kZmEEqOlf28gc2APwLdJ138ZzdPOZ2ylsXazmS2xgNZ0Ss/gw0ULba1JMbNNCHB4ifv7ck=
X-Received: by 2002:a17:90a:ca16:b0:1bc:16a7:e840 with SMTP id
 x22-20020a17090aca1600b001bc16a7e840mr16442697pjt.225.1646052372123; Mon, 28
 Feb 2022 04:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20220224152456.493365-1-kernel@esmil.dk> <20220224152456.493365-2-kernel@esmil.dk>
 <87zgme6xna.fsf@DESKTOP-5JD7O8D.localdomain>
In-Reply-To: <87zgme6xna.fsf@DESKTOP-5JD7O8D.localdomain>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Mon, 28 Feb 2022 13:46:00 +0100
Message-ID: <CANBLGczP5OKPsVbs3Ydm9EfHkSoCd=ksYZ6NOnTdmH3Bh2e_fw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] riscv: Avoid unaligned access when relocating modules
To:     Samuel Bronson <naesten@gmail.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 at 01:45, Samuel Bronson <naesten@gmail.com> wrote:
>
> Emil Renner Berthing <kernel@esmil.dk> writes:
>
> > With the C-extension regular 32bit instructions are not
> > necessarily aligned on 4-byte boundaries. RISC-V instructions
> > are in fact an ordered list of 16bit native-endian
> > "parcels", so access the instruction as such.
>
> Hold on a minute, this is what it says in my copy of the Unprivileged
> ISA:
>
> ,----
> | RISC-V base ISAs have either little-endian or big-endian memory systems=
,
> | with the privileged architecture further defining bi-endian operation.
> | Instructions are stored in memory as a sequence of 16-bit *little-endia=
n*
> | parcels, regardless of memory system endianness.  Parcels forming one
> | instruction are stored at increasing halfword addresses, with the
> | *lowest-addressed parcel holding the lowest-numbered bits* in the
> | instruction specification.
> `----
> [Emphasis mine.]
>
> In other words, the parcels are little endian, and they're arranged in
> little-endian order.  System endianness doesn't matter, it collapses to
> plain old little-endian.

Wow, this actually changed since I wrote this code, nice catch. In
specs up until the latest it used to say "Instructions are stored in
memory with each 16-bit parcel
stored in a memory halfword according to the implementation=E2=80=99s natur=
al
endianness". I hope noone designed a big-endian core before they
changed it.

> (I'm really not sure why they describe the ordering in such a
> round-about way; I assume that's the source of the confusion here?)

I guess the round-about way is exactly because the parcels used to be
native-endian, but the order of the parcels alsways little-endian.

/Emil
