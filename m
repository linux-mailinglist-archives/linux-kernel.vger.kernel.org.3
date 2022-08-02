Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE34B587B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiHBLEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiHBLDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:03:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DC50713
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:03:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id tk8so25263232ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P0Jfd7tAzAuxX0y7WjLxKt/TPIgKGV9Dv1ZKmVWbSV8=;
        b=Dvs/l5xyUz6w9U57X/ujdUBFkpw4TNVuVO76eJhfi8+zydKcIExuO4AmEDGYWHuS/2
         bWVAtw0iOX+ADb8frAysBBu8Y/D1CMb6ySHt6NDVfQnTVgHxz6AQTGcUb/1612lYdqol
         ak9uPgFPAoCmQcLtbv96c75hwc1D7vec5KDbKHPM36cxg3XOEPocZOA3kvnuihuIbLHO
         IR0A2sx3qkhotB2Lz41pEtAnX26NBLt/T7AlOjA8FK/7F3n+u3/bqtF5+qFj7VjdsZp+
         6iqEmy5J7ECjYVUc8KO4lbUUQnBL95vmI68uhhk+sQKpemh7E4cltYAv5lLSMHC7QWX5
         qelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=P0Jfd7tAzAuxX0y7WjLxKt/TPIgKGV9Dv1ZKmVWbSV8=;
        b=WQ89AYEq/9+DL8Js6KWulcgpqFNH8926xJsIagtevD0tddjSjUXIq/wmLFsUbGw3+q
         rVaH6PbzNjqvx3lJi8ELfEugMElGVTGGTCog/pSPBjZwbz4nEDwFHXRlXZaM1jP4huim
         +oijE9gyQPXIEC9Oin3FC1kIfRdvHiwIe8fDmH9wQACfsn+aEJ3cre5/PNVBjRDeTaSP
         W1X6w8RSrQn50VLRnDBR59rSdvMYz4OZhkI2db17xtfLetckD8MJFIG59qGQ8lBz55yy
         aEMUtUootIXHh34hwmKHhhN4ZdYYMJbcY/31XGTNglmFS2jndOG9pxZnd9ffCvE7bA5j
         IqDg==
X-Gm-Message-State: ACgBeo1JkAH2IMRZu+Mm2CTztSQnBKpiGXtNwXC5JjiNJUyJRU/+Ll4v
        25V6og1R6+lNSJWOVKidxeg=
X-Google-Smtp-Source: AA6agR6QKypEUHeom0CcRA0ARtr5TOJA+z93ia3eGX/HpeUkZ/cJtZ1l2R+AYjcOBR90kBz5F7geqw==
X-Received: by 2002:a17:906:4793:b0:730:853a:e3ac with SMTP id cw19-20020a170906479300b00730853ae3acmr7274431ejc.652.1659438224906;
        Tue, 02 Aug 2022 04:03:44 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id qc19-20020a170906d8b300b007305d408b3dsm3366884ejb.78.2022.08.02.04.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:03:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 13:03:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Sun <yi.sun@intel.com>
Cc:     dave.hansen@intel.com, sohil.mehta@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        david.laight@aculab.com, heng.su@intel.com
Subject: Re: [PATCH v2 2/2] scripts/x86: Add script to consume trace log of
 xsave latency
Message-ID: <YukEjqcU9UK8IVgf@gmail.com>
References: <20220729095608.1475138-1-yi.sun@intel.com>
 <20220729095608.1475138-3-yi.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729095608.1475138-3-yi.sun@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yi Sun <yi.sun@intel.com> wrote:

> Consume the trace log dumped by trace points x86_fpu_latency_xsave and
> x86_fpu_latency_xrstor, calculate latency ranges for each RFBM and
> XINUSE combination including min, max, average and 97% tail latency.
> 
> Add the average of 97% tail latency to remove the unreasonable
> data which is introduced by interrupts or other noise. By adding the
> experimental code disabling interrupts before the calculation of
> latency, it's obvious to get the 3% tail latency has been filtered.
> 
> Make use of sqlite3 to make the data statistics more efficient and
> concise. The output looks like following:
> 
> EVENTs                	RFBM   	XINUSE	lat_min	lat_max	lat_avg	lat_avg(97%)
> ----------------------	-------	------	-------	-------	-------	------------
> x86_fpu_latency_xrstor	0x206e7	0x0   	364    	364    	364    	364
> x86_fpu_latency_xrstor	0x206e7	0x202 	112    	1152   	300    	276
> x86_fpu_latency_xsave 	0x206e7	0x202 	80     	278    	141    	137
> x86_fpu_latency_xsave 	0x206e7	0x246 	108    	234    	180    	177
> 
> The XSAVE/XRSTOR latency trace log can be got by two ways:
> 1. Generated by Kernel debugfs
>   echo 1 > /sys/kernel/debug/tracing/events/x86_fpu/enable
>   cat /sys/kernel/debug/tracing/trace_pipe > trace-log
> 
> 2. Generated by helper tool like 'trace-cmd'
>    trace-cmd record -e x86_fpu -F <command>
>    trace-cmd report > trace-log
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> 
> diff --git a/scripts/x86/xsave-latency-trace.sh b/scripts/x86/xsave-latency-trace.sh
> new file mode 100755
> index 000000000000..d45563984fd6
> --- /dev/null
> +++ b/scripts/x86/xsave-latency-trace.sh

The patchset looks mostly good to me, but I don't think we are supposed to 
add arch dependent instrumentation scripts to scripts/, please put this new 
script somewhere in tools/testing/x86/ or so.

Thanks,

	Ingo
