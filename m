Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AFC54A1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiFMVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiFMVq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:46:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7C63C9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93598B81598
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5F3C3411C;
        Mon, 13 Jun 2022 21:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655156813;
        bh=X46jeMDNn8HyJl0KZHYa8Gd+f29qA1cMwLGoyuFo7Iw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UBfBbpoHKAz5A7GGkUegeVBfLYHR5X20kSoA/VQOShj0hW5lCVCpwb4Hm3Y8WpIKO
         5BXfWlo+dnKipOS5E3yTOkLLTnpeIIFRzEHOh+OsfyzH+sC5k2VmWVU+FruiVnSRDY
         ieQIjfTK0mF4RhQB8HjAZd1ebxwkjZivI2YXqlcA=
Date:   Mon, 13 Jun 2022 14:46:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "liubo (AW)" <liubo254@huawei.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        linmiaohe <linmiaohe@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: =?UTF-8?Q?=E7=AD=94=E5=A4=8D:?= [PATCH] mm/swapfile: release
 swap info when swap device is unpluged
Message-Id: <20220613144651.8f54b3da0c2e013d9db89f02@linux-foundation.org>
In-Reply-To: <80d54ab2864e4011a9f5e5b198ccfe8e@huawei.com>
References: <20220528084941.28391-1-liubo254@huawei.com>
        <80d54ab2864e4011a9f5e5b198ccfe8e@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 13:00:24 +0000 "liubo (AW)" <liubo254@huawei.com> wrote:

> friendly ping.

I was hoping that someone might weigh in and review this, but no joy.

The patch does quite a large amount of code movement, which makes it
quite hard to review - to see what functionally changed.  Is it possible to turn
this into a two patch series?  The first does the code movement with no
functional changes and the second is the actual fix?

