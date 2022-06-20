Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E414E551F12
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiFTOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiFTOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B65136386
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655733177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOK78pMDu5Gw+NHDV7mvfymArER1DCvC65M8XZ4Vtbw=;
        b=HBhFlgwQXxaRKsqc/4M85Y1t+N2k9JbVtqc2iMyQXvRchBy5y6UEt5bqJLE3BW1D4PH+Hh
        2UXsuMTrAbhJPqdH1bjb46qPlXV60YUYNvukPMAc4VRU+SPgIBGyqxQ1tXYhS9Kc45comw
        qmIACb1uMP16aCjR3wSLbyDb1SEWBS8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-tnuzEwsnOSyT23n7A2PHew-1; Mon, 20 Jun 2022 09:52:56 -0400
X-MC-Unique: tnuzEwsnOSyT23n7A2PHew-1
Received: by mail-wr1-f72.google.com with SMTP id e21-20020adfa455000000b0021b80b12356so1987406wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vOK78pMDu5Gw+NHDV7mvfymArER1DCvC65M8XZ4Vtbw=;
        b=iCk3EMOlSoK3xIK9NkMGixep7vn5fYhCuJczJ7GuYwPCifobfz7j74NefYlqGQ9F5U
         yq+SdOT5ubAsg03m1aCVbkNd/DQBW1vpiPymoFXClCiUkUr9/jQ2nigWCP2DvVo813Qx
         z8nj/89j0BWu97xHsFtZCNab/v0Yr3pIDFTlbfE9BR+Muhn3mf0DHa9ELQWiVNovB3B3
         XkKxKp/BBIuVPaOhPlcfAlagyzElQz8cX1KCN+JffLyEhFI3oH4Ci18EYJSeo4b4FTyS
         BbkzLQXHQx/UuQAYYDMtybqqK8wM9Vlc1X2GnXFRmHb4Yfa+lZq9hEqjeXMZEy6AWdEy
         qhHA==
X-Gm-Message-State: AJIora88b42pCjSNiJwTUxapbE1+g/kPXK27M/Fi0YSkBXg/FJJv4YUs
        aesbW5E0f+FOJNuvA4Qs7dA/KCTqoVPt+Zpxbe4sRantnIp7d2V7nN2QOAy9/LfRp8mYBXArlDx
        ep4UnDj0uWqiqS5U6G3TI+Qxb
X-Received: by 2002:a05:6000:18aa:b0:21b:9477:a84b with SMTP id b10-20020a05600018aa00b0021b9477a84bmr1079281wri.179.1655733175409;
        Mon, 20 Jun 2022 06:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shzViJinr6p/h9CHdRMj7lpY5WLIY1OBDC4zxNesfyf3j0+t6d4SDGJOzk/9zuzwdhEGjSXA==
X-Received: by 2002:a05:6000:18aa:b0:21b:9477:a84b with SMTP id b10-20020a05600018aa00b0021b9477a84bmr1079260wri.179.1655733175197;
        Mon, 20 Jun 2022 06:52:55 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c3ac500b0039c457cea21sm14511827wms.34.2022.06.20.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:52:54 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Brian Norris <briannorris@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2] sched: Drop outdated compile-optimization
In-Reply-To: <20220617203458.275319-1-briannorris@chromium.org>
References: <20220617203458.275319-1-briannorris@chromium.org>
Date:   Mon, 20 Jun 2022 14:52:53 +0100
Message-ID: <xhsmh7d5b787e.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/22 13:34, Brian Norris wrote:
> Looks like this exists from way back in 2011 (commit 095c0aa83e52
> ("sched: adjust scheduler cpu power for stolen time")), when there was a
> little more aggressive use of #if around these variables. The comment
> mostly serves to confuse the reader, although it may arguably apply to
> the (excessive) #ifdef CONFIG_HAVE_SCHED_AVG_IRQ.
>
> Anyway, the #ifdef is not needed, so drop both the comment and the
> "optimization." Any modern compiler will realize this block is not
> needed (for one, update_irq_load_avg() is an empty function when
> !CONFIG_HAVE_SCHED_AVG_IRQ).
>
> Confirmed on:
>
>   x86 gcc 11.2.0 (Debian)
>   x86 clang 13.0.1 (Debian)
>   aarch64-linux-gnu-gcc 11.2.0 (Debian)
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

