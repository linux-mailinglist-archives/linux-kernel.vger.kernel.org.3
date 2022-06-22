Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59D4553F64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbiFVASb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiFVAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:18:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F1248D4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:18:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3137316bb69so147006397b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oGTotRq4WT1s39cOcG1SCSH+1obZhPZeWPvkH3sdIY=;
        b=pRiRdRZvjWOHeq131C46xsgsl6zJcY8C05hCjZzCa9c5mI+uxZS+aWO42sFaDVcz0b
         nZ6JYvtfY+Dyq2C3cKgNrJEzQb345RwaajVb7ThwG5hC4/DO+seCNsOY5IrbWmSj93x2
         odlhjOIH9KnXoJQSU0k/qCogGY7lOn36CEKee3zO/Hjmxp94lYh4Dbu3OZ2pdCN470GB
         +pFf6fL2HolqA61KHmkwKp5hmNh6RdX/SFg+piwu9viA8TJy2VVclhV5fTeHJgt9D5mU
         YbHFvldnFR/xTL31nImBrcfsqLyAFoBI+mjOIE5RD2EhoaF6AlCw0MOPtH1rTD4uNfEc
         xIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oGTotRq4WT1s39cOcG1SCSH+1obZhPZeWPvkH3sdIY=;
        b=pUhtIeNQuT9PZW3FHHhdkBlVyJkgAMX0XfbaLSlElqvz5RgruBnMUheZcCu9rDxfjc
         HiJuRyjkbcx1VV5/qkeLK0LkOhaqPpLTO7O1NWIToZnf7JNyyg4PdUP3go+87K3EZHsT
         f62V2Qt5/RFvTzBn61ItFFXdZUFI2Rlrraaf0wveqddADZrHTAh+rsIcwTeKSvheALaf
         PeLFYGdZf/m18/dBNDWujp1toPRTLhQZBC5oLZ8R0Vq1UTp2yEUAn1cpdLNXvkKtPhM+
         sWl/lIe8TTunoMTvUHwDeeAUcwTvtKc6y1ifMi02oqA7/ZELIYWtvV1xyWRJCTjmrdp1
         pqQg==
X-Gm-Message-State: AJIora/BFxj2BmM+y/KPzhT7vDe/RJEoT7+qMOXld1edcgyFWzgnSbkG
        LsCIROdknajlTamCO/FP3vvCiCEXoOxsmZRjVOkuIg==
X-Google-Smtp-Source: AGRyM1uZMeYsz5mgtXqZFmpIy7OI6WlLsf1bMvgdPOTGVewZvG7oLbOCHMIQXhvHTWsNX+x8sktVDLoJVaFNzPzXsDo=
X-Received: by 2002:a0d:cd81:0:b0:2ff:aa45:4238 with SMTP id
 p123-20020a0dcd81000000b002ffaa454238mr984226ywd.155.1655857105884; Tue, 21
 Jun 2022 17:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220616211016.4037482-1-dylanbhatch@google.com>
 <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
 <CADBMgpwt2ALzBTtEm7v6DLL_9pjUhVLDpBLHXn1b0bvVf2BSvg@mail.gmail.com>
 <47312e8a-87fe-c7dc-d354-74e81482bc1e@linuxfoundation.org>
 <CADBMgpx9hwHaWe=m2kQhKOJFWnLSejoWa6wz1VECEkLhWq4qog@mail.gmail.com> <a5f46e4e-a472-77ce-f61e-b2f9922bdd50@linuxfoundation.org>
In-Reply-To: <a5f46e4e-a472-77ce-f61e-b2f9922bdd50@linuxfoundation.org>
From:   Dylan Hatch <dylanbhatch@google.com>
Date:   Tue, 21 Jun 2022 17:18:14 -0700
Message-ID: <CADBMgpzyOKVO1ju_WkxYLhXGvwJjHoL6V-+Nw49UdTFoPY7NvQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/proc: Fix proc-pid-vm for vsyscall=xonly.
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
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

On Fri, Jun 17, 2022 at 3:27 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/17/22 4:05 PM, Dylan Hatch wrote:
> > On Fri, Jun 17, 2022 at 12:38 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> On 6/17/22 12:45 PM, Dylan Hatch wrote:
> >>> On Thu, Jun 16, 2022 at 4:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>>>
> >
> >>
> >> It depends on the goal of the test. Is the test looking to see if the
> >> probe fails with insufficient permissions, then you are changing the
> >> test to not check for that condition.
> >
> > The goal of the test is to validate the output of /proc/$PID/maps, and
> > the memory probe is only needed as setup to determine what the
> > expected output should be. This used to be sufficient, but now it can
> > no longer fully disambiguate it with the introduction of
> > vsyscall=xonly. The solution proposed here is to disambiguate it by
> > also checking the length read from /proc/$PID/maps.
> >
> >>
>
> Makes sense. However the question is does this test need to be enhanced
> with the addition of vsyscall=xonly?
>
> >> I would say in this case, the right approach would be to leave the test
> >> as is and report expected fail and add other cases.
> >>
> >> The goal being adding more coverage and not necessarily opt for a simple
> >> solution.
> >
> > What does it mean to report a test as expected fail? Is this a
> > mechanism unique to kselftest? I agree adding another test case would
> > work, but I'm unsure how to do it within the framework of kselftest.
> > Ideally, there would be separate test cases for vsyscall=none,
> > vsyscall=emulate, and vsyscall=xonly, but these options can be toggled
> > both in the kernel config and on the kernel command line, meaning (to
> > the best of my knowledge) these test cases would have to be built
> > conditionally against the conflig options and also parse the command
> > line for the 'vsyscall' option.
> >
>
> Expected fail isn't unique kselftest. It is a testing criteria where
> a test is expected to fail. For example if a file can only be opened
> with privileged user a test that runs and looks for failure is an
> expected to fail case - we are looking for a failure.
>
> A complete battery of tests for vsyscall=none, vsyscall=emulate,
> vsyscall=xonly would test for conditions that are expected to pass
> and fail based on the config.
>
> tools/testing/selftests/proc/config doesn't have any config options
> that are relevant to VSYSCALL
>
> Can you please send me the how you are running the test and what the
> failure output looks like?

I'm building a kernel with the following relevant configurations:

$ cat .config | grep VSYSCALL
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set

Running the test without this change both in virtme and on real
hardware gives the following error:

# ./tools/testing/selftests/proc/proc-pid-vm
proc-pid-vm: proc-pid-vm.c:328: int main(void): Assertion `rv == len' failed.
Aborted

This is because when CONFIG_LEGACY_VSYSCALL_XONLY=y a probe of the
vsyscall page results in a segfault. This test was originally written
before this option existed so it incorrectly assumes the vsyscall page
isn't mapped at all, and the expected buffer length doesn't match the
result.

An alternate method of fixing this test could involve setting the
expected result based on the config with #ifdef blocks, but I wasn't
sure if that could be done for kernel config options in kselftest
code. There's also the matter of checking the kernel command line for
a `vsyscall=` arg, is parsing /proc/cmdline the best way to do this?

>
> thanks,
> -- Shuah

Thanks,
Dylan
