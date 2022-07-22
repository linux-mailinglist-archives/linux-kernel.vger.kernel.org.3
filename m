Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD957E32C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiGVOmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiGVOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:42:30 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE4313A5;
        Fri, 22 Jul 2022 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658500946; x=1690036946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ilviaOvklFwTKBFN8iWNcUxStrx434S9g548fZbd/ws=;
  b=CN0OeacihQwkFo3uDfcJX92IsBjcBpJBabUCeSmNT5ZlXftwMUbfkXJg
   wE+DeB+bS0ietl40hNd6yQOUSInG8vcUojzpnFXL4m9ku7ixOfUf/wbio
   84aQhHPZKYqe5FNr8AXzT/53Z1DYi1iU+7kOKWSOqlIf7usKVB11lzdQJ
   3O5G7g/lD9hEoLRItsoP4VfW6E5cQMKJ0SZfZEgEHO+cKavhN2ZC/f76Y
   Q0uHLjGrxidRrZcrR0CNjhDjGOwz2DgCD6m6qRa3mIIvYe8mfO77poNvk
   RCIBQ8pGqxYGKzupgaWi+GoTzU1PDtp8l/LxeJOCEfO6EI93a6NXDEXtu
   A==;
X-IronPort-AV: E=Sophos;i="5.93,186,1654531200"; 
   d="scan'208";a="211602933"
