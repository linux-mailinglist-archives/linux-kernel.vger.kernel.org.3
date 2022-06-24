Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9911559225
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiFXFV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXFVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:21:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A24868020;
        Thu, 23 Jun 2022 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QYAP6IdYxL4kkP1mhFiWFjHH5BifnWV+2KXEJB5WN44=; b=vzFJlocgeN9Sn5a6VlqTMFsTGY
        spn+jb0ZGmZFBUPtgTeT5l3ETwKxU8cJw9juEpT490/JJZ8T84TkG9jSA1WN13ix1Rg/6JtCx7A6Y
        Qr5aim01kpLR8tF9eVuG4M3oLni2WsyOxRwUbkBurz8n3uAL8OPxWTHyPbZNlT0sCjd4abNX7GsQL
        k+ihqoWOlZdrzK8sGGb8Xw764sspo87RnfFrOiFIl3aO1VLj+Y4OI76Lc/+blZNDfJnhhwnPtzGsj
        Omz4DbGrmtJ6CuJeOcV6bqdsmqHsoyWJZkPQxsLlDnpY0lM8GjBxxjyIaableNzgWQSj/EPV39I2D
        97JcYzwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4blI-000aUe-MC; Fri, 24 Jun 2022 05:21:44 +0000
Date:   Thu, 23 Jun 2022 22:21:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        christophe.leroy@csgroup.eu,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Message-ID: <YrVJ6GaSzD/4kD6M@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <YrVHvv0spuMsC1In@infradead.org>
 <33bdac1e-207a-192b-bf43-818abfa49fe1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33bdac1e-207a-192b-bf43-818abfa49fe1@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:50:33AM +0530, Anshuman Khandual wrote:
> > On most architectures this should be const now, only very few ever
> > modify it.
> 
> Will make it a 'static const pgprot_t protection_map[16] __ro_after_init'
> on platforms that do not change the protection_map[] even during boot.

No need for __ro_after_init when it is already declarated const.
