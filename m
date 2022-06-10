Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A08545962
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbiFJA6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiFJA6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:58:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0441A506DB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:58:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i15so4815488plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 17:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7SW/nOLns8Fu4l8nto08TFqxZTKRWZDmtRYj6hSbnDk=;
        b=OAlS4FmSB660LfOyAPLOMlFeKjQ7shZBM3rmiFuoCMSypriemBC3DnJFLqq+DZg9uI
         aZ+YjI5KvYedG/X6AGkk7sY0yJXMJsrDeCh44jrz/rdgE/kz2bzzR4hGMR8K6jTimI4q
         bqKdnb7B17/nPIHi6Wzmebn1dZOCKcjvPsVzGk0UUI/nbvXCOr1Pn/8g6xfwSlRlsK1H
         EHnmBJ8lEuhZ6B9sYshP1/gO5Y/f4tz5A4gkenONLiWxG94ntrpE69+a6G6T1ARXOQ93
         SfzZK12YqW/iXZFeuNFrQidpM5C0ovAYsi8K0bO67w10fAv+LoAWAhiyud+Im00rFHsN
         E+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7SW/nOLns8Fu4l8nto08TFqxZTKRWZDmtRYj6hSbnDk=;
        b=QpEP1NhgHbY4jeV/7lzxvMh1PvRp+G1Hs9MrAIbWpTnMhjW5E7/kwFq8cwO6dNp/QN
         yhqMPpnGVCqeWFhVvWndU4T7A0V5ZHSGcGetniDDTfVMMOKj1UY219MvE/ssf69wzUKg
         esqALwtkkKU54ypXEWu6z7uKEdt1rOwk0+/g1FXjYmiChs5NZJNm7n0E1nmIS2Vb4JDu
         Rr994rY/631CQmHS1dvxUw1l/7Yuk4hCa//zWcK5QkJj47WbnhpNCOQP+DPbarxoP7z2
         4AG0zpSpF5NZdqA+DDEYOVuCJsp7CsMTNg5nRmf6PxXHb+o9AIr5oxdhXg0TX9wi3f2S
         dxDQ==
X-Gm-Message-State: AOAM533ySoVTKMvHptcpAOyBe99Uw1Cm56YE51xo0i/O3Mkf+HGb6OyF
        NVoMdDOBiguq/a6Fg2EnTilXd+kjKdwMvQ==
X-Google-Smtp-Source: ABdhPJxAIkeHaFSZm5dAiXgxfFJUlw7f5e9kMQ0XVzdhRDn8O+RHvhgZJbnjbL8SOAojOwn9DZKbEQ==
X-Received: by 2002:a17:90a:5d04:b0:1e0:83d7:413c with SMTP id s4-20020a17090a5d0400b001e083d7413cmr6139295pji.201.1654822679344;
        Thu, 09 Jun 2022 17:57:59 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q133-20020a632a8b000000b003c14af505fesm17949731pgq.22.2022.06.09.17.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:57:58 -0700 (PDT)
Date:   Fri, 10 Jun 2022 00:57:55 +0000
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
        Marc Zyngier <maz@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <YqKXExV4BOVRbOVc@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <CAAhSdy0_50KshS1rAcOjtFBUu=R7a0uXYa76vNibD_n7s=q6XA@mail.gmail.com>
 <CAAhSdy1N9vwX1aXkdVEvO=MLV7TEWKMB2jxpNNfzT2LUQ-Q01A@mail.gmail.com>
 <YqIKYOtQTvrGpmPV@google.com>
 <YqKRrK7SwO0lz/6e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqKRrK7SwO0lz/6e@google.com>
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

+s390 folks...

On Fri, Jun 10, 2022, Sean Christopherson wrote:
> On Thu, Jun 09, 2022, Sean Christopherson wrote:
> > On Thu, Jun 09, 2022, Anup Patel wrote:
> > > On Wed, Jun 8, 2022 at 9:26 PM Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Tue, Jun 7, 2022 at 8:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > >
> > > > > Marc, Christian, Anup, can you please give this a go?
> > > >
> > > > Sure, I will try this series.
> > > 
> > > I tried to apply this series on top of kvm/next and kvm/queue but
> > > I always get conflicts. It seems this series is dependent on other
> > > in-flight patches.
> > 
> > Hrm, that's odd, it's based directly on kvm/queue, commit 55371f1d0c01 ("KVM: ...).
> 
> Duh, Paolo updated kvm/queue.  Where's Captain Obvious when you need him...
> 
> > > Is there a branch somewhere in a public repo ?
> > 
> > https://github.com/sean-jc/linux/tree/x86/selftests_overhaul
> 
> I pushed a new version that's based on the current kvm/queue, commit 5e9402ac128b.
> arm and x86 look good (though I've yet to test on AMD).
> 
> Thomas,
> If you get a chance, could you rerun the s390 tests?  The recent refactorings to
> use TAP generated some fun conflicts.
> 
> Speaking of TAP, I added a patch to convert __TEST_REQUIRE to use ksft_exit_skip()
> instead of KVM's custom print_skip().  The s390 tests are being converted to use
> TAP output, I couldn't see any advantage of KVM's arbitrary "skipping test" over
> TAP-friendly output, and converting everything is far easier than special casing s390.
