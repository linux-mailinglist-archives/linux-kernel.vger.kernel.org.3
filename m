Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C602F519C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbiEDJyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347832AbiEDJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:54:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22951183BA;
        Wed,  4 May 2022 02:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3D25B82330;
        Wed,  4 May 2022 09:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B35C385AF;
        Wed,  4 May 2022 09:50:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XRHm7UCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651657829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mu7frDY3tF1mpPfvDkSZ+QoF/RCrkyl1/4guVXYmJNM=;
        b=XRHm7UCvVR4SkJlHIC4MC9fzP8jGzY9bC6MB7LKcWyM2oxz75UAmXryEZuG+uXtEt+TS6m
        7BAEw/STne95pFe9MsLMoE+2DBW1cTXOv9w+WUq95lhrV5h8AlAwgLvsRQZIkmVFBqGCvw
        uuHyzaCbjNRtOiRO4a1R394qbiLNAuM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ecf50f8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 09:50:29 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ec42eae76bso9208577b3.10;
        Wed, 04 May 2022 02:50:28 -0700 (PDT)
X-Gm-Message-State: AOAM532f2AD+BUC3f6X3qR/wpdS7R3sEXnCkqlYTEATIGfrI8HKmZnfi
        qONlLhCU97ZbFl+8kU7/3rlxBnkiv7WE8O0WGW8=
X-Google-Smtp-Source: ABdhPJzuMzs1bKkUTBLTJ00IJAbYgtTI+hqFcHguOCIXiEYbsg60S5jxhxQzD4lN6i9iMWN9Mzs+4DwAmgNgps7YOKU=
X-Received: by 2002:a81:cc3:0:b0:2f7:d52b:92bf with SMTP id
 186-20020a810cc3000000b002f7d52b92bfmr18719777ywm.231.1651657827651; Wed, 04
 May 2022 02:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <alpine.LRH.2.02.2205040453050.22937@file01.intranet.prod.int.rdu2.redhat.com>
 <YnJFViBFIgYOl7/2@smile.fi.intel.com> <24c9a856-be10-e9b3-b26d-e6ced9e13c63@gmail.com>
In-Reply-To: <24c9a856-be10-e9b3-b26d-e6ced9e13c63@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 4 May 2022 11:50:16 +0200
X-Gmail-Original-Message-ID: <CAHmME9roTbjorBTzJGqJjmu7fgE_8w4RV8Pnwkqnoa1V+0kahg@mail.gmail.com>
Message-ID: <CAHmME9roTbjorBTzJGqJjmu7fgE_8w4RV8Pnwkqnoa1V+0kahg@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 11:47 AM Milan Broz <gmazyland@gmail.com> wrote:
> BTW we use exactly the same code from Mikulas in cryptsetup now (actually the report
> was initiated from here :) and I added some tests for this code,
> you can probably adapt it (we just use generic wrapper around it):

I use something pretty similar in wireguard-tools:
https://git.zx2c4.com/wireguard-tools/tree/src/encoding.c#n74

The code is fine. This is looking like a different issue somewhere
else in the OpenRISC stack...
