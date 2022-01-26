Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2363B49C7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiAZKgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:36:51 -0500
Received: from foss.arm.com ([217.140.110.172]:58514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232441AbiAZKgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:36:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD6F1FB;
        Wed, 26 Jan 2022 02:36:50 -0800 (PST)
Received: from bogus (unknown [10.57.39.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE2C53F766;
        Wed, 26 Jan 2022 02:36:48 -0800 (PST)
Date:   Wed, 26 Jan 2022 10:36:14 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        Sudeep Holla <sudeep.holla@arm.com>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
Message-ID: <20220126103614.pcrcuc2kzklkq3xa@bogus>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
 <20220125071414.811344-6-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125071414.811344-6-tarumizu.kohei@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:14:11PM +0900, Kohei Tarumizu wrote:
> This patch will create a cache sysfs directory without ACPI PPTT if
> the CONFIG_HWPF_CONTROL is true.
> 
> Hardware prefetch control driver need cache sysfs directory and cache
> level/type information. In ARM processor, these information can be
> obtained from the register even without PPTT. Therefore, we set the
> cpu_map_populated to true to create cache sysfs directory if the
> machine doesn't have PPTT.

I am assuming this is ACPI enabled system.

This looks bit hacky in my opinion. Before I explore better way of adding it,
I would like to check if you have explored ways to add PPTT reading these
registers from UEFI/EDK2 as PPTT has other topology information which you will
need anyways. That would simplify handling of these cacheinfo sysfs in the
kernel. Let me know what are your thoughts ?

-- 
Regards,
Sudeep
