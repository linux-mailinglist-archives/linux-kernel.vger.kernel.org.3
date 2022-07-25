Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F157FB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiGYI3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiGYI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:29:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62D813FBE;
        Mon, 25 Jul 2022 01:29:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p21so4602566ljh.12;
        Mon, 25 Jul 2022 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bSa24RkLGOVb9mqXyzx5nIyXZhJRiDANt8v3RVr4jNw=;
        b=NZEnL/5HwwpZkPsB4qWr1n9TlyT8CGVdbUGeyp3B+6OTVvXVjq94R/vWnIP5/sivRD
         Ur1DfxHDTUN1v7ujHMDWo/yb6BCdUPIf1m/zfO8QuYDcC7haEbJxRDF7Pn649G9cYR+K
         JqWOmH5SrK9pSbrKnnnKY+5Rb455r2EiMZ2PR0EY1Cx0z4T3U1FnXQNPQFSd825728uw
         +drQyj53j2SVztE1TZ9M0aEQJzN44LwBeE34w0/6YVcpxkM57UXuw5VNJc/X4l2s8VZB
         Y0XpHoJyLsGrQh3w7hbtBlmgC0kW2biVf5WF3HrDkjgtD7/HRt7maXTL4/d/vyL2Dn6a
         GA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bSa24RkLGOVb9mqXyzx5nIyXZhJRiDANt8v3RVr4jNw=;
        b=F3BTFi7YRVLASz1jhKphBDXgxj0OWvnQ5GKuZUVx5TcghkRn1XJj5Bkn+rX0/1E54v
         aS9hJKVnqmwiTEElVsy1p0me11XAZzmSsDGk7Ht6KEtXQM+fJoWuizRVhPlyeQHKLQp9
         YdN7K0H4yhNXF5QaiA7ThuGn10xYdbHxANypxW5jydGOk+SNnrT7ruysQDLn4y/BCk5U
         QhSct/8VGHlos0IVPx0FcaR1jiNHK/0npXgAOUvP8y+xUzEeKdGz2pg9E9xvF6ZYKNYW
         V5V5DSGncfr/bU+S0ByGZuQl8h2pPoff4D9Ivif4k9XyCwqoGQybuVuboJD01vDBqTxB
         hQsw==
X-Gm-Message-State: AJIora//h3blu0QXrK2dkiCI4MmXD7tSx2Fgfw/yRCb1FYMfZ1956xXK
        XKJkLz5Om40oB1W+WEDr/Ak=
X-Google-Smtp-Source: AGRyM1sL8dXypJNjduwiqiel7ZINjQ4gH90GfP8zpYz+wdc3KAC/BR7gkYlI7ebg3aFeuA3y5CnZQA==
X-Received: by 2002:a2e:908:0:b0:25d:e37b:2cbb with SMTP id 8-20020a2e0908000000b0025de37b2cbbmr3763221ljj.401.1658737775869;
        Mon, 25 Jul 2022 01:29:35 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.82.139])
        by smtp.gmail.com with ESMTPSA id p13-20020a2ea4cd000000b0025e0396786dsm715578ljm.93.2022.07.25.01.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:29:35 -0700 (PDT)
Subject: Re: [PATCH v2] USB: HCD: Fix URB giveback issue in tasklet function
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, kishon@ti.com, dianders@chromium.org,
        s.shtylyov@omp.ru, mka@chromium.org, ming.lei@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
References: <20220725065251.832087-1-WeitaoWang-oc@zhaoxin.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <3b9a3fec-7716-3e9d-1e91-cfdac46845f7@gmail.com>
Date:   Mon, 25 Jul 2022 11:29:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220725065251.832087-1-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/25/22 9:52 AM, Weitao Wang wrote:

> Usb core introduce the mechanism of giveback of URB in tasklet context to
> reduce hardware interrupt handling time. On some test situation(such as
> FIO with 4KB block size), when tasklet callback function called to
> giveback URB, interrupt handler add URB node to the bh->head list also.
> If check bh->head list again after finish all URB giveback of local_list,
> then it may introduce a "dynamic balance" between giveback URB and add URB
> to bh->head list. This tasklet callback function may not exit for a long
> time, which will cause other tasklet function calls to be delayed. Some
> real-time applications(such as KB and Mouse) will see noticeable lag.
> 
> Fix this issue by taking new URBs giveback in next tasklet function call.
> Add a member high_prio for structure giveback_urb_bh and replace the local
> high_prio_bh variable with this structure member in usb_hcd_giveback_urb.
> 
> Fixes: 94dfd7edfd5c ("USB: HCD: support giveback of URB in tasklet context")
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
> v1->v2:
>  - Fix compile warning by remove label "restart".
>  - Modify the patch description info.
>  - Change structure member from hi_priority to high_prio.
> 
>  drivers/usb/core/hcd.c  | 25 ++++++++++++++-----------
>  include/linux/usb/hcd.h |  1 +
>  2 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 06eea8848ccc..1feb9a604380 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
[...]
> @@ -2959,6 +2961,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  
>  	/* initialize tasklets */
>  	init_giveback_urb_bh(&hcd->high_prio_bh);
> +	hcd->high_prio_bh.high_prio = 1;

   s/1/true/?

>  	init_giveback_urb_bh(&hcd->low_prio_bh);
>  
>  	/* enable irqs just before we start the controller,
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 2c1fc9212cf2..98d1921f02b1 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -66,6 +66,7 @@
>  
>  struct giveback_urb_bh {
>  	bool running;
> +	bool high_prio;
>  	spinlock_t lock;
>  	struct list_head  head;
>  	struct tasklet_struct bh;

MBR, Sergey
