Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75FA56396C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiGASxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiGASxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21174092B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E8C4B831A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 18:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFC5C341C6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 18:53:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UalLrrtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656701607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Up1wE9GDgySiXdePWDfOrumTTv+FqsaV66yrYDaW+bs=;
        b=UalLrrtMhsqy+vObCWPFM+BC8n7KKy1FW9S+1xoKTo1ykzXA389DUHBeA9d8jxT/ZBdVCX
        OumPt4w0jQSQrret87fetqm9wZEBK3Jq0Tr5x6xiZvRAs7mcVIB0K1iXzoRHgqSa4rrU+t
        GafUB9HHKr51//EnbtFAUPe0HWpABG8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4084abe6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 1 Jul 2022 18:53:27 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id o4so1951649ilm.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:26 -0700 (PDT)
X-Gm-Message-State: AJIora9nNVForF0rhCM+dQ+Xz3b+NnX6ULTRZeW6+4pH4qHRk3O2+usy
        uls4hvMFC/h5bjJze0TwSc1VDFa4kNP0VAVHzKA=
X-Google-Smtp-Source: AGRyM1sF34wHZWq+EcS8M+rQ2iaaqu+BimwiD5I+BAfOrnYi53f4vFmeGqw0dDsMUQiX8UvwNFYRx3zEF1j3oveWtso=
X-Received: by 2002:a92:cda5:0:b0:2d9:5bc5:6661 with SMTP id
 g5-20020a92cda5000000b002d95bc56661mr9473420ild.16.1656701605232; Fri, 01 Jul
 2022 11:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220630133106.35970-1-Jason@zx2c4.com> <20220701175808.188604-1-Jason@zx2c4.com>
 <05A1E6F8-432A-4D68-9CF8-C77A3FC68584@zytor.com> <Yr8/+3qha3nCRLOD@zx2c4.com> <709B69E7-DEC8-428C-9555-254E32C834A9@zytor.com>
In-Reply-To: <709B69E7-DEC8-428C-9555-254E32C834A9@zytor.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 1 Jul 2022 20:53:14 +0200
X-Gmail-Original-Message-ID: <CAHmME9rJ2TO1fNm3eW3Hj6FxqMHy-6pHXkeKnG6phfr_vfXHAw@mail.gmail.com>
Message-ID: <CAHmME9rJ2TO1fNm3eW3Hj6FxqMHy-6pHXkeKnG6phfr_vfXHAw@mail.gmail.com>
Subject: Re: [PATCH v5] x86/setup: Allow passing RNG seeds via e820 setup table
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 8:52 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On July 1, 2022 11:42:03 AM PDT, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> >Hi Peter,
> >
> >On Fri, Jul 01, 2022 at 11:25:49AM -0700, H. Peter Anvin wrote:
> >> Please correct the incredibly confusing title of this patch.
> >>
> >> The setup_data linked list has nothing to do with memory types (e820),
> >> except that memory types is one kind of data that can be passed on by
> >> this mechanism. This title makes it sound like you are passing random
> >> data in as a memory type, which could make some bizarre sense if it
> >> were, say, some kind of ring buffer preconfigured by the BIOS/VMM/boot
> >> loader to be continually overwritten with new random data.
> >
> >Yea that is pretty confusing. Alright, I'll retitle that to something
> >like:
> >
> >    x86/setup: Allow passing RNG seeds via setup data
> >
> >Hopefully that matches more, considering the function that does the work
> >is called "parse_setup_data".
> >
> >(I'll wait some more time before posting yet another v+1 with that
> >change, in case others have more feedback.)
> >
> >Jason
>
> We usually refer to it as setup_data (with the underscore) to indicate that it is a name and not a description.

That makes sense. I'll do that.

Jason
