Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8A4D4225
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbiCJIF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiCJIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:05:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043D6BDCE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6fZFRDk00Q3zeigqRio4keAMEWWmRAGUJBzI3wc4vAQ=; b=W3yXoQrHVgRBgOuCkBpPB/gz8i
        hHpRH4Vk+apWrTyQskw2y87v/nbjZdjLg7oC7wtFJqhUstYc7xgq0y+HAisvh8mnqBSDKqAXTESYr
        2K2IfYS/ep4DZGEZ17uWrOuPOnjFFATpZVvLNTql1Puws/3qju2vWtYYV43zWXtMIePBH8RjcWpyP
        JOLOzsreGgH4Og22imza/oRbwSeqF2JvHJ9NX6bBauUPEKKHimWfhfq22gF2X7w7nJoIwFt487WPf
        Qn3wzRhRFI43Gwij7BVkwIRzfoiKsXZQLal43/RREx+fvK3fHmkG5X7FBgr4OuD0snuAW5Yaq9UaQ
        gtz59HOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSDn0-00Bptl-RQ; Thu, 10 Mar 2022 08:04:50 +0000
Date:   Thu, 10 Mar 2022 00:04:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@infradead.org>, michael@michaelkloos.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the
 M-extension
Message-ID: <YimxItxjPsPTXeub@infradead.org>
References: <YimjbmdACoQOk+hj@infradead.org>
 <mhng-08a28047-b563-41f4-b705-f27b88554f2c@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-08a28047-b563-41f4-b705-f27b88554f2c@palmer-mbp2014>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:34:25PM -0800, Palmer Dabbelt wrote:
> If someone has hardware that lacks M and users care about running Linux on
> that then I'm happy to support it.  I'll still point out the silliness of
> that decision, but if it's too late to change things then I'd rather support
> the hardware.  If it's one of these "fill out every possible allowed ISA
> flavor, even if nobody has one that runs Linux" then I don't see a reason to
> bother -- there's an infinite amount of allowable RISC-V implementations,
> we'll all go crazy chasing them around.

It's not like Linux had required M mode since the RISC-V port was merged
upstream, so any new implementor really should know about it.  And
performance on anything that requires Linux will just be horrible.
I could see a bit of an excuse for a nommu port.

Anyway, this kind of patch really does need to state the why.  And it
better be a really good reason.
