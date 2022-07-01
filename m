Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83FF562C21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiGAG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiGAG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:58:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72600D112;
        Thu, 30 Jun 2022 23:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 222C5B82E4A;
        Fri,  1 Jul 2022 06:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F47C3411E;
        Fri,  1 Jul 2022 06:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656658706;
        bh=UBTffDzwvX+CIbxAmYZr3d1/a9dxAAVHxHpGjDbKgZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJZ6ik/UCVTN+TI4KrBpCUcCsfajMFoqMLvjNbX/hvnNvv7ZLp8RsqdHLqDH57XQ6
         GqNwuG2svF5w8wDIA7IPqFAYjUymqoCi5Vy8GNzdMoffP1Cp6kKUpsiUhdI5YuOJGo
         z4Mwb1f60PK3kAlmzwM644su2oZ+Mm9LHeWxmwuk=
Date:   Fri, 1 Jul 2022 08:58:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-pm@vger.kernel.org, Richard Gong <richard.gong@amd.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] HID: usbhid: Set USB mice as s2idle wakeup
 resources
Message-ID: <Yr6bELakZTVhpknY@kroah.com>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <20220701023328.2783-10-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701023328.2783-10-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:33:28PM -0500, Mario Limonciello wrote:
> The USB HID transport layer doesn't configure mice for wakeup by default.
> Thus users can not wake system from s2idle via USB mouse. However, users
> can wake the same system from Modern Standby on Windows with the same USB
> mouse.
> 
> Microsoft documentation indicates that all USB mice and touchpads should
> be waking the system from Modern Standby.

As I said before, their documentation indicates that all _EXTERNAL_ mice
and touchpads.  You forgot about internally connected mice and touchpads
here, you wouldn't want them to wake up a device asleep, right?

thanks,

greg k-h
