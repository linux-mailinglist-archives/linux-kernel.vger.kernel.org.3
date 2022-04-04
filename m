Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAD4F1EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381509AbiDDVuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379589AbiDDRmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:42:08 -0400
X-Greylist: delayed 11588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 10:40:11 PDT
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106B31DE3;
        Mon,  4 Apr 2022 10:40:11 -0700 (PDT)
Date:   Mon, 04 Apr 2022 17:40:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649094008;
        bh=Abj/f7lL3h7XnhObd7VBg4DhV/bWNl/cvotUhP1u5T8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=3zwPnEvMbMsRufQ4rkq/plkvyH4UTTC+wCAjxwm1qROB63BFurVZOSl9DjEddPlH1
         ML0RCDqePpTF7NnbABDwUsqFtHbWRNhTmX6x56uG71l24aYpVFnr0KpdnhMvK2OQZ3
         vfaJcfMHXqIVz4yAZyE8N4zzzgPwjYLOwrb2DiqWzSl7zUMpwTNqCxC51yMHMsZY8V
         MXOAdrV1mn8S+/xZFcjV/oq3fiS85tNkHDPQFazOT/Fzil9BXweVNqRZjpFuNt+Xxq
         gXV6wir5MiuHIj1uf59qZQxDz9Vr/htCYnaygN3gfzyGntVIMQEbR2z3LEYKmof2FW
         c4L5ElgyA954w==
To:     regressions@leemhuis.info, Basavaraj.Natikar@amd.com,
        bnatikar@amd.com
From:   Marco <rodomar705@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, jkosina@suse.cz,
        benjamin.tissoires@redhat.com
Reply-To: Marco <rodomar705@protonmail.com>
Subject: Re: Bug 215744 - input from the accelerometer disappeared, regression on amd_sfh on kernel 5.17
Message-ID: <xZsLVmWExSSYgHXHsfOKkB7SbLy-bltitpJznKV1HHsv2-_ZcSFArnir30v-7Eg8zqmGSMmZi3Cr7YHpB8tD_FVnBvf2W-VsmmFGdc7hlWw=@protonmail.com>
In-Reply-To: <-IeN6GQXuvFeZGmf-HSltWI3MN3V02oQzXAW0XR74vD62w_Fo_A6lSfJXrDgV2MTrHs9Id2Ce_r9J_zZCKx67DnVAWeFg3-ULIZ2GSm_ITQ=@protonmail.com>
References: <048ef583-4a8f-96b0-68a3-45ab9ec8d6df@leemhuis.info> <0499f8ae-6966-be4b-5af8-e7e568bfcd5f@amd.com> <6fe27103-5e35-5f16-d213-29bd71412f5b@leemhuis.info> <7dfb121f-848c-873e-f3cc-43239c264f21@amd.com> <0a33735c-dd43-4305-ff92-7b9ac2c6a0d9@leemhuis.info> <539ff0c5-a95b-836d-e1c6-39f64ee2a418@leemhuis.info> <056621a6-b6ac-90d9-c409-ba5d9404c868@amd.com> <-IeN6GQXuvFeZGmf-HSltWI3MN3V02oQzXAW0XR74vD62w_Fo_A6lSfJXrDgV2MTrHs9Id2Ce_r9J_zZCKx67DnVAWeFg3-ULIZ2GSm_ITQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've added the three test cases (dmesg + sudo monitor-sensor on all three t=
ests) on the bug report on bugzilla.kernel.org. One is with the stock kerne=
l from arch, 5.17.1. The other two is using zen patches on top of 5.17. One=
 is without the three reverts above mentioned. Sensor is missing still. The=
n my same custom configuration only with the three reverts applied. The sen=
sor is back and working.

If you need anything more, just let me know.

Link to bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D215744

Marco.

Inviato con l'email sicura di ProtonMail.
------- Original Message -------
Il luned=C3=AC 4 aprile 2022 16:26, Marco <rodomar705@protonmail.com> ha sc=
ritto:


> I haven't tested this on the tip of the git tree, I can do this probably =
wednesday if it is needed.
>
> I'll post the output from sensors-detect shortly.
>
> Marco.
>
>
> Inviato da ProtonMail mobile
>
>
>
> -------- Messaggio originale --------
> On 4 apr 2022, 16:04, Basavaraj Natikar < bnatikar@amd.com> ha scritto:
>
> >
> >
> > >
> > >
> > > On 4/4/2022 7:23 PM, Thorsten Leemhuis wrote:
> > > > On 04.04.22 09:25, Thorsten Leemhuis wrote:
> > > >> On 04.04.22 09:18, Basavaraj Natikar wrote:
> > > >>>
> > > >>> On 4/4/2022 12:05 PM, Thorsten Leemhuis wrote:
> > > >>>> On 01.04.22 21:47, Basavaraj Natikar wrote:
> > > >>>>> Committed patch is disabling the interrupt mode and does not ca=
use any
> > > >>>>> functionality or working issues.
> > > >>>> Well, for the reporter it clearly does cause problems, unless so=
mething
> > > >>>> in testing went sideways.
> > > >>>>
> > > >>>>> I also cross verified on 3 system and working fine on 5.17 and =
not able
> > > >>>>> to reproduce or recreate.
> > > >>>>> [...]
> > > >>>>> ------------------------------------------------
> > > >>>>>
> > > >>>>> Looks like this is not regression. May be some hardware/firmwar=
e bug.
> > > >>>> Well, from the point of the kernel development process it afaics=
 is a
