Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3939457B04C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiGTFYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTFYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:24:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4961D75
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:24:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so554902wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRnZ7FX3Aqrm2qW8fYxLX7RCSK0CzE4lO2XUFg1ljc0=;
        b=jzF8fnE2hCPuY1x6GtEnxncgUVeZNaW9cJL0tqYagkApAz0NWWouwaoAyObyqtwC+p
         dgTn4x1c53hJ378QxoQ+bYlqn88bt4cPodRBull4ndNB7Vrp9B4u3o1IbNUkouK8hHAM
         HB1JD6xSezt3lPZ+rePNDQKwfawn4Zzy0vdvHWmAw9Qa5r858HkyYoesdzMuvaeJX0tQ
         eOrR1waOeZtTYsQreu0ekNN6DXcd8YfVa4xRZPwhIydpg9wxnvBx3If082sE8bazbuxM
         DMUwMAiK62y6yfSvhc2er/7gVuBQ7wAPY4sAMi/onY7eauocskE+LFRCKdBSwt/pzIAn
         q0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRnZ7FX3Aqrm2qW8fYxLX7RCSK0CzE4lO2XUFg1ljc0=;
        b=ExIhntGMb9NR43iRtBS686RCiWM9260vOxS1EQc0FJrh3X2Ls54/1prsgeDOfSsJoy
         A5PKrXyqhTtRZxK0GhqaZeYhhgkz2G7dNT7Jrc0PYkSQ5DgNjlTlA/lhYz9tZ7jt9eHC
         lfDIv2PP5HXeZEDDp4v020QrTj+6Ivp3qnH2Bs7rEYmImWWu8OdqpkpM34SiqC7ArWBs
         yj1iTmveMd16grll3WLI0wHWdouyf01iFoLTZxD/rzCuwo3mwM4uTX+iMdJ4yU74DeCC
         /3JXw0LKSTZgvsuKjnEcuykTMsJwpBKwvQbwjL9wI8ini8l396btnaXMPBzFiIxc0425
         tHww==
X-Gm-Message-State: AJIora8nDR8uQqSABj766eLMBpAFOT51XGz6miaJ+28ibrVlApahbBah
        pzKlxNbaR7vhKBoBuVl1spwXJOWrA8Dh8xB+PRwknA==
X-Google-Smtp-Source: AGRyM1s5iP4OA8cMNvI+s2mqJl4IG5qLyUtgEsSsWsKnRRTanm3pwd3oeGqQuDkbNfyZ2Fvkx7dU3EXyGoprkeRikAc=
X-Received: by 2002:a05:600c:378c:b0:3a3:2b0a:b531 with SMTP id
 o12-20020a05600c378c00b003a32b0ab531mr545385wmr.176.1658294689630; Tue, 19
 Jul 2022 22:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <c96980ec35c3bd23f17c3374bf42c22971545e85.1656777646.git.sander@svanheule.net>
 <346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net>
In-Reply-To: <346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 20 Jul 2022 13:24:38 +0800
Message-ID: <CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] lib/test: Introduce cpumask KUnit test suite
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     sander@svanheule.net, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        bp@alien8.de, dave.hansen@linux.intel.com,
        Marco Elver <elver@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        vschneid@redhat.com, x86@kernel.org, yury.norov@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000eca1c105e435d1fc"
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

--000000000000eca1c105e435d1fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2022 at 5:31 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> > Add a basic suite of tests for cpumask, providing some tests for empty
> > and completely filled cpumasks.
> >
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> The tests test_cpumask_weight and test_cpumask_last are failing on all
> architectures, as can be seen on [1]. Also this test doesn't follow the
> standard style for KUnit tests [2].
>
> [1]
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220718/=
testrun/10865066/suite/kunit/tests/
> [2] https://docs.kernel.org/dev-tools/kunit/style.html
>
> CC: Brendan Higgins <brendanhiggins@google.com>
> CC: David Gow <davidgow@google.com>
>
> Best Regards,
> - Ma=C3=ADra Canal
>

Hmm... this test passes on the default kunit_tool configs for UML and
x86_64, which are all without SMP.

It looks like the flaw is that, if CONFIG_NR_CPUS is greater than the
actual number of CPUs present, then the cpu_possible_mask (correctly)
won't be full.

I'm not sure what the right fix is: but removing the checks for
cpu_possible_mask being full is probably the way to go. Unless we want
to plumb through some actual detail about the underlying system and
check against that, it doesn't make sense. (Or, we could generate an
artificial "possilbe_mask" which is always full, and test the cpu
against that. But we sort-of already do that with mask_all anyway.)

