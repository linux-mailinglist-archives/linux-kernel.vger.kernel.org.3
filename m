Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2050B3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445915AbiDVJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiDVJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:25:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06EA533E23
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:22:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57881477;
        Fri, 22 Apr 2022 02:22:31 -0700 (PDT)
Received: from bogus (unknown [10.57.11.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF2BA3F766;
        Fri, 22 Apr 2022 02:22:29 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:22:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arch_topology: support for describing cache topology
 from DT
Message-ID: <20220422092225.ezmaqxloujdw5bqg@bogus>
References: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
 <1650552960-60165-2-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650552960-60165-2-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 07:55:57AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> When ACPI is not enabled, we can get cache topolopy from DT like:
> *		cpu0: cpu@000 {
> *			next-level-cache = <&L2_1>;
> *			L2_1: l2-cache {
> * 				compatible = "cache";
> *				next-level-cache = <&L3_1>;
> * 			};
> *			L3_1: l3-cache {
> * 				compatible = "cache";
> * 			};
> *		};
> *
> *		cpu1: cpu@001 {
> *			next-level-cache = <&L2_1>;
> *		};
> *		...
> *		};
> cache_topology hold the pointer describing "next-level-cache",
> it can describe the cache topology of every level.

As I mentioned before, I would like to avoid any duplication and see
what can be reused from drivers/base/cacheinfo.c

We can discuss and see how to proceed on that once we settle/agree on
2/2. I don't want to waste your or my time if we don't end up using this.
So let us look at this once we agree to push the sched related changes
as we have used generic ones so far and you want to introduce arm64 specific
levels. That requires some discussions and thoughts before we can finalise.

Also I have mentioned you to keep Dietmar and Vincent in cc for all sched
related changes which you failed to do again. I expect you fix that next
time if you want them to help you in discussions and make any progress on
this. Otherwise it may get ignored as you don't have all the right
people in cc.

--
Regards,
Sudeep
