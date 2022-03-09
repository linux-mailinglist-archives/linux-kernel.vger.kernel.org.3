Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2BC4D294B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiCIHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiCIHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:12:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6396ECC57;
        Tue,  8 Mar 2022 23:11:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e3so1388944pjm.5;
        Tue, 08 Mar 2022 23:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRcojdKFkUrzcCxTuVNdK1onU1312nQ1Uevvd7PHIkI=;
        b=KXYwwrpv7fPdjKDvyfPqgrR0KKByHaugnhUItQbb8kh2d2NiBboHduKjSD5mSTS4DK
         L97VgyDwqow5cNP8VyVZktho6f3hp2W+EuCoohYVa6u9A9jCOi6uzrU3q8cMrfGFo1G/
         cvG/woSM6AMp1+AGpvU8/qwcNpnVbMGl2txaPDASXmBs3W6JcoEdVDzj3gPw766vMI8U
         FfYLgJN0qZQrx8SGQT7i+/+EQTiZZ3CHDTXXzcMy3GI+Es2GkrKPjbDnpZAlJ/PoeD00
         xGUiPGo9vrNr3vLkhnfkT4IwJumJQPONK8JF4jXf1eU4s+SOvPYKXTBJ6mVRH9DbYxjv
         kYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRcojdKFkUrzcCxTuVNdK1onU1312nQ1Uevvd7PHIkI=;
        b=MO8vcgtEe4sQk/leXTKlR0M+Cbpp8k8wumr/V1/i1nrua4VkYzwhWO2R8li1QJDEPv
         0RvMIRcb6Oa9R6dSjpe17pzYra9zPxY9G5S+B6SXgzZzgMyYQ1YSeNkJ3sAGoUY8tNvg
         lXftSZxpWCoHeB3zT3MlX8WgUvthMV2bdgyep666nO17lVp2zLWEgjb9E1l5452l+8KC
         vbOlDOIAOVTSLFVQPjzLOUNSM2xz8WbwsdIdBDHbJNKwMstZQYmpjCuPhJK+Oq7vdFYL
         GDuhxn3HtuFK5kTyTJUgZnT25XoyCAWyygERF+BSxO3p9Euz9/WWBtmgR2XB8Mn/crb9
         XJ1g==
X-Gm-Message-State: AOAM533JhdWB6l/NYji22Ef/ZEyYgWTiL9WA5utr4BFqIvQ726d7yV5J
        1D5HSApopPOfDGrQALEaOHKwd56eXHTgsjQWGA==
X-Google-Smtp-Source: ABdhPJx7Y9tMsgrHNCFHvVb+R6kcxLDVwEdD+wPmSxpzfNfTeIicJ0IQT3rT29l/gVAxaOVxTDHZSM1g6Fy0HM3gq1Q=
X-Received: by 2002:a17:902:8a91:b0:14f:969b:f6be with SMTP id
 p17-20020a1709028a9100b0014f969bf6bemr21600350plo.161.1646809914993; Tue, 08
 Mar 2022 23:11:54 -0800 (PST)
MIME-Version: 1.0
References: <CAMhUBj=i4MJ6KH_UU5dy8e+DmviRg4EFA-D5zyD=XfRi9Ma=pg@mail.gmail.com>
 <YihJm4xuJEDXbcJx@infradead.org>
In-Reply-To: <YihJm4xuJEDXbcJx@infradead.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 9 Mar 2022 15:11:43 +0800
Message-ID: <CAMhUBj=ZXeGvRv4fJqSKLEkwAm8x664X=sh4PVr7DR83CB7zbA@mail.gmail.com>
Subject: Re: [BUG] block: sx8: Invalid wait context in carm_queue_rq()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 2:30 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> I guess you don't actually have the hardware and just built it into the
> kernel?

Yes, I use the virtual machine instead of the real hardware.

> Because I've been pretty sure that this driver is pretty much dead,
> so maybe we need to go ahead and just remove it.

I found that there were a few active commits to this driver last year,
so I assumed it was still "alive".
Maybe it's time to clean up these unused drivers.

Thanks,
Zheyu Ma
