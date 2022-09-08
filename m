Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC285B2346
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiIHQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiIHQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:14:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF416E9012
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:13:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q3so18262970pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ynlv/HlbjINH5vzgYf4TA8R4RfVi30O2jA5crDrStO0=;
        b=oYHv1zVyXadmL712N/OTN2ss+kfxkYYSZBY8SbeRcDbK5VRzMS9d5oRJiUpeOHaNnS
         y6U8mteu3RX3xSdL5vGrsFWmQ0rr4DrfFKLnopVfEAmi84XeZniDURw9fK6qKvxsWiTq
         0ZT0zNSgYguC3eYyLhWhzdiJaFpeL/WVVWjRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ynlv/HlbjINH5vzgYf4TA8R4RfVi30O2jA5crDrStO0=;
        b=tGqZrOPZuUsyN4n+MB56XuS4MpMiPgMzO2ZIAF1OQ4U6+CWJS/d8xqS9fySN7qKllQ
         R2ZVuJdKavJU2BXRS74hksKUZwM6E+rWcNKt/TInE5lOURAb8qsKQN5XBkr3FpnafWW3
         t/jQ4JBlkKLy+Vc0sQuayXaNR2xeewsa2dlvQ5/R7QvzUT7FWT9Ka/dqpBQ5uRUyRx8y
         B3Bnb1ietT9Uk6mHfE7IKZ5UvbFjICMmiGX05IFfBdqUvLHXXX31qhojwY0hvRO2dUT5
         7PYFY8kCVoXIxuslk0JWmR/9e9A4ktc/ndWrRZf/ntqYPSb01O3CIAp4+TMUfswO/yaY
         rwNQ==
X-Gm-Message-State: ACgBeo2pk+PBkRqMTOptCnFeetsCYA8wQ+9JvFVmHDFMrRBnPQp/v/Fs
        EdDBkoyw0J7KW37g3AmdJq9c7Q==
X-Google-Smtp-Source: AA6agR4b8HBqas+oT3K9pH3ycWp3TxRR1yMAxYD+7X/J4yLb8tb1538WM7cusSa+UKAv+3mrExLCmQ==
X-Received: by 2002:a17:90b:1bc8:b0:200:43c7:5940 with SMTP id oa8-20020a17090b1bc800b0020043c75940mr5071911pjb.46.1662653613370;
        Thu, 08 Sep 2022 09:13:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709027e0e00b0016be596c8afsm14773738plm.282.2022.09.08.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:13:32 -0700 (PDT)
Date:   Thu, 8 Sep 2022 09:13:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     agk@redhat.com, mka@chromium.org, dm-devel@redhat.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sarthakkukreti@chromium.org
Subject: Re: dm: verity-loadpin: Only trust verity targets with enforcement
Message-ID: <202209080912.00880AD6@keescook>
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
 <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
 <YxoJcG5MN4OdaulL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxoJcG5MN4OdaulL@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 11:25:36AM -0400, Mike Snitzer wrote:
> On Wed, Sep 07 2022 at  6:34P -0400,
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Wed, 7 Sep 2022 13:30:58 -0700, Matthias Kaehlcke wrote:
> > > Verity targets can be configured to ignore corrupted data blocks.
> > > LoadPin must only trust verity targets that are configured to
> > > perform some kind of enforcement when data corruption is detected,
> > > like returning an error, restarting the system or triggering a
> > > panic.
> > > 
> > > 
> > > [...]
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] dm: verity-loadpin: Only trust verity targets with enforcement
> >       https://git.kernel.org/kees/c/2e1875c05267
> 
> Does this mean you're intending to send this upstream?  I prefer to
> take all DM changes unless there is an external dependency.

Oh! Yeah, I added it to my tree since you'd asked me to take the
original verity-loadpin series and this was a fix. I'm happy either
way. Shall I drop this change from my tree?

-- 
Kees Cook
