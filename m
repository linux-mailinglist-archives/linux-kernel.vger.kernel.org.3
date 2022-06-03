Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3153C520
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiFCGkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbiFCGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:39:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999538787;
        Thu,  2 Jun 2022 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/qB9gxrKGTNOzMJzvvVbgCLr/R5FGBh4VoOWfCq44ZQ=; b=KRj+Ey/Rr2SB20Q1D3iuLZQ1Hy
        IAK3MTi6/6h4lRiBTkT2Thew6/Qcuen9go+KyDHYEi3H4bUQbnZLvkvoPNoj374nfMu5b0iTxJX2o
        YxVAicmeaTegJg8GB7ovR3749ztwgYXnxNhsegHrStiYUaAp1+bIHLuBwAGL7tpuJkWiepuizANCh
        Z3b/WtbCv8Kx1mESKwIkG09wIvEeTXyYahyF62A/0+arRwhbd90u+YwXebhS30M0KQsPE8EAYd7Yd
        12YWe8dyZqrZg7UnPnq9XEslJkaSoq07sRx9v2whhK/RWO4mZ3vEHLYfIElplYV6L5MS7ZyaJ6HB4
        FQ2ZayNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx0yO-0063An-Gv; Fri, 03 Jun 2022 06:39:52 +0000
Date:   Thu, 2 Jun 2022 23:39:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v3 04/11] md/raid5-cache: Take mddev_lock in
 r5c_journal_mode_show()
Message-ID: <YpmsuIQhk+i8LShF@infradead.org>
References: <20220602181818.50729-1-logang@deltatee.com>
 <20220602181818.50729-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602181818.50729-5-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 12:18:10PM -0600, Logan Gunthorpe wrote:
>  	conf = mddev->private;
>  	if (!conf || !conf->log) {
> -		spin_unlock(&mddev->lock);
> +		mddev_unlock(mddev);
>  		return 0;
>  	}
>  
> @@ -2557,7 +2560,7 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
>  	default:
>  		ret = 0;
>  	}
> -	spin_unlock(&mddev->lock);
> +	mddev_unlock(mddev);
>  	return ret;

Using a goto out_unlock would be nice here to keep the critical
sections simple.  But even as-is this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> +	lockdep_assert_held(&conf->mddev->reconfig_mutex);
> +

.. but this looks unrelated and misplaced in this patch.

