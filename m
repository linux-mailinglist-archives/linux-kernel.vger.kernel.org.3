Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2402470B26
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbhLJUAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:00:13 -0500
Received: from mx0b-0011f701.pphosted.com ([148.163.158.185]:15094 "EHLO
        mx0b-0011f701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232829AbhLJUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:00:12 -0500
X-Greylist: delayed 1562 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2021 15:00:11 EST
Received: from pps.filterd (m0099302.ppops.net [127.0.0.1])
        by mx0b-0011f701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BAIJn9q020460;
        Fri, 10 Dec 2021 13:29:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zebra.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pps04202018;
 bh=YC0P5dc22lD94M4kZZY/Xr8HNwEBcS0yXLGTiKEjXuM=;
 b=nqB6lYLYKLy1CMulSaHm9UeVZze5E4mZ67+Fzz1hMLDxJPN6fJ6badgNxgX32aBMPswp
 Lj4XAxygtveEhXZltFgKBC0oJ/8LS76rIAm/+hY17GfetwqyQuZjtJQOh0iCDECD1Svu
 0XhgnQeDcyfB+e4PWPi77MrzXA/r07/x69Q9tgaN9jwwdCFXXvZWFyrNisztBp0qtx/q
 /0mVWFooyhnc1Q2mo7rd5HKg1lCaczpTfljNRMeIYv8RE/oFhtVmdD72TRDJC2EIcvM2
 W/GUNQEQ0r1Rqq1p3ucv6hrfaWU+DphT6X7e5Wkg07OYAviVTqTmrTyqBpUz6IFAHKsS eQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0b-0011f701.pphosted.com (PPS) with ESMTPS id 3cumpq4ey9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:29:23 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0oQ2fvjEBJQnnq7kmoWLYROPvoueymtnMPIH7Fhqces+ZaSEOu8rLE3JPOg6iDJmzNOqaFBdzUQUPTO0UEqypLH5IICNKaSiH3LEvVQeOfb/qqU6lwzrxadTaYGiJNFjp99xTap+9b2JjFfWnbbE81HTgimdCQFDDJB9vxIf4tNMIXDzVVsetzAIeJUU6TkjekQQ/hQBKFsC6wTcLucwQPKGqUsMk+5X/J/82A/KU+1fbsCvvEgFX9EVk6q+FiNXRZi+kqQ9ayldV66/0A0XrmQ6MuKgFK3/HhS92v017c2IHPlS+UutKEAx3bLfAHYql+Of5VX3aF9F5IM7AoIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC0P5dc22lD94M4kZZY/Xr8HNwEBcS0yXLGTiKEjXuM=;
 b=noujM83kBTZ0WxLfRIYJG+FGZWgQY3dAwkNx/W8LJIotdi6WNWsRWBnorodMlIfFNI32Ui1V2w211yeQ1U9p1OmplDQLj2KBOdgEusghCwsn30C4/zaz1qhs13BWCjixeL6q+CXJZSdQJgirIRrv0IxVwevFFUkbsb32ropL7A51xXqQc2u4ewlp/4lTsxkvcVVILzAxW4fByzUU4AWQuKipYcQMoS3pv1usd4o9VkyP5WCkS7OCLJ/lciMLFQQjH3gpr5Mxhq3tbBneNoZlqQq33shWpwIAyRgkDYbuah78B7SK+x8N1yO5wXa1pZRPkKzzmAFmF9107ycDTC2TKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zebra.com; dmarc=pass action=none header.from=zebra.com;
 dkim=pass header.d=zebra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zebra.onmicrosoft.com;
 s=selector2-zebra-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC0P5dc22lD94M4kZZY/Xr8HNwEBcS0yXLGTiKEjXuM=;
 b=JbiVuqgkLdboBEfkBec7rgwCYehbHsLfufsmEqjt+ZQHERErshYcRuHZzkYInrja57MLrCGFpTL6fE+MduM5TUlP4tjIOUk+lpwlgSftKzfKIw6sLsLxfKcIdtY2uKVpgfpZHcoBj7EfviSsBYeTh0ivd59IJeQ4nQkJU5SvNq8=
Received: from DM6PR03MB4668.namprd03.prod.outlook.com (2603:10b6:5:18c::28)
 by DM6PR03MB3977.namprd03.prod.outlook.com (2603:10b6:5:46::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 19:29:09 +0000
Received: from DM6PR03MB4668.namprd03.prod.outlook.com
 ([fe80::49a0:9cb6:c8aa:bde9]) by DM6PR03MB4668.namprd03.prod.outlook.com
 ([fe80::49a0:9cb6:c8aa:bde9%5]) with mapi id 15.20.4755.024; Fri, 10 Dec 2021
 19:29:08 +0000
From:   Bradley Scott <Bradley.Scott@zebra.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Kailang Yang <kailang@realtek.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bradley Scott <Bradley.Scott@zebra.com>
Subject: [PATCH] ALSA: hda/realtek: Amp init fixup for HP ZBook 15 G6
Date:   Fri, 10 Dec 2021 14:26:12 -0500
Message-Id: <20211210192614.460529-1-Bradley.Scott@zebra.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::18) To DM6PR03MB4668.namprd03.prod.outlook.com
 (2603:10b6:5:18c::28)
MIME-Version: 1.0
Received: from BradsZBook.confuseacat.org (24.212.215.149) by YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 19:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac7a3db2-ec1d-4912-c738-08d9bc135626
X-MS-TrafficTypeDiagnostic: DM6PR03MB3977:EE_
X-Microsoft-Antispam-PRVS: <DM6PR03MB39773F73A8617121B7C2679EEF719@DM6PR03MB3977.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HsDolCRU1lS/zXpeS5i8FnnkhA8ygJUyoiGpxAIMMeJJ3ZZhl6I8JM/QUo00bd8FsLMXidO7L62sq+AGzRu1GQ/004+ZpPF5nEAbVcw0+U8A/CJ1hD/FQY48hXe/DRa/ry0uMejRqxYHIj4sUk3Wdt2wj890QAt0w37ZxGeDQvWl7tcVKPIcZeEXDPvUkbgM/D5ebkfAjhOCzrroipijIj2HeCzBHzTFhLIs1COs/CkViYoQB+n0BDFC1hmF90G56nhQKOXbS7cJF/3yadXaQF/vxNxI7kV/Z2Jkw6vxkjvvRrG5o61T0Tg/b/2Uk6W+PtcJiIc+6pTSltSQDhfw66Zqyh/oV8XhxBDHQm4RK4zeFIaRyVN4lUXBRblqdOmNugE06+m8bWrLaJNx52vacSTl5AMGfxVYQRlwzHljVFK9QKcCRduAiMD2XMKYELtUFn9F383zux8mJXG1EoY05DQ7Btelvf6dSxjlinh4dLv1EmScdSKj1tueMc+SYp1UKc9bom1tpSJC1EtNnG0DuKY9hKSduRlfHsZew9jnCDzC3y0B4U/qxYcUTC5Wvj8jGAedV32kq3XYDQRqcOMXJSbdvuHu72tGJ5IyRUgFZPB7YJLcRv9KK97oFcog9UxfKtWv/Odm1EX1uikd6ITZl+m6RbmD9l2ZzjYiEIovZwTdY1IrpVjiXUC+iKrXrLxC5M6lU3StPwgjbtym8q5SaSjaVIOtOnS2yu0YByhR8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4668.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(1076003)(4326008)(8936002)(316002)(2906002)(6512007)(508600001)(52116002)(5660300002)(186003)(38100700002)(2616005)(6486002)(921005)(6506007)(107886003)(6666004)(26005)(8676002)(956004)(83380400001)(86362001)(66946007)(36756003)(66476007)(66556008)(38350700002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZV5KRmgfLmGzd4oTv9BePBjcBHOW8k3zbQnbiLf9BKp0qutC1xV0XPC9Kjqv?=
 =?us-ascii?Q?Zfo16WuPJ0Zxg+B0P4sqTkfqPf8//u8LX8HXVtRBOCBO46oiQXowu21cunCw?=
 =?us-ascii?Q?Jmc9V/k9xHwpIQl7K1VQGCMGje1fvm5ihpISkAPR+bG55j6sLD1Ob6F7Ksvp?=
 =?us-ascii?Q?3AlaAhDA/UdoKiKker9rP1iwnVUmXpRpTy//JRGKIF41tOeUqcWyPb6DOVqM?=
 =?us-ascii?Q?aUjBf0aC1cusprj3LnV+76F1+Qf+qmkijauZR69WjhHVdULMZllQ8haDeDQw?=
 =?us-ascii?Q?TyLa5WEC/U0yoCPmnn1YML2jklp9mT8KNqyrO+zEzL1j57X6FWpd9fGlX/04?=
 =?us-ascii?Q?yAR+PlTlDuntp6VvSQ6IF7/IAduEcvCvfY3Vafr7lOVK8vXhymhJzHQiWVE8?=
 =?us-ascii?Q?ePTZk8J26TAsRb45hJZMRmS86HXGIozadgn3/nLHwtNC3hGDd1qt0On650a9?=
 =?us-ascii?Q?DKUbKKtKZJ5U9Vzf40+phR4SoM/mSoIF42JNeo6Qej79asHwbma4VFp1g09V?=
 =?us-ascii?Q?4bQJ6m8X/ZtkNt8AyOmESY//9kfYgtS/a8YS06p6jEBLtDLRFGBdOQscmYNq?=
 =?us-ascii?Q?yztD5Wi1cyAD1YEo8PhpsSAW3g9Y1FMAziqaDQoPx6AgrkYPiyhg5UxcOc9i?=
 =?us-ascii?Q?9VnEL7/zJBbgwQbu1JYLFyFeXbC13QDtlkzBkdE384Oh0MBWRK//q6IbzR/j?=
 =?us-ascii?Q?CRtKunfRjmO60642vcTQkWdygbWTpMUtg+dvT/soRomwCEIIXQYnEFnx4KLH?=
 =?us-ascii?Q?UwNQhbn8Y/k+NaIc4kZlw6R8bx2u9jENfuUHKTSLJsAevA6a/Birn7TGO/Of?=
 =?us-ascii?Q?Q56qtFwMq7Htbk0fh9Mev4UiJCFBZ08idBa2kPICIeaZONxowIC1HTgPTdU2?=
 =?us-ascii?Q?D5BK2y8nj7rvT6cczjRJceMk7LezfqoqsN9oxlqTvKREdFSOIiYkssw1jyuG?=
 =?us-ascii?Q?7fjaWQlMl+nM3//Ejf8aLEVo5AGVK2UAPGgwPXLTusYclz92JVEYPlccWvxg?=
 =?us-ascii?Q?Yax0cpJRPLpN8C/6dAa94ZuK4o9vA/FwhsNiScjkLIAFObesO4nwsb1dSCZT?=
 =?us-ascii?Q?TmIGDhVGt/qkk0P2Mm+7YovqysB0ls5wJclPdp7PNN9RkdaTNsWJzA5im0L0?=
 =?us-ascii?Q?TsEWTQchIE+gIFgi3e0RhLS1IghxWSbBi4MJeMEYwo2yUj8zwLXjHMl6COT3?=
 =?us-ascii?Q?gI6soUHjBhNq1aU4hrZlSEGKv20CMzJggqHnSR+YoJMvZKVCRXT+5yFRYzyQ?=
 =?us-ascii?Q?fp2elbITxbJ1mPcp3gCnuM+rgDFM6GbmuyrjRCS9OBLV14z2Munh0PhzKvrx?=
 =?us-ascii?Q?aAU0XO2H5/yRm2AIwuPOFFexKSrw3uQZ8j4PI1mTYwUyjRysF9xdUKdKwbVE?=
 =?us-ascii?Q?5fDy6BK9n9lTiMnC/1ULGhjxLX/tGJ1vzq8TkwnXK9B3Mg5jqheUDH+k7FIc?=
 =?us-ascii?Q?Kyem/4N5fSpqItPiBsCn7l+oeuslFix7+r6ki21AoIkX+oDSAuiN/X2tMEzG?=
 =?us-ascii?Q?IEtnkXi7bGq5SfkCDyL2CCQZTJpNKXFScjNGG6UfcrpoOEm1S4DKC89qMmvY?=
 =?us-ascii?Q?dzuCJMmE0pGHUN9wOxEkvwhRhK9+t/3z9M3wBEDsaT+Onr2aDhlaH8arIJ6g?=
 =?us-ascii?Q?iqASZMoaDfmTzuddkCjAXSc=3D?=
X-OriginatorOrg: zebra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7a3db2-ec1d-4912-c738-08d9bc135626
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4668.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 19:29:08.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d3d260a-9c40-4306-8dac-0d64717039ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yve5TXHSqMYZ9RHZtFhJ3DzkifdmLAchPKDhQsRWI9gKyQGyxr3Kub7byESzNFd4N5ZRgQ+6AaceiSEs+pctOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3977
X-Proofpoint-ORIG-GUID: Zk8yBOxy_VIvnPFllO0Td1ztlm30sMpn
X-Proofpoint-GUID: Zk8yBOxy_VIvnPFllO0Td1ztlm30sMpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP ZBook 15 G6 (SSID 103c:860f) needs the same speaker amplifier
initialization as used on several other HP laptops using ALC285.

This commit also adds a new "alc285-hp-amp-init" model that can be used
to apply this same amp init fixup to other devices by passing
"hda_model=3Dalc285-hp-amp-init" to the snd-sof-intel-hda-common module or
"model=3Dalc285-hp-amp-init" to the snd-hda-intel module, depending on
which is being used.

Signed-off-by: Bradley Scott <Bradley.Scott@zebra.com>
---
 Documentation/sound/hd-audio/models.rst | 2 ++
 sound/pci/hda/patch_realtek.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/=
hd-audio/models.rst
index 0ea967d34583..d25335993e55 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -326,6 +326,8 @@ usi-headset
     Headset support on USI machines
 dual-codecs
     Lenovo laptops with dual codecs
+alc285-hp-amp-init
+    HP laptops which require speaker amplifier initialization (ALC285)

 ALC680
 =3D=3D=3D=3D=3D=3D
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3599f4c85ebf..fc41f3e8ddc3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8660,6 +8660,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
        SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_=
OMEN),
        SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUT=
E_LED_MIC3),
        SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_F=
IXUP_HP_SPECTRE_X360),
+       SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPI=
O_AMP_INIT),
        SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP=
_HP_GPIO_AMP_INIT),
        SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
        SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENV=
Y_GPIO),
@@ -9123,6 +9124,7 @@ static const struct hda_model_fixup alc269_fixup_mode=
ls[] =3D {
        {.id =3D ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name =3D "alc287-ideap=
ad-bass-spk-amp"},
        {.id =3D ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name =3D "alc623-l=
enovo-thinkstation-p340"},
        {.id =3D ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name =3D "alc255-ace=
r-headphone-and-mic"},
+       {.id =3D ALC285_FIXUP_HP_GPIO_AMP_INIT, .name =3D "alc285-hp-amp-in=
it"},
        {}
 };
 #define ALC225_STANDARD_PINS \
--
2.25.1



________________________________
- CONFIDENTIAL-

This email and any files transmitted with it are confidential, and may also=
 be legally privileged. If you are not the intended recipient, you may not =
review, use, copy, or distribute this message. If you receive this email in=
 error, please notify the sender immediately by reply email and then delete=
 this email.
