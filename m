Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93A4B59B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357377AbiBNSO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:14:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357371AbiBNSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:14:55 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35F6541B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:14:45 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bx31so23509748ljb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=za1XMQmDSvo1tI1nYjjULb15Ic/yfPGol3r5k5Fjeac=;
        b=V+B92DzLSwMBpjaeppdbk+sAoKjZyUQ/OkQuTlh+advSeJZ9o8fPIxWeIx7+AxQKpB
         ycAXqXNyBB+AapMyKSNHaZJ7HL1Va+uEb7lfmh2AV1MfBNopCD+DWsY9qFifDO0ZbPLZ
         8xSB5iHB35K56klYlTL1Ne9fKNWQWwPZd7Po3/ExMzbeYVsXqZujuaCJm/Wz0c5r6Xes
         a27j6r44Juz6t5pHXiUP2Fw6QXMGWpnFEhCPPS7xXrhEb63E7ymJjYtUU+e9HZwCMPIv
         eiFsgOCKmk12fLU4lBG8QNAuU65+Ch1IToVC9poY2QlUZYBuVpX7hIJylVRnbs0mi/qe
         JgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=za1XMQmDSvo1tI1nYjjULb15Ic/yfPGol3r5k5Fjeac=;
        b=4W7ZPbpIIrL01Gbv2jCKYQyRcbESYSsUSZ4mY8V8JFd0ol/nV56dMyqu4eEa5dxCfG
         kch8gD633DtpW0M9qXf2t/k269Ry9Z/IhnqNdeCsKeHIjkET/HIPjG+HYqH+yERx4q8F
         fOsrdFzuJ2ymSlFKsDf2Zt7hmv4pequ2iPUDa9fiaenY4+XedHq4A8ajQi1jWykc5jqI
         gKLOuP9qI6qLInzf5+qkOhw5KP59rIltPo4/jfA6yVq5k9ng4hDs1zAv7AwH0vBcVTQt
         3Pzz7Z8zc132uBUc/S2l8IBpVO6e1EEFle9vX8cxok2eiofgivgCYvP3I7ahOxxCN4sW
         cGRg==
X-Gm-Message-State: AOAM532vGFP8WT2O5pMpeXjV1ffQJkhM0XNOxA6xjDwjKkOb7R+o/xGQ
        QF+99zH0aavwE4pd2QLLJBIApvCC7BMkWQ/4NE6zxw==
X-Google-Smtp-Source: ABdhPJxiu2ox2DHHG9pa9Pb9YzXWa4RTT8ly/QBgDWP1BBh9UF2nElrWB29CHHW3YhppFsZOhJ4rQ+DDijHwHUER8/8=
X-Received: by 2002:a05:651c:1a22:: with SMTP id by34mr645542ljb.331.1644862483359;
 Mon, 14 Feb 2022 10:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20220204115718.14934-1-pbonzini@redhat.com> <YgRApq20ds4FDivX@google.com>
In-Reply-To: <YgRApq20ds4FDivX@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 14 Feb 2022 10:14:16 -0800
Message-ID: <CALzav=ee3JBR+L2uZOaB-ijakMoabEXJLLozy56SQJL+m9KC2Q@mail.gmail.com>
Subject: Re: [PATCH 00/23] KVM: MMU: MMU role refactoring
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Wed, Feb 9, 2022 at 2:31 PM Sean Christopherson <seanjc@google.com> wrote:
> On Fri, Feb 04, 2022, Paolo Bonzini wrote:
> >   KVM: MMU: replace direct_map with mmu_role.direct
>
> Heresy!  Everyone knows the one true way is "KVM: x86/mmu:"
>
>   $ glo | grep "KVM: MMU:" | wc -l
>   740
>   $ glo | grep "KVM: x86/mmu:" | wc -l
>   403
>
> Dammit, I'm the heathen...
>
> I do think we should use x86/mmu though.  VMX and SVM (and nVMX and nSVM) are ok
> because they're unlikely to collide with other architectures, but every arch has
> an MMU...

Can you document these rules/preferences somewhere? Even better if we
can enforce them with checkpatch :)
