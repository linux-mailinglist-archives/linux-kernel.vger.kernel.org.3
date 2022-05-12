Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875CE524B15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353013AbiELLLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiELLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:11:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A475372B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:11:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dk23so9482126ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mU7DjZ6YdE5ZE6KKWVtlZVe9sgVvfea3+yMKl+vOnVo=;
        b=Jz3TNB8Ix/xBZkbtD4X/DUmSq4yrvweuymYmhr87xqoKK5IUcCStHAl/E63TFW9yig
         lcBfVAgG4F3Y70mg4qNIlVfbSyle/W6kkfNPBn3V53mF6wXoUvnWuh2G1uaOVPh2pNVZ
         29PL1PqFKJ5Q17EoiAxRowAF6RaaQR7bHgXdonm7011jncH3ynSsle0eIJlA38q6o/gw
         S1P4+n0yOKA0iDNxa2RRjZZt9ImKvr+7LHeXFbgqRiKSRfKwe7SKImD52XXg0ib0zhG6
         D3sR9XXM3oS9fT4pT7hGWd8NX+8ZgSsFY/YN26HVof+qfy6t65+FRNetsjng4OXJYS5y
         tVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mU7DjZ6YdE5ZE6KKWVtlZVe9sgVvfea3+yMKl+vOnVo=;
        b=XhQEKVPCAHrXLh8v+vjXdaeh71pQmCVSJX3MwiP/C31e2Tgnv27T0Ggv7JbNEXsWlp
         +BkY/8HkMEKsA9SZu4M7C0WiWOpYML9EpO6C7V6+FDP2ViQCnO47Xn2+YxmDmqHp62lm
         Wt2YArTAwSy2Iz7/2QY+fh+jkVpFU8PzcYvSBfn65lwwZyAh2L9okgDSwH1MYCLz2Dp9
         CBPTf1AYet6bydYNeQgRsh1rJMHw6SiPuctNanG7RTWfHfQbGzzhN9n035b15J9pdGEa
         cuMC9srTYoeGYkvoq5Lxugc8ZakJHZSBY+ixiuA2gurmcZdGx+Sap7/fFkA4L/QlM/gc
         wy9g==
X-Gm-Message-State: AOAM531pJ1KvxwaUiG/Y9pFRd56eKQXkja6VoMo1xYzD0xo+OuOzn6fq
        qftG+/Ko235g5r93kr/hJyY=
X-Google-Smtp-Source: ABdhPJyAzjR5uVZuKuZsiWODeTC6oFfxt4BJFSeN9J6FT/+zjzv4PUPDOISmQAZEk6erZEgvpK+x2A==
X-Received: by 2002:a17:907:c28:b0:6f4:2a80:f355 with SMTP id ga40-20020a1709070c2800b006f42a80f355mr28999239ejc.101.1652353884087;
        Thu, 12 May 2022 04:11:24 -0700 (PDT)
Received: from archbook.localnet (ict-networks-195-176-112-051.fwd-v4.ethz.ch. [195.176.112.51])
        by smtp.gmail.com with ESMTPSA id y17-20020a50f1d1000000b0042617ba6380sm2436781edl.10.2022.05.12.04.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:11:23 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to boot due to firmware bug
Date:   Thu, 12 May 2022 13:11:22 +0200
Message-ID: <6587375.6lpfYT6tjA@archbook>
In-Reply-To: <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
References: <1698297.NAKyZzlH2u@archbook> <YnOEwuuyO2/h7c1G@e120937-lin> <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry for the late reply, completely missed that there was a question
for me in this mail.

On Donnerstag, 5. Mai 2022 11:40:09 CEST Etienne Carriere wrote:
> Hello Nicolas, Cristian,
> [...]
> 
> Indeed the firmware implementation is wrong in TF-A.
> And also in OP-TEE by the way:
> https://github.com/OP-TEE/optee_os/blob/3.17.0/core/drivers/scmi-msg/base.c#L163-L166
> 
> @Nicoals, do you want to send a patch to TF-A, or do you want me to do it?

I have no experience with TF-A, so I'd prefer if you could do it.

In good news, Rockchip has confirmed they're preparing to release RK356x
TF-A sources, so I'll be able to port the patch over to their sources once
they are released, if they don't already apply it themselves.

> 
> I can fix the optee_os implementation. I'll tell you when I'll have
> created a P-R.
> The fix is the same for TF-A and OP-TEE.
> Proposal from Cristian looks good to me, maybe simplified:
> 
> ```patch
>          memcpy(outargs, &p2a, sizeof(p2a));
>          memcpy(outargs + sizeof(p2a), list + a2p->skip, count);
> 
> -        scmi_write_response(msg, outargs, sizeof(outargs));
> +        list_sz = (1 + (count - 1) / sizeof(uint32_t)) * sizeof(uint32_t);
> +        scmi_write_response(msg, outargs, sizeof(p2a) + list_sz);
> ```
> [...]
> 
> BR,
> Etienne

Regards,
Nicolas Frattaroli



