Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221A75754CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbiGNST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiGNSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:19:25 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9E912AB9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:19:24 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31cf1adbf92so25599687b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UalPu2ksuWmPhMJk6j/nedFQH4vb0HRRAL+Epn4qbZ8=;
        b=j4dwcaQHxccsYOFZrXtomfe9hOl6BlVc4DQKsraUI3MJvpEoX61FMcb4nxyZRbRD+y
         SS1TtWDZUdJE1B+TtUsKSI1GUNUMmsL0zWNYoVVMksVTckyC1IYa0j6SdesEOJHPmkl1
         KyDzM+uxVRocoJ+TKjPx5nsaU32fQyQrJp+BGkwL6V5QyOccv1GCuQ8REo4/GYhuh0+P
         KGQxPNRaZzbCGKpY51IBbk0O/s7k931S2m6nM2CVV6ZYSG2TQfWxoKTZjSVLdZ2ydhyP
         To2+Hn+xOGUPAGEHyAAzB4wlp2oUgyRFggJtIs8CeZjVagrVXZRaQNI+c5LIevh68Vjf
         M9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UalPu2ksuWmPhMJk6j/nedFQH4vb0HRRAL+Epn4qbZ8=;
        b=UXxrxwpWxiAQSWsVIL5sGsuznYt9khLLpt4wmzaogEzJm3wJopwrbyw1lWjgDmc8In
         bDRmu7QxeFVuKn3gmRo/FvvrgLy8XMsdaZ/ouIiJbpJm4wp7YTDrQP/SSAKwOgu1rnHx
         d6ItzWPJyOl8+kTUnv9ChchO+2yxfc4s/enKPof6G5wYOdf2QnSCzwtB34YkK+F7s6f/
         aft1g3SJd1zNcvsfvKO7nhCnFLungX7bxMTx59U4EMiumkSsIcTb8SV3tcTg5h5nrhYt
         Ih0lNMRQUaERgUnyzzxJsY0LDvLfIWoh0lpp1H2xt8ZBoN+7Uh/bhy89jsF2obOA+qgf
         CPvg==
X-Gm-Message-State: AJIora/Upgj3qZ3V6p9V4z1egZ+yn+XHWIp3PrZOaDk60IRYv+tTMBB5
        eJ5ddA/oIbrFtwxirEnfudCtb8jkW7JfQtJdllkN2g==
X-Google-Smtp-Source: AGRyM1tyJfI1/uNHge25px5/PLanVAieHbxdM60iopHkkljV0nkYyMuYqzY2eroNzQHCTe3fJ7VxxB7ATKaOGnnw3vY=
X-Received: by 2002:a81:4427:0:b0:31d:b9ad:4a7c with SMTP id
 r39-20020a814427000000b0031db9ad4a7cmr10743607ywa.396.1657822763794; Thu, 14
 Jul 2022 11:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
 <Ys40uw4QIe4fQKA/@google.com> <CANkg5eyehcECGeDHBEsxR=iOoyMwzkcpvX+oRxy7PJPYLD=VuQ@mail.gmail.com>
In-Reply-To: <CANkg5eyehcECGeDHBEsxR=iOoyMwzkcpvX+oRxy7PJPYLD=VuQ@mail.gmail.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Thu, 14 Jul 2022 12:19:12 -0600
Message-ID: <CANkg5exT1kFr9WBQEGD0=ndH1aJMD3OXmuZ4Obx9JtVDgKS6ow@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rrangel@chromium.org,
        robbarnes@google.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

[Resending in plain text mode]

Hi,

> Please be consistent.  Either way:
> - .prepare and .complete.
> - .prepare() and .complete().

I'll address this in the next version.

> The patch doesn't allow EC to log anything.  It makes AP emit more logs.

This patch changes when the EC outputs the host command that indicates
the AP is starting suspend and finishing resume, due to the change (in
this patch) when the AP sends that host command.   This makes the EC's
logs more accurate when correlating them with the AP's logs in regards
to when suspend is started and resume is completed.   Previously,
those events were sent when suspend/resume were already in progress.

We'd also like to keep the new logs emitted by the AP to make it
clearer when the AP is starting suspend and completing resume, so we
can correlate it with the EC logs more easily.   This should aid
debugging and timing analysis.   Since it only occurs during
suspend/resume, it shouldn't flood the logs and follows the logging of
other driver PM functions.

> I didn't see concerns in [1] have been addressed.

I replied to the first email stating why we want to keep the log
message (and reiterated it above).   What's the correct process to
indicate we don't want to make the change requested in [1]?

On Wed, Jul 13, 2022 at 12:05 PM Tim Van Patten <timvp@google.com> wrote:
>
> Hi,
>
>> Please be consistent.  Either way:
>> - .prepare and .complete.
>> - .prepare() and .complete().
>
>
> I'll address this in the next version.
>
>> The patch doesn't allow EC to log anything.  It makes AP emit more logs.
>
>
> This patch changes when the EC outputs the host command that indicates th=
e AP is starting suspend and finishing resume, due to the change (in this p=
atch) when the AP sends that host command.   This makes the EC's logs more =
accurate when correlating them with the AP's logs in regards to when suspen=
d is started and resume is completed.   Previously, those events were sent =
when suspend/resume were already in progress.
>
> We'd also like to keep the new logs emitted by the AP to make it clearer =
when the AP is starting suspend and completing resume, so we can correlate =
it with the EC logs more easily.   This should aid debugging and timing ana=
lysis.   Since it only occurs during suspend/resume, it shouldn't flood the=
 logs and follows the logging of other driver PM functions.
>
>> I didn't see concerns in [1] have been addressed.
>
>
> I replied to the first email stating why we want to keep the log message =
(and reiterated it above).   What's the correct process to indicate we don'=
t want to make the change requested in [1]?
>
>
> On Tue, Jul 12, 2022 at 8:58 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>>
>> On Wed, Jul 06, 2022 at 08:51:39PM -0600, Tim Van Patten wrote:
>> > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_suspend() during PM
>> > .prepare() and cros_ec_lpc_resume() during .complete. This allows the
>> > EC to log entry/exit of AP's suspend/resume more accurately.
>>
>> Please be consistent.  Either way:
>> - .prepare and .complete.
>> - .prepare() and .complete().
>>
>> The patch doesn't allow EC to log anything.  It makes AP emit more logs.
>>
>> On the related note, the commit subject is confusing.  The patch doesn't
>> send "host event".  "host event" is a terminology when EC wants to notif=
y
>> AP something.  Also, s/cros_ec/cros_ec_lpcs/.
>>
>> > Changes in v2:
>> > - Include cros_ec_resume() return value in dev_info() output.
>> > - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
>>
>> I didn't see concerns in [1] have been addressed.
>>
>> [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220701=
095421.1.I78ded92e416b55de31975686d34b2058d4761c07@changeid/#24920824
>
>
>
> --
>
> Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997



--=20

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
