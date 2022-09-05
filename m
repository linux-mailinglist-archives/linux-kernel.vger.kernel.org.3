Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEF5ACFDF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiIEKUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiIEKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:19:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9AF578AF;
        Mon,  5 Sep 2022 03:19:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nc14so16097972ejc.4;
        Mon, 05 Sep 2022 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=hq9S7cyR2dxsLgQQf9Da5fdBhaAZlofiS7OnzuWQkA4=;
        b=enS/dVRccNUcTzSwDmjPE7Y8IWNF/bSR24RCFsTnoWcb1emBYDfls+IxZ5lxOlNEzv
         GKnLEl1YGiNDbSDzm87okIIouF/6jLm7hcKKQ1MdNmIRlZiltTMFmFmC7xPu11KXu7zV
         pXDDKUmp4Y7Ed5bq2NZjzNZnfiTWfj2wWFhpIIXY6XXHY779JXOrfFJ0Z9KdfsWLsxev
         V2U0rV24RMe9rhDcAIIZYGcznHujk+6aurfDuKxetkzas+1hddLLP3umznG/lZ5ZY4So
         cCauNtHa9Fx0TvuCjwevyRyF0OQ4BMvVZCjDkYFZwLuHCSP1zBZBNIOu8QeBf3PGvDIG
         1YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hq9S7cyR2dxsLgQQf9Da5fdBhaAZlofiS7OnzuWQkA4=;
        b=aCy+HHecJxhp386qcow9kNt4kSfrnilvSSglcIA9lqXfoxhySki17vujSgDT//5vtV
         L0TGoU7+x6lRqFJh8c7bKo5FjiHBH5HEDwVQn3EbyFQqcKxH8OBKuvOD5rFoXT7JZz85
         fMaJLwkImwyKIuISqjziGpNG2oYNWTjndxTb+00Rg0maEQZH8FZhOgRhi5W7NZaRCy8/
         bWxzHypN6wjOl4NB7XZKj4JhmsZFvO4G47mjp877MwsynDD84ZRj5zO4lWVMfbAy3Q75
         YgUqVGsqcpAbOY5uiqH+PEmcJOT0mXRPONd00UBLUPUOpiK61irMc5XYKBKiWoaBwuU5
         r27Q==
X-Gm-Message-State: ACgBeo0lxiZ6QNk+lNFlxUTpffR/wFN4rP+aENwfHhHikpWh4CjafYYw
        lGj+02raZh1ozEFOuFFWf9o=
X-Google-Smtp-Source: AA6agR4zMDhI7xLR+yuIdS6+wZrs6umOCMaHX1ji0XevKCB0sgmE1JpOs82NMO+Pm12Pr6vAOmA5DA==
X-Received: by 2002:a17:906:6a0a:b0:741:55b6:83ef with SMTP id qw10-20020a1709066a0a00b0074155b683efmr28072869ejc.210.1662373152226;
        Mon, 05 Sep 2022 03:19:12 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906314c00b00764a76d5888sm2364475eje.27.2022.09.05.03.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:19:11 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 5 Sep 2022 12:19:10 +0200
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf c2c: Prevent potential memory leak in
 c2c_he_zalloc
Message-ID: <YxXNHtXoOeZG9Bzb@krava>
References: <20220903072542.27678-1-shangxiaojing@huawei.com>
 <20220903072542.27678-4-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903072542.27678-4-shangxiaojing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 03:25:42PM +0800, Shang XiaoJing wrote:
> Free allocated resources when zalloc is failed for members in c2c_he, to
> prevent potential memory leak in c2c_he_zalloc.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  tools/perf/builtin-c2c.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 12f272811487..5530433eda80 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -146,15 +146,15 @@ static void *c2c_he_zalloc(size_t size)
>  
>  	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
>  	if (!c2c_he->cpuset)
> -		return NULL;
> +		goto out_free_he;
>  
>  	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
>  	if (!c2c_he->nodeset)
> -		return NULL;
> +		goto out_free_cpuset;
>  
>  	c2c_he->node_stats = zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_stats));
>  	if (!c2c_he->node_stats)
> -		return NULL;
> +		goto out_free_nodeset;
>  
>  	init_stats(&c2c_he->cstats.lcl_hitm);
>  	init_stats(&c2c_he->cstats.rmt_hitm);
> @@ -163,6 +163,14 @@ static void *c2c_he_zalloc(size_t size)
>  	init_stats(&c2c_he->cstats.load);
>  
>  	return &c2c_he->he;

nit, given that c2c_he is zero allocated we could just have
single error label that would free everything

for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> +
> +out_free_nodeset:
> +	free(c2c_he->nodeset);
> +out_free_cpuset:
> +	free(c2c_he->cpuset);
> +out_free_he:
> +	free(c2c_he);
> +	return NULL;
>  }
>  
>  static void c2c_he_free(void *he)
> -- 
> 2.17.1
> 
