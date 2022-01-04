Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAD483CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiADHhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:37:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40576 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiADHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:37:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 004DF612B9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 07:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB760C36AED;
        Tue,  4 Jan 2022 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641281850;
        bh=v2lNzqSbU2x0cV+Xpxqk19+qAMt8N7vLbnwM7OdLlJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+ByJnflafx13xb3UebgWp9YjvDbRXNhE5SMO1fgUunjhj4z3OpkHsICN+rISZU3f
         cn9fN9yTphPfsG51SriXePJls7E3+8K8MbGmFVRdogVrItcyz24pX5FqvPYr8RBHsw
         eJKhlDmQWxeRGwUr/SvY0Yc7mFtpKXsoNL2dM8WE=
Date:   Tue, 4 Jan 2022 08:37:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Fei1 <fei1.li@intel.com>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        reinette.chatre@intel.com, zhi.a.wang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: fix a memory leak bug in acrn_dev_ioctl()
Message-ID: <YdP5N3lYqF09dLPv@kroah.com>
References: <20220104024729.GA26952@louislifei-OptiPlex-7050>
 <20220104034501.45715-1-zhou1615@umn.edu>
 <20220104035032.GA27848@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104035032.GA27848@louislifei-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:50:33AM +0800, Li Fei1 wrote:
> On Tue, Jan 04, 2022 at 11:45:01AM +0800, Zhou Qingyang wrote:
> > In acrn_dev_ioctl(), vm_param is not released or passed out on the 
> > error path of "if ((vm_param->reserved0 | vm_param->reserved1) != 0)", 
> > which could lead to a memory leak.
> > 
> > Fix this bug by adding a kfree of vm_param on the error path.
> > 
> > This bug was found by a static analyzer.
> > 
> > Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings, 
> > and our static analyzer no longer warns about this code.
> > 
> > Fixes: 9c5137aedd11 (“9c5137aedd11 virt: acrn: Introduce VM management interfaces”)
> > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > ---
> > The analysis employs differential checking to identify inconsistent
> > security operations (e.g., checks or kfrees) between two code paths
> > and confirms that the inconsistent operations are not recovered in 
> > the current function or the callers, so they constitute bugs. 
> > 
> > Note that, as a bug found by static analysis, it can be a false
> > positive or hard to trigger. Multiple researchers have cross-reviewed
> > the bug.
> > 
> > Changes in v2:
> >   -  Fix the same bug in ACRN_IOCTL_SET_VCPU_REGS.
> > 
> 
> Signed-off-by: Fei Li <fei1.li@intel.com>

For the multiple obvious reasons (not the least being you didn't even
run it through our normal testing scripts), I am not going to take this
change, sorry.

Fei, please be more careful in the future.

greg k-h
