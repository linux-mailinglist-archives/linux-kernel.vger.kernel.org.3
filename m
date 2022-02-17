Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A254B976C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiBQEGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:06:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiBQEGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:06:34 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6321FC7C;
        Wed, 16 Feb 2022 20:06:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id h5so2247997ioj.3;
        Wed, 16 Feb 2022 20:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUSoUHSjJMmplw4ZjLL+BTqGLSZGqO8tdAI7uDdrahY=;
        b=UYiGhdWEhgHiJjsOB0bDbRCJ1zOUL1OgbrBA5OeIavQp6/7KKSDbRu5Uo4BdZ1mHq0
         ebZxyXZEYOMa7GBZcnqcaUMdxjsejCMGpG7WwQqGSLKPRL+y5KtR3A77UKxDKeIZBaWs
         AVha5oqKOLU9YYWM+7owD97Xo7Xq3XBSxXyHgzpUgDWNVQHfEqqtgqQCynB8Ko/wvsgJ
         mdEjnQ2ncNqqCfwlmzV9+cIyXduBmz8uDizsLg6qkytymfVz8xnU44SJawU6oM+ToC3e
         iAM7NGTggh8L/Gb8NTrl+cYl2TWrTpYfGOREen19/6qyfvMckBrrzlCKKaLjgLbGmo53
         TwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUSoUHSjJMmplw4ZjLL+BTqGLSZGqO8tdAI7uDdrahY=;
        b=15SuEp3I7ACQtqXD/hC4W+h88SOlaAN/fbkbBMBl2uKhpr8VnDLPvXhrv8KPnxMrcw
         yf3yRVx6g72zBeHw3/rvMCatd/0i7YqgY3yjocOTK/dslbBO60g1QAgJK2vPSVaJqDbH
         fbqiZgNFGb2axVAllIuRhZWi4wcP8qfh3VWzMZiT82J7rPIE+GnAAJETw7vJzdmtnhNz
         zMLccpto9xM5gfUxjJOAEIrM+sAi00Bthzce0PoYrqOse1YcLWVBqfDQzkjpKyxV5flp
         jGpkeSSJ2+OB+n72VhbvabvhDpdsNi9aEZnyyQJa4SFrtxqbc8OCx3gAxsuUWVufqH3O
         ZalA==
X-Gm-Message-State: AOAM531Ftmm2NqU0rJYd+ALZYNx8WuZ3d2AvrZHButmIROPR/1evBta2
        yFz9+4EqDJI6oTqGefIb1lKyYWPj/XdjWfzUnzWdIZIYMvo1Ms31FHY=
X-Google-Smtp-Source: ABdhPJx187pKc6+DoMP2EEChkSUVbFdwtcAYM42qX69rLIAIylW4QfCWKbxmGNW6de2pHCO2YXluGQ+nWYcuShjy6gM=
X-Received: by 2002:a02:b903:0:b0:30e:49cb:e65c with SMTP id
 v3-20020a02b903000000b0030e49cbe65cmr750449jan.164.1645070780775; Wed, 16 Feb
 2022 20:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20220211001345.3429572-1-gch981213@gmail.com> <20220216195423.GA17551@alpha.franken.de>
In-Reply-To: <20220216195423.GA17551@alpha.franken.de>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 17 Feb 2022 12:06:09 +0800
Message-ID: <CAJsYDVJw2DJX97cRwoAofzq_jL0GhyaC5j7UuT6OzC=Lp8WkSQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: mt7621: do memory detection on KSEG1
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, Rui Salvaterra <rsalvaterra@gmail.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi!

On Thu, Feb 17, 2022 at 3:57 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Fri, Feb 11, 2022 at 08:13:44AM +0800, Chuanhong Guo wrote:
> > It's reported that current memory detection code occasionally detects
> > larger memory under some bootloaders.
> > Current memory detection code tests whether address space wraps around
> > on KSEG0, which is unreliable because it's cached.
> >
> > Rewrite memory size detection to perform the same test on KSEG1 instead.
> > While at it, this patch also does the following two things:
> > 1. use a fixed pattern instead of a random function pointer as the magic
> >    value.
> > 2. add an additional memory write and a second comparison as part of the
> >    test to prevent possible smaller memory detection result due to
> >    leftover values in memory.
> >
> > Fixes: 139c949f7f0a MIPS: ("ralink: mt7621: add memory detection support")
> > Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > ---
> >  arch/mips/ralink/mt7621.c | 36 +++++++++++++++++++++++-------------
> >  1 file changed, 23 insertions(+), 13 deletions(-)
>
> applied to mips-fixes.

Oops.

As I mentioned in a previous mail, this patch has two cosmetic problems:
1. misplaced bracket in commit message "Fixes" tag
2. incorrect second test pattern: I meant to flip all the bits in the
first pattern,
   but I used "!" instead of "~". Any value will work just fine but it
looks weird
   to construct a zero using !MT7621_MEM_TEST_PATTERN.

Should I send a second patch to fix this patch or send a v2 of the
original patch?

-- 
Regards,
Chuanhong Guo
