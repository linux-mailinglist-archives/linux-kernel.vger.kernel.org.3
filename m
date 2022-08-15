Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD48592FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiHONcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHONca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:32:30 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5D15718
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:32:29 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id v4so2163316pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6+NKr8x81snqBPCrj5grt+MbWltUZu5PmZe6P/3T6aM=;
        b=Eul1FE/WL+1pSC4oKQfwt0TaAzuyWzUDhfnkAN+OA90ZE/aJ2hEj1YpVFWr8Tq5qY2
         hJLegOObGkmNUJ58dBxBfyqa8+kJY1nuTAbLSRwecjajL/W3XAb02jzbnEoNHlZ9FcFQ
         2k5bnhaQsmuAjOVmjPz1QHj8Nd5xZVq1zW8SIuddsvYmKGKAbfun7wxJIFZ5Q2EE0CMO
         9mbsuf/Se0atpkQMB2OCOO2nEfhMjL7NF6dP59uZXDzSfGtf3fWL/kkoukUQiUH1mbH1
         qoV/T1gsskmIisHJCE/CKz4Opi6xwthdFa+zVfdlugWjMjap44hitMoF2yesNmmlnW76
         zCLQ==
X-Gm-Message-State: ACgBeo2caYNjgVopazMY8Kvr6UO7xuyJJSmGJFq7lK7tkSUoIe7V/dsE
        N/h1IL6lLos04USNPK0SRoM=
X-Google-Smtp-Source: AA6agR6oSpgHxc+dt63vqfcdjwfag3ms5XkVohiacbxfketzvYVSYHIwNqzSsvU+tSB9zeLx0MXvcQ==
X-Received: by 2002:aa7:85da:0:b0:52f:c5bc:cb41 with SMTP id z26-20020aa785da000000b0052fc5bccb41mr16401699pfn.31.1660570348933;
        Mon, 15 Aug 2022 06:32:28 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902eb8500b0016dbe5f5308sm6916750plg.79.2022.08.15.06.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:32:27 -0700 (PDT)
Message-ID: <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
Date:   Mon, 15 Aug 2022 06:32:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: lockdep splat due to klist iteration from atomic context in Intel
 IOMMU driver
Content-Language: en-US
To:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Sasha Levin <sashal@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org,
        Scarlett Gourley <scarlett@arista.com>,
        James Sewart <jamessewart@arista.com>,
        Jack O'Sullivan <jack@arista.com>
References: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 05:05, Lennert Buytenhek wrote:
> On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
> CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
> below when an I/O page fault occurs on a machine with an Intel
> IOMMU in it.
> 
> The issue seems to be the klist iterator functions using
> spin_*lock_irq*() but the klist insertion functions using
> spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
> over klists from atomic (hardirq) context as of commit 8ac0b64b9735
> ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
> when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
> pci_get_domain_bus_and_slot() calls into bus_find_device() which
> iterates over klists.
> 
> I found this commit from 2018:
> 
> 	commit 624fa7790f80575a4ec28fbdb2034097dc18d051
> 	Author: Bart Van Assche <bvanassche@acm.org>
> 	Date:   Fri Jun 22 14:54:49 2018 -0700
> 
> 	    scsi: klist: Make it safe to use klists in atomic context
> 
> This commit switched lib/klist.c:klist_{prev,next} from
> spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
> the spin_{,un}lock() calls in add_{head,tail}() untouched.
> 
> The simplest fix for this would be to switch lib/klist.c:add_{head,tail}()
> over to use the IRQ-safe spinlock variants as well?

Another possibility would be to evaluate whether it is safe to revert 
commit 624fa7790f80 ("scsi: klist: Make it safe to use klists in atomic 
context"). That commit is no longer needed by the SRP transport driver 
since the legacy block layer has been removed from the kernel.

Thanks,

Bart.


