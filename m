Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CC586F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiHARKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiHARKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:10:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19EA20F5E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:10:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kb8so6978413ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X0og83QNDPb/QcxMWBlN2VCbsCakqiz5VRkxizX3GDE=;
        b=eneuZjA3S4iZ2Z2l1coSF74XiWWRRyXzNf1RQnBcKTZ+npKdCJ5n4WUZ8DBBwotx50
         jdH3tgqYQEkFaH3F0Wybx5qNoa7i0sI7XGbogSpG2VVKZerUfKzNxRo8inPlUzF/YkMJ
         9Ew3NOts+n/x8qw3jAAixv+esdmdi356qY7Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X0og83QNDPb/QcxMWBlN2VCbsCakqiz5VRkxizX3GDE=;
        b=zmUbnwPRICGiAiSxoF4tEGdiYMNkhmloJMMGjC1dmvDxEqCtojophWOifvEKddCoTz
         r1Qpe6zeQw/CJ/nOqhphtWoCg4peyzwANZ9DPTtE7RtXnfQtM8jjU7AESugORTZUYbOg
         4zYvYBMRHZxZ3myX3CuXLXFRyKf8gF02iuiGG2HDtBxhfBZ7GFWkpyNY9mSKcXWOuIMp
         Ll/+kOn5ZspMtcX5D4OtL3ZyfwCVdSgzEj9CnKHoZaS1ycVZOg6mG1XtsOAaF6CPbOaV
         7jf+9vtLnz9VCN04Ivfd3nW4qrYgY9aIYl/S7oDJ6G53lL/+fLEmL3WQpDYJF4WEjS2w
         Ge7Q==
X-Gm-Message-State: AJIora93V/8xQsfHqfeXoh/MdZRBSvqMzxpGKVnai8NUnnqEbedzD2mj
        HUb6DazstSe75guZjErUGLDTDa93nS/qlWYi3SY=
X-Google-Smtp-Source: AGRyM1spqovG9M2L/tgxBsM5bwCYWPgiv3YNhDMdqU6R3ZV9XwGmcn5jvC/1OMEe/9tUKqH6hN32xg==
X-Received: by 2002:a17:907:69b0:b0:72f:6520:9305 with SMTP id ra48-20020a17090769b000b0072f65209305mr13849704ejc.388.1659373829318;
        Mon, 01 Aug 2022 10:10:29 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id w10-20020a50fa8a000000b0043bdc47803csm7149585edr.30.2022.08.01.10.10.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:10:28 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id m13so10989915wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:10:28 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr10571973wrw.281.1659373828346; Mon, 01
 Aug 2022 10:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <YueXA90ePDFY7mKf@zn.tnic> <CAHk-=wiy+R8dW4RCV4-1ydh-JTy+4LCn4BbqNvBqxshDtp-XGA@mail.gmail.com>
 <YugH3pmzmRm7eoa2@zn.tnic>
In-Reply-To: <YugH3pmzmRm7eoa2@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 10:10:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLwhC8DVCQkRt_iejvFkNoToSXM6HuAmwktAs_o5+L0A@mail.gmail.com>
Message-ID: <CAHk-=wiLwhC8DVCQkRt_iejvFkNoToSXM6HuAmwktAs_o5+L0A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cleanups for v6.0
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 10:05 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Mon, Aug 01, 2022 at 09:34:26AM -0700, Linus Torvalds wrote:
> > Hey, I like boring.
>
> In that case, you'll like a couple more tip pull requests this time
> around.

Indeed, I'm working through your pile of mostly really boring stuff.

Yay!

                 Linus
