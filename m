Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757314A464C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378003AbiAaLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380541AbiAaLph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:45:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF82C06136F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 875EDB82A42
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE55DC340E8;
        Mon, 31 Jan 2022 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643628913;
        bh=Ow54je8UTcAKdwrgrjjuTJRzwEPu54U100XeZaWxyZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0KU3zS3XilzLyYarOVzBTqNf55opYsUgbivSHd4Pao4sqX9QbHKzmpUUWWCODjYA
         5URzCkyPUXhcIyQmE8quN9IkroZeBL/3pIxp0+tqquK07ZqlR7Y7S99DlufRXf0NJl
         PRGGZEesj2ztAwcdoDDk35r7KCoORi8waKhm0tgc=
Date:   Mon, 31 Jan 2022 12:35:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 6/6] topology/sysfs: Add PPIN in sysfs under cpu
 topology
Message-ID: <YffJbnO5uyYptFAd@kroah.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
 <20220121174743.1875294-7-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121174743.1875294-7-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:47:43AM -0800, Tony Luck wrote:
> PPIN is the Protected Processor Identification Number.
> This is used to identify the socket as a Field Replaceable Unit (FRU).
> 
> Existing code only displays this when reporting errors. But this makes
> it inconvenient for large clusters to use it for its intended purpose
> of inventory control.
> 
> Add ppin to /sys/devices/system/cpu/cpu*/topology to make what
> is already available using RDMSR more easily accessible. Make
> the file read only for root in case there are still people
> concerned about making a unique system "serial number" available.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-system-cpu  | 4 ++++
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 6 ++++++
>  arch/x86/include/asm/topology.h                    | 1 +
>  drivers/base/topology.c                            | 4 ++++
>  include/linux/topology.h                           | 3 +++
>  5 files changed, 18 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
