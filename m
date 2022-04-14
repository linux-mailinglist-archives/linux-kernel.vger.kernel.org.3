Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65032501BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344675AbiDNTVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiDNTVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:21:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526697BBF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33C04B8282C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935BFC385A1;
        Thu, 14 Apr 2022 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649963952;
        bh=cmAgQ34MO+zKNJP8+Cq8Gpyoo2RCaNKr3MAzw2HUJ2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uStoVx8H5lW50rNMzzWX2S2ZVBnh3fnnjT5lB1YkF9/KUPzUKnZRZlSmQjm5+goRq
         s8Wu9eJEIbQvYk3mYx5yPKV8MaScCTvfcf8hdHAPiDpZtfhYP00GUXwRxyym5JgEaa
         cClrvy3ng13F94NHj5nE+taOEsZj9z4CRH+DZfrg=
Date:   Thu, 14 Apr 2022 12:19:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Message-Id: <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
In-Reply-To: <20220414171521.bgdvrirumd4atjhs@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
        <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
        <20220414135706.rcn7zr36s2hcd5re@revolver>
        <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
        <20220414171521.bgdvrirumd4atjhs@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 17:15:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> > Also I noticed, for the end address to walk_page_range(), Matthew used
> > -1 and you used ULONG_MAX in the maple branch; Andrew used TASK_SIZE
> > below. Having a single value throughout would be great.
> 
> I think ULONG_MAX would be best, we should probably change the below to
> ULONG_MAX.

I switched it to ULONG_MAX/

> I don't see the code below in mglru-mapletree (62dd11ea8d).  Am I on the
> right branch/commit?

oop, sorry, sleepy guy failed to include all the mglru patches!  It
should be fixed now (4e03b8e70232).
