Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20224B73A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiBOPme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:42:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiBOPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:41:08 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9813FAEF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:34:44 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso23621885oon.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lICLxHXDz47Zrz6aevlppIMXuruBJmDOc0eDfWsdodY=;
        b=aOv1eEN1wu7TUzfxLlt1pmrdqkCiCXVvy082d8mxVz2pU32xBefNtT/wpBtTs0PUsU
         WwFnGpSIkEloJ/856De8fJh4guiKI0xAxyFNlzg4vVoQVc/WnoFJ/NrTRFzi2ESDqdqS
         IId/m6wv/SOKu9M6zd5nap7i4WyFfVMLuaIL0gyYX6toG5+s7nLWd+i+tirCg8zHzsMg
         SDTg2Cpv+nQTB3Nnka8YtN0Uh4zlr3FkijikOZoQ5KLcIGJr7Z+UqG6JPYyP/wxZaOAP
         3ttr8rjFy8T8qhCw4YXvCBSfZSHlCEBXR4Qtn7kxh0iUgk7GOTH7GMz/rHQvW+sJrFCU
         EvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lICLxHXDz47Zrz6aevlppIMXuruBJmDOc0eDfWsdodY=;
        b=OM7c6ir/Kx2byMCJ8wYvMhk3FKJUx+mQK0PoLcWmYTGyp2JUPm6ebHZnuVEzE3Q/tk
         ysfG4HWOKGfyvLEO3xQ9AmPZ+36rCrLVleJISuKUcTjHSJkP8BHPL6UyqM+ol0EHgafZ
         bomTglzrlDhl2M6Be1kA6gkeB0Ssci3zSyoBhIShQDVKwYzAbjVLPpqpQPG2oNzDasHw
         QLF7dXfyZBxaIUwsAwe7mBFykOFGEuUbUlMYzMjA24G+sH8MYzZmMIgtZmEnTBF6H6k9
         S0cev3YZ93V2+mC8R4cnqycb3T8EJk9UlA9Yag+iwRyXepkk1tGBoRMRkQ3XL5ZlKNzR
         bQBA==
X-Gm-Message-State: AOAM531CYdH3ZUcLGcvJbqvv91uUtrf8M9P6lZ4aC+lsRzbdlbLqJA6F
        rn0QTfZzSpEdJM17dH43Gik2LA==
X-Google-Smtp-Source: ABdhPJzbWwU42jNoOxbpoCebn0T7UnHfSr29OBuXpn3I/sQBF5m3RpPW5CFBWyczhtgGB+fVXx6EUA==
X-Received: by 2002:a05:6870:1059:b0:ce:c0c9:5b2 with SMTP id 25-20020a056870105900b000cec0c905b2mr1573971oaj.4.1644939283973;
        Tue, 15 Feb 2022 07:34:43 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id b8sm5414114oae.30.2022.02.15.07.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:34:43 -0800 (PST)
Date:   Tue, 15 Feb 2022 09:34:41 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 09/15] rpmsg: smd: Drop unnecessary condition for channel
 creation
Message-ID: <YgvIEYOAZTFHN6fb@yoga>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <Yfhjil3pfZLa5g3j@builder.lan>
 <2615776.mvXUDI8C0e@g550jk>
 <3503848.e9J7NaK4W3@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3503848.e9J7NaK4W3@g550jk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Feb 14:51 CST 2022, Luca Weiss wrote:

