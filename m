Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDF58F08D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiHJQkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiHJQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:40:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F53B2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:40:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ee900cce0so18444616fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=yb0FqRtMqUKU+P/ctb3sogkoQRmLyX6XlF3M71/csC8=;
        b=HxchlGZH1QrRpSnzRgFnJlioSzOls6/F2rKMVA6MAOV4iA4+KU6W40atEbSOubwB3w
         c/JdsXCLC2kqN4sNBOEkqeVrfzES2OBzfPC7WCW9Z0WOjXod+T0WfBTSvsV8Oor7XtJ8
         jiUjkDA/WRhDfZXJx0kK2mqUs69AvQcXStVWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=yb0FqRtMqUKU+P/ctb3sogkoQRmLyX6XlF3M71/csC8=;
        b=DLiueFExN3L0gEAhAY21HF3K62A2dt/V206v6uyy5UAvTxnYODDppqZx6592wQoa9w
         4tL/wpE+8KiFyTe72IJddarEXBbjIIsPKTIvD0Mcu9Ya57h2QW7F1r4YAz9IhP0VFsfp
         Oj5A0GdaPznaOpovDkhKCZGwzmJmfu3YK/+/yJlkzUkoZw3RUtZPR4iDVDnychPgCgBD
         YM4Q1NFE1E4p8YA5pg0u+P6toK+1qvv5RNCjYdtjT199PbZQj+j4b6XPWkzNUS7AULvn
         MIimPnwk76kJl6fcWbydQoMnlcBYf3RQTtT9zj7ZEulNWMYohuEvb4tbX/ZNDWFhQEiG
         rtwA==
X-Gm-Message-State: ACgBeo043Yu4eBOV3LhW++dSdUNVJqwBro0Wq8S8iVgSxd4fDSp+YRBN
        48phyMJwPXHonen8jepUFrZQBoYW6fbNDU34/ppoObLQMX4=
X-Google-Smtp-Source: AA6agR7tx/Q6RJ1nEIkhY51xamWM0f+5w6PTicLMo86wNo/NH7RxeEeVDm73bfNHdaTNH9bq6+UEd8k5Bs2xIdZw0ag=
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id
 fo23-20020a0568709a1700b000e903d1f91amr1879997oab.44.1660149635427; Wed, 10
 Aug 2022 09:40:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Aug 2022 11:40:34 -0500
MIME-Version: 1.0
In-Reply-To: <CAODwPW_mYQ1gcd2Xw5s+7dL2kLcYn-VTxKHUH1iM1V4mn7pT_w@mail.gmail.com>
References: <YuuBrUmiRYoaSmPw@google.com> <20220804142856.306032-1-jrosenth@chromium.org>
 <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com> <CAODwPW_mYQ1gcd2Xw5s+7dL2kLcYn-VTxKHUH1iM1V4mn7pT_w@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 10 Aug 2022 11:40:34 -0500
Message-ID: <CAE-0n504q_NeB9e2BYF8P9Scp7TPqsp9KEWu2DO=ZzbYdJfyew@mail.gmail.com>
Subject: Re: [PATCH v7] firmware: google: Implement cbmem in sysfs driver
To:     Julius Werner <jwerner@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2022-08-04 16:14:43)
> > Quoting Jack Rosenthal (2022-08-04 07:28:56)
> > > cbmem entries can be read from coreboot table
> > > 0x31 (LB_TAG_CBMEM_ENTRY).  This commit exports access to cbmem
> > > entries in sysfs under /sys/firmware/coreboot/cbmem-*.
> > >
> > > Link: https://issuetracker.google.com/239604743
> >
> > Is what you intend to use from here essentially an nvram? If so, it may
> > make more sense to expose just that entry in drivers/nvmem/ as a
> > read-only sort of nvmem.
>
> No, it is not NV. It's just a normal memory buffer allocated and
> filled by firmware on boot and placed in a region of normal DRAM
> that's marked as reserved.

Alright cool. The bug says 'vbnv' so I was guessing 'nv' meant
non-volatile.

>
> > It isn't clear to me what the structure of this path is. I'd expect to
> > see an entry for each 'address', 'size', 'id', 'mem' with a different
> > What/Date/Contact/Description. If those attributes are all within a
> > directory in sysfs then there could be a top-level description for that
> > as well.
>
> CBMEM buffers are used by coreboot for all sorts of things and we
> regularly define new ones. We can't maintain a full list of all IDs in
> kernel sources because it would be a ton of churn for no reason --
> best we could do is to add a link to the ID list in the coreboot repo
> (e.g. https://review.coreboot.org/plugins/gitiles/coreboot/+/refs/heads/master/src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h).

Agreed, that's a good approach.

> We really only care about one of these right now and many of them will
> never be relevant to the kernel, but I still thought that while we're
> doing this we might as well provide a generic interface to all of them
> because others may become useful in the future (and then you don't
> have to update the kernel every time you get a new use case for some
> userspace tool wanting to interact with some resident data structure
> from coreboot).

Exposing more than is necessary in the kernel ABI could get into
problems with backwards compatibility. It also means we have to review
the ABI with the consideration that something may change in the future
and cbmem would be exposing something we don't want exposed, or maybe it
is writeable when it shouldn't be?

Furthermore, if the ABI that the kernel can expose already exists then
we're better off because there may already be userspace programs written
for that ABI with lessons learned and bugs ironed out. In this case, I
was hoping that it was an nvmem, in which case we could tie it into the
nvmem framework and piggyback on the nvmem APIs. It also helps to expose
a more generic ABI to userspace instead of developing a bespoke solution
requiring boutique software. Of course sometimes things can't be so
generic so code has to be written.

>
> > Do you need to be able to write cbmem entries?
>
> Yes, see the use case in the bug (using the vboot workbuffer from
> coreboot as a write-through cache for the vboot nvdata on flash).

Is it a cached non-volatile memory?
