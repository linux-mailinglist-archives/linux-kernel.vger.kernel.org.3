Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261185258FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357041AbiEMAgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiEMAgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:36:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425642497D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D48B82B61
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AECDC385B8;
        Fri, 13 May 2022 00:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652402181;
        bh=YamEZ3xW3F+5L2aoDDsxvt+p4+fp1TcaW7VG7lie2EA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DlXLjpB7tjOcsoABHj2WqvpbCi0VJ4jfI7RsczkeARZrYrD3y/p6FOFOwCSQH04bw
         xX4J4DwetmBpMrV9MwEV2vwVbVGI4TDgYKWamlclDiLGHkkfbfeqR25GeHLd+19qin
         50jvhr221UvJad6SIV8AlGnzvwkeMeYzSvH+xRCw=
Date:   Thu, 12 May 2022 17:36:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Bibo Mao <maobibo@loongson.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Message-Id: <20220512173620.2f5175c7a321e6ccea6e58e9@linux-foundation.org>
In-Reply-To: <YmrB/7ehG2kj2RMn@xz-m1.local>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
        <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
        <YmrB/7ehG2kj2RMn@xz-m1.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 12:34:07 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Thu, Apr 28, 2022 at 05:17:07PM +0200, David Hildenbrand wrote:
> > On 17.03.22 07:50, Bibo Mao wrote:
> > > collapse huge page will copy huge page from general small pages,
> > > dest node is calculated from most one of source pages, however
> > > THP daemon is not scheduled on dest node. The performance may be
> > > poor since huge page copying across nodes, also cache is not used
> > > for target node. With this patch, khugepaged daemon switches to
> > > the same numa node with huge page. It saves copying time and makes
> > > use of local cache better.
> > > 
> > > With this patch, specint 2006 base performance is improved with 6%
> > > on Loongson 3C5000L platform with 32 cores and 8 numa nodes.
> > 
> > If it helps, that's nice as long as it doesn't hurt other cases.
> > 

Quite a bit of doubtful feedback and we have yet to hear from the
author.  I'll drop the patch.

Bibo, please resend at a later time if you feel the patch remains
desirable.  Please attempt to address the feedback via code changes
and/or changelogging.

