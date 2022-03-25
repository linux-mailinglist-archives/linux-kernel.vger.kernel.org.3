Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28E4E6B64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356803AbiCYAEC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Mar 2022 20:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357211AbiCYADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:03:42 -0400
Received: from mail2.intersystems.com (mail2.intersystems.com [38.105.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20280B6D13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:02:10 -0700 (PDT)
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
From:   Ray Fucillo <Ray.Fucillo@intersystems.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Ray Fucillo <Ray.Fucillo@intersystems.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: scalability regressions related to hugetlb_fault() changes
Thread-Topic: scalability regressions related to hugetlb_fault() changes
Thread-Index: AQHYP7uAlCiDRvHUGUacjbJUOtVkhKzPVz2AgAANE4CAABZqAA==
Date:   Fri, 25 Mar 2022 00:02:08 +0000
Message-ID: <8E9438A4-56BF-4DBF-9424-2161A488352B@intersystems.com>
References: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
 <43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org>
 <e4cfa252-7be8-48b2-9f19-019bcc0038af@oracle.com>
In-Reply-To: <e4cfa252-7be8-48b2-9f19-019bcc0038af@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.254.204]
x-c2processedorg: 5d7e5ca7-6395-445f-80da-8568a4fc58e5
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BD5E1F3232CF04A8B389603D457D492@exchangemail.iscinternal.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 24, 2022, at 6:41 PM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> I also seem to remember thinking about the possibility of
> avoiding the synchronization if pmd sharing was not possible.  That may be
> a relatively easy way to speed things up.  Not sure if pmd sharing comes
> into play in your customer environments, my guess would be yes (shared
> mappings ranges more than 1GB in size and aligned to 1GB).

Hi Mike, 

This is one very large shared memory segment allocated at database startup.  It's common for it to be hundreds of GB.  We allocate it with shmget() passing SHM_HUGETLB (when huge pages have been reserved for us).  Not sure if that answers...

> Also, do you have any specifics about the regressions your customers are
> seeing?  Specifically what paths are holding i_mmap_rwsem in write mode
> for long periods of time.  I would expect something related to unmap.
> Truncation can have long hold times especially if there are may shared
> mapping.  Always worth checking specifics, but more likely this is a general
> issue.

We've seen the write lock originate from calling shmat(), shmdt() and process exit.  We've also seen it from a fork() off of one of the processes that are attached to the shared memory segment.  Some evidence suggests that fork is a more costly case.  However, while there are some important places where we'd use fork(), it's more unusual because most process creation will vfork() and execv() a new database process (which then attaches with shmat()).
