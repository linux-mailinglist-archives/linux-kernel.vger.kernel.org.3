Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C94B2FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353779AbiBKVx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:53:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiBKVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:53:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18091C6D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:53:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE0A6B82A94
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 21:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23257C340E9;
        Fri, 11 Feb 2022 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644616400;
        bh=OKkifUPDbiPipbbjhfkrwiFe3zvLH8D2eSdINnSo9XM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AUF7n4LlZxdh+nVBkGdadBE5TUTAQtmTu2EwVHGaa1p5Ukrzz2Gv+wmOWqwRahnuY
         9Wiw9sGELlzHfNgjjn8f9lsX0wtEnpe638yMBTtJ5heHRloKaOxtT4UOEYuWs0g50/
         3tvIPHK+M7th800I2S1aTpmyKFgWp0e8QWRdvJEo=
Date:   Fri, 11 Feb 2022 13:53:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     shy828301@gmail.com, ziy@nvidia.com, ying.huang@intel.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] migrate: Wrap CONFIG_DEVICE_PRIVATE dependent
 function declarations with ifdef
Message-Id: <20220211135319.1ff408fa6a7c5c5755ac2c87@linux-foundation.org>
In-Reply-To: <20220209094753.22022-1-sj@kernel.org>
References: <20220209094753.22022-1-sj@kernel.org>
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

On Wed,  9 Feb 2022 09:47:53 +0000 SeongJae Park <sj@kernel.org> wrote:

> 'migrate_vma_{setup,pages,finalize}()' functions are defined under
> CONFIG_DEVICE_PRIVATE, but their declarations are not.  This commit
> wraps the declaration under the config to minimize confusion.
> 
> ...
>
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -162,9 +162,14 @@ struct migrate_vma {
>  	unsigned long		flags;
>  };
>  
> +#ifdef CONFIG_DEVICE_PRIVATE
> +
>  int migrate_vma_setup(struct migrate_vma *args);
>  void migrate_vma_pages(struct migrate_vma *migrate);
>  void migrate_vma_finalize(struct migrate_vma *migrate);
> +
> +#endif /* CONFIG_DEVICE_PRIVATE */
> +

We often don't do this.  The advantage is that errors are revealed at
compile time rather than at link time.  But the downside is quite a lot
of maintenance overhead and messier-looking header files.

And that maintenance overhead is significant, partly because we can get
this wrong but the kernel will still happily compile and boot!  So the
only way to maintain these things is by inspection.

