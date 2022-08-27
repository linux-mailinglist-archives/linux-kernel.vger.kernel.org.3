Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F95A3424
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 05:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbiH0DTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 23:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiH0DTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 23:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24FAB420
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 20:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 471ED61DCE
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2770CC433D6;
        Sat, 27 Aug 2022 03:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661570382;
        bh=l8bh0UlqdzPrtkN84q9zam96jL20dAmmD1ZErVl3gEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t5iUjlv6LPyc6Md5JdsZoQqIcCardc+IfYCGnm4NiFchCaQ1EqVxwfp82AB4wXlmx
         w5u+ogExFpSIHDvlgSZl7OdBKoNu3yEmG60oS1BM5rJHe3l0Q2IuVz48qEftrsGdQP
         tiDDxgGQS55yEwaPAj9By1hGkwDL0dNyp7FSEVJ0=
Date:   Fri, 26 Aug 2022 20:19:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <pasha.tatashin@soleen.com>, <shakeelb@google.com>,
        <sieberf@amazon.com>, <sjpark@amazon.de>,
        <william.kucharski@oracle.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <minchan@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH V5] mm: fix use-after free of page_ext after race with
 memory-offline
Message-Id: <20220826201941.de6ed957a0d6547b2d501c19@linux-foundation.org>
In-Reply-To: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
References: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
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

On Fri, 26 Aug 2022 12:26:33 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.

What are people's thoughts on a -stable backport?  It looks like the
bug has been there for years and the means of hitting it are obscure
and the patch isn't minor, so I'm thinking no?

