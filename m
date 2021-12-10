Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A7B47056F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhLJQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:21:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44390 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbhLJQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:20:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BBB9CE211C;
        Fri, 10 Dec 2021 16:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92988C00446;
        Fri, 10 Dec 2021 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639153041;
        bh=eEOzoZqVJMKv25tFyw1dzqbBRMrJAuuCYvvNkluR5nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDtkTvK7+i80796F890FjPoOL0Th8QL2gk+G+CjlfOpZ0rjkKWybTOCW9jbf9cOZL
         guJ7WjobyeR51iKYvMZk4G44WxVXru25cMxa2dkCRA0xVwSKR83EPexneplgh5KKqO
         KM41udNCHj1Y7rlG3m2IsSe3XRwxplOOPkdauxRI=
Date:   Fri, 10 Dec 2021 17:17:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: runtime: Add safety net to supplier device release
Message-ID: <YbN9jtlcKYG/WObw@kroah.com>
References: <11889065.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11889065.O9o76ZdvQC@kreacher>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:10:13PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because refcount_dec_not_one() returns true if the target refcount
> becomes saturated, it is generally unsafe to use its return value as
> a loop termination condition, but that is what happens when a device
> link's supplier device is released during runtime PM suspend
> operations and on device link removal.
> 
> To address this, introduce pm_runtime_release_supplier() to be used
> in the above cases which will check the supplier device's runtime
> PM usage counter in addition to the refcount_dec_not_one() return
> value, so the loop can be terminated in case the rpm_active refcount
> value becomes invalid, and update the code in question to use it as
> appropriate.
> 
> This change is not expected to have any visible functional impact.
> 
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/core.c          |    3 +--
>  drivers/base/power/runtime.c |   41 ++++++++++++++++++++++++++++++-----------
>  include/linux/pm_runtime.h   |    3 +++
>  3 files changed, 34 insertions(+), 13 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
