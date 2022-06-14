Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36D54AB38
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354893AbiFNHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355810AbiFNHxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 388C841984
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655193169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnHP5HpQogaWTOAPZ0p9wI4hJWfzi2FApEgb9iVePvA=;
        b=DvDcAhHEiPwHRy9iYFciuyPitKtAQ+Y1WWfnSzIV0nqtIdeHxGX1zz13aCs6mqBWl9WsPy
        pR0ul57NrNPVi/ND1ghN6W1cdfVJSRWZ5Pf8SfTB1q1dDwI8AWYEWUoNAMM2W5F05oDGM0
        Blw3wuOhG0JA3sDUM/yNLQOSjWEnulU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-ZbBZRNsCPDGh8U-5ck_jGg-1; Tue, 14 Jun 2022 03:52:47 -0400
X-MC-Unique: ZbBZRNsCPDGh8U-5ck_jGg-1
Received: by mail-ej1-f69.google.com with SMTP id q5-20020a17090676c500b00704ffb95131so2543726ejn.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnHP5HpQogaWTOAPZ0p9wI4hJWfzi2FApEgb9iVePvA=;
        b=umzXVveYEYeHGWbcF+HrEFGrqThmsqsQpKClga77MYBMSjs6ErPitCIangl0bF+dYs
         DeROM/HsfoSthutx0wqjjJN3guX5D9nThn0bcvbcX1Hb/vQAtLu10CjHQV32+KdP+7Iq
         BkAhCmc0/ZyycLGDKZZBXDdBHDogZ0Suvfw4+SFbPdJB8hs8MzvM35XiFHKrDQe72yyX
         v03yusYINnLgEcpLJcJvA6HMLisbFrCHIqBUwXxOnVx8ZDqqoYI+g7iorgYTE/EHRs94
         EislKpjLutSmda7WD5ScgcjwrNYtoTZxYaaY8wN8bzF2ebcEVL5nvrFkJqxv6F0GoV0S
         AHAw==
X-Gm-Message-State: AOAM532CQMDgqE1HvOJemf8LmSqBxex/U+Hilsb6KakeMK66HaIpG2Jz
        AeHpOdKbkPYIRpZqVTPR91P4xi4+ArQPWKcv1JFzcw+Mu490yGZWyxSDb7wh6HRkda4WLpr2hC/
        QBHHHdiw5mPiHgwKPxycRctH3
X-Received: by 2002:a50:c407:0:b0:431:39ed:1c5e with SMTP id v7-20020a50c407000000b0043139ed1c5emr4325804edf.402.1655193166823;
        Tue, 14 Jun 2022 00:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqsqRtQjOIkakSdUAAA8ijFKx/TiXJdlhre2jr0Rlz8xFe54ywLyWRD87oXQ0HPlxqDvfsnQ==
X-Received: by 2002:a50:c407:0:b0:431:39ed:1c5e with SMTP id v7-20020a50c407000000b0043139ed1c5emr4325794edf.402.1655193166678;
        Tue, 14 Jun 2022 00:52:46 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id pv17-20020a170907209100b00704757b1debsm4734510ejb.9.2022.06.14.00.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 00:52:46 -0700 (PDT)
Date:   Tue, 14 Jun 2022 09:52:44 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: selftests: Fixups for overhaul
Message-ID: <20220614075244.yux5owiik2tmdgkj@gator>
References: <20220613161942.1586791-1-seanjc@google.com>
 <20220614075106.463oqkerlaximxfl@gator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614075106.463oqkerlaximxfl@gator>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:51:06AM +0200, Andrew Jones wrote:
> On Mon, Jun 13, 2022 at 04:19:38PM +0000, Sean Christopherson wrote:
> > Fixups for the overhaul, all of which come from Drew's code review.  The
> > first three should all squash cleanly, but the kvm_check_cap() patch will
> > not due to crossing the TEST_REQUIRE() boundary.
> > 
> > Sean Christopherson (4):
> >   KVM: selftests: Add a missing apostrophe in comment to show ownership
> >   KVM: selftests: Call a dummy helper in VM/vCPU ioctls() to enforce
> >     type
> >   KVM: selftests: Drop a duplicate TEST_ASSERT() in
> >     vm_nr_pages_required()
> >   KVM: selftests: Use kvm_has_cap(), not kvm_check_cap(), where possible
> > 
> >  .../testing/selftests/kvm/aarch64/psci_test.c |  2 +-
> >  .../selftests/kvm/include/kvm_util_base.h     | 57 ++++++++++---------
> >  tools/testing/selftests/kvm/lib/kvm_util.c    |  6 +-
> >  .../selftests/kvm/lib/x86_64/processor.c      |  4 +-
> >  .../selftests/kvm/s390x/sync_regs_test.c      |  2 +-
> >  .../kvm/x86_64/pmu_event_filter_test.c        |  2 +-
> >  .../selftests/kvm/x86_64/sev_migrate_tests.c  |  6 +-
> >  tools/testing/selftests/kvm/x86_64/smm_test.c |  2 +-
> >  .../testing/selftests/kvm/x86_64/state_test.c |  2 +-
> >  9 files changed, 42 insertions(+), 41 deletions(-)
> > 
> > 
> > base-commit: 8baacf67c76c560fed954ac972b63e6e59a6fba0
> > -- 
> > 2.36.1.476.g0c4daa206d-goog
> >
> 
> All these patches look good to me. For the series
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
> There's still one more comment I made on the overhaul though, which
> is that the expressions using i and j in kvm_binary_stats_test.c
> for the vcpus and vcpu_stat_test indices have i and j swapped.
>

I'll just go ahead and send that i,j patch myself now.

Thanks,
drew 

