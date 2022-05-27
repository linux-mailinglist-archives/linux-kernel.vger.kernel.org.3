Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE5535D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiE0Jip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350605AbiE0Jie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E60F554015
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653644311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dxJgteJ4eYA2hPblerYsI7xTL/JrWtd/SRhGAQjbDE=;
        b=FmiB+TrOxqVHTnvNhSrCOXsLZCErWdstIIQNDPgj/v4OoedGxh5KMrhneaIHjFCGm2RxYR
        pjBqbiUNRDqMLMLFgxJOpjcfCrDB+Z2LA4AUFuJCKOaUnQZ8zqYzdiV0FXpL62m2KfS2nq
        xEFYxjw3KQhz/rEGoj/B4StZHSxNDbc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-79Gj1KbXPXaG2UBnnAxlAw-1; Fri, 27 May 2022 05:38:30 -0400
X-MC-Unique: 79Gj1KbXPXaG2UBnnAxlAw-1
Received: by mail-wm1-f70.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso4559600wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+dxJgteJ4eYA2hPblerYsI7xTL/JrWtd/SRhGAQjbDE=;
        b=3ylFN37n2WDybcbgb7Gex91F7DXwdasLH+f4XyK0QSWZIOHrs3zxGImamQmxhFggyJ
         tUgJx0f4wwmT2ntkXs8weUF13TFrezo/Ao8xke8Xk52qB9fdMaAsbAopsKDj4emTiVQC
         51QzPfrKB1k+3g1bk8/WiVspYM0aikjvQDvAsHo/hvqqVG3YakOISoUMA0lShzgNDAvD
         pjkMOllR9aA3FlUY3B4qd37waY7Xpi/LpRwS3JgvIsOMQJh3N3f5xAVjhNFVNU8omSOi
         2kGJ7jCsDx5q5cTPG/PbGFTvzy1gFRGA0GxzNNvCrRlyQcb1Gd06GH2EImO9GieV92zq
         Lb3g==
X-Gm-Message-State: AOAM533Ym/LZYCDbRoBTePT7KlTa0kUb5mVMfhuWjyHlSKqYI4oDvy8R
        1rJ8ojjxMkg7X2USi7jmQ2687hxNIE3nx72Ows155UL4jLP4fkDxRS9cbKnYnzjVP4lZWUliq9U
        TZr/UjIere7v0rBhyuWvqacUC
X-Received: by 2002:adf:d1a1:0:b0:210:1ed6:3c83 with SMTP id w1-20020adfd1a1000000b002101ed63c83mr788491wrc.345.1653644309047;
        Fri, 27 May 2022 02:38:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4znpk6L/Ijy6sYnbWXl5A8U/E62h5+UWKn7E+9kCDYCblJJyM55OoA0Gb0FvjZe7tF6JEOg==
X-Received: by 2002:adf:d1a1:0:b0:210:1ed6:3c83 with SMTP id w1-20020adfd1a1000000b002101ed63c83mr788488wrc.345.1653644308910;
        Fri, 27 May 2022 02:38:28 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h9-20020a7bc929000000b003974a3af623sm1705244wml.17.2022.05.27.02.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:38:28 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] cpuhp: Set cpuhp target for boot cpu
In-Reply-To: <20220526160615.7976-3-pauld@redhat.com>
References: <20220526160615.7976-1-pauld@redhat.com>
 <20220526160615.7976-3-pauld@redhat.com>
Date:   Fri, 27 May 2022 10:38:27 +0100
Message-ID: <xhsmhwne7l3ho.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/22 12:06, Phil Auld wrote:
> Since the boot cpu does not go through the hotplug process it ends
> up with state == CPUHP_ONLINE but target == CPUHP_OFFLINE.
> Set the target to match in boot_cpu_hotplug_init().
>
> Signed-off-by: Phil Auld <pauld@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index cdb6ac10ad94..0bb8ad0fa2d9 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2677,6 +2677,7 @@ void __init boot_cpu_hotplug_init(void)
>  	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
>  #endif
>  	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
> +	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
>  }
>  
>  /*
> -- 
> 2.18.0

