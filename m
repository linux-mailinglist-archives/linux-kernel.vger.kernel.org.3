Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC954B1E96
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbiBKGeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:34:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiBKGee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:34:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4FBE56;
        Thu, 10 Feb 2022 22:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wmT7NdpIIaZIZ4RJN8MppwRUgJ7HrGVSC4APn17UeMY=; b=29czAqJRGXG9/3d5XsS3Qn5xPf
        msIroF9kN5cnhhZVwC1VEpMYxztAzu1w/QoGaORO9AXhwrQe3iWqmu1mjrO96HH2IGf+78L9I1Y/e
        uZLVt2DNRlf69kviZF0Ma3rimb3FJwKlx7aNodiI0EmLI13WwMokZVpM7Bgvib9L+I1yVXpIf/0bQ
        N5qs8K2lzHviDpdOG8zebJc+reU+Ku7krq5ulnVBeYjeZipiricP1UYVBV15nj+oSC6+J9VzCgUuV
        t7+rQ1LJz66kZsUg2SDPckzpjChVwEs6GM33uzdUlnsWXdKnTrwZPt+IPiXkxYStH55wVdTBp5wDG
        J4g6aMEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPVo-005zmJ-3R; Fri, 11 Feb 2022 06:34:32 +0000
Date:   Thu, 10 Feb 2022 22:34:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH REPOST] irq_poll: Add local_bh_disable() in cpu_dead
 notifier
Message-ID: <YgYDePJLsVLXKqEP@infradead.org>
References: <YgJ/XWVxxWDVBBVA@linutronix.de>
 <YgNzsnIE9bwQZ1Zg@infradead.org>
 <YgUGI9qAKUh4AOUY@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgUGI9qAKUh4AOUY@linutronix.de>
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

On Thu, Feb 10, 2022 at 01:33:39PM +0100, Sebastian Andrzej Siewior wrote:
> You need to handle the pending softirqs. If you don't handle them
> immediately or in a deterministic say (like on IRQ exit) then they will
> be handled at a random point.

Yes.  Just like regular interrupts.
