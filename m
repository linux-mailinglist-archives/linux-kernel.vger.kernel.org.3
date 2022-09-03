Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52F5ABD7C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiICGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiICGmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:42:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA670B07E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 764A1B82E81
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F097C433C1;
        Sat,  3 Sep 2022 06:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662187337;
        bh=rKNMGllfZe2l+RKwVXIACnwY+MJaVa2QnM3LCCg3Ti0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHCAvDcTdxtT8P/IqYrNgv2IQOTF6F2IwmNanQsAQIvqUcns+CopD7TtCYuemx3ro
         RQuVYV9mFqg0HlPhGMSyq+HexU9GjKTl1+y4tHMiHpsL3X5KkZVBurFIEsD1sNg0c+
         v3spVnURYqsoxWh9dZX0EG/KvGIQpFxftzI28piA=
Date:   Sat, 3 Sep 2022 08:42:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver core fixes for 6.0-rc4
Message-ID: <YxL3W3Sb0AMMt01T@kroah.com>
References: <YxIht+ev+gXsF6ZD@kroah.com>
 <CAHk-=whnNO4T9PHNC1DT35sROGNK_geKL0Q_EjZH=0sLoACPHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnNO4T9PHNC1DT35sROGNK_geKL0Q_EjZH=0sLoACPHw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:02:00AM -0700, Linus Torvalds wrote:
> On Fri, Sep 2, 2022 at 8:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc4
> 
> Entirely unrelated to this pull request, but since the diffstat made
> that "drivers/base/dd.c" file stand out, I tried to look at what the
> history of that odd name is.
> 
> And it's not obvious to me.
> 
> Very strange filename. Should it perhaps be named "device.c" or
> "probe.c" or something more descriptive?
> 
> Not a huge deal, more of a passing thought inspired by that diffstat.

I think Pat named it and I always think of it as "device vs. driver".c
as it handles all of the device and driver interactions between binding
and unbinding and other fun logic there.  I'm all for a new name if
anyone has any ideas, "probe.c" is sane, but it also handles disconnect
logic.  "core.c" already has lots of device functions, so renaming it to
"device.c" would be confusing.  I don't know...

Yeah, in digging, Pat did this in commit 07e4a3e27fe4 ("[PATCH] Move
device/driver code to drivers/base/dd.c") way back in 2005 to get code
out of drivers/base/bus.c.

Naming is hard :)

greg k-h
