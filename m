Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22BA5553E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377356AbiFVS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiFVS7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC012E0B3;
        Wed, 22 Jun 2022 11:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4639261D55;
        Wed, 22 Jun 2022 18:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59DAC34114;
        Wed, 22 Jun 2022 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655924370;
        bh=QQ6cuo8RAZmbdEridoZ6FW1VaSlmNyzCEQ2IWmydrZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0B7D55DYDaSLRTKdFR6id2nhj2h3mTjIemRLAhadA4QcFGmJZz9h5CYOCk/opCWk
         zREnGfkqG/Vx65TSSBYVQ3w8SsRrk4w7UQoYnOfJDs+5TFWM8Y+SbTpaQikwGyZ0dG
         gIluXlq+P9vA3WDqZ4jAlpX4vqCAiteNB6bJPuhA=
Date:   Wed, 22 Jun 2022 11:59:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with the folio tree
Message-Id: <20220622115917.5268aeea70b22a566c90be8c@linux-foundation.org>
In-Reply-To: <CAMZfGtVQr=7pUevVbbNK9teskfGsjcoif2sfHQ-YrDx5qHNiXg@mail.gmail.com>
References: <20220622153815.6f2e671a@canb.auug.org.au>
        <CAMZfGtVQr=7pUevVbbNK9teskfGsjcoif2sfHQ-YrDx5qHNiXg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 15:22:35 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> > Today's linux-next merge of the mm tree got a conflict in:
> >
> >   mm/vmscan.c
> >
> > between commit:
> >
> >   15077be8badc ("vmscan: Add check_move_unevictable_folios()")
> 
> Sorry for the conflicts, I didn't see this change in the mm-unstable branch
> yesterday. Based on this commit, I have reworked the following commit
> (see attachment, mainly changes are about check_move_unevictable_folios()).
> Andrew can pick it up if he wants to replace the original patch with
> the new one.

Your comments in
https://lkml.kernel.org/r/YrM2XCwzu65cb81r@FVFYT0MHHV2J.googleapis.com
make me wonder whether simply dropping cca700a8e695 ("mm: lru: use
lruvec lock to serialize memcg changes") would be best?

