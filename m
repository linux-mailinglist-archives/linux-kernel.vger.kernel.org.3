Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C255A11B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiFXSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiFXSoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:44:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB23E7FD15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:44:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eq6so4656156edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VX57bzNcj5z4sH662dwxPCfuAuhByjkAt4BvZ77sBWg=;
        b=MOcBReg0ICIq5qYDLdcmdE+4ehKszK3dO00drnWMdiRkCw0BWwYh0gt17NRvXenl/K
         mfDyDzCuQg6+JHfz8JSXZX5ejZDH9ogXrGpJvaI9ViY/YYne0QmIbnwIoRRRgZA6x0bZ
         8U6rllDjymhKOoU5x2gcZqNmNJ+84HkYhzgjXeT8/2OCnqYnP7eY3WUsWYbU21vrCkDS
         cfW4P5NKX1dRXAysCYYRoGECqGHnOLqbpANweOJjAcjmZ2w1s7d4joBsrHVWOx5guGuI
         U+lOSlRJnmGAbQ8lk/edWt4KoA7NaJtj536yktxmXTsmn69/UZ/I3giRSXDilYV445Dt
         70lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX57bzNcj5z4sH662dwxPCfuAuhByjkAt4BvZ77sBWg=;
        b=xg6NQZAgZ5BJEGbuMfQeBgdzty9KTeHIswTxq96BfraCeVt6XRA8duaw8EKOq5b6hj
         HtDOpVdLu/SD2WrfYvHtiUhpYsQdW0TqH1zBS65x8t0+Z6hhpt2FUlMD7rZ/hXwny/OM
         tMxmRc9q3oMOoXav3weyrCusZOlMsVa77k+U1vNPZRqyCgArO+e2466r1NHmUlYdhdYZ
         jmMgZteJDw599kYwwk17wWdxicxL1kIFCzYeaiXyL2jgfbaRsGsqU1ajUcz76gzubtYL
         X7I5Ak2dfHkOyfei6H7EYBWUJ0WkMIZfDeFgUoQ02sACmJlE1X3OspPSn4F3YzmUgso6
         Vntw==
X-Gm-Message-State: AJIora9uxJISm0EvcEKZbCe70DDji87fZiE2/4IvybUwiPfCJCDRjb8r
        kwSaLs6ueEVz8f+xa9ft/CaLE3aaBo4GLwrqlR2wSA==
X-Google-Smtp-Source: AGRyM1tQuF2QNbugVXp1L9OpiKHyKWyjy48JI3q39qKPoOXbInafNPSi1BeW//br0G8KfiuhCGEXrSCeSeSGHiWxLyQ=
X-Received: by 2002:a05:6402:5ce:b0:435:65f3:38c2 with SMTP id
 n14-20020a05640205ce00b0043565f338c2mr581487edx.347.1656096242346; Fri, 24
 Jun 2022 11:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220624024120.11576-1-hbh25y@gmail.com> <20220624173621.GC1736477@p14s>
 <47db0cd8-c940-6e74-f8dc-8e3931e13d80@linaro.org>
In-Reply-To: <47db0cd8-c940-6e74-f8dc-8e3931e13d80@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 24 Jun 2022 12:43:51 -0600
Message-ID: <CANLsYkzT5ZROReZNQ_eYL-r49ijaZYZ5TzdMpqy1RK0_hvW3_Q@mail.gmail.com>
Subject: Re: [PATCH v2] rpmsg: fix possible refcount leak in rpmsg_register_device_override()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hangyu Hua <hbh25y@gmail.com>, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 24 Jun 2022 at 11:45, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/06/2022 19:36, Mathieu Poirier wrote:
> > On Fri, Jun 24, 2022 at 10:41:20AM +0800, Hangyu Hua wrote:
> >> rpmsg_register_device_override need to call put_device to free vch when
> >> driver_set_override fails.
> >>
> >> Fix this by adding a put_device() to the error path.
> >>
> >> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
> >
> > This is funny... Neither Bjorn nor I have reviewed this patch...
>
> It was a fix for commit in Greg's tree and Greg's pick it up after a
> week or something. I am not sure if that's actually funny that Greg has
> to pick it up without review :(
>

The patch was sent out on April 19th and committed 3 days later on
April 22nd.  Is 3 days the new patch review time standard?

> Best regards,
> Krzysztof