So, my recommendation for a fix would be:
- Get rid of "KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));"
- Replace "KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1,
cpumask_last(cpu_possible_mask));" with a KUNIT_EXPECT_GE()
- _Maybe_ add some debug logging with the cpumask value being checked,
as it's a pain to tell from the expectation failure messages. e.g.,
kunit_info(test, "cpu_possible_mask =3D '%*pb[l]'\n",
cpumask_pr_args(cpu_possible_mask));


Cheers,
-- David

> > ---
> >
> > Notes:
> >     Changes since v3:
> >     - Test for_each_cpu*() over empty mask and cpu_possible_mask
> >     - Add Andy's Reviewed-by
> >     - Use num_{online,present,possible}_cpus() for builtin masks
> >     - Guard against CPU hotplugging during test for dynamic builtin CPU=
 masks
> >
> >     Changes since v2:
> >     - Rework for_each_* test macros, as suggested by Yury
> >
> >     Changes since v1:
> >     - New patch
> >
> >  lib/Kconfig.debug  |   9 +++
> >  lib/Makefile       |   1 +
> >  lib/test_cpumask.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 148 insertions(+)
> >  create mode 100644 lib/test_cpumask.c
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2e24db4bff19..04aaa20d50f9 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2021,6 +2021,15 @@ config LKDTM
> >       Documentation on how to use the module can be found in
> >       Documentation/fault-injection/provoke-crashes.rst
> >
> > +config TEST_CPUMASK
> > +     tristate "cpumask tests" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT
> > +     default KUNIT_ALL_TESTS
> > +     help
> > +       Enable to turn on cpumask tests, running at boot or module load=
 time.
> > +
> > +       If unsure, say N.
> > +
> >  config TEST_LIST_SORT
> >       tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
> >       depends on KUNIT
> > diff --git a/lib/Makefile b/lib/Makefile
> > index bcc7e8ea0cde..de3e47453fe8 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -99,6 +99,7 @@ obj-$(CONFIG_TEST_HMM) +=3D test_hmm.o
> >  obj-$(CONFIG_TEST_FREE_PAGES) +=3D test_free_pages.o
> >  obj-$(CONFIG_KPROBES_SANITY_TEST) +=3D test_kprobes.o
> >  obj-$(CONFIG_TEST_REF_TRACKER) +=3D test_ref_tracker.o
> > +obj-$(CONFIG_TEST_CPUMASK) +=3D test_cpumask.o
> >  CFLAGS_test_fprobe.o +=3D $(CC_FLAGS_FTRACE)
> >  obj-$(CONFIG_FPROBE_SANITY_TEST) +=3D test_fprobe.o
> >  #
> > diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> > new file mode 100644
> > index 000000000000..a31a1622f1f6
> > --- /dev/null
> > +++ b/lib/test_cpumask.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * KUnit tests for cpumask.
> > + *
> > + * Author: Sander Vanheule <sander@svanheule.net>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/cpu.h>
> > +#include <linux/cpumask.h>
> > +
> > +#define EXPECT_FOR_EACH_CPU_EQ(test, mask)                   \
> > +     do {                                                    \
> > +             const cpumask_t *m =3D (mask);                    \
> > +             int mask_weight =3D cpumask_weight(m);            \
> > +             int cpu, iter =3D 0;                              \
> > +             for_each_cpu(cpu, m)                            \
> > +                     iter++;                                 \
> > +             KUNIT_EXPECT_EQ((test), mask_weight, iter);     \
> > +     } while (0)
> > +
> > +#define EXPECT_FOR_EACH_CPU_NOT_EQ(test, mask)                        =
               \
