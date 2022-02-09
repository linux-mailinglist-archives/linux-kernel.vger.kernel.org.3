Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED8E4AEB73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiBIHu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiBIHu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:50:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA1C0613CB;
        Tue,  8 Feb 2022 23:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ddsD2phgZUdtg2qpp+HrVXJ99MqUCSgUVEdA7iCALpQ=;
        t=1644393029; x=1645602629; b=KDYmkDdCvCw4K9k8uklb9JFAQ1TlU1c02+KbIe/BY9VrgYy
        RYJmLfTWGyW/utPvE3CQBbKnBrn6miY+JRdPOzJgy3ngtXvV/R4pcoMTrgh21YRIB+Pp5bvJeQ9eV
        rGtoPPJy/RK892NIQk1mLdsTETsa1TJ+6LeTOMs9ujLmoMqeNVxFUIwO0oBXlieKd61KTzmN3o1OT
        8gTfZRhjVRrK2JlalGp3e35In3PUuPrnbgngxb1i9zK7YgLb7VYQvsEQD1V7+uISiKGiDrrpXEhdX
        DhrAPlSn7U9SYv1kUsm+VOE8QKnoEh+EoNl+M3TTgkL0eAPJ6JN6ahU5y75P613Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nHhk5-00GWm6-2O;
        Wed, 09 Feb 2022 08:50:21 +0100
Message-ID: <2d71a9c0d2cd0b0c82a627b0585040c81a4523fa.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, swboyd@chromium.org,
        khsieh@codeaurora.org, nganji@codeaurora.org,
        seanpaul@chromium.org, gregkh@linuxfoundation.org,
        dmitry.baryshkov@linaro.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org
Date:   Wed, 09 Feb 2022 08:50:19 +0100
In-Reply-To: <b60d30cf-e435-49c4-a251-b910bc2e94ae@quicinc.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
         <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
         <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
         <c59bc1af9974484075091333a3c98a2088251321.camel@sipsolutions.net>
         <a280fec2-754a-88ec-acc7-337e069e9148@quicinc.com>
         <c2a6e29063793eecc5c65d32af9d826544404ecc.camel@sipsolutions.net>
         <b60d30cf-e435-49c4-a251-b910bc2e94ae@quicinc.com>
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

On Tue, 2022-02-08 at 17:55 -0800, Abhinav Kumar wrote:
> 
> Are you suggesting something like below?
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 42dcf96..14203d0 100644
> --- a/fs/sysfs/file.c
> 

No, for sure not, but I guess from the looks of this patch there's no
way to do something like that for just an individual attribute...

Oh well.

johannes
