Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8756259574E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiHPJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiHPJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:57:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD20194;
        Tue, 16 Aug 2022 02:18:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v2so14042036lfi.6;
        Tue, 16 Aug 2022 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Kk2g2IEl/Ua+BBCBiaozArRy7OGG11VduF5q3BhTDG0=;
        b=KcBiWrctfetchJMsY/eFWVoCsx3SblR9qr6NI6BPQ60NgilShdjZlJUj4AiV5t0Yz1
         QLi+cwFAww1Sh0xZjHgdFm2wXeNc1qu+yYPcoCpbHeauU5+BHlq8vB3ETrA+3wNlMNAq
         YfbF3VYWZjWcHbXYEqnmKbHbidsO/eQQGJjM3gLluTqbtBegGjkkFls9VZZOLZYpzsB/
         kt2bO+DyeinL1VidVfznhy9aVsAasdL03No67OrGbIRpxJ9O733KT4e2UUBk18Sg6RIE
         BvRr9ja784eIHZZDWo5KueuM0LZCwwgjFh7PRZkYjhHV500L74V1q7n0lwlIANYOoPvV
         fvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Kk2g2IEl/Ua+BBCBiaozArRy7OGG11VduF5q3BhTDG0=;
        b=GZVhmcHyprqs3B5Z9jKNl0dcyq41VPIwmEkZZLmFWh+YgL+xFCjZTBrpOfxPUezfO+
         Inrwlb/5IywmbNkERF2mxrffqbXFhKdhS2ggb4GoTASsUm6akD/+TTeBbPo8zDHjIWhO
         ict1jbDHwMf/FAOCuwTX7Qxy+/11uUu9ly3nAMYuGqf38ZoJhmYP3OasmTbTyjN2Hlxf
         lQt98I+VEIyiXSmPUQvp+ygsET4D1unYSdKR4omOdHik7lsITT7bRljriQQ7FAd2wkVw
         9of+w/u/Ya01ni7oxnNUsScYDdHMPcxmhI4bRfF7kecWWgOYxincSnfLYCI17K3DmHP9
         51xA==
X-Gm-Message-State: ACgBeo1D+F8lS/ln7U8nwO0jNVpk0EVrSZnO1KCfx0oOMy2LCO+HOX/m
        T5nxWXKFWZ4B01CHzfyeAU3WLe6vKxm1WNcIN/Sdb3RF7EcEOg==
X-Google-Smtp-Source: AA6agR7PDcg9fUP4aVag2k2cXXyHGw1wbNV0WesqmcGnmlmXEndYbcZ7+VdLCCjesog4PO6/2bAL/31vc+5aUkDs4mU=
X-Received: by 2002:a2e:b88c:0:b0:25f:eae4:74ff with SMTP id
 r12-20020a2eb88c000000b0025feae474ffmr6545964ljp.48.1660641515791; Tue, 16
 Aug 2022 02:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220815175114.23576-1-konishi.ryusuke@gmail.com>
 <YvqP/f2P2YgIIO9U@ZenIV> <CAKFNMomyjXpsz-=BtG+G3q1J7CFUBMEfP13FfxwhWB==9qb++w@mail.gmail.com>
 <YvrQ8xO9Lx7rdKq8@ZenIV> <CAKFNMoniwM5x0w03cezGTFDWt=apNmGWpur83+vjghg3zcawpQ@mail.gmail.com>
 <CAD-N9QW5-kVR85t1canTqrF9RMkOjC1Z2q8BSQKxLwaay97Mgg@mail.gmail.com>
In-Reply-To: <CAD-N9QW5-kVR85t1canTqrF9RMkOjC1Z2q8BSQKxLwaay97Mgg@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 16 Aug 2022 18:18:18 +0900
Message-ID: <CAKFNMonVb6s3Cey5riXFwd+C3wy87fHbMUtnq3SXooXgsSD5yA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix use-after-free bug in nilfs_mdt_destroy()
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Aug 16, 2022 at 12:25 PM Dongliang Mu wrote:
> > Dongliang (or Jiacheng?), would it be possible for you to post a revised patch
> > against inode_init_always() that moves the call of security_inode_alloc()
> > instead of i_private initialization (as Al Viro said in a nearby thread [1]) ?
> > If you have time, I would like to leave it to you since you wrote the
> > original patch for inode_init_always().
>
> Sure, I will post a v2 patch that moves security_inode_alloc to the
> location just prior to
>         this_cpu_inc(nr_inodes);
> with proper commit message.
>

I saw you already sent the v2 patch on linux-fsdevel, etc.
Just thank you for your quick follow.

Regards,
Ryusuke Konishi

> >
> > [1] https://lkml.kernel.org/r/CAO4S-mficMz1mQW06EuCF+o11+mRDiCpufqVfoHkcRbQbs8kVw@mail.gmail.com
> >
> > Thanks,
> > Ryusuke Konishi
