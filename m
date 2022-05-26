Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376CA53554E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiEZVAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiEZVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:00:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05645E7328
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:00:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y189so2652500pfy.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JteuSCmFe0Ax3Jv0jhvvnbUFmqGywiPgYTZBKAL1MtA=;
        b=KLy4seMkAvMEULbJdH9kBPX6d58QUXCV+UEgGHhwvr0oHiKUVf32JPkuAe/eXE3++q
         KXeRzj87OrOKgrQg6L71NlyvCO5JBAFYP42Qy0dlNhKtY9uHm4qGXfykdGnI+xr4VTjr
         fR7tBcC1jJ/HqOuwxDPY892GUqk8ORhs7lZ5ZjwJUiUpcn79SygdfnhgiznBPv8fXWxI
         /BO/WDsY9mi8cycnqGYKKjO9Cm6qwBzh1uA+zpq1bTWaAofx07SZ01pnKkWbMovSnzY9
         qPHkIVSUJuXBoaGVAxzG/YiJhvObKZyjih10FWX2yUrRSNxvpTJDGlBHSOgSQWaGk+KT
         dF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JteuSCmFe0Ax3Jv0jhvvnbUFmqGywiPgYTZBKAL1MtA=;
        b=z+BBS7THXN5Fq8ORZfrnA4CCuaq75pkNr6zSDkvxEimSqOWAlOPR+TpIuhQT2YARTq
         KlUa2zEW6qzPQUamFfZVZhkZNOlDGOqy2EeTspUOEiTG7dsNDbG2w3wtVWn3TQiUqPz4
         jRWP29/lOs+KLijWRT8IZdMVpBkpXYACYqOpf8390bRzN+MGNH4Mcc6bkb3gfapc2J7o
         pYONuRfp+liR8sBHMfGSri/8bJxZKO7vYCx0rwLNoyvn4WQzPk3y7zzOdSMXNzXz+k3a
         XxG9jk4hIU2HzvDqIGhcrLDGuYQ92Af/+roPeaKKDgOCDwio4nrkT4yxFw+7YoIXMoiJ
         QEoA==
X-Gm-Message-State: AOAM5333GudRkHv+XVdYuo+VJDJl2+8gBuwDXWl+liXxx1oMYtYUkN9S
        DZwcTzBPgVMODQ84n8Vk7n7mfw==
X-Google-Smtp-Source: ABdhPJwU8XJ1LbdTt56UBXDcvb1DNrNr0jHtKCkWknsStzSSq1vRk0n7+OPAv+C8mi5Oq6jmV+EXJQ==
X-Received: by 2002:a05:6a00:711:b0:4fa:daf1:94c1 with SMTP id 17-20020a056a00071100b004fadaf194c1mr40319321pfl.52.1653598842348;
        Thu, 26 May 2022 14:00:42 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i6-20020a63cd06000000b003f24d67d226sm1928874pgg.92.2022.05.26.14.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:00:41 -0700 (PDT)
Date:   Thu, 26 May 2022 21:00:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv3 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <Yo/qduyX33XHFVjK@google.com>
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
 <20220524221012.62332-4-kirill.shutemov@linux.intel.com>
 <6350b927-4b3f-6f43-aa62-f8db19fa8d5b@intel.com>
 <20220526203619.gpyyl67ygk622e5g@black.fi.intel.com>
 <bb94beeb-061d-c795-7ed6-3c9d2c73191c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb94beeb-061d-c795-7ed6-3c9d2c73191c@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022, Dave Hansen wrote:
> On 5/26/22 13:36, Kirill A. Shutemov wrote:
> > On Thu, May 26, 2022 at 09:20:56AM -0700, Dave Hansen wrote:
> >> On 5/24/22 15:10, Kirill A. Shutemov wrote:
> >>> +	/*
> >>> +	 * MMIO accesses suppose to be naturally aligned and therefore never
> >>> +	 * cross a page boundary. Seeing unaligned accesses indicates a bug or
> >>> +	 * load_unaligned_zeropad() that steps into unmapped shared page.
> >> Wait a sec though...
> >>
> >> We've been talking all along about how MMIO accesses are in some cases
> >> just plain old compiler-generated memory accesses.  It's *probably* bad
> >> code that does this, but it's not necessarily a bug.
> > Compiler-generated memory accesses tend to be aligned too. You need to do
> > something make them unalinged, like __packed or pointer trickery.
> 
> I totally agree.  But, the point is that __packed or pointer trickery is
> goofy, but it's not necessarily a bug.  This might crash the kernel on
> goofy stuff, not bugs.

Yeah, I don't think it's worth exploding on unaligned accesses, it's specifically
page splits that are a mess and are an absolutely nightmare to handle.  E.g. for
VirtIO kicks, the data and page offset are completely ignored/irrelevant, so a
multi-byte write to any random byte in the page should work, even though it's all
kinds of goofy.
