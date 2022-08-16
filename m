Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998B5952FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiHPGtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiHPGtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:49:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCC5222883;
        Mon, 15 Aug 2022 20:13:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u1so13095812lfq.4;
        Mon, 15 Aug 2022 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Zh9L3GMyN0bAgm1VZ5joh7GoecxvY4X4P34K9smg9ao=;
        b=DCJaZHlRDaLYCQnt5L/NE3PWbEAGjyuvd10TuFktBd16TZV17FdCS9hgDC0ppYunaP
         q9E5NpecMnY4E4AFkxNe/0Fg5Rpb0+9bBEr/d/CBE7bGj2b9z9Pn1ehRMS2UkLwThYTg
         p0lh1UNazF8H2Kjpui8hPnrP6QPIPbwE03vMS4l8Rwi9ShypZKI5ROv6WBckPQQrSZhR
         maWp0FjTDz61asqVWcvIDUXlWmZOLTQwSbeJVZNDaSR3V3nC/6imXUiNaemBXyYUV+Xo
         TpKZnIQgdPV+bx3JAuU5MZ3brQ40b6mDdnyBbCSpGVb8oMAbtD8Uta1aQ6cBRtlM5Okf
         /YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Zh9L3GMyN0bAgm1VZ5joh7GoecxvY4X4P34K9smg9ao=;
        b=4TU/LqPfqveV7cWpV1nx/qJHS+RGfQBQkrtSx1H0z9n6EHS0jrN1l6qBqiqttUQM+b
         iRTZqs1Z1ABDyISpOii12r6Qigkg3yevS4HdC3KHfTOeIgJcLMzKF7lO2pnDznHv0d5c
         BaS9MyJiC9Kc1gcy4ewPllWDHAIfnrwbW+ax3rQDXlA/jApSrGewpXVxSvTIGWw0bSoC
         NM/Q4QLzxOkGzSObi8xpHG7cMVVFX5WCnxhix7mk0W8VtxlXmhkZMroMuHqDWQuT32UR
         7WH3tnVu3znZ4W+owhH2U/RSMTtNy7ALwvp44plhEq08F1Vbf/yN/QLLt4LjKvF8eySf
         59Ug==
X-Gm-Message-State: ACgBeo3QGXPCFrqjDiK/EJuclTuR2KoMZbpHfxqpXF+y3feZ2zMNHHPG
        LzwVoAccmj/RUSOjLnEHm42nosoibrQFO+MOZhk=
X-Google-Smtp-Source: AA6agR7w9kHMvJPn3RTwXOaTy5l2S6jr1zt04RQSK+VEW6psSbCcgrh8HwLIcO+KxlrpQRLFBT9Th59sTSKMT+dd004=
X-Received: by 2002:ac2:52a5:0:b0:48b:2905:21ed with SMTP id
 r5-20020ac252a5000000b0048b290521edmr6041789lfm.120.1660619512328; Mon, 15
 Aug 2022 20:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220815175114.23576-1-konishi.ryusuke@gmail.com>
 <YvqP/f2P2YgIIO9U@ZenIV> <CAKFNMomyjXpsz-=BtG+G3q1J7CFUBMEfP13FfxwhWB==9qb++w@mail.gmail.com>
 <YvrQ8xO9Lx7rdKq8@ZenIV>
In-Reply-To: <YvrQ8xO9Lx7rdKq8@ZenIV>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 16 Aug 2022 12:11:35 +0900
Message-ID: <CAKFNMoniwM5x0w03cezGTFDWt=apNmGWpur83+vjghg3zcawpQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix use-after-free bug in nilfs_mdt_destroy()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Mudong Liang <mudongliangabcd@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiacheng Xu <stitch@zju.edu.cn>
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

On Tue, Aug 16, 2022 at 8:04 AM Al Viro wrote:
>
> On Tue, Aug 16, 2022 at 05:34:12AM +0900, Ryusuke Konishi wrote:
>
> > Yes, I agree it's better if security_inode_alloc() is moved to the end as
> > possible in the sense of avoiding similar issues.
> > But, would that vfs change be safe to backport to stable trees?
>
> Yes.
>
> > It looks like the error handling for security_inode_alloc()  is in the
> > middle of inode_init_always() for a very long time..
>
> Look at the initializations done after it.  The only thing with effects
> outside of inode itself is (since 2010) an increment of nr_inodes.
>
> > If you want to see the impact of the vfs change, I think it's one way
> > to apply this one in advance.  Or if you want to fix it in one step,
> > I think it's good too.  How do you feel about this ?
>
> IMO that should go into inode_init_always(), with Cc:stable.  If you
> (or Dongliang Mu, or anybody else) would post such variant with
> reasonable commit message, I'll pick it into vfs.git and feed to Linus
> in the next window.  E.g. into #work.inode, with that branch being
> made never-rebased, so that you could pull it into your development
> branch as soon as it's there...

I agree with your thoughts on the course of action.
Andrew, I withdraw this patch.

Dongliang (or Jiacheng?), would it be possible for you to post a revised patch
against inode_init_always() that moves the call of security_inode_alloc()
instead of i_private initialization (as Al Viro said in a nearby thread [1]) ?
If you have time, I would like to leave it to you since you wrote the
original patch for inode_init_always().

[1] https://lkml.kernel.org/r/CAO4S-mficMz1mQW06EuCF+o11+mRDiCpufqVfoHkcRbQbs8kVw@mail.gmail.com

Thanks,
Ryusuke Konishi
