Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52D4AE221
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385975AbiBHTUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385964AbiBHTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:20:08 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8056CC0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:20:06 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id bt13so28807807ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JxTFoE10Xqe5d3z4zOPiFNFHsiuqJzkr1QYZntPRQM=;
        b=GTHGYForIk5Fc+B3ly6NQIqzu76350nZw/zcVJV1GYoex90pIOQWA5cBUqP0smIYOa
         HoI4ymg+6rnCuRF0IYyh2u8IB3AN7ya9qi1ZcKuD0JhuFUjll+OYHAemD5SRnJ0u3G2w
         cpY6mwL4z3I7a3vVzUU/4NI9HcfSvwHaNLUH4nEynWyqhoaKFIvaRzHSDEcXjNPolrw1
         Z5gyGFKMgPcanS5YHmm3T1UzXQHrVwk7PD5lFHrHIIbrjTtDMnKIsST02C+7PqDe/OWZ
         fpPH7qXeuZ7u4FAjrwZvMT4oxhZ8xlYN6n/RXkTjwhverTuHFhg3ZMfVs5WU/j0MCByG
         +5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JxTFoE10Xqe5d3z4zOPiFNFHsiuqJzkr1QYZntPRQM=;
        b=iYRnPmRstVbibBhpfWhq3KnLbmH63oTl6XqJwDHCM8HZ++U+gTM8j9hdf4ZZZiKgAA
         CRjvVsprcVL/X9FtQIWYmxD7mHHqA08t3MSZfxjGYWdRNeZ0M/3NfMnE7QzdobQI8On2
         nwvcd/AZ1iHi41/FCwJSdwZAC7d8BQb/cEAK2USxZNaDprUhhzFkp37P3yqcsVdYwRrp
         zdwK7frBUXO6gu0G/1T+0WGTa9a1GVJiOzDkg90xDXZKrZqUfoYEtLskX/uzNiita89Y
         c9RKoj0P0pC8RQL+qUM+wx3LWRFY8r6KQ0Cf36ggRCWFvBwUsn6AhMFZ5O3fekxVCHfJ
         KAtA==
X-Gm-Message-State: AOAM531AFAE9xQp9NECy9qyZmf3Jioznw5mDw9IDA9r1x4kkp+VUgikv
        vyCk/QHg0dbOEgp8YMEA2iHQ8u+ENA+grbf0HJFKE2+B88ylbg==
X-Google-Smtp-Source: ABdhPJy/2ZJsdNIpfT19XC99EZa++n0vY+09GTEwdIyYzwjIrajZCMmDIQh50dNobDk17ev42L4L5l7uya+oNR03sQ0=
X-Received: by 2002:a0d:e305:: with SMTP id m5mr6327794ywe.375.1644348005640;
 Tue, 08 Feb 2022 11:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
From:   Angela Czubak <acz@semihalf.com>
Date:   Tue, 8 Feb 2022 20:19:54 +0100
Message-ID: <CAB4aORW_b+6=a-fXCL-MJoM9uNvjeYL01W85Rb=6rMP-Nm11QQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] HID: fix for generic input processing
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Wed, Jan 26, 2022 at 5:18 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi,
>
> This is a followup of the discussion we had between Wacom and
> the maintainers, and a followup of those 2 patch series:
>
> https://lore.kernel.org/r/20211022232837.18988-1-ping.cheng@wacom.com/
> https://lore.kernel.org/r/2ca91ac7cf92e3048a236db3cd519f04e12c1e61.1615224800.git.nabijaczleweli@nabijaczleweli.xyz/
>
> It took me a while to get it right, but I finally can submit the
> series:
>
> - the first 8 patches are some cleanup in the hid-input.c and
>   hid-core.c code. They also create a list of input fields that
>   is then used to process the event, in the priority we think
>   is good.
>
>   For instance, on multitouch devices, it is better to have
>   Contact Count before processing all touches, and in each
>   touch, having Contact ID first is better. This series doesn't
>   cover hid-multitouch, but I have a series on top of this one that
>   does cover it.
>
>   Anyway, in our case, here, we need to process Invert before
>   In Range for tablets so we can make a decision whether the user
>   has the intend to erase or not.
>
> - patch 9 enforces the invert usage before In Range as mentioned
>   above
>
> - patch 10 is the actual bulk of processing that should fix the
>   generic tablet handling. Now that we have a reliable ordering
>   of the fields, we can compute the state of the tool in a reliable
>   way, and be kinder to userspace by not sending to it 2 tools at
>   the same time.
>
>   This patch has been extensively tested by hid-tools with the new
>   MR I submitted that add tests for tablets [0].
>
> - patch 11 is a nice to have that I need for my second series regarding
>   hid-multitouch. It is not mandatory with that series, but given
>   that it changes the format of the priorities in hid-input.c I thought
>   it would be best to send it as part of this series.
>
>   Note that now we are tagging the *reports* and the individual fields
>   when they are part of a multitouch collection, which should help
>   the drivers that implement this processing (hid-multitouch and wacom).
>
> - last, patch 12 is an attempt at fixing the documentation regarding
>   BTN_TOOL_* (requested by Peter).
>
>   Dmitry, feel free to take this one through your tree if you prefer
>   to do so (and if you are happy with it), otherwise we can take it
>   through the hid tree.
>
> As mentioned above, I have a followup series not entirely tidied up
> that implements the processing of Win8 mutltiouch devices in
> hid-input.c.
> There are several benefits for that: we should be able to drop the
> multitouch code in wacom.ko, we can simplify part of hid-multitouch,
> and we will be able to quirk a particular device in a separate module,
> without touching at the generic code (in hid-multitouch or hid-input).
>
> Anyway, I am missing a few bits for that so that's coming in later.
>

Is there any timeline for the followup series? I am wondering how that
would affect haptic support implementation.

> Cheers,
> Benjamin
>
>
> [0] https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127
>
> Benjamin Tissoires (12):
>   HID: core: statically allocate read buffers
>   HID: core: de-duplicate some code in hid_input_field()
>   HID: core: split data fetching from processing in hid_input_field()
>   HID: input: tag touchscreens as such if the physical is not there
>   HID: input: rework spaghetti code with switch statements
>   HID: input: move up out-of-range processing of input values
>   HID: compute an ordered list of input fields to process
>   HID: core: for input reports, process the usages by priority list
>   HID: input: enforce Invert usage to be processed before InRange
>   HID: input: remove the need for HID_QUIRK_INVERT
>   HID: input: accommodate priorities for slotted devices
>   Input: docs: add more details on the use of BTN_TOOL
>
>  Documentation/input/event-codes.rst |   5 +-
>  drivers/hid/hid-core.c              | 280 ++++++++++++++++++++---
>  drivers/hid/hid-input.c             | 330 ++++++++++++++++++++++------
>  include/linux/hid.h                 |  23 +-
>  4 files changed, 533 insertions(+), 105 deletions(-)
>
> --
> 2.33.1
>

Does this patch series introduce the leaf driver support you mentioned
in the haptic review?
