Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1974CDBA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiCDSCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbiCDSCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:02:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED351D06F6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:01:34 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b9so15480128lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IIyu3V6JyZxTM4QW6XDn+zJ4BNFrrgaUMPNXlXD3rc=;
        b=UitQJmKRYIi3XZTJMbylshPqv8vGQ+3FgxsTTHVVz4mqaiJsbjaMBivswMaIsg1X6z
         kG1HT/WWh6TXjxgFCnOG4KlWZQzay/cQAzhpTSUO5NuPs7Dx4pAqSuW/1lcfbwCZBKQ1
         +36ay/fBApVGdwFKWLXyR+GyfWDuKseXonuzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IIyu3V6JyZxTM4QW6XDn+zJ4BNFrrgaUMPNXlXD3rc=;
        b=bMdK1a1cf0f2r/HskPqhn6iprR/7PXIUx9WrT+HwRntpcXqCSmzaXawCXNcopbNptF
         HwHZ3LSb+JKgV/bVpJrWpl1m6EoRmGtY4g1Qp8UvxkmKCoxKf2M/RNrg6LOip/j6I5u6
         NZaNUJEOu27LU2KYUfS/jSvIoId5mMriYBvDlTsdWQ3z1SiTijNreGRbXpmIXOdmuTnG
         juS2Vkq7RoqMSxSm/cxey0wawRWl/ZLAGligtzR587Yg9SPPl5ofS/BW2K1hCIB8lWJy
         d22GWEGMQN/LbrgxmKq/ED+/VxWmSFnks5kBzoyM6woKVBsltc2cnqxw4QEKAqnOnxpS
         HtEg==
X-Gm-Message-State: AOAM5303ayxGD4GLck2YbC6snO7RZMtqRs6Lstmy5ZUd/jB6EjGfmr5+
        rNC8G5BUBgW+tOa7YumAJn7dOTYs3BLT8utP
X-Google-Smtp-Source: ABdhPJxO+oKEK6YLtiSg34jDrTvJsjLrwEIH3AnsiTyRgZJCnYJhyoS4aEp+Y1h/ORwkVyzv/movtw==
X-Received: by 2002:ac2:5f68:0:b0:438:6751:6b83 with SMTP id c8-20020ac25f68000000b0043867516b83mr25204990lfc.376.1646416890085;
        Fri, 04 Mar 2022 10:01:30 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n8-20020a2e86c8000000b00246381f7fe4sm1198859ljj.108.2022.03.04.10.01.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 10:01:28 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id o6so12061440ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:01:28 -0800 (PST)
X-Received: by 2002:a05:651c:1505:b0:246:8fe5:5293 with SMTP id
 e5-20020a05651c150500b002468fe55293mr14863391ljf.152.1646416887860; Fri, 04
 Mar 2022 10:01:27 -0800 (PST)
MIME-Version: 1.0
References: <8a99a175d25f4bcce6b78cee8fa536e40b987b0a.1646403182.git.daniel@iogearbox.net>
In-Reply-To: <8a99a175d25f4bcce6b78cee8fa536e40b987b0a.1646403182.git.daniel@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Mar 2022 10:01:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDLyNRipPBv5Jebmb6K84Q-eAMi=d0t6-gnC2wyQ2-1g@mail.gmail.com>
Message-ID: <CAHk-=whDLyNRipPBv5Jebmb6K84Q-eAMi=d0t6-gnC2wyQ2-1g@mail.gmail.com>
Subject: Re: [PATCH] mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+11421fbbff99b989670e@syzkaller.appspotmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
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

On Fri, Mar 4, 2022 at 6:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
>  [ Hi Linus, just to follow-up on the discussion from here [0], I've cooked
>    up proper and tested patch. Feel free to take it directly to your tree if
>    you prefer, or we could also either route it via bpf or mm, whichever way
>    is best. Thanks!

Applied.

Thanks,
          Linus
