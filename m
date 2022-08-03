Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16925894DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiHCXc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCXc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:32:27 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B494E877
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:32:26 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so3261484ooj.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZZp/mpqWm7MHvgF6uTyDMp42kr2Njy7C2uXF4wQPOwo=;
        b=3DPS0mjfbJdbjToepDdO1S2S3zdUjdQJBt0jGkacyWBVxaE/Tsg0FESZtVHQG6E6S3
         U2kREMlA1P3Bf8hZ4/RhW0vfQk5neJMTiIUpL16lZ7KjxduKAKuN3r5vZwVl0FGlI5O7
         wcVGwQvcYLayLWi3fMxucb6Hmj+Vqv8lPACXPSnYWMIknnB1Hh0EwqGw/EDWLqeQ6kLB
         4P17IjI6LKt+S+hAlywSHRWBBvzdJZQ8o0S38u/fuA+EHcgdD7AIfKu4i3rzMBaQ9Vgz
         1RgX/yCkO2EsHnfXzDw5yLrXZce71rZmnVmtW6ELxu6KhU2gvBfakCEklhz69027+yqp
         qZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZZp/mpqWm7MHvgF6uTyDMp42kr2Njy7C2uXF4wQPOwo=;
        b=PGUs+bHHrq3NN/uFbcP4Jf4j0/UpnhLTQnH5HHLDzmlIqcsbHLpZK3YGt2t2ixvEcR
         /8n653hLeAIhHPlzTO+rGTJD7oLPW01gMSlmuy8yvlIg64VXTZGKW5snElF0xgD1aAJT
         LGQXjEsJOYXgZkOoGJXgVzwUMxmQBvUtoBPUnoVp/3aJ1yh8P07OIHZu41f7ssCAo2uQ
         WpFIk1bh/pCmuq+YKl/E4vC/97sIUcBWBv/c5FzSimyxg2C8EShETCI1AqpdQltFutap
         4p3t8xoZxEyHLwvbsHaDEbx3nJ581BjlwNi6YNYrf7IT19cLR6tncWiM/jBs2dZPe+fK
         HVIw==
X-Gm-Message-State: AJIora/Ni3Zwzhv2PmQgKKBb+xTs01XtzOI7TX8NpA06hbZ5HBYkWNGQ
        mWRnI9a3SxzY1CtzcMwLDSedy11qQ7Xf7u+QIjW9iVhhii4EWg==
X-Google-Smtp-Source: AGRyM1sHmMNEUlUl3pAbbNlUgZITxMc87KTUVrIRloEeKvKXACYdDy9c7oiQXFxRG56P/md1h2R0fVXfJVHLpnBXJuo=
X-Received: by 2002:a4a:95ca:0:b0:435:fcc6:5eca with SMTP id
 p10-20020a4a95ca000000b00435fcc65ecamr8893903ooi.5.1659569545598; Wed, 03 Aug
 2022 16:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com> <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
In-Reply-To: <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 4 Aug 2022 00:31:16 +0100
Message-ID: <CAPj87rMSNtqZUbH_5rmGAXpWONKhoZHJsjbw11PwYwXJi0b9jA@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded,

On Wed, 3 Aug 2022 at 21:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> The reason it happened now is because I saw two drivers, which are
> doing h/w acceleration for AI, trying to be accepted to the misc
> subsystem.

Why misc?

> Regarding the open source userspace rules in drm - yes, I think your
> rules are too limiting for the relatively young AI scene, and I saw at
> the 2021 kernel summit that other people from the kernel community
> think that as well.
> But that's not the main reason, or even a reason at all for doing
> this. After all, at least for habana, we open-sourced our compiler and
> a runtime library. And Greg also asked those two drivers if they have
> matching open-sourced user-space code.
>
> And a final reason is that I thought this can also help in somewhat
> reducing the workload on Greg. I saw in the last kernel summit there
> was a concern about bringing more people to be kernel maintainers so I
> thought this is a step in the right direction.

Can you please explain what the reason is here?

Everything you have described - uniform device enumeration, common job
description, memory management helpers, unique job submission format,
etc - applies exactly to DRM. If open userspace is not a requirement,
and bypassing Greg's manual merging is a requirement, then I don't see
what the difference is between DRM and this new bespoke subsystem. It
would be great to have these differences enumerated in email as well
as in kerneldoc.

Cheers,
Daniel
