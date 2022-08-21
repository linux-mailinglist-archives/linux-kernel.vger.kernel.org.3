Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5A59B287
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiHUHGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHUHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:06:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B4F18379;
        Sun, 21 Aug 2022 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rqK9MH6E+zyPNfoBb3WIh6sFDcqeUlOUtDbpiAGrdbk=; b=PE14Ru/1l5olhS26PFhijWSbP+
        iUTHWysuaFK63pKsj+GmDBY6F5fEWffZ+s5AF0zoP7UEVsZ/oJCW2Vh/1KRHlWZIgVAxqvZoy1MA5
        rIKU3o32lM0dHssNP5gD2WYYOsrHiDHLUk9EIndrU3aMWhoxyv3Ms04uD2//in9mnuZholjyz8aD6
        C5h4bG4LpJDMNlscLWmBTgQvkKkU+cczmjINAPf2R1bNHSV2378xQTNDWLjxJHTbPJYZ17CyEVtpm
        kKjloGqnDE+P3hD+VyU8lcbKP/3CDf2R+fTAH9RqVqWodGE2bKpM1Lm4gUxugP8TFhxocKnq0FlGz
        Y1lyY3ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPf2e-0078qZ-G8; Sun, 21 Aug 2022 07:06:40 +0000
Date:   Sun, 21 Aug 2022 00:06:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 10/11] sh: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwHZgE2RlMaBBhEl@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-11-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-11-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> +#define arch_ioremap arch_ioremap

Shouldn't this still be under CONFIG_MMU?
