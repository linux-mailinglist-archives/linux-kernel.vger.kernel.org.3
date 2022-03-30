Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD194EBD54
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbiC3JNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbiC3JNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:13:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778F221B83
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:11:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bh17so683196ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iHEjOeawVE4TGGyzTMRHiW0bGnAT2V/UGHXTsEjK33c=;
        b=BAquZY3ZcJjJbGzdnLDnwoPAfCF3aPDs9DaAype0z44smc9sVNP1FgWzkid0jvZ3Vj
         UvZWNFM2xk4UP4B52AOmycyyuQrqVZ6j9nXJFevQ6rcpEU0Hx5SDi9tKaIrdcUAl6Bvc
         JRlRSLrtam3JCljIXAmoKkiDddKYchCtttn8z1X0tXtwC/jnmVLAU1Sha+qWRvHFp7aO
         Ch43V6BVwrYt5S7ri2LtZpKLoluilwbAD5N7Abfo8fm9aC++ql6ASD60Fb5l7lalJFNf
         A+FAqlvxbRHFMTrpZztQ/M1bnq4u4S7hGU8teieRi2Mdq3AJ7NfaY7VtuiobV/umUGmk
         rmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iHEjOeawVE4TGGyzTMRHiW0bGnAT2V/UGHXTsEjK33c=;
        b=plCKA6OB+jvA2xjvUWQ5HUVAn9c0q4Iz3Ei84jlrMPG1Nd/ZuUxgkFhldEAqwCI93P
         NB+onVnM9RQbZ5YWIBGn1SHPI2d3Eigtm7v4SeVsaPuy+7dDYzEIFmf2fSmJNAKvGqw2
         p2Se1IMEF9HZkTx3aH60WWqBZ3vB/37P21kUox6T6hMIOPZC//bferHyCmFUYX3BT78P
         nm7IvzavgdToYO8q7NGpPsMl8e5NTsGqg1jxf+addWLV/HKzjyhDh5K/F0Z/9TN3/1ZE
         tvCApeIaA8uu6ql1yFvbpR8Oq9FEPbt2lgCyKu4exzGuhwZtgpeKAfp4typM58ciKuYe
         E/rg==
X-Gm-Message-State: AOAM533D6/2f/5AvanrA7JSwZeGMoPULqa4nnj5nH7QMdnk1edMybWpJ
        mhw7mxmSAH/yh4AWOePhpHNqAtUe9UHO3SFH1HU=
X-Google-Smtp-Source: ABdhPJzFkCqohT94+eLa4A9BUZrPPE9lpe/sT/ADFwRxWI+b4DtrCQ+SExJM2i0502sH2S+yfSHLrpTINcFKgPqyodQ=
X-Received: by 2002:a17:907:1b08:b0:6da:b62a:762a with SMTP id
 mp8-20020a1709071b0800b006dab62a762amr37926168ejc.60.1648631517183; Wed, 30
 Mar 2022 02:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b@epcas1p2.samsung.com>
 <20220330052502.26072-1-jaewon31.kim@samsung.com> <YkQPefdRc+hxIXEV@dhcp22.suse.cz>
 <YkQZi5WFAwbqWKNZ@dhcp22.suse.cz>
In-Reply-To: <YkQZi5WFAwbqWKNZ@dhcp22.suse.cz>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Wed, 30 Mar 2022 18:11:46 +0900
Message-ID: <CAJrd-Ushm_t6voCEuTpx=Y9cms2QsRPvjkO-JAdLcwcedZ3k-A@mail.gmail.com>
Subject: Re: [PATCH] zram_drv: add __GFP_NOWARN flag on call to zs_malloc
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, s.suk@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 3=EC=9B=94 30=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:49, M=
ichal Hocko <mhocko@suse.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 30-03-22 10:06:18, Michal Hocko wrote:
> > On Wed 30-03-22 14:25:02, Jaewon Kim wrote:
> > > The page allocation with GFP_NOIO may fail. And zram can handle this
> > > allocation failure. We do not need to print log for this.
> >
> > GFP_NOIO doesn't have any special meaning wrt to failures. zram
> > allocates from the memory reclaim context which is a bad design IMHO.
>
> Btw. I forgot to mention that GFP_NOIO doesn't have any different
> meaning than GFP_KERNEL from this (PF_MEMALLOC) allocation context
> because this request will never perform a reclaim.

Thank you for reply

Yes it was kswapd with PF_MEMALLOC, but I thought this zs_malloc could
fail on direct reclaim context.

I think zram is gracefully handling this ENOMEM situation, it actually
accounts the failed count as zram stats.
The failed page will be tried to swap out again later.

Yes I need to look into more about this memory shortage.
But I thought there were too many ALLOC_HADER requests in a short
time, and I want to see other
allocation failure logs like one with GFP_ATOMIC instead of this
zs_malloc failure log.

> --
> Michal Hocko
> SUSE Labs
