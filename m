Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647A25A0101
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiHXSCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiHXSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:02:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A813CCD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:01:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3378303138bso440845637b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DGuV+oKzfmFfApe8NxA2paN6tKmjViwBVg9JpKKUVew=;
        b=aK7CLkv5P2RcCIQ4lBOyr8TSYIWgo/S7IAXUY+CksZwIzy0GAUD2JwRUYl1mFSlNy1
         AlZYZ+MSnfLOvbuZkVTyk5hYpkNwyfw7XjHdVZIEBzoniE+PdMWI3Dkur8HhBI1VH++3
         zG2zC0bKMzKEiqxXi/wzfVrA6uOVxHU694jVkzxalWH/7oz6JhUVaNQgLaUVbsF4Ja+t
         m3unpH32vONLlCtLiTtPrym5TcCuV3jdyoTEvGYk3Tv3xyUaF9kJPtsQZ62M2XcawYY2
         /Xq7h71eB0GYT/81B4VArgq0LRAgwploebcVMZfOKDuGJ6M4fYqAWEeqcb1m1QMMjszm
         Wn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DGuV+oKzfmFfApe8NxA2paN6tKmjViwBVg9JpKKUVew=;
        b=C4dnNQwAjN0H/oNLfSwS1xI2ObpSWNLp56bUDfgMyzmDTCAvdr76BBnpsbD5x58wC9
         D2qb92pf/N1ShQHqoT/jSAjbkUHe2LRyNulcm8qVOZ54LbSH5PKFfzEMSJ/alXQ590C6
         OyJGk3qZHnPEEu4VufXl+lbtDiFvM4+r1j5//+wqq/2dE/hemPfh98hi8Q4mU4jDi5Rh
         fYKPB11p6VhND1K9QSdPdTA2hSSvb53WyVeKI+mbCFdOeFA2asid0Ug9RWSASW3bT/4C
         MJ3x3npl1l2VfcDZxkQpqdHcab2GyTzaVGKH75ECXXuoQfcGHV4hiYadIMyyZOGpiEdw
         r2bQ==
X-Gm-Message-State: ACgBeo0jD0rwdACipWgSqvmtqn9PMPxzLeuVY0JAATpbV0tX/eYoL5oG
        Eo7CZAkdejgGMh7V2K7NbWMUr1/v6PzUyrJTPAe4uA==
X-Google-Smtp-Source: AA6agR4krDxQhq5Y+22wT3eQhzuO1h8jJucGBjy3TIVyLauaMRohf/vMydVZsogFXj4WyTvzKkerLZ1BkZP/rZzLJXI=
X-Received: by 2002:a81:6f43:0:b0:335:9e7e:ad25 with SMTP id
 k64-20020a816f43000000b003359e7ead25mr347464ywc.518.1661364087931; Wed, 24
 Aug 2022 11:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220307213356.2797205-1-brijesh.singh@amd.com> <20220307213356.2797205-44-brijesh.singh@amd.com>
In-Reply-To: <20220307213356.2797205-44-brijesh.singh@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 24 Aug 2022 11:01:16 -0700
Message-ID: <CAAH4kHYm1BhjJXUMH12kzR0Xun=fUTj-3Hy6At0XR_09Bf0Ccw@mail.gmail.com>
Subject: Re: [PATCH v12 43/46] virt: Add SEV-SNP guest driver
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com,
        Marc Orr <marcorr@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the necropost, but I noticed strange behavior testing my
own Golang-based wrapper around the /dev/sev-guest driver.

> +
> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> +                               u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> +                               u32 resp_sz, __u64 *fw_err)
> +{
> +       unsigned long err;
> +       u64 seqno;
> +       int rc;
> +
> +       /* Get message sequence and verify that its a non-zero */
> +       seqno = snp_get_msg_seqno(snp_dev);
> +       if (!seqno)
> +               return -EIO;
> +
> +       memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
> +
> +       /* Encrypt the userspace provided payload */
> +       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> +       if (rc)
> +               return rc;
> +
> +       /* Call firmware to process the request */
> +       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +       if (fw_err)
> +               *fw_err = err;
> +
> +       if (rc)
> +               return rc;
> +

The fw_err is written back regardless of rc, so since err is
uninitialized, you can end up with garbage written back. I've worked
around this by only caring about fw_err when the result is -EIO, but
thought that I should bring this up.

--
-Dionna Glaze, PhD (she/her)
