Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E264ED4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiCaHar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiCaHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:30:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93537A95
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:28:50 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220331072848epoutp022dbda881db01304183c73702fdc18dfc~hZpTjsXt61156411564epoutp02h
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:28:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220331072848epoutp022dbda881db01304183c73702fdc18dfc~hZpTjsXt61156411564epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648711728;
        bh=JklK4+/QcfhoWqf+/Kmo7YPclTT9xspCDtBds+uRFXM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=JHpYXtVOPJx5qRxQd1PvEDsZJRgc2r0mUTH3vgR8A03MhA4i4AhPJ2Ym9L3ChxxgM
         AG/GKHlyrXCNJGWuT9QxNp+tOvre3kv5ddatXqyqwxiNBXPxAXu/IHgngka090vVcw
         WCRIAFdA/m9Ol9UIVkVv8wIgY7E0cCXwu2AE1ZIs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220331072847epcas2p103c7961fef3d8f6447169f5b0a101abb~hZpSymB3G1115511155epcas2p17;
        Thu, 31 Mar 2022 07:28:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KTZfh4Mddz4x9Q1; Thu, 31 Mar
        2022 07:28:44 +0000 (GMT)
X-AuditID: b6c32a48-511ff7000000810c-48-6245582b5316
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.F4.33036.B2855426; Thu, 31 Mar 2022 16:28:43 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] thermal: exynos: fix masking value for exynos7
 temp_error
Reply-To: hypmean.kim@samsung.com
Sender: Sang Min Kim <hypmean.kim@samsung.com>
From:   Sang Min Kim <hypmean.kim@samsung.com>
To:     "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220331071833.115732-1-hypmean.kim@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220331072843epcms2p5c9e7ee4756d1aa267cf4af56b0ca22fc@epcms2p5>
Date:   Thu, 31 Mar 2022 16:28:43 +0900
X-CMS-MailID: 20220331072843epcms2p5c9e7ee4756d1aa267cf4af56b0ca22fc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmua52hGuSwaM1ShYP5m1jszg8v8Li
        +5brTBYvD2lazPssazH/yjVWi/PnN7BbbHoMZF3eNYfN4nPvEUaLGef3MVnM/TKV2eLJwz42
        B16PnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgHsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCnKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM34uWctc8Euh4tuKzewN
        jD0KXYycHBICJhINh1+wdDFycQgJ7GCU6Lv3kL2LkYODV0BQ4u8OYZAaYQF/iYPPdrOC2EIC
        ihIvd2xnhojrSdzc+JkdxGYT0JF43HqfCWSOiMATJonz388ygjjMAjOYJM52nWCF2MYrMaP9
        KQuELS2xfflWRhCbU8BO4sz5xVBxDYkfy3qZIWxRiZur37LD2O+PzWeEsEUkWu+dhaoRlHjw
        czdUXFJi0+HtUPXVErc2LmcFOUJCoIFRovVbEzPIZxIC+hI7rhuD1PAK+EpM6pgN1ssioCqx
        vO0Z1J0uEvt2HwOLMwtoSyxb+BqslVlAU2L9Ln2IKcoSR26xwHzVsPE3OzqbWYBPouPwX7j4
        jnlPmCBsVYmdm7rZJzAqz0KE9Cwku2Yh7FrAyLyKUSy1oDg3PbXYqMAEHrnJ+bmbGMGpVstj
        B+Pstx/0DjEycTAeYpTgYFYS4f140DlJiDclsbIqtSg/vqg0J7X4EKMp0JcTmaVEk/OByT6v
        JN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVANTQ0C9js29zX7bVm9M
        Vnx/at3Kuq/T9/aZZBQmvy3PfZp6qJ+la41Y291PbHVCR+yXZ+UuZV4mu0ZivcpiP++lP1wy
        lHYahyr1deu3+2kGXbRuktE7nrLpf/bBfbN433EqlFduKG14vngh/1wLo+vRNYkc1173FkQo
        yqSf6rr6qvmD2pyem1Y/ZXq+FcrOOqzWdDojrtJfvDf96WNXM8cahrupio02C2cZdNxbv3KL
        xuVpp7eXBa8x2b7LKY6H959JcE28p9e/eZmPWZnvOJ14c7G/wbfXrUop0KTrg1rNV5G+a0pf
        Hc9u/X1b+Yg273+hYOEgfTbpqNU7J0c7rdrUvPp2jfDh7RM/tZs8l1diKc5INNRiLipOBABv
        sw3XPgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220331071809epcas2p472298073d4aed0a8026d4b08967c5de5
References: <20220331071833.115732-1-hypmean.kim@samsung.com>
        <CGME20220331071809epcas2p472298073d4aed0a8026d4b08967c5de5@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C2=A0=0D=0AModify=C2=A0mask=C2=A0value=C2=A0for=C2=A0the=C2=A0temp_error=
