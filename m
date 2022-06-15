Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD354C780
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347186AbiFOL3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347562AbiFOL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:28:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3843EFD;
        Wed, 15 Jun 2022 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ffs70zIAEPDoQR7c4GQM9h5KRYBlcReN8DDYbmuklWA=; b=eVx0xL+TUT9/UozlSGm3BSao4r
        t4A0k50rGvMY5v0y2l2Lu7kInP8Iuuw2lNBBwjXDQve2/BETf31KEI5uWFKraX1UBrrTHQVr9EObw
        MqIxPKjQMHg2b1n6EvewXsvzMTYm15xPMYAnWZ4KXYnarus+p5ywQRg6pwLgh9jcmoX/cfUML8z0A
        wTkEwU+8XR/zRJXGSR1suj47ftkmSZPxPcpjkOcB4FnubiT1DhUT0LpHrm0vdP32doAJvmx5DkMqb
        9L8oBwaINGC5njlF/BxW0fMQy+3UFXFkTvMhDiK3hApgX19XsumxnSJEFRqzfiU55vd0wyBpOzK3a
        sV+lQJXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1RCR-00EB1m-Bb; Wed, 15 Jun 2022 11:28:39 +0000
Date:   Wed, 15 Jun 2022 04:28:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
Message-ID: <YqnCZ+EKZeZ5AEnr@infradead.org>
References: <20220615084835.27113-1-jgross@suse.com>
 <YqnBZhiLOHnoalbC@infradead.org>
 <9b9785f5-085b-0882-177f-d8418c366beb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b9785f5-085b-0882-177f-d8418c366beb@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:26:27PM +0200, Juergen Gross wrote:
> On 15.06.22 13:24, Christoph Hellwig wrote:
> > I don't think this command line mess is a good idea.  Instead the
> > brand new grant devices need to be properly advertised in the device
> > tree, and any device that isn't a grant device doesn't need
> > VIRTIO_F_ACCESS_PLATFORM.  No need for a command line or user
> > intervention.
> 
> And on x86?

ACPI tables or whatever mechanism you otherwise use to advertise grant
based DMA.  But that is irrelevant for now, as the code in mainline
only supports DT on arm/arm64 anyay.
