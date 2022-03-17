Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9514DC4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiCQLhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCQLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:37:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BEC11F7AB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:35:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647516942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dp8FfPTLGmw/K6M4b2j41g72cLrWRUo3xM+TgpBkEBI=;
        b=3tUuRBCPOPWFpMsj6hjejl0U+MC+zxSoP4no87AYQEnGya3NmxUKD9Cy+e06EahpXcX/qk
        lGgoLfa42h8il4bd1ye4Jzz4bNfmDz8/lQlw5VLi2kmWMuR2tPVW2ZWp8nr0B3/7uF8oCM
        wsTXIyB5K7TwsoHpiqdAkO004TIPh7ZqUyfJbVhMRDN1tSaeVVFxPz5agD/5cZagcAJVwN
        WCopny/dKeoRS8D/dhbq1PhEsvQlNtoN8OBGIpzdTHEswpoIvqfgegLPs06CDlaeV7aQh8
        CzlsujUq2CSbnImftI+rMCU2EfEzARKD7YpJAP0aPj9UX5eZ7vuM+0o/f+iC/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647516942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dp8FfPTLGmw/K6M4b2j41g72cLrWRUo3xM+TgpBkEBI=;
        b=EPea7RRIWvmeFK6RMiPGtI28PqqwRMmeoWG6lb8t8SCXrqMEjVzWcyt91NfBvTrDEnLGem
        YVRzkQ8lpoaqBSDw==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 11/30] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220316020856.24435-12-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-12-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 12:35:41 +0100
Message-ID: <87sfrg24mq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> This approach will be adopted in the future, removing the bulk of
> MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.
>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
