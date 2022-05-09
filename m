Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309A551FB55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiEILeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiEILeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:34:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA87A1D2FCE;
        Mon,  9 May 2022 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Qp60fjaH432wSsrjBdzucmsGuUGlPT7M8ehJp5svCQ=; b=l+zaoFZFhtXgoRQOqkDfYTiCjz
        Tr0WZdiPIQzZ6ScfuCWMCGWSvvFpVonRZiq6VcHt4sC4VCUJk7MHkcsce4Cejs2SJKsHKUbStu8qh
        lyEvpivJbxNOOdD6lQWh2jUqfY7WlGpQTMO/aMg5zOwWrQemJ1vIZxpXVlvXirRSRoSkYATU4ZMBu
        PzJ//zL6cSefV/qH+OYVn9nNkZgs9awICReZsJC6gqJytVf3DFOhumUFUUKnHQmuvXBZJsOsTa2Bn
        CbkqnTlS3NmFj3xjMyUiXPNPHuFgrXVUieCV25I+xXAOdmvHmTBzMnhHKvxL8zQ/s3FqaI7TH7vLv
        HdZl4L5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no1ac-00E6ow-G3; Mon, 09 May 2022 11:30:10 +0000
Date:   Mon, 9 May 2022 04:30:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daehwan Jung <dh10.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [PATCH RFC v5 6/6] usb: dwc3: dwc3-exynos: add host init
Message-ID: <Ynj7Qt6PpWM1KFYG@infradead.org>
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220506063340epcas2p4c9d88670f9be952f3637e3a545a7d1da@epcas2p4.samsung.com>
 <1651818679-10594-7-git-send-email-dh10.jung@samsung.com>
 <584df17c-3ffc-4290-a2dd-c803987dccfe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584df17c-3ffc-4290-a2dd-c803987dccfe@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 08:45:39AM +0200, Krzysztof Kozlowski wrote:
> On 06/05/2022 08:31, Daehwan Jung wrote:
> > This is for xHCI Host Controller driver on Exynos SOC.
> 
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> > It registers vendor ops before loading xhci platform driver.
> 
> It does not explain why do you need it, why do you do it, what is this
> going to achieve or give us.

Nver mind that the whole concept if "vendor" ops doesnt make any sense
whatsoever, as I've repeatedly pointed out.  The "vendor" is completely
irrelevant for a Linux driver.
