Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7954DA55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358975AbiFPGKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358969AbiFPGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:10:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66802E9DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=67SdYKRUCeobi2/rHNNNfjGcSSgRdxZp6RN6GJ1fkCs=; b=UlZyMgJGdvNMa/vaSP9UiiWJaV
        A7KSO9MNTXWK+M7ozyQzazoFEwwZZzXwS2DOZmjiCC/yw8rJJoMjdy1zTygm5fD87bqefzSnNjwK3
        j+U9xLnGRGtwljMeGLNvyBx5Z43b43Ndz7WBr/0t1g2gvAo+qg0QWmgM5iCa2N38iaPuuRggT32Sa
        jvb0vl8mcLrcWYd6j8U3+euo2QgGuhFAj/UnAj+g3kSEWriecVG3IAgrHC2vs1ZgdlPHbHQh/z/5l
        ppPObL4YkMRNXiWHTyHeGW6MQeaZMrquluqlUJCp+fO3x+WQW6HWMSdrh2dXOUJz7ix2TT9CFdOnn
        2knwSArQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1ii2-000gnh-OW; Thu, 16 Jun 2022 06:10:26 +0000
Date:   Wed, 15 Jun 2022 23:10:26 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Message-ID: <YqrJUgwW/ycqffvQ@infradead.org>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
 <8819cd0a-4120-9afe-e491-2843681a0e7e@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8819cd0a-4120-9afe-e491-2843681a0e7e@csgroup.eu>
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

On Thu, Jun 16, 2022 at 05:27:15AM +0000, Christophe Leroy wrote:
> 
> 
> Le 16/06/2022 à 06:09, Anshuman Khandual a écrit :
> > Move the protection_array[] array inside the arch for those platforms which
> 
> s/protection_array/protection_map
> 
> > do not enable ARCH_HAS_VM_GET_PAGE_PROT. Afterwards __SXXX/__PXX macros can
> > be dropped completely which are now redundant.
> 
> I see some protection_map[] are __ro_after_init, some not.
> 
> I'm sure several of them could be const as they are never modified.

Yes, most should be const as they are never modified.  A few have init
time modifications and can be __ro_after_init.  If we actually have
any that are modified later on that is a bug that we need to look into
with the respective arch maintainers.
