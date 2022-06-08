Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958CB543FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiFHXUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFHXUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:20:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F483EBB8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:20:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cx11so19965970pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xhtp6TTc6vqgexGjW19jty2j7CpvP7bWmQW45o9paqI=;
        b=DYAb8tCCx5GJLhiTQv/YV14Sx5Hm0DcfqU9+exgsXu/mgjeTXK4c+ug5SJ77e11AS5
         W0qCQhMSEX941g0DvMefSXHZuxFsV2zVqSEofp+QeQzeo+C956lCAKYDia92qFQwTl7J
         aovWeV8nBne1+tyCkqRSYDXpCG2rAMrEsyD80t0Vpvdrv4FuN5+XIARQnFBYYUlPFFYX
         LjTLdYt5mieSGgGLnoxYF+nvUvdwb9e6hSmVug4VxfSlQUssV2taGyn/RV/++mMV99dH
         K/z9bd2ytmebqxv0CCtjMJoptpl0dDreO1owIO7IT/pws9a5edf8IWZEoj973Wd3UCfF
         NpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xhtp6TTc6vqgexGjW19jty2j7CpvP7bWmQW45o9paqI=;
        b=7/xl64l59yhwtjhrplWyCm2sCReMsI3s1lXIR5O1HXLM9pVkGPNvX3paPNk5S95ICK
         2Wqj8mlgQlHYHgPpUVZZ4GhhOQsTEgEH7stOX+7z+ln/Gm8vWaCDrGnfJgTdSl3DzgbT
         Xa8yDEELMAkYXXzi+em9uHgR7OSNJGMTUU8QFrUmm7VPwbZb4tJI5L5ahWOpsiKBMmRw
         UsDnZzGXAeOnewEzhLQEBbF+yiCRjPRuuobD2lu+jfVoe4AZ6Z2k70CM+05/UGLrzfnB
         K9CkO209o/ofumbbkpFq+JDW9Slj1zjsNxBFZq110dDw7qnEQ78BAjCaMEy0Z01bbp+4
         F40g==
X-Gm-Message-State: AOAM533mlKm863CwBPHvPenT/hJkxdxyw3vqircF8+a6rm0EyREp/D1S
        aKrbHz55RjtBdr/M89j/coHo2rxoPp6+yQ==
X-Google-Smtp-Source: ABdhPJx7Vsoz777hqcF5bIUVbM72L0w1AkFn3J15iJXwjoChqtx9IoiXpVwllH7YMaNpUuhjbB74OA==
X-Received: by 2002:a17:902:aa85:b0:155:ceb9:3710 with SMTP id d5-20020a170902aa8500b00155ceb93710mr37049411plr.59.1654730409877;
        Wed, 08 Jun 2022 16:20:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id ic6-20020a17090b414600b001df93c8e737sm14711578pjb.39.2022.06.08.16.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 16:20:09 -0700 (PDT)
Date:   Wed, 8 Jun 2022 23:20:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <YqEupumS/m5IArTj@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <93b87b7b5a599c1dfa47ee025f0ae9c4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b87b7b5a599c1dfa47ee025f0ae9c4@kernel.org>
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

On Wed, Jun 08, 2022, Marc Zyngier wrote:
> On 2022-06-07 16:27, Paolo Bonzini wrote:
> > Marc, Christian, Anup, can you please give this a go?
> 
> Can you please, pretty please, once and for all, kill that alias you
> seem to have for me and  email me on an address I actually can read?
> 
> I can't remember how many times you emailed me on my ex @arm.com address
> over the past 2+years...
> 
> The same thing probably applies to Sean, btw.

Ha!  I was wondering how my old @intel address snuck in...

On the aarch64 side, with the following tweaks, courtesy of Raghu, all tests
pass.  I'll work these into the next version, and hopefully also learn how to
run on aarch64 myself...

Note, the i => 0 "fix" in test_v3_typer_accesses() is a direct revert of patch 3,
"KVM: selftests: Fix typo in vgic_init test".  I'll just drop that patch unless
someone figures out why doing the right thing causes the test to fail.

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index b91ea02a8a80..66b7e9c76370 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -317,7 +317,7 @@ static void test_vgic_then_vcpus(uint32_t gic_dev_type)

        /* Add the rest of the VCPUs */
        for (i = 1; i < NR_VCPUS; ++i)
-               vm_vcpu_add(v.vm, i, guest_code);
+               vcpus[i] = vm_vcpu_add(v.vm, i, guest_code);

        ret = run_vcpu(vcpus[3]);
        TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
@@ -424,7 +424,7 @@ static void test_v3_typer_accesses(void)
                            KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);

        for (i = 0; i < NR_VCPUS ; i++) {
-               ret = v3_redist_reg_get(v.gic_fd, i, GICR_TYPER, &val);
+               ret = v3_redist_reg_get(v.gic_fd, 0, GICR_TYPER, &val);
                TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");
        }

@@ -654,11 +654,12 @@ static void test_v3_its_region(void)
  */
 int test_kvm_device(uint32_t gic_dev_type)
 {
+       struct kvm_vcpu *vcpus[NR_VCPUS];
        struct vm_gic v;
        uint32_t other;
        int ret;

-       v.vm = vm_create_with_vcpus(NR_VCPUS, guest_code, NULL);
+       v.vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);

        /* try to create a non existing KVM device */
        ret = __kvm_test_create_device(v.vm, 0);
diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index b3116c151d1c..17f7ef975d5c 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -419,7 +419,7 @@ static void run_test(struct vcpu_config *c)

        check_supported(c);

-       vm = vm_create_barebones();
+       vm = vm_create(1);
        prepare_vcpu_init(c, &init);
        vcpu = aarch64_vcpu_add(vm, 0, &init, NULL);
        finalize_vcpu(vcpu, c);
