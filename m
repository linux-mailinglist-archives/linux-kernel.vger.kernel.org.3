Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CAA58B48D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiHFI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiHFI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:26:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DA515A07
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k8UmK+Thqsvym4mmtink5O9lRMicTDQwBOnB8ntzrps=; b=jb4L7NzQF5zkPqeU+Qjhdlil9l
        jWDA+jLDufuAIg/c0LJ2QdMuzR8zKgafeyplR7sGzFLeohJqlpegNDMAJe+T5T1kshgv71WWbVRjV
        RAcq/4d3vF5SkVXFUbmkeQwOzM1/Sm569ey4NviOUs+Zn1vwZtsvBLIxy2APAgfgmeiw8EJPbhtZf
        BbtL+/QVTpp6bv/ntS9gvzXh6O4DO7K8tA5EmAruK0GbJGrK8bYQGuCnZ15vLSlnHw1i8a61l0k48
        onj82Y0+eZZIAm5hNuMqAUSlKFlaeEYsepYo5TnDEKhZlxcgDcRsP8eXmzTq/eTbcm3C8u+d6wY4O
        WvurDN+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKF90-006VN1-8e; Sat, 06 Aug 2022 08:26:50 +0000
Date:   Sat, 6 Aug 2022 01:26:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Gao <chao.gao@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        konrad.wilk@oracle.com, jxgao@google.com
Subject: Re: [PATCH] swiotlb: avoid potential left shift overflow
Message-ID: <Yu4lyhNFXRJjNc6Y@infradead.org>
References: <20220805114438.102085-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805114438.102085-1-chao.gao@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 07:44:38PM +0800, Chao Gao wrote:
> The second operand passed to slot_addr() is declared as int or unsigned int
> in all call sites. The left-shift to get the offset of a slot can overflow
> if swiotlb size is larger than 4G.
> 
> Fixes: 26a7e094783d ("swiotlb: refactor swiotlb_tbl_map_single")
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Can you just convert it to an inline function?  That will take care
of the typing in a much cleaner way than a cast.
