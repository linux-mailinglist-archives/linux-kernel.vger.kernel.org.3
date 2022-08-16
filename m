Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D45963E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiHPUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiHPUnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122503FA22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660682631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fxf9g37yt4QV3sYboUS8drWbHKZT6H8bVu/xJaEn0Rg=;
        b=OnJanxmtG7pIMv5uiyCapIthtKNHB5A39pUY36vsUmny4C7lj5hGy1prJyTlGBuid+pE0x
        fFJ5Z+XggM3tDVMbC/hjPb0On88q6UPxHMaFmuWQkw8u9avcwWN5qed/QYhwcU//f89d0R
        p4kJCqyGsO+kH55g1pyvYerKSQoTp1M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-a1GdagdWOyquF5oNJuyGoA-1; Tue, 16 Aug 2022 16:43:49 -0400
X-MC-Unique: a1GdagdWOyquF5oNJuyGoA-1
Received: by mail-ej1-f72.google.com with SMTP id sa33-20020a1709076d2100b0073101bdd612so2256153ejc.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Fxf9g37yt4QV3sYboUS8drWbHKZT6H8bVu/xJaEn0Rg=;
        b=wlpiCCfCKBknJUNgt+WoGSkLmwoAA5rlEV3jy+L4Gj4cNWzT+BartnyVzBjKDrpoj+
         JDRytWTSpD6OMy1U5OyQyl50NHkzLVlGtjpPGjTVC/7p6i4pWLLhzv60DN4+igU1EHOL
         jV6CddNuvWs1Cky8+BVZm91TGRCIpe2NLg/6XPBDficSHrseOQAHhJsqTi5kvngNUDbD
         fINWCB727o64jfPkmOhxI6TJD1lh8VgtS8ZLpFzya5DvdI145Rzp4eVahDwQV1L6+YsQ
         5+010mV+xB8ZCjZYWuUXTocMB7uMiMuNIHa2Tu2FjWQKGzhK8dfimmIAkZKFuYzXMWif
         kIcg==
X-Gm-Message-State: ACgBeo2BCNUzF2mkxDPK9SwL7DlMMd9ElpkZVmC6pOOTr9cDmdqNFXnM
        254zPS9MLZpm4jrbbn30QoSkuvH2lDVYgHLlCio4AMuldgw0+tCm2KI191Tn/v4GA6EQodc7x1v
        d/cwdYrvwVs9P1KNg8dVcrEVkyN/kw1EepfnWDifn
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id gs18-20020a1709072d1200b007316a4eceb0mr14858113ejc.115.1660682628499;
        Tue, 16 Aug 2022 13:43:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6mQoJ2O5YQF6G2r3WkspIUVkvBOxFCch0fVBSiDl1gYE66/cPrbW4OldsDj5twWFTyEbDTfZf7egY2AUaRKbQ=
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id
 gs18-20020a1709072d1200b007316a4eceb0mr14858098ejc.115.1660682628222; Tue, 16
 Aug 2022 13:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220811103435.188481-1-david@redhat.com> <20220811103435.188481-3-david@redhat.com>
 <YvVRfSYsPOraTo6o@monkey> <20220815153549.0288a9c6@thinkpad>
 <CADFyXm7-0zXDG+ZHjft95aAAiSZh_RyAqgJw1nGsALwEL1XKiw@mail.gmail.com>
 <20220815175929.303774fd@thinkpad> <CADFyXm40iiz-xFpLK4qGgHGh5Qp+98G9qxnqC20c8qtRiKt9_A@mail.gmail.com>
 <20220815203844.43b74fd1@thinkpad> <Yvq99MmpaGJBhlt4@monkey> <20220816113359.33843f54@thinkpad>
In-Reply-To: <20220816113359.33843f54@thinkpad>
From:   David Hildenbrand <david@redhat.com>
Date:   Tue, 16 Aug 2022 22:43:37 +0200
Message-ID: <CADFyXm5m1a+ZRwp1Kejt0L4HFcVBSoSz6mG-19_65CnR7s7Q-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/hugetlb: support write-faults in shared mappings
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, stable <stable@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerald,

>
> Thanks, we were also trying to reproduce on x86, w/o success so far. But
> I guess that matches David latest observations wrt to our exception handling
> code on s390.
>
> Good news is that the problem goes away when I add this simple patch, which
> should result in proper VM_WRITE check for vma flags, before triggering a
> FAULT_FLAG_WRITE fault:
>
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -379,7 +379,9 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>         flags = FAULT_FLAG_DEFAULT;
>         if (user_mode(regs))
>                 flags |= FAULT_FLAG_USER;
> -       if (access == VM_WRITE || is_write)
> +       if (is_write)
> +               access = VM_WRITE;
> +       if (access == VM_WRITE)
>                 flags |= FAULT_FLAG_WRITE;
>         mmap_read_lock(mm);

That's what I had in mind, good.

>
> Still find it a bit hard to believe that this > 10 years old logic really
> is/was broken all the time. I guess it simply did not matter for normal
> PTE faults, probably because the common fault handling code later would
> check itself via maybe_mkwrite(). And for hugetlb PTEs, it might not have
> mattered before commit bcd51a3c679d.

It is akward, but maybe we never really noticed for hugetlb (not sure
how common read-only mappings are after all).

>
> >
> > bcd51a3c679d eliminates the copying of page tables at fork for non-anon
> > hugetlb vmas.  So, in these tests you would likely see more pte_none()
> > faults.
>
> Yes, makes sense, assuming now that it actually is related to s390
> exception handling code, not checking for VM_WRITE before triggering a
> write fault for pte_none().
>
> Thanks for checking! And Thanks a lot to David for finding that issue
> in s390 exception handling code!

Thanks! Looks like adding the WARN_ON_ONCE was the right decision.

