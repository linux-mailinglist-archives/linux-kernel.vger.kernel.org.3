Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97D4AE349
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386804AbiBHWVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386769AbiBHVJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:09:33 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02758C0612BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:09:33 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y129so303057ybe.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Voz9w9zuaut5zzPtd6DrE9JLrle0cFN3rE5oW1AaY2M=;
        b=H86Fkha4NgU8OTWhaHjE4JlGaizgjjoCxAoxzH6KuMHph8fpqwf03RaVnEuLk2P/bp
         yY61kdvApYE6qxRpAaZcrq1arCGYhyP64OfxKZGk/ZOoOi/ltDcqSmSvBtCoQmeyEyLR
         FYKxeVXO0j/kENA0AQ+2vCrGOl0VUKu3hWvpH/6m/A6hDV0bT0QlgbAqfNsNBafihzt3
         2DJiAdstGP57WhN+4kYnrr97E23PJoqPkDXeN4LhN/1bMFwtonqt5k3vmcslxFSVGhxw
         1hFhSiwDhUci9XkHK8tdvuB1zULSZaI7zSssvL59P/voaJjScrGEK282mnejgUsEtNCb
         E5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Voz9w9zuaut5zzPtd6DrE9JLrle0cFN3rE5oW1AaY2M=;
        b=jiPeSXdHExt4YyIsQllfKTI3H31kxvZ1i+TV82m9r76rAMmg1LmrXQs+5r6Sh1mKwl
         LEL2fzGI5Du3cTkazYhGAuxR9V/IQ9BsgnG4WI1NoSt5q5wr5EyKaYlKTNmNDY7oIefh
         gzfeO5Nb5onomkL+l9fOzqlz2XA1pH/g9YK+/cWgfGQCWRn97qgJZJgAWCHRkuQJD8OB
         FCMA2dJMKNkcO6i29opodoEba2tqn2ZpsfPvhcDQxVOhws9FMTZ6+Cz3V+GJt/TdE4ET
         E3gbLmbUeBrWjna0qHSUQmHsxM7A1d77eKcFd3pE5bo29zeey6rElmofZBxUbikzItGn
         CF6Q==
X-Gm-Message-State: AOAM532z5xPilUKwQ51SX4LaoOjH3hqVgR827796z1NsG3uBZ+LVfolf
        ClIMnjBwb96b6AEbxx/igB7HrHWPGZ8txSJ426Ynzg==
X-Google-Smtp-Source: ABdhPJwq0oxAvAIPreUivsgDVcSG53+v8LdcVF+reGL+9mzDGy2lOfjCUp4XCtrNh7PS7fr/4/oEr1Bunn9utBnAgNA=
X-Received: by 2002:a25:9988:: with SMTP id p8mr6404360ybo.128.1644354572175;
 Tue, 08 Feb 2022 13:09:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:174d:0:0:0:0:0 with HTTP; Tue, 8 Feb 2022 13:09:31 -0800 (PST)
In-Reply-To: <202202071325.F8450B3B2D@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-4-martin.fernandez@eclypsium.com> <202202071325.F8450B3B2D@keescook>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 8 Feb 2022 18:09:31 -0300
Message-ID: <CAKgze5YtTMmmqmrNjkCey84nSRxGpa_yajH8+9kwQLckb2dFoA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 03, 2022 at 01:43:25PM -0300, Martin Fernandez wrote:
>> __e820__range_update and e820__range_remove had a very similar
>> I propose a refactor of those functions, given that I need to create a
>> similar one for this patchset.
>
> The diff here is pretty hard (for me) to review; I'll need more time
> to check it. What might make review easier (at least for me), is to
> incrementally change these routines. i.e. separate patches to:
>
> - add the new infrastructure
> - replace e820__range_remove
> - replace __e820__range_update
>
> If that's not actually useful, no worries. I'll just stare at it a bit
> more. :)
>

Yep, that's a good idea. I'll keep that in mind for the next patch.

>>
>> Add a function to modify a E820 table in a given range. This
>> modification is done backed up by two helper structs:
>> e820_entry_updater and e820_*_data.
>>
>> The first one, e820_entry_updater, carries 3 callbacks which function
>> as the actions to take on the table.
>>
>> The other one, e820_*_data carries information needed by the
>> callbacks, for example in the case of range_update it will carry the
>> type that we are targeting.
>
> Something I think would be really amazing here is if you could add KUnit
> tests here to exercise the corner cases and validate the changes. It
> should be pretty easy to add. Here's a quick example for the boilerplate
> and testing a bit of __e820__range_add():
>
> #ifdef CONFIG_E820_KUNIT_TEST
> #include <kunit/test.h>
>
> static void __init test_e820_range_add(struct kunit *context)
> {
> 	struct e820_table table;
> 	u32 full;
>
> 	full = ARRAY_SIZE(table.entries);
> 	/* Add last entry. */
> 	table->nr_entries = full - 1;
> 	__e820__range_add(&table, 0, 15, 0);
> 	KUNIT_EXPECT_EQ(table->nr_entries, full)
> 	/* Skip new entry when full. */
> 	__e820__range_add(&table, 0, 15, 0);
> 	KUNIT_EXPECT_EQ(table->nr_entries, full)
> }
>
> static void __init test_e820_update(struct kunit *context)
> {
> ...
> }
>
> static struct kunit_case __refdata e820_test_cases[] = {
>         KUNIT_CASE(test_e820_range_add),
>         KUNIT_CASE(test_e820_update),
> 	...
>         {}
> };
>
> static struct kunit_suite e820_test_suite = {
>         .name = "e820",
>         .test_cases = e820_test_cases,
> };
>
> kunit_test_suites(&e820_test_suite);
> #endif
>

Oh that's awesome! I'll definitely take a look into KUnit and integrate
it to this patch. Thanks for the code snippet!
