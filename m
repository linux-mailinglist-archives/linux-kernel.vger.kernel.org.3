Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58D4AE439
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355659AbiBHW1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386790AbiBHVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:12:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DBC0612B8;
        Tue,  8 Feb 2022 13:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Ka1YRMzeVRg7rN1gJ2YpEkVn/wWTU+NPmgwt1bGNWtA=;
        t=1644354767; x=1645564367; b=T014nE4znWd8E+7itKVL1L9j11EYA5ju4k9PZHKGcJbbnBX
        f+NzZiLQoVCXf8J1jNGvww8NY0QcpH08RsMC+a4h/ldendjRCJc6XHCtUtv61el7duutRP6or/VdU
        yNj8aAQBM9Z7qyazCivippi7HC3r87VYwrvfrgjEg7p68Xn7YiI1ZImJj3426Dp0GAc4WFyihr1cL
        lEa1qTMnYbjl1X7qlYJpYHwzEeQ12c1dHP+vnnDORyr/2+j1gMiVqQCcjy34Y05tTumPkv9P5NPV4
        pvlfUHLPaLdY4fVJSvnq6Ih44zHQgUDG61R5Mv2h0QZYzQgDUqYRQjwwp0AlMJJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nHXn0-00GCMS-QC;
        Tue, 08 Feb 2022 22:12:42 +0100
Message-ID: <c59bc1af9974484075091333a3c98a2088251321.camel@sipsolutions.net>
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
Date:   Tue, 08 Feb 2022 22:12:41 +0100
In-Reply-To: <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
         <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
         <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
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

On Tue, 2022-02-08 at 13:04 -0800, Abhinav Kumar wrote:
> 
> It opened the file rightaway but could not finish reading.
> 
> The device gets deleted so the corresponding /data will disappear too ( 
> as the data node is under devcd*/data)

Yeah but even if the file disappears, the open file descriptor is still
there, no? Does sysfs somehow make those disappear? I know debugfs does
(now, to some extent, it didn't always), but I thought sysfs was
refcounting things and didn't do that?

What did the userspace actually see? read() returned 0 so EOF?

(I guess I could test it, but it's getting late)

Your other questions are related - you need to consider the file in
sysfs and the open file descriptor separately.

johannes

