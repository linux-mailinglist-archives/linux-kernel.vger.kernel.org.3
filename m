Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D14AE3FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356797AbiBHWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386453AbiBHUfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:35:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1AC0613CB;
        Tue,  8 Feb 2022 12:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jFMUOxkl3kB2j+Wo2GSKdxNzPGRMQ7XpF5gBMuNYOTk=;
        t=1644352519; x=1645562119; b=fJumUEPNdjhYM3d38TSYR/EZD4AxfMKk8PAW7QVmAldR8cF
        wgTW1uxQZ1fw4gD23fywmYyRM1P6lAf8au4bR638Y+TdgqJ2fzBgBLwsOL/+pcKkSLZFsLE2q1jxm
        ZSd2wpvAul7kEz1PmU1O4biCIz89sYXovXmxoOHXXg1kWwI0oRbE6QHwW89ZD7YaNikOSw09TYJly
        eNr6L6MTTq54zcaDe0rrN7YZMIf8+tLZcRWK0PsSsgeqn5Ojo/Hs3Hx/vMCOBuTq51f5VAYyuAkDC
        iSnmpXVhH6AatgkPdurQm0VdIjo+ZlXY2VStMIrEE9c+EqQcZ45CBIp2hVAi8SEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nHXCj-00GB3n-Oo;
        Tue, 08 Feb 2022 21:35:13 +0100
Message-ID: <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, seanpaul@chromium.org,
        swboyd@chromium.org, nganji@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org
Date:   Tue, 08 Feb 2022 21:35:11 +0100
In-Reply-To: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
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

On Tue, 2022-02-08 at 11:44 -0800, Abhinav Kumar wrote:
> There are cases where depending on the size of the devcoredump and the speed
> at which the usermode reads the dump, it can take longer than the current 5 mins
> timeout.
> 
> This can lead to incomplete dumps as the device is deleted once the timeout expires.
> 
> One example is below where it took 6 mins for the devcoredump to be completely read.
> 
> 04:22:24.668 23916 23994 I HWDeviceDRM::DumpDebugData: Opening /sys/class/devcoredump/devcd6/data
> 04:28:35.377 23916 23994 W HWDeviceDRM::DumpDebugData: Freeing devcoredump node
> 
> Increase the timeout to 10 mins to accommodate system delays and large coredump
> sizes.
> 

No real objection, I guess, but can the data actually disappear *while*
the sysfs file is open?!

Or did it take 5 minutes to open the file?

If the former, maybe we should fix that too (or instead)?

johannes
