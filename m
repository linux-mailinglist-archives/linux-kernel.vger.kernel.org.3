Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA14BCF9A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiBTPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:49:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiBTPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:49:19 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04980532D0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:48:58 -0800 (PST)
Received: from ylum.localnet (unknown [IPv6:2a01:e0a:3d9:ddd0:37f3:7f74:639b:b0a3])
        (Authenticated sender: domi.dumont@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4BF65B004EE;
        Sun, 20 Feb 2022 16:48:43 +0100 (CET)
From:   Dominique Dumont <dod@debian.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Reply-To: dod@debian.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, 1005005@bugs.debian.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Evan Quan <evan.quan@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic in suspend (v2)") on suspend?
Date:   Sun, 20 Feb 2022 16:48:43 +0100
Message-ID: <5164225.DI6hChFYCN@ylum>
In-Reply-To: <CADnq5_MfR99OhjumQESCO7Oq+JVOHOVgyVQHX4FpGFDnPu6CyQ@mail.gmail.com>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan> <CADnq5_MfR99OhjumQESCO7Oq+JVOHOVgyVQHX4FpGFDnPu6CyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 14 February 2022 22:52:27 CET Alex Deucher wrote:
> Does the system actually suspend?  

Not really. The screens looks like it's going to suspend, but it does come 
back after 10s or so. The light mounted in the middle of the power button does 
not switch off.

> Is this system S0i3 or regular S3?

I'm not sure how to check that. After a bit of reading on the Internet [1], I 
hope that the following information answers that question. Please get back to 
me if that's not the case.

Looks like my system supports both Soi3 and S3

$ cat /sys/power/state 
freeze mem disk

I get the same result running these 2 commands as root:
# echo freeze > /sys/power/state
# echo mem > /sys/power/state

>  Does this patch help by any chance?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> d=e55a3aea418269266d84f426b3bd70794d3389c8

yes, with this patch:
- the suspend issue is solved
- kernel logs no longer show messages like "failed to send message" or 
"*ERROR* suspend of IP block <powerplay> failed" while suspending

All the best

[1] https://01.org/blogs/rzhang/2015/best-practice-debug-linux-suspend/
hibernate-issues


