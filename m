Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097C249F6F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbiA1KPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbiA1KPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:15:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DA3C06173B;
        Fri, 28 Jan 2022 02:15:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94186B82513;
        Fri, 28 Jan 2022 10:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D49C340E0;
        Fri, 28 Jan 2022 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643364948;
        bh=IqKsdmtcoXo/YK7JT1TZuG90bj1qq6VQtmMzxkz+FMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omBwj6mD3mH/GbRAnTQUeMsxfwAJgoUyiZZaXRFctu2JMoqe0g6qVeHoQpZzhyM1F
         CQyzEkG9/DoO9HqB8FMCR4BqSuwU0CAP1JKXpAZGIDHliKG7VK71C6KlwBuDI48Bq9
         m4XRvSQw6v3BvlvdUOXfh84WwMRZ/jrt5eItW+ok=
Date:   Fri, 28 Jan 2022 11:15:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: OSL: Fix a NULL pointer dereference in
 extlog_init().
Message-ID: <YfPCURbOtpGqekyi@kroah.com>
References: <20220124164134.52046-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124164134.52046-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:41:34AM +0800, Zhou Qingyang wrote:
> In extlog_init(), acpi_os_map_iomem() is assigned to extlog_l1_hdr and
> there is a dereference of it through l1_head. on the failure of
> acpi_os_map_iomem(), the return value of it could be NULL, which may
> introduce a NULL pointer dereference.
> 
> Fix this bug by adding a NULL check of extlog_l1_hdr.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: a238317ce818 ("ACPI: Clean up acpi_os_map/unmap_memory() to eliminate __iomem.")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.

Then all of their names need to be on the commit.

Also, as stated before, umn.edu is still not allowed to contribute to
the Linux kernel.  Please work with your administration to resolve this
issue.

