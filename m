Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6352554D2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346274AbiFOUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbiFOUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:48:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5D54F80
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:48:36 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l204so22537729ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qa3tsYK2bljXrt3Mkxfz0grFVBOVa6KK4MmffPa/HZs=;
        b=RX18XnnfqjfkM7VzGEEtNwFnp9OLKHeAAzouCcexVXysP2zke5k1vt4V+P62kKD1nx
         TGGY6CwUOsIqQu7kYnQlucj4iszPS9+Q1PuHOCOFXWzBW4s6s521IumeVVkFLllSeaAJ
         /Vsac2wvJ6G4zIQenT3j2ZhDPDn/Tpp+gd2no3DpbR6U6U6/+BgWYTo054K0966aKwvj
         WcIr0GcR1pngLv0/yeHnjj48jx14ft+D/bQLBdOUGwu1HnynsZLXRg+uoYnnyAPTL7P8
         krZcbM7mpBudQ3y8HAz5Z7P3zDEV6MFKqaLCnc45hfD2KLIJSZzeKA919PcsYRYJJi5e
         8uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qa3tsYK2bljXrt3Mkxfz0grFVBOVa6KK4MmffPa/HZs=;
        b=5Uxr09TiFLfEZdXAztqN8llcBgRimevgIuwrTGOzhNF2qCshIoUs3T+B/APGNs/XkZ
         HbgK+YpeGFBuPdSbjHbVo9eBb1xOdj0H56oRDokl6w6KmwwBHrU//OvUaYpRlDvSK5v3
         YWEWtoQt38rVTxKHn0TLXoTo8XQNcAKcn1vcH0Bl6krlpz77l+xQrRn6qXCC/N1hZlkd
         djjHVGgsOvpC86QLAAtmzlpe7nVDJTzPQ85WVNyxr/T35Zm25kZBxi3TKnM5nJhj70mI
         fPuRryeZ1oVfGBVDS9ItkGDG/JbuoZ/AVyTzFeDCvzRoUdRsXuu50Jqx+CLMZn1E1eBn
         +Bjg==
X-Gm-Message-State: AJIora+31ulr9zvvfuox8ie+gFAuCHSs5DqMHnwV1I1F8RdUSmxjKAYa
        rO0bkKdEG0w1UDJKAY7ruvkrfbNiXzA6bTlFCkpHDg==
X-Google-Smtp-Source: AGRyM1vsKJDK8HulI5fnoOJIzelifBQivxt1+XV6dPPW5onay514r37hk3mZP8WxEAAyZe2g4j8MQ/qUUNPZliuSu54=
X-Received: by 2002:a5b:884:0:b0:65d:1c7c:4f33 with SMTP id
 e4-20020a5b0884000000b0065d1c7c4f33mr1836464ybq.601.1655326115552; Wed, 15
 Jun 2022 13:48:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:af52:0:0:0:0:0 with HTTP; Wed, 15 Jun 2022 13:48:34
 -0700 (PDT)
In-Reply-To: <CAFmMkTGFpehSFOsnDuQN4aTnwfgYGwTbGBxtvUU_byDcoRVPPA@mail.gmail.com>
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
 <20220615190519.GA1524500@alison-desk> <CAD2FfiGxy=9ARK5FT_iaLACZSzR+R4crmGJv7T+v_w3+ktOzCQ@mail.gmail.com>
 <20220615195425.GA1524649@alison-desk> <CAFmMkTGFpehSFOsnDuQN4aTnwfgYGwTbGBxtvUU_byDcoRVPPA@mail.gmail.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Wed, 15 Jun 2022 17:48:34 -0300
Message-ID: <CAKgze5aQsh2VY4tjsDco_Wc6CTU+KXZM3bhFR+73AVp3gLWHuA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Richard Hughes <hughsient@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alex Bazhaniuk <alex.bazhaniuk@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22, Daniel Gutson <daniel.gutson@eclypsium.com> wrote:
> On Wed, Jun 15, 2022 at 4:54 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
>>
>> On Wed, Jun 15, 2022 at 08:34:58PM +0100, Richard Hughes wrote:
>> > On Wed, 15 Jun 2022 at 20:06, Alison Schofield
>> > <alison.schofield@intel.com> wrote:
>> > > My first reaction is lying about the cpuinfo is not a soln, since
>> > > it creates a problem for a users currently relying on cpuinfo to be
>> > > the source of truth for TME.
>> >
>> > I think you have to qualify "source of truth". At the moment the CPU
>> > reports "Yes! I support TME!" and then for one reason or another the
>> > platform turns it off and actually there's no memory encryption of
>> > your secrets at all. There's seemingly no userspace way of telling if
>> > TME is actually active. We were told that we shouldn't export the
>> > "platform has disabled a CPU feature" in sysfs and just to clear the
>> > cpuid flag that gets exported (like AMD is currently doing) which is
>> > what Martin proposed here. Programs want to know the true CPU
>> > capability can do __get_cpuid_count() like they can for the SME/SEV
>> > capabilities.
>> >
>> Disagree on sending folks to use __get_cpuid_count() when they already
>> have cpuinfo.
>>
>> Why is a sysfs entry TME-enabled 0/1 a bad thing?
>
> :)))
> This was my very first patch, and I got half of the community complaining
> It was so long ago that I don't recall everything, maybe Mart=C3=ADn does=
?
> or Richard?

The discussion triggered the fact that checking that TME is active is
not enough to tell if memory is being encrypted or not (which we
thought it was true by that time), and that triggered a series of patches t=
o
address the other checks required, which is currently going nowhere
[1].

The sysfs _wasn't_ discarded perse, but since Boris suggested the
change in cpuinfo (several times now that I recalled that Daniel patch
[2]) I think that is cleaner, besides the backwards compatibility.

[1] https://lore.kernel.org/linux-efi/20220429201717.1946178-1-martin.ferna=
ndez@eclypsium.com/

[2] https://lkml.iu.edu/hypermail/linux/kernel/2006.2/05231.html

>> It can be documented
>> to have the same meaning as the log message.
>>
>> You keep referring to AMD. How is their exception documented?
>>
>> Alison
>>
>> > > Are we to tell them to go look in the
>> > > log now, because fwupd folks didn't want to ;)
>> >
>> > We're not telling anyone to use the log; grepping megabytes of
>> > unformatted kernel logs is a terrible (and slow) way to get one
>> > boolean value.
>> >
>> > Richard.
>
