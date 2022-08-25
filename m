Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898215A1C30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiHYWV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243915AbiHYWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:21:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92DC3F5D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:21:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x19so33441plc.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=x5NirdzqMfoe8MCTNsWn+TbWWpEBzaHt38NWMgPFt0Y=;
        b=pa3FQ750frcLh+M83FXbUBxqvg8TgPlioYvnZJk/g8/rICG6Sl7zzt9mwszxtYD+CC
         49YGZmDznByJ0h5JmcXMukKMHJ5nCWgQJllJQo9+3bgXVHV0/75e2OT+x20cwrGoQsvh
         dN3ze+LrdKGZvJz4sF99kmmC3S7B3ZfYfu5d1QpieHPsc5NvKID3/2zYsynALu0DO2e0
         DM7JaqSLb08/Jc7CnwkELsFcVYhRZXlvtSvnSWTx+HowzVyKtfgBmaeij4oEFPB1qcQW
         87+FBEhiYbh/V8eUcGtKuoNhV5GwDFzTk4mwINglG5XRAAhwQ5Sy2lY86avE21ePcqms
         BbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=x5NirdzqMfoe8MCTNsWn+TbWWpEBzaHt38NWMgPFt0Y=;
        b=t5whj7J0+T7f37bgGXDpwVRU9ffoHFAAFrvQBbnyJ9LNTBcOB0MnBWfgRy9cMI6EBb
         qI06ugJLvoDQIfsQayeZh5Xk0CUu97DL51UGcV2G/azKK1ExeZTCHGTTTxc3cWQN0lVR
         AbZmNGhR2caNrJQal42pVjGo9tuddOh4j36rElOVDa0hD5f8E7FJBl//VaIYOIiCZ6QK
         VwAd6TwIhuqcB3Jr6o9sCCWG3BHW6aRR/kF9IDPUGRiANGnxbuVlVcmqDW7yfqGJJ5Ch
         Yt8ZMO0vWm5whGVkNJBnBO0oyf1JZNO2Et9XgulpEpCYHL7ulI9+P2XfJN1vv/xLBnK3
         JjfA==
X-Gm-Message-State: ACgBeo1GHwccxcGam+pUKzQDnvDfrkJw+NBeFlncfRHSMPWtJnpNLmha
        gwzMjMZPpyBHBoMaVfzhxtSE5A==
X-Google-Smtp-Source: AA6agR70MEsIOmrS6RoETs/W38aqLW00pQAtTHj81b9n86XcuDQIAKsE0R/0zU8rTZw0iajBXJclDQ==
X-Received: by 2002:a17:90a:640d:b0:1fa:ea96:3d10 with SMTP id g13-20020a17090a640d00b001faea963d10mr1336943pjj.74.1661466115146;
        Thu, 25 Aug 2022 15:21:55 -0700 (PDT)
Received: from ghaven-kernel ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b00172a1f6027asm49289plx.235.2022.08.25.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:21:54 -0700 (PDT)
Date:   Thu, 25 Aug 2022 15:21:52 -0700
From:   Nate Yocom <nate@yocom.org>
To:     Bastien Nocera <hadess@hadess.net>, dmitry.torokhov@gmail.com
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Input: joystick: xpad: Add X-Box Adaptive
 Controller Layer button
Message-ID: <Ywf2ACXJZ5zm0QV+@ghaven-kernel>
References: <20220813185343.2306-1-nate@yocom.org>
 <20220813185343.2306-3-nate@yocom.org>
 <b32cee349fdfa6ffdc60cd31f662dbd479b01e4d.camel@hadess.net>
 <ba73ce3733ff76b081fb0916e4b9be82179a42dc.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba73ce3733ff76b081fb0916e4b9be82179a42dc.camel@hadess.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:36:30PM +0200, Bastien Nocera wrote:
> On Wed, 2022-08-17 at 12:37 +0200, Bastien Nocera wrote:
> > On Sat, 2022-08-13 at 11:53 -0700, Nate Yocom wrote:
> > > Adds a new quirk for controllers that have a Layer button which has
> > > 4
> > > states, reflected as an ABS_MISC axis with 4 values.
> > 
> > It's called the "Profile Button" in the official documentation:
> > https://support.xbox.com/en-US/help/account-profile/accessibility/get-to-know-adaptive-controller
> > so best to call it that.
> > 
> > I wonder we have any other examples of profile handling in input
> > drivers. The xpadneo driver implements the profiles in the kernel
> > driver directly.
> > 
> > Benjamin?
> 
> After speaking to Benjamin, it was clear that ABS_MISC wasn't the right
> absolute axis to use.
> 
> I think that adding a new ABS_* axes in include/uapi/linux/input-event-
> codes.h would be the best, for example ABS_PROFILE as 0x21.

Makes sense to me. 

> Dmitry, what do you think?

I'll submit a v5 with ABS_PROFILE defined jic.

> 
> The idea here is to encode a hardware controlled switch that has 4
> possible values. Its state will be sent with every input event in order
> for user-space to (maybe) apply a specific profile to the events.
> 
> This would also be used by the XBox Elite 2 controller driver.
> 
> Cheers
