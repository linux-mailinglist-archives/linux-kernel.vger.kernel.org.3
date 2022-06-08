Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6573543D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiFHTtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFHTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:49:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4311D4222
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:49:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o17so18550602pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VEjo109UU6vyMJaWpJ5ZAEaj/fsluHwQF6ABTzm5Vqk=;
        b=OKAfshPLtVGbddgYGpjaJH6MWgYvGLHZOYpCNxSFAc51y9hzgRZqZbv3+VLDsV/rPN
         Ldv4+Bl9aCJE58WvgIvf6qeT2We6fXT2veKEpCNSDpLYZj3UeeAHFcVOXyAmEVTp+vGw
         ku1L+JpJ87qN2eW1kwBVF/Lcm7kh+sKLvgpw5JNZLj1fo116MWqG4fd0tbJH024xsmwn
         yHzudUEZgfRiOxxBfrBR0kallfrK6nIfhIPivNpeqwewkKKfE0qJ8nac8nqkrERYmTYy
         XkOd0rjQhQfHBVBV8kbnBos7tJ1D9r3+uFCuEBwtRJvZ/ZAZxYfvA/22S9Y9qiiqaipA
         2V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEjo109UU6vyMJaWpJ5ZAEaj/fsluHwQF6ABTzm5Vqk=;
        b=Q4RkRFlCLlxviJ7CziCdRfWrECr0s2qqiXzB6Dh8C2Yl+39uJNssfJmm7fl/nWUzW1
         4C/PSpBfpOpq0dOx7P8FelXRJtDCS1oC1dihob1QIvAwIno7tGQ03/aNPKJ/5bDU7ccw
         KuPatgUmFr18lkjszmeZX6sR7j+lwQhYAeQJ4qWEkHYSwtQjrZOvdcKbYCIdJG3EMmph
         si3DLTtDQiOa7k/QckJC5eCzmAOQ66Az7x4B3R4sPZzmcI0gL5+3RgkgX78VfNuIECbA
         dUM29q1PrtHXGTHwndWbqNOLV0YjB4RBwy0f0OGv2NHZx47X8ba3XYM50jxGr8Lxx2h9
         FPjA==
X-Gm-Message-State: AOAM532APibD7F7UN7PU5KgfDjQ6gzmjr5poah3kAsmTuEoukmlsVNK1
        PzrLIpwlWQ1tpINKbURFeCyllg==
X-Google-Smtp-Source: ABdhPJxzoSD/U+UWEntTfAhoBbf8dbSHxS3qOPycaK0n9wSvvXjHFLbT0tyoXEtV4jK3PbZHG85Ivw==
X-Received: by 2002:a17:902:b70c:b0:156:16f0:cbfe with SMTP id d12-20020a170902b70c00b0015616f0cbfemr35623819pls.152.1654717774882;
        Wed, 08 Jun 2022 12:49:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709028c8600b001636c0b98a7sm15084461plo.226.2022.06.08.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 12:49:34 -0700 (PDT)
Date:   Wed, 8 Jun 2022 19:49:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 038/144] KVM: selftests: Push
 vm_adjust_num_guest_pages() into "w/o vCPUs" helper
Message-ID: <YqD9SshYPF9ZV+Hc@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-39-seanjc@google.com>
 <20220608143828.b7ggvuptlngmnqvp@gator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608143828.b7ggvuptlngmnqvp@gator>
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

On Wed, Jun 08, 2022, Andrew Jones wrote:
> On Fri, Jun 03, 2022 at 12:41:45AM +0000, Sean Christopherson wrote:
> > Move the call to vm_adjust_num_guest_pages() from vm_create_with_vcpus()
> > down into vm_create_without_vcpus().  This will allow a future patch to
> > make the "w/o vCPUs" variant the common inner helper, e.g. so that the
> > "with_vcpus" helper calls the "without_vcpus" helper, instead of having
> > them be separate paths.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 1c5caf2ddca4..6b0b65c26d4d 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -282,6 +282,8 @@ struct kvm_vm *vm_create_without_vcpus(enum vm_guest_mode mode, uint64_t pages)
> >  {
> >  	struct kvm_vm *vm;
> >  
> > +	pages = vm_adjust_num_guest_pages(VM_MODE_DEFAULT, pages);
> 
> Hi Sean,
> 
> We should pass 'mode' here.

Ouch.  Very nice catch!  Lucky for me, the resulting conflicts later in the series
are obvious and straightfoward.

Thanks much!
