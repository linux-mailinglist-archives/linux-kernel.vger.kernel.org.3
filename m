Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93BD465635
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhLATRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbhLATRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:17:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF423C061574;
        Wed,  1 Dec 2021 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6e3Fc8TCwomnGDDJoRyOSPoVaIO/PWXmtwS4Ua1oLJ8=; b=MrRzYc8pioP2SYDopPzks8X4Au
        vp21r7DN/HiUI3SRiohDGrsSoWhchBu5qmvO4qrn9SlnWA0qdwnO1SPQL5oUH3SWqqjdqfDHeh9DR
        W4vbInD/4xUq/c9MSHpbgMmN7933pAI9TAeu5cIlqkbabubvMsSvxBIccX2N+kPWCrDIY5TRis0Qt
        8tM5KeDLH1M0ypP0xOno4WF3DvoVQ/p+z33xyOUdlwvVXP4WGBsig2rz3YMQjCtw/bMRHFHx81uJW
        3GNNVRJUnVbNIjzB1elPWtsOvSOeZjpmUyP8j3G40rcxOeTfY3oC+T1LjhhmYu4+BnX/Br+uRBuhd
        31pULHew==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msV2x-009vtT-VO; Wed, 01 Dec 2021 19:13:39 +0000
Date:   Wed, 1 Dec 2021 11:13:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot failure after merge of the akpm tree
Message-ID: <YafJY3rXDYnjK/gs@bombadil.infradead.org>
References: <20211130184622.71be17e0@canb.auug.org.au>
 <YaZPoEHL2svLLBwS@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZPoEHL2svLLBwS@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:21:52AM -0800, Luis Chamberlain wrote:
> On Tue, Nov 30, 2021 at 06:46:22PM +1100, Stephen Rothwell wrote:
> > Bisected to commit
> > 
> >   f00ff38c1dfa ("sysctl: add and use base directory declarer and registration helper")
> > 
> > I have reverted that complete 6 patch series for today.
> 
> I'll be trying to reproduce and fix, thanks for the report!

OK please try this patch, I can boot with this just fine on ppc64le:

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 70acd2a100fd..180adf7da785 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -201,6 +201,7 @@ static struct ctl_table _name##_base_table[] = {			\
 		.mode		= 0555,					\
 		.child		= _table,				\
 	},								\
+	{ },								\
 }
 
 extern int __register_sysctl_base(struct ctl_table *base_table);
