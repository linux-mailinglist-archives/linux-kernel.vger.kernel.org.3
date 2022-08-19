Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138A5998F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348208AbiHSJr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346902AbiHSJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCD5EEF32
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660902442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lMZ2tlr9OXZUpmoDj+rHRu4KhHy68wISKdzPx4ZgD8=;
        b=FCZIRxyqoTz6WT8TZtiQDxYFJzU9oSwr8ZxbpCvGdf0eG6Vom1KYgvOW/XAwE9IagCAIQX
        BSozO7j8q9C+kiXMbHiEw6H4FpVE64DwNf145jHcs959KnSGfLtUv3t97pjm7mz22TTemp
        y/gB2HQylEmwlgOqWI49J8X8edpGm/8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-Y0PYAS-2MDq0cSMqgHeftw-1; Fri, 19 Aug 2022 05:47:21 -0400
X-MC-Unique: Y0PYAS-2MDq0cSMqgHeftw-1
Received: by mail-wm1-f70.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso2204872wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=5lMZ2tlr9OXZUpmoDj+rHRu4KhHy68wISKdzPx4ZgD8=;
        b=wV+mwEg9KZzrRytF+KtoJ1+GtWKYOaPhzUZSlw1AzqLgpecYITqNph54vSGvaGN85v
         8La1nYhF7Uhj0k+ykQPxsNBqrrdKn9lqjZj1bsHGTwaUFk8Ig2qbP/y2BHii7hc7XMAL
         cWpSHPNF+4CScjMhwAPIkAA4hRYSTSoJz+2pK5/rLH2xvFmH8Tm/k+sv4s5Zv418cDZa
         weJ0caxt7XPs2HEN6qP8/HDCsxvSe2AZhg0HkByvtieOS84Yk5aGdLUR9W8I99Vfu0ig
         ac6gwuNH3TVaMJVrR9yqAVc1KBsIRt9IMOs/WMMI10SN0RE7eobG/Z0pppqsXg+xUn9w
         T40g==
X-Gm-Message-State: ACgBeo1zv5alvzYf342QdDbLSj6x4KgPzBAA1g8qPD+Y2Fx9OERk8HZX
        H+aexBD3O00MvKYbf1ow/tqdWN43MXtKYeyA/ixznCTiaffPCS6ZVqkrd3gM1YgL6XqRuU37TeD
        iJhizpgNkzUKXBMPfSVT7Mok3
X-Received: by 2002:a05:6000:1ac6:b0:225:2e67:6ba4 with SMTP id i6-20020a0560001ac600b002252e676ba4mr3918689wry.321.1660902440454;
        Fri, 19 Aug 2022 02:47:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7nQvOWV3ULJGGviUNHqU+TpGchBIgqEmBu6MJDb5xkuEy7gzhYLWgD+bRw0yeEGsmQHQIRbw==
X-Received: by 2002:a05:6000:1ac6:b0:225:2e67:6ba4 with SMTP id i6-20020a0560001ac600b002252e676ba4mr3918675wry.321.1660902440200;
        Fri, 19 Aug 2022 02:47:20 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b003a54f49c1c8sm5421782wmq.12.2022.08.19.02.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:47:19 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Bing Huang <huangbing775@126.com>, mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Bing Huang <huangbing@kylinos.cn>
Subject: Re: [PATCH] sched/topology: Add __init for init_defrootdomain
In-Reply-To: <20220810033932.171690-1-huangbing775@126.com>
References: <20220810033932.171690-1-huangbing775@126.com>
Date:   Fri, 19 Aug 2022 10:47:18 +0100
Message-ID: <xhsmhr11ca7kp.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/22 11:39, Bing Huang wrote:
> From: Bing Huang <huangbing@kylinos.cn>
>
> init_defrootdomain is only used in initialization
>
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

