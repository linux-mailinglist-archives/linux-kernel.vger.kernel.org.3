Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24140467CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353418AbhLCSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbhLCSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:01:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12867C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:58:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so14767674edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yea/SdPe3Gf0ohGg/Nl9Dqn2dARuQKMuNBUEpNaPxnk=;
        b=Ubriqb40c1PZS+79Dl6j67Ias5PFWYTrTRHRXKNlc7sSYxaE9wYBjxyC2ET6CeH0H/
         LnH8SbyKY9szc98MCI90ie9zcuBu5Y34WfRd/GMLJtle5kfVh0AwRKnG8MJLoubu8YDL
         ZU4vQrHR4IY6sZT9u+4VyXu0CNyY4uP8EmYUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yea/SdPe3Gf0ohGg/Nl9Dqn2dARuQKMuNBUEpNaPxnk=;
        b=CFdhbsrZhFVTrIPcf2S3df0ysqvfb59qaKN8fvViYmCdx0URTV+OOSWWogAvkqK0Iq
         0Ed0Rn+uMVgnV4rlSP1AZAZhlp/zyDy67CU/8i8WqA5vwLIfrEKJ54oWb1QAxQr7X5nq
         oC1ea0dKMeQh2imSlUbdCNKBRtsl5KKNKFmlkJsC3CXK8bOky1haAqx8To0GsVPY/l/q
         CI15BdveryVm4ilcZtkWmViycg/9Evol6sa35Y2e64L7pTkXwNH4JN/qh48J0OzgkOmT
         cnpEL9P8RzzMoaarErvyY9L9R0WSGdfavzBHbtrw583tMwxCfnJh/oV2hpnkfnGcOKPX
         DpSQ==
X-Gm-Message-State: AOAM530kOIcCslPlb2R2CtPHG/0mnOz8LcDeUS6tthQw9UdzMibOdf/X
        zCTdmUMPTt9tu93o1WuiaoLiDV1XNr+AFinY
X-Google-Smtp-Source: ABdhPJwNchUTmFQN563SJziwjIepwDGDw27957O1dmGqB7eJEIgS9TTCAfeHVw3prLDfVXktSHAR4A==
X-Received: by 2002:a17:907:6d20:: with SMTP id sa32mr25401543ejc.108.1638554296232;
        Fri, 03 Dec 2021 09:58:16 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id y22sm2312184edi.8.2021.12.03.09.58.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 09:58:14 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so2805383wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 09:58:13 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr16117373wmc.152.1638554293325;
 Fri, 03 Dec 2021 09:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20211201193750.2097885-1-catalin.marinas@arm.com> <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
In-Reply-To: <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Dec 2021 09:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQAQTGdMNLCKwgnt4EiAXf7Bm6p7NQx5-31S9-qPD8jg@mail.gmail.com>
Message-ID: <CAHk-=wiQAQTGdMNLCKwgnt4EiAXf7Bm6p7NQx5-31S9-qPD8jg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Avoid live-lock in fault-in+uaccess loops with
 sub-page faults
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 7:29 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
>
> We're trying pretty hard to handle large I/O requests efficiently at
> the filesystem level. A small, static upper limit in the fault-in
> functions has the potential to ruin those efforts. So I'm not a fan of
> that.

I don't think fault-in should happen under any sane normal circumstances.

Except for low-memory situations, and then you don't want to fault in
large areas.

Do you really expect to write big areas that the user has never even
touched? That would be literally insane.

And if the user _has_ touched them, then they'll in in-core. Except
for the "swapped out" case.

End result: this is purely a correctness issue, not a performance issue.

                       Linus