> Hi Bjorn,
> 
> On Sonntag, 6. Februar 2022 21:17:22 CET Luca Weiss wrote:
> > Hi Bjorn,
> > 
> > On Montag, 31. Jänner 2022 23:32:42 CET Bjorn Andersson wrote:
> > > On Sun 16 Jan 10:30 CST 2022, Stephan Gerhold wrote:
> > > > On Sun, Jan 16, 2022 at 05:08:29PM +0100, Luca Weiss wrote:
> > > > > On Mittwoch, 12. Jänner 2022 22:39:53 CET Stephan Gerhold wrote:
> > > > > > On Wed, Jan 12, 2022 at 08:40:58PM +0100, Luca Weiss wrote:
> > > > > > > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> > > > > > > 
> > > > > > > RPM Firmware on variety of newer SoCs such as MSM8917 (also likely
> > > > > > > MSM8937, MSM8940, MSM8952), MSM8953 and on some MSM8916 devices)
> > > > > > > doesn't
> > > > > > > initiate opening of the SMD channel if it was previously opened by
> > > > > > > bootloader. This doesn't allow probing of smd-rpm driver on such
> > > > > > > devices
> > > > > > > because there is a check that requires RPM this behaviour.
> > > > > > > 
> > > > > > > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > > > > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > > > > 
> > > > > > This is effectively a "Revert "Revert "rpmsg: smd: Create device for
> > > > > > all
> > > > > > channels""":
> > > > > > 
> > > > > > https://lore.kernel.org/linux-arm-msm/20171212235857.10432-3-bjorn.a
> > > > > > nd
> > > > > > ersson @linaro.org/
> > > > > > https://lore.kernel.org/linux-arm-msm/20180315181244.8859-1-bjorn.an
> > > > > > de
> > > > > > rsson
> > > > > > @linaro.org/
> > > > > > 
> > > > > > Won't this cause the same regression reported by Srinivas again?
> > > > > 
> > > > > Do you have any suggestion on another way to solve this? Without this
> > > > > commit the regulators just won't probe at all, I haven't looked very
> > > > > deep into it though given this patch solves it.
> > > > > 
> > > > > I guess worst case it'll become a devicetree property to enable this
> > > > > quirk?
> > > > 
> > > > My spontaneous suggestion would be to skip the check only for the
> > > > "rpm_requests" channel, e.g. something like
> > > > 
> > > > 	if (remote_state != SMD_CHANNEL_OPENING &&
> > > > 	
> > > > 	    remote_state != SMD_CHANNEL_OPENED &&
> > > > 	    strcmp(channel->name, "rpm_requests")
> > > > 		
> > > > 		continue;
> > > > 
> > > > This will avoid changing the behavior for anything but the RPM channel.
> > > > I don't think anything else is affected by the same problem (since the
> > > > bootloader or earlier firmware should not make use of any other
> > > > channel).
> > > > Also, we definitely *always* want to open the channel to the RPM because
> > > > otherwise almost everything breaks.
> > > 
> > > Last time this came up I asked if someone could test if the RPM is stuck
> > > in the state machine trying to close the channel and as such we could
> > > kick it by making sure that we "ack" the closing of the channel and
> > > hence it would come back up again.
> > > 
> > > But I don't remember seeing any outcome of this.
> > 
> > Do you have a link to this or should I go digging in the archives?
> 
> Replying to myself, I went searching but couldn't find anything. If you have 
> some PoC code I'd be happy to try but as I'm not familiar with rpm/smd at all 
> I'd have to read myself into it first.
> 

A quick search didn't turn anything up on my side either.

And while I had suggestions of what could be tried, I don't have any
devices myself that manifest this problem, so I haven't been able to
debug it.

> If Stephans suggestion with the strcmp(channel->name, "rpm_requests") is ok 
> then I'd test this and use that in v2. I'd personally rather not spend too 
> much time on this issue right now as it's blocking msm8953 completely (no 
> regulators = no nothing),
> 

It's been a long time since this problem was initially reported, so I
rather see us land the strcmp() hack to unblock you and others. Then
someone who knows SMD can take a proper look at this.

Regards,
Bjorn

> Regards
> Luca
> 
> > 
> > Regards
> > Luca
> > 
> > > > Many solutions are possible though so at the end it is mostly up to
> > > > Bjorn to decide I think. :)
> > > 
> > > I would prefer to get an answer to above question, but if that doesn't
> > > work (or look like crap) I'm willing to take your suggestion of skipping
> > > the continue for the rpm_requests channel. Obviously with a comment
> > > above describing why we're carrying that special case.
> > > 
> > > Regards,
> > > Bjorn
> 
> 
> 
> 
