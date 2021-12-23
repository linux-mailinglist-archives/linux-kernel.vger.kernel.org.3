Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9271247E8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350284AbhLWUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350277AbhLWUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:55:57 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C31C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 12:55:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id p8so10885328ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 12:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0heL0Bf0pDE1CbJ0tXsHbWplro/8IYWD/x8APQ2EdP8=;
        b=eqW2eAyvaZ9riTv+yoJ/bTDU2IuNRxzBTb8J8cxicdvvtEuO5S/zknf7TZHIFBY3VX
         Emuis5EhWXlOP7pYTqsrDSneGYdrt1XsN6K0uPwQvviEaYaaWNjzQyXz8d1+OfTlVR2Q
         uslAs2TxzGm4nhxnTJfzY4Piw3isQalZiuks6sCNSCsisP93t8LiM4/K0oSN/GEHEzMy
         2qMa7XPCnCr/In8T2w/t7+6lYeZGZnldXzaOnklS2IGW+gMO7yfFUzzZ9Sw1uz5XGDlV
         +F9ZDJsrwRUXEHUH5M5yj1rOqIEvPZxyl2tiBgChy71Dugs/pbv9I0NpF2zI0eG0/3pP
         1H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0heL0Bf0pDE1CbJ0tXsHbWplro/8IYWD/x8APQ2EdP8=;
        b=WrYUaOZsbCvAz11+Hodxw8n0+y9Hr/aNRzLhuaejW+xEUkHkFuxIZcC0SqKWt+ozJr
         OzNFkAFhh5p2DXex0L5FXx/GcpFL5jAD2XXiQVXhAFzri8jhTictctle1nSd+By73VqT
         jy0e/p18iwGOmLiGoW1FP5bJxjkbU4UFdzTWHttDJBWKfrd4R+TWOGkUBc0el5bdCiPO
         jIzVl6T6NQcc+stDE/zGFEPnGv3G08kyOs0dj0unmlBR42y0qbszhdp/ifA3CTZI/GGX
         lp0ctuxb5Xl+X/mlKId+EfaOudNBSeo0vr0/8anDO9tn0nvB/pBTdT3BSS82LeOcz1VQ
         k99Q==
X-Gm-Message-State: AOAM533VoFBpi9/OokbBTcQHwypfCkdLgP9R7NN1Z04VrUplPxMWum96
        oOVoBijtIMiU+UPKN6VMu8nQvg==
X-Google-Smtp-Source: ABdhPJwwJ5AjAvStP29HhgH21FLHAXuEpKyPBb+pFiQO//xkfXSxLZ69fl8SxLGYdjU650kwCVMzCw==
X-Received: by 2002:a2e:8513:: with SMTP id j19mr2654207lji.361.1640292955221;
        Thu, 23 Dec 2021 12:55:55 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bn30sm604080ljb.29.2021.12.23.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 12:55:54 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id BAFAC10425D; Thu, 23 Dec 2021 23:56:04 +0300 (+03)
Date:   Thu, 23 Dec 2021 23:56:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcTTt4LXKfDO+9u3@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 08:53:27PM +0100, Borislav Petkov wrote:
> On Thu, Dec 23, 2021 at 11:45:19AM -0800, Dave Hansen wrote:
> > CC_ATTR_SME_SOMETHING would get set when sme_me_mask is initialized to
> > something non-zero.  That will keep folks from falling into the same
> > trap that you did in the long term.
> 
> I guess CC_ATTR_MEM_ENCRYPT which basically says generic memory
> encryption...

Except CC_ATTR_MEM_ENCRYPT is true for TDX too, so it will also depend on
check order. It is fragile.

Frankly, naked sme_me_mask check would be better. Hm?

-- 
 Kirill A. Shutemov
