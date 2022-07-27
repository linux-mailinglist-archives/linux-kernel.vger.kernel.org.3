Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6EB582172
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiG0Hqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiG0Hq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:46:27 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BAA62CA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:46:24 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220727074621epoutp0471a9e3a824a5afe3cefad69cc232ec5b~FoAULmyU72833428334epoutp044
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:46:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220727074621epoutp0471a9e3a824a5afe3cefad69cc232ec5b~FoAULmyU72833428334epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658907981;
        bh=CtbrmE5mtbwmdtJprAHDtXpLA8uc08KEWRUQJGjNkUE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=SZzi3Bs/bezEjCoMt6nQedw6R8CNLkCuhRiNz2eZLSkxR03ekpId0aD3OtxmHMqKu
         VhWqNjHr6yVNeD5MAvjBe2504kqD2wLPFVGGbr2MSe3UwKFrJjmH8mGBzanjzPV05l
         pHy+fijjGFLkRkFEVAruAh1KcsdXItrx5H/ifA4A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220727074620epcas1p10318d08312608dfabd43eb68621e1615~FoATaoZ3a0632806328epcas1p1j;
        Wed, 27 Jul 2022 07:46:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.227]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lt5SX0y5fz4x9Q6; Wed, 27 Jul
        2022 07:46:20 +0000 (GMT)
X-AuditID: b6c32a37-aea59a80000025bd-7a-62e0ed4bcca1
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.A1.09661.B4DE0E26; Wed, 27 Jul 2022 16:46:20 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] page_alloc: fix invalid watemark check on a negative
 value
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220725113707.e03007d0761423f642c15749@linux-foundation.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727074619epcms1p7285bceab31c4e04406094eee84862803@epcms1p7>
Date:   Wed, 27 Jul 2022 16:46:19 +0900
X-CMS-MailID: 20220727074619epcms1p7285bceab31c4e04406094eee84862803
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmga7P2wdJBocmMlvMWb+GzeL8g19s
        Fi8PaVps+f2G0WL1Jl+L7s0zGS16379isri8aw6bxb01/1ktdizdx2Tx+tsyZotlX9+zW8xu
        7GO0eLye24HP4/Cb98weO2fdZffYtKqTzWPTp0nsHidm/GbxeL/vKptH35ZVjB5nFhxh99j6
        y87j8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBd
        t8wcoPOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaG
        BgZGpkCFCdkZMyZ9Zy3YIlYx5fkV1gbGV6JdjJwcEgImEksvN7B1MXJxCAnsYJR4saKJqYuR
        g4NXQFDi7w5hkBphgRCJg3e3MoLYQgJKEmd/XGGHiOtKNHWvZgGx2QS0Jd4vmMQKYosIhEk0
        P/nEAjKTWeAPs0TT969MEMt4JWa0P2WBsKUlti+HGMop4C3x9NNUdoi4qMTN1W/h7PfH5jNC
        2CISrffOMkPYghIPfu6GiktJnOs+DnazhECExIs96hDhHIn3O+ewQtjmEs82tICN5BXwlXhz
        9gLYCSwCqhIvjk9khWh1kZg7Tx4kzAz0yrKFr5lBwswCmhLrd+lDTFGU2Pl7LiPMIw0bf7Oj
        s5kF+CTefe1hhYnvmPcE6nE1iZZnX6HiMhJ//z1jncCoNAsRzrOQLJ6FsHgBI/MqRrHUguLc
        9NRiwwJjeNQm5+duYgSnYy3zHYzT3n7QO8TIxMF4iFGCg1lJhDch+n6SEG9KYmVValF+fFFp
        TmrxIUZToI8nMkuJJucDM0JeSbyhiaWBiZmRiYWxpbGZkjjvqmmnE4UE0hNLUrNTUwtSi2D6
        mDg4pRqYJh3YcPqh4UGm/Y1yTOHFvXsX2AR98/Cu5rioLqH6fsfx2HKzt1KHmj+mz2l4NqGq
        +ya70ZyOfZtfWRnP19V21yvfs2Gvtef9Q+4+yTP3PylcoSB+KiKgaKPTrQzuzZk7j+u9VowT
        DFjZuKvyWVt3ZJJ51039g/3HRA51Xb2f47Os7RvDiS//Dzcbl1yZyV/hJRJzz0y59Tjnh5Cq
        rwebZwmxs51jP6H/sd10eqAmzwN/rpc/NvBW7NmXcOCd4NYLKdHCL2z9mTrnO/30CVPfZm/U
        fKnXr3fbbq4H8ootM+u15Pf8jVM+Wr/N2ChbfLWrZEd+ZkxNXvbjaCulW/VrTl/1vd+TH8Oa
        lfGhb40SS3FGoqEWc1FxIgA+TeqcUAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725095214epcas1p1cc2019c792560da07d673809a3fc7ef3
References: <20220725113707.e03007d0761423f642c15749@linux-foundation.org>
        <20220725095212.25388-1-jaewon31.kim@samsung.com>
        <CGME20220725095214epcas1p1cc2019c792560da07d673809a3fc7ef3@epcms1p7>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=C2=A0=0D=0A>=C2=A0=0D=0A>---------=20Original=20Message=20---------=0D=0A=
