Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8581A57F14C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiGWUXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGWUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:23:05 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10C1A80B;
        Sat, 23 Jul 2022 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658607784; x=1690143784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bUIWPJjjtutwmlLptGTy8isQKjwjVdkURvLKvmshhlA=;
  b=h4jXvP8FzsTTU2h4BXHs2UNSZq+wGMr0k3z6Qfc+Aer7lvwV89pPbLTZ
   VCALcAS/6iXmUf5nn2qcC5d9PpWv2Pk8qesIJA7eIPzVhFTkDphuS4w7U
   AulSarNarclpg4FASlegY7MsmLVN5vKia3wOJz7p5k+X2SXEuVWKc7GeW
   LYBKkDrK+ndE5ZOPli7eakWRdPf3a0zwQS2tOsaLwgfCAsPkXwoAyjrF/
   VlwS/D5QA6uURvg6yOydy0NEXIBki/O+ItPWzon14U31k2sEq2HMBXR0Q
   YlR9oz3sqDyzP1lFEdLXYScXyXCSY8fSGlMcG1RI5x2Vdb5+g72zouv44
   A==;
X-IronPort-AV: E=Sophos;i="5.93,189,1654531200"; 
   d="scan'208";a="205292555"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2022 04:23:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIOTtsQbOpKCcevI2GNtdusqJbvtqiFrJPYD68OskP9bMoO3XPdoPHpfl7qjtEA8IlsBU85FBzNkbZSTaNxW5izezDk8k7BpJ7DR8OjDCueDn4Mf+vnhPYaj96Im/Wm6jIkLOqcN0tTP4SAJIDYG+Z+tjSgcAcO2OT8K1JKpRfFxXrAcjMcza4IaxXREvEPQEgwfCej6b1a/BUKxaiDy0ECvj+Rh6ahOl9nV/D1ESCsJditWtJGQZwzmYxm6D8LOTxciuKWM+/xiQD013FOjNpZHJNqNkqpVKVP+cjs+nRAUBMy+lcYxc2Y06fDFaf+gcJlyadtUlzE0zhZ/60nUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/BbpmiTjHnHu97xNL1wM7rVAUbxQ1S2z/9MHxbY010=;
 b=XtCeHV5LCibgXAZ5L6wO6nOt7vIPOKK1/yqNwR2UZvQkTbBulxU/w0lewYJ+VFgkmf0SNYgILmRYUYWif3UIyCQqkBCp0/XJK2trrRkOgQkBPzx1lbVxbKMmqdwsrOAxYLOLRCDCVGgTS8UkUYotlHE+xt6of2jCr9zxfIMX2eEmaEdrvKBBPRRRty/1xEVsDCkIU1d1fb2EGAqRy7N3Qb9jBbz3tBBc4smB6bhlzM6ufFRG7fUPByrRhum5d3U2KtZNkTkkRHb/IWpEnf91AJhDkpUrhusdEbpt8++HDnhPSdiTH+eReI1MpiLaWg5h/vGsu0uvPbGNkDspzXWsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/BbpmiTjHnHu97xNL1wM7rVAUbxQ1S2z/9MHxbY010=;
 b=EiLYwAvqPCIrd6bFQiRm1bL209reCqiD8fRKUDzPvvxhqqbijiRWBPHIS2VcxWY03IKV/nzE8zI5wzKLG8rDfhTd7oc2R9FTi1WKWW8SjFmFcH3ISvK1w27fpTXJvH6RpradFm6VPaaS8oYUdcFpKn5RL1fyLcDBGKabZX8Kfxg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR04MB0447.namprd04.prod.outlook.com (2603:10b6:300:75::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Sat, 23 Jul 2022 20:22:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 20:22:59 +0000
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
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2MbQiA
Date:   Sat, 23 Jul 2022 20:22:58 +0000
Message-ID: <DM6PR04MB65756C2EF5D9F23B5EC9E3A7FC939@DM6PR04MB6575.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: f23de97f-5d0b-481c-2c70-08da6ce9229e
x-ms-traffictypediagnostic: MWHPR04MB0447:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9dh2zx23lh9sy6+f87UFWBeoDU+akWqDiDtqJGlnjtsIOaXEiiXkqPE3yEE5oI6qdqkyR1gU/xrfIZWfUrpEQSYu8w1Dnn2zGXf5jglsb5lCprxB3fx0GAzDZt60xae58aZSmbr7UQhOffGRpUYfKh1NwV+XpRLEUnzVzZpMLGWLJ8Cwpz2of7q6k3T2/YyqkrFP0ZMVq93/PvwsDP2W8+o+g2hdbH0ynkczqne/M6JQtWf5g+Rtc4v2fZ3WcJuJS2ExPlPAmNsFRMQQGegi73ueZsprkdo8FSG5Ndi98TShHE+0bUvdvfKGIhtc4ep3LwgCbGMlsO1z2cAm0YpGXzlHTK9V8XOoxt5eUrRpenGsymBxBEpmW9jUNf3drQreZDj139RxFsCDYwi5OcPmHVsPjYnOwoiejciZUvKkdmcbLlk9kxezpqMYtEjp9rysCR2CkeB1t9DCNkf4tEr+MmXY2Uv3pTE/IphhncXHEo2KLAXOen2HdXUwFWxcCAjSyMwQzXVbuM+zigpExnJP/00E8Z7qPlXPe7UfVzo3v9xbPghuDvBRhHkjFRDWCQhnxepbtj1OXRH8y0vMVu4hQgMcqR11Ru1KB/8C13PaE23QMyJC9EdMSvSSb/LA/oB4HuePMM2B94ts+hhaKewDPCGnl3JgPjNIdcx7nEgLrWtfPYt+AzpYN0Z0tOchHUM74VqTkyBtHd13WBFIfPwqC8OymNzzqPXurcnuMFQtf94jArKCIMY+UkopVJSbgUVeNhyMj/yTwGAob+KGmGcuZLrcfeh5gPBHoB3KoGFM7OI2Hp55UbykGC0XJbHX30XVGZXqZ63VNviBsifnjjqdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(186003)(55016003)(8676002)(71200400001)(4326008)(76116006)(66946007)(54906003)(66556008)(66446008)(64756008)(66476007)(110136005)(9686003)(41300700001)(7696005)(6506007)(26005)(2906002)(33656002)(38070700005)(86362001)(921005)(38100700002)(122000001)(8936002)(5660300002)(7416002)(4744005)(316002)(82960400001)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pft6JTTsGepDZOjxbBpbt8p0r7pW1x2rEZFyIZym+W+r7Kk4v5p8zxZOAZPR?=
 =?us-ascii?Q?mORQFZovBaad4E5lFZLIaovj7uK6swoRChfu62SQ6Q5e68qWI52/FIqAMppP?=
 =?us-ascii?Q?eV80P1EfcOAktUp8ZaYVb7xmaOm6pRSdFerpi5lQYHuN3fvFWM4mnSoNUgC9?=
 =?us-ascii?Q?8ZT900Bpc54RD+ldma1NQQkACWGkiColW9L1dEUqtn+01jxj7JVpwZsA956/?=
 =?us-ascii?Q?yNhjNfg38+p4IKgD1E2PEIrgFB/RlS20UUGO8i+9Q+0Eo9vvVQ/4NKJHajh5?=
 =?us-ascii?Q?kOrYaNvTe5s2yXnsRDzhRwBHMMCz5z4NxyM/2zPmNdH1rV/FGZY//6+d3hWz?=
 =?us-ascii?Q?XFaOWfLk9edLgtRLZ9YOlUhZWw3TCJkKp/NqfZyZJrEpeYgtA9nN+aVICx3q?=
 =?us-ascii?Q?NJHRWBBj+JUfKJuHtqM3Nv1nGgHU6d1aSf7qXIBMJNTjU3fhik2RFL1Qa3Am?=
 =?us-ascii?Q?30/ndRIy4t9hzBgze4BdeFZB/bzXUokCie/PWldtQZjFZ4gw+ZgreR3GZSE8?=
 =?us-ascii?Q?ntBzm3h37L00U0Ik8WYPIcP/49vAudQ7Aqa0YV5B/gKcgKSNp6T9Y2YoAxfs?=
 =?us-ascii?Q?ovRp6RYWQFgX4ElcjvOcEVmaaFJ37DwpR7snpamW7M7jWLNaTzaQuSM394Eb?=
 =?us-ascii?Q?iPvRKI2faN2TJrCERRglTkzySDZNfXRuVWcu6CqSChggoosZo39KKGnBvbvI?=
 =?us-ascii?Q?U+QiqyGGmAZ9Er/8KRC7VBPj8x4eQrXmGROkETzpYCxY45d3j1YyPZBbhmRE?=
 =?us-ascii?Q?DHGnGQy1Cmiwp3U2/bwDzqmrQTDssPuGQBqB34iC/5zN/6lDNZHU/2OGk2vm?=
 =?us-ascii?Q?VxZcElZXsSZE7gUZ2mWeDTjhi18CnUcg3D9MJh4OzTiGySIiHICfYRc/JPqr?=
 =?us-ascii?Q?TjI5Im3/vyG1/t9u5V3z7WUgSizo97bTgNzkPhaoXNlAjte5lcscEvnpLqN+?=
 =?us-ascii?Q?s0xYFfB75APDeQI9GH0DtcoXmcSQ218qvJjMJJdizIHcAkearTlo51857znB?=
 =?us-ascii?Q?3+VWnDVBoWHbkBwnw1pyWBOBvRwZxJd3VnSBsb9o1H7OJT1G5fFSgpOxPkJf?=
 =?us-ascii?Q?XnBrUTB4N35HmRYGxRl3HWMvueDJ7GjFusx7r4Wu2NzrtehlOc6m8j6F2Scs?=
 =?us-ascii?Q?q1tfAtAL/0W25S13ANQtEEQQsE2sL7ZlL92KI6qEp5nHtDukTcYLbhVHbwZG?=
 =?us-ascii?Q?V4gn8ltPIHCfwREIIfZqCx+/kXoOpRqHirwu32kbafDn+2j0O6sYK0OO2rHW?=
 =?us-ascii?Q?H+mUhD1UaQDGDXcpPGLV3T1ncrdZHCt0WonyM0olvfYjvfa7w0/egFwPtVzh?=
 =?us-ascii?Q?xFIm1RaQrX+d/59zpOvi96T2FHCDjV8lXAkKCkn8/i0JTD8mQalXQpUlA8jA?=
 =?us-ascii?Q?HuEDz1myDWy1wFv1AmPKi5szbhR8ieLaFw0F3eARKVdJ6nHOvVJ2iOZOG96y?=
 =?us-ascii?Q?pd5WpcRI2KwJmV4HWhxOI3JpzstpuvdHJUCXsX32uLbfQ3jW6BQV3c6cOWjk?=
 =?us-ascii?Q?6RmaYE42RJjAUfvbKpP3/4h4J+FhyOP3yNZE2+9WxCnAxTQK+9wKqbvDy3fb?=
 =?us-ascii?Q?luJy1B9ggg7I3yVVr1fPZJZH1zpIGtxWWvQKH+FS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23de97f-5d0b-481c-2c70-08da6ce9229e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2022 20:22:58.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzLpqiJs96vMaNrsnMD1m218A2vPMfzN5CR11nEoU5yLlKxbgiYIpO9mcYUvyVscmG2tn4cQCJsw7SJzSSYU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0447
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void ufshcd_host_memory_configure(struct ufs_hba *hba)
> +static int ufshcd_host_memory_configure(struct ufs_hba *hba)
>  {
>         struct utp_transfer_req_desc *utrdlp;
>         dma_addr_t cmd_desc_dma_addr;
> @@ -3721,6 +3764,9 @@ static void ufshcd_host_memory_configure(struct
> ufs_hba *hba)
>         int cmd_desc_size;
>         int i;
>=20
> +       if (is_mcq_enabled(hba))
> +               return ufshcd_mcq_memory_configure(hba);
> +
>         utrdlp =3D hba->utrdl_base_addr;
>=20
>         response_offset =3D
> @@ -3759,6 +3805,8 @@ static void ufshcd_host_memory_configure(struct
> ufs_hba *hba)
>=20
>                 ufshcd_init_lrb(hba, &hba->lrb[i], i);
If is_mcq_enabled, do you still call ufshcd_init_lrb?

Thanks,
Avri

>         }
