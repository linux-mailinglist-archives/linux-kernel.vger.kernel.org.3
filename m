Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5257F2D0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 06:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiGXEHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 00:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXEHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 00:07:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425AFA478;
        Sat, 23 Jul 2022 21:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658635669; x=1690171669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7d+Yvbysv9KePLMCda02INw3x5ZgUQk0esEz6uh4seA=;
  b=Sa4JdSoQnOCOte8x4LQ2RSqqoQDQ4gev76pdBiqnnGnPigHDfKKKG+h6
   K7Qwgkl0gMTt3zL0Z7gmyjEuja0IBKtVYG40YXZPVZ2HAmU+1trWSGqIG
   UgEwOYFX3XhVVOSO6tY+amftFKEVf+cX3j/SBmbjGlrOendvF90Uy/Ees
   kcG7rEj/u2K99NDC1wnWdantN8ZdcMj8dWpxi5GC+jh06gvWni5cVbF2P
   uz/a2I5E3FaqWwglVhfx7qO5TNHLchlxZzXIdUrUlLm6YySoy8aI3fFdd
   9PzceOMyDvDGe1EoX8UtOzylTxS3+OJ3l6tOQiH0dCWZZFd+Q8h+qeEHu
   A==;
X-IronPort-AV: E=Sophos;i="5.93,189,1654531200"; 
   d="scan'208";a="207373018"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2022 12:07:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im59aGxE/xuWACwXZrFeor4oVP2JCK1FOiLi/CteAiupeXaZy2/9zDq1DVSxdHIxBXm9EhpfE8qMAXQLBHf8xCzjy9obBR8zgSUJ6lxewg8hxcjQv+LgzX0ZG56hXcjf95JMO8t39jNdeZY4yPQcHyZyiBxwwSnQqPabPnjyTx901UbzdX0/lHQoGqIy8Jptuh9lZfGuF4bzd+v4LnzZhwYTXIsaaraGVNLbzGcz+7a5+RrVKCaZrfYZh+ZmQwnGqZ1pATvRm3T9gZGo2wHzRV4MCYZDL8V2Zx+7VNMsYI1YHCEIq/B/2zRyJh9HBFoF0fWnInt+1p6chS36Wa7e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1N3a4MWrNEQJyh7Oe0pxZepSmRAsc+mL8iumDy6gyg=;
 b=iGYbJL1R+SWqEtF+oRymOkxiHREhEwwijolCwUFyNX5S5KGB0XkF2JPy3DJvvjx6tRGMCj6HhFEqTX0oiQZeVU/eJMvxCuyGuXPQWtjvT7OgGutL5w1liQM1co1c/q1iV1oV9uzhXW75Kpi8mcGpxxM1jXKSXw02rD/KiLZUpFjhLrZ3M79htxb5WNFNU/uuVHwM0FV5KscxcNRicdstu/9bif35YPjItsd4LAkg3GDGJhUu6VbiFKG8a0UOdcciAp8pvD0zFJ9RMz0yQGpNM3BkzM4CC1P8bOpiQJrRZB98BLdZxM/xxc0/Bp1Y+ijhIQ7NTRmZGJ0wAsLlkDk1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1N3a4MWrNEQJyh7Oe0pxZepSmRAsc+mL8iumDy6gyg=;
 b=JjmY376UutJUaSDj/C21aPEpv/nwUYLxssAOnsnWNaswMj7lQHzquk7Db58IU2bWjyx6GPOnznL+GWxnFKV7F1igC8qAB/eIKihv7Yyn5k7eHqgonArJbmQWcVnHltBJP8uaWnq5fRZzQdOxrrpVNunItpgvKDDFm8L2fZHkXuw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4410.namprd04.prod.outlook.com (2603:10b6:5:a1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Sun, 24 Jul 2022 04:07:45 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 04:07:44 +0000
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
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2M7bBw
Date:   Sun, 24 Jul 2022 04:07:44 +0000
Message-ID: <DM6PR04MB65757CEC7F66AB732EF5FC48FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 6a772bee-703f-4378-4c0f-08da6d2a0fdc
x-ms-traffictypediagnostic: DM6PR04MB4410:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6Hi8y5CcBhhI4+8EOecX5X3/kBW+NgqLXgKijyjXwj8jQ+V+tWXXp3IF07p3tXAi4umi9yqwsAfPLB5oaarF/LTz2nX447QEr8h5WqrLfIn89lEhP5Q2LzajVCgFjQquaS+rAKnVeELxpjjTYh1g0qddT24DCRT2RKDmzBmg8RDNI/zP8AAZZhwZDjgeh0guU+swQhGGre9QFMZGvrqLrhcqgNERiEb9y5k/Uf5q06wSP8Koosdm+QKLpr2f9oP8plwg4KjyridN9TWBzQgmqJpuNfx4EZqqnWzTjTbvxUXaBe9PHyjhXnIKNRdWxshkddeOokj52uigkzk72P16TJD3hmcDMb8Z+KhYK3D3C5SaJ/SimmVoUZKwGcFVpetkRf1FKPHj6XcecAIQn0ALng+lcDUNib6ZesGds/DO9COZLU534KvLkBvZQiFjQ4CN/OqqjBCo4EapJQ2HQIIPDb63kRil63xiqC7K4P16ZTSdWLKtkceG1ZldVoaBmPxKDxkHurg03/EYNdSclVKYrMiegYa+xoqkTHYiVbCmsAl0T91uya41ICgu/89ZHgNddFYJHbkxs/R6xrKIaF8oEJUx1AHsaZ1Wv35ZQOvomAQPOSKbWqfaEgwNDOmTIE2x9SIHu7FSqk0SkZDe6ZIcUAuYiDwXu7PVbSWvKWlngPYbdAAUiGXlqtMiN26W0m3WWEogktXjd5fwwcuZRivHi8wl/Qo7ddkWf2hyo4jmDYlBcoOtvHeTp0WFapydJJUzSurYpKd9d20J6yDt2pzfc/J/mTbFlH9wN9XY4tAyQA5O5Ank7B8r6q6w0ylzmtgeDKR8MfeV8XfbzmJsQtNyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(5660300002)(7416002)(52536014)(478600001)(8936002)(86362001)(6506007)(7696005)(26005)(33656002)(122000001)(4744005)(2906002)(41300700001)(38100700002)(82960400001)(921005)(9686003)(38070700005)(186003)(66556008)(55016003)(66476007)(66446008)(64756008)(76116006)(66946007)(316002)(110136005)(54906003)(71200400001)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ratuYfsLPbMR4X6+TeRBDBFZgVtTQska6mQlH+ohom0aOlds4wD00kNVI5vQ?=
 =?us-ascii?Q?5SHFqaTApMguw8KVr2x6qnNMxwli1sy/pmJC4AA+XcJVWTrxRmIhsIP8WNDJ?=
 =?us-ascii?Q?NbxCEVNRjRVk2mbCWO3C/7gOJoygB/avsIC5eOIAW7okiui5iwLpT+QUPSTs?=
 =?us-ascii?Q?UpBV9wD9/osJBxGsYRpDTBR0NHoDY/zxaNkAydXiba5HJ1Hc1y1KbCiIxAOq?=
 =?us-ascii?Q?4BM1EPnZYqHMPQTylluw7IStCiD8rmDLJ1gbKvcB5pHdi+46FTx80msnHsgU?=
 =?us-ascii?Q?5vVsD+hXLA8Df1czmCnQSBXxNqq6uhZ43Oox+1fOeWMOwzGZ3NaalWQ/odlV?=
 =?us-ascii?Q?a2llZBP02gKaeHHcdh8q3Op8EC9LUEfrPEaUa4S3S+ZBmjBA8cvq6nuvZEkO?=
 =?us-ascii?Q?PMrLLTbx6wgErXDZSb0ZGgbxkw2ob30UpSYC3cjBEJro191t1NRYtINHq4EH?=
 =?us-ascii?Q?PNToBjLQ/JDt5qPXHlnthi3v2SZs0T7AbHe5hJ0ggIPn5zkS5ZKKrkAtJPjp?=
 =?us-ascii?Q?ZdzPp7VU4DeErMXpYJmpgBu5rMhx+WRtGd+YMIaVWvdAiopXZydLJ7pIYszf?=
 =?us-ascii?Q?mSKsq0wkbWYWxqJdK1jaWQcltw1o4KWQC7CoyuakSuVGyTY6pOrLPGkjsBZe?=
 =?us-ascii?Q?A1ijko10IbaC5NJyZROzYeW7QHCqgD/NWqT8hQRCK2HfZLntnk7+vnqzRVh6?=
 =?us-ascii?Q?DiZvq8cNvpx/0mvvDmbqBZJ63U41WGDqC6wTdn7jlXaIteNEC6Y+iTbdn7cv?=
 =?us-ascii?Q?80uHjN5+fVfK4Q8hLSQ9KLqihw9QykpqICKG0Z7ZFYQQvRnY8OVfp/+mVmN8?=
 =?us-ascii?Q?UV6svOjxLly+VQaNaYZZiz/Ia3VkqA3TLmCHl/9r5jofOJFLUlsyBV292Coc?=
 =?us-ascii?Q?52A/sw3QCYeVYIKhmpms09O0WXdxvRzhCVnSH+B8NXoMoYrpn8OqOwI67Wcy?=
 =?us-ascii?Q?gNpsI8IimnvzjolnCU+IWCik9hknxyVvOpmLnV7Cbd78n/aVHBwxGqwbEHLK?=
 =?us-ascii?Q?bYbDVfc8jwaSdPI6dyGwLo2I8hn0KRDA3M4N8K4sc74CxyxQYSfhJKaFgW/E?=
 =?us-ascii?Q?yZV/5f39XhmwvW/bpcWiyTitsby1uf4YAEjULacNgqi4+tdOw0Mvr9v1mH4C?=
 =?us-ascii?Q?jH/JjudZvjN4q66kmf/Twtd7q4c6npvtEHGCPD7QFKcY79xDyEeIi3QBkk+Z?=
 =?us-ascii?Q?E8rTonLqUhAxbEE3UdQdM52oZG2RpTiu/YDT3taFT1QYQDfQhF9srWz/QPcB?=
 =?us-ascii?Q?ZL6ydHZud4v3K70eBqR8t53oBHlzKhbkNXKqaE3LwCEWJ/ST09yEY1xY7TH8?=
 =?us-ascii?Q?z5NsWmWIQqLRJqyF9OSJvLydVfHg3WVaCodxN9KlyFnPY3kfLBuucDE3x2iZ?=
 =?us-ascii?Q?HOEVbxiGrfbzLAttJADmWpEBoJw8vYJck4feuLTi7a2Xe9/l/ahTVc/wmALd?=
 =?us-ascii?Q?L5Yd/ulb8Sr0Yfp6mbCuUG5elHj8So0CjGnyLwwK6pbktn9tAeDER2dx7yyS?=
 =?us-ascii?Q?AwqMIKYFTgTHzzUgI3IR71xjSSDcZM6mFK3plM2As02dh7u/0WaSFnZ7bZpQ?=
 =?us-ascii?Q?EL4o8YtDGuJgW8Ml4lYP7lzdmF1isz+mePTyZ3y/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a772bee-703f-4378-4c0f-08da6d2a0fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 04:07:44.8027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhIv3PVMOHJMFGnK3AA/AX+CVnRBzAmQz2ylnil4hoxFni8U10lfJtdRfYWYIoIIlX+5dp4jfKfnG8O6xsQfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4410
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2558,7 +2587,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct
> ufshcd_lrb *lrbp, u8 upiu_flags)
>                                 UPIU_TRANSACTION_COMMAND, upiu_flags,
>                                 lrbp->lun, lrbp->task_tag);
>         ucd_req_ptr->header.dword_1 =3D UPIU_HEADER_DWORD(
> -                               UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
> +                               UPIU_COMMAND_SET_TYPE_SCSI |
> +                               (lrbp->hw_queue_id << 4), 0, 0, 0);
This is fine, as long as we have 16 queues or less.
Otherwise, we need to fill the EXT_IID as well (only if bEXTIIDEn =3D 1).

Also, don't we need to do this for query commands as well?
Or at least add a comment that the queue id for query command is 0.

Thanks,
Avri
