Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AC59FE71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiHXPgm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Aug 2022 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiHXPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:36:40 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC931342;
        Wed, 24 Aug 2022 08:36:35 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id CBCABE0003;
        Wed, 24 Aug 2022 15:36:30 +0000 (UTC)
Message-ID: <ba73ce3733ff76b081fb0916e4b9be82179a42dc.camel@hadess.net>
Subject: Re: [PATCH v3 2/3] Input: joystick: xpad: Add X-Box Adaptive
 Controller Layer button
From:   Bastien Nocera <hadess@hadess.net>
To:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Aug 2022 17:36:30 +0200
In-Reply-To: <b32cee349fdfa6ffdc60cd31f662dbd479b01e4d.camel@hadess.net>
References: <20220813185343.2306-1-nate@yocom.org>
         <20220813185343.2306-3-nate@yocom.org>
         <b32cee349fdfa6ffdc60cd31f662dbd479b01e4d.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-17 at 12:37 +0200, Bastien Nocera wrote:
> On Sat, 2022-08-13 at 11:53 -0700, Nate Yocom wrote:
> > Adds a new quirk for controllers that have a Layer button which has
> > 4
> > states, reflected as an ABS_MISC axis with 4 values.
> 
> It's called the "Profile Button" in the official documentation:
> https://support.xbox.com/en-US/help/account-profile/accessibility/get-to-know-adaptive-controller
> so best to call it that.
> 
> I wonder we have any other examples of profile handling in input
> drivers. The xpadneo driver implements the profiles in the kernel
> driver directly.
> 
> Benjamin?

After speaking to Benjamin, it was clear that ABS_MISC wasn't the right
absolute axis to use.

I think that adding a new ABS_* axes in include/uapi/linux/input-event-
codes.h would be the best, for example ABS_PROFILE as 0x21.

Dmitry, what do you think?

The idea here is to encode a hardware controlled switch that has 4
possible values. Its state will be sent with every input event in order
for user-space to (maybe) apply a specific profile to the events.

This would also be used by the XBox Elite 2 controller driver.

Cheers
