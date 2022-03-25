Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3AA4E7D23
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiCYWiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiCYWiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:38:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73238527F3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:36:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w21so7526381pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66gIpeXcj5574AY6+wxqIKtN1GXT+H4zW/55ds9MTRA=;
        b=Pehj9tXJ4jzHdSs9n3UJ6sf8byvgBPWfgS568/84c46HBvPWXXsvdd8pAEE2HzzzdY
         nhBsal9nGQ7ZgSXnQd9IetpG0IdzOgDsbdffL/rqAdzghtq62mKAtGJ4aJMAiJzpd60K
         sk4O1Q2hg3+cF5cPtgpMcYhNZQgEAlSy77zvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66gIpeXcj5574AY6+wxqIKtN1GXT+H4zW/55ds9MTRA=;
        b=C3b2O1lAAD6EaKG7Dbwz/mrERsgKp/yPu5ced7ndFUryJnvT08x6M0Bf+t/TW8yhu/
         xnU6mEL4VBHZFM1BUHOMNM3CaXOlZYbNgBk4Y0a4hewCOOum3HLNzSSCgiqwjiCxGmHO
         8Jlc9SHWRmsYLAORBTZ80Bame9zAgLlCeHbTSxeEr7lfd9NWAOdsh+nQb8vtCCe+FCRR
         vWw6m4KSNbedovCvYqPkuu0j/5DJRC83/iaqvE8rKsXNtsuZ0RIV81CYCnFjv5ouowNw
         WIhKca+TIYI8EK/9UJ+YeqIkyRF4H3VYa0lTNUn3D6LX5u6CZnw6fAWxgmbxAGdLwT1u
         v3IQ==
X-Gm-Message-State: AOAM530jHDs+7WZTsTlexfauRTRCCkoIBxp2At0R2Udg93dDFOQrMk0W
        ZeijOEUHHY9JRVlbRQkRoexqVQ==
X-Google-Smtp-Source: ABdhPJwG2BRVqQ2ziox0dNsT7VEIXbPPkmt2DvxPblXiXuRWJAFlpkxVnnE+ApT4WaXP9qsdh951NA==
X-Received: by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP id c18-20020a056a000ad200b004f12734a3d9mr12393340pfl.61.1648247785019;
        Fri, 25 Mar 2022 15:36:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id be11-20020a056a001f0b00b004fb29215dd9sm398786pfb.30.2022.03.25.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 15:36:24 -0700 (PDT)
Date:   Fri, 25 Mar 2022 15:36:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/harness: Run TEARDOWN for ASSERT failures
Message-ID: <202203251535.4B900BC0@keescook>
References: <20220324231907.1363887-1-keescook@chromium.org>
 <20220324231907.1363887-2-keescook@chromium.org>
 <f705c381-cbe6-0862-e10f-44f2afdef24d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f705c381-cbe6-0862-e10f-44f2afdef24d@linuxfoundation.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:37:20PM -0600, Shuah Khan wrote:
> On 3/24/22 5:19 PM, Kees Cook wrote:
> > The kselftest test harness has traditionally not run the registered
> > TEARDOWN handler when a test encountered an ASSERT. This creates
> > unexpected situations and tests need to be very careful about using
> > ASSERT, which seems a needless hurdle for test writers.
> > 
> > Because of the harness's design for optional failure handlers, the
> > original implementation of ASSERT used an abort() to immediately
> > stop execution, but that meant the context for running teardown was
> > lost. Instead, use setjmp/longjmp so that teardown can be done.
> > 
> 
> Thanks for the patch. The change look good to me.
> 
> > Failed SETUP routines continue to not be followed by TEARDOWN, though.
> 
> Does this mean failed setup() routines have to handle TEARDOWN? What
> are guidelines to follow for setup() failures?
> 
> Can you add a bit more detail on what you meant by " Failed SETUP
> routines continue to not be followed by TEARDOWN, though".

Sure! It means that any failures in a SETUP need to be cleaned up by the
SETUP, as TEARDOWN won't be run. (As in, this is unchanged from how
things behaved prior to this patch.)

> 
> With that:
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks!

-- 
Kees Cook
