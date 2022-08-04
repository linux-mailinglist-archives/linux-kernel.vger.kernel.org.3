Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387F1589976
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiHDIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHDIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:45:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9471E7;
        Thu,  4 Aug 2022 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659602742;
        bh=zBHeLt3swzlhQhq8Mg+oecUGN1GpWSW7/ADB/NwqugE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=CpTM/L9+EiQjofNeKED27cW/pamOhQHaWJ9kPCuJeGNRydk0SMqBL12zLE5U7scY2
         ChiR3HgHcbzURgwYXlywvO9tNjrPyVfZ3hMk6FXlDhAEyjqgynuBMJYoxJz2+1Oxqs
         G67677hbWeXBbnsz7/tZ/dA52064VRTU6wi2QNN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.176.33]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1oEcel3x1W-00DpdQ; Thu, 04
 Aug 2022 10:45:42 +0200
Message-ID: <0fbc2150-b4aa-f2cb-5084-3a9f69b3455d@gmx.de>
Date:   Thu, 4 Aug 2022 10:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: vt: selection: Add check for valid tiocl_selection
 values
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000bbdd0405d120c155@google.com>
 <20220729065139.6529-1-khalid.masum.92@gmail.com>
 <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de> <YuV9PybMPgc83Jis@p100>
 <1eb62346-304b-54d5-8a62-8a35888d51bd@kernel.org>
 <35e860bb-c76c-ca5f-3f48-2bf6cb798689@gmx.de>
In-Reply-To: <35e860bb-c76c-ca5f-3f48-2bf6cb798689@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fvnbUjIfRjo7BJSx+mfDA4vZyG8NWXczmkia6v3VEBCbAyao9hd
 exfzNMaGvcGQxH4Wvi0pQPqDGVjRjsbygiweWzqqKN84vnc01cUaFT500sLFmneopmj6TuN
 7D8EJ8pXwbhM7DmAcvWEYyuPh8lKGaxGucyqyJFgRu34oMBEb142RvDrcK9gdV236pr3wtT
 Oy5TtUfMy3fcCyOUFruuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yOyWATsJFEw=:5/aYH5v3o7Xf+v2pqkfDUK
 reV/GHEIayBJfoEzdblpgI9tivDovDbUtiadXbrco1O1Kz/139sfsYQ0v7CvR3uzJp9KLYDwR
 HUy9n1zYPpW92BNmMt4mGO64m+SNpC6k2xcrQbAl2p5exmUCgv2eDZfXtukUFmM+A+s+9eTIu
 fbTTBaE+RPM4bPa4tMbNhMFuJoEGAc7jSz71EUcLdnwqnZPhmD7G3rsvvV241xFytVD74Ty3E
 DN36Oqb8zFSsDDuDzzrFynP9ZkH9htFN8iZtWXV1Ecwarp06/GJ1hFwvyNU+eZJn9wJ9/xYc1
 Vz/Ll7S7kfQ2eeR3kcoitXlP/MIv1Av93Kgs1HtcLMS1xSz78IMy3hN6YqPGEB7TlaroAwUZG
 y5kVhKzUGPqeszSaqofYC/PzSRHw2iK3V6qVK/VvqE00bFveRyxB1zS+dJ0BvQJejXPNnj4ad
 cgz6VWmb/Fd5NMRDtzGM/aao8Dd6CI2jlwp7jnO4IevakW7ptE4FfazIc6q19UIolnrfbp8iS
 gVJVJy2UDEssqoqTP4SRJkL8yGAYfFKJQjtILiwX2hZ3KY0ByVOniP0SYkQOpjdE+ziCgUgqS
 jX7qKet8R6eQ+eeg+YlPeSteXvgcwVUY2nTw1aluOUEEOPX/SNX8nzkOfu/19NOk7Xa4akCBJ
 wyy2rO8r28wZmTUdJNbgwdhJB7cjj0DXgD7oM4Yl3neecSqDqf33kEas6KlrehHj4wqS/1nC9
 UlbKQ0qZ/Gu4bwXXDZRhZAt+IBh33/hIFUzUOSeOV6r1CPxUykUDa+pUpA6ednhIhbU6njKyN
 mL5FPM5oSG1euYGSbNvhs8aAOeFPBzteq/Ga48v6SNffpjl7uFIaM6nc2ZYAVSTqkpO885DS0
 4aj/gQ4TV+8y+WCkmOWfkRlFa1C2C1Ksy6kAi/iZkKUBApFP/7g8R3fIq3eWUWgw1yQghgEiA
 yp4/ctSMTC1V4CyUq5FSDXI39NTc47Oifz6kyw0yIaH4aQ3D1HKftyJgepHkvQDIjaMDcteUl
 JqmX9jvje5xHJOL+I8Q87bWPd7IFqWfnb4ETlQ5dNBl+VJBqYiGEzc+0amG0leXUMsi6KI9VY
 qwmRjvX9VRaDMvvEOmOmfJU4qF/5hyagZQAEzySWsild0wCtSTf7hWrsg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 09:15, Helge Deller wrote:
> Hello Jiri,
>
> Thanks for looking into this patch!
>
> On 8/4/22 07:47, Jiri Slaby wrote:
>> On 30. 07. 22, 20:49, Helge Deller wrote:
>>> The line and column numbers for the selection need to start at 1.
>>> Add the checks to prevent invalid input.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> Reported-by: syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
>>>
>>> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
>>> index f7755e73696e..58692a9b4097 100644
>>> --- a/drivers/tty/vt/selection.c
>>> +++ b/drivers/tty/vt/selection.c
>>> @@ -326,6 +326,9 @@ static int vc_selection(struct vc_data *vc, struct=
 tiocl_selection *v,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (!v->xs || !v->ys || !v->xe || !v->ye)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>
>> Hmm, I'm not sure about this. It potentially breaks userspace (by
>> returning EINVAL now).
>
> Right.
> According to the code below, my interpretation is that all xs/ys/xe/ye v=
alues
> should be > 0. But of course I might be wrong on this, as I didn't find =
any
> documentation for TIOCL_SETSEL.
>
> And if userspace tries to set an invalid selection (e.g. by selecting ro=
w 0),
> my patch now returns -EINVAL, while it returned success before.
>
>> And the code below should handle this just fine, right:
>>>       v->xs =3D min_t(u16, v->xs - 1, vc->vc_cols - 1);
>>>       v->ys =3D min_t(u16, v->ys - 1, vc->vc_rows - 1);
>>>       v->xe =3D min_t(u16, v->xe - 1, vc->vc_cols - 1);
>
> It "handles it fine" in the sense that it can cope with the
> input and will not crash.
> But it returns (maybe?) unexpected results...

After some more thinking maybe you are right.
In case a user provided invalid values in the past, simply an unexpected
selection was set, but nothing broke.
Since the patch doesn't fix any critical issue, we could just drop this pa=
tch
and leave it as is.

Helge
