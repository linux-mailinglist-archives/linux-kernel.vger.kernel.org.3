Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C15237DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344019AbiEKP4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344213AbiEKP4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84900286E9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652284571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Mh3inTeIDOo85ciNLhJraJn+1Plr8Qa3Kd2pi/okJ8=;
        b=hNQU/1vudOK348a8xtfNrbNF/zVfNFWIhEbhj4//xDsJvXIRnqh9lfbU/2CQh/SjBYnhdO
        9XswlmW/VNshV15zIKCq8RAECQCkFIzhzP7Arty+dAiG49SKq/9lMxUsSPEHGcwp2U2MwD
        WP2xAcZHjZyVOGvtp0I/lmvbt97hfF0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-oY-XRxuoPQi3nUeV5NrQXg-1; Wed, 11 May 2022 11:56:10 -0400
X-MC-Unique: oY-XRxuoPQi3nUeV5NrQXg-1
Received: by mail-ed1-f72.google.com with SMTP id s29-20020a50ab1d000000b00427e495f00cso1574686edc.14
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2Mh3inTeIDOo85ciNLhJraJn+1Plr8Qa3Kd2pi/okJ8=;
        b=ErhsYtu+zUJ4sXWtFMaHV3k7Dd+4rYl7wpQgb0vE9X5aea3R5Li3oksUHlbfiE3NNk
         INUIKAwKS5dW/09bXU+DJvDZRueYq4wMWKO7A4r8gn0R4K3feQgnnfPRDHzyW50Yu/a1
         D5oZNniGgOLxb02SRQ9qupuDNvPm3cLH0Zwq1mZmI5jUakZ+Tzld1Cmqm/bFcL6kgodE
         JtBDKsDXD6alHok2+e/X1uuNbWBcLMMpd1dcTrjhEuaqfWbd+qJy5i631FnrcX7X6D5B
         OeBnLE3t9IpOwktf9J/edSNcGWRZr/RbUh8N4dB1LeVVNdT2LXpQkFnXfCloiBHwRw0b
         iaJw==
X-Gm-Message-State: AOAM530TRcUHywg5mPA86s8ufiKNgoXkzZwXNOdvrP3KXKL8L6H7l3Dv
        PCCD12wrzIcNGKdOw8rTnDfa1D1XU6SMOxREWp/64TLnGTUNIoheZukskNUG2qp6uUo1f4UTqYF
        Xcnl1k2OySx4l3mv1WgEuXez2
X-Received: by 2002:a17:907:7244:b0:6f4:b93e:58a6 with SMTP id ds4-20020a170907724400b006f4b93e58a6mr24969821ejc.543.1652284569331;
        Wed, 11 May 2022 08:56:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUpXlveqJO5jCVPlVUgX9uBZ8ZXqoTYyuSpX0oWZBkPZpB1IPmGRhUeoeREm30aeOGDGnd+w==
X-Received: by 2002:a17:907:7244:b0:6f4:b93e:58a6 with SMTP id ds4-20020a170907724400b006f4b93e58a6mr24969804ejc.543.1652284569151;
        Wed, 11 May 2022 08:56:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090676c900b006f3ef214e63sm1098915ejn.201.2022.05.11.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:56:08 -0700 (PDT)
Message-ID: <e2f85541-3e7b-6120-1c44-70ec4447291c@redhat.com>
Date:   Wed, 11 May 2022 17:56:08 +0200
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Note not related to this patch, but when test building intel-speed-select
I got the following compiler warning:

  CC      hfi-events.o
In function ‘process_hfi_event’,
    inlined from ‘handle_event’ at hfi-events.c:220:5:
hfi-events.c:184:9: warning: ‘perf_cap.cpu’ may be used uninitialized [-Wmaybe-uninitialized]
  184 |         process_level_change(perf_cap->cpu);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hfi-events.c: In function ‘handle_event’:
hfi-events.c:193:25: note: ‘perf_cap.cpu’ was declared here
  193 |         struct perf_cap perf_cap;
      |                         ^~~~~~~~


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

