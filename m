Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C155509F20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382425AbiDUL7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbiDUL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589B2E690;
        Thu, 21 Apr 2022 04:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7D061BBD;
        Thu, 21 Apr 2022 11:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41798C385A5;
        Thu, 21 Apr 2022 11:56:21 +0000 (UTC)
Message-ID: <291b141f-9f58-54c6-0005-fec0a9335dba@xs4all.nl>
Date:   Thu, 21 Apr 2022 13:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: amphion: fix error check return value of
 debugfs_create_file()
Content-Language: en-US
To:     cgel.zte@gmail.com, mchehab@kernel.org
Cc:     ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220419013809.2561635-1-lv.ruyi@zte.com.cn>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220419013809.2561635-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 03:38, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> If an error occurs, debugfs_create_file() will return ERR_PTR(-ERROR),
> so use IS_ERR() to check it.

Actually, errors should never be checked for debugfs. See e.g. commit
1d8f95c497053839be326bd97eb3128e3b3312cb which removed unnecessary checks
in drivers/media/radio/radio-si476x.c.

Can you make a v2 that removes all the debugfs checks from this driver?

Regards,

	Hans

> 
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/media/platform/amphion/vpu_dbg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
> index 376196bea178..5cef1fd41a74 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -413,7 +413,7 @@ int vpu_inst_create_dbgfs_file(struct vpu_inst *inst)
>  					    vpu->debugfs,
>  					    inst,
>  					    &vpu_dbg_inst_fops);
> -	if (!inst->debugfs) {
> +	if (IS_ERR(inst->debugfs)) {
>  		dev_err(inst->dev, "vpu create debugfs %s fail\n", name);
>  		return -EINVAL;
>  	}
> @@ -451,7 +451,7 @@ int vpu_core_create_dbgfs_file(struct vpu_core *core)
>  						    vpu->debugfs,
>  						    core,
>  						    &vpu_dbg_core_fops);
> -		if (!core->debugfs) {
> +		if (IS_ERR(core->debugfs)) {
>  			dev_err(core->dev, "vpu create debugfs %s fail\n", name);
>  			return -EINVAL;
>  		}
> @@ -463,7 +463,7 @@ int vpu_core_create_dbgfs_file(struct vpu_core *core)
>  							  vpu->debugfs,
>  							  core,
>  							  &vpu_dbg_fwlog_fops);
> -		if (!core->debugfs_fwlog) {
> +		if (IS_ERR(core->debugfs_fwlog)) {
>  			dev_err(core->dev, "vpu create debugfs %s fail\n", name);
>  			return -EINVAL;
>  		}

