Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9CC527D08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiEPFV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiEPFV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:21:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF02DE5;
        Sun, 15 May 2022 22:21:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so3277349pjb.5;
        Sun, 15 May 2022 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RZKcm7OXMK/DUfXVXFdg1TDoHC6E/6MUQpSVukf18d8=;
        b=Q+fxLMKLfrZV2A5DmZD2Jt6jBFF2zhZxMWkvN51gq23a3kF1WSkJZl32EALy83N3sm
         qablH9zzKIgHDFYJpT//lKMX5QEpCCxhRaMelVQt2VHu9+sVX7uxZpOv+3YXbN3fEYHN
         ZuUTj+AjIpVprMDXB+w7eC8+20geYkP3Qj3b9PT+EZeNN8r0KsH0OBMTCUq/LYWK1eGi
         4LgLCqzRgdB1ze7MImSxLnPqd2w+99yObgDzt1dpNX/q62NPWNI3A88+cNl//jDArS4n
         XN7ooWHwLmfXNoO6/+LkXPS70zEkCQIc1/pYzFGzDwFZNRj7PstrhdvunTDC8CwCLB1u
         OD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RZKcm7OXMK/DUfXVXFdg1TDoHC6E/6MUQpSVukf18d8=;
        b=J5YI9u8vMBIXiLnufDP17vgvFhiUngSikTtkDk8N/hviY+ycNRBwhdy8KCHUG1D4yC
         NQDvZ9Nt0xnMPP59qKLV3otj+897tvNsRtAwB1y+UKu9D85FesKGhf5547N/DSpFIsN7
         YbUJRRVDnSN/mEfsq3Z5c2rVfMdW9kE6BVmLeCSHeRsnpeTl8GYA6htl2XkZisf4MQc6
         FY5dPpX0DmlmYhcAS9rw0KPMK+eBWrtLFIAax3fCtz7mJ3YLrnpbzirb8OHKujt2QgGG
         bNI+MhimE4CdZNgQ8sFtn6wpt5/JT4fAuZ0eAhrd3FIc1DRNRTRAilDp0Z4VIJG+JGjw
         qZbA==
X-Gm-Message-State: AOAM531mLQjnZVJt9YihSBtV8taIM+4a2cFnFqxCVka0e6xjV8Z883x0
        kzZwDE3Gbo8S3H0NqCdhlic=
X-Google-Smtp-Source: ABdhPJzDC8La40pR4pmE4LwNuOh4evKrSMQ9DPjq+jdqnhRgBrHgmGu+ocQPVJQvg1N0VNkVwugaGw==
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id s11-20020a17090302cb00b0014f4fb62fb0mr15598252plk.172.1652678484937;
        Sun, 15 May 2022 22:21:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:586d:4807:54a6:b6a0])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0015e8d4eb1ffsm6039999plk.73.2022.05.15.22.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 22:21:24 -0700 (PDT)
Date:   Sun, 15 May 2022 22:21:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] Input: mt6779-keypad - implement row/column
 selection
Message-ID: <YoHfUYmq49V5Bygd@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-3-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513151845.2802795-3-mkorpershoek@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 05:18:45PM +0200, Mattijs Korpershoek wrote:
> The MediaTek keypad has a total of 6 input rows and 6 input columns.
> By default, rows/columns 0-2 are enabled.
> 
> This is controlled by the KP_SEL register:
> - bits[9:4]   control row selection
> - bits[15:10] control column selection
> 
> Each bit enables the corresponding row/column number (e.g KP_SEL[4]
> enables ROW0)
> 
> Depending on how the keypad is wired, this may result in wrong readings
> of the keypad state.
> 
> Program the KP_SEL register to limit the key detection to n_rows,
> n_cols we retrieve from the device tree.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/input/keyboard/mt6779-keypad.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
> index 23360de20da5..653dfc619696 100644
> --- a/drivers/input/keyboard/mt6779-keypad.c
> +++ b/drivers/input/keyboard/mt6779-keypad.c
> @@ -17,6 +17,11 @@
>  #define MTK_KPD_DEBOUNCE	0x0018
>  #define MTK_KPD_DEBOUNCE_MASK	GENMASK(13, 0)
>  #define MTK_KPD_DEBOUNCE_MAX_MS	256
> +#define MTK_KPD_SEL		0x0020
> +#define MTK_KPD_SEL_COL	GENMASK(15, 10)
> +#define MTK_KPD_SEL_ROW	GENMASK(9, 4)
> +#define MTK_KPD_SEL_COLMASK(c)	(MTK_KPD_SEL_COL >> (6 - (c)))

Would it be clearer to say

#define MTK_KPD_SEL_COLMASK(c)	GENMASK((c) + 3, 4)

?

Thanks.

-- 
Dmitry
