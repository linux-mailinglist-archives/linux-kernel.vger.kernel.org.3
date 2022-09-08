Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242B35B23A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIHQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIHQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:31:57 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9621FF0BF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:31:56 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id a22so13294513qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PX5B4DOO9VKB3vdPnCDviaalsOiW5Pvp7jCaKLShA6c=;
        b=B3kNrFXImjpIjuJ1vZUTept4hwW49IbjsXStSr+Dw9nKZLMY23M9pwfSPuggK3a6DK
         DXZAGTzq+fRFD1hP5By4YCSztmkPjiLLkRMB3MuZViP3T3kipC5znVlAH0XmhZFqhWyX
         7jB/2ghfjcCd38HsMkziKaoyexztjHRokidbZkmxF5aIh2tdcSUpWaOsOgEAkOKgddI/
         wq5TTNz3R9AbC/KYsy5IQMnVYlLHOUOSLym41MZKatpL9ftSca17PzPhONiFrN4fNu8F
         Jx1KszdzGR2cCUybi2NJ1MXyPV6XDE2YcCUjfRjupk8ZFuDbe+wnyoq17ctD2cnxIp8v
         LCpw==
X-Gm-Message-State: ACgBeo1YQWBT29abI7HmZl07Y36Ag/ir5LWwx67iKaxxwTLDYVcv912Y
        MdauaiUJ2wb5Rk7GxDgfehja
X-Google-Smtp-Source: AA6agR7c+N33V5guNwxmRNMXuWyaQo5G9ZX7Cz4TZ5I9iGmtqsztgxOGSE4f05D5DrKrMDgf0tX/ng==
X-Received: by 2002:a05:622a:178e:b0:344:56a8:25da with SMTP id s14-20020a05622a178e00b0034456a825damr8513942qtk.375.1662654715883;
        Thu, 08 Sep 2022 09:31:55 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id l5-20020ac81485000000b0031f41ea94easm14551916qtj.28.2022.09.08.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:31:55 -0700 (PDT)
Date:   Thu, 8 Sep 2022 12:31:54 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        dianders@chromium.org, linux-security-module@vger.kernel.org,
        mka@chromium.org, sarthakkukreti@chromium.org, agk@redhat.com
Subject: Re: dm: verity-loadpin: Only trust verity targets with enforcement
Message-ID: <YxoY+hDrmNwvmbiM@redhat.com>
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
 <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
 <YxoJcG5MN4OdaulL@redhat.com>
 <202209080912.00880AD6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209080912.00880AD6@keescook>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08 2022 at 12:13P -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Thu, Sep 08, 2022 at 11:25:36AM -0400, Mike Snitzer wrote:
> > On Wed, Sep 07 2022 at  6:34P -0400,
> > Kees Cook <keescook@chromium.org> wrote:
> > 
> > > On Wed, 7 Sep 2022 13:30:58 -0700, Matthias Kaehlcke wrote:
> > > > Verity targets can be configured to ignore corrupted data blocks.
> > > > LoadPin must only trust verity targets that are configured to
> > > > perform some kind of enforcement when data corruption is detected,
> > > > like returning an error, restarting the system or triggering a
> > > > panic.
> > > > 
> > > > 
> > > > [...]
> > > 
> > > Applied to for-next/hardening, thanks!
> > > 
> > > [1/1] dm: verity-loadpin: Only trust verity targets with enforcement
> > >       https://git.kernel.org/kees/c/2e1875c05267
> > 
> > Does this mean you're intending to send this upstream?  I prefer to
> > take all DM changes unless there is an external dependency.
> 
> Oh! Yeah, I added it to my tree since you'd asked me to take the
> original verity-loadpin series and this was a fix. I'm happy either
> way. Shall I drop this change from my tree?

Let's leave it in your tree if you'll be sending this as a fix for
6.0-rc?

But moving forward, I'll take new development that is localized to DM.
Sound good?

Thanks,
Mike
