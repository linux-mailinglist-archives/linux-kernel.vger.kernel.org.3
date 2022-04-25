Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8A50E4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiDYPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiDYPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:54:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D653A5CB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:51:18 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q22so16319017iod.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KRYSOrgaeJ2D4S/Wx7GywXi3KDyCDXqWNNYrYsjMpyU=;
        b=a6Tudt/FF4aceLEyf67ZDqeMl/oD+rorEIh9wu4NaBa+KN9uq7+ipS69p9kzfR/otj
         yThrGkkFG+OzNwE6bjcMjkTgPe6X65RjUzbfj5jsh/xq7SprTpJYlyJ/P+eZSSzGlA+R
         3rEQpLJx9dIrpizhRymVDP1HswnMdVjv8WuJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRYSOrgaeJ2D4S/Wx7GywXi3KDyCDXqWNNYrYsjMpyU=;
        b=0OGXdsmQvM/Lg6FzANs5p5Lv9ZTdoTogyiU48td+hHreDMLxUEk3Iss8Fw9w0ZMVyN
         LWv+fhu8b4BCsJjzXIg29VDwmKrSFol+LotlucWSsY8cYqWLhycJAZlJtidu9l0s0fMs
         RqHKZGj7C+XUQmWugH/YSRS0Q6zjHrhgLKg3G1lnZY9wX/6sRO/wqrc/3cmdw4tOJKfJ
         Gra1ucYFYg355iYM3A4sooidUvR+tihn3s7YzZNPmV4G8cwHQAz2BoAVNo+cUukuaf9Q
         rT3K8eR3Xey2EYA9TvQHYWoMa0WvjiKbDTxlP7VOsLqQzYXisl6UwcoN4FLFU26jSA/s
         /SUQ==
X-Gm-Message-State: AOAM5308zOHpZaAqHBOUbPofHKDu+PqKQUd1XKKz/Sxgto+xpnlZmMvf
        eSiTbXNpg4RJqnsnR7rFxVSL0w==
X-Google-Smtp-Source: ABdhPJyJq9cXy0E5jrK4OxRObAqzGlCYjTa42Sbs2Sfq9yDNZHOJz2BGh5L/eAtEME6MySvniXiqTw==
X-Received: by 2002:a5d:9318:0:b0:649:a18:dab8 with SMTP id l24-20020a5d9318000000b006490a18dab8mr7829255ion.96.1650901877580;
        Mon, 25 Apr 2022 08:51:17 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id j12-20020a6b310c000000b0065744ce0180sm7683070ioa.8.2022.04.25.08.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 08:51:17 -0700 (PDT)
Subject: Re: [PATCH] selftests/resctrl: Fix null pointer dereference on open
 failed
To:     Colin Ian King <colin.i.king@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220424211536.1373878-1-colin.i.king@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <04a35a47-d83a-67a1-5ed4-ba314c6e1ecf@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 09:51:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220424211536.1373878-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 3:15 PM, Colin Ian King wrote:
> Currently if opening /dev/null fails to open then file pointer fp
> is null and further access to fp via fprintf will cause a null
> pointer dereference. Fix this by returning a negative error value
> when a null fp is detected.
> 

How did you find this problem and how can it be reproduced? Is there
a case where test fails to open "/dev/null"?

> Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/testing/selftests/resctrl/fill_buf.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 51e5cf22632f..56ccbeae0638 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -121,8 +121,10 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
>   
>   	/* Consume read result so that reading memory is not optimized out. */
>   	fp = fopen("/dev/null", "w");
> -	if (!fp)
> +	if (!fp) {
>   		perror("Unable to write to /dev/null");
> +		return -1;
> +	}
>   	fprintf(fp, "Sum: %d ", ret);
>   	fclose(fp);
>   
> 

thanks,
-- Shuah
