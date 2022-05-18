Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26D752BE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiERO4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbiERO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:56:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3016F913;
        Wed, 18 May 2022 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Is6VMKTGS6Q+REIPQaUhYHAbJCVB2LMBP9f+Vwnyr0=; b=ZicRzH8+hsKxFUFZUGV7uh6rsr
        liYqq1jo/NJPjFOq45aL15fhGeuMBVY2fPnZKIydDip+x+51BJs5NLmaGT8oWGbYZbNY+K0Pyrkef
        6rtOzeBsy0dtcUJ9XhADYUN1Y2oy9oXlw62lJz3I3InUErp1+tH7/lFyOSmAivKaDcxFU8jfS3PYX
        5/inIxpdAkkRzXjoVhil+5k58vn049Ny8S6eWbnS3PYIDvtdMiaokBA2YBm3sYTd/JNaiZ0Wbl7n9
        ZDo+9nTYLRaDzeaIcwzrVzxX+7iFsugHlQtmCGx0J+QdfouNf4S/mZbzCdefd3KPIBkiWnP0vWdHc
        TOCI2+AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrL61-00Bsxi-6p; Wed, 18 May 2022 14:56:17 +0000
Date:   Wed, 18 May 2022 15:56:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com,
        akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com, tj@kernel.org,
        dennis@kernel.org, ming.lei@redhat.com
Subject: Re: [RFC PATCH 00/18] Try to free user PTE page table pages
Message-ID: <YoUJEZU9JcfMlhRO@casper.infradead.org>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
 <8c51d9ae-5a8e-74a9-ddc2-70b5fcd38427@bytedance.com>
 <37055be1-05af-f7ef-c33e-27f90fa0f9ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37055be1-05af-f7ef-c33e-27f90fa0f9ca@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:51:06PM +0200, David Hildenbrand wrote:
> yes, I talked about the involved challenges, especially, how malicious
> user space can trigger allocation of almost elusively page tables and
> essentially consume a lot of unmovable+unswappable memory and even store
> secrets in the page table structure.

There are a lot of ways for userspace to consume a large amount of
kernel memory.  For example, one can open a file and set file locks on
alternate bytes.  We generally handle this by accounting the memory to
the process and let the OOM killer, rlimits, memcg or other mechanism
take care of it.  Just because page tables are (generally) reclaimable
doesn't mean we need to treat them specially.

