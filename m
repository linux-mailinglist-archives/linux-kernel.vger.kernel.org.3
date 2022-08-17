Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F2596E44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiHQMQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiHQMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:16:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9086B55
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:16:14 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A85E3F46F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660738572;
        bh=DSb7iQYDJqXj92ygGsNtJZCJ5hZY67yzyY/MzoJmNKE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KRDNs4DlZy0naxAqTyeX1AwWIBsGndM/pZCct6xxhGDhtruewwNGbnLNqFtR/+xVu
         Vi8uMkkLwuBExQqEHSKegzN52m4KQ1oFmF59s6ZWAMrczktLTAduHMxS+LN4ecn2vr
         W1vVAiAJIfkn0zqMMsVKsNM2PX0D/MTbcBtm+j6q+Ra7CjjFvDvmNjyMPot7/680H8
         XHwnHVTDywMfU4SXcTj/eoRcqqCH2iKJsf/Ksh11S07ebk7mNJJ7mmBtqR63NMAiH8
         5p0oTwOe1UyY4X7UHyizoP7XRdGKPBpRwvgPWNr1Jb8gLGbgHMf5VKauPZobUO7RE6
         +oyiLh7AqG5Xg==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-117b96393f3so3893028fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=DSb7iQYDJqXj92ygGsNtJZCJ5hZY67yzyY/MzoJmNKE=;
        b=DAQH3p7cemVS2QWRcBi49mgouQG4Krkk3b1GB1ZnQhaQChuxS+OMWxVlQRT8r8KL30
         A5YZ22H6ZO5DpELH6oTzIfGv/QZONW4E29PrD2TOZa0KmTxkgSIrTcIgekElwWy2db1g
         F8dyGEHFgEUGaXCtrEyRVAES5NByLjBo0YMoNKbvfzkoQosN+R5xdKGq7Vs8XwFs9mfN
         WVZ9JfXIbOppD6MFbEA8xV0BRPYQNZyNKgP1uKgVkyRZBLsY84rJ2n9jJwnnlhOF7xu+
         XqhJ+cHea9Dwbunn/AmkzO0aDncwA/YKCcqJ0z6CF7jDbrGTCRHP+4sUNjP6vXv82ie/
         un7w==
X-Gm-Message-State: ACgBeo0TyMctxxxAynyBYkMRpYVs+wuuJ1MnY4OYrZ8wjzKdNS2saghT
        nwif/nsaPwmCEriJJVNbB0cySydZUyfiEgKldk6BGSudS4LUQFH7mJgO/aHbW/tJOodCw6E6r6N
        TKkd8zV0cdQQRphkhZFjdZmHc5mgOFnfMcFZqazMGNrbL7i37Nhgzz+DK9Q==
X-Received: by 2002:a9d:f05:0:b0:637:1068:1081 with SMTP id 5-20020a9d0f05000000b0063710681081mr8767017ott.224.1660738570900;
        Wed, 17 Aug 2022 05:16:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Z5e/K5f+romlAexEX5pnAcJ6x32GsOIarjF+40/jrQPnGq70CyhTWg+eQG6ziTT55YrNeb9nZ9rmgCxcOdlo=
X-Received: by 2002:a9d:f05:0:b0:637:1068:1081 with SMTP id
 5-20020a9d0f05000000b0063710681081mr8767013ott.224.1660738570591; Wed, 17 Aug
 2022 05:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
 <CACO55tt=Op=0E94kK+1M8cDXNCk5Tkc=FMR8=OQFc5ohehjwaw@mail.gmail.com>
 <CAAd53p49X95MKrTDUq92LuHw3y2i09fUA2HEPzM1EcO8xO97Eg@mail.gmail.com>
 <CACO55tvgmb4Vog701idDYGuh125S9mjWPXhftxDMZ7hg-nQXBw@mail.gmail.com>
 <CAAd53p4W9rjmVJcUasy9hb1Yam+846+Oomvc2r9RMNmWeh_=0w@mail.gmail.com> <YvzYGGXils/Gf44d@intel.com>
In-Reply-To: <YvzYGGXils/Gf44d@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 Aug 2022 20:15:58 +0800
Message-ID: <CAAd53p49zc2G1KutPMUcUBM3_rbCh9_40e0mdtcZKb+C69QL_Q@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when
 it's supported
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        Zenghui Yu <yuzenghui@huawei.com>,
        Imre Deak <imre.deak@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 7:59 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:

[snipped]

> I had a quick trawl through some Windows stuff for this and
> it does seem to do a few extra checks:
> - platform must be TGL-H (nothing else has the DPin stuff I guess)
> - OpRegion header must indicate dGPU presence

Is the dGPU presence denoted by the return bitmask of
INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED?

IIUC the mask 20 won't be set when dGPU is not present.

>
> Otherwise it does call this DSM uncoditionally on boot/S4 resume
> so seems like that is the only really validated configuration.
> Although it does seem to explicitly turn off displays prior to
> the DSM so that does perhaps indicate that those ports might have
> also been enabled via the iGPU by the BIOS. Not sure if disabling
> the ports would work correctly after the DSM or not. If not then
> the DSM call would need to happen after state readout/sanitization
> so that we can shut things down gracefully.
>
> Additionally after the DSM call it scans the FIA TC live state
> bits to check for DPin usage. Looks like its trying to make sure
> the driver stops poking at the relevant power wells once in DPin
> mode. i915 doesn't check that stuff atm so we might end up
> mangling something while the dGPU is driving the port.

Thanks for investigating this. I am not really familiar with other
stuffs you mentioned, but I am happy to test any follow-up patch.

Kai-Heng

>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
