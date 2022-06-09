Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63F8545527
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbiFITsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiFITsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:48:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355453A8F93
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:48:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o17so21067930pla.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nXEceEngZ7WCunTddR9XXHFw5048HaJXvLYe+oVs8EQ=;
        b=f3YofbG6O3DXat2Z5Fk1DvlH7dqsre3W33HaF4Zap2+S9uPch4cTzGocNe+WQ7O8Sg
         eMRyUSjv6vKn6IOGaPGEINVU3zhjfrVOGUjY8OuVXWTu5yNpFuZprDPKHh5k8UvpLS35
         1f/Ezk9N31CA1h7cyX/8+D9PQFFvgZippNtNEAWo+zs0oVTzBvSCIp3S9spyVbMCUdLP
         TNUxb6HJfVmmHMxZ6f7JOdTnHoZQcp4BEYYwe0foOwXtECyoKsG9hBGuGCfxXrEruTBo
         7znnSnrgKmnfGJtU3ztx9xdnHUhr+rqmZ4NQ0LExyU4YcAaQJiqSPrIJr+EZqEHtB63O
         xQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXEceEngZ7WCunTddR9XXHFw5048HaJXvLYe+oVs8EQ=;
        b=Aj/8zFpQCnQj/1tkjFS5rIqtpEv8hFBaNyQzat6evC/KylZO2wNDaWFYskBMhIV6G0
         vTec6IbUC509ofzWV5efcEbWi898L46PlIKFEXoVHlzTv+D2a4TooN5AJ0Adnc7HAlro
         5sVyIXDFpnJ1L/wEyeSX5BDNMeK5HWzTvio0Nh1UqJ8AWp6c8mlMak4BXGxmZ2P/C2xr
         liXOFx/YhmsMpPqbnX0ACP0SBeM/iXvsqV2sUZtD/WJcFu8BCFdmnN2cJOq13sgle9/m
         lXcxzdGFC+JTQ4J+Mc4Qkt7y/qxucy5kjcqUXsc3YCETRLNLJ7PLkPcA4m8o4Gn9h8fN
         dRYw==
X-Gm-Message-State: AOAM531QwIQ1zG2FurIkEkvH34SuJ1S2KbhYLJrft9I3qzgBWrR1nNSU
        nuv/bPNn1xpAJOraz+QjOawVxg==
X-Google-Smtp-Source: ABdhPJxkzOCwThQpBmILmmWW81/sQwDdYPkN9tMdQS1cLfvLlLVKNOAUAbg89SZVyxibYIfRduZq3Q==
X-Received: by 2002:a17:902:d2c7:b0:167:7637:7023 with SMTP id n7-20020a170902d2c700b0016776377023mr24137420plc.18.1654804124518;
        Thu, 09 Jun 2022 12:48:44 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001688f2ff292sm4846499plb.222.2022.06.09.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:48:43 -0700 (PDT)
Date:   Thu, 9 Jun 2022 19:48:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Raghavendra Rao Ananta <rananta@google.com>,
        eric.auger@redhat.com
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <YqJOlysCQLGSrt7h@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <93b87b7b5a599c1dfa47ee025f0ae9c4@kernel.org>
 <YqEupumS/m5IArTj@google.com>
 <20220609074027.fntbvcgac4nroy35@gator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609074027.fntbvcgac4nroy35@gator>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022, Andrew Jones wrote:
> On Wed, Jun 08, 2022 at 11:20:06PM +0000, Sean Christopherson wrote:
> > On Wed, Jun 08, 2022, Marc Zyngier wrote:
> > > On 2022-06-07 16:27, Paolo Bonzini wrote:
> > > > Marc, Christian, Anup, can you please give this a go?
> > > 
> > > Can you please, pretty please, once and for all, kill that alias you
> > > seem to have for me and  email me on an address I actually can read?
> > > 
> > > I can't remember how many times you emailed me on my ex @arm.com address
> > > over the past 2+years...
> > > 
> > > The same thing probably applies to Sean, btw.
> > 
> > Ha!  I was wondering how my old @intel address snuck in...
> > 
> > On the aarch64 side, with the following tweaks, courtesy of Raghu, all tests
> > pass.  I'll work these into the next version, and hopefully also learn how to
> > run on aarch64 myself...
> > 
> > Note, the i => 0 "fix" in test_v3_typer_accesses() is a direct revert of patch 3,
> > "KVM: selftests: Fix typo in vgic_init test".  I'll just drop that patch unless
> > someone figures out why doing the right thing causes the test to fail.
> 
> CCing Eric for that one.

> > @@ -424,7 +424,7 @@ static void test_v3_typer_accesses(void)
> >                             KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
> > 
> >         for (i = 0; i < NR_VCPUS ; i++) {
> > -               ret = v3_redist_reg_get(v.gic_fd, i, GICR_TYPER, &val);
> > +               ret = v3_redist_reg_get(v.gic_fd, 0, GICR_TYPER, &val);
> >                 TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");

Figured it out, "val" should be "i * 0x100", not "0".  The asserts in this test
are awful and don't print the actual "val".  test_assert() shares part of the blame
for printing a stale errno, but holy moly this test makes it painful to debug
trivial issues.
