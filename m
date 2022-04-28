Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB45513ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiD1RVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiD1RVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:21:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2014BBB1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:17:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y19so7581356ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNIYBv55isrBKHu/0D73jjAPNihwP6eLiF1y+MnObN8=;
        b=AmLtvfuUlEd/MFryMoi2KrW3MjkN8XUdj7WljzlzQs1mPZn+ae/YzFM7MSpad9hbWm
         EyiTenkfgHh+omWU1OEZDTs4hBSvFJoVb3GAmjgCkrxjaTOk/0dpEr37PVDhIZWtaTOB
         I6jTajI0npX3gJ5JUXa8daao7//s3+MPZamPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNIYBv55isrBKHu/0D73jjAPNihwP6eLiF1y+MnObN8=;
        b=bJ056Y8lJvC+qUH6N8WtUOcY7B8TR+Fkmr4g3X2CylDgzKBFqjEHNjgcBGGV6QN5bk
         nlvgZiDA2ojLMx2sVB0cwbU6pKZvgNJht9hw2qKxOpPOKYvW20Nnn45YYaLSIkKVSLUF
         jLZfEqmbtWKA1w7qpM9p6LrZEgBPvMzsXV7xt0s7axIg6+LR0NvT5uVt1yFFssyQFDp+
         fbtLtZ12YC5hcnMlLRG7Ngourxo8u5vfvyJD4Mne4Lkuu3HA+1CJ6j4TxFs/J2OFrj3m
         NgmcqP5bpNaCyBcosQd5lNh9Qxqzut7FdrAgW8CQN4GkT2ttXEjgJJRrsM3MrqRMfFio
         C2gw==
X-Gm-Message-State: AOAM532WwOeIO7XnVTYc0IZFO3wFWi9jZewKfC3Sad/XppwEbPKZvX4T
        9ZDIukdYJnaT7z753MDqSX+FhgvQG6EApJCmx+o=
X-Google-Smtp-Source: ABdhPJy+20izviJ0rT4kAwowDBqs2eDhenkxIUuS7VDY+1xc0OGqV457NUJIkgcbg6V9ml2Dy6mOaw==
X-Received: by 2002:a2e:b5cd:0:b0:24f:e86:be54 with SMTP id g13-20020a2eb5cd000000b0024f0e86be54mr16254200ljn.250.1651166268702;
        Thu, 28 Apr 2022 10:17:48 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id bj25-20020a2eaa99000000b0024f2b540bcesm42637ljb.85.2022.04.28.10.17.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 10:17:47 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id c15so7573318ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:17:47 -0700 (PDT)
X-Received: by 2002:a2e:9d46:0:b0:24c:7f1d:73cc with SMTP id
 y6-20020a2e9d46000000b0024c7f1d73ccmr22272241ljj.358.1651166267188; Thu, 28
 Apr 2022 10:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
 <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
 <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
 <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
 <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com> <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
In-Reply-To: <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 10:17:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiF8D6Bs2m8y85XpHU__c4XD1yFV9JXx9FuTqoge+-yhg@mail.gmail.com>
Message-ID: <CAHk-=wiF8D6Bs2m8y85XpHU__c4XD1yFV9JXx9FuTqoge+-yhg@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Apr 28, 2022 at 10:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll look at that copy_page_to_iter_iovec() some more regardless, but
> doing that "let's double-check it's not somethign else" would be good.

Oh, and as I do that, it strikes me: What platform do you see the problem on?

Because the code for that function is very different if HIGHMEM is
enabled, so if you see this on x86-32 but not x86-64, for example,
that is relevant.

I *assume* nobody uses x86-32 any more, but just checking...

               Linus
