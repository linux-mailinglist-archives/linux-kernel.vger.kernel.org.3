Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B393857E41E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiGVQIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiGVQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:08:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827BCE12;
        Fri, 22 Jul 2022 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mVumerM2BtpAjoiQzG3zHpPKgPxLzaYLQdBiSPXzBcA=; b=PDQeY5gz5Bxkz8IKg3LmyXVXAH
        AjJDRc/XfslgoaC1Q83GHu5meqbqg59CZqBsKENHVYDZ+D3FL6OWpjRp9d/JAorSixJFqHqQsbUBB
        QoY0TXwc12SVg0RTQsThq6jk08psM7DN/l9zZR3MmnfgplAIEQFIhfm81tXLL01fEvQ09zRn4toCA
        X2/DNFPu4psDhUTRjR27exzdgH5aGZJsqm7yK486AXX0XP/Y1iIoX1cc0g9c+8R++vxVFXUsobQ8g
        mvrDpc0PuX1Buu0G0Em0ZvFcWzQdAp/dny4bDjxpzCKna7cYkXpJFDjMu8atLdxTGkb+F3v4+xrJN
        YeyVmLZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEvC6-007lQI-QJ; Fri, 22 Jul 2022 16:08:02 +0000
Date:   Fri, 22 Jul 2022 09:08:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: avoid potential infinite loop in
 __blk_mq_alloc_request
Message-ID: <YtrLYiJFlqL64voT@infradead.org>
References: <1658467343-55843-1-git-send-email-liusong@linux.alibaba.com>
 <Yto2sHfyiJITgYAn@infradead.org>
 <eb99b420-3e28-98c7-dacc-767d564661e2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb99b420-3e28-98c7-dacc-767d564661e2@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 04:15:49PM +0800, Liu Song wrote:
> It is a reasonable approach to prevent abnormal alloc from going down,
> but this is a very rare exception after all, and above modification is
> checked
> every alloc request, which seems to be a bit excessive overhead.

Every allocation of a passthrough requests.  Which isn't really the
normal fast path.
