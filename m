Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912853933A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiEaOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiEaOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA3727C14B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654007994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyyotCGPOPufc7b62v1p4WrQMCcz9qeHy9xiBKChoLw=;
        b=iE5LAnY6r+pxfw8t1BLedhZokwmww2aboqTR6lCtljxz7ZEZIIcy4Mhh1EQfJpnyCCbz4M
        SLo6WsjbVUckRhLamo6KOHuuoiQapYLfScOsf2dNunlSrzzSPoMfwUSmuCnfUNOMwJvtMa
        7r7kdlZKclQS2fktYjZ7omBxYPee3LA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-TQG_21VzMuyjeu0bz1z9YA-1; Tue, 31 May 2022 10:39:50 -0400
X-MC-Unique: TQG_21VzMuyjeu0bz1z9YA-1
Received: by mail-ej1-f71.google.com with SMTP id n2-20020a170906724200b006fed87ccbb8so5393035ejk.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyyotCGPOPufc7b62v1p4WrQMCcz9qeHy9xiBKChoLw=;
        b=czmiI6bi++zfRwRRd8ax7rWQxekjXRQr0jPu2TDH5KA3i6CvkBNutgwGJfunHBbQ8e
         dUYLsk/ecNMl8mFIbb1YtIu34Hu8Jj180ooCA9cXw+XPhSpjgh7XZj+BjrbyK3jVWRBf
         PytJBtVTFDy8+gt2zHD0cZfSqrnnUFczGYZcyPgN+qI8yHTq0kRK57AwRRnv5d837w2C
         /n4ddWCSPkaPrkWDPzyWfPqF76+D/H+BwzhE2F9x4Kgz4D+RhE2BEFiojd9NnN7yFj/T
         IfzIgQHC+jn80V0uHdWcQPWlx64vrPoOUwj2/kDRkYXRvzfw4A9Sn26n3+aFr4CubTZH
         wqww==
X-Gm-Message-State: AOAM532c2IOO5YZ69bO1wMs3N/WJ9PO1HAABkJRPT9wNYCm+nyu+74ER
        0FuzG/FgSotPt5cWJfD6UCSeYgohiToXBHNODSLXzUPR8BQ0cEZZVJgKdAbrhBxqgOv7yGo35h2
        Rca6vJ0XgMRg0bV4Tu9wEN/Bp
X-Received: by 2002:a17:907:6d90:b0:6fe:bac0:5ba with SMTP id sb16-20020a1709076d9000b006febac005bamr43966673ejc.29.1654007989373;
        Tue, 31 May 2022 07:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQDrDBiA3s6l8mWVCk+nY0o3NUZCkK3puLNgAUpCAh2/CrhR6F1EztRHJcLenhUZgh9SvF5g==
X-Received: by 2002:a17:907:6d90:b0:6fe:bac0:5ba with SMTP id sb16-20020a1709076d9000b006febac005bamr43966652ejc.29.1654007989103;
        Tue, 31 May 2022 07:39:49 -0700 (PDT)
Received: from [10.39.193.22] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b006f3ef214e27sm5000566eju.141.2022.05.31.07.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 May 2022 07:39:48 -0700 (PDT)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Vlad Buslov <vladbu@nvidia.com>,
        Toms Atteka <cpp.code.lv@gmail.com>
Cc:     Roi Dayan <roid@nvidia.com>, Ilya Maximets <i.maximets@ovn.org>,
        Aaron Conole <aconole@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pravin B Shelar <pshelar@ovn.org>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Maor Dickman <maord@nvidia.com>
Subject: Re: [PATCH net-next v2] net: openvswitch: fix uAPI incompatibility
 with existing user space
Date:   Tue, 31 May 2022 16:39:47 +0200
X-Mailer: MailMate (1.14r5895)
Message-ID: <0DEFEF9E-96A0-4B65-A6A3-611EBAC97F6A@redhat.com>
In-Reply-To: <CD6F1EAA-7A32-46D2-9806-98CDB98DC537@redhat.com>
References: <20220309222033.3018976-1-i.maximets@ovn.org>
 <f7ty21hir5v.fsf@redhat.com>
 <44eeb550-3310-d579-91cc-ec18b59966d2@nvidia.com>
 <1a185332-3693-2750-fef2-f6938bbc8500@ovn.org> <87k0c171ml.fsf@nvidia.com>
 <9cc34fbc-3fd6-b529-7a05-554224510452@ovn.org>
 <4778B505-DBF5-4F57-90AF-87F12C1E0311@redhat.com> <87lev783k8.fsf@nvidia.com>
 <FFBEB52B-FA8C-4989-BDC1-1F3908F024B8@redhat.com>
 <CD6F1EAA-7A32-46D2-9806-98CDB98DC537@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 May 2022, at 14:54, Eelco Chaudron wrote:

