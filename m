Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930B74D3FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiCJDaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiCJD37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:29:59 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615F128DDC;
        Wed,  9 Mar 2022 19:28:58 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2db2add4516so44842637b3.1;
        Wed, 09 Mar 2022 19:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjd2ThEm3zd0tdYH3BroVF2CLX+6/0fXl/qPcVH3kk0=;
        b=atv8URorMFWVm7W/JbnBT43c4H/k3qoUj57eppDjHGR3aqIM+tNa0Nz1UfBYTZwn9I
         UqMHfRuLZpphvQAoeWZc2Bf3XnF/Yok43C7cooMQaiVQHPt4QL5BMx+gCezBteol7uC2
         DUcLCT2Gt4RNqmOwfaJ08DTkh8Xd16v8Noogn0pHMlCcFFWRU6jqpv1lXFXZ+QJx1kAO
         UKpSUdVkBzBzT28pE3os4dW4e2d8B7oxraaCb+ldm/SYdXrT1ZKKr72mI8+AGN8ojq/g
         Cpr3BxezQi8xPZfgz5LU2rePQj+QWzxMiC7kdqc2SWMc086F/wK+HyI5w2728N1997KA
         J5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjd2ThEm3zd0tdYH3BroVF2CLX+6/0fXl/qPcVH3kk0=;
        b=nQfxIKn25oAYiVQotPb4f+WkpYVS2lLyZBM+3q65+6IHvyEAqpbtaTKWQwj58UjbOG
         UfVGdTwMIYqzT8oqaItHJca3vmbAVblzqMPumCTo2qSQzg0X6rGUmJOKrkCadGyxtfa6
         Upy+i1qp3Flc8NXmYMD4Fx+ZRmj01mIzSpbb75xMAOV2M4ll0qL0StO7nivD2pyzJ+He
         Cew1FM33l9yV8/zk8wSqgWsGCESkSYm5pxOmECkPnhfgInUZvrhKC/76yKXiRgOWYk+q
         oUHfVnvaheKLojMOPTG71k+c68NWK5ZcGkxsXzvpD0c9fRotO0OtCCDZnk013+cAGZls
         vghw==
X-Gm-Message-State: AOAM530pf3gC5krrWrR5TmtQ+gCc0cd3K3Qm5QcuHoMycOBOzFYkkv14
        h2jm56fWCh3IylE371Y8AJmbVTHOJaHQoklyRXYVxAw6y7I=
X-Google-Smtp-Source: ABdhPJwZLh5gzQl0eGL9xgDrmBFKqP9/+8Q3CWZjcOwhGZLdASVXlUAwVF6AzHYD69B54vEAUxOA62gQg87GlyGMRhM=
X-Received: by 2002:a81:500a:0:b0:2dc:31bb:d11e with SMTP id
 e10-20020a81500a000000b002dc31bbd11emr2408106ywb.456.1646882937716; Wed, 09
 Mar 2022 19:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com> <20220309162301.61679-19-alexandre.belloni@bootlin.com>
In-Reply-To: <20220309162301.61679-19-alexandre.belloni@bootlin.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 10 Mar 2022 08:58:46 +0530
Message-ID: <CAOh2x=nL412tDb_6cshW00d2pntZ=cav=mRUpPoQfbM=f9r5UQ@mail.gmail.com>
Subject: Re: [PATCH 19/29] rtc: spear: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:26 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> While the RTC can store dates from year 0000 to 9999, leap years where not
> tested fro 2100. The driver currently stores tm_year directly which will

from*

> probably fail at that time or more probably in 2300.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-spear.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
