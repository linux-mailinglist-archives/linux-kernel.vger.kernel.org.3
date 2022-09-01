Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760B35A98F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiIANdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiIANcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:32:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB70C286F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:29:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so2548707pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=d/dtvHsGzKChCFtBhbRFZrV5ckZUGK/bJoK4hbgII4U=;
        b=lw71GbRMr86iOIzNa9lBOzhcHr3Ynvkvy2zVuyzX5264UmMPnKkxrLDwG3lKG01TEW
         OFCVJJMX1H8dTB9b8RVTZ1KncLvxhswep4ZZzaABCXzfPJ6Ies7HfO516BtXXmq7Rwsx
         vDDunr01Sxc+uuZejLYUhXPcspHRvXC4J0nQ350qCviY3JjEIW3aY2MT0rzwKy8RvfRh
         RlWBvj+UFBzNZeyZ/9D9TllJp2YOf/myzvCZTeZjSzFpgFbMpT0EcpZeJyE/4OtKFwD/
         zQXCSK+hdX1ekyHFdDrpRb38i380RI5s7TXhIAA330AVREwRvJ1caYRJ2puev5nhaSJ1
         71mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=d/dtvHsGzKChCFtBhbRFZrV5ckZUGK/bJoK4hbgII4U=;
        b=lLUR3UziNyWBUVEsBCNQAsUc5ENbSxbH/MVllNu/Kba6Y3x8J1dkadJ86QZZGJ72Oc
         Eec28MEJtYW+62TqAybvoiRMgCmIw998Q+ZCNT4JBvRhjZzLRpjRdgppJJnstYmdhRO2
         NSq/7zPDeKJC2GWEUuE9rnwB1f28lK8g0GUsfyoLXx2ciO0mYG4ftyM6d11IQv96rjwG
         e9EJOzbmuh5SSs6keWgEiEVeRxkUribjADqdP8as3m8ZFW8UJDOUiODVNnJK6iDSWMIi
         BUPeDC3a+Bg13z7GA4kQTZFsyG4KTi8dxVtP9hIwjDHjOl4+5j5raK5hbZ4WrxFF6Av0
         qrpg==
X-Gm-Message-State: ACgBeo1D8vVx8DEwt3rBfgEqb0pNGVgi4+OGDa4YgmKsvzP0S4Un5bgf
        Kam28kmGuvik3wd3H3E1hSt8Ew==
X-Google-Smtp-Source: AA6agR41KtCX/CebMwsWMiPTzySwAYrctlLIBcBhRy5/3ZUyMDdEigjfkPm6JHETgY8FWTrGkpxPRA==
X-Received: by 2002:a17:903:26c1:b0:174:ef08:6c75 with SMTP id jg1-20020a17090326c100b00174ef086c75mr16143944plb.94.1662038964840;
        Thu, 01 Sep 2022 06:29:24 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a7c0d00b001fd6066284dsm3253361pjf.6.2022.09.01.06.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:29:24 -0700 (PDT)
Date:   Thu, 1 Sep 2022 13:29:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 03/19] Revert "KVM: SVM: Introduce hybrid-AVIC mode"
Message-ID: <YxCzsFXy/sNYF0Ac@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
 <20220831003506.4117148-4-seanjc@google.com>
 <17e776dccf01e03bce1356beb8db0741e2a13d9a.camel@redhat.com>
 <84c2e836d6ba4eae9fa20329bcbc1d19f8134b0f.camel@redhat.com>
 <Yw+MYLyVXvxmbIRY@google.com>
 <59206c01da236c836c58ff96c5b4123d18a28b2b.camel@redhat.com>
 <Yw+yjo4TMDYnyAt+@google.com>
 <c6e9a565d60fb602a9f4fc48f2ce635bf658f1ea.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e9a565d60fb602a9f4fc48f2ce635bf658f1ea.camel@redhat.com>
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

On Thu, Sep 01, 2022, Maxim Levitsky wrote:
> On Wed, 2022-08-31 at 19:12 +0000, Sean Christopherson wrote:
> > On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> > > If you are really hell bent on not having that MMIO exposed, then I say we
> > > can just disable the AVIC memslot, and keep AVIC enabled in this case - this
> > > should make us both happy.
> > 
> > I don't think that will work though, as I don't think it's possible to tell hardware
> > not to accelerate AVIC accesses.  I.e. KVM can squash the unaccelerated traps, but
> > anything that is handled by hardware will still go through.
> 
> Nope! Remember why do we have that APIC private memslot?

Heh, I finally understood what you were suggesting two minutes after I woke up
this morning.   Apparently I needed to sleep on it?
