Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF550CE57
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiDXCJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiDXCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:09:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A648DEF8;
        Sat, 23 Apr 2022 19:06:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n8so19439829plh.1;
        Sat, 23 Apr 2022 19:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G5chtXdXHBAHq9U8cN942JiV6ivsvkzMtMA5fbafTig=;
        b=qBHPxvxPL6sor5qMtXE3DaLjQP9T/ilrSNm23CyTsMaZTcq1kHQr0cGCKQrgm/dVIT
         QgaF5j6ync5JRYZ2Cn7QsuQs4YoVCQjiLf4eDT/zkMnquI/OYksg0q+4twatpo3R9McQ
         EKKKowZ5KnFn0RmUUS0GvbXC3lrVd5mg4J+ZBC1yO6dAv5arSZxD7s9wd5+1Xl4/0SOg
         CM4GhCkzCCqgDz7rw8n5pJ/Z9oh4DXfRGkWe1gmfaSQUH4c9Crpu/7hIZldobc6UBR+/
         UnQBtXF1vJRs939yBl5MD72dxLB6O7h8fZja08SNADyYwlL9oOvCEJmcpKKjnH4665Ey
         a4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G5chtXdXHBAHq9U8cN942JiV6ivsvkzMtMA5fbafTig=;
        b=mQC2gJFVPMp9teHV8NRCus0f6FAE0IbFIRLeeLDmoXMrKyDZkXeQNvFuzGj74lbXLH
         lpxYZqwV3vfCOXS+gVLRppEn5K3khfnExk5of4UUD3y7XFnqy1QWwShGqALiq/OnxcL2
         wtiINSoaU1Da4/LpdyyEPxPUu4A0Aqa9vJmU9vfk0305/qlJkexGzuX+lhsBe49pmwQq
         anh6iB46tzCJ3RYOnPOonF4NCtGttuU9qIljcEvCD63SaNkCynSwEs+Lr3uAZ7qX1DF0
         GC6xdcg/LBg1311NUcnR60Wwv8bhVtwbqkZSk0JGgd2zzK21A0r15pr0R0hmQWas4fng
         ak7Q==
X-Gm-Message-State: AOAM532aOhMfg9EDHqr/GJM5RtnwWMfQfcKwpSVu46RT0cv2yCh91mzz
        /VvZsUZdurp0eQ7Iq5wca4c=
X-Google-Smtp-Source: ABdhPJzLTnOSaQr+nWBe52Kah2RbUcCpcTm+2JUktZ74CsyXnl9YV8zvqt64lVJCETd/TcOiuFHoSA==
X-Received: by 2002:a17:902:a501:b0:153:f956:29f0 with SMTP id s1-20020a170902a50100b00153f95629f0mr11714114plq.120.1650765998998;
        Sat, 23 Apr 2022 19:06:38 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a0fc600b001d5f22845bdsm9959867pjz.1.2022.04.23.19.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 19:06:38 -0700 (PDT)
Message-ID: <ab977d4e-dbe7-3198-9477-66d42d818d1a@gmail.com>
Date:   Sun, 24 Apr 2022 10:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rpmsg: virtio: Fix the unregistration of the device
 rpmsg_ctrl
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220422155402.721982-1-arnaud.pouliquen@foss.st.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220422155402.721982-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/22 23:54, Arnaud Pouliquen wrote:
> Unregister the rpmsg_ctrl device instead of just freeing the
> the virtio_rpmsg_channel structure.
> This will properly unregister the device and call
> virtio_rpmsg_release_device() that frees the structure.
> 
> Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 3b7b47f785cf..0db8043e6c49 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -861,7 +861,7 @@ static void rpmsg_virtio_del_ctrl_dev(struct rpmsg_device *rpdev_ctrl)
>   {
>   	if (!rpdev_ctrl)
>   		return;
> -	kfree(to_virtio_rpmsg_channel(rpdev_ctrl));
> +	device_unregister(&rpdev_ctrl->dev);
>   }
>   
>   static int rpmsg_probe(struct virtio_device *vdev)


Thanks for further optimization.

Reviewed-by: Hangyu Hua <hbh25y@gmail.com>

Thanks,
Hangyu
