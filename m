Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A70509C29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387520AbiDUJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387461AbiDUJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BDA425E88
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650532550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GBI+dW7/NO5MYmhrOVhiWRnYsRGOAInfWi+gKO1iL4=;
        b=ONqOD8bhluonoKUEnzCDbt+qyiQhnQWamSonjdniBZQIuD2TKS/ekLX+y7veLLVMV2HqIA
        GSyvUiB4cUJzEEGtDQf49EGEfaQOOSO1eFz+W/3m7XQ9bXHJKZT3ndZYdhe3W48NE1g9yi
        WACenZpJjztvzZEpgYXgxJO0SZGFB3k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-Yp9uKak3Ne2IgV8fUZ6S8w-1; Thu, 21 Apr 2022 05:15:49 -0400
X-MC-Unique: Yp9uKak3Ne2IgV8fUZ6S8w-1
Received: by mail-pj1-f72.google.com with SMTP id oo16-20020a17090b1c9000b001c6d21e8c04so4752968pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6GBI+dW7/NO5MYmhrOVhiWRnYsRGOAInfWi+gKO1iL4=;
        b=8NDZazsLgkIEThD1c0KxBdU334st6ajah1Nnm5b1lNEXmJSP4nx0ZI1aoHGMvisAQl
         8Tv0a33kOep9qgzgJH5j2O0ikIbkshJ8N7ZPAPwmvrmH3AuLGWOREyLVhX9ZovHKOeM0
         vQ76MntlN9u3wPEU0RhSBcX1e2LV35XwkC6Bf/niHiVFpKg2o5d/utrzi8fnviBqbJqq
         6c3LVmHPYQRfpyO2+kHK2+tLWVKw2G3Yf208mONy4KJZ7bRGHf2ExTD+FVIr8LoP90Qs
         U7GZYQLIGN7NZkHShm2Dlj0KA3quI2UYpF/2cel+0YWbiayQ194jlZhRHAClml4VTq5T
         7uow==
X-Gm-Message-State: AOAM531x2Utnr352fCvM1iAelR+3Fo8C1bvEQgymY56aZ1c4SHfDYT4B
        VQg1qLK8o2yJyud+5b7OLGxnpqidzB2Zk0dxKmmMgpkOTC1MNZeWRrrebAlJv6at4TijD1Kounn
        reYL739+jjoxvnLywvbErCgme0ES6o8XvkeRd61bo
X-Received: by 2002:a63:444f:0:b0:39d:3aa5:c9f0 with SMTP id t15-20020a63444f000000b0039d3aa5c9f0mr23334461pgk.363.1650532547840;
        Thu, 21 Apr 2022 02:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8NrWxgRbjiR50laTOy0tvspGBzaPfZ8HJnTKIdhi6K9j+LzMjrjrtDYZUPjGUaa3frz1nCXXR0ev/f9H31Bs=
X-Received: by 2002:a63:444f:0:b0:39d:3aa5:c9f0 with SMTP id
 t15-20020a63444f000000b0039d3aa5c9f0mr23334443pgk.363.1650532547601; Thu, 21
 Apr 2022 02:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info>
 <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com> <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info>
 <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com> <0a33735c-dd43-4305-ff92-7b9ac2c6a0d9@leemhuis.info>
 <539ff0c5-a95b-836d-e1c6-39f64ee2a418@leemhuis.info> <056621a6-b6ac-90d9-c409-ba5d9404c868@amd.com>
 <-IeN6GQXuvFeZGmf-HSltWI3MN3V02oQzXAW0XR74vD62w_Fo_A6lSfJXrDgV2MTrHs9Id2Ce_r9J_zZCKx67DnVAWeFg3-ULIZ2GSm_ITQ=@protonmail.com>
 <xZsLVmWExSSYgHXHsfOKkB7SbLy-bltitpJznKV1HHsv2-_ZcSFArnir30v-7Eg8zqmGSMmZi3Cr7YHpB8tD_FVnBvf2W-VsmmFGdc7hlWw=@protonmail.com>
 <nqBA6pARHM6h_5hMj32zIxq_lgo2z8mmj7FPM5bXBv5DhWmh4K5Qv3MbKfAAi0tXlRy2IFYtfgyk2i_GPLIH5xsJ1hKBaLstHiNI1IEdUVc=@protonmail.com>
