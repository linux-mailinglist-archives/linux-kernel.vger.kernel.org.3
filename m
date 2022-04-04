Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811EA4F1E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiDDWOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356367AbiDDWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:05:39 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED04A3C5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:43:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2eb9412f11dso19607747b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mr13sTe9S5P+5Fhg+wh22VL3ia9fpyUX966OBWfTLkc=;
        b=oYZ8dVpTOFeU7D+TM02AN6Wr769JI0IIjpYWeqQ+Z3SGqPZywVpsTsHx6BmT4To0GA
         MTCmL6WOm3FUQxWUYlYYJDouiyVvKjXb+uSAzWriVCAm8BvxKmxLEJ0BjsL+NDYgjynE
         DDBjsZU1pQ1KUiUzEsLXM6gUhXdVrLYiXRxq7RkCasuovcw4YlKqDB2AIUlABGaZ4hzo
         HtEqyCLYYhunnCWZ/1JMpRiOOL4VsmDInF+XNSjxH8iZjCttPCdrl/zvHUP3qJ+K68Z5
         7RIIAyLsx38vl2myRcoO6cZKIdiSBTJ67WaHGesIPR+39IkAhf0/JuhEDYhC50lYpQMN
         QEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mr13sTe9S5P+5Fhg+wh22VL3ia9fpyUX966OBWfTLkc=;
        b=DOG/sfrWjdm5pemyOiGfjsLBRVfbTNpy2Q/1BA22qf7xtpOsO0Shbumk+WeddlHeMe
         Q/DCgQhldghqZzKXGQzHjVUW5GWAUf+t4E/01BZ+I1HNZnScGOGbv0qIQVkczq8Wf/ew
         rlaw7k9I0jpzlARMT8O2/YzqqnN6KY25oKH39ly5NP/nPs7iHiAV4L1yG/L8x5H+EQnr
         +plroaaoYoYCWaClSM6w23FQ0m3jb7rjuvPSFR6WJ+YUhoqb8K5LU7NsnKPjq5i+74pR
         gCXQh5cfkL8qTYsg+i4aG3jAJxf4YF28snS0c+gn4cisYGIOfxZj4Ijj4MfVaO3pQfkO
         TOcg==
X-Gm-Message-State: AOAM531eIECn2pV9phCRdN4RiiQlpN+hpXKegnAKAATaUrNtG21+nRlM
        fEHSxgm9oXo8a0U9GBr8FlZEhF+lICi2NJly46TavnpxWgZzZw==
X-Google-Smtp-Source: ABdhPJzt85GxkABljpdoViylC1cpfWRSKb9qPQ1y+8bvWSMoJfBDA7k01Qotg3Ej9T1lzLK5pHJX09a0DIOLJBz0yD8=
X-Received: by 2002:a0d:e616:0:b0:2eb:450c:940b with SMTP id
 p22-20020a0de616000000b002eb450c940bmr133822ywe.114.1649108580856; Mon, 04
 Apr 2022 14:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org> <Yh+QeWEufbp2JLo+@matsya>
In-Reply-To: <Yh+QeWEufbp2JLo+@matsya>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 5 Apr 2022 03:12:23 +0530
Message-ID: <CAMi1Hd0ZCM8nVXTyWYkZgk9LMXcKZGBVAJ9LxEj1LR1px+bmFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] soundwire: qcom: add pm runtime support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 21:13, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 28-02-22, 17:25, Srinivas Kandagatla wrote:
> > This patchset adds pm runtime support to Qualcomm SounWire Controller using
> > SoundWire Clock Stop and Wake up using Headset events on supported instances and
> > instances like WSA which do not support clock stop a soft reset of controller
> > along with full rest of slaves is done to resume from a low power state.
> >
> > Tested it on SM8250 MTP and Dragon Board DB845c
>
> Applied, thanks
>

Hi, this patch series broke audio on SDM845 running AOSP. I can
reproduce it on both DB845c and PocoF1
https://www.toptal.com/developers/hastebin/raw/rodazupayu. It is not
100% reproducible but can be triggered on every alternate reboot or
so.

Regards,
Amit Pundir

> --
> ~Vinod
