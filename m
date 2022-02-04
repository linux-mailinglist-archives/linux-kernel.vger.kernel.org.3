Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5DD4AA441
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378093AbiBDXXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiBDXXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:23:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA9DFC0F80
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:23:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644017020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjKFLhJ0WKOYdjVNT75NralCeXORWUK8K4Zouf8H2hA=;
        b=2rLCAeeHPv2kZnBHn2OmGzTO+yyDRHq9i3gmwAezbl2N1S3B037Us1GM6mm3h4p8lyAB0B
        1NFbYIt1m67miC4jgKkjS5AFY/MKleQ91Omh25Rj/wXS2soRK/RUAFkBL5wehByF7MG6l5
        EVWrv+GJO9/m62e7yM01hZ1xnEfI/mM3DAqL7MPZZyG2Y1mKJeqMylPEnJ79zbIS39chKO
        JbXxSzGslbCy4zmRBNVXIBQPwlilwUcjFIk3VMYk2Q6qtsS9H4+sMZ9c8dMI/gmGt1cBYO
        X4LgeAv+0GCVGCb6ly3N2t6SAL4ZeDXd2Id8tr0Lq0/7NQCmhrBBijBBfhCVEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644017020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjKFLhJ0WKOYdjVNT75NralCeXORWUK8K4Zouf8H2hA=;
        b=QphJxMQP6qkYru6xRH4MdbwS6ihQZIdWWFCq9uH7lRxVuKawXyAz83JLiJS5P9XEkVnycC
        vqyCIRZIM6mJx7CA==
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 03/11] iommu/ioasid: Introduce a helper to check for
 valid PASIDs
In-Reply-To: <20220128202905.2274672-4-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-4-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:23:40 +0100
Message-ID: <87tudeb4hv.ffs@tglx>
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

On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:

> pasid_valid() is defined to check if a given PASID is valid.
>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