> On 17 May 2022, at 13:10, Eelco Chaudron wrote:
>
>> On 12 May 2022, at 12:08, Vlad Buslov wrote:
>>
>>> On Thu 12 May 2022 at 12:19, Eelco Chaudron <echaudro@redhat.com> wro=
te:
>>>> On 7 Apr 2022, at 12:22, Ilya Maximets wrote:
>>>>
>>>>> On 4/7/22 10:02, Vlad Buslov wrote:
>>>>>> On Mon 14 Mar 2022 at 20:40, Ilya Maximets <i.maximets@ovn.org> wr=
ote:
>>>>>>> On 3/14/22 19:33, Roi Dayan wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2022-03-10 8:44 PM, Aaron Conole wrote:
>>>>>>>>> Ilya Maximets <i.maximets@ovn.org> writes:
>>>>>>>>>
>>>>>>>>>> Few years ago OVS user space made a strange choice in the comm=
it [1]
>>>>>>>>>> to define types only valid for the user space inside the copy =
of a
>>>>>>>>>> kernel uAPI header.=C2=A0 '#ifndef __KERNEL__' and another att=
ribute was
>>>>>>>>>> added later.
>>>>>>>>>>
>>>>>>>>>> This leads to the inevitable clash between user space and kern=
el types
>>>>>>>>>> when the kernel uAPI is extended.=C2=A0 The issue was unveiled=
 with the
>>>>>>>>>> addition of a new type for IPv6 extension header in kernel uAP=
I.
>>>>>>>>>>
>>>>>>>>>> When kernel provides the OVS_KEY_ATTR_IPV6_EXTHDRS attribute t=
o the
>>>>>>>>>> older user space application, application tries to parse it as=

>>>>>>>>>> OVS_KEY_ATTR_PACKET_TYPE and discards the whole netlink messag=
e as
>>>>>>>>>> malformed.=C2=A0 Since OVS_KEY_ATTR_IPV6_EXTHDRS is supplied a=
long with
>>>>>>>>>> every IPv6 packet that goes to the user space, IPv6 support is=
 fully
>>>>>>>>>> broken.
>>>>>>>>>>
>>>>>>>>>> Fixing that by bringing these user space attributes to the ker=
nel
>>>>>>>>>> uAPI to avoid the clash.=C2=A0 Strictly speaking this is not t=
he problem
>>>>>>>>>> of the kernel uAPI, but changing it is the only way to avoid b=
reakage
>>>>>>>>>> of the older user space applications at this point.
>>>>>>>>>>
>>>>>>>>>> These 2 types are explicitly rejected now since they should no=
t be
>>>>>>>>>> passed to the kernel.=C2=A0 Additionally, OVS_KEY_ATTR_TUNNEL_=
INFO moved
>>>>>>>>>> out from the '#ifdef __KERNEL__' as there is no good reason to=
 hide
>>>>>>>>>> it from the userspace.=C2=A0 And it's also explicitly rejected=
 now, because
