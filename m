Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281354CEF1D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiCGB35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiCGB34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:29:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D51DA67
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:29:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC236B80FA0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A7FC340EC;
        Mon,  7 Mar 2022 01:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646616540;
        bh=YzKQcW85kilXLK0lI0q4go4qeAhC208GWMpPgLmVtlE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zHl0OD16VJbtrKgXB2kUJeGFTxOByE8+z6Hu9OHDMuwW/nwv3+SCWbyuw35pBLm33
         r8Ijl0eT2IJrJuKpKekJeeSbwg566kECmAztVMgAVu2CvntYN4hVwmFQV+zDI8Y7lX
         STdm/3i0GK1BPWAkJCvKzTJZCrVHi6xUfsa1ceTI=
Date:   Sun, 6 Mar 2022 17:28:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     xkernel.wang@foxmail.com
Cc:     linux@dominikbrodowski.net, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        luc.vanoostenryck@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/initramfs.c: check the return value of kstrdup()
Message-Id: <20220306172859.2a35d07284b6aee209b9dcfb@linux-foundation.org>
In-Reply-To: <tencent_DE1C3D1422E1DD4A35FFDE2048CC48B94E08@qq.com>
References: <tencent_DE1C3D1422E1DD4A35FFDE2048CC48B94E08@qq.com>
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

On Fri,  4 Mar 2022 17:27:34 +0800 xkernel.wang@foxmail.com wrote:

> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kstrdup() is also a memory allocation function which is similar
> with kmalloc() in some way. Once some internal memory errors
> happen, it will return NULL. It is better to check the return
> value of it so to catch the memory error in time.
> 
> ...
>
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -139,8 +139,12 @@ static void __init dir_add(const char *name, time64_t mtime)
>  	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
>  	if (!de)
>  		panic_show_mem("can't allocate dir_entry buffer");
> -	INIT_LIST_HEAD(&de->list);
>  	de->name = kstrdup(name, GFP_KERNEL);
> +	if (!de->name) {
> +		kfree(de);
> +		panic_show_mem("can't duplicate dir name");
> +	}
> +	INIT_LIST_HEAD(&de->list);
>  	de->mtime = mtime;
>  	list_add(&de->list, &dir_list);

We often assume that memory allocations cannot fail in __init code.  If
the kernel runs out of memory at this stage, we have very deep problems
and it's virtually impossible that execution would have got this far.


