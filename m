Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F14A7658
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiBBQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234941AbiBBQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643820949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egv0e1QXLdMDJLzDlEfd+9hjoDteiVw0Tc45PLBPnRk=;
        b=Ra3qjMx7W3ZbG2y4gbElmfdvStd5Ymy/uXLEwHoB2zZMH+VMNi/oKwEpyWp8UDeXglbRnt
        d0HZO03ePd1is+kcRxr7bGggTF4UwQ9uwKrz5uIhP0Jp2HmYOeaGRtRuv637ZVIkHuaUJp
        j7+KxZDC1+XGdxImDS58MlfjeUY/wrA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-26kMDZ8dMq28ctd6ecNwVw-1; Wed, 02 Feb 2022 11:55:48 -0500
X-MC-Unique: 26kMDZ8dMq28ctd6ecNwVw-1
Received: by mail-wm1-f72.google.com with SMTP id n22-20020a05600c3b9600b00352d3f6a850so2568149wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 08:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egv0e1QXLdMDJLzDlEfd+9hjoDteiVw0Tc45PLBPnRk=;
        b=jU0bj5HvEeOCqcPxPsobxE7K/cRDcwu6/MZ052yyAgyuxdMr23ybL5WEaqPlmhwQel
         iG3N0kfBiDzG+Gv7yjwrKUcL2mR+gBsx9Nry9S5yDUCCPb76jzjwcmCQeaJyfRYz19Eh
         z/bW9YzzOCjH2mMtaFXBNWd4JB4Xq5SZcVs2ozPCBsWNkaKI0/DXAB3NJqPnVvm9UAMX
         EGkAxR5N4kkNeBqlMyktIfDS7JHeFGxGze9ReVulxhS7YD7klUqqggsXTziijxW3yLU8
         4DoA8i9kdXKxd4sR8K+RylHvwF46r/+Z8zBQkiR6nl2yNTXuAV5irw7/kSJNE+Tn83n+
         71sw==
X-Gm-Message-State: AOAM530UeuP5uTCGtlecoDfBQbes8ma6tutlG02bR9GLM2/uHEfg2i5T
        h7OkQ/C4xEnCojDWQd22l5dUH/W7e/69yXKxiLbTVPeeLvapN+BM0Jol+B4Da1rhwL6xTHrWc/3
        jvSb1Y7NXMZyyK2FSWUwhw5r3
X-Received: by 2002:a1c:7918:: with SMTP id l24mr6820138wme.91.1643820947604;
        Wed, 02 Feb 2022 08:55:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQXlXZtcqdt29L6NXh+2CEo4waI2F0RmzscSS7g2ToiBc7dCyJBZZRaKKDnsqyRi7YXDtCLA==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr6820128wme.91.1643820947458;
        Wed, 02 Feb 2022 08:55:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m187sm5109446wme.25.2022.02.02.08.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:55:47 -0800 (PST)
Date:   Wed, 2 Feb 2022 17:55:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, james.clark@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: tools: Add missing branch_sample_type
Message-ID: <Yfq3kTb7E1cELF0L@krava>
References: <1643799443-15109-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643799443-15109-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 04:27:23PM +0530, Anshuman Khandual wrote:
> This updates branch sample type with missing PERF_SAMPLE_BRANCH_TYPE_SAVE.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/perf_event_attr_fprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 47b7531f51da..98af3fa4ea35 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -52,7 +52,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
>  		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
>  		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
>  		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
> -		bit_name(HW_INDEX),
> +		bit_name(TYPE_SAVE), bit_name(HW_INDEX),
>  		{ .name = NULL, }
>  	};
>  #undef bit_name
> -- 
> 2.20.1
> 

