Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA5058B7DE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiHFTGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHFTGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:06:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73276341
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:06:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so7025149edd.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TcoC+LKGe/ZhJcrgEUVMwuSkE/9txAnoI/28K0Jyoeg=;
        b=MReSOmXu27en2kf6MJbwNJL85Of4VoPZHX0QqO5iRpOY4NsTBJndxZW9aV9asV7/jB
         kvCtFehHK7z3mMY+ikaaLqzjDitUCD+H58IDU2rda8hoRJYd90SMHhyHYh5dhyG3Yavq
         QvY9TN+JqXZWtWQE8nVZkoPBxb1fYxPDcMoFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TcoC+LKGe/ZhJcrgEUVMwuSkE/9txAnoI/28K0Jyoeg=;
        b=xZkxtzxXpyDJ7VvjXBeKRAzncMdcIgNrpH0jEXDwyBLz86Gu3jB1fZkKv3IedtN6Tx
         /j/5xUIYjLiKX1wVVQdDsC95wmcdqTEV7yuk7oEW4DXbU0Zw8CKC0BVmaoDDMBl7XVzL
         e1KBHANP3lb9L0hNNL98Lspqoy32oSvK0nWcsSJyPCG0Q6ZMDKIeoDy+VsvWQTTZulf7
         ox85/nRw50sQJwdnIWd4NTZUknKWfnGrrLRLw72iPQpD6KlyZKR9G0KiSePO2WCHumIp
         UpS3MXvsVb928QsSev/rNBJzEjwQFxKvzNIQUtSZ2P+RI1mePNTevu0XZfkq6Hu8jY16
         VQiw==
X-Gm-Message-State: ACgBeo01IeKgQaPJ7rO+dlcsZYecfnhZubusoKvgvZSXJ9JUjayw6lxb
        utXbl2i+BzwR9WZIxaemeWecmcz/IrS6L+9z
X-Google-Smtp-Source: AA6agR7KtLeNJtZGPAHXC/I7mHvpKIMl5m+OGrFVz5JL5AMk4WNnyKFkmMoCi8l/V9NEqsesnthtTA==
X-Received: by 2002:a05:6402:42d5:b0:43b:5cbc:eeba with SMTP id i21-20020a05640242d500b0043b5cbceebamr11448103edc.3.1659812769071;
        Sat, 06 Aug 2022 12:06:09 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7d999000000b0043bc19efc15sm1868965eds.28.2022.08.06.12.06.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 12:06:08 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso5430542wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 12:06:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr12573939wmq.145.1659812768227; Sat, 06
 Aug 2022 12:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220803104936.7df810fd@gandalf.local.home> <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
 <20220805124701.4b44195d@gandalf.local.home> <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
 <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
 <20220806142203.3c133322@gandalf.local.home> <CAHk-=wiTRbL22B=-SJ0fwqpiXZnGe2LGPs8DjToUk=ezKsKVjg@mail.gmail.com>
 <20220806145159.686794d8@gandalf.local.home>
In-Reply-To: <20220806145159.686794d8@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 12:05:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiu13cO3NR5Ub3oW+V3iJoNwq67QM2Un7xcfNak8UdcA@mail.gmail.com>
Message-ID: <CAHk-=wiiu13cO3NR5Ub3oW+V3iJoNwq67QM2Un7xcfNak8UdcA@mail.gmail.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 6, 2022 at 11:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Is the second one I sent better? The consolidated version.
>
> The asterisks do at least highlight the reason of failure.

Better. But I think you could remove even more. It's not like we need
the whole ascii framing etc.

It looks very 90s to me. "cowsay" and all that..

But it's not like I care deeply about the retro look.

                 Linus