=C2=A0in=C2=A0the=C2=A0sanitize_temp_error()=C2=A0function.=0D=0A=C2=A0=0D=
=0AFixes:=C2=A0aef27b658b43=C2=A0(=22thermal:=C2=A0exynos:=C2=A0use=C2=A0sa=
nitize_temp_error()=C2=A0in=C2=A0exynos7_tmu_initialize()=22)=0D=0Amasked=
=C2=A0temp_error2=C2=A0with=C2=A0EXYNOS_TMU_TEMP_MASK(0xff)=C2=A0value=C2=
=A0even=C2=A0in=C2=A0the=C2=A0case=0D=0Aof=C2=A0EXYNOS7.=0D=0AIn=C2=A0addit=
ion,=C2=A0when=C2=A0entering=C2=A0the=C2=A0if=C2=A0statement,=C2=A0both=C2=
=A0temp_error1=C2=A0and=C2=A02=C2=A0are=0D=0Amasked=C2=A0with=C2=A0EXYNOS_T=
MU_TEMP_MASK(0xff).=0D=0A=C2=A0=0D=0ABy=C2=A0modifying=C2=A0to=C2=A0use=C2=
=A0the=C2=A0previously=C2=A0declared=C2=A0local=C2=A0variable=C2=A0tmu_temp=
_mask,=0D=0Athe=C2=A0mask=C2=A0value=C2=A0suitable=C2=A0for=C2=A0the=C2=A0S=
OC=C2=A0can=C2=A0be=C2=A0applied.=0D=0A=C2=A0=0D=0ASigned-off-by:=C2=A0sang=
min=C2=A0kim=C2=A0<hypmean.kim=40samsung.com>=0D=0A---=0D=0A=C2=A0V1=C2=A0-=
>=C2=A0V2:=C2=A0Add=C2=A0fixes=C2=A0tag=0D=0A=C2=A0=0D=0A=C2=A0drivers/ther=
mal/samsung/exynos_tmu.c=C2=A0=7C=C2=A06=C2=A0+++---=0D=0A=C2=A01=C2=A0file=
=C2=A0changed,=C2=A03=C2=A0insertions(+),=C2=A03=C2=A0deletions(-)=0D=0A=C2=
=A0=0D=0Adiff=C2=A0--git=C2=A0a/drivers/thermal/samsung/exynos_tmu.c=C2=A0b=
/drivers/thermal/samsung/exynos_tmu.c=0D=0Aindex=C2=A0f4ab4c5b4b62..08c63fe=
5566e=C2=A0100644=0D=0A---=C2=A0a/drivers/thermal/samsung/exynos_tmu.c=0D=
=0A+++=C2=A0b/drivers/thermal/samsung/exynos_tmu.c=0D=0A=40=40=C2=A0-243,17=
=C2=A0+243,17=C2=A0=40=40=C2=A0static=C2=A0void=C2=A0sanitize_temp_error(st=
ruct=C2=A0exynos_tmu_data=C2=A0*data,=C2=A0u32=C2=A0trim_info)=0D=0A=C2=A0=
=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->temp_erro=
r1=C2=A0=3D=C2=A0trim_info=C2=A0&=C2=A0tmu_temp_mask;=0D=0A=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->temp_error2=C2=A0=3D=C2=A0((tr=
im_info=C2=A0>>=C2=A0EXYNOS_TRIMINFO_85_SHIFT)=C2=A0&=0D=0A-=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0EXYNOS_TMU_TEMP_MASK);=0D=0A+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tmu_temp_mask);=0D=0A=C2=A0=0D=0A=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21data->temp_error1=C2=A0=7C=
=7C=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(data->min_efuse_value=C2=A0>=C2=A0data->temp_error1)=C2=A0=7C=
=7C=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(data->temp_error1=C2=A0>=C2=A0data->max_efuse_value))=0D=0A-=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0data->temp_error1=C2=A0=3D=C2=A0data->efuse_value=C2=
=A0&=C2=A0EXYNOS_TMU_TEMP_MASK;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->temp_erro=
r1=C2=A0=3D=C2=A0data->efuse_value=C2=A0&=C2=A0tmu_temp_mask;=0D=0A=C2=A0=
=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21dat=
a->temp_error2)=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->temp_error2=C2=A0=3D=
=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(data->efuse_value=C2=A0>>=C2=A0EXYNOS_TRIMINFO_85_SHIFT)=C2=A0&=0D=
=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
EXYNOS_TMU_TEMP_MASK;=0D=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tmu_temp_mask;=0D=0A=C2=A0=7D=0D=0A=C2=A0=0D=0A=C2=
=A0static=C2=A0int=C2=A0exynos_tmu_initialize(struct=C2=A0platform_device=
=C2=A0*pdev)=0D=0A--=0D=0A2.9.5=0D=0A
