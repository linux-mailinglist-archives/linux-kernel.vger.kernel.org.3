Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C15973F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbiHQQOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiHQQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54380A1D2B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B74A615B5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E96C433C1;
        Wed, 17 Aug 2022 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660752805;
        bh=UO87XP+ReSVdtQ6h8DT0P8BuiG4W3/3FE7FMrL/Zy+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IdqD6Qz8QH3d2NEbROstkxmEr4nGM4RAHuIsbVgLlZdNX5n015TUD2yOBaHycElf3
         4gb8E3lbfmJDdLObaeAQnEa2aP+kIJk9Ck9wmUt0ZlUJbeJ5JEdTahjMFXYESc7Qlm
         2STO6uywM50nmhw0zkfxm04rH8717OintFdKxfOk=
Date:   Wed, 17 Aug 2022 09:13:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     vbabka@kernel.org, minchan@kernel.org, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8] mm/page_owner.c: add llseek for page_owner
Message-Id: <20220817091324.59afdb143b6330974f4e9e4c@linux-foundation.org>
In-Reply-To: <20220816020748.18040-1-quic_yingangl@quicinc.com>
References: <20220816020748.18040-1-quic_yingangl@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 10:07:48 +0800 Kassey Li <quic_yingangl@quicinc.com> wrote:

> There is usage to dump a given cma region page_owner
> instead of all page's.

So... dump all the pages and then parse out the ones you're interested in?

Presumably this is too slow and presumably you have a use case in which
this operation needs speeding up?  If so, please fully describe all of
this in the changelog.  If not then please fully still describe the
reasons for making this change.

