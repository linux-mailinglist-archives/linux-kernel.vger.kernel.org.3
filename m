Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E02545002
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbiFIO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiFIO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:57:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9033A2B8B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:57:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e66so22035244pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IwDbyRBH5j46NT03MVkQ+aJLs/1CaN0IJ5TDlMIAfBI=;
        b=fjTHNXi4aftLJVuc/cEp6jjK3k29Ix9OrTzcyy1oa7SAdPXZSzaxsOIPbTUYTGFJSs
         BWXGkdYL+toNdSUlla8e1tzA8XvU+SuYcF9qT9MZoTgSnsIodfuQG8W+gvHMhbD9ugnC
         RYa1Vbmp31AlKQ99WCVDCpRBbWIIt//yyrDKWIzYyUJhP4EIJIHWOXo9GixhQl5ZvI/I
         CZOp9UGvyAgGGXbYnAr+z14NT28fPIMt05tKz4+AS5w4IrRYsG1l39jWy1cnvXSAl1zM
         m02QVEcBU2X4rKM0flG53bC5ins0xHtel97lPgLGzXu+o5gagEE4Qecf36U6IR7DMXlq
         HDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IwDbyRBH5j46NT03MVkQ+aJLs/1CaN0IJ5TDlMIAfBI=;
        b=kzROATosLi4BkD6FJ7/jX2JiCdJDIIuZIsPzEnwpH8fEJynmgfn5O8RqdKeG08cYeD
         j0BwOmKc0aSFGe6hmt7QlxXl1RRL+BQOTOOUSpsR3ZccuPQtUIIy6EKlgW4s7WMXx/su
         eZNq8nJanNJdzG0AMRrrZ9jzWNuZx9XEPwcPtvwVWrYxhHoWNO4OPQq40h25u3KVa5P7
         OHSbZoGPCSp1nQdjtymz9ZdKlwbWb+jHIJencJxgdHtVHchCCu4q0ID4Li7bR9laXfx6
         BxbvSweIxnj8Fs9a66W8VC2rwl/LgF94ynVWgI6py5Gxe/H6V6yI9alL+yYHRH5t5Nir
         +Frw==
X-Gm-Message-State: AOAM533HrKPObm/kUrgaf7NPxeQIZ95ndmKTjH49A+iI+6oChsywZ3W/
        Ycl15ZxPdK/b5OVwaukmctefug==
X-Google-Smtp-Source: ABdhPJwr2XBzQiTa3FF7hr1nqL+GuDlbUCI3Wc1P+pTo7y1/QJ5aWp9bsB6hfaxgag15XKau9x6mYg==
X-Received: by 2002:a05:6a00:158e:b0:51c:2a89:3845 with SMTP id u14-20020a056a00158e00b0051c2a893845mr17988818pfk.64.1654786660858;
        Thu, 09 Jun 2022 07:57:40 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b00161a40b2135sm17062716pld.104.2022.06.09.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:57:39 -0700 (PDT)
Date:   Thu, 9 Jun 2022 14:57:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        KVM General <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <YqIKYOtQTvrGpmPV@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <CAAhSdy0_50KshS1rAcOjtFBUu=R7a0uXYa76vNibD_n7s=q6XA@mail.gmail.com>
 <CAAhSdy1N9vwX1aXkdVEvO=MLV7TEWKMB2jxpNNfzT2LUQ-Q01A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1N9vwX1aXkdVEvO=MLV7TEWKMB2jxpNNfzT2LUQ-Q01A@mail.gmail.com>
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

On Thu, Jun 09, 2022, Anup Patel wrote:
> On Wed, Jun 8, 2022 at 9:26 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Tue, Jun 7, 2022 at 8:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > Marc, Christian, Anup, can you please give this a go?
> >
> > Sure, I will try this series.
> 
> I tried to apply this series on top of kvm/next and kvm/queue but
> I always get conflicts. It seems this series is dependent on other
> in-flight patches.

Hrm, that's odd, it's based directly on kvm/queue, commit 55371f1d0c01 ("KVM: ...).

> Is there a branch somewhere in a public repo ?

https://github.com/sean-jc/linux/tree/x86/selftests_overhaul
