Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64085995A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346938AbiHSHA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346817AbiHSHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:00:41 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A351BD296
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:00:33 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220819070028epoutp0193c187e01f2ff1ed2d8edc2b4c888d23~MrN0RWdIU1887018870epoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:00:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220819070028epoutp0193c187e01f2ff1ed2d8edc2b4c888d23~MrN0RWdIU1887018870epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660892428;
        bh=wSppfcu80Jat1P3mvcqiATRJLkc71gy/XgEBekoydYg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sPTAWW8f7SH5QsZvUNC61uEFeu2maaxrjY/22RXykOEIw81XTXw+KPb+/h61dTKCx
         dm3wM/DUoSVm9GRkxJYgIOaCS2Fr/swqzcxVvTAPXoO/gfwYclySfQYbZ/S3QcsNKh
         zXonbo6xqQgRkmSQghkSqkcCNkhs4FceSdbGwC0c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220819070027epcas5p14fc654a5e47ce4e043303cbbac216009~MrNz6UoHF1013110131epcas5p10;
        Fri, 19 Aug 2022 07:00:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4M8CLx0lXYz4x9Q1; Fri, 19 Aug
        2022 07:00:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.1E.09494.6053FF26; Fri, 19 Aug 2022 16:00:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220819043928epcas5p33942271e69c4e21dcbc506cce74fbbf4~MpStYb-Rn0547805478epcas5p3R;
        Fri, 19 Aug 2022 04:39:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220819043928epsmtrp1555f02093d2b9c4faaaa3f73211af9fe~MpStXnuob2633826338epsmtrp13;
        Fri, 19 Aug 2022 04:39:28 +0000 (GMT)
X-AuditID: b6c32a4a-201ff70000012516-35-62ff3506c782
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.4C.08802.0041FF26; Fri, 19 Aug 2022 13:39:28 +0900 (KST)
Received: from mshams02 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220819043927epsmtip13e2ba04fe94b991e2fe5faa9abda3172~MpSsSrgch1298112981epsmtip16;
        Fri, 19 Aug 2022 04:39:26 +0000 (GMT)
