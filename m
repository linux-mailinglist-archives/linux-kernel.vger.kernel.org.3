Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11EB510B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355406AbiDZV3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355398AbiDZV3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:29:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE01222AE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:25:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v10so5989899pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JiDUP8VDfeMLzW/LS/tubkRyhOzgLYwDgnscZkxJ1B8=;
        b=UYIKydDCPOUryvg9f6Z1DIVDLSH+cg878qeZmL8sMVJSpLWCyvpGFyc4W+81+8IDnG
         LySPTwAGkI+hK8wM/AN0lVsFgNoR+aJ53ralci4xAqDbjz/rvMGfiGlzyZNm3h+Ja5R/
         cuUjkYAyhhryJjLSTiLMyrqRVZemVXLNZZRCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JiDUP8VDfeMLzW/LS/tubkRyhOzgLYwDgnscZkxJ1B8=;
        b=y9nqliggB8oavFSxUVEpfi3SeL5Ek4v1q23bEdpmOVsDmveBlNSNKRL1mSJ+LJqS3w
         Ma5q5d1EfIdn0CedbwtxN7tgiAsvOa+P9NzSmkOXIkP7f3oZTG125g9DCq5teanY0a6S
         rCVbkBHOofjVE1r+Ebzu0RCvDdeuH1FL4buoOeFKLKIBnxVlVzvGb7NYqs5CbD4ae/zN
         DDj7jH0+qXp1ILFq+0EnxgT3vBGy9rN0jG/FsvXDiruu3yK8wDLDHwAbIVVuptCFr5Qf
         L9CH5zdoUOq7WX4sYkReHioIl9ftaRgMATL0iD7+7CMFaBh9YIm3KTQrBC2PtcvFvwap
         7LZQ==
X-Gm-Message-State: AOAM532ddv4YNHaaERygJECBbV8XkbF8csRXDhLz9hv30V6ALpj9k3Yi
        rDljGnup2u6Rv/9LRzB+XRVtdQ==
X-Google-Smtp-Source: ABdhPJw8I8vZswWWOOcvS1rCjG/H7+sDcI353bxRz33tor9qtmLlVF8QV6wFAwYHVWoefMBzT3Yhig==
X-Received: by 2002:a63:2c9:0:b0:3ab:2c8:9425 with SMTP id 192-20020a6302c9000000b003ab02c89425mr14641378pgc.56.1651008358575;
        Tue, 26 Apr 2022 14:25:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090acb8d00b001d953eb2412sm1626822pju.19.2022.04.26.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:25:57 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:25:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 ] devcoredump : Serialize devcd_del work
Message-ID: <202204261421.A58121A53E@keescook>
References: <87levt14kn.ffs@tglx>
 <8186de033c87f0cdec296ae272a72c5b9a2880a3.camel@sipsolutions.net>
 <878rrt0xa2.ffs@tglx>
 <13df1664-fc52-4772-afa1-4f75019b7830@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13df1664-fc52-4772-afa1-4f75019b7830@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:34:07PM +0530, Mukesh Ojha wrote:
> 
> 
> On 4/26/2022 1:07 AM, Thomas Gleixner wrote:
> > Cc+: Kees
> > 
> > On Mon, Apr 25 2022 at 19:19, Johannes Berg wrote:
> > > On Mon, 2022-04-25 at 19:00 +0200, Thomas Gleixner wrote:
> > > > 
> > > > Johannes, can you please explain whether this immediate flush in
> > > > disabled_store() is really required and if so, why?
> > > > 
> > > I don't really know, as I remember that requirement (or maybe even code,
> > > not sure) came from Kees, who needed the lockdown.
> > > 
> > > Given the use case (ChromeOS?) I'm not sure I see a need to flush all of
> > > them, since I guess a typical system would set the lockdown early in
> > > boot and hopefully not have a crash-dump around already.
> > > 
> > > That said, I don't think the diagram you made works - fn() during the
> > > iteration is guaranteed to be invoked with a reference of its own, so
> > > the put_device() there can't be the last reference, only as fn() returns
> > > you'd put the last reference *there*, freeing it.
> > 
> > Bah, you are right, it's magically protected by the klist ref, which
> > prevents devcd from going away. Damned obvious.
> > 
> > This really needs comments why this all can magically "work".
> > 
> > Thanks,
> > 
> >          tglx
> > 
> 
> Thanks you all for your time in reviewing this.
> I tried to address few comments in v3 here.
> 
> https://lore.kernel.org/lkml/1650981343-11739-1-git-send-email-quic_mojha@quicinc.com/
> 
> While, we would like to hear from Kees about reason of immediate flush from
> disabled_store().

This is lost to ancient history in my brain right now. Do you have any
references to past threads on this? The only thing I remember about
device memory dumping was just to make sure that lockdown's
CONFIDENTIALITY mode would block it.

-- 
Kees Cook
