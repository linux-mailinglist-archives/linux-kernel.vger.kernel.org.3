Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3947D4E9CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiC1QvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiC1Qu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:50:59 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCAA393E4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:49:18 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o5so27097643ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L08alKUmm6AlgR+PwMmA7OuwcVmU2N35lSDDIaFmWWM=;
        b=RLmODLwPi1HGZt+v/Oi/5FkxojBFyPOtSKhC+PWgS4z8/ywxAsjLesVRQkcS6PtoR0
         hmqK5P8B12/MBwYac/Xz/OiqHggEI5vOoJyvD7aemgRh7rFhqqVanCUPnOtgmSjbseXv
         /TukGTxIjyafs4RDMmhL8EW2ZjWTUJgUkEtb4sWVte1ZO04adRkg9wZF+Wh6VtBNlJ0G
         kRkQP7ighWnGAqRqDL/EDaumjD9x+sfLnGyFq5B57RukL45aXyMo2asOMlVOgaqdauKd
         6zeHLiLydFoJHj+qnDJqHSqI68Ds4n4hTdXPkKVpPTboZv05i/N7SNspnRj+3G/dhJ3o
         RZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L08alKUmm6AlgR+PwMmA7OuwcVmU2N35lSDDIaFmWWM=;
        b=HUemjhoCibOTRUr7pRpgrqWowsNc2bc0LgeJMk7crHXMxfteDUUPBlHvPUuMUfw9gV
         yNRiiEKlVV0a4Vv2lVd1dVVRRX3d6JQArebsHD0/CMNECVLA0EXKcBfb/GQq3hmUMLdy
         WULhxQGv+huxcnbldnUudz0YwoNoMyrVSwneXutXTRmGCy05EUjwXXJAOSdZiPaWkoJE
         8+0Ph9vdo6CIhiVsPd8dDEgreGeVhw72Pz6FfGUeSIu2yneIBDItvfHGRx+n52uiQZRP
         S+6/TgPyASA8VkAnUnL5ZVsbJfaHuvVMQ7XsmprTFjxUx1FnwbxtSIzUnGNIYpxk1HBg
         yRkA==
X-Gm-Message-State: AOAM530iVBjHxizbHhMatndIOD7jpyeSIe9MYCTtRAPH/S6OLQQl+TJ6
        B2KsxeX2n21/wIyv84IgZddOxTWfMB+pHVig+MWefh0SMhUurg==
X-Google-Smtp-Source: ABdhPJx7a8pbEc2nxFw/EUBqxg9+ajazSjsfJYuPAeLxiURTPJx5h45EPc5k0WLTztD3wyitnt+wOftplCEsZGfC2ZE=
X-Received: by 2002:a05:6902:72a:b0:634:6843:499c with SMTP id
 l10-20020a056902072a00b006346843499cmr25092326ybt.36.1648486157491; Mon, 28
 Mar 2022 09:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220322004654.618274-1-eric.dumazet@gmail.com> <2572770.1648463660@warthog.procyon.org.uk>
In-Reply-To: <2572770.1648463660@warthog.procyon.org.uk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 28 Mar 2022 09:49:06 -0700
Message-ID: <CANn89i+bE6C_dNEvUO-2S6nfjvieB29zJQN0uB82x6WytRnaVQ@mail.gmail.com>
Subject: Re: [PATCH] watch_queue: Free the page array when watch_queue is dismantled
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 3:34 AM David Howells <dhowells@redhat.com> wrote:
>
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> > Reported-by: syzbot <syzkaller@googlegroups.com>
>
> Should this be the following?
>
>         Reported-by: syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com
>

This can be.

I mostly send fixes while the syzbot report is not public, so I used a
generic form.
(Because I also take care of feeding the bot with the needed "#syz
fix:  patch_title")

In this case, I have released the syzbot report, because I saw you had
a patch for this issue already.

Please add "Reported-by:
syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com" when you submit
your fix, thanks !
