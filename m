Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033994B7881
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbiBOQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:44:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiBOQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:44:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7461019EA;
        Tue, 15 Feb 2022 08:44:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A2C60B41;
        Tue, 15 Feb 2022 16:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D94BC340EB;
        Tue, 15 Feb 2022 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644943469;
        bh=j5oH26Cfn5lFpZrtBYRNUgpR23mKOYs0t///TQ3gtos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dx/CDIATn6FoaibbMlYUYCWbYDywCRM1QA5iEN8V6FpJFF0KxX5UKPOXxjeOHv6eV
         JVKlhPrpk/0rnKmre4wP2Y+vlG7otqegLoprosnrs7qD+eTfULRCr64DRdBNoXC1pU
         DRUEBNK1Yie6VavxZYnGQtnA8HTdwLZUavmpjwRe8Z+vNjY66MJnBM9CJ++I4aQQoG
         gpDtbpz/vQ1oQjFW6lPKbJzqGCGxM3imwyOJ9pzdVdIIgqtPN5OiS9UXogazAF2kOL
         kMJ9tONegyRUiZj29VqIWskzzBFCJfTMkIe16DoeZuWCgG7DF9wv5kokaUA8bFS8h+
         WwHuaXcwC5NMg==
Date:   Tue, 15 Feb 2022 16:44:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zwang@amperecomputing.com,
        patches@amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
Message-ID: <20220215164423.GB8458@willie-the-truck>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209092642.9181-1-shijie@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 09:26:42AM +0000, Huang Shijie wrote:
> The following interrelated ranges are needed by the kdump crash tool:
> 	MODULES_VADDR ~ MODULES_END,
> 	VMALLOC_START ~ VMALLOC_END,
> 	VMEMMAP_START ~ VMEMMAP_END
> 
> Since these values change from time to time, it is preferable to export
> them via vmcoreinfo than to change the crash's code frequently.

Please can you explain _why_ they are needed?

Will