From:   "m.shams" <m.shams@samsung.com>
To:     =?iso-8859-1?Q?'Uwe_Kleine-K=F6nig'?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>
In-Reply-To: <20220810171033.bfkzkdipw2v5yorh@pengutronix.de>
Subject: RE: [PATCH] pwm: removes period check from pwm_apply_state()
Date:   Fri, 19 Aug 2022 10:09:18 +0530
Message-ID: <009c01d8b385$aa615f40$ff241dc0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE14N23Ecc1n6hvU/1TooO9Vl2YEgEF3maVAoBW2yoC+wqOdQK9h22TAppw35ICpXWcEK6HU1ow
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmli6b6f8kg3XrrSwezNvGZnH/61FG
        i8u75rBZ3L27itHi5655LBa3J05mdGDz2DnrLrvHnWt72Dz6/xp49G1ZxejxeZNcAGtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMp687
        GQsmeFW8//mCtYFxgkcXIyeHhICJxI+2LuYuRi4OIYHdjBJHtv1mg3A+MUrs2TSfEcL5zCjx
        blU7G0zLpd07WSESuxglZvRchep/xihxbd4PoAwHB5uAqsSOmyIgDSICXhJzL+9mB6lhFpjE
        KPGj/xgrSIJTwFZizvfDTCD1wgKuEh9/MYKEWYBau1f9AFvGK2Ap8ejFWShbUOLkzCcsIDaz
        gJ7EjalT2CBsbYllC18zQxynIPHz6TKwE0QEoiRWPU+CKBGXOPqzB+xMCYGJHBLf1r+GesZF
        Yvulg1C2sMSr41vYIWwpiZf9bVB2usTch71MEHaBxLJd36Hi9hIHrsxhgbBlJaaeWscEsYxP
        ovf3E6h6Xokd82BsRYn/u/uhesUl3q2YwjqBUWkWktdmIXltFpLXZiH5YQEjyypGydSC4tz0
        1GLTAqO81HJ4jCfn525iBCdQLa8djA8ffNA7xMjEwXiIUYKDWUmE98adP0lCvCmJlVWpRfnx
        RaU5qcWHGE2BAT6RWUo0OR+YwvNK4g1NLA1MzMzMTCyNzQyVxHm9rm5KEhJITyxJzU5NLUgt
        gulj4uCUamDqTZOQdN+llsH4sPVbZ0dhxavwM5WneQrldE+c9L2u/albdvNcBa4vG2sduTLn
        Lf23Pm1nktMb1i9iVWr9ro78Z07y6h+fWe0XcqZDM9wucIXXx2Jl/fRp+3mynI0lfgioMOW7
        fONOeOT5/9/Mmz7hpxMaWc7vrNi+z+zn6c56rnX/vO0PpbOW3lqxN+b661UXj6/u/zlRp+E7
        w5T/h54ed7OV+3j6gvqdLTvuz9qwwlLWpp+T9bYW47xLYkJLZc5/XGDm67rx5Luq7NQJM5dz
        2Gy2WVSSXyWg0LuNRYZR5tStXRpSJcKOzzZxapw1ZVrA2H3u+aE/+xRKkuXDeFjFb07d4v1H
        8MJRnkajSmUlluKMREMt5qLiRABOLV6UKQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnC6DyP8kg+dLWSwezNvGZnH/61FG
        i8u75rBZ3L27itHi5655LBa3J05mdGDz2DnrLrvHnWt72Dz6/xp49G1ZxejxeZNcAGsUl01K
        ak5mWWqRvl0CV8a8jmOsBWf0Kz4fvcTcwLhIpYuRk0NCwETi0u6drF2MXBxCAjsYJb71PWCH
        SIhLTPu1nxHCFpZY+e85WFxI4AmjxLIjIl2MHBxsAqoSO26KgIRFBLwk5l7ezQ4yh1lgGqPE
        1Nt3GSGG/mSSWLh4GTNIFaeArcSc74eZQJqFBVwlPv4Cm88CNKd71Q82EJtXwFLi0YuzULag
        xMmZT1hAbGYBA4n7hzpYIWxtiWULXzND3KYg8fPpMlaQkSICURKrnidBlIhLHP3ZwzyBUXgW
        kkmzkEyahWTSLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMePltYOxj2r
        PugdYmTiYDzEKMHBrCTCe+POnyQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRm
        p6YWpBbBZJk4OKUamLYkXr2yYgX7x9i2ORvStdQ2Vy8MKpm8l3lVyN4ct68+5/keRfxbkpvv
        Kfv8a42snNDfXS9qtp2bzLRS5XIZv3lf8rVvOcvuHfOvKlVrjMz5cj9+897GXqMti2U+F0z8
        7tf43GgHi8wNX6/5nwqb3ybkfkwR5LI9uaZ7oevCaWFp9rEMxj2qSpt/B+Wbr30wpSFqe400
        0/X3Zd/PtoQqnN9z5W3NToV9p9xn/U7MnWimYVNlKGUwb+NHxhzz13q/6xes+bZINNJ8lXXP
        +Y9TEniezHgjz6ygx9G+7rdF5c6Zz5uid5T26MZdTXKJe8UdI6dqcrIr51VxeGx4rhSXuZ5E
        4X2bdM6rp7bZbjvCpsRSnJFoqMVcVJwIAHWq6X4OAwAA
X-CMS-MailID: 20220819043928epcas5p33942271e69c4e21dcbc506cce74fbbf4
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea
References: <CGME20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea@epcas5p2.samsung.com>
        <20220805101125.47955-1-m.shams@samsung.com>
        <20220805155509.edqwxcvyoqfic4pn@pengutronix.de>
        <019701d8ab31$94c86d60$be594820$@samsung.com>
        <20220808174842.jiato34jzqstchdn@pengutronix.de>
        <004301d8acad$e31fee70$a95fcb50$@samsung.com>
        <20220810171033.bfkzkdipw2v5yorh@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig=20=5Bmailto:u.kleine-koenig=40pengutronix.de=5D=
