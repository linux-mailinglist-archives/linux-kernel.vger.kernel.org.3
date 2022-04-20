Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A812E508F54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381468AbiDTS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiDTS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:26:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8821369F7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:24:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2846968pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kP8nJgkSpMAbg20Steuna9FNkcQhEvLD3IQk/BXxm58=;
        b=Ea8uZMdTLZJ3OHXpL77k9Jdka2y2mxAmiJvJ3AjLgId0Pgvyxgx5ypE3Xn0Bz16H02
         0+R5KXIJCcjhedCeNRDtb4idSkPS6acUAkBeNSx940wt6b1bWnn2IY+A6V5ldF89KAQt
         8uuoSx4tXipIHte9nc2IoBLu1Wl4m/pOraY5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kP8nJgkSpMAbg20Steuna9FNkcQhEvLD3IQk/BXxm58=;
        b=SYKLCP8fdnHopiiZhzbxU1N7msZoHcDD+UGOitVL0Mm/5yqI3PZhxITucSamN0i7qD
         dInqoBZtOBHiIUa7tEptW6Q8cj8ISTnpj0cy77NfgPD4nV6V0APZhLNyMcCPP+bsnklz
         oEun24maVFL1WLPI0qlaGCVi2sCKTARdbi5NHzeHr9HVlVAVPi4492YpFr7wHvkOfHcC
         mS5/w0ARYp4LlmssMn6qLUo89YK+jGz+uIzH9NzugsA/4QFv5Xdxk0N/1aEgUWITWBVP
         KjyrpjnMomSbcZVUjfKoFBhfDHuJ4225GgbkBm/aRMN20hClVieLuErpMjoJ8nbNFWQI
         9/HA==
X-Gm-Message-State: AOAM530WGMY7S6IOb3LnrWKle9w01MLlgGCtnJ40GNxMLBQUAEryTYch
        VS4o4AuFU2R7RHePbNAyduBCm65W5LYOxw==
X-Google-Smtp-Source: ABdhPJx+v951QewV7QgWyDw5EEGG95BAFVrv7JSxXHdSk+RY/iyGFBRWJQ57pgkMtBYuOexhNjbhiw==
X-Received: by 2002:a17:902:6bc2:b0:158:a26b:5884 with SMTP id m2-20020a1709026bc200b00158a26b5884mr21972995plt.38.1650479051221;
        Wed, 20 Apr 2022 11:24:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4c66:87b7:a600:871d])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a001a5400b0050abaf55b5fsm4040299pfv.191.2022.04.20.11.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:24:10 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:24:08 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: core: Replace _regulator_enable_delay()
 with fsleep()
Message-ID: <YmBPyJfN7we4k78/@google.com>
References: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
 <20220418141158.2.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
 <YmA0vq3qkAEYGk03@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmA0vq3qkAEYGk03@sirena.org.uk>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Apr 20, 2022 at 05:28:46PM +0100, Mark Brown wrote:
> Did the issue with the delay functions preferring delays on the higher
> end of the allowed range get fixed?  That might be an issue for larger
> usleep() values.

Hmm, good question. I had a faint memory of this problem, and searching
around, I couldn't find that anybody *thought* they fixed it, and I
found evidence to the contrary (some reports complaining about, e.g.,
boot-time performance issues in drivers/usb due to the same, with no
indication that anybody truly fixed the problem).

And measurement on my systems (with expected usecs between 322 and 390)
show that we overshoot by the following stats (on >3000 samples, with
moderate load):

 minimum overshoot: ~3%
 maximum overshoot: ~150%
 median overshoot: ~104%
 mean overshoot: ~98%
 stddev: 0.207

I guess this is one aspect that Documentation/timers/timers-howto.rst is
referring to, when it says: "Exact tolerances here are very situation
specific, thus it is left to the caller to determine a reasonable
range." It feels like fsleep()'s "x2" is pretty arbitrary and often not
what people want, but maybe it's good enough for non-sensitive cases.

So maybe it's better to retain the regulator core helper
(_regulator_enable_delay()) and rename/repurpose it for my patch 1?

I feel like there's some room for improvement in either fsleep() or
usleep_range() or both, but I'm not sure exactly how to go about that
right now.

Brian
