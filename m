Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF44EED2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbiDAMdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbiDAMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:33:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE425F254
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:31:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q20so1610994wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjHen8SjurGesv2/euau4gflSw1KQFpZxY2bQ80GWWc=;
        b=4nmMhJBetoYm1lZlMCb31TT7Q/YqTMXFw/vdDDCiqMQui8pdlrPAgDSr4iLNLk81lt
         P4L7OZEbahfo6oNPilxT3fAnrGwcQemIOCzIyvg/Jlh9luW+74eaHIsWgXQ+gSacnCtb
         quzW+wSAWHt89ynaCi6u/Sj4hKMIoRbGzKbW6CNEkgHiqiVKMDz4hm6MKC1FT8vqXI9w
         nMfOLDSgBfsbypS1MRrXzUKuBFkal+Mbdyu2Qhh1tSMRWO6k0YAvAst4gto2/HjQG8rs
         a98p7sGLSQxmKh6G2U/AXLdknnV7dKcKKbiCZtcPkkj6GoAfqV0ctTLKiSYTQ7kvjnFk
         lyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjHen8SjurGesv2/euau4gflSw1KQFpZxY2bQ80GWWc=;
        b=IUUIgkAH0vpxN0z7N6nWfw0PB1b5+drgF98vSQ6AzoBWBXZ5qnOk8S3P6EAdNOHVhi
         4d2mE3OexhvGIL58EGdk+MEC8a2vvGOp0OoAbvOlVZaYHlwYwv+0SCgeve9p+/ULtl+f
         168eVO6zQ2tsIPMuOzaq2KZhTIQTani9eKz0Ibu0JhKKztcu9IwXRMzGvjCW6hpEAgQY
         3dNDHAEtIB1f/vHuOtFvsBkoZcp4Dh9EiuhkPAmRlnOMPTWQeVwiQmgZU0q28kJnXJ8c
         IfjTFJV6whNfAKD91hSGcyFruL4Rj8POhtf61vrRmznMOeDSpPYo8t6fMinIb9nXV+V/
         PhCg==
X-Gm-Message-State: AOAM530NBJwXSvKJcnVfUOnt/S2grz6d9Rf7d5EgZxTrUp79E81DynTr
        cJDoD5PWYWwXzqGIEKtsgv4RwJ2EX0W0SDtlJOUAEQ==
X-Google-Smtp-Source: ABdhPJz4Cw8Lc3YzkpvNHzTnf1J5O+dJbnkNlNzONropveVyQes/R3govCZ1BmuhcVKV3tOg49L9fnv0+pqgJWj6/OM=
X-Received: by 2002:a05:600c:3009:b0:381:194a:8cb5 with SMTP id
 j9-20020a05600c300900b00381194a8cb5mr8871178wmh.43.1648816289933; Fri, 01 Apr
 2022 05:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220401083637.2407766-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220401083637.2407766-1-lv.ruyi@zte.com.cn>
From:   Philipp Reisner <philipp.reisner@linbit.com>
Date:   Fri, 1 Apr 2022 14:31:18 +0200
Message-ID: <CADGDV=Wf9MpS7_3C6=RNTBO5rqxjtWOz170=7K215R9X38yc5w@mail.gmail.com>
Subject: Re: [PATCH] block: fix potential dereference null pointer
To:     cgel.zte@gmail.com
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lv Ruyi,

This patch does not make sense to me. A request can only get "TO_BE_SENT"
when the connection is established with the corresponding
cstate. Establishing a connection can only work if net_conf is set. net_conf
can be exchanged to a new one, but never become NULL.

Please share more details why you think this NULL check is necessary here?



On Fri, Apr 1, 2022 at 10:36 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> rcu_dereference may return NULL, so check the returned pointer.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/block/drbd/drbd_req.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index e1e58e91ee58..8ab6da155e2f 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -577,6 +577,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>                 D_ASSERT(device, !(req->rq_state & RQ_NET_MASK));
>                 rcu_read_lock();
>                 nc = rcu_dereference(connection->net_conf);
> +               if (!nc) {
> +                       rcu_read_unlock();
> +                       break;
> +               }
>                 p = nc->wire_protocol;
>                 rcu_read_unlock();
>                 req->rq_state |=
> @@ -690,6 +694,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>                 /* close the epoch, in case it outgrew the limit */
>                 rcu_read_lock();
>                 nc = rcu_dereference(connection->net_conf);
> +               if (!nc) {
> +                       rcu_read_unlock();
> +                       break;
> +               }
>                 p = nc->max_epoch_size;
>                 rcu_read_unlock();
>                 if (connection->current_tle_writes >= p)
> --
> 2.25.1
>
