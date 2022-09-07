Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6865AF8DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIGAKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIGAKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF6966117
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 056E361721
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3F9C433D6;
        Wed,  7 Sep 2022 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662509449;
        bh=EHSJp+ae8REEPQ3Px3yhok9m5oIog6h9LNiUxvHSGd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1bemAhIhg3JdZaj5tYJq15ketgTqOMnWrsxVHkWnnjJMB/1LFjjdBsf/wgehvekGb
         gPfZtnhOCqYp2EgYXr7JvbsXTFKrVopvV/XHWdoRZ6PPje+xgkqxxal0uQTv7ULj99
         0tptLnKljV+dI7l/zLpeWN4qGosqmKctp9QqxD9w=
Date:   Tue, 6 Sep 2022 17:10:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Cheng Li <lic121@chinatelecom.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: use mem_map_offset instead of mem_map_next
Message-Id: <20220906171048.1cd24a27b71ded17f89ddb00@linux-foundation.org>
In-Reply-To: <Yxd+Nz1wAwiIOWsd@monkey>
References: <1662358159-22780-1-git-send-email-lic121@chinatelecom.cn>
        <Yxd+Nz1wAwiIOWsd@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 10:07:03 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 09/05/22 06:09, Cheng Li wrote:
> > To handle discontiguity case, mem_map_next() has a parameter named
> > `offset`. As a function caller, one would be confused why "get
> > next entry" needs a parameter named "offset". The other drawback of
> > mem_map_next() is that the callers must take care of the map between
> > parameter "iter" and "offset", otherwise we may get an hole or
> > duplication during iteration. So we use mem_map_offset instead of
> > mem_map_next.
> > 
> > Signed-off-by: Cheng Li <lic121@chinatelecom.cn>
> > Fixes: 69d177c2fc70 ("hugetlbfs: handle pages higher order than MAX_ORDER")
> 
> The Fixes tag implies there is a user visible bug.  I do not believe this is
> the case here.  Is there a user visible bug?

A Fixes: with a cc:stable would indicate a user-visible bug.  But IMO a
bare Fixes: is simply a when-to-stop guide to backporters - a
convenience.  And, I suppose, it has some documentation benefit.

And if people are really that interested, they can read the dang
changelog ;)

