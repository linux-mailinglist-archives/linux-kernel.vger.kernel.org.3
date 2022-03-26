Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23144E836A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiCZSnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiCZSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:43:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE39458387
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:41:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bn33so14182342ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=je98ykY3vsH8qDn25IW7eQYaUsod4iWZw+6FMsszdYQ=;
        b=cY/i8NkOXIGpbugW/kXT/lHU/6KoHURxtydz8kA95dAKXv2dKSirRf5cna3Zz4aQE+
         3zUrMCb8X6oIozpmPaWm2GuBQkB5p7v5BNoSLeNAqcrF06WOFYpSLhQLT9RJ7kcNoToA
         /byaS8f5DiCBA3c9IENt3HgD+FLD9/VL6yCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=je98ykY3vsH8qDn25IW7eQYaUsod4iWZw+6FMsszdYQ=;
        b=Cy1a5qiS6mmKnFX4AAjdEKm/aVsjiLvcqW3Eis8mZq0EmXA7Gi0yP+oealMz0dFA7E
         pXtxuO0G5VAuCMtxJMOTqByE8iy50npo272OPzSKk7lXydHiK8z0E7oOCHANj7rzn7FV
         yd95eAgwjNlyKskO5eYo1Omg4FeNOAkN/ZVVivm9FAOoYBQbHBdIxXVgZj6H/SnTl1xa
         9I+Ukq41pI8nw9BGQAX8HVPyy8jAIDcomhb0JfH6VmFSsfrHXstQaWI+Zi+WYNAtOpeA
         aSPgIW9bGQRYrCX7Z/xnyUgdaY7O8zXpGAvQc1K1iQCV4+5pnWCkmxITk3uMLWxfDhgL
         DGeA==
X-Gm-Message-State: AOAM5318xJK45kn7WHkvctSgoyUJ7fz0NgRfD2QhiUzl9hgFiOcYhCE8
        3HG1Plki9Ho18Mxv8LtnXSJLi0SbMO91udIczWs=
X-Google-Smtp-Source: ABdhPJylVVmpaUkleG9tXewEDLKhVLcqR6nSPXJStEVINZt7LFseQiNV/f6NGvvnp/8kJXNaa6itfw==
X-Received: by 2002:a2e:86ca:0:b0:24a:c44a:aa3b with SMTP id n10-20020a2e86ca000000b0024ac44aaa3bmr3306773ljj.290.1648320094728;
        Sat, 26 Mar 2022 11:41:34 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n20-20020a19ef14000000b0044a212f7845sm1134757lfh.118.2022.03.26.11.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 11:41:34 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 5so18450413lfp.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:41:33 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr13185867lfj.449.1648320093080; Sat, 26
 Mar 2022 11:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220325150419.757836392@linuxfoundation.org> <20220325150420.085364078@linuxfoundation.org>
 <CAHk-=wiaeZKiEk87Sms1sy53m8tT3UCLOoeUBnX1c_1dZ78WjQ@mail.gmail.com> <Yj7oXgoCdhWAwFQt@kroah.com>
In-Reply-To: <Yj7oXgoCdhWAwFQt@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 11:41:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeOrhN_Gznm80==STG1pEbqLMCaZZoeQzZu=NN9GOTgw@mail.gmail.com>
Message-ID: <CAHk-=wgeOrhN_Gznm80==STG1pEbqLMCaZZoeQzZu=NN9GOTgw@mail.gmail.com>
Subject: Re: [PATCH 5.10 11/38] swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
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

On Sat, Mar 26, 2022 at 3:18 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:"
>
> Yes, I've been watching that thread.  This change is already in 5.15 and
> 5.16 kernels, and does solve one known security issue, so it's a tough
> call.

If you're following that thread, you'll have seen that I've reverted
it, and I actually think the security argument was bogus - the whole
commit was due to a misunderstanding of the actual direction of the
data transfer.

But hey, maybe I'm wrong. The only truly uncontested fact is that it
broke the ath9k driver.

           Linus
