Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7784D9FED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbiCOQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiCOQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:24:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761B5F66
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:23:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nU9wq-0001IY-Bn; Tue, 15 Mar 2022 17:23:00 +0100
Message-ID: <c22a0f1c-883d-5122-ef88-0d7c57ab4e66@pengutronix.de>
Date:   Tue, 15 Mar 2022 17:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Possible performance regression with CONFIG_SQUASHFS_DECOMP_SINGLE
To:     squashfs-devel@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This an issue we had with v5.15 that we have since successfully worked around.
I am reporting it here as a pointer in case someone else runs into this and as
a heads up that there seems to be an underlying performance regression, so
here it goes:

We have an i.MX8MM (4x Cortex-A53) system with squashfs on eMMC as a root file
system. The system originally ran NXP's "imx_5.4.24_2.1.0" which has about
5000 patches on top of upstream v5.4.24 including PREEMPT_RT.

The system was updated to mainline Linux + PREEMPT_RT and boot time suffered
considerably growing from 40s with vendor kernel to 1m20s with mainline-based
kernel.

The slowdown on mainline was reproducible for all scheduling models (with
or without PREEMPT_RT) except for PREEMPT_NONE, which was back at 40s.

The services most impacted by the slowdown were C++ applications with many
shared libraries dynamically loaded from the rootfs.

Looking through the original kernel configuration we found that it has
CONFIG_SQUASHFS_DECOMP_SINGLE=y and CONFIG_SQUASHFS_FILE_CACHE=y.

Once changed to CONFIG_SQUASHFS_FILE_DIRECT=y and
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y, we were below 40s as we want.

That's clearly the preferred configuration and it resolves our problem
It doesn't solve the underlying issue though:

  - CONFIG_PREEMPT_VOLUNTARY performs much worse than CONFIG_PREEMPT_NONE
    for some workloads when CONFIG_SQUASHFS_DECOMP_SINGLE=y

  - And this might not have been the case with v5.4. Unfortunately we can't
    bisect, because there wasn't enough i.MX8MM support mainline back then
    to boot the system. Earliest mainline-based kernel we reproduced this on
    was v5.11.

TL;DR: Check if CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y in your configuration

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
