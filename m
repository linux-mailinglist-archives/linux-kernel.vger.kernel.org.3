Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2641A4F5208
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849268AbiDFCeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449532AbiDEWYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:24:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68917584C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vfnds4uZwOUw8zPinp55S3drsKWUUrjkD5pxZmDfQ3o=; b=UE9salMD8CEHOMHRKgSqk1ysa4
        +Zb8ubeM4QI2ErLIm70Y4BRN2nXRdyL+r/3EWfgaNkAjGzYvbec7vhKYE2uod+I9xbucnfeb4m0HU
        lRTNfmvRPN5IzMdnPags8ZPe7zz/KKEQ+N6TLon1FgZEO2tYuIWqSDIC5BYVl90nu3zUQpvI+dMFS
        HGCtYR/g0Y1c+8XmM8EkbAinT1rcrVVrPO2x2jy7n07PnzjcJ/cinP7k0C8R9w6f7Nczk1v9TsVcL
        KEy3AsIypYKS8H0evy+GXwixPEX+lSfwm/hlmJlrY4fj6qjfgGeiqSVjg3zxtDgtvKZwsaSFrTk6l
        +V2RFV7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbqcb-0074AY-PZ; Tue, 05 Apr 2022 21:21:53 +0000
Date:   Tue, 5 Apr 2022 22:21:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Dave Chinner <david@fromorbit.com>,
        Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <Ykyy8RfJgWDOGylv@casper.infradead.org>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
 <20220405051710.GW1609613@dread.disaster.area>
 <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
 <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:58:59PM -0700, Yang Shi wrote:
> Yeah, I agree it actually doesn't make too much sense to return the
> number of reclaimed objects. Other part of vmscan returns the number
> of base pages, the sizes of slab objects are varied, it may be much
> smaller than a page, for example, dentry may be 192 bytes.

From the point of view of vmscan, it only cares about the number of pages
freed because it's trying to free pages.  But from the point of view of
trying to keep the number of non-useful objects in check, the number of
objects freed is more important, and it doesn't matter whether we ended
up freeing any pages because we made memory available for this slab cache.
