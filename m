Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC54AE440
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386733AbiBHW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387107AbiBHVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:54:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD4C0612B8;
        Tue,  8 Feb 2022 13:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=A+S/j9icHeYwdxH49eBPZ83QO48LwLkJGGxnQOH8gC8=;
        t=1644357281; x=1645566881; b=Apd2a+F/6QJqcIihlzohIK5QcDkmZkPZ+wv3zJX4Yxl4Jds
        3CDHrfcd4/ohluFaNVk+32QaaPGoaLmzjnZRLrqak0Iw1X/n9720Yxkc+Bk7McW6s7IMXxQZUV095
        xYP8AcUpPyne4JtThVvUN7pR7D0iGTjKlNiW1ZKpcVZlf4KGeCiY4HkbSpVKdMxT/4+SBqmcoajnn
        tGtjlOiP8bAdNJlnR7O/5js6MeQHO818fFnPBNTviNgyOkfXAfbOfaB1MTmKcR6w7Nz7jMhgmtCC8
        hdWs01UiYNCVviiyDIUzinyjH3y7ENLg5D3VJKxsLzUn3W48UfTfXfyHLrelWfjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nHYRX-00GDjC-9O;
        Tue, 08 Feb 2022 22:54:35 +0100
Message-ID: <c2a6e29063793eecc5c65d32af9d826544404ecc.camel@sipsolutions.net>
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
Date:   Tue, 08 Feb 2022 22:54:34 +0100
In-Reply-To: <a280fec2-754a-88ec-acc7-337e069e9148@quicinc.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
         <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
         <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
         <c59bc1af9974484075091333a3c98a2088251321.camel@sipsolutions.net>
         <a280fec2-754a-88ec-acc7-337e069e9148@quicinc.com>
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

On Tue, 2022-02-08 at 13:40 -0800, Abhinav Kumar wrote:
> > 
> I am checking what usermode sees and will get back ( I didnt see an 
> error do most likely it was EOF ). I didnt follow the second part.

I think probably it got -ENODEV, looking at kernfs_file_read_iter().

> If the file descriptor read returns EOF, even if we consider them 
> separate how will it resolve this issue?
> 
> My earlier questions were related to fixing it in devcoredump to detect
> and fix it there. Are you suggesting to fix in usermode instead? How?
> 

Yeah, no, you cannot fix it in userspace.

But I just followed the rabbit hole down kernfs and all, and it looks
like indeed the read would be cut short with -ENODEV, sorry.

It doesn't look like there's good API for this, but it seems at least
from the underlying kernfs POV it should be possible to get_device() in
open and put_device() in release, so that the device sticks around while
somebody has the file open? It's entirely virtual, so this should be OK?

johannes
