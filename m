Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47B5578E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiFWLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiFWLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AC0D4BFD5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:41:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B8112FC;
        Thu, 23 Jun 2022 04:41:09 -0700 (PDT)
Received: from [10.57.85.4] (unknown [10.57.85.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 092363F534;
        Thu, 23 Jun 2022 04:41:07 -0700 (PDT)
Message-ID: <653fba02-7eef-5f0d-66dd-7599af84db86@arm.com>
Date:   Thu, 23 Jun 2022 12:41:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
 <YrMSJ6AGwn3PxSIH@8bytes.org> <b9439692-c72b-b856-c7c0-e60a863f3e74@arm.com>
 <YrRPfhXvdPo0Y6Cx@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YrRPfhXvdPo0Y6Cx@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-23 12:33, Joerg Roedel wrote:
> On Wed, Jun 22, 2022 at 02:12:39PM +0100, Robin Murphy wrote:
>> Thanks for your bravery!
> 
> It already starts, with that patch I am getting:
> 
> 	xhci_hcd 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000f address=0xff00ffffffefe000 flags=0x0000]
> 
> In my kernel log. The device is an AMD XHCI controller and seems to
> funciton normally after boot. The message disappears with
> iommu.forcedac=0.
> 
> Need to look more into that...

Given how amd_iommu_domain_alloc() sets the domain aperture, presumably 
the DMA address allocated was 0xffffffffffefe000? Odd that it gets bits 
punched out in the middle rather than simply truncated off the top as I 
would have expected :/

Robin.
