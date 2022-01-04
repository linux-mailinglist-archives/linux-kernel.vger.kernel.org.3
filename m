Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0243483FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiADKSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:18:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58100 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiADKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:18:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBB76130A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD27C36AE9;
        Tue,  4 Jan 2022 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641291532;
        bh=8/HEmyqRV2Qs+y4O+h7sf7endKMT2MF5HWeUoTBUMS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wiBdkg23wKz3095eEGrUW5EAuWQZt0sOXzn7gUyKQxcv5VyChOXPbG1xHDFdt1Gys
         ++JlI04La2+irMyzET3o0NNv3m1LOVNjhei150qZFOKz0jjex+fWnmgcAUR5nQ3f8k
         IsHwyQd8hLfy48yJE0sCFCyBTQY/LuUbOdEbQ6Vs=
Date:   Tue, 4 Jan 2022 11:18:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Fei Li <fei1.li@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: fix memory leak in acrn_dev_ioctl()
Message-ID: <YdQfCGf8qr5zZJef@kroah.com>
References: <20220104085321.94485-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104085321.94485-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:53:21PM +0800, Zhou Qingyang wrote:
> In acrn_dev_ioctl(), cpu_regs is not released or passed out on several 
> error paths which could lead to memory leak bug.
> 
> Fix this bug by adding kfree of cpu_regs on error paths.
> 
> This bug was found by a static analyzer.
> 
> Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 2ad2aaee1bc9 ("virt: acrn: Introduce an ioctl to set vCPU registers state")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in
> the current function or the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.

Then why have all of those researchers put their reviewed-by on this
change?

Note that your university is still in many kernel maintainer's
ignore-list (myself included, I dug this up as I saw Fei's response.)
Please work with your administration and the process that is currently
happening in order to give you all the needed training so you will not
keep causing these types of basic errors that keep your patches from
being accepted.

*plonk*

greg k-h
