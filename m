Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA554F8D67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiDHGI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiDHGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:08:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C2B8999;
        Thu,  7 Apr 2022 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DwjOdyHwSk+QeVDvV8DYNR69dAuxGNJilx3j3wHoA44=; b=3/+DTTq1VHD0GGWkFuZbAwBwDP
        2+djqMLbj2XGpCykEA95XbzSRz4WTg2b04a+koULhJR+0ifnxhlNGhaTjWeX18J2EivFM0odAJsMn
        WIOv4KaYx3OOhLVWRw6aoYzEphCpBVPLkiG6RE2ZZ9s/J1PjMpc6LaKQLsUfmh9QS1NNeiTK4h9Fi
        6gH6gK8UXKeCXgnu2cYoeQ5OPoFxqHrAtTE9AJutJoTmkT26oaoieCPksfZBM7vVhUbhC3+Xg4njv
        wcANgTiLucMDrqB/xAnxdN6sXq8MperPRahswronAeiZQtcYs21R56eevzc1Ve7W+8/IGztcVLtjb
        vBom1ekQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchlC-00FEGF-US; Fri, 08 Apr 2022 06:06:18 +0000
Date:   Thu, 7 Apr 2022 23:06:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v1 2/7] md/raid5: Un-nest struct raid5_percpu definition
Message-ID: <Yk/Q2uYnp9jNbjB1@infradead.org>
References: <20220407165713.9243-1-logang@deltatee.com>
 <20220407165713.9243-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407165713.9243-3-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:57:08AM -0600, Logan Gunthorpe wrote:
> Sparse reports many warnings of the form:
>   drivers/md/raid5.c:1476:16: warning: dereference of noderef expression
> 
> This is because all struct raid5_percpu definitions get marked as
> __percpu when really only the pointer in r5conf should have that
> annotation.
> 
> Fix this by moving the defnition of raid5_precpu out of the definition
> of struct r5conf.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
