Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF94E69DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353423AbiCXUer convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Mar 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbiCXUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:34:46 -0400
X-Greylist: delayed 1232 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 13:33:13 PDT
Received: from mail2.intersystems.com (mail2.intersystems.com [38.105.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270FDF7F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:33:11 -0700 (PDT)
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
X-InterSystems: Sent from InterSystems
From:   Ray Fucillo <Ray.Fucillo@intersystems.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: scalability regressions related to hugetlb_fault() changes
Thread-Topic: scalability regressions related to hugetlb_fault() changes
Thread-Index: AQHYP7uAL1vA/rQijE+hDIc6LhXGuA==
Date:   Thu, 24 Mar 2022 20:12:35 +0000
Message-ID: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.254.204]
x-c2processedorg: 5d7e5ca7-6395-445f-80da-8568a4fc58e5
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48F2A26C80B440459846FEED0F086F05@exchangemail.iscinternal.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In moving to newer versions of the kernel, our customers have experienced dramatic new scalability problems in our database application, InterSystems IRIS.  Our research has narrowed this down to new processes that attach to the database's shared memory segment taking very long delays (in some cases ~100ms!) acquiring the i_mmap_lock_read() in hugetlb_fault() as they fault in the huge page for the first time.  The addition of this lock in hugetlb_fault() matches the versions where we see this problem.  It's not just slowing the new process that incurs the delay, but backing up other processes if the page fault occurs inside a critical section within the database application.

Is there something that can be improved here?  

The read locks in hugetlb_fault() contend with write locks that seem to be taken in very common application code paths: shmat(), process exit, fork() (not vfork()), shmdt(), presumably others.  So hugetlb_fault() contending to read turns out to be common.  When the system is loaded, there will be many new processes faulting in pages that may blocks the write lock, which in turn blocks more readers in fault behind it, and so on...  I don't think there's any support for shared page tables in hugetlb to avoid the faults altogether.

Switching to 1GB huge pages instead of 2MB is a good mitigation in reducing the frequency of fault, but not a complete solution.

Thanks for considering.

Ray
