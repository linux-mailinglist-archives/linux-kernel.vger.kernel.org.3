Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC359CA94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiHVVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbiHVVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:13:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A8316
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0938AB818BE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D484C433D6;
        Mon, 22 Aug 2022 21:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661202790;
        bh=bNEV8Hgym2jaXgAqb4vRFEvYKaYv3kDdXR+qqOYIvjs=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=0SXV5O/53D9HVBCIfTKK7UIMlN1+4bjGmBla0l5GXqoD/aZnx3pvRH/Z0CZyG8mt/
         JEfKKSu7WlXZS6A3IDPGgxSqHZHCky61e9QREg60OS8qECfjo/WacfqIzxeoNnLNrq
         3l8Zho4T/ZDkvzI9sYvQLhANHkwRjlNysig+KUbs=
Date:   Mon, 22 Aug 2022 14:13:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Message-Id: <20220822141309.3b7382db0367b63b6cd72c14@linux-foundation.org>
In-Reply-To: <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
References: <20220822023311.909316-1-liushixin2@huawei.com>
        <20220822033354.952849-1-liushixin2@huawei.com>
        <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
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

On Mon, 22 Aug 2022 14:12:07 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> Prevention of races against zone/node hotplug?

I meant "cpu/node", of course.
