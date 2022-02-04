Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FE44A9E56
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377170AbiBDRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiBDRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:51:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F230C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:51:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so21505907ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4hiJqR1yEZtQsqmzLlZSfYU8B7IPxJQai2V7jYSZc4=;
        b=RcFLddjHA0EwraDsXQJEq58cJTr2gUXIr9LfLuW9F/h0ucvYyxLmquBUMGKrYcyOpg
         NgOZnAMU8LjKRuXzparft+8yKW1fLvguR3OCDmH/Axos054DyKeWO1ZHsTYpT3+ztQzS
         AnA0982jKYnR0SSr8xJr9VFHphFQNA+Ixj/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4hiJqR1yEZtQsqmzLlZSfYU8B7IPxJQai2V7jYSZc4=;
        b=6FuOItCcKspOPE/aCVNXH10ZFbL8i4rCDbucXMsPg+q/KlqD3vEvacpdSKXjmOgVWc
         wd7CfVpGPMZf+xB9cus2/9cq2UR1PB/0Ya1KeKPWT/GXdbgSJTMrd0mw4NYn4RvrRYmX
         kfz4ERg/JKMl84Of9bbyhkyC2ZFSRfGvcO+TCx6cSylLf7Z8GdmYYBlwLmL7OX045Eyv
         0eGud0W9jnoGmsRhtArX780D1jSzf1JdwiHoQlMLv6UqplEX8tbyBpwDIAW1L+2PkAQG
         AFk8M73SfW0EFirA0bRMjSkttm/3/vgYgjZ0j+sNU27G+2eU9fUtIxpiDWmleDf1uJ7y
         ngAA==
X-Gm-Message-State: AOAM5333TpxjzQgn1halGxM8ZfMtWFGH4WQFtW78uBiX65p94o4zog2R
        sRM6uZWBx6GKjwdQpKY/7QEzGjm55nU8h7uT
X-Google-Smtp-Source: ABdhPJzxNj+S1Bc12oYBjDRpd4mwJPKCbVnMFZYcIjhPOhOLg8A3NE4bvNRJQ5sZwb+zP3P2M/BmGQ==
X-Received: by 2002:a17:907:2da7:: with SMTP id gt39mr3533616ejc.563.1643997068779;
        Fri, 04 Feb 2022 09:51:08 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id by22sm870461ejb.84.2022.02.04.09.51.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 09:51:08 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id j16so12670385wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:51:07 -0800 (PST)
X-Received: by 2002:adf:f90c:: with SMTP id b12mr7765wrr.97.1643997067773;
 Fri, 04 Feb 2022 09:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20220130130651.712293-1-asmadeus@codewreck.org> <Yf0Fh7xIgJuoxuSB@codewreck.org>
In-Reply-To: <Yf0Fh7xIgJuoxuSB@codewreck.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Feb 2022 09:50:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgeEada1nT7yqc4SBKr9q9WeuBxDyJGZ9ebjP631ry81A@mail.gmail.com>
Message-ID: <CAHk-=wgeEada1nT7yqc4SBKr9q9WeuBxDyJGZ9ebjP631ry81A@mail.gmail.com>
Subject: Re: [GIT PULL] 9p for 5.17-rc3
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 2:53 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> I rarely send fixes out small things before rc1, for single patches do
> you have a preference between a pull request or just resending the patch
> again with you added to recipients after reviews?

Generally, pull requests are what I prefer, partly for the workflow,
partly for the signed tags, and partly because then the patch also
gets that same base commit that you tested on.

That said, despite all those reasons, it's a _very_ weak preference
when we're talking a single individual patch.

So if it's easier for you to just send a change as a patch, I still
very much apply individual patches too.

             Linus
