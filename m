Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1336055B462
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFZWfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiFZWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:35:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECCC2DDF;
        Sun, 26 Jun 2022 15:35:34 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68E1A66016B4;
        Sun, 26 Jun 2022 23:35:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656282932;
        bh=8rXxTlcstkFQNootjbn8QCtpfVmztVI0c8pZei6dYig=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HnSsbwGcG6ht6Oy6ED05gqtbxf+0uxcp+BlKnAnY6X92UXaHhlp5D+WFj7oS1omfW
         XPzwyc8giZ4MR2G2QGGxNOCgP3o+ZvYAc8jb3oW5xB+xbbuYPUZb3hdEb9FswAg9nJ
         hrrPvwSkSi5zi3zxYsLPs0wT8Z5J9JXvJD4tlto0lO9kABRM7RcA/iZMTLDgeBwcyF
         UD3k25W8bZteJs+aPq1pHzC1gGQZzEGzISYKENM458W5x0VK8mXXAjLGipla6r3GdJ
         Vo/gb9JUrz1oZet2hKhj88s2nJQHBR3j9s32avttlqrdESPJN4t3M3FBVUK1asaq8u
         +JwWCTbmsGGZw==
Message-ID: <b6e28520-01cc-f163-7ed2-a7f99ad6be26@collabora.com>
Date:   Mon, 27 Jun 2022 01:35:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive
 control getter
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141853.7417-2-Sergey.Semin@baikalelectronics.ru>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220624141853.7417-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 17:18, Serge Semin wrote:
> Most likely due to copy-paste mistake the device managed version of the
> denoted reset control getter has been implemented with invalid semantic,
> which can be immediately spotted by having "WARN_ON(shared && acquired)"
> warning in the system log as soon as the method is called. Anyway let's
> fix it by altering the boolean arguments passed to the
> __devm_reset_control_bulk_get() method from
> - shared = true, optional = false, acquired = true
> to
> + shared = false, optional = true, acquired = true
> That's what they were supposed to be in the first place (see the non-devm
> version of the same method: reset_control_bulk_get_optional_exclusive()).
> 
> Fixes: 48d71395896d ("reset: Add reset_control_bulk API")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch added on v4 lap of the series.
> ---
>  include/linux/reset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 8a21b5756c3e..514ddf003efc 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -731,7 +731,7 @@ static inline int __must_check
>  devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
>  					       struct reset_control_bulk_data *rstcs)
>  {
> -	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, true);
> +	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true);
>  }
>  
>  /**

Good catch,

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Although, this patch should be sent as standalone since it's unrelated
to the rest of the clk patches.

-- 
Best regards,
Dmitry
