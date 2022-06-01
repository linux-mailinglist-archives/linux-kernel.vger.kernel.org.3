Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD19E53A10A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351510AbiFAJpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351373AbiFAJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CA8685EF2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:44:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F56FED1;
        Wed,  1 Jun 2022 02:44:36 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB503F66F;
        Wed,  1 Jun 2022 02:44:34 -0700 (PDT)
Message-ID: <408315d1-9820-65d0-c0a7-cc038bfa9eb1@arm.com>
Date:   Wed, 1 Jun 2022 10:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
Content-Language: en-GB
To:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
 <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
 <803feeab-b27b-983d-45da-02a0daf0179a@cybernetics.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <803feeab-b27b-983d-45da-02a0daf0179a@cybernetics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 23:10, Tony Battersby wrote:
> On 5/31/22 17:54, Keith Busch wrote:
>> On Tue, May 31, 2022 at 02:23:44PM -0400, Tony Battersby wrote:
>>> dma_pool_free() scales poorly when the pool contains many pages because
>>> pool_find_page() does a linear scan of all allocated pages.  Improve its
>>> scalability by replacing the linear scan with a red-black tree lookup.
>>> In big O notation, this improves the algorithm from O(n^2) to O(n * log n).
>> The improvement should say O(n) to O(log n), right?
> 
> That would be the improvement for a single call to dma_pool_alloc or
> dma_pool_free, but I was going with the improvement for "n" calls
> instead, which is consistent with the improvement for the example in the
> cover letter for mpt3sas.  I would have to look up the convention to be
> sure of the proper notation in a situation like this, but I usually
> think "inserting N items takes N^2 time"; to me it makes less sense to
> say "inserting 1 item takes N time", because the N seems to come out of
> nowhere.

No, n represents the size of the set that the algorithm is inserting 
into (or removing from, searching within, etc.). Hence why constant time 
is represented by O(1), i.e. not involving the variable at all.

Robin.
