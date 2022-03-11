Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C154D6660
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbiCKQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348567AbiCKQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4114665A7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647016362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIiyo/Hz9JMpDwt94KYeCOdCYlTzYuM5+GHnQsk/7+4=;
        b=banAhU0ofeaF4znZ6rqdIRuFF2Ofgsb9POM9+WjLwKCPvmnWu/EDoXznz5/VE4dfDweKJH
        2FMRiv46VDilqoidcL8d6kTi+nG/gxM3xdBqHHMv9f0BX5eiCxQ/6YNpPSLNMvhoyBRNDU
        cvJ1lvlQnnvGySlRlpWBPzE6p2DWAe0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-9Ot-QnO3M4eKEjoTECoYxw-1; Fri, 11 Mar 2022 11:32:40 -0500
X-MC-Unique: 9Ot-QnO3M4eKEjoTECoYxw-1
Received: by mail-wm1-f71.google.com with SMTP id l13-20020a7bcf0d000000b0038982c6bf8fso3625556wmg.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIiyo/Hz9JMpDwt94KYeCOdCYlTzYuM5+GHnQsk/7+4=;
        b=hA3XWyPAiR0kWRSJvMzvFSH3HcmEn18Hoz/sQulV14IKqXwsFH8pPNRy1h/7HkbmA1
         79TrA+Z5Nb17YU+fLDUhBeCjr4REnctOzKTJb82Ch+yqAykvySZXh1t2EDobOxp/ml3z
         ju+8Y6IGOe+iDwCbByA/WYrcPFnxLOKf/t5nUq/Tq0Wjtx1MUQnRKua142S4Uw3b6kOl
         5YinXmp1lcITbe2qEcUkUTipK4cNDyrr8U8QYlpzA13dWKFyeuHKAQqw1uV+Jw/cvEqe
         uX+yw7Hq7hG7cAA7cpMsguiHnRAoj0r/Ed/OSodMbYHEmpFhILiTuiRoTqHys1FgpeJh
         6beg==
X-Gm-Message-State: AOAM532pU8+Yi0kYcAyNvTE+VZzegiWI752I3rvf0nFKiPkzGzd33++O
        czOjngl+XFH0nA1+MmtVcg9fJkdDjaDnzfyxwSkq+dSfqx3rHe2hivOvOPRT/lQMmyFNtGXRXPk
        PoWqm9yWASgndZhlgkm3LU7+z
X-Received: by 2002:a05:6000:1104:b0:1f9:7df6:c864 with SMTP id z4-20020a056000110400b001f97df6c864mr7890480wrw.63.1647016359447;
        Fri, 11 Mar 2022 08:32:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW7xVvJKrOS4i/VOXAwIU8h5bRNK36QLS+yGu7beP2gTUOBkmEGhe0SKy7JrVLcX09APi9Jw==
X-Received: by 2002:a05:6000:1104:b0:1f9:7df6:c864 with SMTP id z4-20020a056000110400b001f97df6c864mr7890465wrw.63.1647016359206;
        Fri, 11 Mar 2022 08:32:39 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a1c:5a01:f0e6:1d65:f381:51c4])
        by smtp.gmail.com with ESMTPSA id i1-20020a1c5401000000b00389f76c1325sm578681wmb.47.2022.03.11.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:32:38 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:32:36 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V3 00/15] rtla: Improved tracing support
Message-ID: <Yit5pMZVCPFAXE/e@localhost.localdomain>
References: <cover.1646247211.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646247211.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/03/22 20:01, Daniel Bristot de Oliveira wrote:
> This set introduces some tracing facilities to rtla tools:
> 
> - Add the possibility to change the tracing_thresh to osnoise,
> allowing a fine tune of OS noise detection.
> 
> - Add the auto-tracing feature (-a threshold us), which aims
> helping the first approach to a problem by setting common
> tracing features with a single parameter.
> 
> - Add -e/--event option, allowing osnoise and timerlat to
> enable additional trace events via (possible multiple)
> -e sys:event options.
> 
> - Add the --filter option to filter the previous -e event.
> 
> - Add the --trigger option to allow the usage of tracing
> trigger of the previously set -e event. If the trigger
> is hist: one, rtla automatically saves the hist file
> associated with the -e event.
> 
> And some more improvements:
> 
> - Add --dma-latency option to tune exit from idle latencies
> 
> - Some minor fixes
> 
> Changes from V2:
>  - Rebased to for-next
>  - Add --dma-latency
>  - Some more fixes
> Changes from V1:
>  - Add -e to osnoise/timerlat hist
>  - Add --trigger
>  - Add --filter
>  - Add support to save hist file
>  - Function name refactoring

I took this for a spin and it looked good to me!

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

