Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589FB59270D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiHOARz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOARx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FA11A33
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB2EF60F22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4757C433C1;
        Mon, 15 Aug 2022 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660522672;
        bh=1asjCdG2YjeCaG6oCo5BXz+9uNtqjJ1F5D1TkIiGuOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nBClIhA5cHZDJ9j5x3vyso3d6VXaxu4thzAY4HdiugFYbzG7vrh25SMcRQKKFEDFF
         GHZBvZcsL5TYxY7fHw9BKpiMFczLvMMZxLaywLXFaKoD8aqlHhvVl2137iRYf0etIY
         /+x7FLmZg3RTiPSPgwBOx7J3V0zvFQYfJE4+f6a0=
Date:   Sun, 14 Aug 2022 17:17:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chao Xu <Chao.Xu9@zeekrlife.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: remove duplicate mm_types.h and unnecessary declare
Message-Id: <20220814171750.858b89dca1042fd46ec2fc94@linux-foundation.org>
In-Reply-To: <20220727151527.8054-1-Chao.Xu9@zeekrlife.com>
References: <20220727151527.8054-1-Chao.Xu9@zeekrlife.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 23:15:27 +0800 Chao Xu <Chao.Xu9@zeekrlife.com> wrote:

> mm_types.h have already in page-flags.h. Duplicated import
> header file and struct page declare is not needed.

It's better to (as much as possible) explicitly include the needed headers,
rather than reply upon nested includes which might change in the future.

This isn't theoretical.  We regularly get build breakage when rework of
one header exposes unexpected dependencies within another file.
