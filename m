Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D54C8DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiCAOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCAOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:30:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6B7EA01;
        Tue,  1 Mar 2022 06:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5FD61555;
        Tue,  1 Mar 2022 14:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B77EC340EE;
        Tue,  1 Mar 2022 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646144965;
        bh=Lz7ZHbQkw8RobUC8+iZK0D0OkkvqTGgyx7OT5pKsH0M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eBdDZGqWgtd4G4L4TZhwxLuqNhnbpEHGxoiRxkc+rb+vENn6yUP66jXc7eOiSt37i
         SIPvQJsE74KMHa9qeMVI3ssvjaQYZnPYCCNERGnyFvGNLrr9RPbMb0IDy/sjv/OI+s
         gXDvmsZLybbEP9kI/S9li7+C3hcEjTeG0A3+QVCGgRHjykvuxoGntnBNoWurwuB9q+
         lUbBkToBhV3E1XcM9prZBAPcGwQjndCf7nRC5VG7YJGm6iAhwZlu/wLAU4zLi+gq+A
         +PNDwOCcSXa+spmeKGRBqs/zmMz0Tmbv1Le8rpDGqXW5eJxbJJW9kfhtX+vgOHBtAi
         JdXhhO7LQvEFQ==
Date:   Tue, 1 Mar 2022 15:29:21 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.18/uclogic 0/9] DIGImend patches, part II
In-Reply-To: <20220219100157.41920-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2203011529020.11721@cbobk.fhfr.pm>
References: <20220219100157.41920-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2022, José Expósito wrote:

> Hi everyone,
> 
> This series is a follow up to [1], kindly reviewed and applied
> by Jiří in hid.git#for-5.18/uclogic.
> 
> It might look a little bit longer than desired, but most of the
> patches are code simplification and refactoring in preparation
> for the last patch which adds support for multiple frame input
> devices.
> 
> Thank you very much in advance to maintainers for reviewing it,
> José Expósito
> 
> [1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
> 
> Nikolai Kondrashov (9):
>   HID: uclogic: Remove pen usage masking
>   HID: uclogic: Replace pen_frame_flag with subreport_list
>   HID: uclogic: Switch to matching subreport bytes
>   HID: uclogic: Specify total report size to buttonpad macro
>   HID: uclogic: Use different constants for frame report IDs
>   HID: uclogic: Use "frame" instead of "buttonpad"
>   HID: uclogic: Put version first in rdesc namespace
>   HID: uclogic: Define report IDs before their descriptors
>   HID: uclogic: Support multiple frame input devices
> 
>  drivers/hid/hid-uclogic-core.c   |  79 +++++++------
>  drivers/hid/hid-uclogic-params.c | 195 ++++++++++++++-----------------
>  drivers/hid/hid-uclogic-params.h |  86 +++++++-------
>  drivers/hid/hid-uclogic-rdesc.c  |  53 ++++-----
>  drivers/hid/hid-uclogic-rdesc.h  |  38 +++---
>  5 files changed, 221 insertions(+), 230 deletions(-)

Now queued in hid.git#for-5.18/uclogic.

Thanks,

-- 
Jiri Kosina
SUSE Labs

