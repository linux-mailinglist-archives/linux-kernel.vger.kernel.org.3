Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43F525629
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358240AbiELUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiELUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:00:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F04704F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D527B82B1B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09F4C385B8;
        Thu, 12 May 2022 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652385652;
        bh=gj5imhNP1kGbjLtES03/wUeaRho9QAjqu8qpTgUzxvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YKi3IOX2stMb8eNuUxfBVl80Bs/rLWGkKHxwnnm2xhETa4PR35vXp6B4jd3pFWtNT
         QrZYRMmndeMN7V6bkN7d0VUgVVRdDvuO+FsB621k0G5bzU0G2SIfEja6m+zE0lQTnS
         UkwQdGNsNYDLkKWHHvf7jgUHC/0V3RwyGSYVa+II=
Date:   Thu, 12 May 2022 13:00:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     liqiong <liqiong@nfschina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change "char *bdi_unknown_name" to
 "char bdi_unknown_name[]"
Message-Id: <20220512130051.94a0c53e5d1498292473975d@linux-foundation.org>
In-Reply-To: <20220512082637.24649-1-liqiong@nfschina.com>
References: <20220512082637.24649-1-liqiong@nfschina.com>
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

On Thu, 12 May 2022 16:26:37 +0800 liqiong <liqiong@nfschina.com> wrote:

> "char bdi_unknown_nam[]" string form declares a single variable.
> It is better then "char *bdi_unknown_name" which creates two
> variables.
> 
> ...
>
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
>  
>  static struct class *bdi_class;
> -static const char *bdi_unknown_name = "(unknown)";
> +static const char bdi_unknown_name[] = "(unknown)";
>  

heh, fun patch.  We actually do this quite a lot.  

	grep -r "^[a-z].*char \*[a-z].*= \"" .

is a pathetic pattern which catches a lot of them.


However.  I expected your patch to shrink the kernel a bit, but it has
the opposite effect:

hp2:/usr/src/25> size mm/backing-dev.o
   text	   data	    bss	    dec	    hex	filename
  21288	   9396	   3808	  34492	   86bc	mm/backing-dev.o-before
  21300	   9428	   3808	  34536	   86e8	mm/backing-dev.o-after

Even .data became larger.  I didn't investigate why.
