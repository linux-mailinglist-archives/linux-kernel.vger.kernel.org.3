Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C459A860
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbiHSWUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbiHSWUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:20:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E4ED399B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:20:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b38so5183673lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1w9j2CnxvpyDXJP79Sumgew0FP16DRtCEadh0HEfiw0=;
        b=nedrGMevZdy6slVv+dPk/OuT3aiMTrep7kHueX8UNcmcbH7GyPzBhhYgPUFsOfqfNa
         n4llUV8b8GJ5N4LkrWz39ExnK9T0PGbLFPxu0/0dE4FarUGHi8OiQNr+x0kc8rHjtjVU
         zjXNZ+W2SU5Megg3N/ZtK5sNEZZ8HV9Su2YP6YvRfn68rxabxzX6ZNOwC4+TPsEMpveC
         Jy0DRc+tyU7gpFK7LgXAvuM4oylAn+PgIZdTA898ydx9yuwKghWkn+7Ug9xLXWq99xCG
         G9qY82cQ/oSQE5ffiGv1wvIxLGRD1nqH3LlP6D7NCQV9nKG3Tio5zHsGjrtdv8vsMBv3
         y35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1w9j2CnxvpyDXJP79Sumgew0FP16DRtCEadh0HEfiw0=;
        b=v3r+IXNAbv2hW7b4ZbE9xaA0CVFZ9bo8Zmv/5DJIM6j2V0HvFf+55pNE4FA75lvxq4
         FvahKGM85Q9xxYf+qln8X5sMHp8bzQIoFCibogh1VYbGM9nLSGXBkrxfzpCWiDBYYn8E
         jIhyhDXPZ0uuXxXCPgYu9pWk/sK/cCIqlDKUWQjeZB7jTkzD96HZVp6Rqx/2Bl+1X3HS
         C9iGJAiJwDdMmYNk9CJmNRwT+f7cSoI1rw4K6KwRyswfd6Xw/LSSZ3V8d3RP2z/40Rxr
         2ve8lLUPScgMa4/VnItBKVIjc1nw7EYiCVoloEPb6DLN6JYr8dftNeUJ/DvyZYCSpS6C
         yJ4A==
X-Gm-Message-State: ACgBeo3rqPJfwdqX5GX8qftSJ8YvWJqYQH0sZQfnlkZ4fViI8te7zkt/
        zZ0EFP7uyEZCNGImhhs03pRzlzQcb98uHskkuUKFFg==
X-Google-Smtp-Source: AA6agR7gzGL5Ufc+3smMEbm6na/bSIYdDXa20mn3jdUHyqDKUAL5i1UlTnXmF2upgUWAg2TYuw9QSJv6kvqkax+xddg=
X-Received: by 2002:a05:6512:139c:b0:48f:da64:d050 with SMTP id
 p28-20020a056512139c00b0048fda64d050mr2796700lfa.268.1660947643331; Fri, 19
 Aug 2022 15:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220819210737.763135-1-vipinsh@google.com> <YwAC1f5wTYpTdeh+@google.com>
In-Reply-To: <YwAC1f5wTYpTdeh+@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 19 Aug 2022 15:20:06 -0700
Message-ID: <CAHVum0ecr7S9QS4+3kS3Yd-eQJ5ZY_GicQWurVFnAif6oOYhOg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: selftests: Run dirty_log_perf_test on specific cpus
To:     David Matlack <dmatlack@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Aug 19, 2022 at 2:38 PM David Matlack <dmatlack@google.com> wrote:
>
> On Fri, Aug 19, 2022 at 02:07:37PM -0700, Vipin Sharma wrote:
> > +static int atoi_paranoid(const char *num_str)
> > +{
> > +     int num;
> > +     char *end_ptr;
> > +
> > +     errno = 0;
> > +     num = (int)strtol(num_str, &end_ptr, 10);
> > +     TEST_ASSERT(errno == 0, "Conversion error: %d\n", errno);
> > +     TEST_ASSERT(num_str != end_ptr && *end_ptr == '\0',
> > +                 "Invalid number string.\n");
> > +
> > +     return num;
> > +}
>
> Introduce atoi_paranoid() and upgrade existing atoi() users in a
> separate commit. Also please put it in e.g. test_util.c so that it can
> be used by other tests (and consider upgrading other tests to use it in
> your commit).
>

Sure, I will add a separate commit.


> > -     while ((opt = getopt(argc, argv, "eghi:p:m:nb:f:v:os:x:")) != -1) {
> > +     while ((opt = getopt(argc, argv, "c:eghi:p:m:nb:f:v:os:x:")) != -1) {
> >               switch (opt) {
> > +             case 'c':
> > +                     nr_lcpus = parse_cpu_list(optarg, lcpu_list, KVM_MAX_VCPUS + 1);
>
> I think we should move all the logic to pin threads to perf_test_util.c.
> The only thing dirty_log_perf_test.c should do is pass optarg into
> perf_test_util.c. This will make it trivial for any other test based on
> pef_test_util.c to also use pinning.
>
> e.g. All a test needs to do to use pinning is add a flag to the optlist
> and add a case statement like:
>
>         case 'c':
>                 perf_test_setup_pinning(optarg);
>                 break;
>
> perf_test_setup_pinning() would:
>  - Parse the list and populate perf_test_vcpu_args with each vCPU's
>    assigned pCPU.
>  - Pin the current thread to it's assigned pCPU if one is provided.
>

This will assume all tests have the same pinning requirement and
format. What if some tests have more than one worker threads after the
vcpus?

Maybe I should:
1. Create a generic function which parses a csv of integers, put it in
test_util.c
2. Provide a function to populate perf_test_vcpus_args in perf_test_util.c
3. Provide a function to migrate self to some cpu in perf_test_util.c.
This will work for now, but in future if there are more than 1 worker
we need to revisit it.

I will also be fine implementing what you suggested and keep working
under the precondition that there will be only one worker thread, if
that is okay to assume.

> Validating that the number of pCPUs == number of vCPUs is a little
> tricky. But that could be done as part of
> perf_test_start_vcpu_threads(). Alternatively, you could set up pinning
> after getting the number of vCPUs. e.g.
>
>         const char *cpu_list = NULL;
>
>         ...
>
>         while ((opt = getopt(...)) != -1) {
>                 switch (opt) {
>                 case 'c':
>                         cpu_list = optarg;  // is grabbing optarg here safe?

I am not sure how it is internally implemented. API doesn't mention
anything. Better to be safe and assume it is not valid later.

>                         break;
>                 }
>                 ...
>         }
>
>         if (cpu_list)
>                 perf_test_setup_pinning(cpu_list, nr_vcpus);
>

Better to have a copy of the argument or just get list of cpus after
parsing and then do the verification. What is the point in doing all
extra parsing work when we are gonna abort the process due to some
invalid condition.
