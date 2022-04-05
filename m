Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C564F5200
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849137AbiDFCdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447044AbiDEWWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:22:52 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.180.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80552170097
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:16:23 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id C8F3E5F99
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:15:52 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bqWmndZUb9AGSbqWmnEeZE; Tue, 05 Apr 2022 16:15:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RpbIKh1r4/BW29+SALiRPg7XSNqIUw9inRFZ3VtgfiY=; b=rnlkEyAZ4vKF3WOJgUmnyodVrd
        C9uslS+M0meUurmet+JAVGBKXdhvwkIsWqpuSeJ3EcCqFEYMEjuAqUGDZmtQnL3BCd9vAK27T05Oa
        7tPV96MzU0+N8l6/JBVEpE2FB90fN6F/nYDinDJWCPLn6wR28z+e6Z0zxJrDOG2YR0wzLBYxMWkg0
        dR9uykoHq/SLgOZElDtv6iSGL0s4P52SjaEyDGDYrvNa3y//i4/710EKGF3oVJKIuPV9+BEfzMLi2
        zoDNoDnzROHbpBYgHf9NVeN34NkjbHdapgBTLoJPWoo/3DBJHTwTEStObnVxjVyZCG838QavMbBdM
        zLCwH4jg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57868 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbqWm-003GUy-8P; Tue, 05 Apr 2022 21:15:52 +0000
Date:   Tue, 5 Apr 2022 14:15:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        will@kernel.org, qperret@google.com, maz@kernel.org
Subject: Re: [PATCH 2/2] watchdog: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <20220405211551.GB2121947@roeck-us.net>
References: <20220405141954.1489782-1-sebastianene@google.com>
 <20220405141954.1489782-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405141954.1489782-3-sebastianene@google.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbqWm-003GUy-8P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57868
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian,

On Tue, Apr 05, 2022 at 02:19:55PM +0000, Sebastian Ene wrote:
> This patch adds support for a virtual watchdog which relies on the
> per-cpu hrtimers to pet at regular intervals.
> 

The watchdog subsystem is not intended to detect soft and hard lockups.
It is intended to detect userspace issues. A watchdog driver requires
a userspace compinent which needs to ping the watchdog on a regular basis
to prevent timeouts (and watchdog drivers are supposed to use the
watchdog kernel API).

What you have here is a CPU stall detection mechanism, similar to the
existing soft/hard lockup detection mechanism. This code does not
belong into the watchdog subsystem; it is similar to the existing
hard/softlockup detection code (kernel/watchdog.c) and should reside
at the same location.

Having said that, I could imagine a watchdog driver to be used in VMs,
but that would be similar to existing watchdog drivers. The easiest way
to get there would probably be to just instantiate one of the watchdog
devices already supported by qemu.

Guenter
