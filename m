Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225215ABD47
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiICFvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiICFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:51:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D6DEA61;
        Fri,  2 Sep 2022 22:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89DC1B8210C;
        Sat,  3 Sep 2022 05:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC587C433D6;
        Sat,  3 Sep 2022 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662184299;
        bh=fFxWroWrVfVRE+Fn43/2dLEdtMojhWkEhXkMwiKHspk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEEFMZ9Deu0H3isLNdjWcXvpVKRXC5095iMke/j/HRx18gr9DJZUu4zwT1HW8F1P8
         uCJD9zZrTjfYvrM+/Vd2ysZOqvrFY7ysW7F+D+VzlIVKE2V/l5WraCwxxJjNNO0eZ9
         IqhQ8z5Y4YqS/bn1P6AT3oXdOMgDQBvyM3FWo1fA=
Date:   Sat, 3 Sep 2022 07:51:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: atkbd - switch to using dev_groups for
 driver-specific attributes
Message-ID: <YxLrfVjnOy8JdzN6@kroah.com>
References: <20220903051119.1332808-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903051119.1332808-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:11:17PM -0700, Dmitry Torokhov wrote:
> The driver core now has the ability to handle the creation and removal
> of device-specific sysfs files, let's use it instead of registering and
> unregistering attributes by hand.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/atkbd.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Wow, I had missed these in my searches as I didn't think any drivers
would be using sysfs_create_groups(), thanks for noticing them and
cleaning these up.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
