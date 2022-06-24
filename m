Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71075596D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiFXJhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiFXJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:37:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354E79444
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Atd5LJgXzo1vZyeUf+/KGPTNYBq0h/PGUpmKMol4gKA=; b=CGjsvzJofFcrSPSXw0tb9JZiNv
        bAjIyAK0C8xhrporVTwUtjJ5S9Bhet9G683UECw5n0B3opQx6T6ZHqFCNqMKnGBAleljYNhSuSJ1k
        FkxD2OAGmBd8YmAkhX2R9OfQeeKFFw4fWJTbMcazC1ve4FxYYkJuxS0WL50NXpgrAQy67XeHl5Hcn
        TQOhio3h4WBwWNXowMO9xq8t3pYSeXD71b2O1EniUpw95+sXhct3/LUCWeeejxkQtsV/AMHua4Xwl
        QFoQddXjiHw8HAUg8s6PFY++qFbISJ7bK62hKaVa2Jd7wbObdueD+4y+fJu58hc31VC2hwWxBbmwM
        Fm/H6pnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4fkh-001SaQ-OI; Fri, 24 Jun 2022 09:37:23 +0000
Date:   Fri, 24 Jun 2022 02:37:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] watchdog: export watchdog_mutex and
 lockup_detector_reconfigure
Message-ID: <YrWF0w3mpYA//BX6@infradead.org>
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
 <20220614135414.37746-3-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614135414.37746-3-ldufour@linux.ibm.com>
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

On Tue, Jun 14, 2022 at 03:54:12PM +0200, Laurent Dufour wrote:
> The watchdog_mutex is exported to allow some variable to be changed under
> its protection and prevent any conflict.
> The lockup_detector_reconfigure() function is exported and is expected to
> be called under the protection of watchdog_mutex.

Please provide an actual function accessor instead of directly touching
a global lock.
