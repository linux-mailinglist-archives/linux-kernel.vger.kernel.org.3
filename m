Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50E5223C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbiEJSVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243136AbiEJSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:21:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E536315FCB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:17:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 961251F8C1;
        Tue, 10 May 2022 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652206659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiGLHqQlexjKp2BCk/wVVn8oKcq1hyMdphZCk4Mecmk=;
        b=FJ/35b9BVDalbSkvNr3+Dnf4RLDEqQwFxW2y25rnm7oKIqQ32a0DwCX5vKaxteDBm4+64q
        q1VKW5GZPX/L2Rbvh9kjtN6ZXFshll6uQndDSttzC2+UBjLynlnjSPMTkD/Vx430llG3ns
        6G6V2NShE4ICZGJkalATUxc7sV05Qd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652206659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiGLHqQlexjKp2BCk/wVVn8oKcq1hyMdphZCk4Mecmk=;
        b=wAaQwnykYpP5wcAAHomQMuBG/2Magts3Quiv9hbSXtw62XmDGlxZA0Xvl10KK3N5FLOVxp
        gLH6fX3lvkLIv4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 295FB13AA5;
        Tue, 10 May 2022 18:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lug+CEOsemL4LgAAMHmgww
        (envelope-from <jroedel@suse.de>); Tue, 10 May 2022 18:17:39 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BUG] Warning and NULL-ptr dereference in amdgpu driver with 5.18
From:   =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>
In-Reply-To: <CADnq5_NYVvjcUru9hfbnATfcHJR5+eiK9bJAA9m41WKa=OJsog@mail.gmail.com>
Date:   Tue, 10 May 2022 20:17:38 +0200
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <505081FC-4323-4424-87A9-89B95A89515D@suse.de>
References: <YnTAc96Uv0CXcGhD@suse.de>
 <CADnq5_NT3UtawpGuPDwF+dgmRdaoysb7sD_-oWWBC=T3BoUH7Q@mail.gmail.com>
 <YnpIjdTT3esZ72Bf@suse.de>
 <CADnq5_NYVvjcUru9hfbnATfcHJR5+eiK9bJAA9m41WKa=OJsog@mail.gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 10.05.2022 um 17:31 schrieb Alex Deucher <alexdeucher@gmail.com>:
>=20
> On Tue, May 10, 2022 at 7:12 AM J=C3=B6rg R=C3=B6del <jroedel@suse.de> =
wrote:
>>=20
>> Gentle ping. This is a 5.18 regression and I also see it with
>> 5.18-rc6. Please let me know if you need anything else to debug.
>>=20
>=20
> Are you doing anything special when it happens?  I.e., does it happen
> when the monitor is coming out of DPMS or something like that?
>=20

Yes, it usually happens when I return to the machine and press some =
button on the keyboard to get the screens enabled again. It doesn=E2=80=99=
t happen always, it seems to depend on how slow the monitors come out of =
power saving mode.

Regards,

J=C3=B6rg R=C3=B6del
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany
=20
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev=
