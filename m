Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D465398E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbiEaVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiEaVkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1AA73542
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8519B61384
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D5AC385A9;
        Tue, 31 May 2022 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654033233;
        bh=LP+1R1cUBOgcGWazwUCC1e4KihA9N205ZsMLBqH7mAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjPa68gOoTmBdt/Vqkgq304UPUbu/1zZFfLqGIJZqjxOTtpqN24LwMYPfBgEd8bHz
         rBlDFyt7h/BQSzR/h/vco5tmQU0IwXb9loR9AfYtb0AgMc/EsBTlKaMIirwYZ9ykaV
         mpHHZbLl0H6MjWdgm7AXfhL6h3Fy2QqKeZsjpgLGB32lviiy/d4TQmTZhgIUULQshM
         mSX9/VXZ30oXT0SM5edj6kvkioERX0KugjNIaD3LOcAMKojdXOn2gOFkpfLAr7kV8Z
         TzD1WFIPQPNhqjcKh4RfFMJXV0T/+MCKUhr61OyCFiNPW6hsR63jiigLMLdhXbh9ad
         9GDhCaFQ6Amug==
Date:   Tue, 31 May 2022 15:40:30 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
Message-ID: <YpaLTsAjOOBQhTM9@kbusch-mbp.dhcp.thefacebook.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 02:22:21PM -0400, Tony Battersby wrote:
> +static void pool_free_page(struct dma_pool *pool,
> +			   struct dma_page *page,
> +			   bool destroying_pool)

'destroying_pool' is always true, so I don't think you need it.
