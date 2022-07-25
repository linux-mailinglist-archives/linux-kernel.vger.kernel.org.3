Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0857FB93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiGYIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiGYImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:42:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CAAA454
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E0B9B80E04
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0B4C341C7;
        Mon, 25 Jul 2022 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658738537;
        bh=mW4KiaBbxGVt+hecbTH1wZkdtUCYbGUAyJEs0eoBkt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPgVy7zyXfOP1D1I3EMnhmEGo5AzpjhxPcKoJY4KffbawM2YnJhLRPTYmNU16DiAa
         3nqqwLyOwGGcEl1oQUBSS7YMwMrCTZFQv2micJP5xi9+esbrRWawR7Ho9PFEtpaMUS
         8iPgssT9zyohc+cb9Cj0VPOMMSVpjxmYRhhS+NVs=
Date:   Mon, 25 Jul 2022 10:42:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ren Yu <renyu@nfschina.com>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com
Subject: Re: [PATCH 2/3] lkdtm/perms: Check possible NULL pointer returned by
 kmalloc(),vmalloc()
Message-ID: <Yt5XZN3CdTprfjwk@kroah.com>
References: <20220725081153.20228-1-renyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725081153.20228-1-renyu@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:11:53PM +0800, Ren Yu wrote:
> As the possible alloc failure of the kmalloc() and vmalloc(),the
> return pointer could be NULL.therefore it should be better to check it.
> 
> Signed-off-by: Ren Yu <renyu@nfschina.com>
> ---
>  drivers/misc/lkdtm/perms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index b93404d65650..34b43b9ea1f1 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -180,6 +180,9 @@ static void lkdtm_EXEC_STACK(void)
>  static void lkdtm_EXEC_KMALLOC(void)
>  {
>  	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
> +	if (!kmalloc_area)
> +		return;
> +

Always run checkpatch on your patches so that grumpy maintainers do not
have to tell you to run checkpatch on your patches...

Also, shouldn't this return an error?

But most importantly, how can this ever fail?

thanks,

greg k-h