In-Reply-To: <nqBA6pARHM6h_5hMj32zIxq_lgo2z8mmj7FPM5bXBv5DhWmh4K5Qv3MbKfAAi0tXlRy2IFYtfgyk2i_GPLIH5xsJ1hKBaLstHiNI1IEdUVc=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 21 Apr 2022 11:15:36 +0200
Message-ID: <CAO-hwJL80Oz071zGj93MkZ4vn+ewdgExZhOBM5TyhTEvvhcqOg@mail.gmail.com>
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression
 on amd_sfh on kernel 5.17
To:     Marco <rodomar705@protonmail.com>
Cc:     regressions@leemhuis.info, Basavaraj.Natikar@amd.com,
        bnatikar@amd.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        jkosina@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri, it seems you are pushing patches to the tree (or at least were),
I would suggest reverting b300667b33b2 because there is obviously a
regression, and we'll let Basavaraj figure out a better solution in a
future release.

Cheers,
Benjamin

On Sun, Apr 17, 2022 at 7:16 PM Marco <rodomar705@protonmail.com> wrote:
>
> Any updates to this issue? The latest kernel 5.17.3 is still problematic =
for me.
>
> Inviato con l'email sicura di ProtonMail.
> ------- Original Message -------
> Il luned=C3=AC 4 aprile 2022 19:40, Marco <rodomar705@protonmail.com> ha =
scritto:
>
>
> > I've added the three test cases (dmesg + sudo monitor-sensor on all thr=
ee tests) on the bug report on bugzilla.kernel.org. One is with the stock k=
ernel from arch, 5.17.1. The other two is using zen patches on top of 5.17.=
 One is without the three reverts above mentioned. Sensor is missing still.=
 Then my same custom configuration only with the three reverts applied. The=
 sensor is back and working.
