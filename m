Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C215AFC12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIGF6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGF6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE2895DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A292D6178E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B24C433D7;
        Wed,  7 Sep 2022 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662530328;
        bh=naZK0v57e74Q3v48EfjiO6fCp+pAZWwJm7kyEpVCtDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qu4AL0XiHCS4ZnKtz7us7wvHtTde8+59XSouRmqEARt+4HHqvpfCNM07r/RG8N+jp
         CpYCDzlFmRNhzM+EfkeIGNP+l1h7RDmbNDbxdLUY1K/wi/qFRW8FVMCMdZay+UMU4b
         FeDzz/Sz89YDWxaAUFpxrU8qay6hFs6nG3YtJqzY=
Date:   Tue, 6 Sep 2022 22:58:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] secretmem: use ATOMIC_INIT() to initialize
 secretmem_users
Message-Id: <20220906225847.255b4f244105b9b66b713857@linux-foundation.org>
In-Reply-To: <20220906093620.243465-1-xiujianfeng@huawei.com>
References: <20220906093620.243465-1-xiujianfeng@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 17:36:20 +0800 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> The variable secretmem_users is of atomic_t type, so initialize it
> properly with ATOMIC_INIT().
> 

True, but there are many many cases where we initialize an atomic_t to
the all-zeroes pattern.  So many that this should be considered
acceptable practice.