Received: from mail-dm6nam04lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 22:42:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiVCt9SfQqQCXVkVwA4E0jZe717tsMNG79JKu4QdC16YHQma3DlwDyDptNJE9wXdkuHUXtA6Yar+4P422dOtOg9xkSZ9ARp9FqB7Vj6QRPqBwD752IhhShD33pS0ImzfYiYzBy0+1bb4+myDdaILcwsDcqzB4RXwwcNntf81ZAePQvCpfWq0LjJ68ENbSQK87GF37p3HW/StHghPcxi/NU1qBxd65Itw2iC1hdFKarDRgK+KbGjyMQQeb/YSgdIWyV7dIlx9d+92Dy9VgLukATJ+9cnsekDA16g59zbT0NCiBcBXrXkI5DOUUavYXYyGArm4lk3VteH2YvdRUo6z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKSCNlUYiSf7ASDkWREqkDy4zxSmTNaXhaHUaBN88iY=;
 b=Oq00xW92hVMBf3C7Ok6Jl8E7yl031zmRephGBrJJt3EJHPgFhM3DMOVjbDT5s3mavdrBoxfQpsgCtqLuzJe14hMu+zoRNc7XL3rVd9STP1l0PgaK2wiQekJg+W9AX/DR4YC3cRC9O3zr1Mtf3NG4orADbBMFtHWNW1tGcUWVvhpy0n/HEtSt+w5dsj99V7dt6JTRRtdsZY5jxtd7SEa4MbxNsHyXH546faVG2El3SzuGUllBbB2xMl0GYhDMdM1psozyJSOZYqhtiv2fniwrK6mgYq8EULl4XCMZOWoyKnglE1f33VK5fOAtohg2cn1hDPyknTLqJzHlUUWwSgTHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKSCNlUYiSf7ASDkWREqkDy4zxSmTNaXhaHUaBN88iY=;
 b=J5i9PBFMl0LK8Qaupf31u7K1XFfCc6dCY39SSbNKEckOpkf/yHOTj4caUj46LxKtx8JFKRWxkpTD0Mm+W7iitMqqC5zeBdKadnue7trk4oybGAGyagzTB0fE+A5tqOtLyWSG5axxW3qmhJ45dVZwdX1D6Qz5KczFl/bVgR4tuYI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB1082.namprd04.prod.outlook.com (2603:10b6:4:44::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Fri, 22 Jul 2022 14:42:24 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 14:42:24 +0000
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
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2Ke1zw
Date:   Fri, 22 Jul 2022 14:42:23 +0000
Message-ID: <DM6PR04MB6575D84FB380A844DEA7CC3CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 8b4426eb-72c3-43e9-4a77-08da6bf063f8
x-ms-traffictypediagnostic: DM5PR04MB1082:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUyz8VjHwehUymGMy+nRUw1qlRBPLonF6/hpwwG9sy2ATiYWu4njIe8NgWk6Py4fp7BlspBJjX7eaUWPVQUbpvElpgmdpGAGyGyxR6xWzR/XpWvnJ9vXuyq+DyTOlElEGV5iNz3fL/lFc96DCNL1eVZXIJz1kMTZI9sQgMkPmXK5fIcoKltVNwRgmLgEgviQIf2hulYUIWReYc24czEKvQgX1kMZidyQHJE59ZgJDK5RP17fUHEiCJX2ueyiW6qGjpeRDwiuwqYcpJ4/BuCLheVMgNfE3SQ9av+2do+7cseEDCNKH/IlMrzRwb1mv0j3qdFlr+GtP+KcU5nHxzj4rUGEK/rgU4KAGL+3Vqt5ckkjoKEINTZKFQuMhu8zAX75a20odhKh3zCS0Art2AE+5l+6pZUE6oRQObthMSA17jUXQ5ZXPW7rT4a5B20Be9JTFISzzZhpfJgjcQ76UEwOdWUUqZzQ0ZcJ8klDrOdAzQmwBM0Z2xYxi3pjF2vzj++UYrZl0HhUdIbtsocZ185vMGm3GFfBC/vPZL5yZkGfcZ3AUVNQk29KVJmVrV94evgqLu67hez3IRdw3exm6XkK2Xs7pHiq07gtUSkIziPI5Safyh5wd0b2i/QvmKcaIuyklAcNIQ16B263PGNrITiryFzXi2AOxcP5DP/nYioAhO2h3D9fm5nzBu122XD6b5bT4zBrE/rwSfd8bKloBzSt+SGVD5yjzdG5kkgpSdehXBkEYxFjUg7tYdQCzqEe0wG1lbdWzQmX8uPoE50ALa/wlWz7CWnqXKIB8OLCS7pZMupVvObZWEEwIrOMIWYKLF1P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(33656002)(66446008)(4326008)(316002)(38100700002)(2906002)(8936002)(7416002)(6506007)(64756008)(66476007)(8676002)(921005)(66946007)(52536014)(71200400001)(110136005)(76116006)(38070700005)(66556008)(7696005)(82960400001)(55016003)(26005)(9686003)(186003)(122000001)(4744005)(54906003)(478600001)(86362001)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?66nEkFsFHv+SpVyL7gq+nWp56d5A4qsqlegWFvuRTkdH9gZ21tAeRRcQMSFt?=
 =?us-ascii?Q?dFZpPjSzoYutAl2TOToWfv4LFVAxVpXSON27//ITYfccpJCX8yFwehW5D140?=
 =?us-ascii?Q?B+G+328EUA+8dFiibF+Qu8aOZ4GkuHN6nmEzFhfyp2p9HlnfMrDfDDPVfmBz?=
 =?us-ascii?Q?wCbWxyjnwXBkRkDEHRX+v1IW54Fvp15nR7ZCTgfmJvR8i+O6TTYvrXQjEKFt?=
 =?us-ascii?Q?itSJRA5tJxIrNdpLiDvPUHfOqfKEjm2kXndcZKOgiOO9vwGBCKjFl8vYTm67?=
 =?us-ascii?Q?zLGaozqeTCJXSBDvS5zBEA/SzAi5DfeGwQ72Xb0eqqjov5uH7tqb8kapSqal?=
 =?us-ascii?Q?pfbb87YXaUqFywdC62XTdkxIDnhhrBuW9+QEJEgET+U30OAvlAawQfh4TuG7?=
 =?us-ascii?Q?OmGbPf0qggbBklALjjSZ7sVwNhy7FLKB9+lxiWB3tB4jsFeSlFm3098O2x6I?=
 =?us-ascii?Q?ZPJ5sLZ3l7c9bT6brO32kUM6Rl6a81AIV/bbpPyauxtgYIo2hQRjJV2TZl8T?=
 =?us-ascii?Q?pKIVfqtRC43wjtOZ4q31TXrQZp1Wytbj8Zz/6yRuVo/TqkyCclJrWrhqL4IO?=
 =?us-ascii?Q?UhHy7XbVHR1mRdfbK/0pxSxkmIQ4shA4lCDwgsbKL4MkyuClGwdRUL2k0+VX?=
 =?us-ascii?Q?g06CIfNDeENiCPzGGTwWxM8wc4jnk3JTHqyEtl9Nnr0lQxNaC9dca4Pqbbo2?=
 =?us-ascii?Q?9ucRto6PMH3uCPQef8KjIBXHrhT7E9QT4ndvpCHbUupsuL0wJMRb38BTh8/N?=
 =?us-ascii?Q?3aqrBzCxaRBkrj0LRod3Z7n4G912bwNOpKaGg7dpJs20jRaHE/d3DdYDigMD?=
 =?us-ascii?Q?yq1ZeVyz007cRThAVzOO+Tl0UJhadLcgbK0r9TpZd2JWyz2Skmy7lvxusA/k?=
 =?us-ascii?Q?M2HfDhmCnBOJD3UReZsL99PSwD0RFOcGVX1bznz6j9iGkzRHSKObwtZbcqMX?=
 =?us-ascii?Q?eJUggI7cfp0++6gxU8GHCgp7CvrtBPoqkPFjjMCDrJiObC4W2hhGOlzejdfe?=
 =?us-ascii?Q?MX8cqq7C22XtsTBNPRQBiHjMf+7bWnaXjCEx8eoFNICa3yNwcgrL+KxBu/0X?=
 =?us-ascii?Q?AigZlIoXkrC3u4n8c2204osofRKK77hUJRWjicacKWdwE+l1F/ui59WvRay8?=
 =?us-ascii?Q?t3ntRB5kriqwZiyhRaObbaEykqguTqTWExmLdNG+CA5t1qgoDk6pNecq0qSE?=
 =?us-ascii?Q?U2L5/4pYr4J6vujhYQyCIzJLZrwTuK8sa7mzSZCtn5uPvAuwKxEryi9T/s/a?=
 =?us-ascii?Q?9K2cDr/aD9o1gqlcux0sc85h4lX7+AAiFCZXgN2UOtKDauumyC7QNDNDMSD/?=
 =?us-ascii?Q?pVbjXIJeC4LC+Fw88PVng9ZJMUNt6f1gTP4Uk1GUjj0LpsZcQfY9v6IiYMhD?=
 =?us-ascii?Q?xshsRrO7Q6d7sPANioUMi4OoENW21Vek680dchq/kaXyo6wM67CYCu17C013?=
 =?us-ascii?Q?BwxMa/1fGsOCfmLZQaPZx89xr9LVn33/NxMqMxiFfKAcnicTX1E7WPYlDbtZ?=
 =?us-ascii?Q?kTIuo1ubCgevC+Zq8X2Dp/7ag4aG3xLe+574zbC/J1bDpMNZwrkbiQeRUOfU?=
 =?us-ascii?Q?trcz9tzMCNf4eBISux29vdEjRZXsUFVoL6r/fjJ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4426eb-72c3-43e9-4a77-08da6bf063f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 14:42:23.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBsWu7GqfcLpb3ZjByc4cEpctZn2z116LDEI8GYEUv6jBR1rfEoqMVIpB4Sz6gfD6vqIMKr3ujQOBZvplQju7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1082
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>                                       desc_buf[DEVICE_DESC_PARAM_SPEC_VER=
 + 1];
> +
> +       dev_info->bqueuedepth =3D desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
> +
>         b_ufs_feature_sup =3D desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
>=20
>         model_index =3D desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
> @@ -8184,6 +8315,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba,
> bool init_dev_params)
>                 ret =3D ufshcd_device_params_init(hba);
>                 if (ret)
>                         goto out;
> +
> +               if (is_mcq_enabled(hba) && hba->dev_info.bqueuedepth)
> +                       ufshcd_mcq_config_mac(hba);
>         }
So what happens if the device does not implements the shared queueing archi=
tecture.
MCQ is still enabled?

Thanks,
Avri
