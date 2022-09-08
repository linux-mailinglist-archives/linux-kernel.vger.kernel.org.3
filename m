Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B305B2923
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIHWRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIHWQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:16:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCD0E9144
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F0B4B822A6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63755C433C1;
        Thu,  8 Sep 2022 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662675415;
        bh=JE10mbUSQvV4SLEVtxGEewRCL7LxHQ8Z4Hk4Ug6Gx40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqNr4u8E7dl2ZhOS8hXrXPNG6imPpAFM+Tm1VQ8hnxaegmOa2M82ra44QQRl7/JIa
         WmrPKGvDyepk0B6onw7WPRU3Dbpc2DFUyD2EeyhDrmbvLZ4kdq5CTsFhBp4p5gSNFd
         SRHwFAr9HSNX8Eb2fndf9HjwrLKHrW3jMHWbWu7DETrZcEp9+1CVPspNcV8xv3Hb6g
         A/rOrbpG+IyCjtG1F7pTuVdkEXSoNWON5b7Ns7+WkHmpMKKFtriaH3JehvE8D8kS+3
         gAjoBjzWqZkdnO7y0lNbwA7zehcDhXhJ8dh2dDRUCQ4b82+/zBB2Ii4R1woupaxmx0
         dB1JwodMRvxzw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Xin Hao <xhao@linux.alibaba.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: change few functions execute order
Date:   Thu,  8 Sep 2022 22:16:53 +0000
Message-Id: <20220908221653.131120-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908151042.239189ddb1635c0f598c6fd2@linux-foundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 15:10:42 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu,  8 Sep 2022 18:49:47 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hi Xin,
> > 
> > On Thu, 8 Sep 2022 16:19:32 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> > 
> > > These nr_{schemes,regions,contexts,kdamonds}_store() functions are both call
> > 
> > checkpatch complains as below:
> > 
> >     WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> >     #10:
> >     These nr_{schemes,regions,contexts,kdamonds}_store() functions are both call
> 
> I fix that sort of thing.  A lot ;)

Appreciate your efforts always.  If you need any help from my side, please let
me know at any time.

> 
> > > kstrtoint() to get relative values from sysfs interface, if it return an
> > > error, there get kobject instance would be meaningless through 'container_of'.
> > 
> > I was thinking the compiler could do that kind of optimization on its own, so I
> > preferred to make the code shorter.
> 
> Yes, the compiler will do this.
> 
> > This change makes the code slightly longer, while the benefit of the change is
> > unclear.  I'd like to keep it as is unless we get some clear benefit of this?
> 
> I find it a readability improvement.  Puts the initialization in a more
> appropriate place and avoids those nasty tricks to prevent unreasonable
> line lengths.

Agreed.

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
