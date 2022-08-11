Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5037158F8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiHKIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiHKIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:05:14 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB42B2C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:05:10 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AFF75240026
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:05:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660205108; bh=uBjOoAjoOE2x/uB83MFmjFqoBdTq+uDcdv7yqd4frS4=;
        h=Date:From:To:Cc:Subject:From;
        b=ru+9AIOAljZ4b3fVkdp19kyLiAihJ0zKPfcF1B+Rf3fwXKaLxXFddvvL39n1D8+Jc
         PxFJgZeorWck0Ym2vyRONraZtyZ0PnRRWEt0l6AhdWsBxBWR2l5IiDoKQO4gRDS5cM
         g6Hz2aU+fdyA4Du/JuiPQ7Q8DAnMcZAK17TbamE2m/LZ8fl5pgwPYu7S3hFcFKW3Tc
         dLQFCf1nfs7xqn5WndsU5yiMNclcRmDppeZL+Riw+qhCZqIl6o/RzndJgIO2r9JTCD
         DYWlerU4QpneHE80pr76/jc0bq20sZfu8bP/hiJIt4TXU7nx09TCPnx4V6JEcuf/qJ
         MuIpMRDKkiVOQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M3K9H473jz9rxV;
        Thu, 11 Aug 2022 10:05:07 +0200 (CEST)
Date:   Thu, 11 Aug 2022 08:05:06 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Message-ID: <20220811100506.4d69b027@posteo.net>
In-Reply-To: <8beb8ae2-04cd-fa37-5dbe-8d18e6a53f4d@roeck-us.net>
References: <YvO4cfx12Q9gcmPg@monster.localdomain>
        <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
        <20220810185658.6e27d9bd@posteo.net>
        <bc1d22d1-45b4-7d49-bedd-f0eafdc035cd@roeck-us.net>
        <20220810194852.78536153@posteo.net>
        <8beb8ae2-04cd-fa37-5dbe-8d18e6a53f4d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 11:21:36 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 8/10/22 10:48, Wilken Gottwalt wrote:
> > On Wed, 10 Aug 2022 10:29:08 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> >> On 8/10/22 09:56, Wilken Gottwalt wrote:
> >>> On Wed, 10 Aug 2022 09:31:21 -0700
> >>> Guenter Roeck <linux@roeck-us.net> wrote:
> >>>
> >>>> On 8/10/22 06:53, Wilken Gottwalt wrote:
> >>>>> Add reporting if the PSU is running in single or multi rail mode via
> >>>>> ocpmode debugfs entry. Also update the documentation accordingly.
> >>>>>
> >>>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>>      - fixed spelling issues in commit message
> >>>>
> >>>> You did not address or even provide feedback on my second comment.
> >>>
> >>> Oh darn ... sorry, I was quite busy and didn't really pay attention. I will
> >>> answer the earlier mail and think about it.
> >>>
> >>> Though, maybe you can help me with that what keeps me so busy. Would it be okay
> >>> to use a kthread in a hwmon driver to do sampling (500ms - 10s) in conjunction
> >>> with HWMON_C_UPDATE_INTERVAL, or is this a strict no-no? I know it is actually
> >>> used to set a sample/update rate in a sensor (-register), but this USB-HID
> >>> approach is a pure polling thing. It seems to work quite and enables the driver
> >>> to collect data quite early in the boot process.
> >>>
> >>
> >> It really depends. Is it _necessary_ ? The pwm-fan driver uses a timer for
> >> periodic polling, but that is because it has to. We should not do it purely
> >> for convenience, and from the code I don't immediately see why it would
> >> be necessary.
> > 
> > Together with the polling I would add encountered lowest and highest values and
> > the average of basically all available sensors (kind of session statistics). I
> > know it is a bit odd, but currently these power supplies are sold again in a
> > newer version and people really like to use them in their servers/workstations
> > because of the "realtime" data and this driver. No joke, but I really got
> > several requests to add this and I must admit I have quite some fun implementing
> > it.
> > 
> 
> That is out of scope for a kernel driver. If desired, a user space application
> should do the polling and calculate statistics such as lowest/highest or averages.

That is exactly what I told the requesting people. Now it is in the public
record and I hope that kind of requests go down a bit, at least for pushing
this in the mainline kernel.

greetings,
Wilken
