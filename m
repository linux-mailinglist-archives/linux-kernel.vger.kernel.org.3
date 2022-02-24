Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B54C3257
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiBXQ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiBXQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:56:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891219C34;
        Thu, 24 Feb 2022 08:55:36 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m11so2267277pls.5;
        Thu, 24 Feb 2022 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3jupyhKXUVgzI8jl6XLkxB3VWZ4j9bVDJBTUD2oEwyY=;
        b=BOJNjF3xyVndodCcQOK86cBfUWQhJA40AxnlGYqWlLmglYuNH2k70JUJ9UlFA0iK8q
         xl+EMxPU2sd48ePOxgbDoRzqyab9Pvqd7+aagqFqiaAxENZ3klDcSuGLlpTZOBMzvYeU
         Zk8E/dL3HW61Y2bMNHVG4Sf1kFxJXd8yROaX/SK3G6jdSh4r3rE+i018U51E3KInLFlu
         bR3j6zHHUfJ+n1GuNQdhxyD6c9LTiyOlLiG2pHEo3H7ng0FtX4f7qUy5ielAJ7RP59WO
         HUVe9AKSF3kvminEYa6Ch0dOBFmQakw6ICZ+juP8uVJRkuyGZ5lpG6XOqRhNks8/eq+r
         DGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3jupyhKXUVgzI8jl6XLkxB3VWZ4j9bVDJBTUD2oEwyY=;
        b=h3qE2pEDK2WGnoiSEzvs37Z2DH+Odqzr/NFgimhDmws2ZJZe60OeBDbKLOOMiRlHzV
         jTiQ9LBAh5rgdS6WOr0GKIg/rgmVUtzPu8rMFrdVc31zhJ0o+p8qHmryA/kaxvTSl/Rm
         z0JLTybogmb2E2ecPvm/4kQDob1ge0XdUUw2u+4go2k4NPhiX1j8CklqMhVYB7KWv6PH
         oKoXutbnOZZwqMSdxJtcROVQ6v4oye1AEgbSFP2EGG0NaJ/arwVq24tZTQf3PGF6WlfK
         UYhp8Q4t8kyKv11preKIyZLwb+t8bOCELl85o9FDpXH09AE3Gh7e734C7HHi3dnIGfJE
         j+SQ==
X-Gm-Message-State: AOAM532uvuUXzAYUGbaBSwnxXgo/n7faY9lAJ09hyP/ZLOJJVkbckjBe
        2SM/hrTw7++2di+BTO1gmtQsAOV3NQo=
X-Google-Smtp-Source: ABdhPJzpdF6V+TrUGFelU7N+ech1dEa5Yf8cBaK/SZaPLwugPzG3cUTrbKfY5N1wAuiv2rpp21ljzQ==
X-Received: by 2002:a17:90a:e512:b0:1bc:22c8:cc82 with SMTP id t18-20020a17090ae51200b001bc22c8cc82mr15450092pjy.208.1645721735718;
        Thu, 24 Feb 2022 08:55:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id pf14sm3750081pjb.16.2022.02.24.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:55:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 24 Feb 2022 06:55:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V5 02/16] blk/rq-qos: prepare to make blk-rq-qos pluggable
Message-ID: <Yhe4hmVyh9ygGycR@slm.duckdns.org>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
 <20220224090654.54671-3-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224090654.54671-3-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:06:40PM +0800, Wang Jianchao (Kuaishou) wrote:
> This patch makes blk-rq-qos policies pluggable as following,
> (1) Add code to maintain the rq_qos_ops. A rq-qos policy need to
>     register itself with rq_qos_register(). The original enum
>     rq_qos_id will be removed in following patch. They will use
>     a dynamic id maintained by rq_qos_ida.
> (2) Add .init callback into rq_qos_ops. We use it to initialize the
>     resource.
> (3) Add /sys/block/x/queue/qos
>     We can use '+name' or "-name" to open or close the blk-rq-qos
>     policy.
> 
> This patch mainly prepare help interfaces and no functional changes.
> Following patches will adpat the code of wbt, iolatency, iocost and
> ioprio to make them pluggable one by one. And after that, the sysfs
> interface /sys/block/xxx/queue/qos will be exported.
> 
> Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>

As discussed before, the addition of new interface and custom module loading
mechanism is unnecessary and undesirable.

Nacked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
