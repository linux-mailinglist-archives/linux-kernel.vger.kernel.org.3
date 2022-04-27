Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78820511624
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiD0Ldg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiD0Ldd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:33:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22837A2D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:30:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bx5so1227784pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWsO9zYE+6z8Bu+J+RVWchJHdOi/jTER00tosQL2T9k=;
        b=fBiMUHL+/89DWKYwG6EjwyvTpwpWmS2S7Tq9KPIVm3Z1+65DIF65PsvxA6GBg6lX5E
         7RqX1vmosklEYI8VFjNF3/0b1d/zOlXrobjGn6xntCUrbhi3bpISDovDrxsTNVsPnogN
         2t5yfG+UyyZROV8h3L/dReZNbNN7kRmw32Q+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWsO9zYE+6z8Bu+J+RVWchJHdOi/jTER00tosQL2T9k=;
        b=rs8JkjrwtR0NfPuN1ARItNZson7EETbPFx4eL4x+iSQUkDwpvbkiiSNL/Wsjq3uVQU
         O6N65xA+Nn5Z3gBRbUxiwqJQkwPZMpWlpX3I89B3MEp9t4A9jtOIYv1zJFjRpcUlv2Mu
         pZ/VZWO3id2yu2J2odIpz2b4M3bijLC02xI4G9ofHjYMrSQMeDTSjWuULR7uLG7T4dA6
         NU6ygxEtZWyPNSTYcFwaFF2zBGMmvCfCOwaQdSun5TEJeb/zapRRjj6vfcwmq1pflx3x
         ubZd+Pxo5cdCn3PjmtMxhnHqUrgeofGDoX2UGSnJ2oBWKduZ2DVhT4YVqUXfk3RwS52I
         A87w==
X-Gm-Message-State: AOAM532eV6GvOmrQFN9yDQFbrW7KC3FNQNZrcMKwDowvF17uHqq3qpU0
        8CkDawdy2FOTIESdEqrEk5gpPKmARUNVuQ==
X-Google-Smtp-Source: ABdhPJxgII3YJrlgmRBlb+I6g1YyWPWr0arhPXRxwA6t0ftRB36wF6qpxWbiq+09MhjzTFZc/4cGUA==
X-Received: by 2002:a17:903:32d2:b0:15d:57c7:9eef with SMTP id i18-20020a17090332d200b0015d57c79eefmr1916051plr.2.1651059022158;
        Wed, 27 Apr 2022 04:30:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e2d:263:26e7:c039])
        by smtp.gmail.com with ESMTPSA id d14-20020a62f80e000000b0050d2671b11bsm14355030pfh.53.2022.04.27.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 04:30:21 -0700 (PDT)
Date:   Wed, 27 Apr 2022 20:30:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org, axboe@chromium.org,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        mnitenko@gmail.com, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v2] zram: remove double compression logic
Message-ID: <YmkpSC/gJf7Cg2Ym@google.com>
References: <20220427100345.29461-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427100345.29461-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/04/27 13:03), Alexey Romanov wrote:
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index cb253d80d72b..4be6caf43b1d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1153,9 +1153,8 @@ static ssize_t debug_stat_show(struct device *dev,
>  
>  	down_read(&zram->init_lock);
>  	ret = scnprintf(buf, PAGE_SIZE,
> -			"version: %d\n%8llu %8llu\n",
> +			"version: %d\n%8llu\n",
>  			version,
> -			(u64)atomic64_read(&zram->stats.writestall),
>  			(u64)atomic64_read(&zram->stats.miss_free));
>  	up_read(&zram->init_lock);

I think this also has to bump `version` to 2, since format of the
file has changed.
