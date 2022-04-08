Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5AB4F8EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiDHGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiDHGAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:00:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F5F2D9A1D;
        Thu,  7 Apr 2022 22:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fVIoAxn12PdxzuZvdoPtbIsVBecGZngbVKbs08NDtPg=; b=poQey1Jx+AA6sONlhvostPmZ2e
        XzOspUSmgCagrUwMBP7a6xFEUEb8oEF7sf4EvGy/Vf1Jzan/DkvcgFKQSZ7MzEvOJmxt848R336I/
        TyWhEslxxwNeawfl8HXjKgx0gNUgNecToWKIjhG8l0p+OHwNbpoSH7C+kBd5z3c/tyflS82mpFZ4z
        PYJY5HruVLMJs/EFCsdbOp95b1XtzJKYLRL+HI2RuKTThZbceBrzsbqAGrQh5GTRvonzqxMsS2q0P
        gRrRcWx8lixG5hLUHDtplweNDKfznk6barELQO7pgLgMre8XNdd55yS9I6VGY09r+ePE3H5GdgbsT
        jUCnTUZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchdx-00FDbE-FH; Fri, 08 Apr 2022 05:58:49 +0000
Date:   Thu, 7 Apr 2022 22:58:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v1 1/8] md/raid5: Refactor raid5_make_request loop
Message-ID: <Yk/PGeQDgz/rCfOz@infradead.org>
References: <20220407164511.8472-1-logang@deltatee.com>
 <20220407164511.8472-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407164511.8472-2-logang@deltatee.com>
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

On Thu, Apr 07, 2022 at 10:45:04AM -0600, Logan Gunthorpe wrote:
> +			spin_lock_irq(&conf->device_lock);
> +			if (mddev->reshape_backwards
> +			    ? logical_sector >= conf->reshape_progress
> +			    : logical_sector < conf->reshape_progress)

Normal kernel style is to have the operators at the end of the previous
line (and the whole reshape_backwards handlign is ripe for a bunhc
of well contained helpers).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
