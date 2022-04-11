Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4E64FC269
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348630AbiDKQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348625AbiDKQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:33:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BBD3135B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j9so19550585lfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTF2lMXV9wxXsFaw1Yi/+Bse2dwqUs9rz7Y6bCytCHk=;
        b=eiXuxRx5rFIGmeq+qfzK/Xn1pQaet+b/9Zs+2H9POBlnw0ck60/0qGYLtHx/djEgly
         pZzBAjknNQpN4cx4F9pMy5jT60GShUDw43qPsexrJUZtJDq0wVRIv5FNa6cgd3CdMmNY
         bzWBDUh6ZkBVhtjpQd3F8gLgssTUHnNEZ7JXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTF2lMXV9wxXsFaw1Yi/+Bse2dwqUs9rz7Y6bCytCHk=;
        b=CMLMYgnzixuO8jloqci9AX8uLRC8R7ZoEVXzpYKuCSa3rDxbF8Z1Mqou8oarkkDK+V
         l4I3hgmYe0/t+GNOPUlWs1UkpJMh/n+Vtqnihq8rbBVUvvbIASxt8l9cYYBP8v9CzMAC
         yvSSFdhXVqHraJXzmpr1QJsoL6tZL0GDEbwJRkJBNcI+aTLDgqeLp0MdUNlMmmDjGlIQ
         wUpSlxa26yFCb7mALHdywCPguXuft2mhPOFIBapaf2Lu/qOXhAMf0OF4ERBK/HVPmWj9
         XpbLWT//i0yKr58yPIgqBuirnkOf/T913CDORrdj3LLway7XVr2uULSr6+4zWCVFPwoP
         PmFg==
X-Gm-Message-State: AOAM531c5hk9vEjOFzCtH6erFFUnvMYSUM2M0uW7w1XKQffibRHAjwQH
        mPfqRzPWNNikteNPxTkFVV8GDSzge+lKF4CR
X-Google-Smtp-Source: ABdhPJwFqfGdv1F48OGxpHIKVwEupRF8yiewTi8ilJY9V8A/gvS2tMOXG1kRhiagIEFp6eHK9zUvTg==
X-Received: by 2002:ac2:4e0b:0:b0:46b:aec3:50d5 with SMTP id e11-20020ac24e0b000000b0046baec350d5mr1962202lfr.602.1649694665246;
        Mon, 11 Apr 2022 09:31:05 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u2-20020a197902000000b00448a4a7cfc3sm3361311lfc.136.2022.04.11.09.31.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 09:31:04 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u19so7529621lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:04 -0700 (PDT)
X-Received: by 2002:a05:6512:2291:b0:46b:b72b:c947 with SMTP id
 f17-20020a056512229100b0046bb72bc947mr98236lfu.531.1649694663647; Mon, 11 Apr
 2022 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Apr 2022 06:30:46 -1000
X-Gmail-Original-Message-ID: <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
Message-ID: <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Apr 11, 2022 at 4:43 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> If you run a program compiled with OpenWatcom for Linux on a filesystem on
> NVMe, all "stat" syscalls fail with -EOVERFLOW. The reason is that the
> NVMe driver allocates a device with the major number 259 and it doesn't
> pass the "old_valid_dev" test.

OpenWatcom? Really?

> This patch removes the tests - it's better to wrap around than to return
> an error. (note that cp_old_stat also doesn't report an error and wraps
> the number around)

Hmm. We've used majors over 256 for a long time, but some of them are
admittedly very rare (SCSI OSD?)

Unfortunate. And in this case 259 aliases to 3, which is the old
HD/IDE0 major number. That's not great - there would be other numbers
that didn't have that problem (ie 4-6 are all currently only character
device majors, I think).

Anyway, I think that check is just bogus. The cp_new_stat() thing uses
'struct stat' and it has

        unsigned long   st_dev;         /* Device.  */
        unsigned long   st_rdev;        /* Device number, if device.  */

so there's no reason to limit things to the old 8-bit behavior.

Yes, it does that

  #define valid_dev(x)  choose_32_64(old_valid_dev(x),true)
  #define encode_dev(x) choose_32_64(old_encode_dev,new_encode_dev)(x)

  static __always_inline u16 old_encode_dev(dev_t dev)
  {
        return (MAJOR(dev) << 8) | MINOR(dev);
  }

which currently drops bits, but we should just *fix* that. We can put
the high bits in the upper bits, not limit it to 16 bits when we have
more space than that.

Even the *really* old 'struct old_stat' doesn't really have a 16-bit
st_dev/rdev.

           Linus
