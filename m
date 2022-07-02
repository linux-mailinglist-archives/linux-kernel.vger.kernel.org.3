Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0B8563FFA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiGBL6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGBL55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:57:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C513F5F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:57:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so8420856ejb.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 04:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oct/Mca2P8XVhFy4lRX/Nm0TdLF7CZqD8kLxnCcVmw=;
        b=A9WAgXr9lDhNKgP4G8HYvjMcdINUQ+O0blKLB2tcp8kUZ/63IzSI/xZYQRUPLhrpfy
         OHlqJdRk1qxy0kKQDL3Kq+olIkO8QGyBDFDVHu4rvee9UY0ZMyXfzvxsfnEKJZCweEl9
         BK6I2ijY+vefkdzBrISFQlcPNajvjDFiLhIKoSSSVqUqjhbU+GA/19kyBalC7dHA4oOy
         RpAsKubmLZDqRQ31FWS1b30RpIxKLrGPxoKJlXfvDbMUr0QX7EsIUFJ3wqpGsGp81hYj
         e3P0ZWKU7TwiDIPYOgRgIOQc2AwHEA3qH78W04xh11GQGMc0EluD7megk9BWP123aSvX
         QMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oct/Mca2P8XVhFy4lRX/Nm0TdLF7CZqD8kLxnCcVmw=;
        b=h5V1pp0fSepltAaprXG2YY1iRDyZ2gW77Pq2E8+IPY/AvVqM6am5t1qyhfg1bQMMAx
         tP4r1KL0zJ7a9wsmaowo8QUjIozxxMdvhUxLQ4Ga1ISe40rd6N71hxiOXutyuJurRfMq
         /QTHGLhlua4eWx1oKlW9g/5UbVX09b06xBrWKVEaT+ElljldzwdLTKttCI3bOy1dbYSJ
         5NSRQUze68eelI3nisSDkz1maRdZ2XAOpaC2HRDgA1XT58IJl46k5E1f+QbrGxLt7Pmy
         oENziDqAx2Pm9w8rLgtQPgpnv7XYSxFo40GkqJz8Bct+DCDiaQtAdpSWedkk29Pzod6F
         Jp9A==
X-Gm-Message-State: AJIora8Jc5DD3i3Qk1fCbkygmR72R8KQCDTBtW1CIWpjQ5Zo910AOIZH
        Obwh1HzMe5hQZZUt4QDnoRGyen7mcx0Sq4VJTCoIDJDVNtA=
X-Google-Smtp-Source: AGRyM1sDKUNsykNANtDv0rrY4Qpou+53/pM5SXzCaaqED1Um11bXdi1XtBe/fgiKFE1UZZjQL3ZeH8oqIS9RfIUtfeM=
X-Received: by 2002:a17:906:d550:b0:726:2b34:2fd6 with SMTP id
 cr16-20020a170906d55000b007262b342fd6mr18529741ejc.311.1656763073979; Sat, 02
 Jul 2022 04:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
 <20220621072050.76229-5-christian.gmeiner@gmail.com> <2d475e77dca2395ee5b6fcff0e1d3ade2b0a36ef.camel@pengutronix.de>
In-Reply-To: <2d475e77dca2395ee5b6fcff0e1d3ade2b0a36ef.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Sat, 2 Jul 2022 13:57:43 +0200
Message-ID: <CAH9NwWc7x2nUQAhL4vpeOJ-gRUHs4QqqBeo4jbQt0e2Mb=a7_w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/etnaviv: export loadavg via perfmon
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas

> You need to explain a bit more how you intend to use those.
>
> Contrary to all other perfmon values, where we go to great lengths to
> only count the load put onto the GPU by the specific process requesting
> the perfmon, the loadavg values also include the load caused by other
> submits. Due to this difference in behavior I fear that those new
> counters might be confusing to use. But maybe you have a use-case in
> mind that I don't see right now.

I see these values as total load avg of a sub-GPU component. Sure it is not per
process but it is a starting point. I have no problem introducing per
process load avg
values .. lets see how the next version of this series will look like,

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
