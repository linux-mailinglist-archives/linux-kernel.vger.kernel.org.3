Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53484C71FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiB1Qyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiB1Qyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:54:49 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48C27B28
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:54:10 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 132so12063486pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/PP18PnlVf/AcE9TCVp3WkPzAUoq9OmCtcVZO7RF9H0=;
        b=gKIUb/KnSbcay3ZyS25SnMcMCkia1zVN8fogNkDZhAJy/PZ4nFs1s7suvXkAwiLrgf
         zMdI+/Uq1FcmfvLktwbNajZiyi9blVd4xqrH72deaYtxQCgr0vIXB4w8JSpJ0pZTIV2u
         eYz3PEIKyCBVIfD1jZNHmLA5KmL3VAGBwlgVzQIUWQ3wc0unNGZc+4IlJ0s9ja3PBGjy
         QEAP81qnZf23+Je1wJ7KA/IjQxWbvjqjvrUb1FLbHE2baA7fjU/SMrNHw7VozR1idXC6
         FpGRgMGeVXK5J6f4PjEe3oEQJIcAJj7i/1NtdvMywuxlJ/TtqAQ4rCM0Ow3PoF5K0/ux
         k+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/PP18PnlVf/AcE9TCVp3WkPzAUoq9OmCtcVZO7RF9H0=;
        b=fAyIr4YB8BNGgsbjLtLTzXV0eeplIJMFSdPQrjA1oV31qAY/gkcd9hOOveoPhk2qp6
         vNi6SyvmsrIHPxC/93mr4lCvAqDhnuCtATRfGqtcFeePGV8+YDLMPe0v+L4lXGr++iAv
         6WyW/VzjzcKMTOHRf+yBu0isL9dIADVdE7mTKWWsz9A6YoHjUu4NuxCmo4JbSYVuOkvB
         QldhyzCxJnY1RAWvozrTQaT/27zKLeyogFnl3rdL0M7p9RWH0Owv6SGdOkTT3JxtslQd
         DOA8TSWOZSF1KpP9DgJIPfZ07TQMyVRe76GLRmOmL8dmMQ260aclcCyi3gOspafrXykm
         1dgQ==
X-Gm-Message-State: AOAM530BSbZHP0XMOf1z010LVsQ81sUxMrIq5fDuLxJWSKAQeeFN3/dT
        vQ8I5m6X4oAtRkQq7VIF3WN0UQ==
X-Google-Smtp-Source: ABdhPJxkrRPzgHLEA6/yaGSmJMHupUBt5XWeQCaT+Zgrv9LZMBwjgbpIY8cgrhjD6wWV3UeC0NUOqw==
X-Received: by 2002:a63:8c52:0:b0:378:907d:1c6d with SMTP id q18-20020a638c52000000b00378907d1c6dmr5604028pgn.477.1646067249560;
        Mon, 28 Feb 2022 08:54:09 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004e10af156adsm14601792pfc.190.2022.02.28.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:54:08 -0800 (PST)
Date:   Mon, 28 Feb 2022 09:54:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Drop unused 'none' enum value for each
 component
Message-ID: <20220228165406.GA1278407@p14s>
References: <1645005118-10561-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645005118-10561-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Wed, Feb 16, 2022 at 03:21:58PM +0530, Anshuman Khandual wrote:
> CORESIGHT_DEV_TYPE_NONE/CORESIGHT_DEV_SUBTYPE_XXXX_NONE values are not used
> any where. Actual enumeration can start from 0. Just drop these unused enum
> values.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 3 ---
>  include/linux/coresight.h                    | 5 -----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 88653d1c06a4..af00dca8d1ac 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1278,9 +1278,6 @@ static struct attribute *coresight_source_attrs[] = {
>  ATTRIBUTE_GROUPS(coresight_source);
>  
>  static struct device_type coresight_dev_type[] = {
> -	{
> -		.name = "none",
> -	},
>  	{
>  		.name = "sink",
>  		.groups = coresight_sink_groups,
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 93a2922b7653..9f445f09fcfe 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -36,7 +36,6 @@
>  extern struct bus_type coresight_bustype;
>  
>  enum coresight_dev_type {
> -	CORESIGHT_DEV_TYPE_NONE,
>  	CORESIGHT_DEV_TYPE_SINK,
>  	CORESIGHT_DEV_TYPE_LINK,
>  	CORESIGHT_DEV_TYPE_LINKSINK,
> @@ -46,7 +45,6 @@ enum coresight_dev_type {
>  };
>  
>  enum coresight_dev_subtype_sink {
> -	CORESIGHT_DEV_SUBTYPE_SINK_NONE,
>  	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
>  	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
>  	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> @@ -54,21 +52,18 @@ enum coresight_dev_subtype_sink {
>  };
>  
>  enum coresight_dev_subtype_link {
> -	CORESIGHT_DEV_SUBTYPE_LINK_NONE,
>  	CORESIGHT_DEV_SUBTYPE_LINK_MERG,
>  	CORESIGHT_DEV_SUBTYPE_LINK_SPLIT,
>  	CORESIGHT_DEV_SUBTYPE_LINK_FIFO,
>  };
>  
>  enum coresight_dev_subtype_source {
> -	CORESIGHT_DEV_SUBTYPE_SOURCE_NONE,
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>  	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
>  };
>  
>  enum coresight_dev_subtype_helper {
> -	CORESIGHT_DEV_SUBTYPE_HELPER_NONE,
>  	CORESIGHT_DEV_SUBTYPE_HELPER_CATU,
>  };

These have never been used in the 7 years the subsystem has existed and I don't
see in what kind of situation they could be...

I have applied this patch.

Thanks,
Mathieu

>  
> -- 
> 2.20.1
> 
