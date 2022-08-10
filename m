Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9269B58E78F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiHJHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHJHCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:02:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3674DD4;
        Wed, 10 Aug 2022 00:02:29 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f14so10520651qkm.0;
        Wed, 10 Aug 2022 00:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rSmYRwhSKwMnBfTi/jvVtIpAV+E+QFfv+LYuFK98Rr8=;
        b=Ccc7NPfOHdvS0O0vrc/nj68VpzBfetEjYqQjxZrtwhLsHaaJDWn1ig8iR2K6A0bLJe
         OfANXDbQ1cPkgQ25cTK91SNrNkoDu0YA7k1uTvkcDlrcBT5emBgWrlTmE8ndvyrNxQDB
         pyxrOQb4eCgQpiictOmdEdPMpZKANBX37bgaqJvsRVMuQL7tEE2+V3HKIFefiAPDs6qg
         neYUuO2lw54h6JEtHOAtNTsq0/K+50wio1mC1M63o6tG3WMyI2OeXHNn3GhPRzO3Wb6Y
         B01tgXEIrvbCmCfFWjlfIZOPv8uDRASc1DIzVx6oX2H0pLBLx2l20CwPnfmIxRHiJplM
         2Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rSmYRwhSKwMnBfTi/jvVtIpAV+E+QFfv+LYuFK98Rr8=;
        b=SHK0e3lugutYJKhhT/+F5x+WaCSQprVoL8m+79KoUrJ7ORzzw61x49ljW7Z6klUW96
         iWVYByfH033nCipEhbNNscRsBtoCymCE3N2l8fTHci4cVVFQBVum2RA+Ymsc8xxX3pu8
         VsCz/gBRmCVgn6M7FhdTXtvfi+H6WhWN+0vJQ9olN/gKyph9D79WRKt/qx+JmqAv5cm8
         SBcmnzn7CkA5GXQunFQR37JNAc6EQnmEkTyBNG3XPbOZo/Yd7BV3/wkqMh6PyikKQE2k
         2BIT48xyvOCsI/DRsgSCyXxxqhs5QDs25XnFKX/qubiJ3sYFMt/60d/Bi1WdXi5M5rjv
         iQBw==
X-Gm-Message-State: ACgBeo0GNFbSHnNGn8sJBGi/DQXew/egTgx5x+ic8tSJW/tcivhuU23n
        DvcS4HBZaxS+Jf1f140Fg0UPaSudxQcaIUJP8bOVV9uJjjKy9w==
X-Google-Smtp-Source: AA6agR4gWyi1fxIF/0g49kxhXHqr1UPm2AD2RbHwI63O516dEPTfcbmWPCbmNRsrNNvhRnIrxCD1/aqsFvFW7kIBp1M=
X-Received: by 2002:a05:620a:4007:b0:6b5:d88b:6d42 with SMTP id
 h7-20020a05620a400700b006b5d88b6d42mr20185709qko.180.1660114948091; Wed, 10
 Aug 2022 00:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220809165615.9694-1-ubizjak@gmail.com> <20220809220511.GI3600936@dread.disaster.area>
 <20220809230244.GJ3600936@dread.disaster.area>
In-Reply-To: <20220809230244.GJ3600936@dread.disaster.area>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 10 Aug 2022 09:02:16 +0200
Message-ID: <CAFULd4YkSG4RES8=P5BjF8JH5En++XN6LpVNd391eYcy_baeyw@mail.gmail.com>
Subject: Re: [PATCH] fs/xfs: Use atomic64_try_cmpxchg in xlog_grant_{add,sub}_space
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 1:02 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Aug 10, 2022 at 08:05:11AM +1000, Dave Chinner wrote:
> > On Tue, Aug 09, 2022 at 06:56:15PM +0200, Uros Bizjak wrote:
> > > Use `!atomic64_try_cmpxchg(ptr, &old, new)` instead of
> > > `atomic64_cmpxchg(ptr, old, new) != old` in xlog_grant_{add,sub}_space.
> > > This has two benefits:
> > >
> > > - The x86 cmpxchg instruction returns success in the ZF flag, so this
> > >   change saves a compare after cmpxchg, as well as a related move
> > >   instruction in the front of cmpxchg.
> > >
> > > - atomic64_try_cmpxchg implicitly assigns the *ptr value to &old when
> > >   cmpxchg fails, enabling further code simplifications.
> >
> > Do the two cmpxchg operations have the same memory ordering
> > semantics on failure?

Yes. The API also provides _acquire, _release and _relaxed variants of
both, atomic64_cmpxchg and atomic64_try_cmpxchg. On x86, these two
functions actually compile to the same CMPXCHG instruction, the
difference is only in how the comparison is handled:

      15:    48 09 c2                 or     %rax,%rdx
      18:    48 89 c8                 mov    %rcx,%rax
      1b:    f0 48 0f b1 16           lock cmpxchg %rdx,(%rsi)
      20:    48 39 c1                 cmp    %rax,%rcx
      23:    74 2a                    je     4f <xlog_grant_add_space+0x4f>

becomes:

     29c:    48 09 ca                 or     %rcx,%rdx
     29f:    f0 48 0f b1 16           lock cmpxchg %rdx,(%rsi)
     2a4:    75 d2                    jne    278 <xlog_grant_add_space+0x8>

And as demonstrated in [1], even the fallback code compiles to a
better assembly.

[1] https://lore.kernel.org/lkml/CAFULd4bc54+_FmJ=f++zzz99mR8r5c11-Y49pz86Yb8G3dyJpA@mail.gmail.com/

> > > This patch has no functional change.
> >
> > The patch looks ok, but ....
> >
> > ... I'm about 2 hours away from posting a patchset that completely
> > removes the cmpxchg and the new grant head accounting has
> > significantly lower fast path overhead. It also opens the door for
> > tracking more than 2GB of log space in the grant heads.
>
> FYI, the original RFC for this was posted a bit over a month ago:
>
> https://lore.kernel.org/linux-xfs/20220708015558.1134330-1-david@fromorbit.com/

-static void
+void
 xlog_grant_sub_space(

[...]

- old = head_val;
- new = xlog_assign_grant_head_val(cycle, space);
- head_val = atomic64_cmpxchg(&head->grant, old, new);
- } while (head_val != old);
+ atomic64_sub(bytes, &head->grant);
 }

I actually wondered why these two functions were not implemented as
atomic64_{add,sub}. Of course, this is a much better solution that
renders the proposed patch obsolete.

BR,
Uros.
