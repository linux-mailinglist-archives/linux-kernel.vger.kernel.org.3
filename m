Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72635929B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiHOGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiHOGlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:41:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9302140F2;
        Sun, 14 Aug 2022 23:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E6760BB9;
        Mon, 15 Aug 2022 06:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA62C433C1;
        Mon, 15 Aug 2022 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660545661;
        bh=XOZ/dBYSuq4o6QxZna2f3OAdyjsEx7s3NCoq0gSZc1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACxpbnfS5uThb55aeG6gv16RjDMiFdSSH5pVQXmGugnqwiA1Zwv2YhD/GX60JZMHu
         Wg3agcrI2mLzqPw+AYFGi9YzOp6Yr/TJVwl1RUt203p7XbibOshUX+gyGvhT0h4AIy
         1aiwNqwR1hfwActljRjjKTvpHcP6LXrkOTCz18v4=
Date:   Mon, 15 Aug 2022 08:40:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YvnqefDHJM+HQIMG@kroah.com>
References: <20220815041145.35629-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815041145.35629-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:11:45PM +0800, Szuying Chen wrote:
> +/* ASMedia specific validation mode */
> +#define nvm_upgrade 0
> +#define nvm_add 1
> +#define nvm_write 2

Why is this not an enum?

And why is this specific to a single vendor, yet that vendor name is not
in the #define?

> +struct nvm_asmedia {
> +	u32 date;

__le32?

> +	u32 customerID:16;
> +	u32 version:8;
> +	u32 reserved:8;

Are you sure these bitfields are correct on all platforms?

thanks,

greg k-h
