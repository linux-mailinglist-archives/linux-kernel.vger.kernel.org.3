Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D74DE01A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiCRRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiCRRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:42:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B16197AF1;
        Fri, 18 Mar 2022 10:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4B7FB824F0;
        Fri, 18 Mar 2022 17:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C420C340E8;
        Fri, 18 Mar 2022 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647625257;
        bh=y1kSwAeyUIPDD0WUz6meKPi7vm54XPFekIW69rri3cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCL2ClCbITt12Y9eqokJetjwA0tRnCwNDm412G4Ql1rs+kWvAlzVKXsC8JYDGSL6N
         U95VkEqvnmbPNsg70bQc3bXxthHOUgXO69AT6NvQY4n1qkVYJ9GG//g5fduPgexaPE
         0GZszFFZisqQiqD2OYD4MfVPlOx/c5HSdQS1g6vgGdX6g+HWh44YlOR81IrVV1mpVu
         WIvlIaxL+7EE0zpw+10uHxyJxhabj6naed5nh4COB+flhrzzD/0ZxLE5Ceryx4Jyrh
         vlVvBagxU0tJXKlRUdk78I8efZb7AM7NXI1xG8GhoEHVadnigj7Y9fV0kwk6Jynhgf
         FReVWA2JgrjHw==
Date:   Fri, 18 Mar 2022 11:40:55 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] nvmet: remove redundant assignment after left shift
Message-ID: <YjTEJx2Uk2RN1+p5@C02CK6Q3MD6M>
References: <20220318013014.90698-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318013014.90698-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 01:30:14AM +0000, Colin Ian King wrote:
> The left shift is followed by a re-assignment back to cc_css,
> the assignment is redundant. Fix this by replacing the <<=
> operator with << instead.
> 
> Cleans up clang scan build warning:
> drivers/nvme/target/core.c:1124:10: warning: Although the value
> stored to 'cc_css' is used in the enclosing expression, the
> value is never actually read from 'cc_css' [deadcode.DeadStores]

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
