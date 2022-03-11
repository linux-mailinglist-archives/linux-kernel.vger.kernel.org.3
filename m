Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE44D6819
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349942AbiCKR5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiCKR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:57:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2DB1C1ED6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:56:34 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r29so2651111edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6uqrZCjfvTCf0vt8DbhYIoNyBdrnrfGnyWV6ShUB2vU=;
        b=Np8v8rOaTexwZ9CowsixK98xvDVR/E2HeNEE9G8HenWAgLG2yemAxpgvVci5J5M9E/
         ww2D8EpkdwkrLH/I0vWWh9u7qyWvZ4VZaOSsPpHkxHjzl2SNgKnjo/HqG83j30EfsRFV
         PD3gWWPF3jC2guzLSofGcoOW71gHVlrFct9bgSM6bGnCNsPr1FSNzwngi/ElmXVsS9AG
         JQq1PLSXqweRV+CbnOgPPQllnqthJEE3BHdv4zqiCfrzRk7z2K5hyu6MUYHRMoNNXeqe
         XdUc3gi649tmmAnRsMMVQzCJvADluc2wizuISjw8kNhajMhuJQpWa9hsWmwVPWyAC0p0
         4m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6uqrZCjfvTCf0vt8DbhYIoNyBdrnrfGnyWV6ShUB2vU=;
        b=19i787BwJeEQFgc5Ws5TVOcCDApDLHE0rusXFilHE71kmXTzCe9KdyPWafBmj8fZXH
         G+BBgVRDgnITp7cDXU9lURq+S/An7AAAWbTrY0EXK5YOuybkAmyQUjCgsPJAfhyJTezY
         8krGK2w7z8rENwwbG0g+8DkMGShsgJBN4Ex03prpjEBZ1ml162LjRUflXsSn5MPjFwFC
         G439lk7tzzE/ogEp9mqTQBzG1xi111djrGZb8GtahkBd0iFs+wT5kUzfeSo0j1RhRNIq
         Ej4Q+EXxS0Jay5ozW52CzacDINQuibAwqJ9eiuRY4goJAap5G2KbZsnswbPJX2v3PtmW
         4gvw==
X-Gm-Message-State: AOAM531Vmji0ZJHN0sly/KFaG0W8suLpIbFwsQue7mPgZH3hlfgD3Dw9
        xYVKZ7LkBpZ/VQyEyublfw0xB8NbMLAflgDUeSH2FQ==
X-Google-Smtp-Source: ABdhPJwYY3OG4OM3NNI/L0bMert1EmCD8hdhav4/Wgf4KNE3snW+GGxbN3UYDTLUSIImyQRJ8LcMXpAFS/L8po/gON4=
X-Received: by 2002:a05:6402:3490:b0:416:8b97:b1f7 with SMTP id
 v16-20020a056402349000b004168b97b1f7mr9808627edc.36.1647021392341; Fri, 11
 Mar 2022 09:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20220310210210.2124637-1-brendanhiggins@google.com>
 <Yirz/hbo4K9zN9Ht@google.com> <CAFmMkTFa9xVt314WEGd0nNx+ovc=aGB_yN1LorP7WrBga9quxw@mail.gmail.com>
In-Reply-To: <CAFmMkTFa9xVt314WEGd0nNx+ovc=aGB_yN1LorP7WrBga9quxw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 11 Mar 2022 11:56:20 -0600
Message-ID: <CAGS_qxqHhGEYS_4C-gTmPt_d3Fm==VOTEzQGggWh6MWppTHtZQ@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 4:14 AM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>
>
>
> El vie., 11 mar. 2022 4:02 a. m., David Gow <davidgow@google.com> escribi=
=C3=B3:
>>
>> On Thu, Mar 10, 2022 at 01:02:10PM -0800, Brendan Higgins wrote:
>> > Add support for a new kind of kunit_suite registration macro called
>> > kunit_test_init_suite(); this new registration macro allows the
>> > registration of kunit_suites that reference functions marked __init an=
d
>> > data marked __initdata.
>> >
>> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> > ---
>> >
>> > This patch is in response to a KUnit user issue[1] in which the user w=
as
>> > attempting to test some init functions; although this is a functional
>> > solution as long as KUnit tests only run during the init phase, we wil=
l
>> > need to do more work if we ever allow tests to run after the init phas=
e
>> > is over; it is for this reason that this patch adds a new registration
>> > macro rather than simply modifying the existing macros.
>> >
>> > [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
>> >
>> > ---
>>
>> I'm a little concerned that this is just removing the warnings, but do
>> agree that this is safe enough for the moment. At least the information
>> about which tests need __init is preserved by the use of a different
>> macro.
>>
>> I guess one day we'll need a second list of 'init' tests or something...
>
>
> Hi, could you please detail about this? Why a second list?
>

I assume this is referring to a future where we want to run tests
_after_ the init phase.
In that case, we'd need to be able to separately register tests that
run during and those that run after.
(Or we could have one list and just tag each suite as init/post-init.
If we ever had >2 "phases" where we run tests, this might be the more
scalable option)

Is it likely we'd have tests run after?
Not in the near future, I don't think. But it could be asked for.

For context, here's where built-in KUnit tests currently run:
https://elixir.bootlin.com/linux/v5.17-rc7/source/init/main.c#L1615
That'd probably become kunit_run_init_tests() and then we'd have
another kunit_run_post_init_tests() called later, or something.
