Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519184C71E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiB1QpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiB1QpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6100694AD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646066677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sVkgrQx4/hFskalMNfAttIkAMngSgQhSsCGyOZ8Ebfo=;
        b=AD1/5QUO0WY5LvO3KupCtmLKtAlx9lFvoBcLb4pqLnUdDuj4X6bksG6/F6h+RUiKEg7K2h
        V3dG6HNT/Rb5Bc/NoWF7GvxHlp0YiBYkEVcZgZB+jLRXrZZfl7tyFBp31HZgflXfJqfDED
        6Bnpx+jt0BvYahUsCgdus67lw6NUU8I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-coYP04JEPHmDBRye27VzXA-1; Mon, 28 Feb 2022 11:44:36 -0500
X-MC-Unique: coYP04JEPHmDBRye27VzXA-1
Received: by mail-qk1-f197.google.com with SMTP id r20-20020a37a814000000b00648f4cddf6bso11638835qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sVkgrQx4/hFskalMNfAttIkAMngSgQhSsCGyOZ8Ebfo=;
        b=HE2Jmtkt5vf5aIavcnrhFTA4VpM7HwhSm5tr/tQsmGreEclJznG8F4S1qRojT+hb8Z
         +Wn5dGjrZZUs7r8gunrlGiJ6GJGtGh5wIeGwUV+0QbAzcMdOH1SB7Fucs9AOrpDtUrL9
         dpNwhFw+TdIIL7+9GIIm38+VI0E0JdVrP0YTYWT0Auv/e4b+wdSYFsyBOr2kWxZ0SLcR
         MqoktyP5/CieIB7PJPsxxpYJIAbWuELTAGkYhCXkNdlYs8LK3qtfEecH0tILMsY/8641
         yObz8BgHqNu6ph/UGwVGD3EViSwnY3WnxfRTfwSyZQkIk7ECp6pDB1M7mMEg9KjUhQQs
         +QYw==
X-Gm-Message-State: AOAM531m1jKSdQ0YXPVigkiuqNGye5biKg2tbuSdxv2yxosbK3WouJHD
        D0PjTnNppDz3K482s8EShhHrQMlWH9NQ5/nSi7rwvh9k3WwmKfNsBQUjQdz3E0fGXPTvxU7pqnC
        9sK5KpbW5E+e1NZuKfL3yAOdv
X-Received: by 2002:a37:9e86:0:b0:507:42b:7540 with SMTP id h128-20020a379e86000000b00507042b7540mr11554025qke.159.1646066676088;
        Mon, 28 Feb 2022 08:44:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8GYDO/W+wtFA8bzurOKX7n/pjCYKWYUslsiKvaGl8LxgY7gGD0gf0ofbgVorZpuNIYwd2Gw==
X-Received: by 2002:a37:9e86:0:b0:507:42b:7540 with SMTP id h128-20020a379e86000000b00507042b7540mr11554012qke.159.1646066675821;
        Mon, 28 Feb 2022 08:44:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id j10-20020ac85f8a000000b002dde6288fa7sm7386432qta.83.2022.02.28.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:44:35 -0800 (PST)
Date:   Mon, 28 Feb 2022 08:44:30 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 15/30] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220228164430.7uveususkg4upihq@treble>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-16-kirill.shutemov@linux.intel.com>
 <20220227220219.6myd32n6oojwbnyh@treble>
 <20220228163353.d6redrbv3kpb557n@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228163353.d6redrbv3kpb557n@black.fi.intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:33:53PM +0300, Kirill A. Shutemov wrote:
> On Sun, Feb 27, 2022 at 02:02:19PM -0800, Josh Poimboeuf wrote:
> > On Thu, Feb 24, 2022 at 06:56:15PM +0300, Kirill A. Shutemov wrote:
> > > Port I/O instructions trigger #VE in the TDX environment. In response to
> > > the exception, kernel emulates these instructions using hypercalls.
> > > 
> > > But during early boot, on the decompression stage, it is cumbersome to
> > > deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> > > handling.
> > > 
> > > Add a way to hook up alternative port I/O helpers in the boot stub.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > I think you missed my comment from v3.
> 
> I did not missed it, but I failed to acknowledge it.
> 
> To me it is a judgement call. Either way has right to live.
> I talked to Borislav on this and we suggested to keep it as. Rework later
> as needed.
> 
> > Repeating it here:
> > 
> > At least from reading the commit message it's not self-evident why #VE
> > handling would be worse, especially since there's already #VC support in
> > boot.  It would help to give more info about that in the commit message.
> > 
> > The current approach also seems fragile, doesn't it require all future
> > code to remember to not do i/o directly?  How do we make sure that
> > doesn't happen going forward?
> > 
> > How does it fail if some code accidentally does i/o directly?  Or
> > triggers #VE some other way?  Is the error understandable and
> > actionable?
> 
> Dealing with failure in decompression code is a pain. We don't have usual
> infrastructure there. The patch deals with port I/O which is the only way
> to communicate issue to the user. If it fails for whatever reason we are
> screwed. And it doesn't depend on how it was implemented.

In the patch description, please address all of my concerns and
questions.

-- 
Josh

