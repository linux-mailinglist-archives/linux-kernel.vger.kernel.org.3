Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0720474927
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhLNRVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:21:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11332 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhLNRVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:21:17 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEGYA86024948;
        Tue, 14 Dec 2021 17:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ivWwD2gE3XuL8scd2qJ0uNArAsGG6ZqGzCdHXqKESlw=;
 b=nASBSNYLhQPOecz/EbdtEMzu8hkW2f+DxHuy+uB+UmcaVQ9Gc0gmtywJgSzZ0oEa+5Gr
 vbbkL5KNDzk87S7ZOvLvTM9HroR9z96pf/oVYrhWmfIBgXeSKX5QxDeDmgpwSOOlSTlJ
 Dv9B4t6w1RGzGgR1hruQgvU7nNuJqzOLfdUMzstIMVKXWckPuOrEeSHveKh7cEe0gM6O
 d1PQcAyRDaVwUXMEj4/Uo4nUUiUCuE7dLoQ7sKdHa2s55Zm3Rqa+7eyYIqqoljpMog9I
 2VZREWdrKCdMws3inpOateZeNG4lrLP46b/+jRcEQZh2acjIa3lmrtqYNUg+4nJVSuAT yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3ukcfej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 17:21:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BEHGUCt146783;
        Tue, 14 Dec 2021 17:21:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3cxmrak7qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 17:21:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCSgnflw/ojVlQ7ChJC1wz6hDDN8k9tQbRUqRCZ561evV8Q6N8RAt8kdvaJs7FDN5lgfbyBKBWbcuX9Jpw1tIdmqhGKsM9q75dSMiPYhjywZeh4Ab3yr1PzcWZwL3I/Gh79RgOhT0QTZBMggPtEg530g8vdmQgeC8IYJF6OqFIUjeRbrjZwHcsSY/1ifKn9txxyLApICMSy8mEU7f6swB0SnNJXkY8u2/cEhIBj78ZOQ/GaHLovBmEcp/4dKBLurBcNI6Y9BQPbjL/yzfTBbLt13ToEmFEAVw25Zu9PujVrDLYS5p/R0gXXnwCj8wYKLMXd8c1u6KPoHLTJqIA7Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivWwD2gE3XuL8scd2qJ0uNArAsGG6ZqGzCdHXqKESlw=;
 b=haST+TWyRqcKybZA0ZXSPlvIDJMLEIykCvVW6ZkjV8pQe5J2/c3OQHwCfm6DKL75LzSjPaoryhhU6FIlWXXD3CgPA6iWouY66hzvJSaz81qvqy2yFXCNQZeGj33C2CWZBM1UHTbLibOJOcmrQE9kxAAR8F8HBkADsX0y4O24bVtoyaeujkvb8WHFq73lhWbYUVnuzLbPJTxdt9Frh5d8yw0GG588D0Ig6cVJ1UoiSayDRqt00Z3BvsF9cNiMJsNliZpTwuu16wnHHOodQUwfMyHpsVhSLQOrhURm74LnghN3KGExHic8HZqq7orlf+Fr4tPk1Ne4xwDz2CnUrKM8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivWwD2gE3XuL8scd2qJ0uNArAsGG6ZqGzCdHXqKESlw=;
 b=Bm4EBPNAej3xvp/U6vATJ0QGjh05D7MxBh+eBSOwQRITLCS2eGfDbcNniWBaH1B3swD5Yc60NBpcGpSkGV8857HKPTuWvpga7QVor3Ae/n31ZxQyJHkvneQMxDugrHkxzpoYOxPPlWU3rzUVaekOouGopj6a1CyrxFePy39MYig=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2942.namprd10.prod.outlook.com (2603:10b6:805:d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 17:21:10 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::755b:8fbf:706a:858]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::755b:8fbf:706a:858%4]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 17:21:10 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     linux-scsi <linux-scsi@vger.kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        open list <linux-kernel@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3] qla2xxx: synchronize rport dev_loss_tmo setting
