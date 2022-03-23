Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55A4E58D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbiCWTED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiCWTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:04:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003FF67D24
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:02:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r2so2845266iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILBTcqbT7I8ERAhQgoP+879JxAlN6lgSjFR2Kgt92rU=;
        b=i9KhzFRzSDE94JcTAqHIOza78OGHLvuqTh6NzpW8BI5PzZye1IJ7d6nWD7PtqzawGW
         mMfoQEZDw9pk8BfZMCWjhfof2Qm8+il7EkqfVe5Wb9R6LTxbjsespfOjq6xJBZv2aXUl
         SUMq2HTqb9HHeFrLPsvbnenp5I+9RcSNDa2N4mHzHDINbZL8BX/VjnCNMP+Yb6Vcj4eq
         kFfAa+sDq8GgM0t6y4ufe41nP5TJ2325djUZcJpVqYeoan02sKFBTcUA5XnEB6fmbBuN
         chh+y2yrE6c93BgcvJDq39xgSRanxBD8vwWdFFpdeO7YY+shjgRmS9ALjfBZ7frA+1dv
         SwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILBTcqbT7I8ERAhQgoP+879JxAlN6lgSjFR2Kgt92rU=;
        b=I/zv32PEiuqFyL4SNGCucTMsMmWxYKu3ictI8kUrcoEv6B5M3lvoWvR+HJn2R6g3/D
         FWZrzG74K04qsvFqjUDPlNPW6n3qnO3vShAQAIktaHrWBehBZzv97buuxJMABQcs+9Ap
         MHzNBRzyMn7e17NtoHdjt4rSIEpQw3tDicMTBdl3F3kFa6o6jdDbAMkrYFvFK4+8/1Ny
         SajBSOhJFQrTma35d9FJICb3DHMfbY6T9zLlvaJ+d3gOgtpeOsRRxoceovBLBZJALtxA
         9aP4AFuHFVRtvoxe0DbuGltFMA7PE4rcofHyQ1BdjnRHMY7iaaSXVa914rWblv/IWkZQ
         5SSA==
X-Gm-Message-State: AOAM533w6b0LWpUtrnOtRObXRJKnITwJUaqoUe2QAg0p9u819iB8bdOF
        585FyFnjAXYOVGZdgJlSszueqg6Af2mqF8EkeA8=
X-Google-Smtp-Source: ABdhPJztMHMmsNQy8dQ5gWQnBlTdXE0AU/DGUamXU3evKA4MSjOxM9U2wi35kk1dN6m420ZO683FctYgQlzAOzhG8WE=
X-Received: by 2002:a05:6638:16c6:b0:31a:c83:bc7c with SMTP id
 g6-20020a05663816c600b0031a0c83bc7cmr784674jat.264.1648062152433; Wed, 23 Mar
 2022 12:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 23 Mar 2022 20:02:20 +0100
Message-ID: <CANiq72kLxzRdXSQfjXBL9xixXBwbxOAhZ4fR_+GtgT5FXz7vaQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] auxdisplay: lcd2s: make use of device property API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Andy,

On Tue, Mar 8, 2022 at 4:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Make use of device property API in this driver so that both OF based
> system and ACPI based system can use this driver.

I applied the series to -next, but for my understanding: the device
property API was already being used, even if non-OF platforms couldn't
use the driver before this patch, right? i.e. the commit message seems
like the patch modified the calls.

Cheers,
Miguel
