Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D0568884
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiGFMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGFMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:41:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F5252AA;
        Wed,  6 Jul 2022 05:41:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 145so13907562pga.12;
        Wed, 06 Jul 2022 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XSmJd1bpU0glTVAxiyaH+IAuqRCtmm6vBt6ZWeEWSjI=;
        b=QRp7RubZClq6VYpat3y7q7HgKvGpPDnUrXiBo2fA8t1m9ENWJlkgWy6suTgQ073Qm5
         vZOSKTR+bf5nqBaQW3a0NAT00pXGvyykNnKassuTkserwnZbMs3ObFyQS/DkwSWpAZJH
         +0zw+b2uu38SFluU6AF274EECmeD/mw0Z3i85z7wzsoGBQKFMfT//07c2ZYATEoJ1XLA
         4pBHjaHT8HCtVri77+gDja7aQzhkxxnS3i5bOqVRQASpBDLtbEEJxbod77G6jzH5fn4K
         MhhPi3DG33KpOM1Mi8iG2d4mSW62cokXWNi0WQl3bsn5CWFrRmMXyMu2QQr4JJa26uEB
         8cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XSmJd1bpU0glTVAxiyaH+IAuqRCtmm6vBt6ZWeEWSjI=;
        b=iz8vZrTPDQPaLRhBs/FEiRHQ+FWrZlwgOU6FuRHk9Ml2DcS3CObixZD9eFWp3D614n
         WeGPpTfxKn442B6FwAOCYTAq+bjX7ppPJsH95Bv4QOfJNqzMZqu4nRPTvJk1pSilEfPS
         yOS+qXxsSjTZjy8GbmAYFkrZLRjX75P7ZbDyfdsNbYl8ELr7r0h5v90Lq2cDwYgVYNaT
         auVd6a/tintCKQs2B/HaR56CIEpu/ZkCR6w823dv1Cjvrd9eglhV/eVOwez4KAheLoC/
         9Yd+EhYFOWXfE83X4M34/Nb0NclHCACI2ykTyMooR5a4WiOxtJd0YjmE9UQKfr09nodf
         YkeA==
X-Gm-Message-State: AJIora+qNsK64ZmQfvVRP89rcZ9En1qP479PI7gPydTcYieC+e9WtVTd
        xSl9fFAx6m8ZsiPrgbgoFo4=
X-Google-Smtp-Source: AGRyM1uq149T+UXOfXySCa+9sRr+0vARPC9zynC8iC6s8O2zbU7cQlw3n/jsJ2VkbAOuz/BbF5u+2A==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr8800555pgj.539.1657111301178;
        Wed, 06 Jul 2022 05:41:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090322d200b0016bdc98730bsm7829564plg.151.2022.07.06.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:41:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Jul 2022 05:41:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Philippe Boos <pboos@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: meson: keep running if already active
Message-ID: <20220706124139.GB492220@roeck-us.net>
References: <20220705142444.17063-1-pboos@baylibre.com>
 <f756b2d5-56e7-6e52-2739-eca4bb33508b@baylibre.com>
 <1jmtdnwd7y.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jmtdnwd7y.fsf@starbuckisacylon.baylibre.com>
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

On Tue, Jul 05, 2022 at 09:29:35PM +0200, Jerome Brunet wrote:
> 
> On Tue 05 Jul 2022 at 16:39, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
> > Hi,
> >
> > On 05/07/2022 16:24, Philippe Boos wrote:
> >> If the watchdog is already running (e.g.: started by bootloader) then
> >> the kernel driver should keep the watchdog active but the amlogic driver
> >> turns it off.
> >> Let the driver fix the clock rate then restart the watchdog if it was
> >> previously active.
> >> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> >
> > Please drop this review tag since it was done off-list
> 
> Indeed a review was done off-list.
> 
> Reviewed-by says a review has been done. I was not aware this applied to
> public reviews only. I probably missed that, would you mind pointing me
> to that rule please ?
> 

Public or not doesn't really matter. However, you can only apply a
Reviewed-by: tag (or any tag, really) if you explicitly received one.
The exchange seems to suggest that you did not receive that tag.
Please never add any tags on your own.

On the other side, if the reviewer did send a Reviewed-by: tag off list,
I would kindly ask the reviewer to not do that in the future to avoid
misunderstandings. If you don't want your Reviewed-by: tag attached to
a patch, don't send one. Not everyone will even realize that you sent
your tag off-list, and no one can be expected to know that you didn't
really mean it when you sent your tag.

Thanks,
Guenter
