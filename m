Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAF4B7229
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiBOQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:14:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbiBOQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:14:01 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D29E02D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:13:51 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id b5so19013155qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ypn/aYhmXOciMlfqAueEjzIefCRey5nIsCwsmgIaFyY=;
        b=M05Qq9KLA8RA/K4rgZh8Lyc5eMuEySX+Ry8WzMfSzm5+VZy2e572WzK5dx7cb9f/s2
         GcX0Uukp2v8wej6E1jLCuPNVOXZpVrqdwy9JNOJjadsWI3IU/34PPNDVdnu80pyOhVcs
         dKaSNObBW0j+55nBBPpEao2XIqvb7u12hlmcND1Mdk+YBSiZoLsDA4vicbMcAkyNumyk
         DhYryeQROUrahMCawnYnQHjjaASneqPFZpBTRoC2bxoA1o0Gs5z4da/PCYTDjWa9Uq35
         XJe9Zt+iNzaH0vssCa847XcKyINklOusgsgty68boxvD5NTnJXq3IMlbxcLbFtje+ogh
         A5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ypn/aYhmXOciMlfqAueEjzIefCRey5nIsCwsmgIaFyY=;
        b=XUiG/ceUnn5oiLqPFNK5liFwCrEUFy8EVasjHSkk6OKP3mmv0cEvDuSH7X6qSCH1Ck
         46WsQaQj3xGfPSxkroE7Ci/IkN1qTTq7BNDYBcGvXQX/Dq9heW8WQF+HcUuqAUv/I9Cy
         re0YVezdmgFMdWhg5SER2HztlH//iS38pe6wEAxAF5GOy4tLkiQbAMi/X25rayF/qy+w
         wMHewsWAp21TB0oEfxdELeZGEHSjz688u0U4N9ngjJhyNev5zodco/PgZbpmQrrcgF2x
         KejimWAlP6/mxurt54Q9oj+wgxN10yzpPLXlOPWjLR8b0rEPuicyK4VbOhyrMirtpIik
         Udyg==
X-Gm-Message-State: AOAM533/05p/gUeeeCFdcwZLF8GGqVWCi9uon6c79ecmGtL3wXnHqEz6
        Rsg/RWK7wgaA69sz7jsxt+1q+A==
X-Google-Smtp-Source: ABdhPJzckpK/aLbVPcqxjj0MTWY9sCyxas2zreD1jK0ipt/37kTFObu882WaGo6NHke162vUMLOVbw==
X-Received: by 2002:ac8:5d8a:: with SMTP id d10mr3252911qtx.279.1644941630211;
        Tue, 15 Feb 2022 08:13:50 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s9sm16641251qki.101.2022.02.15.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:13:49 -0800 (PST)
Date:   Tue, 15 Feb 2022 11:13:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, CGEL <cgel.zte@gmail.com>,
        Minchan Kim <minchan@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm: page_io: fix psi memory pressure error on cold
 swapins
Message-ID: <YgvRPJh44VkX1+JV@cmpxchg.org>
References: <20220214214921.419687-1-hannes@cmpxchg.org>
 <20220214144805.fa389f495fdfb07b40526f70@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214144805.fa389f495fdfb07b40526f70@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 02:48:05PM -0800, Andrew Morton wrote:
> On Mon, 14 Feb 2022 16:49:21 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Once upon a time, all swapins counted toward memory pressure[1]. Then
> > Joonsoo introduced workingset detection for anonymous pages and we
> > gained the ability to distinguish hot from cold swapins[2][3]. But we
> > failed to update swap_readpage() accordingly, and now we account
> > partial memory pressure in the swapin path of cold memory.
> > 
> > Not for all situations - which adds more inconsistency: paths using
> > the conventional submit_bio() and lock_page() route will not see much
> > pressure - unless storage itself is heavily congested and the bio
> > submissions stall. ZRAM and ZSWAP do most of the work directly from
> > swap_readpage() and will see all swapins reflected as pressure.
> > 
> > Restore consistency by making all swapin stall accounting conditional
> > on the page actually being part of the workingset.
> 
> Does this have any known runtime effects?  If not, can we
> hazard a guess?

hm, how about this paragrah between "not for all situations" and
"restore consistency":

IOW, a workload doing cold swapins could see little to no pressure
reported with on-disk swap, but potentially high pressure with a zram
or zswap backend. That confuses any psi-based health monitoring, load
shedding, proactive reclaim, or userspace OOM killing schemes that
might be in place for the workload.
