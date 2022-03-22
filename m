Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5B4E45A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiCVSC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiCVSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9E674D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C1B3B81D36
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB27AC340F0;
        Tue, 22 Mar 2022 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647972040;
        bh=8WWwmLlNe1EYEj4DzrflF2uVllZ805Y7mQ/as9vhofY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ir6LCK+GyiOi/zjhFD5pbZy7dhL5u5cGtV+O8Jff/V4zCM3894EBbQ79PpCVYMjma
         /IUWINLVxM8uVNJm4hZ1UNC3Q4i6xeQ/oj3z5yuVKYX6vaQUSj9wpJMlrgcf8M3nRV
         AdLovh+I4YDjES9G0ZEwDT+1qiCot8YHPDfg/m/0=
Date:   Tue, 22 Mar 2022 11:00:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Cc:     Sean Anderson <seanga2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: add switch between culling
 by stacktrace and txt
Message-Id: <20220322110039.f90dabd5f41fb0300cb6be29@linux-foundation.org>
In-Reply-To: <623932d7.1c69fb81.31089.1923SMTPIN_ADDED_BROKEN@mx.google.com>
References: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
        <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
        <20220321133825.6f003c62381edbab361a8d96@linux-foundation.org>
        <623932d7.1c69fb81.31089.1923SMTPIN_ADDED_BROKEN@mx.google.com>
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

On Tue, 22 Mar 2022 10:22:05 +0800 Yinan Zhang <zhangyinan2019@email.szu.edu.cn> wrote:

> on 2022/3/22 4:38, Andrew Morton wrote:
> 
> > These comments were not responded to:
> >
> > On Mon, 29 Nov 2021 21:23:41 -0500 Sean Anderson<seanga2@gmail.com>  wrote:
> >> This is working as designed. IMO there's no point in separating
> >> allocations like this which differ only in PID and timestamp, since you
> >> will get no grouping at all.
> >>
> >>> The info of second block missed. So, add -c to turn on culling
> >>> by stacktrace. By default, it will cull by txt.
> >> Please keep the default to actually do something in the cull step.
> >>
> >> ...
> >>
> >>> @@ -162,6 +171,9 @@ int main(int argc, char **argv)
> >>>    		case 't':
> >>>    			cmp = compare_num;
> >>>    			break;
> >>> +		case 'c':
> >>> +			cull_st = 1;
> >>> +			break;
> >> Can we set a "cull_cmp" variable like cmp?
> >>
> >> Looking forward, I think something like
> >>
> >> 	page_owner_sort --cull=stacktrace --sort=times foo bar
> >>
> >> would be nice.
> >>
> > Which is unfortunate.
> >
> > I'll send the patch in to Linus anyway, as many other patches
> > syntactically depend on it.  Please work with Sean to address these
> > issues and lets get this resolved over the next few weeks.
> >
> > Also, please cclinux-mm@kvack.org  on changes to page_owner.
> >

(top-posting repaired)

> I replied to the email a few months ago. Did you receive it?

I didn't, and it isn't in the list archives at

https://lore.kernel.org/all/20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn/T/#u
