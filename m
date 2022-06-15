Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998854C75F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbiFOLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbiFOLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:24:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BC3BF8D;
        Wed, 15 Jun 2022 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BK8bIaaa2wq3VpZdMmSbQMojkUO+GHs4/AOKLZKBl7Q=; b=UB+Jljv2uYmYDQ6VXlacVbsXef
        dqTRZnATTAR/5b7GUWgSzE2FyUwMS4FTTKpvLECUeCtZ50iJ1WdKIYoleKOcawth62F9jFMifLH48
        PAt5nKttUO4No+iT6DksuV0nbb73d28QWyXshaWvgzjsMgR7Oiy/6VA9EiKsjGoL/SOxns4rzYxQj
        /nN7UlP7WD9hOWDF1/jaod4Gu888DPsfRrTbvJxkllsilOnIN5u15pb8xTD1Qgi4f4RZPzZZKC4MK
        QRVBML5IGUKiQeW7tocw75XsUZrep09UuxgSrXGIMzD7EXwzqK/rvezMjvOxA9v2PTZgTAzI7kpte
        P3e2OYXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1R8I-00E9lp-6L; Wed, 15 Jun 2022 11:24:22 +0000
Date:   Wed, 15 Jun 2022 04:24:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
Message-ID: <YqnBZhiLOHnoalbC@infradead.org>
References: <20220615084835.27113-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615084835.27113-1-jgross@suse.com>
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

I don't think this command line mess is a good idea.  Instead the
brand new grant devices need to be properly advertised in the device
tree, and any device that isn't a grant device doesn't need
VIRTIO_F_ACCESS_PLATFORM.  No need for a command line or user
intervention.

