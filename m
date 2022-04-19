Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89084507C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358198AbiDSWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358186AbiDSWMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E211C39;
        Tue, 19 Apr 2022 15:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26888617C8;
        Tue, 19 Apr 2022 22:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57787C385A5;
        Tue, 19 Apr 2022 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650406203;
        bh=nu7JAz/iZL5xTvK4t662LoC6NJwxk64ejQbKntayjS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqzbBSjii0XE3/O32BfwfZmA7x1Vj61tfhxaX5LFu6xKYotqzzco1/yprAaUIy8bA
         lo3POwW9Vk+ZWi+vUCL48fEo9dK9WkaVXsebg5a/3updlLqYimxU1QkSR5W/Lp9Bky
         FDkt+/000BDTQKAZitfcbHcA1AYCLx8bieS9stzwdVCv3UvTJ+jgJ8ZSW42YkbG7u3
         Yy+jxF/qmQLbUJeh9oj1XnxiS+Gq8XIFjraDOtpNnSSFLt8vUynrJz7EQZir4/juG7
         T+aw0XK0Qi2T8mNkHox128A0GUaRAJXOMYfOL1FKyN01kmN1VDUwx+7ALJJ1/gkZdt
         ZDaRsc1Wjp8uQ==
Received: by pali.im (Postfix)
        id 070FB692; Wed, 20 Apr 2022 00:09:59 +0200 (CEST)
Date:   Wed, 20 Apr 2022 00:09:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] power: supply: bq27xxx: expose battery data when CI=1
Message-ID: <20220419220959.jnyhycaarxtucymo@pali>
References: <20220419213647.1186284-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419213647.1186284-1-absicsz@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 April 2022 23:36:46 Sicelo A. Mhlongo wrote:
> We currently discard capacity information provided by the chip when the
> Capacity Inaccurate flag is set. However, in many cases, having this
> stale data is better than no information at all.
> 
> Even if the chip has been fully reset, the datasheet shows that capacity 
> values (NAC specifically) can be seeded by using the WRTNAC facility of 
> the Control and Mode registers. After seeding, CI remains set, but the
> capacity values are as accurate as the NAC value provided to WRTNAC is.

NAC (Nominal Available Capacity) is exported via CHARGE_NOW property.

So what about implementing CHARGE_NOW property also writable and write
operation would do this WRTNAC seeding? So userspace would be able to do
'echo new_value > charge_now' and for Nokia N900 case just directly
'cat .../rx51_battery/charge_full_design > .../bq27200/charge_now'

> On the Nokia N900, such seed value can be obtained from rx51_battery, 
> which reads battery data directly from the battery's BSI pin. This can
> be done in userspace via i2c access to the registers. With this patch,
> once seeded, capacity values are available through the driver.
> 
> The patch was successfully tested on bq27200 on the Nokia N900.
> 
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> 
> Sicelo A. Mhlongo (1):
>   power: supply: bq27xxx: expose battery data when CI=1
> 
>  drivers/power/supply/bq27xxx_battery.c | 58 +++++++++++++-------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> -- 
> 2.35.2
> 
