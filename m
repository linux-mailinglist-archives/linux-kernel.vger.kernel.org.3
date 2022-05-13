Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F06525982
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376398AbiEMBtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376393AbiEMBtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:49:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E727F12F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38952B828B3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F9AC34114;
        Fri, 13 May 2022 01:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652406549;
        bh=KrxWD2CuSg9dzECF9702XBUPnwyF2cUFYN6lqGyJS4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OI7tWbNycPGvskqqqe1hAO6VTJf2so+OQ4ixn9hlGBABsyXshcWqUcbYMRi2Cuakg
         fgEposrmOERKAGqLqH+QMcxX4DIRDN+SuKu+voWrchvd4vr1SPmBD9AukaVQwDIJPu
         b9R2vSe5t0sVsEA3/kQIjLEikOZz70tS4Vzi7aQQ=
Date:   Thu, 12 May 2022 18:49:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     maobibo <maobibo@loongson.cn>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Message-Id: <20220512184908.0852e1efcb6fd78aea52b557@linux-foundation.org>
In-Reply-To: <69c4f018-2012-8af5-569b-289d2a8a80f5@loongson.cn>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
        <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
        <YmrB/7ehG2kj2RMn@xz-m1.local>
        <20220512173620.2f5175c7a321e6ccea6e58e9@linux-foundation.org>
        <8c1fc6d4-7d3a-85dd-ebd9-fc8e221f1878@loongson.cn>
        <69c4f018-2012-8af5-569b-289d2a8a80f5@loongson.cn>
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

On Fri, 13 May 2022 09:29:07 +0800 maobibo <maobibo@loongson.cn> wrote:

> 
> 
> >> and/or changelogging.
> > Sorry for the late response, the mail is filtered and I did not notice that. The result is not so obvious after bandwidth is improved between nodes, it is only about 1% improvement for specint2006 for 32 core on my box.
> > 
> > Now I do not see negative effective about this patch unless user wants to keep some cores separated from khugepaged daemon process.
> 
> Can we provide an extra parameter to let khugepaged daemon scheduling binded to node or freely? If can, I will provide updated patch.

It has always surprised me that we have a single khugepaged thread.  If
we had a thread per node, you'd be all fixed up, yes?

Ditto ksmd.