> > +     do {                                                             =
       \
> > +             const cpumask_t *m =3D (mask);                           =
         \
> > +             int mask_weight =3D cpumask_weight(m);                   =
         \
> > +             int cpu, iter =3D 0;                                     =
         \
> > +             for_each_cpu_not(cpu, m)                                 =
       \
> > +                     iter++;                                          =
       \
> > +             KUNIT_EXPECT_EQ((test), nr_cpu_ids - mask_weight, iter); =
       \
> > +     } while (0)
> > +
> > +#define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)                      \
> > +     do {                                                    \
> > +             const cpumask_t *m =3D (mask);                    \
> > +             int mask_weight =3D cpumask_weight(m);            \
> > +             int cpu, iter =3D 0;                              \
> > +             for_each_cpu_wrap(cpu, m, nr_cpu_ids / 2)       \
> > +                     iter++;                                 \
> > +             KUNIT_EXPECT_EQ((test), mask_weight, iter);     \
> > +     } while (0)
> > +
> > +#define EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, name)           \
> > +     do {                                                    \
> > +             int mask_weight =3D num_##name##_cpus();          \
> > +             int cpu, iter =3D 0;                              \
> > +             for_each_##name##_cpu(cpu)                      \
> > +                     iter++;                                 \
> > +             KUNIT_EXPECT_EQ((test), mask_weight, iter);     \
> > +     } while (0)
> > +
> > +static cpumask_t mask_empty;
> > +static cpumask_t mask_all;
> > +
> > +static void test_cpumask_weight(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> > +     KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
> > +     KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
> > +
> > +     KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
> > +     KUNIT_EXPECT_EQ(test, nr_cpu_ids, cpumask_weight(cpu_possible_mas=
k));
> > +     KUNIT_EXPECT_EQ(test, nr_cpumask_bits, cpumask_weight(&mask_all))=
;
> > +}
> > +
> > +static void test_cpumask_first(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first(&mask_empty));
> > +     KUNIT_EXPECT_EQ(test, 0, cpumask_first(cpu_possible_mask));
> > +
> > +     KUNIT_EXPECT_EQ(test, 0, cpumask_first_zero(&mask_empty));
> > +     KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first_zero(cpu_possible=
_mask));
> > +}
> > +
> > +static void test_cpumask_last(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty))=
;
> > +     KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possi=
ble_mask));
> > +}
> > +
> > +static void test_cpumask_next(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_EQ(test, 0, cpumask_next_zero(-1, &mask_empty));
> > +     KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next_zero(-1, cpu_possi=
ble_mask));
> > +
> > +     KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next(-1, &mask_empty));
> > +     KUNIT_EXPECT_EQ(test, 0, cpumask_next(-1, cpu_possible_mask));
> > +}
> > +
> > +static void test_cpumask_iterators(struct kunit *test)
> > +{
> > +     EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
> > +     EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
> > +     EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
> > +
> > +     EXPECT_FOR_EACH_CPU_EQ(test, cpu_possible_mask);
> > +     EXPECT_FOR_EACH_CPU_NOT_EQ(test, cpu_possible_mask);
> > +     EXPECT_FOR_EACH_CPU_WRAP_EQ(test, cpu_possible_mask);
> > +}
> > +
> > +static void test_cpumask_iterators_builtin(struct kunit *test)
> > +{
> > +     EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, possible);
> > +
> > +     /* Ensure the dynamic masks are stable while running the tests */
> > +     cpu_hotplug_disable();
> > +
> > +     EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
> > +     EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
> > +
> > +     cpu_hotplug_enable();
> > +}
> > +
> > +static int test_cpumask_init(struct kunit *test)
> > +{
> > +     cpumask_clear(&mask_empty);
> > +     cpumask_setall(&mask_all);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct kunit_case test_cpumask_cases[] =3D {
> > +     KUNIT_CASE(test_cpumask_weight),
> > +     KUNIT_CASE(test_cpumask_first),
> > +     KUNIT_CASE(test_cpumask_last),
> > +     KUNIT_CASE(test_cpumask_next),
> > +     KUNIT_CASE(test_cpumask_iterators),
> > +     KUNIT_CASE(test_cpumask_iterators_builtin),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite test_cpumask_suite =3D {
> > +     .name =3D "cpumask",
> > +     .init =3D test_cpumask_init,
> > +     .test_cases =3D test_cpumask_cases,
> > +};
> > +kunit_test_suite(test_cpumask_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > --
> > 2.36.1
>
>

--000000000000eca1c105e435d1fc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCV
7mE1P25euFam6dD4RJHjye9kTEl6nVR9jP4Nz7srwjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MjAwNTI0NDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAF0b/EeU/l8XIAZijPg3x
FqNeA6HQJi6ESRV7u+hJukshMRRI9+bA9xr7n1f3Q7vhGZAXEOc0Te8lhlXzJVhBAHK1HUBoUV+1
DSRFMxrkvpjliLOvVgherqapeLVcVq1ieMcwVCmVYZP4llJ1iRQSO9RCRTa5Kr+WvUAh9Ps2bca/
4MIDh4JUqHAYT05b9u39D/DybFNl1TCHNAlaiWWvun5lAZdb/ZIBo8YL3ieySb+4iDT3w5NT6Uuu
ZRXfhAJQn5zNwsti8dIdEq7j7syS5+2s1tok4plMFgISA/ZIP1iPWjqNFFPaxFYsXzyBwVDl4xyJ
3T0P+gV48jYy/kz7Tg==
--000000000000eca1c105e435d1fc--
