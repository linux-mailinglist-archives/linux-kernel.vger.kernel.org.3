Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B815A3A2E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 00:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiH0WNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 18:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiH0WNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 18:13:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79931ECA
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 15:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D11AB807E8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 22:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8451BC433B5;
        Sat, 27 Aug 2022 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661638387;
        bh=4j9dWv3SalI9XL4QHA6egNN0lDV1LYcP+fce7U59F+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTkckR3QSqI9EkRpQV/OQuwsYmSdo2Z4DWMItgvPyVBMkFcsWh4PAmeYpAA4I5i89
         tMun4/ptY47kdq7YIcsFy2kYQ7u8QCRAQE3P1qNgDznZHGR6edqLLr+94FsUH8pAC/
         6hK0d4lnxyCUAbRCCKJFJ8T7IaEw1lE5NICP8M2Q=
Date:   Sat, 27 Aug 2022 15:13:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH -next v3 0/5] Delay the initializaton of zswap
Message-Id: <20220827151306.879ec27ea7314a543c5f60f6@linux-foundation.org>
In-Reply-To: <20220827104600.1813214-1-liushixin2@huawei.com>
References: <20220827104600.1813214-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 18:45:55 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> In the initialization of zswap, about 18MB memory will be allocated for       
> zswap_pool. Since not all users use zswap, the memory may be wasted. Save  
> the memory for these users by delaying the initialization of zswap to         
> first enablement.                                                             
>                                                                               
> v2->v3: Fix frontswap_ops NULL reported by Nathan and add init for online
> swap device in backend register.
> v1->v2: Change init_zswap to zswap_init suggested by Andrew.

Thanks.  Konrad, could you please take a look for the frontswap
changes?