> >
> > If you need anything more, just let me know.
> >
> > Link to bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D215744
> >
> > Marco.
> >
> > Inviato con l'email sicura di ProtonMail.
> > ------- Original Message -------
> > Il luned=C3=AC 4 aprile 2022 16:26, Marco rodomar705@protonmail.com ha =
scritto:
> >
> >
> >
> > > I haven't tested this on the tip of the git tree, I can do this proba=
bly wednesday if it is needed.
> > >
> > > I'll post the output from sensors-detect shortly.
> > >
> > > Marco.
> > >
> > > Inviato da ProtonMail mobile
> > >
> > > -------- Messaggio originale --------
> > > On 4 apr 2022, 16:04, Basavaraj Natikar < bnatikar@amd.com> ha scritt=
o:
> > >
> > > > > On 4/4/2022 7:23 PM, Thorsten Leemhuis wrote:
> > > > >
> > > > > > On 04.04.22 09:25, Thorsten Leemhuis wrote:
> > > > > >
> > > > > > > On 04.04.22 09:18, Basavaraj Natikar wrote:
> > > > > > >
> > > > > > > > On 4/4/2022 12:05 PM, Thorsten Leemhuis wrote:
> > > > > > > >
> > > > > > > > > On 01.04.22 21:47, Basavaraj Natikar wrote:
> > > > > > > > >
> > > > > > > > > > Committed patch is disabling the interrupt mode and doe=
s not cause any
> > > > > > > > > > functionality or working issues.
> > > > > > > > > > Well, for the reporter it clearly does cause problems, =
unless something
> > > > > > > > > > in testing went sideways.
> > > > > > > > >
> > > > > > > > > > I also cross verified on 3 system and working fine on 5=
.17 and not able
> > > > > > > > > > to reproduce or recreate.
> > > > > > > > > > [...]
> > > > > > > > > > ------------------------------------------------
> > > > > > > > > >
> > > > > > > > > > Looks like this is not regression. May be some hardware=
/firmware bug.
> > > > > > > > > > Well, from the point of the kernel development process =
it afaics is a
> > > > > > > > > > regression, unless the testing went sideways. It doesn'=
t matter if the
> > > > > > > > > > root cause is in fact a hardware/firmware bug, as what =
matters in the
> > > > > > > > > > scope of the kernel development is: things worked, and =
now they don't.
> > > > > > > > > > For details please check this file and read the quotes =
from Linus:
> > > > > > > > > > can you help to answer the below questions:
> > > > > > > > > > Me? No, I'm just the Linux kernels regression tracker t=
rying to make
> > > > > > > > > > sure all regressions are handled appropriately. :-D
> > > > > > >
> > > > > > > Marco, can you help out here?
> > > > > > > Marco replied in private and allowed me to forward his reply:
> > > > > >
> > > > > > ```
> > > > > > I can't since, as mentioned previously, this is the only AMD la=
ptop
> > > > > > device that I have.
> > > > > > I am sure this is a regression for me, even if the issue is fir=
mware
> > > > > > related. I have tested the 5.17 stock arch kernel and the senso=
r is
> > > > > > gone. With the last three patches reverted the sensor is back a=
nd
> > > > > > working fine.
> > > > > >
> > > > > > I would love to verify if the issue is hardware or software rel=
ated, but
> > > > > > being outside of AMD and with AMD not releasing any public info=
rmation
> > > > > > with datasheet/specification on their Sensor Fusion Hub I reall=
y can't
> > > > > > say anything specific.
> > > > > >
> > > > > > This still remains a regression, since the hardware was working=
 before
> > > > > > and now it doesn't.
> > > > > >
> > > > > > By the way, I already have seen also this rework of this specif=
ic driver
> > > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fgithub.com%2Fconqp%2Famd-sfh-hid-dkms&data=3D04|01|Basavaraj.Natikar%4=
0amd.com|05891d0582f94d68e7f908da164272ca|3dd8961fe4884e608e11a82d994e183d|=
0|0|637846771908092322|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&sdata=3DnAmJdcP2ALl9cEaejWezLb9B3bU=
5Omp72Z6kjTbaBRY%3D&reserved=3D0 that even added a still
> > > > > > missing handler for the lid sensor switch for disabling touchpa=
d and
> > > > > > keyboard, and all efforts tried to merge it upstream with all s=
orts of
> > > > > > issues.
> > > > > >
> > > > > > Regardless of everything, this is a driver supported in kernel =
by AMD
> > > > > > engineers, so all of this doesn't matter. On my hardware this t=
hree
> > > > > > patches break a previously working hardware.
> > > > > > ```
> > > > >
> > > > > Thank You Marco for the information.
> > > > >
> > > > > Could you please provide me below results for acceleration
> > > > > by re-applying and reverting patch once again on same laptop.
> > > > >
> > > > > Did you attempt to test it multiple times on the tip of the git t=
o see
> > > > > if the problems goes away?
> > > > >
> > > > > if same test is performed multiple times with or without revertin=
g patch
> > > > > on same laptop on which issue is observed
> > > > > we may see same working/issue behavior. if it is regressing then =
always
> > > > > it should work with or without reverting patches on same laptop. =
is this
> > > > > the case here?
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Basavaraj
> > > > >
> > > > > > Ciao, Thorsten
> > > > > >
> > > > > > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tr=
acker' hat)
> > > > > > >
> > > > > > > P.S.: As the Linux kernel's regression tracker I'm getting a =
lot of
> > > > > > > reports on my table. I can only look briefly into most of the=
m and lack
> > > > > > > knowledge about most of the areas they concern. I thus unfort=
unately
> > > > > > > will sometimes get things wrong or miss something important. =
I hope
> > > > > > > that's not the case here; if you think it is, don't hesitate =
to tell me
> > > > > > > in a public reply, it's in everyone's interest to set the pub=
lic record
> > > > > > > straight.
> > > > > > >
> > > > > > > > Did you attempt to test it multiple times on the tip of the=
 git to see
> > > > > > > > if the problems goes away?
> > > > > > > >
> > > > > > > > if same test is performed multiple times with or without re=
verting patch
> > > > > > > > on same platform (laptop/hardware/firmware) on which issue =
is observed
> > > > > > > > we may see same working/issue behavior. if it is regressing=
 then always
> > > > > > > > it should work with or without reverting patches on same la=
ptop. is this
> > > > > > > > the case here?
> > > > > > > >
> > > > > > > > I don't see any regression here. I requested to retest with=
 other
> > > > > > > > hardware/platform/system also as per my above test (output)=
 all working
> > > > > > > > fine in 3 different platforms and not able to reproduce or =
recreate for
> > > > > > > > my side on 5.17.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Basavaraj
> > > > > > > >
> > > > > > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux=
-next.git%2Fplain%2FDocumentation%2Fprocess%2Fhandling-regressions.rst&data=
=3D04|01|Basavaraj.Natikar%40amd.com|05891d0582f94d68e7f908da164272ca|3dd89=
61fe4884e608e11a82d994e183d|0|0|637846771908092322|Unknown|TWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&sdata=
=3D9ORA2inmfocvEJ%2FXOov67q2ebzZrcuguViSPV%2B58yA0%3D&reserved=3D0
> > > > > > > > >
> > > > > > > > > Ciao, Thorsten
> > > > > > > > >
> > > > > > > > > > Just curious reverting this patch how it is working jus=
t suspecting
> > > > > > > > > > firmware undefined behavior.
> > > > > > > > > >
> > > > > > > > > > If possible, please check on other platform/system also=
 if same behavior
