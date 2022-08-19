Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B24599446
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346248AbiHSEw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiHSEwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:52:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4363C6FC7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81903B82569
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE0FC433D6;
        Fri, 19 Aug 2022 04:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660884741;
        bh=pJsR9cSORbtbMymP+m9MvHTaCihfu9PX9SIGrheKZmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=o637CJLbB7MYcFkOf3iJtO6JpyRqT6H/5C4jnwxHKJxPdd8ZbddPbFkBo+Owi/yid
         XwC+pxHsAnOS7lk8zjN3euHYHC8T1TKW7LPAUZ1VzFVNxyvbUZAJX05KUIX0W0YcTe
         zutCqedwg2t+ZGWH9IsEbLWKOLFpN1rToKXWL/HQnGuaYzniR+aYnDlfZmHCLur+18
         A9rskX98zkia9sdqJOJtmTL37CwwpUIM+SvRSc2c/jGT2ltJtUDi7TTj/YphImTOX8
         jIOurMsYjVJ+aDtwDBX0ZqunReNK3u1gU4A8bAOyztUXzd72GBHUkzvSLwyU8v/DGR
         gBxt8Sf1ZFALQ==
From:   SeongJae Park <sj@kernel.org>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mm/damon/lru_sort: Move target memory region check to head of func
Date:   Thu, 18 Aug 2022 21:52:04 -0700
Message-Id: <20220819045204.21834-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <c0c5c013-9355-c394-afff-ed25b0c456b8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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

On Fri, 19 Aug 2022 10:47:58 +0800 haoxin <xhao@linux.alibaba.com> wrote:

> 
> 在 2022/8/19 上午10:28, SeongJae Park 写道:
> > Hi Xin,
> >
> >> 在 2022/8/19 上午1:11, SeongJae Park 写道:
> >>> Hi Xin,
> >>>
> >>>
> >>> On Thu, 18 Aug 2022 18:57:31 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >>>
> >>>> In damon_lru_sort_apply_parameters(), if "monitor_region_start"
> >>>> and "monitor_region_end" is not a valid physical address range,
> >>>> There no need to run the remainder codes in it.
> >>> The function, 'damon_lru_sort_apply_parameters()', checks validity of
> >>> parameters and construct the DAMON context one by one.  For example,
> >>> 'damon_set_attrs()' returns an error if the parameters are invalid.  So the
> >>> intended flow is,
> >>>
> >>> 1. check DAMON attributes parameters,
> >>> 2. apply DAMON attributes parameters,
> >>> 3. check scheme parameters,
> >>> 4. apply scheme parameters,
> >>> 5. check target region parameters, and
> >>> 6. apply target region parameters.
> >>>
> >>> Therefore what this patch does is making the target regions validity check to
> >>> be done earlier than validity checks of other parameters.  There is no special
> >>> reason to check the region earlier than others.  Also, this change makes the
> >>> flow of the function a little bit weird in my humble opinion, as the flow will
> >>> be
> >>>
> >>> 1. check target region parameters,
> >>> 2. check DAMON attributes parameters,
> >>> 3. apply DAMON attributes parameters,
> >>> 4. check scheme parameters,
> >>> 5. apply scheme parameters, and
> >>> 6. apply target region parameters.
> >> Ok, understand what you mean,   my fix looks ugly,  buy any apply above
> >> are not not necessary if one of them checks failed, why not check all
> >> fisrt and then apply them, like this:
> >>
> >> 1. check target region parameters,
> >>
> >> 2. check DAMON attributes parameters,
> >>
> >> 3. check scheme parameters,
> > The parameter values could be changed by users after the check, so we should
> > cache those somewhere anyway.  In other words, we cache those in the DAMON
> > context.  Therefore I think the above works were not totally waste of the time.
> > Also, because the parameters applying functions like 'damon_set_attrs()' does
> > the check and applying of the parameters together, I feel like current flow is
> > natural.
> 
> Ok,  Thank you for your detailed  explain, just keep it. but there still 
> a problem in damon_lru_sort_apply_parameters
> 
> if (!monitor_region_start && !monitor_region_end &&
> 		!get_monitoring_region(&monitor_region_start,
> 			&monitor_region_end))
> 
> if (!monitor_region_start || !monitor_region_end ||
> 		!get_monitoring_region(&monitor_region_start,
> 			&monitor_region_end))
> 
> the '&&' should fix to '||',  anyone checks fail, it should return ?

No.  The code is for setting the monitoring region as the biggest System RAM
resource only if the user didn't set both 'monitor_region_start' and
'monitor_region_end'.


Thanks,
SJ
