Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1BA4FA5A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiDIHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiDIHsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:48:55 -0400
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E3BB8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 00:46:47 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 360b3d46-b7d9-11ec-8da1-0050568c148b;
        Sat, 09 Apr 2022 07:46:48 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 0087E194B3E;
        Sat,  9 Apr 2022 09:46:46 +0200 (CEST)
Date:   Sat, 9 Apr 2022 09:46:40 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: cacheflush_32.h needs <linux/mm.h>
Message-ID: <YlE54Cs0mi0WDPo7@ravnborg.org>
References: <20220409060215.19890-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409060215.19890-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, Apr 08, 2022 at 11:02:15PM -0700, Randy Dunlap wrote:
> Add <linux/mm.h> to cacheflush_32.h just as in cacheflush_64.h.

Just add a forward declaration like this to fix it:

struct page;

No need to pull in a header file when a forward is enough.

Maybe we could simplify sparc64 in a similar way, but that is another
patch and it may require extra work in other files anyway.

	Sam
