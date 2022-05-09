Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F245207E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiEIWlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEIWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:41:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269061F7E35;
        Mon,  9 May 2022 15:37:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9ED4D732;
        Mon,  9 May 2022 22:37:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9ED4D732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652135857; bh=+K/p8aJYKppOfVB/2Lds90/8PmBqo1/rz5gWoyZ5boc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FtmTZGc2LhZRGi+Lb1lomHQMGAmfneipznhz/s9NSAqpbZEVldkNbPzHoZ9mmO9Cv
         ebbMwOUDuKYR4AH+UiWRt2dr1Sdu4Ywp1PUr1upzbuYb7aTDqfuzqEORTY3/YZqVG6
         cT5HOYKtNhyGwgWVHU5ko6/0KbQyjn604SF728Sditw1ovlJiGCcmURqlKUP4uGqt1
         naxPvLosAkPK4hM8xGpeqWV+/p7eRkPVurfyMXmXBpoVMltbYvEY89Xd/ZdRKuVT5+
         Qyk8EgecFVKYlO2gOolAM5VgZquswCMjiapglTJaW0HEuAILvqSooM+QglyacUDKDo
         NaLpDWt1y0qoQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Wu XiangCheng <bobwxc@email.cn>, Daniel Xu <dxu@dxuuu.xyz>,
        Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Julian Merkle <me@jvmerkle.de>, Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
In-Reply-To: <92a7010c-5bb2-65df-edde-0ca88e035c2e@gmail.com>
References: <20220507052451.12890-19-ojeda@kernel.org>
 <7e9c2e77-8b70-6e15-3f3d-905ab42b0fcd@gmail.com>
 <CANiq72mBVo4+htxVjY0wB1Y3GO2PEUiZjZKRYT8ddwx84-hAtg@mail.gmail.com>
 <92a7010c-5bb2-65df-edde-0ca88e035c2e@gmail.com>
Date:   Mon, 09 May 2022 16:37:36 -0600
Message-ID: <8735hicoy7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> [+To: Jon]
>
> On Mon, 9 May 2022 12:41:28 +0200,
> Miguel Ojeda wrote:
>> Hi Akira,
>> 
>> On Mon, May 9, 2022 at 6:02 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>>>
>>> I think you agreed splitting SVG part into its own patch with
>>> a proper copying info, etc.  Let me see...  So, here is the link:
>> 
>> Yes, sorry, will do (in fact, it should have been there in v5 too).
>> 
>> By the way, the Linux SVG logo (used to make the one here) is pending
>> in the linux-doc ML.
>
> So you mean the following post:
>
>     https://lore.kernel.org/lkml/20220207014418.GA28724@kernel.org/
>
> I'm not sure why Jon has not responded.
>
> Jon, was there any issue on this patch?

Yeah, but the issues are all with me :)  Please accept my apologies for
letting it slip through the cracks.

Looking at it now, though, I hesitate to add the logo (and another
COPYING file) in the top-level Documentation directory - I'd really
rather people not have to pick through a bunch of unrelated stuff to
find the actual docs they want.  I'd recommend we make a
Documentation/images (or .../assets or whatever) and put things like
logos there.

Disagree?  If not, could I get a version of the patch that does that?  I
promise not to set on it for three months this time...

Thanks,

jon
