Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A7509757
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiDUGSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384807AbiDUGRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:17:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA413DE1;
        Wed, 20 Apr 2022 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QeRKGkvFLelyG9rKu/uS3aYOVkHHkLrkP5MDRe1pwmg=; b=wiDd3TG/zR4xbQ1k1sNrzkbJbt
        d4A3NhDoa+q1NV5tCat1rp+GtM7uVB731PtAaP8cNQSeY7u8opVortfQMfJIvOB98JVz0XVMIl+DR
        HfKoAjIMyk7VQF41j6kAWBmSP0XMha9IVXyGvi+ATAm+2QIBGTZZFWwYZLOKSxAE4KX8ppuQRcgQ8
        6ji+2FJPZjdxcFlUND26o10iUJFvXKJ+HO93+/qtWC44SpitrmFiRe7GhIQHg/9oRGL6nJt7Nr6hP
        8dinfSHCnSYtFh7Qm7TFIClOsSUT4SRFSH+gpd+/DBSqZX3qsGZMJ1Muh+SFP1yZKG18U3ZN346LC
        CRtS0bWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQ5H-00BeYW-SX; Thu, 21 Apr 2022 06:14:31 +0000
Date:   Wed, 20 Apr 2022 23:14:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 05/12] md/raid5: Factor out helper from
 raid5_make_request() loop
Message-ID: <YmD2R0AJ54yPRZhR@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-6-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (unlikely(conf->reshape_progress != MaxSector)) {
> +		/* spinlock is needed as reshape_progress may be

Normal kernel style is to stat with a

		/*

line and to captalize the first word.  (also applies for a few other
comments).

> +		if (must_retry) {
> +			raid5_release_stripe(sh);
> +			return STRIPE_SCHEDULE_AND_RETRY;

The raid5_release_stripe cleanup is duplicated a few times.  I think
using goto based unwinding would be hepful in this function.
