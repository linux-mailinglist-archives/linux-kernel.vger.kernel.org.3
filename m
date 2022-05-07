Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8052651EA68
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387566AbiEGWDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350158AbiEGWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 18:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EFF1A3A4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 14:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D93B660F19
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 21:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DFDC385A6;
        Sat,  7 May 2022 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651960778;
        bh=Ka1X3YltXKyKrA5wqKviT4NwESbjBhPlX4Lz/VQyqIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nrb95ZZQ19DPLKrY9f0/KQYOZkAtoYQi6gbHeTccHTKEWS0z5hMvyIkyaPC8/aINW
         Ix7m0nunPoxUi32N87IKhjPLRHRtrcr4ydjgQM3/iofEAAAvXw+AGrrWoJRbktlfM3
         gWEVaeesPGd+zf2P6C0gA2fZ0M90TdndEfgJcrxY=
Date:   Sat, 7 May 2022 14:59:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>
Cc:     michel <michel@lespinasse.org>, hughd <hughd@google.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Barry Song" <21cnbao@gmail.com>,
        zhangshiming <zhangshiming@oppo.com>,
        peifengl55 <peifengl55@gmail.com>
Subject: Re: [PATCH] mm: fix align-error when get_addr in
 unmapped_area_topdown
Message-Id: <20220507145937.6dbfc036f99addf9342bc5ce@linux-foundation.org>
In-Reply-To: <2022050211305415626916@oppo.com>
References: <20220412081014.399-1-lipeifeng@oppo.com>
        <20220412142238.93e36cc4095e4e0b362db348@linux-foundation.org>
        <2022041310411426044561@oppo.com>
        <2022050110235766139218@oppo.com>
        <20220501181041.6d53cb9ed54bf697840e36cc@linux-foundation.org>
        <2022050211305415626916@oppo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 11:33:18 +0800 "lipeifeng@oppo.com" <lipeifeng@oppo.com> wrote:

> Hi Andrew：
> 
> Thanks for your quick response.
> 
> > They caused me some merge issues against mapletree, which I had
> > resolved.  Mapletree is dropped at present so I set these patches aside
> > until the next version of the mapletree patches are available.
> 
> Do we have a definite time for the next available version of the mapletree patches?

I merged v2 a couple of days ago.  It should be in mm-unstable then
linux-next early next week.

> Excuse me, is it possible for our patch to be independent of mapletree and brought in separately?

Well, the changelog was rather unclear on the real-world end-user
visible effects of the defect.  When these prioritization decisions are
to be made, it really helps to have a clear view of the impact to our
users.

> 
> > I've been holding your patches until Michel Lespinasse has had time to
> > review them (and hopefully explain them to me ;)).  Please review
> > earlier comments which Michel has provided and ensure that those
> > comments have been fully addressed so we can hopefully move forward on
> > this.
> 
> We will reply soon if Mr.Lespinasse provideds any advices or question.
> And I haven't received any reply from Mr.Lespinasse yet, pls let me know
> if i missed the reply.

There was a big conference last week.
