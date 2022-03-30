Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9D4EBDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiC3Jp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiC3JpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:45:24 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC31689BC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:43:37 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220330094335epoutp046011b4be685e9240ecb843ae43767391~hH1s-OSm01821418214epoutp04k
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:43:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220330094335epoutp046011b4be685e9240ecb843ae43767391~hH1s-OSm01821418214epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648633415;
        bh=iFIPEFQ0MLQon8gnTy1omTAKrg3mcd9SEAOGrTgjzSU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=MYzyjJccCaZb52lnbcZQ/YGBbtgRjiIk1+2oG6HHw0KaTn3ZBLsSwEPItzfaPUQiV
         b4mDUh51Pdhu2+sRhzBZLAKB5FR3/rT+azhSnoSx+g6yAoIDLyVtiuVgXE9YC/8TYc
         7YAD47EylGB252ecPLSsgkUuRb6oTw7ergfVOCTo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220330094334epcas2p116fdc57a4b7eb64ee0c47329bb2624ba~hH1sZvtnF1947619476epcas2p1t;
        Wed, 30 Mar 2022 09:43:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KT1hf4pSQz4x9QL; Wed, 30 Mar
        2022 09:43:30 +0000 (GMT)
X-AuditID: b6c32a48-511ff7000000810c-23-6244264185c7
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.24.33036.14624426; Wed, 30 Mar 2022 18:43:29 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] thermal: exynos: fix masking value for artpec7 temp_error
Reply-To: hypmean.kim@samsung.com
Sender: Sang Min Kim <hypmean.kim@samsung.com>
From:   Sang Min Kim <hypmean.kim@samsung.com>
To:     "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220330093905.191315-1-hypmean.kim@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220330094328epcms2p35a3346066ae7b3e8a489e2c81d44f8c9@epcms2p3>
Date:   Wed, 30 Mar 2022 18:43:28 +0900
X-CMS-MailID: 20220330094328epcms2p35a3346066ae7b3e8a489e2c81d44f8c9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmua6jmkuSwddvXBYP5m1jszg8v8Li
        +5brTBYvD2lazPssa3H+/AZ2i02Pr7FaXN41h83ic+8RRosZ5/cxWcz9MpXZ4snDPjYHHo+d
        s+6yeyze85LJY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2
        St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QFcqKZQl5pQChQISi4uV9O1sivJLS1IV
        MvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzTnyeyVSwULGi75xbA+NmhS5G
        Tg4JAROJ+d+eM4HYQgI7GCU2/PXtYuTg4BUQlPi7QxgkLCzgJdG25jkbRImixMsd25kh4noS
        Nzd+Zgex2QR0JB633gcaw8UhIrCdSWLTm+0sIA6zwAwmibNdJ1ghlvFKzGh/ygJhS0tsX76V
        EcTmFLCT+D5/HlSNhsSPZb3MELaoxM3Vb9lh7PfH5jNC2CISrffOQtUISjz4uRsqLimx6fB2
        qPpqiVsbl7OCHCEh0MAo0fqtiRnkMwkBfYkd141BangFfCVeHu8Dm8MioCrR+u4C1G0uEpfn
        /webwyygLbFs4WuwVmYBTYn1u/QhpihLHLnFAvNVw8bf7OhsZgE+iY7Df+HiO+Y9YYKwVSV2
        bupmn8CoPAsR0rOQ7JqFsGsBI/MqRrHUguLc9NRiowITeNQm5+duYgQnVy2PHYyz337QO8TI
        xMF4iFGCg1lJhPfjQeckId6UxMqq1KL8+KLSnNTiQ4ymQF9OZJYSTc4Hpve8knhDE0sDEzMz
        Q3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MpuK/TZKv6OT7ih1RSckqvDrvkZxU
        t86r/RrMzQdZQ0yKvwgYCLUdZGFObMmuvz//TmG4zd1c9s8NV+984kv02VXNkHri04eXipL+
        /cZiny63+l/4MHnG2jOGb9emxSyY1P+23kf9z5f6STf1VK8dfsee9DLX6duiORz8Yvvutyx6
        srrstugSnaSsA4dzn8WtdZD8VCFY5HXarHSNSubKTXbcud4PHTpmGF/wS35tdLuHKYSTw+ml
        76zmO1LSU7fdlb9oLntwYi+DdkXXVtkJl69qfCwKbL1x+tGaKSuF1+xdflD9Sti18pyTSu90
        z5lcUfBuapdek6B37XqbgPny95rXtjk/d52+xlNlQpKPEktxRqKhFnNRcSIAiuLr+TcEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220330093842epcas2p11a4e220245298c5729e4a37d1484d4d5
References: <20220330093905.191315-1-hypmean.kim@samsung.com>
        <CGME20220330093842epcas2p11a4e220245298c5729e4a37d1484d4d5@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This=C2=A0patch=C2=A0is=C2=A0a=C2=A0modification=C2=A0related=C2=A0to=C2=A0=
