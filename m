Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A644B3042
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354019AbiBKWSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:18:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354011AbiBKWSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:18:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C5B3F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7410761324
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 22:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70D5C340E9;
        Fri, 11 Feb 2022 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644617925;
        bh=1x4MD3h28qH5lSSy2MvLp8Vn4kQQ2lZhTJJA+xdWjx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s35ETBSV+qA6j/KXHTKiY9CFHxBB96s6cMLNL7BSpwonI7obmvlKHVqB9COeoV8gJ
         xQtDsHfTj9LaweADCqCYJypOXJYyjMjzaspp/1F0oUQ9k9GEnrbJZFbtL1UJyHnq5I
         nGlhlPq6lH3M09SCXqdhJnZfvykCrBCbwGWxjEeM=
Date:   Fri, 11 Feb 2022 14:18:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] container_of.h: make container_of const-aware
Message-Id: <20220211141845.d89b77bb5954bdc3e3ee9f1e@linux-foundation.org>
In-Reply-To: <CAA8EJpo_7x28BkvwOma4=-=4ricqRYCb42dXc72i4wcSceyV5w@mail.gmail.com>
References: <20220210170434.3924169-1-dmitry.baryshkov@linaro.org>
        <20220211140523.738c14327b03647f535c4df8@linux-foundation.org>
        <CAA8EJpo_7x28BkvwOma4=-=4ricqRYCb42dXc72i4wcSceyV5w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2022 01:10:09 +0300 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On Sat, 12 Feb 2022 at 01:05, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 10 Feb 2022 20:04:34 +0300 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >
> > > container_of() macro has one major drawback. It does not check whether
> > > the passed ptr has a const pointer, the result will always be a
> > > non-const pointer. Use a _Generic() construct (supported since gcc 4.9
> > > and Clang 3.0) to teach container_of that if converting a const pointer,
> > > the returned pointer should also have the const modifier.
> > >
> >
> > Nice idea, but my x86_64 allnoconfig build explodes with zillions of
> > warnings.
> >
> > In file included from ./include/linux/list.h:5,
> >                  from ./include/linux/module.h:12,
> >                  from init/do_mounts.c:2:
> > ./include/net/sock.h: In function 'sk_entry':
> > ./include/linux/container_of.h:17:42: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> 
> Are these warnings legit? In other words, is the code converting a
> const pointer into a modifiable one?

It is indeed doing that.

static inline struct sock *sk_entry(const struct hlist_node *node)
{
	return hlist_entry(node, struct sock, sk_node);
}

Which is a pretty rude thing to do.  What was the point in that const arg?

> I've stumbled upon this in drm
> drivers.
> How do we proceed with this patch?

They all need to be fixed up :(

You could take a shot, if you have the time.  If not, bug the relevant
code's owners about it.  But we can't add a patch like this, blow up
everyone's builds and wait for various people to fix up the fallout!

