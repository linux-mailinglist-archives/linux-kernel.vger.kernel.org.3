Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044E9508347
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376683AbiDTIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376663AbiDTIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:23:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEAE192B0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:20:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ks6so1980723ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37dXOeJAMPQb/aG1DhfASa3E4eLCqeB00YEjRZAkEoY=;
        b=kg+MJjWHdMSqpwWZAIdt+66NX7VK6JJe5TSpR86R3H4Q3NsdrvdSM+OLrd7FSaTvEc
         g0Wlm1JnAzb0Fz/tpaZ/WDhN7agm9xEHc3MLg9GiyHyN63Llvi88fnv9UmzDEKAO8TA/
         cSYpju5rc+tkaOpXunGVhe84R77+vkM9wt7RB1zqVKh0CF/E19nYW6ZRpwqUMVVBvNIq
         +w8uY8eRZbRa6tLy9BVAwXv1ulP5ee6sbCZLvT8B/4Y0VHisqKVqRJ+ageD6pbPykiYN
         Nb+zgGZf1U4zBQ698fV/ovzsvuzjNeR3hUCOOmlVlUiKd+Rzcenwzo4EPECcU55AAkg8
         /ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37dXOeJAMPQb/aG1DhfASa3E4eLCqeB00YEjRZAkEoY=;
        b=ED1BWcKu0CgABhjFuifq6QiFDhczyGHwyr4F2GPgedHkN4RqxbaudXnV9tmBjPyD6X
         znhJ4AUVpgz9ev0WTp/6q5DmMaMayGPS8TrfirnhUPTKis+5UFYzUX357cijgeufSVtf
         Jo1w3UJ0N861kkNpBV19Xi2Iz+/rMRpx8uYlVnxNGS9NUgp4xkESrwSU9QRNNV1EYKVn
         cblSvGHRcLbJbxPdUBvmralq0dlCJ5/+A5jJxrqBJORG3gQLKPzFChL68ezbC6EpKImx
         20IcMaQnafa1sM0jRMUAa6fiPkoj/yVl96pUkrmSoczTWmBVmFaQwQ8YEszL6TFwaPBJ
         ZNaw==
X-Gm-Message-State: AOAM530m8z2oH7Mhb5b026N9tpxUWb3euZgT+hGY7ypvXvwQhdnoS0Jj
        oBh2qYH0ITmdaqd75ABYjzvlPCVKX/ld+Yaa84mrwg==
X-Google-Smtp-Source: ABdhPJwGGAxB80ju4/rLep0FQz+cm1bQDM+t8WqYC0SlwEjYmdLPFsgYrg9VWDIe5T5UzwFcznPj5A==
X-Received: by 2002:a17:907:3d93:b0:6e8:756c:e54d with SMTP id he19-20020a1709073d9300b006e8756ce54dmr17130002ejc.207.1650442847328;
        Wed, 20 Apr 2022 01:20:47 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id bw3-20020a170906c1c300b006e88cdfbc32sm6493010ejb.45.2022.04.20.01.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:20:46 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:20:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        acme@kernel.org, benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <20220420082040.GA843168@leoy-ThinkPad-X240s>
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-3-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408195344.32764-3-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:53:41PM +0000, Ali Saidi wrote:
> Add a flag to the perf mem data struct to signal that a request caused a
> cache-to-cache transfer of a line from a peer of the requestor and
> wasn't sourced from a lower cache level.  The line being moved from one
> peer cache to another has latency and performance implications. On Arm64
> Neoverse systems the data source can indicate a cache-to-cache transfer
> but not if the line is dirty or clean, so instead of overloading HITM
> define a new flag that indicates this type of transfer.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>

The patch looks good to me:
Reviewed-by: Leo Yan <leo.yan@linaro.org>

Sine this is a common flag, it's better if x86 or PowerPC maintainers
could take a look for this new snooping type.  Thanks!

Leo

> ---
>  include/uapi/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 82858b697c05..c9e58c79f3e5 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1308,7 +1308,7 @@ union perf_mem_data_src {
>  #define PERF_MEM_SNOOP_SHIFT	19
>  
>  #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
> -/* 1 free */
> +#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
>  #define PERF_MEM_SNOOPX_SHIFT  38
>  
>  /* locked instruction */
> -- 
> 2.32.0
> 
