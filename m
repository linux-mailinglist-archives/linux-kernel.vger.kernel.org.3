Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D64B33C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiBLIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:25:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiBLIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:25:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F327A26AF7;
        Sat, 12 Feb 2022 00:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XH4dFPiX5OoR9zNtWoY972SsBoh28piIfTnd7x3AM1k=;
        t=1644654301; x=1645863901; b=HYni9O7Hy3Lw5qzwfs73wAMPDmivexdxVh6sGzB+zK7Xa3+
        RMMU0RNoLuxOedO3+7LddFgz7UdDUiUT2vSHvOg5UJAOZr5e04AU6YaG8EjNTx/7A7iHE+UJj8Z+R
        tPypTHS7XzHdLLxUAjU3qJLKoPtlTKUq1D+/kaY6zV4JBHVB7IBlVanLsbo0rUYII9uFzDkvoHbHJ
        lRyEtzjNJy/Qytabx2/LOptoBjHXf0G8Ez83LHeAcas+CIgC3FdfW6EfSR/iPyGGcnvOFa1ImpaiG
        F36E/GMPxmMRAUPJgvz/C9emBQ64eLmGDEQC0/v92yOvkuJsYVmQnw4I9DLPikOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIni7-000C5h-6u;
        Sat, 12 Feb 2022 09:24:51 +0100
Message-ID: <7db7d01fcf5a3edce61161769c0e6eb1541237bf.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        seanpaul@chromium.org, swboyd@chromium.org, nganji@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org
Date:   Sat, 12 Feb 2022 09:24:50 +0100
In-Reply-To: <b9156bde-137c-2fac-19e0-b205ab4d6016@quicinc.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
         <YgZD8vPqB7ISpRpZ@kroah.com>
         <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
         <Ygdb63FrorUsX/Hg@kroah.com>
         <b9156bde-137c-2fac-19e0-b205ab4d6016@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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

On Fri, 2022-02-11 at 23:52 -0800, Abhinav Kumar wrote:
> 
> The thread is writing the data to a file in local storage. From our 
> profiling, the read is the one taking the time not the write.
> 

That seems kind of hard to believe, let's say it's a 4/3 split (4
minutes reading, 3 minutes writing, to make read > write as you say),
and 3MiB size, that'd mean you get 12.8KiB/sec? That seems implausibly
low, unless you're reading with really tiny buffers?

Can you strace this somehow? (with timestamp info)

> Just doubling what we have currently. I am not sure how the current 5 
> mins timeout came from.
> 

To be honest it came out of thin air, and wasn't really meant as a limit
on how fast you can read (feels like even if it's tens of MiB you should
read it in milliseconds into userspace), but more of a maximum time that
we're willing to waste kernel memory if nobody is around to read the
data.

I thought it'd be better if we could somehow pin it while the userspace
is reading it, but OTOH maybe that's actually bad, since that means
userspace (though suitably privileged) could pin this kernel memory
indefinitely.

johannes