Thread-Topic: [PATCH v3] qla2xxx: synchronize rport dev_loss_tmo setting
Thread-Index: AQHX8NttSrFcrIaBQ0W50sWJ/LWSwqwyPEGA
Date:   Tue, 14 Dec 2021 17:21:10 +0000
Message-ID: <EA0E244B-C26A-44F2-B224-7DCB554D6DC3@oracle.com>
References: <20211214111139.52503-1-dwagner@suse.de>
In-Reply-To: <20211214111139.52503-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8edfb801-6a15-46de-0db4-08d9bf261f44
x-ms-traffictypediagnostic: SN6PR10MB2942:EE_
x-microsoft-antispam-prvs: <SN6PR10MB29420ECA791834C08285D09BE6759@SN6PR10MB2942.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ccHlqrFLu52HXWn6nB7czf+lEsY5T/Ibz3fN+S/hi40SXsVoDp/iba6bH33EeGoS/N4BSNgk6LOQbHR+EXVqxTNi5uEEmhlNJUTJtH71sVTpEOkAKLAD4am8DJk15Cm+nKAyif/ahWXYPXYEjUw0iCgd+39A/w7kNi/9rs/wBFKhQRsKdO33Rjwqn5i47f/4Ky5GN+JowU8tKenyfcElg7yLjRqcV/1HN7B9tiEY1RBTcKxaKTarx7LMo0pFRpLIPhhzMYYLrqikc7Y1gz7NYTNtalCtSt67kyavSXVXVZKSAEp4krSeiYRHnAZr5aUhqolLmY0L5GzVlSJsgbHFYQAbFcp7WtzfGUgJaDyrVOhnwQH9Vd24Ne59PFBCR6Eg1ge09CDV3lgLNVwziN3enK6MqlFKvtJGGS1yK72X0tKOtLp+juj1n43m+jv+3PFdoqTdkZRnPjkx9EpvYGRoYyoK/iV/U0zJaqDwVTAaScovGQb9ko2s7FZnb9xLrIJN36g1Rf043g4nJ34AzdqPlYukbLS6P8GQEzkEIvPrnre4sQN3HEMK/1BcvFwQE+S3VI6vE/FkOL6Q3PYUoaH3CilIHl13jvKAZ/Z3hDuhsUdCx5UdWraPtP3SNfVNdtVxBjikmaATO664Igdl/559Ui999SR9LVPL1fRMU52dM4PQ7sAH16jm7terfmNr75gq7Z3NxwL3qWCaUkZlLrw2zoHM+7zlobKvp2C4OLEDoTyBDU5qxb3cGDEb3JyRruifhvYL9ZzQjZIMjz1spcxDH8eDDUUd91lId89MIv8VlOqBbcVXAepkwEsGK5xX+6h2m7UbES5fUX8HunUXSghubosNpkv/NlDEtmd2IsZn+2w6hGUICV5cr7eDY0uGPinj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2616005)(44832011)(6486002)(38070700005)(6506007)(66556008)(76116006)(122000001)(2906002)(38100700002)(83380400001)(66446008)(66946007)(26005)(86362001)(4326008)(6916009)(6512007)(53546011)(64756008)(5660300002)(71200400001)(966005)(33656002)(8936002)(186003)(508600001)(36756003)(316002)(8676002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QQYSLTqrdbOGSHAmA7clEw0SfwyVeE+LDwT6XVOL2JBSIaqux9T7H/pWVg6w?=
 =?us-ascii?Q?FDXUtOjxwzte/I8JfAFgaeQJdDWB4JT5O98etK5CjiYbqLPYEhX7fGw99Dib?=
 =?us-ascii?Q?iV4OPzddTOgjGlkQ3zGfZCDrZoXNoK0jXwdbPXFXNMoWyOxoUWQsS9SqU90h?=
 =?us-ascii?Q?iRoi8aWjk/vDhbK2fChVeVQ6f6W1o3/8QlhRevhgfsYelrqTAGBjI4oxRWf0?=
 =?us-ascii?Q?4/wbTemE4n4Lc5xetQAPzvxmPAscqb9yyufkXE+fXpObc55lV8R/vbbz6ZRp?=
 =?us-ascii?Q?YBseGdy05cQ2FiWLTB9CHPsftuXyArgrB8IZV1XXuumqMJ4aM4S0Uq+jW9zQ?=
 =?us-ascii?Q?btb6FzNk9aLIPDnbhqdDk0dwXWq7l6pwrLeb0GMkWHYHGI0uO1mcNq1dgkP2?=
 =?us-ascii?Q?TpEM/i38eeKUXCVKYQ6YFMl3sJb82uIoVPnxmpP+SAr4U7EVpKQQ+22jeET+?=
 =?us-ascii?Q?51cnEf+yiD8iN0wKfU/eyGRos8s++d1q1mnnO8FwOKrKF9DnXIk3kD2c4Yti?=
 =?us-ascii?Q?cADNxnR8Snk/GEUtyyI0S+GXSy4+Mz2y+QD2yxUSCDxCK9Iw3stzYhFwfSUN?=
 =?us-ascii?Q?Bd49STWhMtnwoWmLq8yKdUAHEY6D7mJthOCW3n3AlwIRcEnhBP9SVs0UUSeR?=
 =?us-ascii?Q?Kpo++j/kcu6AisYjM+PpJKHgtdINZPmHU4k3H4KMyn3pwpVZLtmABaE/PPDG?=
 =?us-ascii?Q?Tq/Aly6zJMp/nYAAmwDLlxFtW4H8zBf5PNLONCsf26NpNN+EbrqPSK9evHBE?=
 =?us-ascii?Q?fpiJv24ZUaT9+Q33rnOj5zcemgfkSBipN6IOvVLEHO52clyEOw3uAAXqOt10?=
 =?us-ascii?Q?EOr/aVBDeCqC4zyhNkEu71mVTd0F/QzJay+BdPN8a1CXL84MRqzvaiOSBAb+?=
 =?us-ascii?Q?8RMrfAmvx+fcgYaBy5/s566u2gwrLej6/rganlbJ/aEVDmJQUEoLsbI66liG?=
 =?us-ascii?Q?qlGsg3PjuGHq490/R+8XLHbaH4Rq94KJn3j50KyjXk+fApBJe/t62nYH4qDB?=
 =?us-ascii?Q?T8UNP+AZX6mwos6vAT6wO3rpWq/LUX8Y4crhfAf5m8xkSm+nwrjTl4mugJnZ?=
 =?us-ascii?Q?XZAF3o1nvf6C5ueXlp1LdcmtB94L2umauBd0xVo6MQWdG+gRRWgLGNf94SdX?=
 =?us-ascii?Q?xGyLZx6N7x0a99sZKqAjueQIqhKdKHdcqwNmQrz73E9EW7gUsJ67EoKVJeYF?=
 =?us-ascii?Q?MyXB4UA5F4zoYYuXaoWt9QsLQlaDzj9PdRrt2WtaklvBVhCFfaHwEv4f/Udx?=
 =?us-ascii?Q?RMLle4O6nX4+Ta7gK3YTYXaplHylWH/PdOREGpSdq6C6vtQQ8scNVzIVqYiU?=
 =?us-ascii?Q?bLcugxfVBzD7ISvfUkgJlJwnLxNvfz5afDWL6Z2aMLV4kuRosbKW9Wn3bSra?=
 =?us-ascii?Q?dO+3l2TfqXsGfgFJJAUhuiKx05a6sKiMokbgfnAYIllfYXu2inKpyGfnizuX?=
 =?us-ascii?Q?V++I5dC2OFRUKAD2eegFA2D7/MVtqB5SXRwsCx2hABwQxRcSpTx7yJBdhgbX?=
 =?us-ascii?Q?SzOA2RDV+RKiF2DdhH56X5ERlURcbpn8ukFHynXVwAMYjLLQ1SYgsCa/LmOr?=
 =?us-ascii?Q?o67iyhZJoUWxcSzPPvge3u2TAoz+aspQ1E5pHMpfCCT6vtxCnFn3GJ9p8f7R?=
 =?us-ascii?Q?+STe/QvE9sZDA68mfyXHhXNdqhjICHuW008NHlsXzoOMfxutZsGKm8zz6FcO?=
 =?us-ascii?Q?DnC91GPDsr+Qzi74PwFTkCd2bWA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <86BFD0869FC4174C948962FCED52B97A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edfb801-6a15-46de-0db4-08d9bf261f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 17:21:10.2914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT7OqjdesPx49mtcdhAPH4C6G0t/ukM9fBKMu0YAIHASjjMEJlJ/KP8snrh5jiOyAVtmJcWplM5NnsYhw8yfMUB2MbHX2rLtGwrCJTqJvqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2942
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140095
X-Proofpoint-GUID: hBDzqfaeLXY60aSTVePsw1INDsVoaaZR
X-Proofpoint-ORIG-GUID: hBDzqfaeLXY60aSTVePsw1INDsVoaaZR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 14, 2021, at 5:11 AM, Daniel Wagner <dwagner@suse.de> wrote:
>=20
> From: Hannes Reinecke <hare@suse.de>
>=20
> Currently, the dev_loss_tmo setting is only ever used for SCSI
> devices. This patch reshuffles initialisation such that the SCSI
> remote ports are registered before the NVMe ones, allowing the
> dev_loss_tmo setting to be synchronized between SCSI and NVMe.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> We have this patch in our kernels for a while and it works
> fine.
>=20
> v3:
> - added additional check if fcport pointer is valid in
>   qla2x00_set_rport_loss_tmo (crash reported)
>=20
> v2:
> - https://lore.kernel.org/linux-scsi/20210702092052.93202-1-dwagner@suse.=
de/
> - fixed build failure for !NVME_FC reported by lkp
>=20
> v1:
> - https://lore.kernel.org/linux-scsi/20210609094956.11286-1-dwagner@suse.=
de/
> - initial version
>=20
> drivers/scsi/qla2xxx/qla_attr.c |  6 ++++++
> drivers/scsi/qla2xxx/qla_init.c | 10 +++-------
> drivers/scsi/qla2xxx/qla_nvme.c |  5 ++++-
> 3 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_a=
ttr.c
> index 032efb294ee5..db55737000ab 100644
> --- a/drivers/scsi/qla2xxx/qla_attr.c
> +++ b/drivers/scsi/qla2xxx/qla_attr.c
> @@ -2700,7 +2700,13 @@ qla2x00_get_starget_port_id(struct scsi_target *st=
arget)
> static inline void
> qla2x00_set_rport_loss_tmo(struct fc_rport *rport, uint32_t timeout)
> {
> +	fc_port_t *fcport =3D *(fc_port_t **)rport->dd_data;
> +
> 	rport->dev_loss_tmo =3D timeout ? timeout : 1;
> +
> +	if (IS_ENABLED(CONFIG_NVME_FC) && fcport && fcport->nvme_remote_port)
> +		nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port,
> +					       rport->dev_loss_tmo);
> }
>=20
> static void
> diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_i=
nit.c
> index 070b636802d0..1fe4966fc2f6 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
> @@ -5828,13 +5828,6 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_por=
t_t *fcport)
>=20
> 	qla2x00_dfs_create_rport(vha, fcport);
>=20
> -	if (NVME_TARGET(vha->hw, fcport)) {
> -		qla_nvme_register_remote(vha, fcport);
> -		qla2x00_set_fcport_disc_state(fcport, DSC_LOGIN_COMPLETE);
> -		qla2x00_set_fcport_state(fcport, FCS_ONLINE);
> -		return;
> -	}
> -
> 	qla24xx_update_fcport_fcp_prio(vha, fcport);
>=20
> 	switch (vha->host->active_mode) {
> @@ -5856,6 +5849,9 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port=
_t *fcport)
> 		break;
> 	}
>=20
> +	if (NVME_TARGET(vha->hw, fcport))
> +		qla_nvme_register_remote(vha, fcport);
> +
> 	qla2x00_set_fcport_state(fcport, FCS_ONLINE);
>=20
> 	if (IS_IIDMA_CAPABLE(vha->hw) && vha->hw->flags.gpsc_supported) {
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_n=
vme.c
> index 138ffdb5c92c..e22ec7cb65db 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -43,7 +43,7 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha,=
 struct fc_port *fcport)
> 	req.port_name =3D wwn_to_u64(fcport->port_name);
> 	req.node_name =3D wwn_to_u64(fcport->node_name);
> 	req.port_role =3D 0;
> -	req.dev_loss_tmo =3D 0;
> +	req.dev_loss_tmo =3D fcport->dev_loss_tmo;
>=20
> 	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_INITIATOR)
> 		req.port_role =3D FC_PORT_ROLE_NVME_INITIATOR;
> @@ -70,6 +70,9 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha,=
 struct fc_port *fcport)
> 		return ret;
> 	}
>=20
> +	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port,
> +				       fcport->dev_loss_tmo);
> +
> 	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_SLER)
> 		ql_log(ql_log_info, vha, 0x212a,
> 		       "PortID:%06x Supports SLER\n", req.port_id);
> --=20
> 2.29.2
>=20

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

