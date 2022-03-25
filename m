Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30E4E743E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355428AbiCYNeq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Mar 2022 09:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiCYNen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:34:43 -0400
Received: from mail2.intersystems.com (mail2.intersystems.com [38.105.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605A35FE7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:33:07 -0700 (PDT)
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
Thread-Index: AQHYP7uAlCiDRvHUGUacjbJUOtVkhKzPVz2AgAANE4CAABZqAIAATaiAgACU6YA=
Date:   Fri, 25 Mar 2022 13:33:03 +0000
Message-ID: <CD631DCE-22C1-41FF-A55D-CCB393230851@intersystems.com>
References: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
 <43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org>
 <e4cfa252-7be8-48b2-9f19-019bcc0038af@oracle.com>
 <8E9438A4-56BF-4DBF-9424-2161A488352B@intersystems.com>
 <1883d31a-639e-8717-39b1-426628cb0d56@oracle.com>
In-Reply-To: <1883d31a-639e-8717-39b1-426628cb0d56@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.254.204]
x-c2processedorg: 5d7e5ca7-6395-445f-80da-8568a4fc58e5
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDB99200A394884FABF35F09A6F1AB5A@exchangemail.iscinternal.com>
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


> On Mar 25, 2022, at 12:40 AM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> I will continue to look at this.  A quick check of the fork code shows the
> semaphore held in read mode for the duration of the page table copy.

Thank you for looking into it.  

As a side note about fork() for context, and not to distract from the 
regression at hand...  There's some history here where we ran into problems 
circa 2005 where fork time went linear with the size of shared memory, and 
that was resolved by letting the pages fault in the child.  This was when
hugetlb was pretty new (and not used by us) and I see now that the fix
explicitly excluded hugetlb.  Anyway, we now mostly use vfork(), only fork()
in some special cases, and improving just fork wouldn't fix the scalability
regression for us.  But, it does sound like fork() time might be getting 
large again now that everyone is using very large shared segments with 
hugetlb, but generally haven't switched to 1GB pages.  That old thread is: 
https://lkml.org/lkml/2005/8/24/190
