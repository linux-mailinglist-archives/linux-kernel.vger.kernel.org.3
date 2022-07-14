Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A9F5755AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiGNTPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGNTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:15:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2005C2DA88
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:15:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h19-20020a9d6f93000000b0061c1ad77d5fso1901391otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ug2UPgCJkGZUd3eex6JqeDleZ7+02+BMSb3Xz7COUc=;
        b=Io5jX6M9weRAKZ/6bMrsI8c8J91V/f1tIOtj5YAO1fyr5fHIKqAq5YTdfPClmWJ9lG
         G+eccMYlKa2OjnFV35nGLX12gbdsyt1hS0MOywHfOUcsCsIHRfrjJ6nRJTM52/zu2oOL
         oRr6XqoYyR3dikXRM0G3vFyCIA/DyNcsCEHUr4m2d2exc1dypdcY8FWfQA65j4ryKjJw
         OzLZH/yynbmNCwURJvhAgf1aaOsHa3TqPoBVdUYfbkZUTbDEKEsAFPOIlViGMDP4Oik4
         BRPPoGmhOEPw5LJkZ3pr7VpEgxyz7LRcYYzZ4Eg47fntv8AuTAlm/+Rd/su9T6a95OTG
         Fu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ug2UPgCJkGZUd3eex6JqeDleZ7+02+BMSb3Xz7COUc=;
        b=jaWn6e/jrOoSf5fCeVaABdWHWYRoN6TZanlmWkPf/437uZlC6tfbd3Fgn9kcvTAvml
         6AsSyeMBma2ByVWAKx9+k97HL+LPI9tw6hisJs9r7RssS+OmAoswx7u63Dxvc7Hcd+Ji
         AgxRpymxC2qe9lJKGW6cxUygYoXSFnE/3ltdPCYRWwtD3TZsdNyFzEXvFizckPOR7kTQ
         fj3UULC+EoYkLAkMGegUlPet4fyYjUG3RteMWUVxGmniwYEEtM7flfUk/D0VB6K/AEf8
         x+5kPqsJW7YTAObDZTLMCk5UuMAc2+nFqFxV671bPuQ9Fcls/LdAlPi+Y6g9MpbL51hb
         T1nw==
X-Gm-Message-State: AJIora/fZuYqHalRVoAsMicfHUL7gY8JiU+NrpPtspc3MHC83QRns9O/
        cuVWMalQp94DHMV/1XFrvt03ciyRAsRGc9yvyso=
X-Google-Smtp-Source: AGRyM1stqM3E5mwFGwQ2lR0dWVowA7yGZNm59iYRC0kLE+g9B/OUxRZxoiYcZ38Q2C1aW52XStMckREctFCzptWXHFE=
X-Received: by 2002:a05:6830:2645:b0:61c:5aad:632 with SMTP id
 f5-20020a056830264500b0061c5aad0632mr4012466otu.169.1657826131215; Thu, 14
 Jul 2022 12:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220713124958.3094505-1-bbara93@gmail.com> <OSAPR01MB50602133D5009DFE59C93458B0889@OSAPR01MB5060.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB50602133D5009DFE59C93458B0889@OSAPR01MB5060.jpnprd01.prod.outlook.com>
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 14 Jul 2022 21:15:20 +0200
Message-ID: <CAJpcXm5t0bd9McYAipKVVc=_N0ddvxLQVbZuX9LUysmn3ivzKw@mail.gmail.com>
Subject: Re: [PATCH] regulator: da9063: disable unused voltage monitors
To:     DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
Cc:     "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        richard.leitner@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 11:36, DLG Adam Thomson wrote:

Thanks for the quick feedback.

> What exactly is the problem you're attempting to resolve through this patch?

I have some use cases where certain modules (e.g. audio) are not required.
Therefore, I have removed a couple of "always-on" from my DT to let the kernel
decide if the regulators are needed.
Since unfortunately some of the later disabled LDOs are monitored, the state
becomes invalid.


> If you disable monitoring of a regulator, and no other regulators are being
> monitored at that point, then GP_FB2 will no longer be asserted and you
> have the same issue.

Thanks for the clarification, I wasn't aware of that.
It's clear to me now that this would become a general problem.


> What's more this patch impacts all users and there's no means to re-enable
> monitoring.

I am aware that the patch is not complete to handle the whole voltage
monitoring of the da9063.
So if wanted, I can extend the patch to store the vmon state when disabling
it and restore it during the re-enable process (can also take a look for the
handling while sleep/suspend).

best regards & thanks again,
bb

P.S.
I checked if there is some existing kind of framework for voltage
monitoring of regulators, but I couldn't find something so far.
I can imagine it might make sense to have a DT property for
"regulator-monitor-voltage-on/-off" to override the OTP settings via DT,
but I am not sure if this is something that is needed/wanted/required.
