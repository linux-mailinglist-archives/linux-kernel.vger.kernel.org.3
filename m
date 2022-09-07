Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FCC5B1071
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIGXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIGXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:34:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCD7AEDA0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5D50B81F28
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D909C433C1;
        Wed,  7 Sep 2022 23:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662593649;
        bh=8qHDzjTjq+FV8EUAuXd3KU8y3Cmqs9z+Bxt12Z9Z744=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d02IjSQKwvtfFUmR3Ty8Hi4MJJl/YGPwkLLtpaOgir0yCYPur1O/yfTODk6eNem9o
         /msKMYI5LkuTE1TEBYGwBoG8AIycwX/8AQKZ6qtKWUeQWOFT6XRNmmWEP12FyBa2CE
         HQJu/WZjHcFXa9RuJwfabXtL7FxUkTphYQzazPFA=
Date:   Wed, 7 Sep 2022 16:34:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: avoid unnecessary page table walk for
 __get_user_pages
Message-Id: <20220907163408.f9a9152314d33afc74cb1f0c@linux-foundation.org>
In-Reply-To: <20220906024401.133336-1-chenwandun@huawei.com>
References: <20220906024401.133336-1-chenwandun@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 10:44:01 +0800 Chen Wandun <chenwandun@huawei.com> wrote:

> It is no need to walk page table and find pages if faultin_page success
> and __get_user_pages does't care pages at all, so directly handle next
> page.
>
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1198,7 +1198,10 @@ static long __get_user_pages(struct mm_struct *mm,
>  					   PTR_ERR(page) == -EMLINK, locked);
>  			switch (ret) {
>  			case 0:
> -				goto retry;
> +				if (pages)
> +					goto retry;
> +				else
> +					goto next_page;
>  			case -EBUSY:
>  			case -EAGAIN:
>  				ret = 0;

Looks right to me.  I redid the changelog somewhat:

: There is no need to walk page tables and find pages if faultin_page)_
: succeeds and __get_user_pages)_ doesn't care about populating the pages[]
: array.  So directly go on to handle the next page.

