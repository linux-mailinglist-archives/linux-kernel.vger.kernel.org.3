Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F092757F3A7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiGXHVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiGXHVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:21:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4813DFD;
        Sun, 24 Jul 2022 00:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658647308; x=1690183308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AQLI9sRjgsYJ2CHlvk3Z4IWIdGFTs6bWtXc2OnpIGAU=;
  b=p7Hxw3Nsr1+SDtu1e3296YoITrOqHSIBO36FVni00Jj+fbnK9M61OiRQ
   QcGEqO8qor+DW87HJVR4mHb77/fR9kZCuL5cGtNZ/CYkX5zXKdwc1Xcif
   RBgw4oT7kEt05xwtZzibp9SP+sMi7WDuCU9/UN0lvRi0TslgkPMflXl50
   VEHC9W9pGOp8lfx4h6NLsRNM5J5ChDzKY5SrVaZg9/XLMjMW0Z0Wb7zoc
   9JtEAz8P05c/98LlAkU0aqT4M8ZSMTa5Z45fjlGmtdnNfTfHG/uYgU+15
   j5B+UR+5MQ52onMWzKdaH1rP7nPAdUGi0YmpERV9VaxQji5FWnU/z0o2x
   g==;
X-IronPort-AV: E=Sophos;i="5.93,190,1654531200"; 
   d="scan'208";a="311072269"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2022 15:21:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKpwLp3L6DSp8L/PKeFQhG6AUHyxwIuFV/R4/wLD+SPKDrKtb8s1aAm2+q+6JRMsP73ndcsj5+6tzkyAkTgTWjTqwK8JgP+5FOzoCBlDtF6AGWW/cJLi2nvbYaBqNxkcVXiXbWfn1ufZgSYcckMWScFK5lWtXrS0sGqusrEJbt+1CLL9T68giXKlrZpT8lP1kFdX07xTHPRsBpjKSBfDS//pMrJlNit1NDHLTIoGnJXHxD3enoYTqd52QbqXN03Avd/WVB+5I+Xh6td7PNH0Wk/G+rTQc3JjLwldxBSnIi/GgsiNRxt1Ch8/vghB4ChElXN8L3II2z6Tl8uJRo6HoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew6nCoCyUD29dhCsEp6IDjJtwOMSb/3wex767WisFEY=;
 b=BuMZLXTKDW6WzMO/Ky6VlhAO/4EmzVG0VEflbjoBBTUiQ9K1k2xUL+KFomKqNPGB0Mdam2Do9ZENYv4V33WhQ8EsR6Jk1wvz7aAXNesBlzKBt7jjEhAAUUbwc1yYvzL0FSzQaXjOPdgRSdezoIEE2I8Uk1Y4z0gr9R6D0ODtmyTMH29xndEOsGTO/OleYTFIFQ/vZSvxkvuRaz0wv0XTITYkpfzqO90XSbLPrldAp4VD5clLaUTvBIM7BArqIYXDaNw1mJm2qu7nSlz257Wd+/PX65sS3i6UsywMYErHiyMLAJ2dGz2tkVikGzUHvCkmyKwWr/BtDZD1fZMZq5mj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew6nCoCyUD29dhCsEp6IDjJtwOMSb/3wex767WisFEY=;
 b=BEwQoM0p5uWk0CFQV5BXIgLc6QHySjKvzXBe+GbByjJSgD+ufPpBa85lZfXjQkQgDMOu9VWsjIRiGx+tG2LJgw1ubevsMjsGf9OMP3kef0XPeW3PzAJ0FxAGuC9RtA/YXm36pWkWVJIHYxZOjCWEi1cfEkxr83nQ9s97o/6SfDQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6132.namprd04.prod.outlook.com (2603:10b6:408:4d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Sun, 24 Jul 2022 07:21:42 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 07:21:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2NJGBA
Date:   Sun, 24 Jul 2022 07:21:42 +0000
Message-ID: <DM6PR04MB65759EE596FA294BA8A9215EFC929@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 221a3bf9-4852-44ab-7c57-08da6d452871
x-ms-traffictypediagnostic: BN8PR04MB6132:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kgW2lY9c4Mr83RfByNlBNljJ2FWZaUGQer4K8WK7XRQUpvJqarCZYQPhLxesc1KRAUvIBkh175nsAEwtVF1xM8fgH2TkiVqQ7c5F51XSfm6n1EULSuyaLLwgHAPk5n6rdr/J5D9Xa/xlFXDxu0rNpExKU3F/eWk2YcMepUc/2g4hfyLZvw405uxX/AL70fUknu3f/XPtRCk6NmLHnEyATMfNzh8iTmphFCZV912jpGqRxatwd/+v5GPaw3q4og2rHROzF5zE1a+7ExlTmII8d0lVgdxiN6UXie3elmoXG1LJU+qMO8AbllBPWR+BP/6cUsJFqLuI/wBt4oCtA1TN6nYmE2FZdt6/HbU6Z4K0pIJDR4O/7bwKjkubXdqywhvo63zxfPQtNOUkZwk5bf1D1+Dg3Uj15upjiW++4aEqITOraODt/LwYscHmWJ4EAsTRH8ZxhNQqaDsDRzZB/Hxr35Ysh35DEFlkoAPnc11f2ZqTPGo7WEvQz/9r5aCJ10tZnbiFPBunQj+HHRtnkaX10V9Y1pThhh+Kqw4EOtgqpiY7SqanVyBu3fDkF+8iLX8amPQtxNb7i+JifIkdFpfFJz40dUeJCVBflwYGPkIwH0so8zDVChkBiCkpglbd38PCc0fvdgHAgdQI23yKRlVh7TDf2PUvp4NSNBbZ/b+A+wOOR1DhDE8PvwXi+1bAXg2d9l/vXkSwp13rbrn1K74EplLQlSMVa8NSw1ep6kwe2R4Z7GsZ+dc0/otMMx5x/7WG3FaJJU6IaammIS36IG7htbCwhv5R+LDlgKPpJrKki3YUvFHvoimR1OjA4x0gj+KmV8VgjLo6nGGT3l4yOIKWpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(38100700002)(54906003)(122000001)(921005)(316002)(71200400001)(110136005)(38070700005)(8676002)(82960400001)(64756008)(66476007)(4326008)(66446008)(66556008)(76116006)(55016003)(186003)(2906002)(41300700001)(33656002)(7696005)(86362001)(6506007)(66946007)(478600001)(5660300002)(7416002)(4744005)(9686003)(8936002)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pEtz/QyO5O/lhClxaIaamou58ospvlUMV3hMZZO2dWr5ZSvO8IbOnig8m+1m?=
 =?us-ascii?Q?RGAR7prJDBPfCQ7e1KO1+0wtiy4/MjIgouWOxzUb+LSWTu9ZOfFB2cCdFTGZ?=
 =?us-ascii?Q?opQxZO5MIVOtfEOBKPtiB98ekHAU256d2f57GpEcJ+kGaGIX7vVLMj+U1nKF?=
 =?us-ascii?Q?w0h/rKTltsqTIBX3s6lN9PcuVYbR7mHCvcSyHJ9RsHVAm54QND8hHZJjeTv+?=
 =?us-ascii?Q?7bcX8odPbhXq18t2qlnLRZMsH6V992pCOeNNsd2bjyR10mGAt+tW5DnKqXat?=
 =?us-ascii?Q?ChXj3IKwqs21CMtSPk9CGN7unnDPXg7fUnt8XjUWqBcehfTzO2Qmr2QBMwua?=
 =?us-ascii?Q?TdubWPqEgCYcdqoo6jtIVI+enZWNMTfm3jqjU1c2/LUJYrNHqFJNmeksOuxH?=
 =?us-ascii?Q?745ykvLVcot4oNhJd0NMppS+gAWsu4MBesOE7UMaW0S+lmyFS0g3K0jKo/T+?=
 =?us-ascii?Q?nF8UjSJlrdvT/JvQSNxVGE4v6ktCefCXxdPAc78jeaK9QG9axahdpkZvizIk?=
 =?us-ascii?Q?H9EDi4b66+Ql4948RGjpKGFxUOdHJJ46GUIAhP5pQiMcpeOF7qHoWazaeV31?=
 =?us-ascii?Q?Rq6V+cSH14TwNkEiSgbnpVRr3hLYYAV9aYsj2qs8RlstaS2aUlNDi2kKAawa?=
 =?us-ascii?Q?F4xPcDqocdQi/hhf6rtLrtFv7IkcDWijftSfSqPdOFPmb2vACcwRSSN9JNlC?=
 =?us-ascii?Q?Ae2gECqWqfkKJnen9dv/qSqvo9Aurr79wNECDkZRQXwgb5YD90gdFS8P76gQ?=
 =?us-ascii?Q?LJOtv47Z/UMPnreNCt5oKI+0kQZ3t0vga1ZhcOZBAeI2JNqN5lbKgLqN/+II?=
 =?us-ascii?Q?IoA8aoFcPWQtwkIBP2BIqq8eNgVxslvddYh6p4GXj/osItnN2NtSjG2gWivv?=
 =?us-ascii?Q?Ry7T0vvOhDhTXFvF1Y8OVxbK79oK2ylsq1dmaevfU9sx80UI8BYaPPCu71pf?=
 =?us-ascii?Q?5uw5l+T8lE+qx+jjEZx80aeKbXJq0H+o4jGr4H3iDmQeGs8jU/FPvmF6Kd61?=
 =?us-ascii?Q?Kqr0onoRQSPKy/vA2u404JNKDM1eZl1Y4VDzr+it1dV8ZtrzFi8QSGBddoEn?=
 =?us-ascii?Q?txulIS2Ce2soY0uPOyXT7F8kZhQ7fYuo2dBSXutxj9YnDdj0749UklG2zfiw?=
 =?us-ascii?Q?OJX3EPi9CYam2z72iV/ABMWGHfyQnFRnnt/QtrAELT6FiFxOHORI1/iUlX9p?=
 =?us-ascii?Q?9ImvIC4L91BQLu96U2dCryEvHI1bIHcSlD6zBRWLrrOWB6CyYIbcFHWNnWVh?=
 =?us-ascii?Q?KziaKbFWoszzHehmQKS4OWS0ja8P0BziH8c8sBIwh1WNAnM19NWnK5wXBl5V?=
 =?us-ascii?Q?NVOun8QlIZt4SMqrbAD+/ujpp6VXp0BQ2ksT1AvkR8XWG5yhu1M9eg6Mpf/B?=
 =?us-ascii?Q?N2XUPla7Qum3+x6/XgPeN45dPnGx0TTMtK4TGACV/4XAz809AC0LhTJamB+U?=
 =?us-ascii?Q?07xESd6+n68RKOIHIbKP/X1m/59D53MXhzD6HhptTuwhKjSX1DOplOTqMjdb?=
 =?us-ascii?Q?xzUf4ASs7EdYQVv78GBn0JhBOAMepLsx9x6hJD08cINoPmDFLy78nFbhC81x?=
 =?us-ascii?Q?UkdApyHIE4oJ4K9Butkr2AOFjJKSBI5FO1df27lx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221a3bf9-4852-44ab-7c57-08da6d452871
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 07:21:42.4731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GP32+7GPVRgCYCgZXAsvQjpWQDGfxQEyemG3v2IoKkmwWMzj0bEdffqFq4ASoVErngcu3Du4xkpAldPy/hxLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6132
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void ufshcd_mcq_config_mac(struct ufs_hba *hba)
> +{
> +       u32 val =3D ufshcd_readl(hba, REG_UFS_MCQ_CFG);
> +
> +       val &=3D ~MCQ_CFG_MAC_MASK;
> +       val |=3D hba->dev_info.bqueuedepth << MCQ_CFG_MAC_OFFSET;
> +       ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
Arbitration scheme is something that I would expect to be configurable.
Or at least, add a comment explicitly saying that you choose a round-robin =
arbitration scheme.

Thanks,
Avri
