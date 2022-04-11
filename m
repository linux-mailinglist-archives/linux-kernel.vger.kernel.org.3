Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389814FB924
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbiDKKPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDKKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:15:15 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707441F95
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:13:02 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso9690206wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NIpP1nx9/f18tnpNY46mhDB5G980D7IcTknlfdST6Ik=;
        b=40iDGOwd0uNRqsZJsB0kHXwHcm+aH8RHI8lTzYAq+PsbNFCnJXzS8Plte1jpCKGFLA
         o0WUml7rKdTRuPDw5v5GrytP9dfKh7jBSHPRqehs8fPQii/Xtb8BbZtB+Su3NMDQtBTK
         0DiJUp8s43zIjB6KpVaAIgww5uQjiiUlDd7865Wdfr0RtxIv6fv4jei+Y+d0WvDoV6c/
         f5hYBNzDcMlHXCxaj8WFdgFnmUCXQz7NZUMEWo7ieZIGS0IT5PYT1TIqQUmhYfNB5JRk
         Umxow1YIr4MtzErhumjTfTX91o/WUKN6RhoLlt1hnC+EsQqZhwfIiBFjvEpQoRMkngnm
         ourQ==
X-Gm-Message-State: AOAM533ofv2PUJU4NYu0wQwzq3mvBXov5UtMlq62HmH6YMmC9E3VGY2h
        oUnpa85spaKRDFjcInQhCVU=
X-Google-Smtp-Source: ABdhPJx/5SyYwGZ1hGDiJt3ggQIe26BvClG7jZAjo8qrfDRoJzUZM3DTKzv+0wS3h3x74UWwi90TRg==
X-Received: by 2002:a1c:7518:0:b0:381:c77:ceec with SMTP id o24-20020a1c7518000000b003810c77ceecmr28458283wmc.57.1649671980640;
        Mon, 11 Apr 2022 03:13:00 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm22732493wml.5.2022.04.11.03.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 03:12:59 -0700 (PDT)
Message-ID: <f9e0d516-d3a7-c0bf-f673-2a4c3dd9184d@kernel.org>
Date:   Mon, 11 Apr 2022 12:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: synclink_gt: Fix null-pointer-dereference in
 slgt_clean()
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220410114814.3920474-1-zheyuma97@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220410114814.3920474-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 04. 22, 13:48, Zheyu Ma wrote:
> When the driver fails at alloc_hdlcdev(), and then we remove the driver
> module, we will get the following splat:
> 
> [   25.065966] general protection fault, probably for non-canonical address 0xdffffc0000000182: 0000 [#1] PREEMPT SMP KASAN PTI
> [   25.066914] KASAN: null-ptr-deref in range [0x0000000000000c10-0x0000000000000c17]
> [   25.069262] RIP: 0010:detach_hdlc_protocol+0x2a/0x3e0
> [   25.077709] Call Trace:
> [   25.077924]  <TASK>
> [   25.078108]  unregister_hdlc_device+0x16/0x30
> [   25.078481]  slgt_cleanup+0x157/0x9f0 [synclink_gt]
> 
> Fix this by checking whether the 'info->netdev' is a null pointer first.

Hi,

LGTM

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Out of curiosity, do you use the driver, or you only do some static 
analysis?

> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   drivers/tty/synclink_gt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 25c558e65ece..9bc2a9265277 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -1746,6 +1746,8 @@ static int hdlcdev_init(struct slgt_info *info)
>    */
>   static void hdlcdev_exit(struct slgt_info *info)
>   {
> +	if (!info->netdev)
> +		return;
>   	unregister_hdlc_device(info->netdev);
>   	free_netdev(info->netdev);
>   	info->netdev = NULL;


-- 
js
suse labs
