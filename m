Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF455305C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiFULBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347085AbiFULBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:01:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666229823
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:00:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g4so9343659lfv.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuiB2lEEMCk0w/w/b+ALLeZ6vsLYTAjuyX+rwIjOEXk=;
        b=aqaw3+BMMU0j938NWoZbZ9UP6JuFL0AXN2pvwceLelhH1yoKvwXyL5EgVTxbpxmG/R
         dJaah/AfgOMSCCDdDay6LYB+g2DIBrAXRsVD6wyNYMz2Qgn9rZSdUsSdmHAsm6f8+yVt
         xoJLh5X56XJpSwV6KSW120800VS7yh/dEq5Lg5mzR9zek7I4hkavSCrRt16zo5E9tesf
         CBD2UtOpTGjAU6jpobd4DH0BkziZWqNszjbJX7a+CMhhMig6iZnZboxy9aff3i5hyFey
         /UDiMuL90ho1PdpiAjB5TEeZP0G+mf0yK/e+R5ukV90gvqYwxrTYAIMOVJ6stF8NfVSr
         afBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuiB2lEEMCk0w/w/b+ALLeZ6vsLYTAjuyX+rwIjOEXk=;
        b=P9hlke3HcUAsl4mNbVB4+KlFF+Hmdk4Z+bfS5T2cOLHitY3hAc1+la8DiAzlBM4XxS
         q398ePq4E3xLSF5BdK5N3Ct1GsvavSJ0RR1tYg2DGaXyMTTHRUOeQuRE5L+qi1nkhUD4
         6kflwMVQHKrzXTngb75XqPzTCMDZEALYG/nhtbQshtkaGEqE1hXcqYC/mNR7iucw7IMO
         T5SdXR1H5Lalvax338mlzWi+e9QU8Ywl8n7C9DXtvLvuvi5yZbtkT6F5K11iD51E84jr
         3HP1a63VWiJ/t4OByo2+eZSVWb+Wp9Z05FgU05nJVPkUd3utfz5ZnXpygoKfMvi0Co1D
         fHAA==
X-Gm-Message-State: AJIora9oc9b4X30AC08Oka3B4UFvY68VN004/I0BxgfitJcb9shdOQYt
        XIiNIA4tOI92qqfOGN+8R5sR0bPBlzzTecRnL8g=
X-Google-Smtp-Source: AGRyM1vjPstPhMcfRgUwQXS8N/cl5cvZIXZ3mQrH7rDQ3i/dbq4zsOWG2nTOOO6P5X32unp502ZF7KykuNIxjSSVxyw=
X-Received: by 2002:ac2:484d:0:b0:47f:7ebf:336 with SMTP id
 13-20020ac2484d000000b0047f7ebf0336mr1677240lfy.130.1655809256871; Tue, 21
 Jun 2022 04:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <1653447164-15017-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
 <Yq+PMWlARgDhv8uL@pc638.lan> <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
 <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
 <CAGWkznE5cFfdtmQ2j57goWtpfPGYPsd5Oi3pvb9vcfifodR9OQ@mail.gmail.com> <YrGO4cae/03r3PzP@pc638.lan>
In-Reply-To: <YrGO4cae/03r3PzP@pc638.lan>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 21 Jun 2022 19:00:27 +0800
Message-ID: <CAGWkznFdZ1_jrSWSOPkSDyLY1OSodZBy6MTfdwPKo3VoW67GBg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Christoph Hellwig <hch@lst.de>
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

On Tue, Jun 21, 2022 at 5:27 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > On Mon, Jun 20, 2022 at 6:44 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > > > >
> > > > > Is it easy to reproduce? If so could you please describe the steps? As i see
> > > > > the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
> > > > > glance i do not see how it can accessed twice. Hm..
> > > > It was raised from a monkey test on A13_k515 system and got 1/20 pcs
> > > > failed. IMO, vb->va which out of vmap_purge_lock protection could race
> > > > with a concurrent ra freeing within __purge_vmap_area_lazy.
> > > >
> > > Do you have exact steps how you run "monkey" test?
> > There are about 30+ kos inserted during startup which could be a
> > specific criteria for reproduction. Do you have doubts about the test
> > result or the solution?
> > >
> I do not have any doubt about your test results, so if you can trigger it
> then there is an issue at least on the 5.4.161-android12 kernel.
>
> 1. With your fix we get expanded mutex range, thus the worst case of vmalloc
> allocation can be increased when it fails and repeat. Because it also invokes
> the purge_vmap_area_lazy() that access the same mutex.
I am not sure I get your point. _vm_unmap_aliases calls
_purge_vmap_area_lazy instead of purge_vmap_area_lazy. Do you have any
other solutions? I really don't think my patch is the best way as I
don't have a full view of vmalloc mechanism.
>
> 2. You run 5.4.161-android12 kernel what is quite old. Could you please
> retest with latest kernel? I am asking because on the latest kernel with
> CONFIG_KASAN i am not able to reproduce it.
>
> I do a lot of: vm_map_ram()/vm_unmap_ram()/vmalloc()/vfree() in parallel
> by 64 kthreads on my 64 CPUs test system.
The failure generates at 20s from starting up, I think it is a rare timing.
>
> Could you please confirm that you can trigger an issue on the latest kernel?
Sorry, I don't have an available latest kernel for now.
>
> Thanks!
>
> --
> Uladzislau Rezki
