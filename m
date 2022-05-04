Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498AD51AFF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378456AbiEDVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiEDVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:03:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB34CD5F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=ZH0+gkBXZopimra8SObfLC2yiFbKfN4e2FbQtTyV6l8=; b=fUE1ohMkrlTBUYHw7qPWcEJF4o
        WtNt6e4R6k4TmyTKvJxrmzbigEdizYt+T+Un+ugfg9EyLQvUeh8ktc+thK9fvcyI2fEQIUzR7a23o
        0LFQc6OLzBkcQsYpcmiup5wH6KjIETUHqpMfsUUyZ+1innpXm0An3HIWvycCozyD7Rfx5bk3CBykX
        AhFI4dS//Jkp/jcIJaRiWiWck7I8DUCdbMK+s3UZSmEG+FokYpz/ejtjXirOJxqaSW6F1yTCiQtjz
        eiN+5qZp6DdBobo2rlb5E+97W8PR2+zajPmY8rT71f2KvokXr0W/P6qwgj2J2w+UJwdRSWfgiGiTv
        +JTwuFiw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmM5a-00Chd4-RW; Wed, 04 May 2022 20:59:14 +0000
Date:   Wed, 4 May 2022 13:59:14 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tangmeng@uniontech.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sysctl-next] reboot: Fix build warning without
 CONFIG_SYSFS
Message-ID: <YnLpIvXoFrCwnXTy@bombadil.infradead.org>
References: <20220427125401.28868-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427125401.28868-1-yuehaibing@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:54:01PM +0800, YueHaibing wrote:
> If CONFIG_SYSFS is n, build warn:
> 
> kernel/reboot.c:443:20: error: ‘kernel_reboot_sysctls_init’ defined but not used [-Werror=unused-function]
>  static void __init kernel_reboot_sysctls_init(void)
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Move kernel_reboot_sysctls_init() to #ifdef block to fix this.
> 
> Fixes: 06d177662fb8 ("kernel/reboot: move reboot sysctls to its own file")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks! Merged and pushed onto sysctl-testing. If there are no issues I'll move
it to sysctl-next.

  Luis
