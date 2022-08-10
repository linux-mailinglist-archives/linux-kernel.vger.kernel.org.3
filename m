Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9858F1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiHJRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHJRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:49:04 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9DB8C443
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:48:55 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7388324002A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660153734; bh=jy6n1S3YeB0RcKIkxKT4aPXQLVnQFIHbNqQoHkyrx/E=;
        h=Date:From:To:Cc:Subject:From;
        b=TC7LrVgItVOFl+957ue9Tii1LbUJjTzOFcYT9wqYUdAk+gxs68o1Q43wkSbm/7Klj
         gQSxslQRRMqFhh5s3lx3er+FtZnr4CQYsYo+C5twL6OYu47Qx3Z7ETXtwb7y8AtjVh
         kQ091uEfMiHKRbvR1W2/qsddJfwiVv1WwweIQU9iOHzDjRurOHbUH+PJSvvobbptuV
         Egh/1WdRInOBHFvbAEH9zej4j3B1uMSBtIizfYOr54m6zWKY6tz7MbOJ16ygFq9sI1
         kIv0qvm4t0yqD6ugP1L7DivjSgBGiVmi2qdWPdawXlf2mhb4ULJhuV8Le2bot5uado
         fiFv6bd1eEeDg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M2y9K4vnfz6tmQ;
        Wed, 10 Aug 2022 19:48:53 +0200 (CEST)
Date:   Wed, 10 Aug 2022 17:48:52 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Message-ID: <20220810194852.78536153@posteo.net>
In-Reply-To: <bc1d22d1-45b4-7d49-bedd-f0eafdc035cd@roeck-us.net>
References: <YvO4cfx12Q9gcmPg@monster.localdomain>
        <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
        <20220810185658.6e27d9bd@posteo.net>
        <bc1d22d1-45b4-7d49-bedd-f0eafdc035cd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 10:29:08 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 8/10/22 09:56, Wilken Gottwalt wrote:
> > On Wed, 10 Aug 2022 09:31:21 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> >> On 8/10/22 06:53, Wilken Gottwalt wrote:
> >>> Add reporting if the PSU is running in single or multi rail mode via
> >>> ocpmode debugfs entry. Also update the documentation accordingly.
> >>>
> >>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >>> ---
> >>> Changes in v2:
> >>>     - fixed spelling issues in commit message
> >>
> >> You did not address or even provide feedback on my second comment.
> > 
> > Oh darn ... sorry, I was quite busy and didn't really pay attention. I will
> > answer the earlier mail and think about it.
> > 
> > Though, maybe you can help me with that what keeps me so busy. Would it be okay
> > to use a kthread in a hwmon driver to do sampling (500ms - 10s) in conjunction
> > with HWMON_C_UPDATE_INTERVAL, or is this a strict no-no? I know it is actually
> > used to set a sample/update rate in a sensor (-register), but this USB-HID
> > approach is a pure polling thing. It seems to work quite and enables the driver
> > to collect data quite early in the boot process.
> > 
> 
> It really depends. Is it _necessary_ ? The pwm-fan driver uses a timer for
> periodic polling, but that is because it has to. We should not do it purely
> for convenience, and from the code I don't immediately see why it would
> be necessary.

Together with the polling I would add encountered lowest and highest values and
the average of basically all available sensors (kind of session statistics). I
know it is a bit odd, but currently these power supplies are sold again in a
newer version and people really like to use them in their servers/workstations
because of the "realtime" data and this driver. No joke, but I really got
several requests to add this and I must admit I have quite some fun implementing
it.

Maybe I can provide a patch after I'm done and you can decide if this is okay
or not. After all I provide an external more enhanced driver via github where
some features are added, which are a clear no-go. It would be nice to have that
in mainline, but I'm absolutely fine with a "no".

greetings,
Wilken
