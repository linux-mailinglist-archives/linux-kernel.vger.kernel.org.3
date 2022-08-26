Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7735A2887
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbiHZN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiHZN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76157D91CC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661520524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgxwSFOIh54EtZVmIF6eRuoxcZoMjiIGAdMZ3OxKrqI=;
        b=MmHQSTfVb/FaXY2MxwPVEx+znb0iCl2Jz+P1DQ4tLJqHFQ+U5M4WegmMAMYG/nyGFP9MC5
        VYH1LZ9ohOdgja8tOA9yS3KE29CR+UbBiTuxJPY3zsOgk7OqGGRi/tpuYn/o4aAe5ckgui
        uswrZr7PIqxqSSIrB7rwRL9T5Ok37xY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-2qGmffvwMMe1KiByd1PuxQ-1; Fri, 26 Aug 2022 09:28:41 -0400
X-MC-Unique: 2qGmffvwMMe1KiByd1PuxQ-1
Received: by mail-pg1-f199.google.com with SMTP id a12-20020a65604c000000b0042a8c1cc701so857762pgp.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sgxwSFOIh54EtZVmIF6eRuoxcZoMjiIGAdMZ3OxKrqI=;
        b=LhXfIaCkia+NRTSOobPLrLjRmN1iPSq6cb+UBM5NwLQQ5zHEJZba3XOoYLLnpEblvh
         vxNbTwmyBuvdzlFltqloo/mA6Hl8h9suNNIQ0hIXE0RyXXiq+TYb3Hq5MQ0IK143yC4V
         3gsOs4ua1Iuqhd/0fByvpegX8ZaOu2r44bHNJbgrVIEdpsCSDm2ntLIk3VW2JeWSns2p
         SAfY4nOHlMVnWtgyNcq0p7SVfqalU6laeaCEm/A4O6aHNHRdd11XKX9bAjztkYX5TIRj
         LaQI0ES5+xegW1w+az6E8Bn9KeuYT/uIeaUj4ylf3TWWOBm+0CLYUvSr/hK0lJp2HCFd
         Y+XQ==
X-Gm-Message-State: ACgBeo3Lbf++GmGSYwEswlzVPQP4eCh1zHatd+D0PudcQJRg7agngx9e
        WtgpJ3Aiu1uUbhrsSvTAtzglnMahSoh+ItmRLg2qpwUyd/qTxcCz5nd/I2Ngm0mAjiGZxklB907
        +IXW7BRMTEO5H+VFrPSs29BjmIllhe2j+EJKp/Mko
X-Received: by 2002:a05:6a00:15ce:b0:537:24ee:cbcf with SMTP id o14-20020a056a0015ce00b0053724eecbcfmr3794896pfu.30.1661520520372;
        Fri, 26 Aug 2022 06:28:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GXmUOOA8TaJrQGAd0RVSO5V8ppVyacwCExmmyD+lUPx9uKDeCnQ22UA3d09DQa33dIJwDyQ32kbXmPafZg+Y=
X-Received: by 2002:a05:6a00:15ce:b0:537:24ee:cbcf with SMTP id
 o14-20020a056a0015ce00b0053724eecbcfmr3794882pfu.30.1661520520137; Fri, 26
 Aug 2022 06:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220818210144.7915-1-wsa+renesas@sang-engineering.com>
 <bd7275c6-4ebe-de99-75c2-400cfa2e5026@redhat.com> <YwaFRvWw5hi/uWYs@shikoro> <d53a4672-d068-c394-6ab1-058b2d72701f@redhat.com>
In-Reply-To: <d53a4672-d068-c394-6ab1-058b2d72701f@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 26 Aug 2022 15:28:28 +0200
Message-ID: <CAHc6FU4g_6qYsUoFOnfcX5e2=XiZCu76EUy8kFP1AHDW0f6zyQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH] gfs2: move from strlcpy with unused
 retval to strscpy
To:     Andrew Price <anprice@redhat.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram and Andy,

On Thu, Aug 25, 2022 at 11:33 AM Andrew Price <anprice@redhat.com> wrote:
> On 24/08/2022 21:08, Wolfram Sang wrote:
> > Hi Andy.
> >
> >>> -   strlcpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> >>> -   strlcpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
> >>> +   strscpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> >>> +   strscpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
> >>
> >> Perhaps the size should be changed to GFS2_LOCKNAME_LEN to match the size of
> >> the destination, too.
> >>
> >> With that addition, this patch fixes this syzkaller report:
> >>
> >> https://listman.redhat.com/archives/cluster-devel/2022-August/022755.html
> >
> > Linus wrote another summary about strlcpy vs. strscpy use[1]. So, the
> > size argument should be the size of the smaller buffer if the buffers
> > are of different size. GFS2_LOCKNAME_LEN is smaller, so that looks
> > suitable. Shall I resend the patch with the suggested change?
>
> Yes, please. I can't speak for the gfs2 maintainers but I think it would
> be a good plan, as the combination of strscpy and the size change fixes
> a bug.

thanks, I've fixed this in for-next now:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?h=for-next&id=204c0300c4e99707e9fb6e57840aa1127060e63f

Andreas

