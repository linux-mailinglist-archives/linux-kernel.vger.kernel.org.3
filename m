Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E7D4C8E55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiCAOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiCAOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:54:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474570CD5;
        Tue,  1 Mar 2022 06:53:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57396159A;
        Tue,  1 Mar 2022 14:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190CCC340EE;
        Tue,  1 Mar 2022 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646146424;
        bh=GD3ppfugRqIV23Miab38fww3xcaKUQM6WrDR9+Hobac=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OJ7+ZGm984efelp+NWTFaTZSwNtYW/hotKfXQQAbmPQdU2DVLAhJDKxty1YwNe0wF
         uuW9ZbcHwfWHZSqQ1OL1yL3tumw8R4ryx+4OYpt1149PryFFu7Ac7hOBFA6zFbMTku
         bW9e8qosXA3Tlfh+OcfCdAHOjFAZrARLsyn1rKGxYm4up4Uku7AP5vrV3Cb3FWjg/Y
         CxMe4D1OXlGPjDEw/n42MjQ4ImqnzkfNxub9psGTfcTKVKid9TAqCiFpw98pKmMcrh
         n8dFCGb3GkLb7R4kHn4Ye5eC/vGdQuUJBzEG0Ftyd2Tsn1v0iOLhA6hPH4yei5RT9N
         k8sic9WuMTR2w==
Date:   Tue, 1 Mar 2022 15:53:31 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?ISO-8859-2?Q?Ahelenia_Ziemia=F1ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] HID: fix for generic input processing
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2203011552560.24795@cbobk.fhfr.pm>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022, Benjamin Tissoires wrote:

> Hi,
> 
> this is the v2 of my series which reworks the HID report processing.
> 
> I took Ping's comments into account, and amended my MR with the
> regression tests[0].
> More specifically, the tests (and thus this new version of the series)
> enforces that only one BTN_TOOL_* event gets forwarded between each
> EV_SYN frame, and that BTN_TOUCH are properly translated too.
> 
> This also magivally solved some worrying transitions we had in the
> pen state machine where the pen was jumping from "eraser" to "in
> contact". This new behavior enforces a "out-of-range" state in the
> middle, making it easier for userspace to understand now.
> 
> Again, tests are welcome :)
> 
> Cheers,
> Benjamin
> 
> [0] https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127
> 
> Benjamin Tissoires (12):
>   HID: core: statically allocate read buffers
>   HID: core: de-duplicate some code in hid_input_field()
>   HID: core: split data fetching from processing in hid_input_field()
>   HID: input: tag touchscreens as such if the physical is not there
>   HID: input: rework spaghetti code with switch statements
>   HID: input: move up out-of-range processing of input values
>   HID: compute an ordered list of input fields to process
>   HID: core: for input reports, process the usages by priority list
>   HID: input: enforce Invert usage to be processed before InRange
>   HID: input: remove the need for HID_QUIRK_INVERT
>   HID: input: accommodate priorities for slotted devices
>   Input: docs: add more details on the use of BTN_TOOL
> 
>  Documentation/input/event-codes.rst |   6 +-
>  drivers/hid/hid-core.c              | 280 ++++++++++++++++++---
>  drivers/hid/hid-input.c             | 364 ++++++++++++++++++++++------
>  include/linux/hid.h                 |  23 +-
>  4 files changed, 568 insertions(+), 105 deletions(-)

This is now in hid.git#for-5.18/core.

Thanks a lot Benjamin, very nice work.

-- 
Jiri Kosina
SUSE Labs

