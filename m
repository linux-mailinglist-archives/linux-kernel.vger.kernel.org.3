Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9299058F3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiHJVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHJVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:31:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CD533A17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53BDFB81EA4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D28C433C1;
        Wed, 10 Aug 2022 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660167064;
        bh=NK5lGETgJ8mV70zk2IetcbwhCrJmhDXBruOENzA6gx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HgvldGL+0W0bZUXB4GMdvA8WAn0MnQAf5RshM9DXqFgYnCo9exBMfdSF5xuPBY0QL
         BOzOf+35p230OeMwcerWHA4EvX3W682/mJqLmg3qlMdVW2QtQOIm8EXMD1EbWk9dnC
         A6SbZldUcxeYrFpCp+DVbqLGmNVngiJ3PzXez/8Y=
Date:   Wed, 10 Aug 2022 14:31:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <david@redhat.com>, <vbabka@suse.cz>, <quic_pkondeti@quicinc.com>,
        <minchan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/cma_debug: show complete cma name in debugfs
 directories
Message-Id: <20220810143102.595072879e4bae7f7c46e3e6@linux-foundation.org>
In-Reply-To: <1660152485-17684-1-git-send-email-quic_charante@quicinc.com>
References: <1660152485-17684-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Wed, 10 Aug 2022 22:58:05 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> Currently only 12 characters of the cma name is being used as the debug
> directories where as the cma name can be of length CMA_MAX_NAME(=64)
> characters. One side problem with this is having 2 cma's with first
> common 12 characters would end up in trying to create directories with
> same name and fails with -EEXIST thus can limit cma debug functionality.

I guess so.  There might be back-compatibility issues, but it's
debugfs...


> Also drop 'cma-' prefix for the cma debug directories as they are
> clearly evident that they are for cma debug through creating them in
> /sys/kernel/debug/cma/ path.

I guess so.  But please run `grep -r cma- Documentation'

