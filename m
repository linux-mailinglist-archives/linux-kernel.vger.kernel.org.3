Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DF5237D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbiEKPyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbiEKPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4545EBA9A1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652284437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwrxWlDkRYEZxUPCibFUkteoAJ+YBJnBk276PVcc9II=;
        b=QspQlpVTiA/ia2pDNub2t50j6nhxTuuGRQqGKdJPobl6rcaqdmDWSqs4rhb4PWrg/fgnbw
        DCkG11rtQuvvsX1ZsSAd2YJt8vR1pBmDqmICyNT/8P7WdaZfrdOIEL5QftSmB8oZoRLFeg
        VbYhJzs+UT4jQAw2WIJ0EJUcUfNtPQM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-ZxN8oefZOsyj9SzUwsfjwA-1; Wed, 11 May 2022 11:53:55 -0400
X-MC-Unique: ZxN8oefZOsyj9SzUwsfjwA-1
Received: by mail-ed1-f69.google.com with SMTP id k13-20020a50ce4d000000b00425e4447e64so1558350edj.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IwrxWlDkRYEZxUPCibFUkteoAJ+YBJnBk276PVcc9II=;
        b=ObNzeRnR19vmbGm8P2rbHsJ76HqXzfh2DLyk1uBUitMLKLGs+MYpFxyUgRyoEQPoHl
         yWeC/4SfySgF1kSqk34mg+bz8d+6895LnqtgRAnMC5etF3HXlOFNdvFXagJ9jwUaeB9e
         X5QohLL+CB3nhWvsz5hR9uWm3s47rFJFTl2jDNcG15GDk6Z//aF3JoW+2vMrY36W5XT6
         yXnhFFK1oFEndoTRNZ39Dt6uyK1aPis0Oy+ekj6WrpDHEmXWb0NyP06bbkK2ueBgONSf
         +TEdq8su5GsmAlX1bGVkmbjtGsXHfeDYLvTrRGcOKy+7TERAqZPxbfyEzGUL0qvaKqtQ
         ecaQ==
X-Gm-Message-State: AOAM530PoShNRL1SQUCb/mZnJKs/rMkEm0OXz/FmF6bZI0CG1KCQ8R8x
        jzLhHTMUY84B6r9V6311Sm076wGdCeW+uU6ezCZ3wG/iP9XbvWJ50gTK00O3R50eYrnY03nHHVD
        vjEz0tLEeDfSy3slWnvpyhQnV
X-Received: by 2002:a17:906:c142:b0:6f5:2632:adb7 with SMTP id dp2-20020a170906c14200b006f52632adb7mr24687704ejc.637.1652284434601;
        Wed, 11 May 2022 08:53:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK3Nm8WXoopAHEkKYllofwom5n4jcVxKk9ixK/73qGrQuL+lw3yNSJ0WX+Sqog3OO2Tooytg==
X-Received: by 2002:a17:906:c142:b0:6f5:2632:adb7 with SMTP id dp2-20020a170906c14200b006f52632adb7mr24687683ejc.637.1652284434391;
        Wed, 11 May 2022 08:53:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jz21-20020a17090775f500b006f3ef214e77sm1097647ejc.221.2022.05.11.08.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:53:53 -0700 (PDT)
Message-ID: <ef0e965d-f66a-3b02-1687-781a84b8db8a@redhat.com>
Date:   Wed, 11 May 2022 17:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Display error on
 turbo mode disabled
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220510023421.3930540-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220510023421.3930540-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/10/22 04:34, Srinivas Pandruvada wrote:
> For Intel SST turbo-freq feature to be enabled, the turbo mode on the
> platform must be enabled also. If turbo mode is disabled, display error
> while enabling turbo-freq feature.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Since this is a trivial patch, I am not sending a PULL request.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> 
>  tools/power/x86/intel-speed-select/isst-config.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
> index 060390e88e37..9d35614995ee 100644
> --- a/tools/power/x86/intel-speed-select/isst-config.c
> +++ b/tools/power/x86/intel-speed-select/isst-config.c
> @@ -1892,6 +1892,12 @@ static void set_fact_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
>  	int ret;
>  	int status = *(int *)arg4;
>  
> +	if (status && no_turbo()) {
> +		isst_display_error_info_message(1, "Turbo mode is disabled", 0, 0);
> +		ret = -1;
> +		goto disp_results;
> +	}
> +
>  	ret = isst_get_ctdp_levels(cpu, &pkg_dev);
>  	if (ret) {
>  		isst_display_error_info_message(1, "Failed to get number of levels", 0, 0);

