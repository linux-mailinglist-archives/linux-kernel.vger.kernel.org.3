Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283F5919F1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiHMKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiHMKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:50:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205548EBD;
        Sat, 13 Aug 2022 03:50:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a89so4052873edf.5;
        Sat, 13 Aug 2022 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=1CAalEJ6M6+sHCvMstYoC0TE80FQCIJVVQFjrdbMso0=;
        b=EyaMw8jpwT+IkyycaSL+1/iVKlOFken09+CbZf85T81lT+fWJtN6DJKnYXhHSjiY90
         JC+AFnEs/eGL6tn20+6oHy2O1elmjNjPYFI2W7L/KoPv1FiHKsivxiYkYsra3O8DAcA0
         tHiJSATggu3EO+X8OGS42Sh3952DeE8hLgV4WnIhJvNhKiOlyIMxH7WYh4NQRjzpSdiE
         Za3XzVOhsnjZvUQDV5kjvYLwRWyM4fVkY2Yy5fjJbq7uYcvrCKzuXyDuqOVhIWprZlUX
         /IzFJor+f3CJ5LyAXuzRTjs33MIfY6KvG82xVGOhUci+Hd8uQJOmH4PM5Yfg5dwLK3K/
         um4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=1CAalEJ6M6+sHCvMstYoC0TE80FQCIJVVQFjrdbMso0=;
        b=eS3esZKKoPPtGbFKV/w6XoMDFxDcNiX+bAOyfj2kQV2CjckTCEvg87SZT6pKnsyY2e
         jpkpw7n3+epw/ibttcJH5L0AJpKyKTTdWER5zYUQQiWhFgMEmp7jFy6qvJipkPu/7LNC
         D4zQyGC+F5EVPDzRq/v7Zd8yjIYC92fdDZ+9QQl/2Lh6ogL9jD0xjkYQojEZwwFxmUQ6
         B50RH8p4Ac9JjjrdENiQoWaGT9rQdfmURHb3HR44FMwMQnSg9rfm7XeQY6S14iNnLuJb
         M/6UhSKCvjmakb8p45AWYO83XAGBXWAwlbP30jo8JIEJA5r1oP2y0TupbSNgP/8MYm3V
         fsJQ==
X-Gm-Message-State: ACgBeo1TFS1fNLc6JoVXtFH9t8GM/aYTKv5mbeoBuF9cAGilZa2EcAjW
        ULz8YglCckfPgIKd4B+XywhO9JOH568=
X-Google-Smtp-Source: AA6agR5c66lajvAoYxOZJmW8IdWbdjCr31ihOAnWjfiJ7cUF/ZmBWGAuP1F1veUTcp4ClKdfI00icw==
X-Received: by 2002:a05:6402:3907:b0:431:6776:64e7 with SMTP id fe7-20020a056402390700b00431677664e7mr7030885edb.0.1660387850409;
        Sat, 13 Aug 2022 03:50:50 -0700 (PDT)
Received: from gmail.com (84-236-113-143.pool.digikabel.hu. [84.236.113.143])
        by smtp.gmail.com with ESMTPSA id c18-20020a056402121200b0043cc2c9f5adsm2819785edw.40.2022.08.13.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 03:50:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 13 Aug 2022 12:50:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH 7/7] perf/x86/intel/P4: Fix smp_num_siblings usage
Message-ID: <YveCBx/X/YyoccI0@gmail.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
 <20220812164144.30829-8-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812164144.30829-8-rui.zhang@intel.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhang Rui <rui.zhang@intel.com> wrote:

> smp_num_siblings can be larger than 2.
> 
> Any value larger than 1 suggests HT is supported.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  arch/x86/include/asm/perf_event_p4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/perf_event_p4.h b/arch/x86/include/asm/perf_event_p4.h
> index 94de1a05aeba..b14e9a20a7c0 100644
> --- a/arch/x86/include/asm/perf_event_p4.h
> +++ b/arch/x86/include/asm/perf_event_p4.h
> @@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
>  static inline int p4_ht_thread(int cpu)
>  {
>  #ifdef CONFIG_SMP
> -	if (smp_num_siblings == 2)
> +	if (smp_num_siblings > 1)
>  		return cpu != cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));

This fix too should probably come before all the other changes.

(Not that Pentium 4 code is expected to ever see such SMT thread values.)

Thanks,

	Ingo
