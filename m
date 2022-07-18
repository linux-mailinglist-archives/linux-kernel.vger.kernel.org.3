Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82242578E72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiGRXqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGRXqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:46:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F933417
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:46:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so19774743pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V+k5WNh4t1m32DC2xdn9fqss9Z9YPd/9WCm7Vf/65ew=;
        b=IKcajPEAOoIJLsaEnsE29X545rHMn3JotFea30qeq9PiH2LmRPV0e2ppAntkVs3SbX
         qNmZXVmRwcP+wgg79UgXOD28mrlAFYR4DY9Mhy2g8+P2Xld7JXlu7svBXo2lz2EgEVNl
         efo6pQEuJOxxswIoQohjFg2GOpoeduYEm342e7MOPqLd+i+sbneveien6K40mVZBcUzN
         Pj3QAC/hT4WpWaUYbdY5isGpRQUYYSuWP+E0ef0pCKjBbEf98jANV0nrgifcXwD5DiT7
         osgc7gmGlWp3JNod5zpKbBzHK6DX1aWKdw/6HxZAxmcE2ke8+yE34zvOVgup4RY8O8K9
         +ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V+k5WNh4t1m32DC2xdn9fqss9Z9YPd/9WCm7Vf/65ew=;
        b=5vM8uK0iz7XdJm80nTAIeWhmGu79IX8z2+fF88Yb1/jATiv5LVDfgOtO8b4b7e/xcV
         4gmCAS3YnttojcpgHWhmDBC/VEwgU7o0wrAow7qFzfZjJD2GBPJlZchvGd/j+BY11pFW
         XILUkxZosLIJbEZh++qo5ESQkL7DfP2SW26kAT55L315ZOhanDQsL7uR3I5+uCxQJE3d
         +jqvearq2p4B7yzj/ZdCGbcWxhc6WqifmbAMDUYPMjWXNyluSMTvenjHxNIxDeRh899s
         t+bviQfVtDaPBE6zNG71UxEtRhqo8XVNeEClFSdd1mCTVfaGpDUWBkqHzHlJFX91v6K0
         zcxQ==
X-Gm-Message-State: AJIora8jN74eUonryxdP0g/35DXBrKkWQf5VcS2QBpg6wNIzEcHnWWrs
        ajz0GC0cmmr4zvRsmISUDcnJQQ==
X-Google-Smtp-Source: AGRyM1tHTutF3/J1jx5hyumfSIH5Nny7tbSTVRFNGviIDr3edV8HTIveuVe3LoJ6y2mAcVox2RucNA==
X-Received: by 2002:a17:90a:4e05:b0:1ec:8de4:1dd5 with SMTP id n5-20020a17090a4e0500b001ec8de41dd5mr34719549pjh.242.1658188009008;
        Mon, 18 Jul 2022 16:46:49 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7952d000000b0052ac5e304d0sm10157638pfp.179.2022.07.18.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 16:46:48 -0700 (PDT)
Date:   Mon, 18 Jul 2022 23:46:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, oliver.upton@linux.dev,
        shuah@kernel.org, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH v3] KVM: selftests: Fix target thread to be migrated in
 rseq_test
Message-ID: <YtXw5DKI7z9s1TA6@google.com>
References: <20220719013540.3477946-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719013540.3477946-1-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022, Gavin Shan wrote:
> ---
> v3: Improved changelog (Oliver Upon)

Sorry I didn't catch v3, I saw that you waited but just didn't get to this earlier :-/

> ---
>  tools/testing/selftests/kvm/rseq_test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 4158da0da2bb..c83ac7b467f8 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -38,6 +38,7 @@ static __thread volatile struct rseq __rseq = {
>   */
>  #define NR_TASK_MIGRATIONS 100000
>  
> +static pid_t rseq_tid;
>  static pthread_t migration_thread;
>  static cpu_set_t possible_mask;
>  static int min_cpu, max_cpu;
> @@ -106,7 +107,8 @@ static void *migration_worker(void *ign)

Pass the target TID to the worker, then there's no need to use a global and no
chance of consuming rseq_tid "uninitialized".  The casting to convert gettid() to
a "void *" is annoying, but not the end of the world.

>  		 * stable, i.e. while changing affinity is in-progress.
>  		 */
>  		smp_wmb();
> -		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> +		r = sched_setaffinity(rseq_tid, sizeof(allowed_mask),
> +				      &allowed_mask);

Eh, let this poke out, don't think it's worth wrapping here.

E.g.

---
 tools/testing/selftests/kvm/rseq_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index aba7be178dab..a54d4d05a058 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -80,8 +80,9 @@ static int next_cpu(int cpu)
 	return cpu;
 }

-static void *migration_worker(void *ign)
+static void *migration_worker(void *__rseq_tid)
 {
+	pid_t rseq_tid = (pid_t)(unsigned long)__rseq_tid;
 	cpu_set_t allowed_mask;
 	int r, i, cpu;

@@ -104,7 +105,7 @@ static void *migration_worker(void *ign)
 		 * stable, i.e. while changing affinity is in-progress.
 		 */
 		smp_wmb();
-		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
+		r = sched_setaffinity(rseq_tid, sizeof(allowed_mask), &allowed_mask);
 		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
 			    errno, strerror(errno));
 		smp_wmb();
@@ -227,7 +228,8 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	ucall_init(vm, NULL);

-	pthread_create(&migration_thread, NULL, migration_worker, 0);
+	pthread_create(&migration_thread, NULL, migration_worker,
+		       (void *)(unsigned long)gettid());

 	for (i = 0; !done; i++) {
 		vcpu_run(vcpu);

base-commit: ad6cb756bb497997032df2bda7cbdff076e4a66a
--
