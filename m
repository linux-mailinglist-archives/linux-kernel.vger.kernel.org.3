Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB68522F90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbiEKJhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiEKJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:36:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23D15A1E;
        Wed, 11 May 2022 02:36:45 -0700 (PDT)
Date:   Wed, 11 May 2022 11:36:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652261803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YsRk0Y52ceB53mzi0WU1URp8hY6d/Zh5KcVXn1JeIso=;
        b=RzKx2A3OwQ0esNe35M1hejmwml8x/rR0nFzylwQ7NubQ11bIXJNDXkPvWMmMPPjrzFhqON
        xvZtTRXTaBM2D5UrDKf1fmOSUTaRQ5CvwPYChu9fqbtISYp1EvgbzD01Px28623JbGIiJZ
        blK+h+IqPi0k1FR05u82nU3Wxjt8Dzxu6DQT7H0fvVnSJ0g6PsYEhtfHXw4FNZrAbmnSWx
        SSaMQJ99GgsIev7uBtvkNG0QmYIGErZBWIreJzF/m1bxCZBrGIKDvjWHhzewWj5pZ38pKE
        vNJmF2kJoAtP6oUYmuTHcW3lN8OvLtMUIHP7YHvrY67rw4i1LxED2VzOI6Avuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652261803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YsRk0Y52ceB53mzi0WU1URp8hY6d/Zh5KcVXn1JeIso=;
        b=ctQINjeHT9J5/fntc05J4Ji+uvR/PxE6gNX9a3kvgxJvwo1mTpy46Pk9yGgxiN9UClUQKD
        vR0hjYwsnPvIbBBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com, ben.dai@unisoc.com, shian.wang@unisoc.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH] kernel: locking: rwsem optimization for rtlinux
Message-ID: <YnuDqYz5vlFw3lZy@linutronix.de>
References: <1652257281-11494-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652257281-11494-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-11 16:21:21 [+0800], zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> With regard to rtlinux, releasing the lock to RT waiter could be helpful to
> increase its responding time even if cfs writer listed at the head of the
> wait_list.

This does not apply to current kernel (v5.18-rc6). If you need want to
apply some thing to an older kernel, I suggest a backport and reasoning
why this backport is needed.
So first you need address the issue, that you are facing, in the current
development kernel.
Also it would be good to know if "rtlinux" is PREEMPT_RT or something
else. The latter uses a different mechanism.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Sebastian
