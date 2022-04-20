Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0936508075
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359376AbiDTFTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352624AbiDTFTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:19:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA0433EA2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5aJ4VSTNBoJHIuxjXyVo/HWsgabQBZYBF70E4FQjBKc=; b=rVovb28sjZdzotdLqYBUmKrItl
        WevqnWzjnJMvjjRQIvo56X4FgNT6+V8fNsrT3T3UUHktBLgtAEClc+kOAnpbT8azgYeRu5JUL5yKo
        xj9wwoiPowGhi9QcEujijWcjSuWsTKE86zyT76rae29/0ms1FMP5xKQEWQhyfoAwJ6I94swvUwm3Q
        3oc7jwYrDqkN+0a/4fIcwHo8pmgHSfuotxg5HzpPsePMKFKXeog8VW2zsrh9LtC1DuKe762Hwpk4/
        l6H6rFvxjwdyFHRp7cQxO6m+bfDMoT+rz6IYVmhA6Gvc5HEwx+PufElk0s0vmg4SW/8zeh2zu2m4o
        SIhOTCZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh2hO-007NNZ-US; Wed, 20 Apr 2022 05:16:18 +0000
Date:   Tue, 19 Apr 2022 22:16:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: use flush command instead of FUA for zoned device
Message-ID: <Yl+XIjiuFRN9Pzxv@infradead.org>
References: <20220419215703.1271395-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419215703.1271395-1-jaegeuk@kernel.org>
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

On Tue, Apr 19, 2022 at 02:57:03PM -0700, Jaegeuk Kim wrote:
> The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
> command to keep the write order.

The block layer can reorder all commands.  Given that FUA only affects
the command itself that should not matter.  What is this trying to fix?
