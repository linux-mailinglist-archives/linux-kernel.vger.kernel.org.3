Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937144D610B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347449AbiCKLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiCKLzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:55:06 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7667D4339D;
        Fri, 11 Mar 2022 03:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=QKQNUb8gG1815bo0+LJAzephXsrFMrZXGrmPtBwOo6c=;
        t=1646999643; x=1648209243; b=alHnBgDIHy9y0RUCRwwm0He8FSk4xcPUW9/EkiSAih21DFM
        8yjhuigiX6tbzgl3M08NcjD5KiTxv9w+CXmUJX/aSYqJ1AyInOYuNm4901RQFfmqFnR6CYZlwuEc3
        Hj4/kj489RxcTwk35q/BGf44Di9sAq1qrrCZFCQeK90/PGycpLm0Ntu8xqZMeNuznVFTvihU6g9Xc
        W3aRh+VZ+JOzxzwDMvOdb5ItDjw3PNVKrMwz596BzdCUE6CR2P2wZmHzQ7pNByEtQb1dOfGczHFbY
        GK9v93vvNdHsHZ6ecXRO1xFbNvE1vE7ATVeZ47RQc+3yw57RdaLI55lmMyaftxkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nSdqI-00BtPi-Dc;
        Fri, 11 Mar 2022 12:53:58 +0100
Message-ID: <564672530e489da8872bdf1d8cdee7ce071d6a19.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rob Clark <robdclark@gmail.com>,
        David Laight <David.Laight@aculab.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "khsieh@codeaurora.org" <khsieh@codeaurora.org>,
        "nganji@codeaurora.org" <nganji@codeaurora.org>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "aravindh@codeaurora.org" <aravindh@codeaurora.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
Date:   Fri, 11 Mar 2022 12:53:57 +0100
In-Reply-To: <CAF6AEGtNGJanJ9f2pkjst50yPSWGJPo5nDkcZZgq=BkRWMq4yg@mail.gmail.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
         <YgZD8vPqB7ISpRpZ@kroah.com>
         <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
         <Ygdb63FrorUsX/Hg@kroah.com>
         <b9156bde-137c-2fac-19e0-b205ab4d6016@quicinc.com>
         <7db7d01fcf5a3edce61161769c0e6eb1541237bf.camel@sipsolutions.net>
         <2add9ba7-7bc8-bd1d-1963-61e8154b0e3c@quicinc.com>
         <989efb15-cc5e-8f6d-c313-118f01498e33@quicinc.com>
         <8fa2f879e33e4e42b76e21c6fbdcb023@AcuMS.aculab.com>
         <CAF6AEGtNGJanJ9f2pkjst50yPSWGJPo5nDkcZZgq=BkRWMq4yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-01 at 09:45 -0800, Rob Clark wrote:
> On Mon, Feb 28, 2022 at 10:49 PM David Laight <David.Laight@aculab.com> wrote:
> > 
> > From: Abhinav Kumar
> > > Sent: 28 February 2022 21:38
> > ...
> > > We also did some profiling around how much increasing the block size
> > > helps and here is the data:
> > > 
> > > Block size    cost
> > > 
> > > 4KB           229s
> > > 8KB            86s
> > 
> > You must have an O(n^2) operation in there - find it.
> 
> The problem is how the devcoredump/sysfs interface works, which
> results in "re-rendering" the output for each block.. it's fine for
> moderate size sysfs files, but scales quite badly once you get into
> couple MB size sysfs files.
> 
> It could be fixed by having some way to keep state across successive
> read callbacks.

I'm not sure that's true? Perhaps for dev_coredumpm(), but only if you
implemented read() badly.

If you have e.g. dev_coredumpsg() or dev_coredumpv() that's just a
simple read from the existing buffer.

johannes
