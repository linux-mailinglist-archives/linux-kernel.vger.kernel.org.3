Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CBF52E896
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347649AbiETJSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347700AbiETJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:18:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 201CD149171
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:18:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF0A81477;
        Fri, 20 May 2022 02:18:26 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14D83F66F;
        Fri, 20 May 2022 02:18:25 -0700 (PDT)
Message-ID: <c10de7b0-ca73-e2a8-bdc5-1a3a9edd5f30@arm.com>
Date:   Fri, 20 May 2022 10:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, jon.grimm@amd.com,
        linux-kernel@vger.kernel.org, vasant.hegde@amd.com
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org> <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
 <YodMvV/8eii4KCLg@8bytes.org> <794e13dd-8eae-481d-711d-b5462fdbfb18@arm.com>
 <YodYTZzSd9fZucLT@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YodYTZzSd9fZucLT@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-20 09:58, Joerg Roedel wrote:
> On Fri, May 20, 2022 at 09:54:51AM +0100, Robin Murphy wrote:
>> The .def_domain type op already allows drivers to do exactly this sort of
>> override. You could also conditionally reject IOMMU_DOMAIN_PASSTHROUGH in
>> .domain_alloc for good measure, provided that (for now at least*) SNP is a
>> global thing rather than per-instance.
> 
> Yeah, that could work. I am just not sure the IOMMU core behaves well in
> all situations when allocation IOMMU_DOMAIN_PASSTHROUGH suddenly starts
> to fail. I would feel better if this is checked and tested :)

Well, iommu_group_alloc_default_domain() has the fallback and is 
currently the only place that __iommu_domain_alloc() can be called with 
a type other than IOMMU_DOMAIN_UNMANAGED, so by inspection it should be 
fine. However if iommu_get_def_domain_type() says the right thing then 
neither sysfs nor automatic default domains should get as far as even 
trying to allocate an identity domain anyway - note that that's already 
what happens for untrusted external devices. But either way should be 
easy enough to verify with a quick hack, too.

Cheers,
Robin.
