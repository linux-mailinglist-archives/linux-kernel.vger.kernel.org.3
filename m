Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3846EC3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbhLIPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbhLIPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:53:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264DC061B38
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:50:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id p13so5796911pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opll92z9ujZP79gGmlECeOewebbDh/wvZxPmkdeuXT4=;
        b=rheB96QWK2vg5pjLH0AnVJ3LgtUJc4iwNoQLktg4zUxCIt5jeSPLni54FphDF1KABr
         bJjtQhqgF0II+TNOqGeH0XWP6ddvYPjg+yBrMdTzeYCgnYmuZLv68eNhq/LJE+uM9TB9
         Z2Ix8Qyj9auuVsD8bCkvNkUS9Db5NPL3Eo4M8yzYEkXTSbMTrTwv5MXPwZMXqTBrdIWy
         dKaIC4vrqwtNTM5l3F3wvqv2b0Ap+gzTS+RIEFWOZrqxpX4+kC94RvxzTa3RM613sTaU
         hqjqLryWQceVqoe+bgonj/NTIrselTLgJQ2HQm4dEiz26qYf981kN3/PL0BYhx5i3WEE
         aV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opll92z9ujZP79gGmlECeOewebbDh/wvZxPmkdeuXT4=;
        b=N0JgIp4RlfyJNEbWbalHrWM2J49QpO2f5+tQ9Lz/CCUmktBBI5PffTPaU1vwXXD39R
         fNBekdH3LohfXQ+o82sA22WgcmGuuMssNGKPH/dV8oNuk1WqMU/QfcIMBcqcoKns+d4N
         //C0IA48X1FPUDLrKABc9nILou3orjYq0VGMpertCp+b3DWhA1iCq7plPXlHUxp8e1Tg
         DTP/fpc1HynLPGv4rnbz0hi1bympRV7djnqBattLXgCooloX+D+WmPoqrxganmzH/NQd
         HzTcltk6stt2KOgMklBSkbk+4L7+7Oe4J7CkiGzcCt0Vsv+Vfu3MIUq22cQa+vQ6xTBG
         dzGg==
X-Gm-Message-State: AOAM531onFavQ0XA7tkBImew0ArPAQ0OeXtGH5Kax4Hd3JRjA8cmWNlq
        L6RJObcaZby+R3dR2bjSb3RHiqT1BhgFmw==
X-Google-Smtp-Source: ABdhPJyeqnC/JhNrKE1UZQ5/PYeMe6yyTckxBZB2WNiBS+sShVoLVkpS1ylEYqibl6fhruQB3eltkA==
X-Received: by 2002:a65:6251:: with SMTP id q17mr36669117pgv.403.1639065007856;
        Thu, 09 Dec 2021 07:50:07 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e14sm148295pfv.18.2021.12.09.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 07:50:07 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:50:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: x86: Rep string I/O WARN removal and test
Message-ID: <YbIlq+RBx0f/wMiL@google.com>
References: <20211025201311.1881846-1-seanjc@google.com>
 <YbGYuDgaqcRH/CZo@google.com>
 <57c83b62-675f-d368-e09f-7f97d3a7e3fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c83b62-675f-d368-e09f-7f97d3a7e3fb@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021, Paolo Bonzini wrote:
> On 12/9/21 06:48, Sean Christopherson wrote:
> > On Mon, Oct 25, 2021, Sean Christopherson wrote:
> > > Remove a WARN that was added as part of the recent I/O overhaul to play
> > > nice with SEV-ES string I/O.
> > > 
> > > For the record, my FIXME in lieu of a WARN was deliberate, as I suspected
> > > userspace could trigger a WARN ;-)
> > > 
> > > Based on kvm/master, commit 95e16b4792b0 ("KVM: SEV-ES: go over the
> > > sev_pio_data buffer in multiple passes if needed").
> > > 
> > > Sean Christopherson (2):
> > >    KVM: x86: Don't WARN if userspace mucks with RCX during string I/O
> > >      exit
> > >    KVM: selftests: Add test to verify KVM doesn't explode on "bad" I/O
> > > 
> > >   arch/x86/kvm/x86.c                            |   9 +-
> > >   tools/testing/selftests/kvm/.gitignore        |   1 +
> > >   tools/testing/selftests/kvm/Makefile          |   1 +
> > >   .../selftests/kvm/x86_64/userspace_io_test.c  | 114 ++++++++++++++++++
> > >   4 files changed, 123 insertions(+), 2 deletions(-)
> > >   create mode 100644 tools/testing/selftests/kvm/x86_64/userspace_io_test.c
> > 
> > Ping.  I completely forgot about this too, until I unintentionally ran a
> > userspace_io_test that was lying around.
> > 
> 
> Queued now, thanks.  I don't know if I want the honor of having KVM singled
> out again on the -rc release message, but these are bugs nevertheless...

Heh, you could always wait an -rc to send the fixes and hope Linus has a short
memory :-D
