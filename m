Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F5B4B94A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiBPXpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:45:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiBPXpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:45:39 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D5024467B;
        Wed, 16 Feb 2022 15:45:26 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 26BBA784;
        Wed, 16 Feb 2022 23:45:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 26BBA784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645055126; bh=Sau/8cjm8I8qhCKztqdxWnh/G71DxOC+cWRj6cLXdWs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AKTZ0g7C8vjqdhi9kWWEzoEe9Y0BVE8ZI4Qn++H8qhAH0hw9tl0l/yu2u7f5U5F0h
         LycKi5cpybaGfE0hOXC1fj6Q0yCE3exH8DVwfNcGGN/+mcylM7zBzNilSjO+WSI7gm
         H0inRMW/gkE096yiONRLhc0i72p+LwRM/MCAIHJn7CST++V6NUK+h9QW8jKZ4s4Yf6
         GLZn8A1pBZHSSQa6pJym5IE/eJzSRjT+ZGxxY28j+LfBE3EY2/HNK8684SuQTYBZRv
         lfuOx0P9aPBlRYeEj0MkBuA4v8imNjzEd4naVnDBAA/gvsog/+NJPgVUcRpszAd/IO
         qH2VkHPdTpK5Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
In-Reply-To: <20220205233945.7a4d22d8@fuji.fritz.box>
References: <20220205233945.7a4d22d8@fuji.fritz.box>
Date:   Wed, 16 Feb 2022 16:45:25 -0700
Message-ID: <8735ki2x62.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> This is in fact a release notification of a major kernel-doc script
> refurbishment I have done. My work has reached a stage, which can be
> considered a world sync point and here we are.
>
> I'm not sending all the patches to the Linux mailing list, as I prefer
> to check what you think before I emit about 500 emails.
>
> I've parked the lot for you to inspect here:
> https://salsa.debian.org/guest/kernel-doc
>
> This also helps me report the bug fixes. See the issue tracker:
> https://salsa.debian.org/guest/kernel-doc/-/issues

I've taken a quick look - that's a lot of stuff.  Thanks for not sending
it all; you would have gotten some unhappy answers.

Some overall thoughts:

 - Work like this needs to be broken up into digestible batches.  Let's
   start with the POD stuff that I've (finally) commented on; other
   stuff can come later.

 - The coding style in the new work is very unkernellike; that will make
   it harder to get this work merged.

 - But let's take a step back and ask: why are we doing all of this work
   in the first place?  What is the benefit to the kernel community from
   all this churn, and a growth of the kernel-doc script by over 2,000
   lines (even if an awful lot of them are blank)?

I'm serious about that last question; do we really want to invest that
kind of effort into this nasty old script?  Or, if we're going to do
such a thing, should we maybe start with Markus's rewrite into Python
instead?  If we're going to thrash the code and make it unrecognizable,
perhaps we should move to a language that is consistent with the rest of
the docs build system and which, I believe, is easier for more kernel
developers to deal with?

I am *not* saying that this work cannot be accepted, and I certainly do
not want to alienate somebody who is actually able to look at kernel-doc
and not have their eyes bleed out.  But I am saying that, before
launching into a hundreds-of-patches journey, we should know where we're
going and why we are doing it.

See what I'm getting at?

Thanks,

jon