> > > >>>> regression, unless the testing went sideways. It doesn't matter =
if the
> > > >>>> root cause is in fact a hardware/firmware bug, as what matters i=
n the
> > > >>>> scope of the kernel development is: things worked, and now they =
don't.
> > > >>>> For details please check this file and read the quotes from Linu=
s:
> > > >>> can you help to answer the below questions:
> > > >> Me? No, I'm just the Linux kernels regression tracker trying to ma=
ke
> > > >> sure all regressions are handled appropriately. :-D
> > > >>
> > > >> Marco, can you help out here?
> > > > Marco replied in private and allowed me to forward his reply:
> > > >
> > > > ```
> > > > I can't since, as mentioned previously, this is the only AMD laptop
> > > > device that I have.
> > > > I am sure this is a regression for me, even if the issue is firmwar=
e
> > > > related. I have tested the 5.17 stock arch kernel and the sensor is
> > > > gone. With the last three patches reverted the sensor is back and
> > > > working fine.
> > > >
> > > > I would love to verify if the issue is hardware or software related=
, but
> > > > being outside of AMD and with AMD not releasing any public informat=
ion
> > > > with datasheet/specification on their Sensor Fusion Hub I really ca=
n't
> > > > say anything specific.
> > > >
> > > > This still remains a regression, since the hardware was working bef=
ore
> > > > and now it doesn't.
> > > >
> > > > By the way, I already have seen also this rework of this specific d=
river
> > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2Fconqp%2Famd-sfh-hid-dkms&amp;data=3D04%7C01%7CBasavaraj.Natik=
ar%40amd.com%7C05891d0582f94d68e7f908da164272ca%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637846771908092322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DnAm=
JdcP2ALl9cEaejWezLb9B3bU5Omp72Z6kjTbaBRY%3D&amp;reserved=3D0 that even adde=
d a still
> > > > missing handler for the lid sensor switch for disabling touchpad an=
d
> > > > keyboard, and all efforts tried to merge it upstream with all sorts=
 of
> > > > issues.
> > > >
> > > > Regardless of everything, this is a driver supported in kernel by A=
MD
> > > > engineers, so all of this doesn't matter. On my hardware this three
> > > > patches break a previously working hardware.
> > > > ```
> > >
> > > Thank=C2=A0You Marco for the information.
> > >
> > > Could you please provide me below results for acceleration
> > > by re-applying and reverting patch once again on same laptop.
> > >
> > > Did you attempt to test it multiple times on the tip of the git to se=
e
> > > if the problems goes away?
> > >
> > > if same test is performed multiple times with or without reverting pa=
tch
> > > on same laptop on which issue is observed
> > > we may see same working/issue behavior. if it is regressing then alwa=
ys
> > > it should work with or without reverting patches on same laptop. is t=
his
> > > the case here?
> > >
> > > Thanks,
> > >
> > > Basavaraj
> > >
> > > > Ciao, Thorsten
> > > >
> > > >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker=
' hat)
> > > >>
> > > >> P.S.: As the Linux kernel's regression tracker I'm getting a lot o=
f
> > > >> reports on my table. I can only look briefly into most of them and=
 lack
> > > >> knowledge about most of the areas they concern. I thus unfortunate=
ly
> > > >> will sometimes get things wrong or miss something important. I hop=
e
> > > >> that's not the case here; if you think it is, don't hesitate to te=
ll me
> > > >> in a public reply, it's in everyone's interest to set the public r=
ecord
> > > >> straight.
> > > >>
> > > >>> Did you attempt to test it multiple times on the tip of the git t=
o see
> > > >>> if the problems goes away?
> > > >>>
> > > >>> if same test is performed multiple times with or without revertin=
g patch
> > > >>> on same platform (laptop/hardware/firmware) on which issue is obs=
erved
> > > >>> we may see same working/issue behavior. if it is regressing then =
always
> > > >>> it should work with or without reverting patches on same laptop. =
is this
> > > >>> the case here?
> > > >>>
> > > >>> I don't see any regression here. I requested to retest with other
> > > >>> hardware/platform/system also as per my above test (output) all w=
orking
> > > >>> fine in 3 different platforms and not able to reproduce or recrea=
te for
> > > >>> my side on 5.17.
> > > >>>
> > > >>> Thanks,
> > > >>>
> > > >>> Basavaraj
> > > >>>
> > > >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.g=
it%2Fplain%2FDocumentation%2Fprocess%2Fhandling-regressions.rst&amp;data=3D=
04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da164272ca%7C=
3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C3000&amp;sdata=3D9ORA2inmfocvEJ%2FXOov67q2ebzZrcuguViSPV%2B58yA0%3D&am=
p;reserved=3D0
> > > >>>>
> > > >>>> Ciao, Thorsten
> > > >>>>
> > > >>>>> Just curious reverting this patch how it is working just suspec=
ting
> > > >>>>> firmware undefined behavior.
> > > >>>>>
> > > >>>>> If possible, please check on other platform/system also if same=
 behavior
