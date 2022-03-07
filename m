Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790D64CF2A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiCGHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiCGHga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:36:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA235F4FD;
        Sun,  6 Mar 2022 23:35:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F011B80F88;
        Mon,  7 Mar 2022 07:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF8FC340E9;
        Mon,  7 Mar 2022 07:35:33 +0000 (UTC)
Message-ID: <2a3b4095-7b63-4da5-d0fa-43ba86715504@xs4all.nl>
Date:   Mon, 7 Mar 2022 08:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] media: st-delta: Fix PM disable depth imbalance in
 delta_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105115515.12196-1-linmq006@gmail.com>
 <20220301031253.6142-1-linmq006@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220301031253.6142-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian Lin,

On 3/1/22 04:12, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> 
> Fixes: f386509 ("[media] st-delta: STiH4xx multi-format video decoder v4l2 driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - remove unused label.
> ---
>  drivers/media/platform/sti/delta/delta-v4l2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
> index c887a31ebb54..36ce0775f3f9 100644
> --- a/drivers/media/platform/sti/delta/delta-v4l2.c
> +++ b/drivers/media/platform/sti/delta/delta-v4l2.c
> @@ -1899,6 +1899,7 @@ static int delta_probe(struct platform_device *pdev)
>  err_v4l2:
>  	v4l2_device_unregister(&delta->v4l2_dev);
>  err:
> +	pm_runtime_disable(dev);

This isn't right. If the devm_kzalloc at the beginning fails, then it also jump
to this label, but at that time no pm_runtime_enable() has been called yet,
so this patch will just introduce another imbalance.

You *do* need a new label here (like you did in v1 of this patch), and update
the 'goto err;' instances after the call to pm_runtime_enable() to go to that
new label.

Regards,

	Hans

>  	return ret;
>  }
>  
