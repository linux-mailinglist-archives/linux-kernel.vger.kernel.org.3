Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87CC56A976
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiGGRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiGGRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:23:57 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 20FA04F1A2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:23:51 -0700 (PDT)
Received: (qmail 433016 invoked by uid 1000); 7 Jul 2022 13:23:50 -0400
Date:   Thu, 7 Jul 2022 13:23:50 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <YscWpjFlV60NybEA@rowland.harvard.edu>
References: <20220707170912.70505-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707170912.70505-1-mdevaev@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 08:09:13PM +0300, Maxim Devaev wrote:
> It allows to reset prevent_medium_removal flag and "eject" the image.
> 
> The patch is a completely alternative implementation of the previously
> proposed [1], the idea of which was born after the mentioned discussion.
> 
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> Link: https://lore.kernel.org/lkml/20220406092445.215288-1-mdevaev@gmail.com [1]
> ---

Greg's patch bot is going to complain that you didn't describe the 
differences between v2 and v3 at this point.

And since you'll have to submit the patch again...

> +ssize_t fsg_store_forced_eject(struct fsg_lun *curlun, struct rw_semaphore *filesem,
> +			       const char *buf, size_t count)
> +{
> +	int ret;
> +

...  How about putting a comment line here, explaining that this 
override will cause the medium to be ejected no matter what the host 
wants?

> +	curlun->prevent_medium_removal = 0;
> +	ret = fsg_store_file(curlun, filesem, "", 0);
> +	return ret < 0 ? ret : count;
> +}
> +EXPORT_SYMBOL_GPL(fsg_store_forced_eject);

In any case, in the next submission you can add:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