> > > >>>>> occurs.
> > > >>>>>
> > > >>>>> Could you please provide me platform/system details so that I c=
an check
> > > >>>>> this behavior?
> > > >>>>>
> > > >>>>> Thanks,
> > > >>>>> Basavaraj
> > > >>>>>
> > > >>>>> On 4/1/2022 1:36 PM, Thorsten Leemhuis wrote:
> > > >>>>>> Hi, this is your Linux kernel regression tracker.
> > > >>>>>>
> > > >>>>>> I noticed a regression report in bugzilla.kernel.org that afai=
cs nobody
> > > >>>>>> acted upon since it was reported about a week ago, that's why =
I decided
> > > >>>>>> to forward it to the lists and all people that seemed to be re=
levant
> > > >>>>>> here. It looks to me like this is something for Basavaraj, as =
it seems
> > > >>>>>> to be caused by b300667b33b2 ("HID: amd_sfh: Disable the inter=
rupt for
> > > >>>>>> all command"). But I'm not totally sure, I only looked briefly=
 into the
> > > >>>>>> details. Or was this discussed somewhere else already? Or even=
 fixed?
> > > >>>>>>
> > > >>>>>> To quote from https://nam11.safelinks.protection.outlook.com/?=
url=3Dhttps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;da=
ta=3D04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da164272=
ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000&amp;sdata=3DpLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw%=
3D&amp;reserved=3D0 :
> > > >>>>>>
> > > >>>>>>> Marco 2022-03-25 15:22:19 UTC
> > > >>>>>>>
> > > >>>>>>> After updating to 5.17, the input from the accelerometer disa=
ppeared, completely. No devices available from IIO tree. First bad commit c=
ausing it is https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.=
git%2Fcommit%2Fdrivers%2Fhid%2Famd-sfh-hid%2Famd_sfh_pcie.c%3Fid%3Db300667b=
33b2b5a2c8e5f8f22826befb3d7f4f2b&amp;data=3D04%7C01%7CBasavaraj.Natikar%40a=
md.com%7C05891d0582f94d68e7f908da164272ca%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637846771908092322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DL36JFc%2B=
nejM4bJXfNui49v2uJKrS4cJnU93dpEhXPms%3D&amp;reserved=3D0. Reverting this an=
d the the other two on top fixed this. Tried to not revert only the above m=
entioned commit, but it's still not working.
> > > >>>>>>>
> > > >>>>>>> Marco.
> > > >>>>>> Anyway, to get this tracked:
> > > >>>>>>
> > > >>>>>> #regzbot introduced: b300667b33b2b5a2c8e5f8f22826befb3d7f4
> > > >>>>>> #regzbot from: Marco <rodomar705@protonmail.com>
> > > >>>>>> #regzbot title: input: hid: input from the accelerometer disap=
peared due
> > > >>>>>> to changes to amd_sfh
> > > >>>>>> #regzbot link: https://nam11.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215744&amp;d=
ata=3D04%7C01%7CBasavaraj.Natikar%40amd.com%7C05891d0582f94d68e7f908da16427=
2ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637846771908092322%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C3000&amp;sdata=3DpLGKHCV1ZNrXghGdDFG16sguRA8xi0VzUSG%2Fbw%2FQsBw=
%3D&amp;reserved=3D0
> > > >>>>>>
> > > >>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tra=
cker' hat)
> > > >>>>>>
> > > >>>>>> P.S.: As the Linux kernel's regression tracker I'm getting a l=
ot of
> > > >>>>>> reports on my table. I can only look briefly into most of them=
 and lack
> > > >>>>>> knowledge about most of the areas they concern. I thus unfortu=
nately
> > > >>>>>> will sometimes get things wrong or miss something important. I=
 hope
> > > >>>>>> that's not the case here; if you think it is, don't hesitate t=
o tell me
> > > >>>>>> in a public reply, it's in everyone's interest to set the publ=
ic record
> > > >>>>>> straight.
> > > >>>>>>
> > > >>>
> > > >>>
