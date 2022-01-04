Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB9483D22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiADHnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiADHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:43:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F441C061761;
        Mon,  3 Jan 2022 23:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pqTPWf6iPV5Bcx2RGttdJKfervIMBZINiE3d6Dre1UE=; b=UiD/ThU0k7Ho9RkVpwrfHvJjBB
        NrNVafQaMmlB15cuWymH9tSZqUDNcBd01kj4rTVHVicgGaIRSIxBsJU/EsArulWjI0AOilOxh6v73
        3HpW1b91giViGSLnL0uuRqz72s1va8xB8Q7T2ZWkoWBjV3QEF7ywbbUtpv4d5LLonV//nKAoN2LwX
        h6bgc9FW3Ymy5TKet706IPBo1Ut8MeSy5RArNf75sKlVrHkwcViqmGGcR0FzX6a5LCTWTG8p9Wpqj
        Oi+G/6hXPeM2s85cZNvyU4QyGYs75Lso6dV7lBhpXOZ68aMXJlEP1/Q/VIVAqEQ8mjmT7l72Zpz3I
        YNidTf5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4eTr-00AXfk-72; Tue, 04 Jan 2022 07:43:39 +0000
Date:   Mon, 3 Jan 2022 23:43:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-rdma@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
Message-ID: <YdP6qx0G7ICcBu3f@infradead.org>
References: <20220102070623.24009-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102070623.24009-1-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yikes, this rdmavt code is completely fucked up and a very good example
why people should not use __user casts or random internal helpers.

The right fix is to remove this crap entirely, and if the rdmavt
maintainer think that they absolutely need a non-temporal memcpy they
need to work to add a core API for it.