>Sender=20:=20Andrew=20Morton=C2=A0<akpm=40linux-foundation.org>=0D=0A>Date=
=20:=202022-07-26=2003:37=20(GMT+9)=0D=0A>Title=20:=20Re:=20=5BPATCH=20v2=
=5D=20page_alloc:=20fix=20invalid=20watemark=20check=20on=20a=20negative=20=
value=0D=0A>=C2=A0=0D=0A>On=C2=A0Mon,=C2=A025=C2=A0Jul=C2=A02022=C2=A018:52=
:12=C2=A0+0900=C2=A0Jaewon=C2=A0Kim=C2=A0<jaewon31.kim=40samsung.com>=C2=A0=
wrote:=0D=0A>=0D=0A>>=C2=A0There=C2=A0was=C2=A0a=C2=A0report=C2=A0that=C2=
=A0a=C2=A0task=C2=A0is=C2=A0waiting=C2=A0at=C2=A0the=0D=0A>>=C2=A0throttle_=
direct_reclaim.=C2=A0The=C2=A0pgscan_direct_throttle=C2=A0in=C2=A0vmstat=C2=
=A0was=0D=0A>>=C2=A0increasing.=0D=0A>>=C2=A0=0D=0A>>=C2=A0This=C2=A0is=C2=
=A0a=C2=A0bug=C2=A0where=C2=A0zone_watermark_fast=C2=A0returns=C2=A0true=C2=
=A0even=C2=A0when=C2=A0the=C2=A0free=0D=0A>>=C2=A0is=C2=A0very=C2=A0low.=C2=
=A0The=C2=A0commit=C2=A0f27ce0e14088=C2=A0(=22page_alloc:=C2=A0consider=C2=
=A0highatomic=0D=0A>>=C2=A0reserve=C2=A0in=C2=A0watermark=C2=A0fast=22)=C2=
=A0changed=C2=A0the=C2=A0watermark=C2=A0fast=C2=A0to=C2=A0consider=0D=0A>>=
=C2=A0highatomic=C2=A0reserve.=C2=A0But=C2=A0it=C2=A0did=C2=A0not=C2=A0hand=
le=C2=A0a=C2=A0negative=C2=A0value=C2=A0case=C2=A0which=0D=0A>>=C2=A0can=C2=
=A0be=C2=A0happened=C2=A0when=C2=A0reserved_highatomic=C2=A0pageblock=C2=A0=
is=C2=A0bigger=C2=A0than=C2=A0the=0D=0A>>=C2=A0actual=C2=A0free.=0D=0A>>=C2=
=A0=0D=0A>>=C2=A0If=C2=A0watermark=C2=A0is=C2=A0considered=C2=A0as=C2=A0ok=
=C2=A0for=C2=A0the=C2=A0negative=C2=A0value,=C2=A0allocating=0D=0A>>=C2=A0c=
ontexts=C2=A0for=C2=A0order-0=C2=A0will=C2=A0consume=C2=A0all=C2=A0free=C2=
=A0pages=C2=A0without=C2=A0direct=C2=A0reclaim,=0D=0A>>=C2=A0and=C2=A0final=
ly=C2=A0free=C2=A0page=C2=A0may=C2=A0become=C2=A0depleted=C2=A0except=C2=A0=
highatomic=C2=A0free.=0D=0A>>=C2=A0=0D=0A>>=C2=A0Then=C2=A0allocating=C2=A0=
contexts=C2=A0may=C2=A0fall=C2=A0into=C2=A0throttle_direct_reclaim.=C2=A0Th=
is=0D=0A>>=C2=A0symptom=C2=A0may=C2=A0easily=C2=A0happen=C2=A0in=C2=A0a=C2=
=A0system=C2=A0where=C2=A0wmark=C2=A0min=C2=A0is=C2=A0low=C2=A0and=C2=A0oth=
er=0D=0A>>=C2=A0reclaimers=C2=A0like=C2=A0kswapd=C2=A0does=C2=A0not=C2=A0ma=
ke=C2=A0free=C2=A0pages=C2=A0quickly.=0D=0A>>=C2=A0=0D=0A>>=C2=A0Handle=C2=
=A0the=C2=A0negative=C2=A0case=C2=A0by=C2=A0using=C2=A0MIN.=0D=0A>>=C2=A0=
=0D=0A>=0D=0A>Thanks,=C2=A0I=C2=A0added=C2=A0cc:stable=C2=A0to=C2=A0this.=
=0D=0A>=0D=0A=0D=0ASorry=20for=20your=20inconvenience.=0D=0A=0D=0ACould=20y=
ou=20fix=20a=20typo=20by=20adding=20r=20to=20watermark=20on=20title=0D=0A=
=0D=0A-=20page_alloc:=20fix=20invalid=20watemark=20check=20on=20a=20negativ=
e=20value=0D=0A+=20page_alloc:=20fix=20invalid=20watermark=20check=20on=20a=
=20negative=20value=0D=0A=0D=0A=0D=0AI've=20appreciated=20it=20in=20advance.
