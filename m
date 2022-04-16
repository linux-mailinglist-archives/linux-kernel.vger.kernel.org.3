Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E4503462
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiDPGJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPGJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:09:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175865404
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7q55fBD/If1zhZdmpRrkJ8LAPojnNiIN0sEvE05Ctwk=; b=cMcvUoLF9t8i+WPX8nbPrHKTpU
        B06E6ECDKRBlaNNA7/4Q6dRDnLjRFGOUX8wd8Q2KKhjuHBLFPV9+Zue4ho9wVEB6RS30D1zBioXtt
        V+Lp1o4dTv5oHaBbZVlDVRCWQUwOi4y++6lq9CNFsRHkBUsaMwrJ7yHeIh4axcp/jLCE81Q+dkQXH
        6UwiBQxst4/dOqKM6Sf62txqv0VdU6kGjqWXmReVZcuCiaXZJC0kVaZ6qvGpFR5T8y5tPNfSVSm4b
        OXEoHMu6B0oPLJmJynm2f59ZyjZEkOocBrfRZD/q2Q/YyYMduY3sFwU4R8BNOZYm074q3ByEG86ZA
        ROsKlu+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfbaG-00CK5x-5f; Sat, 16 Apr 2022 06:07:00 +0000
Date:   Fri, 15 Apr 2022 23:07:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
Message-ID: <YlpdBHKT1bYzZe2e@infradead.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
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

On Fri, Apr 15, 2022 at 03:02:45PM -0700, Stefano Stabellini wrote:
> This makes sense overall. Considering that the swiotlb-xen case and the
> virtio case are mutually exclusive, I would write it like this:

Curious question:  Why can't the same grant scheme also be used for
non-virtio devices?  I really hate having virtio hooks in the arch
dma code.  Why can't Xen just say in DT/ACPI that grants can be used
for a given device?