>>>>>>>>>> it's for in-kernel use only.
>>>>>>>>>>
>>>>>>>>>> Comments with warnings were added to avoid the problem coming =
back.
>>>>>>>>>>
>>>>>>>>>> (1 << type) converted to (1ULL << type) to avoid integer overf=
low on
>>>>>>>>>> OVS_KEY_ATTR_IPV6_EXTHDRS, since it equals 32 now.
>>>>>>>>>>
>>>>>>>>>> =C2=A0 [1] beb75a40fdc2 ("userspace: Switching of L3 packets i=
n L2 pipeline")
>>>>>>>>>>
>>>>>>>>>> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extensi=
on header support")
>>>>>>>>>> Link: https://lore.kernel.org/netdev/3adf00c7-fe65-3ef4-b6d7-6=
d8a0cad8a5f@nvidia.com
>>>>>>>>>> Link: https://github.com/openvswitch/ovs/commit/beb75a40fdc295=
bfd6521b0068b4cd12f6de507c
>>>>>>>>>> Reported-by: Roi Dayan <roid@nvidia.com>
>>>>>>>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Acked-by: Aaron Conole <aconole@redhat.com>
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> I got to check traffic with the fix and I do get some traffic
>>>>>>>> but something is broken. I didn't investigate much but the quick=

>>>>>>>> test shows me rules are not offloaded and dumping ovs rules give=
s
>>>>>>>> error like this
>>>>>>>>
>>>>>>>> recirc_id(0),in_port(enp8s0f0_1),ct_state(-trk),eth(),eth_type(0=
x86dd),ipv6(frag=3Dno)(bad
>>>>>>>> key length 2, expected -1)(00 00/(bad mask length 2, expected -1=
)(00 00),
>>>>>>>> packets:2453, bytes:211594, used:0.004s, flags:S., actions:ct,re=
circ(0x2)
>>>>>>>
>>>>>>> Such a dump is expected, because kernel parses fields that curren=
t
>>>>>>> userspace doesn't understand, and at the same time OVS by design =
is
>>>>>>> using kernel provided key/mask while installing datapath rules, I=
IRC.
>>>>>>> It should be possible to make these dumps a bit more friendly tho=
ugh.
>>>>>>>
>>>>>>> For the offloading not working, see my comment in the v2 patch em=
ail
>>>>>>> I sent (top email of this thread).  In short, it's a problem in u=
ser
>>>>>>> space and it can not be fixed from the kernel side, unless we rev=
ert
>>>>>>> IPv6 extension header support and never add any new types, which =
is
>>>>>>> unreasonable.  I didn't test any actual offloading, but I had a
>>>>>>> successful run of 'make check-offloads' with my quick'n'dirty fix=
 from
>>>>>>> the top email.
>>>>>>
>>>>>> Hi Ilya,
>>>>>>
>>>>>> I can confirm that with latest OvS master IPv6 rules offload still=
 fails
>>>>>> without your pastebin code applied.
>>>>>>
>>>>>>>
>>>>>>> Since we're here:
>>>>>>>
>>>>>>> Toms, do you plan to submit user space patches for this feature?
>>>>>>
>>>>>> I see there is a patch from you that is supposed to fix compatibil=
ity
>>>>>> issues caused by this change in OvS d96d14b14733 ("openvswitch.h: =
Align
>>>>>> uAPI definition with the kernel."), but it doesn't fix offload for=
 me
>>>>>> without pastebin patch.
>>>>>
>>>>> Yes.  OVS commit d96d14b14733 is intended to only fix the uAPI.
>>>>> Issue with offload is an OVS bug that should be fixed separately.
>>>>> The fix will also need to be backported to OVS stable branches.
>>>>>
>>>>>> Do you plan to merge that code into OvS or you
>>>>>> require some help from our side?
>>>>>
>>>>> I could do that, but I don't really have enough time.  So, if you
>>>>> can work on that fix, it would be great.  Note that comments inside=

>>>>> the OVS's lib/odp-util.c:parse_key_and_mask_to_match() was blindly
>>>>> copied from the userspace datapath and are incorrect for the genera=
l
>>>>> case, so has to be fixed alongside the logic of that function.
>>>>
>>>> Tom or Vlad, are you working on this? Asking, as the release of a ke=
rnel with
>>>> Tom=E2=80=99s =E2=80=9Cnet: openvswitch: IPv6: Add IPv6 extension he=
ader support=E2=80=9D patch will
>>>> break OVS.
>>>>
>>>> //Eelco
>>>
>>> Hi Eelco,
>>>
>>> My simple fix for OvS was rejected and I don't have time to rework it=
 at
>>> the moment.
>>
>> That=E2=80=99s a pity, Tom do you maybe have time as your patch left O=
VS in this error state?
>
> Looks like everybody is busy, and as the patched kernel is now availabl=
e, let me try to fix this on the OVS side.

I posted a patch on the OVS mailing list, please review/verify.

https://patchwork.ozlabs.org/project/openvswitch/patch/165400753240.20546=
05.12815593709246812392.stgit@ebuild/

//Eelco