masking=C2=A0of=C2=A0the=C2=A0temp_error=C2=A0value=0D=0Ain=C2=A0the=C2=A0s=
anitize_temp_error()=C2=A0function.=0D=0A=C2=A0=0D=0AFor=C2=A0SOC_ARCH_EXYN=
OS7,=C2=A0the=C2=A0temp_error1,=C2=A02=C2=A0value=C2=A0should=C2=A0be=C2=A0=
masked=C2=A0as=0D=0AEXYNOS7_TMU_TEMP_MASK(0x1ff).=0D=0AThe=C2=A0current=C2=
=A0code=C2=A0masks=C2=A0temp_error2=C2=A0with=C2=A0EXYNOS_TMU_TEMP_MASK(0xf=
f)=0D=0Avalue=C2=A0even=C2=A0in=C2=A0the=C2=A0case=C2=A0of=C2=A0EXYNOS7.=0D=
=0AIn=C2=A0addition,=C2=A0when=C2=A0entering=C2=A0the=C2=A0if=C2=A0statemen=
t,=C2=A0both=C2=A0temp_error1=C2=A0and=C2=A02=0D=0Aare=C2=A0masked=C2=A0wit=
h=C2=A0EXYNOS_TMU_TEMP_MASK(0xff).=0D=0A=C2=A0=0D=0ABy=C2=A0modifying=C2=A0=
to=C2=A0use=C2=A0the=C2=A0previously=C2=A0declared=C2=A0local=C2=A0variable=
=C2=A0tmu_temp_mask,=0D=0Athe=C2=A0mask=C2=A0value=C2=A0suitable=C2=A0for=
=C2=A0the=C2=A0SOC=C2=A0can=C2=A0be=C2=A0applied.=0D=0A=C2=A0=0D=0ASigned-o=
ff-by:=C2=A0sangmin=C2=A0kim=C2=A0<hypmean.kim=40samsung.com>=0D=0A---=0D=
=0A=C2=A0drivers/thermal/samsung/exynos_tmu.c=C2=A0=7C=C2=A06=C2=A0+++---=
=0D=0A=C2=A01=C2=A0file=C2=A0changed,=C2=A03=C2=A0insertions(+),=C2=A03=C2=
=A0deletions(-)=0D=0A=C2=A0=0D=0Adiff=C2=A0--git=C2=A0a/drivers/thermal/sam=
sung/exynos_tmu.c=C2=A0b/drivers/thermal/samsung/exynos_tmu.c=0D=0Aindex=C2=
=A0f4ab4c5..08c63fe=C2=A0100644=0D=0A---=C2=A0a/drivers/thermal/samsung/exy=
nos_tmu.c=0D=0A+++=C2=A0b/drivers/thermal/samsung/exynos_tmu.c=0D=0A=40=40=
=C2=A0-243,17=C2=A0+243,17=C2=A0=40=40=C2=A0static=C2=A0void=C2=A0sanitize_=
temp_error(struct=C2=A0exynos_tmu_data=C2=A0*data,=C2=A0u32=C2=A0trim_info)=
=0D=0A=C2=A0=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dat=
a->temp_error1=C2=A0=3D=C2=A0trim_info=C2=A0&=C2=A0tmu_temp_mask;=0D=0A=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->temp_error2=C2=A0=
=3D=C2=A0((trim_info=C2=A0>>=C2=A0EXYNOS_TRIMINFO_85_SHIFT)=C2=A0&=0D=0A-=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EXYNOS_TMU_TEMP_MASK);=0D=0A+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tmu_temp_mask);=0D=0A=C2=A0=0D=0A=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21data->temp_e=
rror1=C2=A0=7C=7C=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0(data->min_efuse_value=C2=A0>=C2=A0data->temp_er=
ror1)=C2=A0=7C=7C=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0(data->temp_error1=C2=A0>=C2=A0data->max_efuse_v=
alue))=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->temp_error1=C2=A0=3D=C2=A0data->e=
fuse_value=C2=A0&=C2=A0EXYNOS_TMU_TEMP_MASK;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dat=
a->temp_error1=C2=A0=3D=C2=A0data->efuse_value=C2=A0&=C2=A0tmu_temp_mask;=
=0D=0A=C2=A0=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=
=C2=A0(=21data->temp_error2)=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->temp_e=
rror2=C2=A0=3D=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0(data->efuse_value=C2=A0>>=C2=A0EXYNOS_TRIMINFO_85_SHI=
FT)=C2=A0&=0D=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0EXYNOS_TMU_TEMP_MASK;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tmu_temp_mask;=0D=0A=C2=A0=7D=0D=0A=C2=
=A0=0D=0A=C2=A0static=C2=A0int=C2=A0exynos_tmu_initialize(struct=C2=A0platf=
orm_device=C2=A0*pdev)=0D=0A--=C2=A0=0D=0A2.9.5=0D=0A=C2=A0=0D=0A=C2=A0