=0D=0A>=20Sent:=2010=20August=202022=2022:41=0D=0A>=20To:=20m.shams=20<m.sh=
ams=40samsung.com>=0D=0A>=20Cc:=20thierry.reding=40gmail.com;=20lee.jones=
=40linaro.org;=20linux-=0D=0A>=20pwm=40vger.kernel.org;=20linux-kernel=40vg=
er.kernel.org;=0D=0A>=20alim.akhtar=40samsung.com=0D=0A>=20Subject:=20Re:=
=20=5BPATCH=5D=20pwm:=20removes=20period=20check=20from=20pwm_apply_state()=
=0D=0A>=20=0D=0A>=20Hello,=0D=0A>=20=0D=0A>=20On=20Wed,=20Aug=2010,=202022=
=20at=2005:09:30PM=20+0530,=20m.shams=20wrote:=0D=0A>=20>=20>=20I=20fixed=
=20up=20the=20quoting=20for=20you=20in=20this=20mail.=20Please=20fix=20your=
=20mailer=0D=0A>=20>=20>=20to=20not=0D=0A>=20>=20break=0D=0A>=20>=20>=20quo=
tes,=20this=20is=20quite=20annoying.=20(Looking=20at=20the=20headers=20of=
=20your=20mail=0D=0A>=20>=20you're=20using=0D=0A>=20>=20>=20Outlook.=20Then=
=20your=20only=20viable=20option=20is=20to=20switch=20to=20a=20saner=0D=0A>=
=20>=20>=20client.)=0D=0A>=20>=20>=0D=0A>=20>=0D=0A>=20>=20Sorry=20for=20th=
e=20inconvenience.=20I=20have=20fixed=20my=20mailer.=0D=0A>=20=0D=0A>=20No=
=20you=20didn't.=0D=0A>=20=0D=0A>=20>=20>=20On=20Mon,=20Aug=2008,=202022=20=
at=2007:47:03PM=20+0530,=20m.shams=20wrote:=0D=0A>=20>=20>=20>=20On=20Fri,=
=20Aug=2005,=202022=20at=2003:41:25PM=20+0530,=20Tamseel=20Shams=20wrote:=
=0D=0A>=20>=20>=20>=20>=20>=20There=20may=20be=20situation=20when=20PWM=20i=
s=20exported=20using=20sysfs,=20but=0D=0A>=20>=20>=20>=20>=20>=20at=20that=
=20point=20PWM=20period=20is=20not=20set.=20At=20this=20situation=20if=20we=
=0D=0A>=20>=20>=20>=20>=20>=20issue=20a=20system=20suspend,=20it=20calls=20=
pwm_class_suspend=20which=20in=0D=0A>=20>=20>=20>=20>=20>=20turn=20calls=20=
pwm_apply_state,=20where=20PWM=20period=20value=20is=20checked=0D=0A>=20>=
=20>=20>=20>=20>=20which=20returns=20an=20invalid=20argument=20error=20casu=
ing=20Kernel=20to=0D=0A>=20>=20>=20>=20>=20>=20panic.=20So,=20check=20for=
=20PWM=20period=20value=20is=20removed=20so=20as=20to=20fix=0D=0A>=20>=20>=
=20>=20>=20>=20the=20kernel=20panic=20observed=20during=20suspend.=0D=0A>=
=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20This=20looks=20and=20sounds=20wro=
ng.=20One=20thing=20I=20would=20accept=20is:=0D=0A>=20>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20>=20diff=20--git=20a/drivers/pwm/core.c=20b/drivers/pwm/core=
.c=20index=0D=0A>=20>=20>=20>=20>=200e042410f6b9..075bbcdad6c1=20100644=0D=
=0A>=20>=20>=20>=20>=20---=20a/drivers/pwm/core.c=0D=0A>=20>=20>=20>=20>=20=
+++=20b/drivers/pwm/core.c=0D=0A>=20>=20>=20>=20>=20=40=40=20-557,8=20+557,=
8=20=40=40=20int=20pwm_apply_state(struct=20pwm_device=0D=0A>=20*pwm,=0D=0A=
>=20>=20>=20const=20struct=20pwm_state=20*state)=0D=0A>=20>=20>=20>=20>=20=
=09=20*/=0D=0A>=20>=20>=20>=20>=20=09might_sleep();=0D=0A>=20>=20>=20>=20>=
=0D=0A>=20>=20>=20>=20>=20-=09if=20(=21pwm=20=7C=7C=20=21state=20=7C=7C=20=
=21state->period=20=7C=7C=0D=0A>=20>=20>=20>=20>=20-=09=20=20=20=20state->d=
uty_cycle=20>=20state->period)=0D=0A>=20>=20>=20>=20>=20+=09if=20(=21pwm=20=
=7C=7C=20=21state=20=7C=7C=20state->enabled=20&&=20(=21state->period=20=7C=
=7C=0D=0A>=20>=20>=20>=20>=20+=09=20=20=20=20state->duty_cycle=20>=20state-=
>period))=0D=0A>=20>=20>=20>=20>=20=20=09=09return=20-EINVAL;=0D=0A>=20>=20=
>=20>=20>=0D=0A>=20>=20>=20>=20>=20=09chip=20=3D=20pwm->chip;=0D=0A>=20>=20=
>=20>=20>=0D=0A>=20>=20>=20>=20>=20That=20is,=20don't=20refuse=20calling=20=
pwm_apply_state()=20for=0D=0A>=20>=20>=20>=20>=20state->period=20=3D=0D=0A>=
=20>=20>=20>=20>=200=20and=20even=20state->duty_cycle=20>=20state->period=
=20if=20the=20>=20>=20PWM=20is=0D=0A>=20>=20>=20>=20>=20not=0D=0A>=20>=20en=
abled.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20By=20this=20do=20you=20mean=
=20doing=20it=20following=20way?=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20if=
=20(=21pwm=20=7C=7C=20=21state=20=7C=7C=20(pwm=20&&=20=21state->period)=20=
=7C=7C=0D=0A>=20>=20>=20>=20=09=20=20=20=20(pwm=20&&=20state->duty_cycle=20=
>=20state->period))=0D=0A>=20>=20>=20>=20=09=09return=20-EINVAL;=0D=0A>=20>=
=20>=0D=0A>=20>=20>=20No.=20Your=20expression=20is=20logically=20equivalent=
=20to=20what=20we=20already=20have.=0D=0A>=20>=20>=20I=0D=0A>=20>=20>=20mea=
nt:=0D=0A>=20>=20>=0D=0A>=20>=20>=20=09if=20(=21pwm=20=7C=7C=20=21state=20=
=7C=7C=20state->enabled=20&&=20(=21state->period=20=7C=7C=0D=0A>=20>=20>=20=
=09=20=20=20=20state->duty_cycle=20>=20state->period))=0D=0A>=20>=20>=20=09=
=09return=20-EINVAL;=0D=0A>=20>=20>=0D=0A>=20>=20>=20Learning=20to=20read=
=20diffs=20(maybe=20Outlook=20scrambled=20the=20view=20for=20you,=0D=0A>=20=
>=20>=20too?)=20is=0D=0A>=20>=20a=0D=0A>=20>=20>=20nice=20capability=20you=
=20should=20master.=0D=0A>=20>=20>=0D=0A>=20>=20>=20>=20>=20But=20anyhow,=
=20even=20without=20that=20the=20kernel=20should=20not=20panic.=20So=20I=0D=
=0A>=20>=20>=20>=20>=20ask=20you=20to=20research=20and=20provide=20some=20m=
ore=20info=20about=20>=20>=20the=0D=0A>=20problem.=0D=0A>=20>=20>=20>=20>=
=20(Which=20hardware=20does=20it=20affect?=20Where=20does=20it=20panic?=20.=
..)=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Observing=20Kernel=20panic=20in=
=20exynos=20SoC=20when=20we=20issue=20system=20suspend.=0D=0A>=20>=20>=20>=
=20Following=20is=20the=20snippet=20of=20error:=0D=0A>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20=23=20echo=20mem=20>=20/sys/power/state=0D=0A>=20>=20>=20>=
=20=5B=20=20=2029.224784=5D=20010:=20Kernel=20panic=20-=20not=20syncing:=20=
pwm=20pwmchip0:=0D=0A>=20>=20>=20>=20dpm_run_callback=20failure=0D=0A>=20>=
=20>=20>=20=5B=20=20=2029.240134=5D=20010:=20Call=20trace:=0D=0A>=20>=20>=
=20>=20=5B=20=20=2029.242993=5D=20010:=20=20dump_backtrace+0x0/0x1b8=0D=0A>=
=20>=20>=20>=20=5B=20=20=2029.247067=5D=20010:=20=20show_stack+0x24/0x30=0D=
=0A>=20>=20>=20>=20=5B=20=20=2029.250793=5D=20010:=20=20dump_stack+0xb8/0x1=
14=0D=0A>=20>=20>=20>=20=5B=20=20=2029.254606=5D=20010:=20=20panic+0x180/0x=
398=0D=0A>=20>=20>=20>=20=5B=20=20=2029.258073=5D=20010:=20=20dpm_run_callb=
ack+0x270/0x278=0D=0A>=20>=20>=20>=20=5B=20=20=2029.262493=5D=20010:=20=20_=
_device_suspend+0x15c/0x628=0D=0A>=20>=20>=20>=20=5B=20=20=2029.266913=5D=
=20010:=20=20dpm_suspend+0x124/0x3b0=0D=0A>=20>=20>=20>=20=5B=20=20=2029.27=
0899=5D=20010:=20=20dpm_suspend_start+0xa0/0xa8=0D=0A>=20>=20>=20>=20=5B=20=
=20=2029.275233=5D=20010:=20=20suspend_devices_and_enter+0x110/0x968=0D=0A>=
=20>=20>=20>=20=5B=20=20=2029.280433=5D=20010:=20=20pm_suspend+0x308/0x3d8=
=0D=0A>=20>=20>=20>=20=5B=20=20=2029.284333=5D=20010:=20=20state_store+0x8c=
/0x110=0D=0A>=20>=20>=20>=20=5B=20=20=2029.288233=5D=20010:=20=20kobj_attr_=
store+0x14/0x28=0D=0A>=20>=20>=20>=20=5B=20=20=2029.292393=5D=20010:=20=20s=
ysfs_kf_write+0x5c/0x78=0D=0A>=20>=20>=20>=20=5B=20=20=2029.296466=5D=20010=
:=20=20kernfs_fop_write+0x10c/0x220=0D=0A>=20>=20>=20>=20=5B=20=20=2029.300=
886=5D=20010:=20=20__vfs_write+0x48/0x90=0D=0A>=20>=20>=20>=20=5B=20=20=202=
9.304699=5D=20010:=20=20vfs_write+0xb8/0x1c0=0D=0A>=20>=20>=20>=20=5B=20=20=
=2029.308426=5D=20010:=20=20ksys_write+0x74/0x100=0D=0A>=20>=20>=20>=20=5B=
=20=20=2029.312240=5D=20010:=20=20__arm64_sys_write+0x24/0x30=0D=0A>=20>=20=
>=20>=20=5B=20=20=2029.316573=5D=20010:=20=20el0_svc_handler+0x110/0x1b8=0D=
=0A>=20>=20>=20>=20=5B=20=20=2029.320906=5D=20010:=20=20el0_svc+0x8/0x1bc=
=0D=0A>=20>=20>=20>=20=5B=20=20=2029.324374=5D=20010:=20SMP:=20stopping=20s=
econdary=20CPUs=0D=0A>=20>=20>=20>=20=5B=20=20=2029.328711=5D=20010:=20Kern=
el=20Offset:=20disabled=0D=0A>=20>=20>=20>=20=5B=20=20=2029.332607=5D=20010=
:=20CPU=20features:=200x0002,00006008=0D=0A>=20>=20>=20>=20=5B=20=20=2029.3=
37026=5D=20010:=20Memory=20Limit:=20none=0D=0A>=20>=20>=20>=20=5B=20=20=202=
9.343949=5D=20010:=20Rebooting=20in=201=20seconds..=0D=0A>=20>=20>=20>=20=
=5B=20=20=2030.344539=5D=20010:=20Disabling=20non-boot=20CPUs=20...=0D=0A>=
=20>=20>=0D=0A>=20>=20>=20Just=20locking=20at=20that=20and=20starring=20at=
=20drivers/base/power/main.c=20for=20a=0D=0A>=20>=20>=20while=20doesn't=20m=
ake=20this=20clearer=20to=20me.=20Are=20you=20using=20a=20mainline=0D=0Aker=
nel?=0D=0A>=20>=20>=20Which=20version?=0D=0A>=20>=20>=0D=0A>=20>=0D=0A>=20>=
=20Looks=20like=20I=20had=20some=20local=20patch=20which=20was=20causing=20=
the=20error=20to=0D=0A>=20>=20trigger=20Kernel=20Panic=20(sorry=20about=20t=
hat).=0D=0A>=20>=20On=20removing=20those=20local=20changes,=20I=20do=20not=
=20observe=20kernel=20panic,=20but=0D=0A>=20>=20observe=20following=20error=
=20and=20then=20suspend=20fails.=0D=0A>=20>=0D=0A>=20>=20=5B=20=20=2063.963=
063=5D=20pwm=20pwmchip0:=20PM:=20dpm_run_callback=20():=0D=0A>=20>=20pwm_cl=
ass_suspend+0x0/0xf8=20returns=20-22=0D=0A>=20>=20=5B=20=20=2063.963079=5D=
=20pwm=20pwmchip0:=20PM:=20failed=20to=20suspend:=20error=20-22=0D=0A>=20>=
=0D=0A>=20>=20So,=20as=20to=20fix=20this=20issue=20I=20will=20post=20a=20ne=
w=20version=20of=20patch=20containing=0D=0A>=20>=20change=20suggested=20by=
=20you.=0D=0A>=20=0D=0A>=20Note=20that=20my=20suggestion=20only=20covers=20=
you=20problem,=20it=20doesn't=20solve=20it.=0D=0A>=20=0D=0A=0D=0AYour=20sug=
gestion=20looks=20like=20a=20permanent=20fix,=20as=20there=20should=20not=
=20be=20any=20use=0D=0Acase=0D=0Awhere=20we=20check=20for=20=22period=22=20=
and=20=22duty_cycle=22,=20without=20PWM=20being=20in=20enabled=0D=0Astate.=
=0D=0A=0D=0AThanks=20&=20Regards,=0D=0ATamseel=20Shams=0D=0A=0D=0A=0D=0A
