Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA304B6042
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiBOByH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:54:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiBOByG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:54:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02F140741
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y1xt1MH7s55m6PjHwk7dMVPJJWKbK1+FaxSumu5H3+o=; b=bUd1WdYE2YYSjqdBYMnRAMYIyW
        G8bLcJ38C0SMEGt+ff8etO5JqX0SnBUwTRo3z88QREbGtGsgwwChNt0qcjLLYqop71dd0mS3kLp/C
        P1zspyc4fvrAQi78bKVuzUEiG1AeWSrBNSyJPj/EdJ2iaB7uKkci4N+R60aDLgZhgp7rVb/oXkQuw
        AcmlWNHZB1ubW9YlfTbY84iVe3bH/MAfBzYnu5o0tvQ0fuLfLGTeMSN7wKw8rEm/ix1cFBytctvVR
        24Sxmh7Dt5y8Tg74lsv0Dz9HxZIOjwyBuDK8e7r1Tk0HdVgQQ9TSrSPzQX9LBxkbmZyXI5D55B/d8
        707pchOg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJn2T-00HUWj-Kl; Tue, 15 Feb 2022 01:53:57 +0000
Date:   Mon, 14 Feb 2022 17:53:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware_loader: EXTRA_FIRMWARE does not support
 compressed files
Message-ID: <YgsHtdqm3xRU+QUD@bombadil.infradead.org>
References: <20220214222311.9758-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214222311.9758-1-rdunlap@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 02:23:11PM -0800, Randy Dunlap wrote:
> Document in the firmware loader Kconfig help text that firmware image
> file compression is not supported for builtin EXTRA_FIRMWARE files so
> that someone does not waste time trying that.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
> Yeah, I wasted some time trying to use an xz compressed file
> as builtin EXTRA_FIRMWARE, 

Curious *why* you are using EXTRA_FIRMWARE BTW.

> so try to prevent someone else from
> doing that.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
> 
>  drivers/base/firmware_loader/Kconfig |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- linux-next-20220214.orig/drivers/base/firmware_loader/Kconfig
> +++ linux-next-20220214/drivers/base/firmware_loader/Kconfig
> @@ -60,6 +60,8 @@ config EXTRA_FIRMWARE
>  	  image since it combines both GPL and non-GPL work. You should
>  	  consult a lawyer of your own before distributing such an image.
>  
> +	  NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
> +
>  config EXTRA_FIRMWARE_DIR
>  	string "Firmware blobs root directory"
>  	depends on EXTRA_FIRMWARE != ""
> @@ -169,6 +171,9 @@ config FW_LOADER_COMPRESS
>  	  be compressed with either none or crc32 integrity check type (pass
>  	  "-C crc32" option to xz command).
>  
> +	  Compressed firmware support does not apply to firmware images
> +	  that are built into the kernel image (CONFIG_EXTRA_FIRMWARE).
> +
>  config FW_CACHE
>  	bool "Enable firmware caching during suspend"
>  	depends on PM_SLEEP
