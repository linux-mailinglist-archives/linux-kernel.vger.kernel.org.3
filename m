Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31358B77A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiHFSGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFSG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C82FBDEAB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659809185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmisHoI/lCDfPZbDMxGOLqAxAZBLji8djBUXQfOI7oc=;
        b=PkrkQDiZp7vMYpYASgKzjBLusVAiCzYy0asv/R7KUmYdlOvlPONXCrpJfi9S1yCmCz9qph
        edY3TYHAnl4a6Q0my15FTBYGANVBfSFody9DXfD2cF/uObfbtGUIrb4R/DBhYetMndvE26
        73+ca5+tGUwjtnCNmcH8ld3/FrQwQSk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-rsm38iKUN8ieanl-xaA19A-1; Sat, 06 Aug 2022 14:06:24 -0400
X-MC-Unique: rsm38iKUN8ieanl-xaA19A-1
Received: by mail-qk1-f197.google.com with SMTP id bs41-20020a05620a472900b006b8e84d6cddso4579167qkb.19
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 11:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=MmisHoI/lCDfPZbDMxGOLqAxAZBLji8djBUXQfOI7oc=;
        b=U6EeAgGQlXKVtCskxoc77qMMJ6ZnckgwVASWVTuQddy+ZT0vYp3ebRFX8v9A5hQ7BX
         adrN8t9+F/V5ILVbgL8Fir2SveKPqBPEFxgI4cxYCVOAfffi4422FM51l7zlej2C38xK
         KFnWiRjDeP0QIR5j0p1mQDBO1hmrnFqvj7BxBQ4iudniycTJDRPcQAjAeQfdQ9mvZcUt
         KYNG+M2TDXdrrVowHwE0+Vm5Yftg1+Vro70mcC0Gp4ygTrH+1VCiebLG1rQz6YQPqS+A
         rM9WBHF1T4Brw6uEAMEUxi+y8cW8y3tKAx7855MUOOFRNPvAyvpSUcxvnqQjuIzVt7Tr
         S7Gw==
X-Gm-Message-State: ACgBeo29quh7AfjY+1A+6oVyUB32+X9Djk0/4640oce1aTN7jpbz+ugx
        o+NnUn2TiJS4ih+rhv2zZZCMPN2kq2r1rvn5soCz56VqLwo7vf0XjAlk2ph7wUKLNcWibdjTrQS
        P5+kk/DRTXk2uqrsrVYg5Lw/m
X-Received: by 2002:ae9:ed87:0:b0:6b9:3e61:3195 with SMTP id c129-20020ae9ed87000000b006b93e613195mr1538819qkg.612.1659809184029;
        Sat, 06 Aug 2022 11:06:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Vo6rGBugeAzH08YyctSfuF8+CxDJGcujunt6vJGHFfrQp16J1rv+G4R8nDP3hAZ0/QcO+wA==
X-Received: by 2002:ae9:ed87:0:b0:6b9:3e61:3195 with SMTP id c129-20020ae9ed87000000b006b93e613195mr1538805qkg.612.1659809183822;
        Sat, 06 Aug 2022 11:06:23 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id s23-20020ac87597000000b0033f700f012csm4481122qtq.61.2022.08.06.11.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 11:06:23 -0700 (PDT)
Date:   Sat, 6 Aug 2022 14:06:10 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
In-Reply-To: <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
Message-ID: <995effeb-2b1f-ef57-5f71-846dee8da023@redhat.com>
References: <20220803104936.7df810fd@gandalf.local.home> <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com> <20220805124701.4b44195d@gandalf.local.home> <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
 <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Aug 2022, Linus Torvalds wrote:

> On Sat, Aug 6, 2022 at 6:01 AM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
> >
> > Yes, I will do that. I will also do minimal fedora install and cross-check this further.
> 
> For extra bonus points, if you can state all missing packages in one
> go (instead of "oops you don't have Xyz" followed by install of Xyz,
> followed by "Oops, now you don't have Abc") that would be nice too.
> 
> But at this point the fundamental problem with incomprehensible error
> messages is long gone, so it's not a big deal and not worth lots of
> effort. More of a "if it's easy enough.."
> 
>                 Linus
> 

Daniel, if it helps,
for Fedora I've got

Build Time Requires
-------------------
BuildRequires: gcc 
BuildRequires: python3-docutils
BuildRequires: procps-ng-devel
BuildRequires: libtraceevent-devel
BuildRequires: libtracefs-devel

Run Time Requires
----------------
Requires: procps-ng       
Requires: libtraceevent
Requires: libtracefs

John Kacur

