Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0884FFF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiDMTbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiDMTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:31:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E775608
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9BA2B8276E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0C1C385A4;
        Wed, 13 Apr 2022 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649878107;
        bh=KfuSlyE1Z5VblHuvIYYUHgpgwRqcjLvXRY0q5P7T52Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UhglDxe97PIX9nMF7wv1SmFiymZ/cqXvd0dgEdMWBnLtRRNwPv7tPttnZl+u4Y9Uo
         0b1oGxWzdp6pH1h7fgLbLcpYlfzj1UHoYB2wfJVhfsYBXn41Kdqr0+vbC+XzIzkcJD
         KKeIyUjY148rBOoOzwakAm5zzAPbSWKVgcY/VhZg=
Date:   Wed, 13 Apr 2022 12:28:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmemleak: take a full lowmem check in
 kmemleak_*_phys()
Message-Id: <20220413122826.792a859d90b6c2822b1c796a@linux-foundation.org>
In-Reply-To: <20220413122925.33856-1-patrick.wang.shcn@gmail.com>
References: <20220413122925.33856-1-patrick.wang.shcn@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 20:29:25 +0800 Patrick Wang <patrick.wang.shcn@gmail.com> wrote:

> The kmemleak_*_phys() apis do not check the address for lowmem's min
> boundary, while the caller may pass an address below lowmem, which
> will trigger an oops:

Do you believe this fix should be backported into -stable kernels?   
