Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D864D3C96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiCIWHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiCIWH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:07:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1C101F06
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:06:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF04561B20
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196FFC340E8;
        Wed,  9 Mar 2022 22:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646863588;
        bh=tCTg9iZ+l1L+YIDqIMzEn+ib+sAI8kfh/KLRU9a8GdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DnDofeAkAHu7ywYFNpGq2nl3tLnncdXVE9rvFsKyBSNOIOJOafkOL8QwbSS0koDnB
         EQNB30prTqIQk3+HpHzIGRuDWGKWvLTwoQxbJSjYnMpd7r+DUF6ObJafeblDamGT+/
         WS9QaikU/SW99qMzNydh5dTfD6RU571d84XqAqYY=
Date:   Wed, 9 Mar 2022 14:06:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fs: fix lru_cache_disabled race in bh_lru
Message-Id: <20220309140627.eeaa069daa921dbef64f8970@linux-foundation.org>
In-Reply-To: <20220308180709.2017638-1-minchan@kernel.org>
References: <20220308180709.2017638-1-minchan@kernel.org>
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

On Tue,  8 Mar 2022 10:07:09 -0800 Minchan Kim <minchan@kernel.org> wrote:

> Check lru_cache_disabled under bh_lru_lock. Otherwise, it could
> introduce race below and it fails to migrate pages containing
> buffer_head.
> 
>    CPU 0					CPU 1
> 
> bh_lru_install
>                                        lru_cache_disable
>   lru_cache_disabled = false
>                                        atomic_inc(&lru_disable_count);
> 				       invalidate_bh_lrus_cpu of CPU 0
> 				       bh_lru_lock
> 				       __invalidate_bh_lrus
> 				       bh_lru_unlock
>   bh_lru_lock
>   install the bh
>   bh_lru_unlock

What are the user-visible runtime effects of this bug?

Is a cc:stable needed?

Should there be a reported-by?

Thanks.

