Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FADF4E5961
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbiCWTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiCWTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:50:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC84D58827
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:49:27 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b5so3336464ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPOg7ml2GHdztCx2wbZWD76YhsCFr2lpapXRjdLOdn4=;
        b=f7BkQA4NgoKs9prBjgEi7tB+5wVOxuAcmxEzL8s4/11jpagSay2PERpfZ+g6SrDUnQ
         o7jBani49t1qdStXNOb8e3kw/lA+w3sTkryWnoPWwiyLkUA6+0hx2mZZU2qtSq30pqvo
         ZsGyIosnr5Rr4w1Pn8kt3zdPliJdC48WJ+WW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPOg7ml2GHdztCx2wbZWD76YhsCFr2lpapXRjdLOdn4=;
        b=ReqRyB33RJ1Vr+DRNWMWNGtF7A1l9KsTDYfo0FhiHqQ0W5xJE/o3ne339kQ2g+K5YS
         syG+ynWQCZjmseZy84k3piGPSV2HtdV5jfH2KCCt9exRq7asDGeGO6vB4DZKGCBOvT1u
         4grDNtT+j0tQnhz4DebRgSspTLGapgD3D/pU3xu0tQhIgxgrrISNThxtYMvLunZ+CjkA
         U1ge6HqIDsiachNfq4bWY9PtRHbHXcWb5UdmynzW4dxpwdZkSE5WOQtZ7dgbPVYgBFcs
         tPu6NL7w30wlGZe/FUxm5yZVWlW17dOcjMk/GAz6GxxiYLGg3GKoqHXVRq0wh+1frkUx
         T1Kw==
X-Gm-Message-State: AOAM532UY0eZNwjrvM5HwGhJmuabsNEL7ec2Mctnb67aIHgl+eZmSN7v
        t5TOTjrfSgCh8h12YjxEsljti76PNaR8pexha3c=
X-Google-Smtp-Source: ABdhPJzXCbj2GT3D1nUdZtlyCTTydsgqe9hLH279orke+KFSovkNApka8+HXHdoqc7EQ5f4KIpAX9A==
X-Received: by 2002:a2e:97c9:0:b0:249:8404:a5b7 with SMTP id m9-20020a2e97c9000000b002498404a5b7mr1342005ljj.57.1648064965871;
        Wed, 23 Mar 2022 12:49:25 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c22-20020ac24156000000b0044846901eabsm77608lfi.24.2022.03.23.12.49.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 12:49:25 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id w27so4477825lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:49:24 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr1120043lfj.449.1648064964589; Wed, 23
 Mar 2022 12:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220321105621.3d4a9bc6@gandalf.local.home> <CAHk-=wj3_p98e_oohGZzfkDPaJFLKEW8C6mS9dhuKgLN8PNitg@mail.gmail.com>
 <CAHk-=wiNzTuFN0gCitdkPna0h3MM-ScZhgS_O0NKA5=mcuZCVQ@mail.gmail.com> <20220323154338.200882ac@gandalf.local.home>
In-Reply-To: <20220323154338.200882ac@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 12:49:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNSrf1SWDR+cV6R-pzWOQYPa5RzAwyvgv_ixED5sRD4Q@mail.gmail.com>
Message-ID: <CAHk-=wjNSrf1SWDR+cV6R-pzWOQYPa5RzAwyvgv_ixED5sRD4Q@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.18
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Wed, Mar 23, 2022 at 12:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'll take a look at yours. I gave that branch to Stephen to help him resolve
> it, but didn't look at what he had done to see if it was different.

I may actually have messed up my comparison with your tree, because I
was doing some of that while in my "test-merge" branch (which had that
dirty state due to the merge not working). Maybe I screwed up twice.

I think the only difference I have against linux-next is because I added the

  #undef __assign_sockaddr
...
  #undef __assign_rel_sockaddr

lines to stage6 to match the other pre-existing non-sockaddr cases.

              Linus
