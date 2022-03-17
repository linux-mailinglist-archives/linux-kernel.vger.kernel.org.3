Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1489A4DC85B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiCQOHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiCQOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:07:34 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61245136660;
        Thu, 17 Mar 2022 07:06:18 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id mz9-20020a17090b378900b001c657559290so5285575pjb.2;
        Thu, 17 Mar 2022 07:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l5TJbPNzDqPASdkDHCLk62DytQZBW+wKClOw+PHQQjc=;
        b=Nx9GdB+OwF0Pai9M39tso/lBKaWwCYr/T/8yjX2C2nMSEDAV5zs6+8gbBqwNRTX61l
         4bG9EVIxs8ysO2B46J8jb1lQ+moEoCGW6r25FZWuGUzpi5q7FYGeDSbNqZShf+6qu/X5
         faRuUJlBC9bL3t9l/vzJn77gRuxToRaOL+Y5l99gFVx7hrCLbOI9AMpPwF6oQ2qO79Pv
         8bhfXXp648tsz+l2vm0k7OVRWrG3fMOlvHEYOuwh7b1ifoD4E/5+bCoHIdTQhusMaNI7
         AVTRFTax2x/n5zZwCEkMdnVNFV07l+OU7Dm/tA7qCjcSStOIwxE/e/AmEj1xYhhnoHPw
         pUug==
X-Gm-Message-State: AOAM533rK3AN72GmFi8H/jxVPF2+ZnvKG4Upg11f6pq1iLG2DrKymtgj
        yFitzGswO7FWH5CxivlBxUs=
X-Google-Smtp-Source: ABdhPJw+trXwAO+jp5KEgP7+0YMzXFmtnQ7Oi+H6HoOCE18jVvu7LSrsSPwBrEX4TkUVY2eHcaADhA==
X-Received: by 2002:a17:902:e94f:b0:14f:1636:c8a8 with SMTP id b15-20020a170902e94f00b0014f1636c8a8mr4952381pll.130.1647525977380;
        Thu, 17 Mar 2022 07:06:17 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id na8-20020a17090b4c0800b001bf191ee347sm10381694pjb.27.2022.03.17.07.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 07:06:17 -0700 (PDT)
Message-ID: <22cd48e9-fe36-414c-942e-382b8139ab4b@acm.org>
Date:   Thu, 17 Mar 2022 07:06:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] block: don't show disk stats if io accounting is
 disabled
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk, mpatocka@redhat.com,
        snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220317112653.1019490-1-yukuai3@huawei.com>
 <20220317112653.1019490-2-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220317112653.1019490-2-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 04:26, Yu Kuai wrote:
> If io accounting is disabled, there is no point to handle such device
> in diskstats_show(), and it can be confused for users because all fields
> in iostat are zero while the disk is handling io.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/genhd.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index c3b32c665aec..e5307f512185 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -937,6 +937,9 @@ ssize_t part_stat_show(struct device *dev,
>   	struct disk_stats stat;
>   	unsigned int inflight;
>   
> +	if (!blk_queue_io_stat(q))
> +		return sprintf(buf, "io accounting is disabled\n");
> +

Hmm ... the above looks sub-optimal to me. Has it been considered to 
return an error code instead or even better to hide the stat attribute 
if I/O accounting is disabled? The latter can be achieved by modifying 
disk_visible().

Thanks,

Bart.
