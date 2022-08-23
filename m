Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8976D59EB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiHWSv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiHWSvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:51:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D0C877A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:14:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x5so10871718qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Jl7QpGWs3fSIOiwFofszvrGHHvncc4MbU/7u4S5E9/8=;
        b=TVRjqNKTkcZsOWoJUtNkKqkrqnNgsUcxZ3iU7mf9gQMukXt6eadTKffbXPftXiPSw7
         pbFdaX/XvKcKsmy0y0iOhL+TWd/nqVt6EKTwiGap0p7R7LfDX5ARSpal7E01PxEC7fyi
         osQ34y+6+VdnAkdUziRNLHbQag8PfiJU9szmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Jl7QpGWs3fSIOiwFofszvrGHHvncc4MbU/7u4S5E9/8=;
        b=WF/xR6ZL8l3fo5Uvk33L5AvZsgh60TEn+xoPBJDRqg1gWULMYsUD3hAaAnFzFRKj0O
         wy1gqj6dAiNAE2zILej3Utw6D7iFlnS8Vda+i9SN0hNYhLXzNIBNCg+3lSdNuuLEynx+
         8e/ihsZbM8qtSseY1pa2vTRyEG/GfV+zWJ01hetX2GH70LIki1bpxCqZ1lBBLYpaR8IG
         S6VJtI/q+LV24cH3flW8W6Rr2h2I1QiuyGNM9jGmkVh7LTAu+Hp2quA9YAMSDBZeGQcs
         nZ+UgrKt2Sn/yo1S4xjEod2abE6y+baECk1Kn684aWYHLP4+CQkGLJc4GW81LtYkR6oV
         fKIA==
X-Gm-Message-State: ACgBeo3JGabpbe/aMY+Bt52g1gR6OevR9XusISA3ndiKN9464h0F/j+f
        jbulCE2K0C+0ABLv1UVJ9RD1tBsjHn4K5exL4zrH0Q==
X-Google-Smtp-Source: AA6agR7yZgIhhbEKYBINUBSQ28jS9HzTWpx//defT/uB39yIdcraprXQFrAHtvaBYb93jBLIeUBHy3EZq6WbpST8MqA=
X-Received: by 2002:ac8:5ad2:0:b0:344:90e7:410f with SMTP id
 d18-20020ac85ad2000000b0034490e7410fmr20659384qtd.625.1661274865816; Tue, 23
 Aug 2022 10:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-3-pmalani@chromium.org> <YwSMYb67PMAEkv8f@kuha.fi.intel.com>
In-Reply-To: <YwSMYb67PMAEkv8f@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 23 Aug 2022 10:14:14 -0700
Message-ID: <CACeCKadLYXPLSLzgv5YbBLjb3Tc73-_qiTM_HBDq4CXbAw+8Yw@mail.gmail.com>
Subject: Re: [PATCH 2/4] platform/chrome: cros_ec_typec: Correct alt mode index
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks for the review.

On Tue, Aug 23, 2022 at 1:14 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, Aug 19, 2022 at 07:08:03PM +0000, Prashant Malani wrote:
> > Alt mode indices used by USB PD (Power Delivery) start with 1, not 0.
> >
> > Update the alt mdoe registration code to factor this in to the alt mode
> > descriptor.
> >
> > Fixes: de0f49487db3 ("platform/chrome: cros_ec_typec: Register partner altmodes")
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> Shouldn't this be applied also to the stable kernels?

We're not planning on backporting alt mode driver stuff to older
kernels, so probably not necessary
(aside from where it gets auto-magically picked).
Userspace currently doesn't use the mode index for anything.

Please LMK if you still feel it should go to stable.

>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
