Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9DA524E61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354468AbiELNgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354320AbiELNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:36:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B9326FA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:36:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652362592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LGVxfd1csrHyg3a3ARuqfO22ZbRRJvUq3doY7jKQ9c=;
        b=0PtyaDyLEdwKdNEmqZBly6HUlyPcXUUl7mjwtRW6N1p0cG2kNfHBRkfv712guwf01Fb9Px
        DZ/RauThF3XYjocUeBUe+S9pWC6F1bdc60nWiIcDUlpSEDCVgn3itdnc5/MAXpDpujo946
        41Tfl6AYKE1ESSxjyqfpRiaFx+eiPt1V4V5XqR92PhYo9TiZb+pHrZZM5FUmH/5M1cxQnY
        KmZuY3dWLFyqnrHTWIJmVZRZEambTmXCpLcfn5xm7zQrkH1MZkRYV/8PYCX46R+JEzQldt
        4bM2fDfRkoc1xILrh0XZTcmRgadFvKh2aaysWSq8sKo5rD10j557WnH82p7svw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652362592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LGVxfd1csrHyg3a3ARuqfO22ZbRRJvUq3doY7jKQ9c=;
        b=lDHcjCCK2ho0I/bZ1VDJrm2Tge7rsYN1+F+mxTPNZNbNYLin0MGRvODrvmVyhAww86HLOD
        Qbg8EGBGNc1voICQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFCv2 08/10] x86/mm: Make LAM_U48 and mappings above 47-bits
 mutually exclusive
In-Reply-To: <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
Date:   Thu, 12 May 2022 15:36:31 +0200
Message-ID: <875ymax480.ffs@tglx>
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

On Wed, May 11 2022 at 05:27, Kirill A. Shutemov wrote:
> LAM_U48 steals bits above 47-bit for tags and makes it impossible for
> userspace to use full address space on 5-level paging machine.

> Make these features mutually exclusive: whichever gets enabled first
> blocks the othe one.

So this patch prevents a mapping above 47bit when LAM48 is enabled, but
I fail to spot how an already existing mapping above 47bit would prevent
LAM48 from being enabled.

Maybe I'm missing something which makes this magically mutually
exclusive.

Thanks,

        tglx
