Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F314595A72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiHPLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiHPLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:42:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA2F32E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:13:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r69so8939730pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=V5IkeuSVi9fKfp3zra01ncb3hrHpLVL3k3XVBC9wdIU=;
        b=klS9soVKVxOs0Xqft08jBbZnbUmDJ2wGnHyztAXIP9Sbl/u3vHNVMSVLlxj2KCtKsB
         DTjQPJEJJAKzL20lI8KoI7ajyPxwgQk5SeWXMJtTTmX18eFC/fJq+uF+7U4S99HSGfuf
         HsrlcQ4A/Npdnir/K26lp5dYANl2vb2kp5CkiSjDnfZ7FmGyHO6gUugb+ShZZBhUZ7h2
         BXt5SDXJWUvE9rqUs4JN5yHddrtvoqxcKLo3xr8PuZ5lL/F7zcrRjBGPSQV/kdwNftbP
         jpsKPhPqiY5YSjNlQT4srBuDt61wDMQ/C+5JStujMLDxZf1gy0KDDFP/pdOXz7jF9NMS
         OKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=V5IkeuSVi9fKfp3zra01ncb3hrHpLVL3k3XVBC9wdIU=;
        b=Y2RNvQ8Fq+K65ml10uxskVLHVAj9kTslPOGFBZwzveozLv/26lqYVJ3RII4IEsach/
         KJiTEK49XtEcBBRCfyEYafYybFb4mwJDG6cIVVX6FU8eNPgzPAJMiVWBExvuHPg/7Xgw
         CBaTc1HSotvlpBMEVfsLZUy7YE7YUCCUhTyyQvjvNO38NhXCW/pLj+dzF81EMxS5gSk6
         PenKdOITG9hb/mAlmHyVBfkaz/ORElDCVFZvmpPVwGN4s9Ck/uNErxr9qq/shtPl0jWV
         TmqFFwlpfmjIhU7tRoOjHVIoNM2BiBYxafExHKRCkv6ktkddIBCadliKtekMhaCd3zbZ
         BKvQ==
X-Gm-Message-State: ACgBeo2iOYmp6mQmeEwrVib+64rV0lMqQ1CE9+jkiBVW/YWwMxguYNm1
        Xa9ej7mfBUTcymwYs7X/hsI=
X-Google-Smtp-Source: AA6agR5YH/ZznegVN44Uy5995PYYL+udWnPOF5P90bgS+oePK8xqjC8K/9U6cX36GyQyj03+K08Qkg==
X-Received: by 2002:a63:2a95:0:b0:41a:27e5:1996 with SMTP id q143-20020a632a95000000b0041a27e51996mr17241093pgq.447.1660648393943;
        Tue, 16 Aug 2022 04:13:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9-20020a655589000000b0041d90d681e7sm7340496pgs.48.2022.08.16.04.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 04:13:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 Aug 2022 04:13:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <20220816111311.GC1108868@roeck-us.net>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvsoYzIhOtX9DOi2@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:17:23PM -0700, Isaac Manjarres wrote:
> On Mon, Aug 15, 2022 at 09:25:07PM -0700, Guenter Roeck wrote:
> > > v1 -> v2:
> > > - Fixed the logic in __driver_attach() to allow a driver to continue
> > >   attempting to match and bind with devices in case of any error, not
> > >   just probe deferral.
> > > 
> > > Guenter,
> > > 
> > > Can you please give test this patch to make sure it still works for you?
> > > 
> > 
> > Not as well as v1. I still see the clk crash with versatileab, and imx25-pdk
> > emulations now stall during boot when trying to boot from usb.
> > 
> > Guenter
> Thanks for trying the patch out. This patch isn't meant to fix the clk
> crash that you mentioned on another thread. I had made the following patch for
> that: https://lore.kernel.org/lkml/YvqTvuqSll30Rv2k@google.com/. Have
> you been able to give that a shot yet? If not can you please test with the
> patch in this e-mail and that patch?
> 

No, sorry, I missed that one. It does not apply, though - it is whitespace
corrupted. I tried to fix it up, but that failed.

> Please make sure you do not include this patch as it is known to cause
> deadlocks: https://lore.kernel.org/lkml/YvXhJRlHN9OAIA5l@google.com/.
> 
No, I did not include that patch.

> Did you test imx25-pdk emulations with just v1 of this patch previously?
> 

I am quite sure I did because it is a single setup.

Thanks,
Guenter
