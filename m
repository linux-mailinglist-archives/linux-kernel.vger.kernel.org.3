Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58635A1DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiHZBLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiHZBLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:11:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F674C6CEC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:11:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so6644649pjn.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=R7xpL2cmCkMD4jtRFgP1b3ShRkD2+jaz3DYrJUN7tfs=;
        b=SqU9cO8kD/wD1O+bTGLiXC4p6XIs1R6rFC/4FHxEwYybU1h2ZBaJy3E338XFJ7t6MZ
         2ThdV0pPgtklaaTHok5FcRz81/gKnh8b2Giu7KR0zH8Sr4StIieOscmhiLQv0KXTwnQ7
         kB2soe7ry9pjFpy5TSe1sjoCGdGhjQVUrFaWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=R7xpL2cmCkMD4jtRFgP1b3ShRkD2+jaz3DYrJUN7tfs=;
        b=nLxAceyJV419W0i0aksQaZaFpozkRFwbpceXoKJ3zIegcL4QbCo1N9d4Z1tAb4x70T
         BwBfi+nHApPvtLX+LU3RdP6sVcnXCFubfWfqiJ7FvXi7pDJRS4Nuic6shWOR+RxfpDRh
         TZ20/jvAI0lkABVzx9gmL7/KZO64VwQfI+r3GqL35v+7kHpK6oIQ8ffQeK0lXPkiKaBy
         qTlailvCjNuV+Xu+1VcqU/0Y4jzpSn9ixej0xa3fdPKEn9fcYyHAfqP2j0eyon4Biybh
         DtHerJsY3/lSAnp1saPCW+yeqQdjaSWa8H9ETKsCrSB0+hLqeu1Le3tvNV+VZn8WOSE/
         x6EA==
X-Gm-Message-State: ACgBeo3HHRV6j/IkN4JeDAXEszgJx/6jUFGFEtLvSuaA3z2MmZQpADTq
        DBqXQlwb0TLS67JkAvgO0g87rhaTcIi4Yg==
X-Google-Smtp-Source: AA6agR5WQSRy3QZ3a5qpBgOwTSFImlWhuv1MyJbjJ785Jq2ALsUtA/lkhiGhSpSdprO/IOsqR7UgNA==
X-Received: by 2002:a17:902:e552:b0:16c:571d:fc08 with SMTP id n18-20020a170902e55200b0016c571dfc08mr1577589plf.151.1661476271952;
        Thu, 25 Aug 2022 18:11:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4eb0:cafb:7713:1e6])
        by smtp.gmail.com with ESMTPSA id y18-20020aa793d2000000b0053602e1d6fcsm273846pff.105.2022.08.25.18.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 18:11:11 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:11:09 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Ignore -EIO for uevent
Message-ID: <YwgdraBXTWk1DhCE@google.com>
References: <20220824165459.1.I059ae712dd6d324897162ee9f37c22849aa22745@changeid>
 <20220825140243.tgotqpymswduzlyy@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825140243.tgotqpymswduzlyy@mercury.elektranox.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thanks for the response.

On Thu, Aug 25, 2022 at 04:02:43PM +0200, Sebastian Reichel wrote:
> > For uevents, we enumerate all properties. Some battery implementations
> > don't implement all standard properties, and may return -EIO for
> > properties that aren't recognized. This means we never report uevents
> > for such batteries.
> > 
> > It's better to ignore these errors and skip the property, as we do with
> > ENODATA and ENODEV.
> > 
> > Example battery implementation: Acer Chromebook Tab 10 (a.k.a. Google
> > Gru-Scarlet) has a virtual "SBS" battery implementation in its Embedded
> > Controller on top of an otherwise non-SBS battery.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> 
> -EIO means input/output error. If a driver is reporting that for an
> unimplemented feature it's a bug that should be fixed in the driver.
> Handling it here means userspace ABI changes for temporary issues.

I suppose I can agree with your last sentence.

But the first part is much easier said than done. This is sbs-battery.c,
on top of i2c-cros-ec-tunnel.c, talking to an EC (whose firmware is
pretty much unchangeable at this point), which implements a subset of
commands.

The intention is that i2c-cros-ec-tunnel.c will see something like a NAK
/ "invalid argument" response, and it converts that to ENXIO.
Unforunately, for reasons I have yet to figure out, it's very common for
retries (|i2c_retry_count|) to eventually yield an unexpected response
size, which i2c_smbus_xfer_emulated() treats as EIO; so this layer is
seeing EIO.

Anyway, I might be able to coax the i2c/sbs-battery driver to return
ENXIO instead. Would you consider that to be a better case to handle
here? "No such device or address" seems like an appropriate description
of a permanent error, and not a temporary IO error.

Brian