> > > > > > > > > > occurs.
> > > > > > > > > >
> > > > > > > > > > Could you please provide me platform/system details so =
that I can check
> > > > > > > > > > this behavior?
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Basavaraj
> > > > > > > > > >
> > > > > > > > > > On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
> > > > > > > > > >
> > > > > > > > > > > Hi, this is your Linux kernel regression tracker.
> > > > > > > > > > >
> > > > > > > > > > > I noticed a regression report in bugzilla.kernel.org =
that afaics nobody
> > > > > > > > > > > acted upon since it was reported about a week ago, th=
at's why I decided
> > > > > > > > > > > to forward it to the lists and all people that seemed=
 to be relevant
> > > > > > > > > > > here. It looks to me like this is something for Basav=
araj, as it seems
> > > > > > > > > > > to be caused by b300667b33b2 ("HID: amd_sfh: Disable =
the interrupt for
> > > > > > > > > > > all command"). But I'm not totally sure, I only looke=
d briefly into the
> > > > > > > > > > > details. Or was this discussed somewhere else already=
? Or even fixed?
> > > > > > > > > > >
> > > > > > > > > > > To quote from https://nam11.safelinks.protection.outl=
ook.com/?url=3Dhttps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D2157=
44&data=3D04|01|Basavaraj.Natikar%40amd.com|05891d0582f94d68e7f908da164272c=
a|3dd8961fe4884e608e11a82d994e183d|0|0|637846771908092322|Unknown|TWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&=
sdata=3DpLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw%3D&reserved=3D0 :
> > > > > > > > > > >
> > > > > > > > > > > > Marco 2022-03-25 15:22:19 UTC
> > > > > > > > > > > >
> > > > > > > > > > > > After updating to 5.17, the input from the accelero=
meter disappeared, completely. No devices available from IIO tree. First ba=
d commit causing it is https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorval=
ds%2Flinux.git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid=
%3Db300667b33b2b5a2c8e5f8f22826befb3d7f4f2b&data=3D04|01|Basavaraj.Natikar%=
40amd.com|05891d0582f94d68e7f908da164272ca|3dd8961fe4884e608e11a82d994e183d=
|0|0|637846771908092322|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000&sdata=3DL36JFc%2BnejM4bJXfNui49v2u=
JKrS4cJnU93dpEhXPms%3D&reserved=3D0. Reverting this and the the other two o=
n top fixed this. Tried to not revert only the above mentioned commit, but =
it's still not working.
> > > > > > > > > > > >
> > > > > > > > > > > > Marco.
> > > > > > > > > > > > Anyway, to get this tracked:
> > > > > > > > > > >
> > > > > > > > > > > #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb=
3d7f4
> > > > > > > > > > > #regzbot from: Marco rodomar705@protonmail.com
> > > > > > > > > > > #regzbot title: input: hid: input from the accelerome=
ter disappeared due
> > > > > > > > > > > to changes to amd_sfh
> > > > > > > > > > > #regzbot link: https://nam11.safelinks.protection.out=
look.com/?url=3Dhttps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215=
744&data=3D04|01|Basavaraj.Natikar%40amd.com|05891d0582f94d68e7f908da164272=
ca|3dd8961fe4884e608e11a82d994e183d|0|0|637846771908092322|Unknown|TWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D|3000=
&sdata=3DpLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw%3D&reserved=3D0
> > > > > > > > > > >
> > > > > > > > > > > Ciao, Thorsten (wearing his 'the Linux kernel's regre=
ssion tracker' hat)
> > > > > > > > > > >
> > > > > > > > > > > P.S.: As the Linux kernel's regression tracker I'm ge=
tting a lot of
> > > > > > > > > > > reports on my table. I can only look briefly into mos=
t of them and lack
> > > > > > > > > > > knowledge about most of the areas they concern. I thu=
s unfortunately
> > > > > > > > > > > will sometimes get things wrong or miss something imp=
ortant. I hope
> > > > > > > > > > > that's not the case here; if you think it is, don't h=
esitate to tell me
> > > > > > > > > > > in a public reply, it's in everyone's interest to set=
 the public record
> > > > > > > > > > > straight.
>

