Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5020E523604
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiEKOos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbiEKOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:44:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A2CC9EED
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:44:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 204so2192991pfx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=bhQcuDbFN+fU3KR8R1nULy14OTLdd3tjeHOq6LBw/jA=;
        b=MfXAcKYU2l7shoPUEUT9umv0AimyIjCIDa/u/6CQTXKd7rI7SytNx4+XIbFn2F/H5L
         XmIfFWQ18UDPbWGEP7Dz38TbOKQYHunwXjiaAf1k/d6A2vSpF8yYFGpbr/TrbQtY/JBQ
         nlboE1r/uv06bW4AmuUu5DuZnkZwKEcor8K4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=bhQcuDbFN+fU3KR8R1nULy14OTLdd3tjeHOq6LBw/jA=;
        b=HxTEyg8c7JFfAYFXu0fU3hgl2fZ96m4WLmmavXf8hCAcLAVHfnCP4dHF+euogwYkAv
         YXi+6AiZGDx8QonWvawkCvztyF7ml/Y+oljxweuaamJ/ojlWnczOnEBv8cP42bI3fRiM
         tjmcTOhQlZ6LAPVAlRBdvdXp1m3CiDDztB0ac6YjdSCYNyhiOjx7J4fcaFdRFXVwJEcy
         EkJc7H4yoJMAXKMNaPKHYjSiBhGFEvMkA5i8O5wlffLnDfrI4sUJny2Dv7vg++7oppsA
         9EN7N7s2wa+88aU/OlK7IOn/JOLYvhaFlZvTkYfns9CXq2nmG0fOijGNBz0oY75xTBXM
         5HQw==
X-Gm-Message-State: AOAM532a0arJrXjYjj+e5FOzJ2mbWIUtwnpLm+3wGRAMjuWM8+hxVrxt
        xeY6Qxjxgt1MZVx2yQ4raQ/W0npgBfrwTg==
X-Google-Smtp-Source: ABdhPJxZRgTo5oBTB6xChSJb/iElkzIkdPJzP8D0P+aQil2OueSocD8iod/FzFrA7CbbxWv7NK/PaA==
X-Received: by 2002:a63:941:0:b0:3c6:8d64:ec01 with SMTP id 62-20020a630941000000b003c68d64ec01mr15724384pgj.322.1652280284455;
        Wed, 11 May 2022 07:44:44 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090a420600b001cd498dc153sm2722800pjg.3.2022.05.11.07.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 07:44:44 -0700 (PDT)
Date:   Wed, 11 May 2022 07:44:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Alexander Popov <alex.popov@linux.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
User-Agent: K-9 Mail for Android
In-Reply-To: <YnttpThLX0tgrw5i@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com> <20220427173128.2603085-4-mark.rutland@arm.com> <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com> <YnpQqBwYjlVffJk8@FVFF77S0Q05N> <202205101958.2A33DE20@keescook> <YnttpThLX0tgrw5i@FVFF77S0Q05N>
Message-ID: <33711C66-BB24-4A75-8756-3CDDA02BC0CD@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 11, 2022 1:02:45 AM PDT, Mark Rutland <mark=2Erutland@arm=2Ecom> wr=
ote:
>On Tue, May 10, 2022 at 08:00:38PM -0700, Kees Cook wrote:
>> On Tue, May 10, 2022 at 12:46:48PM +0100, Mark Rutland wrote:
>> > On Sun, May 08, 2022 at 09:17:01PM +0300, Alexander Popov wrote:
>> > > On 27=2E04=2E2022 20:31, Mark Rutland wrote:
>> > > > In __stackleak_erase() we check that the `erase_low` value derive=
d from
>> > > > `current->lowest_stack` is above the lowest legitimate stack poin=
ter
>> > > > value, but this is already enforced by stackleak_track_stack() wh=
en
>> > > > recording the lowest stack value=2E
>> > > >=20
>> > > > Remove the redundant check=2E
>> > > >=20
>> > > > There should be no functional change as a result of this patch=2E
>> > >=20
>> > > Mark, I can't agree here=2E I think this check is important=2E
>> > > The performance profit from dropping it is less than the confidence=
 decrease :)
>> > >=20
>> > > With this check, if the 'lowest_stack' value is corrupted, stacklea=
k doesn't
>> > > overwrite some wrong kernel memory, but simply clears the whole thr=
ead
>> > > stack, which is safe behavior=2E
>> >=20
>> > If you feel strongly about it, I can restore the check, but I struggl=
e to
>> > believe that it's worthwhile=2E The `lowest_stack` value lives in the
>> > task_struct, and if you have the power to corrupt that you have the p=
ower to do
>> > much more interesting things=2E
>> >=20
>> > If we do restore it, I'd like to add a big fat comment explaining the
>> > rationale (i=2Ee=2E that it only matter if someone could corrupt
>> > `current->lowest_stack`, as otherwise that's guarnateed to be within =
bounds)=2E
>>=20
>> Yeah, let's restore it and add the comment=2E While I do agree it's lik=
ely
>> that such an corruption would likely mean an attacker had significant
>> control over kernel memory already, it is not uncommon that an attack
>> only has a limited index from a given address, etc=2E Or some manipulat=
ion
>> is possible via weird gadgets, etc=2E It's unlikely, but not impossible=
,
>> and a bounds-check for that value is cheap compared to the rest of the
>> work happening=2E :)
>
>Fair enough; I can go spin a patch restoring this=2E I'm somewhat unhappy=
 with
>silently fixing that up, though -- IMO it'd be better to BUG() or similar=
 in
>that case=2E

I share your desires, and this was exactly what Alexander originally propo=
sed, but Linus rejected it violently=2E :(
https://lore=2Ekernel=2Eorg/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=
=3D82SPKCpLQ@mail=2Egmail=2Ecom/


--=20
Kees Cook
