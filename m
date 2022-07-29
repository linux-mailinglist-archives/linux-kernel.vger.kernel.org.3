Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1535855AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiG2Tqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiG2Tqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:46:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7267586
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Uyb73v5rTeGi6O22hmhJ+u8gllUvmeLKJcs+R3V8JY=; b=fGF3arBN3qZwrpge7TrypIPvtU
        lqSRvYisb02UGydgHErTPZdJUjvC8IilC6S4OQ+JNwa+4MV37da9is0EM6tVOs8imwcccqdsuLEzs
        qDhvWgPZBdEgI2fiBKwXv6V0Ltaxje17UqBPUroWL4oqJCcrRny9j0na/OoOs0QYjw7k456Tqib0D
        IgyYXviQHOt808H80OQ1mCYrMjs1yB+Nda4h/F6y2pXpGcrPbns0M8tIn+0mFjJyzoOIWubHkOWn+
        AD2gJDLSd7cVTdJJOFbvMKeGI4mOoAPF/zGpiPYjfwkMlO23ykt+frY8ddmhWhfKTpz0Jx44jkVbZ
        vs6YnXnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oHVwL-0050n0-CU; Fri, 29 Jul 2022 19:46:29 +0000
Date:   Fri, 29 Jul 2022 20:46:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     alexlzhu@fb.com
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sys_x86_64: fix VMA alginment for mmap file to THP
Message-ID: <YuQ5FYWMXLw+LpVA@casper.infradead.org>
References: <20220729194214.1309313-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729194214.1309313-1-alexlzhu@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:42:14PM -0700, alexlzhu@devvm6390.atn0.facebook.com wrote:
> From: alexlzhu <alexlzhu@fb.com>
> 
> With CONFIG_READ_ONLY_THP_FOR_FS, the Linux kernel supports using THPs for
> read-only mmapped files, such as shared libraries. However, on x86 the
> kernel makes no attempt to actually align those mappings on 2MB boundaries,
> which makes it impossible to use those THPs most of the time. This issue
> applies to general file mapping THP as well as existing setups using
> CONFIG_READ_ONLY_THP_FOR_FS. This is easily fixed by using the alignment
> info passed to vm_unmapped_area. The problem can be seen in
> /proc/PID/smaps where THPeligible is set to 0 on mappings to eligible
> shared object files as shown below.

Can't your filesystem just use thp_get_unmapped_area() like
ext2/ext4/fuse/xfs do?
