Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8299F4B7A44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbiBOWMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:12:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiBOWMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:12:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2127CC3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FD09B819E8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B71C340EB;
        Tue, 15 Feb 2022 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644963158;
        bh=BPqqLIY3ImvN6qeE7/pDaAPIFxvHggrWbmxk+038ayU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aS08xiLS+FrfVdHvVqNYRDX80mKKpb7SU6cVoK3/6CDQovYEqaCG3fJAuNwKp9HAm
         DJArx1+kQyeRUkvESL8jBIeuwk2s+Hm8c19xUGa50rwZ9NMpUk1X+5qIHP/7HTGYwF
         7dmdZBCHE8ZJINEJ2DSn4gBQFoSawWk5O1c1lYdA=
Date:   Tue, 15 Feb 2022 14:12:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     hughd@google.com, mike.kravetz@oracle.com, kirill@shutemov.name,
        songliubraving@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Fix shmem huge page failed to set
 F_SEAL_WRITE attribute problem
Message-Id: <20220215141236.de1a3eca3a8a52d04507c50f@linux-foundation.org>
In-Reply-To: <20220215073743.1769979-1-cgel.zte@gmail.com>
References: <20220215073743.1769979-1-cgel.zte@gmail.com>
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

On Tue, 15 Feb 2022 07:37:43 +0000 cgel.zte@gmail.com wrote:

> From: wangyong <wang.yong12@zte.com.cn>
> 
> After enabling tmpfs filesystem to support transparent hugepage with the
> following command:
>  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> The docker program adds F_SEAL_WRITE through the following command will
> prompt EBUSY.
>  fcntl(5, F_ADD_SEALS, F_SEAL_WRITE)=-1.
> 
> It is found that in memfd_wait_for_pins function, the page_count of
> hugepage is 512 and page_mapcount is 0, which does not meet the
> conditions:
>  page_count(page) - page_mapcount(page) != 1.
> But the page is not busy at this time, therefore, the page_order of
> hugepage should be taken into account in the calculation.

What are the real-world runtime effects of this?

Do we think that this fix (or one similar to it) should be backported
into -stable kernels?

If "yes" then Mike's 5d752600a8c373 ("mm: restructure memfd code") will
get in the way because it moved lots of code around.

But then, that's four years old and perhaps that's far enough back in
time.

