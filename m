Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31C852BC10
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiERNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiERNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:00:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A01A6AE4;
        Wed, 18 May 2022 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6rvVpjtewErevwtzxVWgKanKatH+lil9XQiGaNTaboY=; b=ThnAz/oFIZap4IArJner1pmcW3
        6MJb8LhZ5nlzG/AhKU5YUmwufgHp2bWyyb94yxcxXrUBTN7Cl0dmA2z8CKpyzIK8v7TkyezC8WKNP
        p4BAlJjvwr25/AOq/K3pzMeuO66nCKb7HsqmmbeQtweeDVpo+my1JeYHtcVeuNXIzNV1wVA5LVb5o
        6IoZcDm+xiE6JtFyotUMSu++E2VWulFO3SodIndd8ca0TPhnop8eZO2XeBJR+m96h41AWDR0iv+y0
        ELyJaeXYcmM7NBeIeWyQVoyNbNex/DPS2tNs3gXLZ9tQfqQMbbiHixzQycBM9ELWJsqZeII6s0y3p
        CacIyhmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrJHs-002CUG-Vm; Wed, 18 May 2022 13:00:25 +0000
Date:   Wed, 18 May 2022 06:00:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, maz@kernel.org, axboe@kernel.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com,
        pavel@ucw.cz, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org,
        tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_svaddagi@quicinc.com,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: Re: [RFC 2/6] PM: Hibernate: Add option to disable disk offset
 randomization
Message-ID: <YoTt6C5ymvmMcmWw@infradead.org>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
 <1652860121-24092-3-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652860121-24092-3-git-send-email-quic_vivekuma@quicinc.com>
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

On Wed, May 18, 2022 at 01:18:37PM +0530, Vivek Kumar wrote:
> Add a kernel parameter to disable the disk offset randomization
> for SSD devices in which such feature is available at the
> firmware level. This is helpful in improving hibernation
> resume time.

This patch just adds a global variable which is then entirely
igored.

But the idea of "randomizing" offsets on SSDs sounds like complete BS to
start with.  The whole job of the SSD is to remap from a random writable
block device to difference physical blocks to deal with erases and wear
leveling.  In other words it really doesn't matter what offset your
write to.  That being said I could not actually find any code that does
this randomization to start with, but that might just be my lack of grep
skills.
