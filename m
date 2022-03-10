Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133554D4C91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbiCJPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbiCJO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:58:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4DC188854
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t73Bn5PoTBPP0h6uAMsqu927EETHhd4aAadtdVAgAbI=; b=GtrxBXAPcQ6W9QFb4AnsRDaHP/
        kiSQAqB0AS19/oFYHmdKvwDO9nCZOBWN+iU9DWJKEjVu1wtnxR4xlOv50QPKef4JQNoJAtQ8q8i6F
        NfR0hD8PF29RiTIFK1TJiAGqOkJnr5YpeSPnLr+rCR4ommax42/RENOPa5qi413UKaDIC7aAkuAvQ
        rqfx4QbnNO46yN5K/29ItPfhuunkjA+iqyTcy8AbeR0GEXk7KpM4gArnxD4xE8qrNmVJbesTSsNRT
        8xcM5Ok6SSyr0AprRM+Pih8y8h6rUlYFsGd0z/kiZzkUpS9F+4kEu7mdn0TqfEhHPr5R++7oB93Hf
        1D1uiTyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSK8a-00DDWC-JW; Thu, 10 Mar 2022 14:51:32 +0000
Date:   Thu, 10 Mar 2022 06:51:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        brijesh.singh@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 27/30] x86/kvm: Use bounce buffers for TD guest
Message-ID: <YioQdNNiGZlAIuJG@infradead.org>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-28-kirill.shutemov@linux.intel.com>
 <f368d524-f676-d112-5bd0-0eeba6b77ff5@intel.com>
 <65577d45-8b15-08b6-2de4-3ca820e4d7a3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65577d45-8b15-08b6-2de4-3ca820e4d7a3@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 08:29:01AM -0600, Tom Lendacky wrote:
> > void __init mem_encrypt_init(void)
> > {
> >          if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> 
> If you make this cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT), then it should
> work for both, I would think. If you use CC_ATTR_MEM_ENCRYPT, you'll force
> bare-metal SME to always use bounce buffers when doing I/O. But SME can do
> I/O to encrypted memory if the device supports 64-bit DMA or if the IOMMU is
> being used, so we don't want to force SWIOTLB in this case.

http://git.infradead.org/users/hch/misc.git/commitdiff/18b0547fe0467cb48e64ee403f50f2587fe04e3a
