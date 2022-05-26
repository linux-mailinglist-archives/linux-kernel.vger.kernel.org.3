Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE15348F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiEZCnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiEZCnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:43:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C5A5010;
        Wed, 25 May 2022 19:43:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f9so644957ejc.0;
        Wed, 25 May 2022 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iji6/qx50HM9mugQAAZFzqNwMWEZ4NiXrC4wwL5plK0=;
        b=FNnAl3u5Raha6JvLBX1X0s8ScB07hNmFt2jqpf2RR3gBZh3HRsqrriMEgUgCFglB/3
         GTgdemVxTBjJeJL4+yfHvfzBUATUah0VBDNGwnDrgYU0lcQO97NW2c3q2gTVuoARtYB2
         ByrJwXQOFCBEPb4faiP1R16zul7ZoKZY+eBzDes/CupOEjwFkvaH+pAZ4ThfcEI9ne2s
         u9TAfoazNks6t4HxyQJa0VRxJt/NzwEB3yerArkL2pTIoRQ/CIx6Mhe7JbW4JdIXWccm
         tQq1OOzqvEzdhu66sjFP4f12nCuXn+D+Ij4wZKkqcz4sofkOHJpnP/Huo3G0LFXDx1ML
         ZMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Iji6/qx50HM9mugQAAZFzqNwMWEZ4NiXrC4wwL5plK0=;
        b=g8gbxUh8ljl3k4kY2pEE8oIIS1Np1RADv57YUOL7FHGOSqGI9q0fcV/0BnnGs1uKZw
         PM56HczO9QrE1SxRw/QI+7Yb8Yeszx/zFCDHQmFgDv2qT3LJlr8GC2tP8Oltlf10UtjP
         QLClZGAHVmukQyW26xT4AYk11tNb/0MZFcgj2whyhIUsq4y1DBnFDRi7nO4lKC9p6aKm
         cUR4rZT0fJeaR9MEPcn57YSW0stNPAD01Seqn6tslJ8WBBP1pgkhTKIVpwbxwls8TedM
         Rblz7yuHziEOobXP0b+HrGee0RUKQKfbub1rFQuUtOwPM+J/kecbaW0Yb7PV6XZXDFzf
         Cp2Q==
X-Gm-Message-State: AOAM532kFdDzFpTieHEfzq2M31nNgVj3ar3/SdWF8wJ5ohT4UGIsUpW0
        /5IPy98gE4nLFLwWeTBA7cQ=
X-Google-Smtp-Source: ABdhPJxhG5Ou+xqvL9zi16Kzz3X6qIMPkTdxsqM9GhM06UDYs1eLvfzgAFK7DcPdoJxMy442z63YCw==
X-Received: by 2002:a17:906:58ca:b0:6fe:c53a:68f6 with SMTP id e10-20020a17090658ca00b006fec53a68f6mr20094635ejs.10.1653532980970;
        Wed, 25 May 2022 19:43:00 -0700 (PDT)
Received: from gmail.com (0526E16E.dsl.pool.telekom.hu. [5.38.225.110])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906590600b006feece1e053sm98294ejq.90.2022.05.25.19.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:43:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 26 May 2022 04:42:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <Yo7pMP7QWWJRimt1@gmail.com>
References: <20220526082850.5869472e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526082850.5869472e@canb.auug.org.au>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commit
> 
>   e281c26b08b3 ("Merge branch into tip/master: 'perf/urgent'")
> 
> is missing a Signed-off-by from its author.
> 
> And for some reason, it is not actually a merge commit.

Script fail on my side: a new script of mine handling the tip:master merge 
tree didn't handle fast-forward merges particularly well.

I've fixed it via --no-ff & re-spun the -next branch. There's no difference 
in the resulting kernel source tree.

Thanks,

	Ingo
