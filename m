Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560484C723F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiB1RMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiB1RMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A66488787
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646068326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZX6qo1v/jKQ+nTOg8nPNmC8+jN9MEtMjq9O50exG1fQ=;
        b=A7tHFsCLVI8bzSxlyIfLa6LfOr39u7xNgwxg6KOvvLC/xjTu0bJCB9oJsM8q5+Z47IG3zY
        oVuuJzoIYKsLc5he54gnMx5fO0fyI25eHxDSOoZEgyzruLGrldPefdYWvIFNCytRQqIz7A
        h/1VAOK8TgcoTJdki9OZQZiAXiI5pwA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-iRxIg8C3NH6Iyg37PVwo6Q-1; Mon, 28 Feb 2022 12:12:05 -0500
X-MC-Unique: iRxIg8C3NH6Iyg37PVwo6Q-1
Received: by mail-qv1-f71.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so12751436qvd.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZX6qo1v/jKQ+nTOg8nPNmC8+jN9MEtMjq9O50exG1fQ=;
        b=n07NZ1MwEQcAaFpb0NWM1vhik8//28x4EBmRQ3nqBpI2UWjiX/8pHuEzt4Y1gB1ieD
         iTj43quFHqHaMiny+NGvgDMFr58xg3K5zj226pvmqnXuk4HDaAAmWXymPhuCPCzGZtXy
         GlRPhEpC67ICafQqrtY8J53MMQ7sbG6/AZicOJJCbtYq3gJW4e1VnCTCmz47h99AVzTH
         Ijsi38diqPE3V0vnVd2zE8MIYhlKnQpw/gphvS4QTSxjK/vVtw278SLBl+G0NyPKEENg
         iUYHn+IPVE/35WGnJYYItsTDTHA/P/Kq6tv4pqV8VuztwpxwzDqrqwYAQQm3u7ZBjyMy
         PlyA==
X-Gm-Message-State: AOAM533Rv+LhmHfLBjiVk6y/PkAZ5/9In019qW091PwU/aE2uB+3M0XY
        5g4An7kovSqyhyfT7LJVaJEK/clN4rCCtZMM4FVloo6cmOgl8lyepvwKbZzqh/y/wtP19t7GZ5s
        lZfW9YJb7Icj9McTc2edCNKgG
X-Received: by 2002:a05:6214:c2a:b0:433:3463:7079 with SMTP id a10-20020a0562140c2a00b0043334637079mr1864850qvd.32.1646068324725;
        Mon, 28 Feb 2022 09:12:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwh1dfCNsb5avhgyr0Ys+Z3P/6xCFr1NJAS1as5YaLdjeBAdkNCjsNwWtzvJjWri9IQSCGHng==
X-Received: by 2002:a05:6214:c2a:b0:433:3463:7079 with SMTP id a10-20020a0562140c2a00b0043334637079mr1864823qvd.32.1646068324427;
        Mon, 28 Feb 2022 09:12:04 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id r14-20020a05622a034e00b002de72634a7asm7046032qtw.37.2022.02.28.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:12:03 -0800 (PST)
Date:   Mon, 28 Feb 2022 09:11:59 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [PATCHv4 01/30] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
Message-ID: <20220228171159.pkp3t46pxbs6o2ul@treble>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
 <20220227220130.23yjme7jucxo266l@treble>
 <20220228162056.gul22bjr4w6zjslq@black.fi.intel.com>
 <20220228164007.nfrg7xvrl4blzzrm@treble>
 <080f9306-8c72-c7bd-010a-f0ed32c4b692@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <080f9306-8c72-c7bd-010a-f0ed32c4b692@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 08:51:20AM -0800, Dave Hansen wrote:
> On 2/28/22 08:40, Josh Poimboeuf wrote:
> >> maintainer-tip.rst seems disagree with you:
> >>
> >>    A Fixes tag should be added even for changes which do not need to be
> >>    backported to stable kernels, i.e. when addressing a recently introduced
> >>    issue which only affects tip or the current head of mainline.
> >>
> >> I will leave it as is.
> > How does that disagree with me?
> > 
> > The "Fixes" tag is for bug fixes.  If it's not possible to trigger the
> > warning and there's no user impact, it's not a bug.
> 
> Does having Fixes: *break* anything?

People rely on the "Fixes:" tag for actual bug fixes.  Using it here --
along with the rest of the "this is fixing a bug" tone of the title and
description -- is guaranteed to confuse stable maintainers and distros
doing backports.

Again, if nothing's broken from the standpoint of the user then it's not
a bug and shouldn't be reported that way.

> If not, I think I'd generally rather have the metadata with more
> information as opposed to less information.

I would call it misinformation.  How is that useful?

It's ok to reference a related commit in the patch description itself.
Just don't abuse the "Fixes" tag.

But IMO, for the least amount of confusion, it makes more sense to
squash this with the patch which actually requires it.

-- 
Josh

