Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F855442E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiFIFHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiFIFHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:07:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BA56222
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=acG/hWi7Fz9ui2xVxpMoGeBP7vrmuNMLdX3ejzV7aPc=; b=MZhm3nf6mKFSlcr8dK8ijoBLa2
        MBmpr98pFWNa8b6ut+XZouG4H5T08bSJ23S8eyxslIMTr4C/O2zuvnG2/qsMxG0x37tmaxvgijfIb
        lGXyW4Q+2Io60XdLfGcV4rp/RIywa2u5fO9NieV0COBKOJzrFJhvVfmdj+5pSGWt/lb4HHj77Z/qa
        w661jXNSO/l+LgOue5Ca0yCP7G8O+ptXdbp8dSD1Vzdtm86SSvktBkKXYdbPsB22/xE+l3YTcUINL
        9HMTg+plhTcoM0gRCPZ1oapj04vRnOV9EHBOaOpaoHqGEW+z8Mh7/21uIp1vsKiXFvwHo2LUpgWRB
        KVKRCt6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzAOE-00GnS5-8r; Thu, 09 Jun 2022 05:07:26 +0000
Date:   Wed, 8 Jun 2022 22:07:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        m.szyprowski@samsung.com, jgross@suse.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        sstabellini@kernel.org, mpe@ellerman.id.au, konrad.wilk@oracle.com,
        mst@redhat.com, jasowang@redhat.com, joe.jin@oracle.com
Subject: Re: [PATCH RFC v1 7/7] swiotlb: fix the slot_addr() overflow
Message-ID: <YqGADnHAP7HYPvRr@infradead.org>
References: <20220609005553.30954-1-dongli.zhang@oracle.com>
 <20220609005553.30954-8-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609005553.30954-8-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:55:53PM -0700, Dongli Zhang wrote:
> +#define slot_addr(start, idx)	((start) + \
> +				(((unsigned long)idx) << IO_TLB_SHIFT))

Please just convert it to an inline function.
