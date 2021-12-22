Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0089947CF05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbhLVJSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:18:17 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:11336 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbhLVJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1640164690; x=1640769490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H6Tj4ksaYOPE1quiSH2Bgey2+ajBQS4a+ZrLHYSGTXo=;
  b=KALOxtZLnH1CSoeBZoc2gPt7CXo+FOdE+JB6q2hTvSV9+PZv5iSpaWIU
   B/vjwBj+w3JY07p+LsflZzGzN/RrQydQ70Ji79KUsdmosIsDaFJ9kWBBO
   Sk/HSxuql04PtdIuie4msvJnlqjx2YYi3WqRUMtTmV7eW51Dre7yc3CF5
   o=;
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 09:18:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbZLjo763Rnwy14dbbrdjjnnFGz51GoG7vm4KQ6fprKb6WmA2yZaLMbfFEwdQUJtXaDKx7gLFagg57QHZSbOscJI3lrPVXu/5C8iekOA8d0NQxthMSeMfrUA/qBDolOShlz5QrmSfQAkqR/I2b0uih1fi3XE3UpTFxZY6/AVOG0SAH2CKb8I6rl1oRqUI3pNrn0e1043omm9FIgQdi+hjhvRlxHIWCd0659M1tdUBDv6rHflcmZ05aFMN7krLV5vZiOz7hHNhAnV0YQnq9uqkjKGHKX90wUH4vB38ywRB8us2hE6t8V6aIEixb2qtQjDYShAbZXSygnmAnpIIm9z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Tj4ksaYOPE1quiSH2Bgey2+ajBQS4a+ZrLHYSGTXo=;
 b=lHNb6HixkNl7SJdWlRZmL3kQssZBmke/Tu72md1TQVyep7UTJv2Wk/nRQN5KdAgzjXe1IJwIDdzDnoLV3n8GcsGxjjPm3WpZf/3BeOLhIRHSEPgozd5MSCZZXKRe6klQnS+N94Bdq2fEQCJgoDSv0pP6IMKZRK8LN7K4dTVlUwTB256ebjw+AbKmZVa9BDClhI7GRfzXnBnDxdFbwDOV0ThHC8vrvF6a9KJ8Df0MD5YqUQZdLalUaofoZb12GX8uH6O2+ak8vXoSM5oX4vrwPnekAW1s1/F0IVwnPz86BhrUQrb6RmDE41oFFo3CTyW2EfcRVdiCGAFSyGCQiZv9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by SA1PR02MB8606.namprd02.prod.outlook.com
 (2603:10b6:806:1fd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Wed, 22 Dec
 2021 09:18:06 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::71b2:90f0:8f8e:c03e]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::71b2:90f0:8f8e:c03e%4]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 09:18:06 +0000
From:   "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        "rjliao@codeaurora.org" <rjliao@codeaurora.org>,
        "hbandi@codeaurora.org" <hbandi@codeaurora.org>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>,
        "PANICKER HARISH (Temp) (QUIC)" <quic_pharish@quicinc.com>
Subject: RE: [PATCH v3] Bluetooth: btqca: sequential validation
Thread-Topic: [PATCH v3] Bluetooth: btqca: sequential validation
Thread-Index: AQHX8a523zG21O4OrEivRazwK/zcmaw1itOAgAi7dPA=
Date:   Wed, 22 Dec 2021 09:18:06 +0000
Message-ID: <SN4PR0201MB8725500D8C41958D3E5F1BA1E37D9@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1639570900-24509-1-git-send-email-quic_saluvala@quicinc.com>
 <5F7F1736-3B51-48DE-9DEF-89774353A85C@holtmann.org>
In-Reply-To: <5F7F1736-3B51-48DE-9DEF-89774353A85C@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cfccc2f-fa60-43df-2cbb-08d9c52bf6ca
x-ms-traffictypediagnostic: SA1PR02MB8606:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SA1PR02MB8606CAA5179E48165DE7A8099F7D9@SA1PR02MB8606.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwMb/zTbKS4HDKj8bw4hA/TOmnjZS3FG7tQcyBJTt52vwC8ehyhBKY/6CenwmEz1eS2wnhf1n/szZvhMTYrRyzNqEfAJxJICkE/Oxv8E8QmFRBSpul3JVlxeZZivCZFf2iR2MzXlolP2FEDBdOFHUnGvo5lsHG6k3yiAI3UWouiMPhlaTridVUqEg3mlzJXX7umNbKBvGOBzFgv2FhPlKW9V/6x85GCa3hKlBMvSbR40pa25KYRSKEEfF4BeDclDhP29FZF4yUgmwLWauNkpaP37Bm3BAKuqCQbU36nJSi7Cd/W2HHUDzvB/jWOhdFaF9sMPpVm8mK79NlIO5tzHzF7qB4sJcCEJwt/YqQZl7wri+WAyp61/A7pE3jMBDdzlShuaZM96+/BATd0j0IRGNusQq3ueXUzSEbhq0vaS00z8xvk5BZ4E3hAcwgaGDjHsAJW25y3jHAnDVDpOVzcSVAJbOYAtO7f1+AFzP0OMQM23oURAIjqi62jMAD0c+7Z9oFnZUug7x5FWCGKSZM5uod9mVuzNeY4RIAC1RT+lYIJWSkxyGCcd6Zw2rfgxPno8FxOVvI4EM3gIyBdh3RDTS8HNDpsUVfs8y/EA4XAWgDbkTeZa8pFZ+RkaIu1LdPy9krsWKeTa4QlpaPIY8WoVKlqFkY464QTf7LSVZcJ8dpeIvW/esaN+XBkkm9CPgYUkHwPXO2voqMV35lNaPH8jMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(7696005)(110136005)(7416002)(54906003)(55016003)(316002)(86362001)(71200400001)(8936002)(52536014)(8676002)(66556008)(6506007)(33656002)(53546011)(2906002)(9686003)(66476007)(186003)(26005)(508600001)(107886003)(38070700005)(83380400001)(38100700002)(5660300002)(66446008)(64756008)(66946007)(122000001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ua/VQejEwWuOcPyrYgUnzvrJtO7R7h7WuQuj3lj1BJb2y9IvSmFCnBz40icX?=
 =?us-ascii?Q?SQ8yN5a51ZnXDE6cLsZBASXxq+0vIzm37GeISZHsfmM4kzieJbBrE6pjGRJN?=
 =?us-ascii?Q?QOjAkw+6pvQn5F4WMXxqRooGd6V90/tfNdokUtMepZ2C8ZI3O7NritwY+D+q?=
 =?us-ascii?Q?6AqHGp2Rh1HxV/RkAIV5QfFQxdclix94XUgH9RBlbkDvZ0U7RIBCO7Dje3u5?=
 =?us-ascii?Q?KAuNBr22xmHGm/F1+/GAN5NBOyeKlBbdFsDMg47lSBnGbcG4l0TrdM8hldto?=
 =?us-ascii?Q?w3L/LIgyksK9TLoW1+1l02oRCe0D0l6oZc9Ih+wwANGmoSIatJwHJ/an096o?=
 =?us-ascii?Q?+f/LPhUS83mGzu4yiFv0jZT3Tx3uEWpQWuCW6ufaHHPhDnCeJB8tGzg2wYoF?=
 =?us-ascii?Q?B46QNjUTWD7nc1j+aN5FCnZRJankgKPbIQP3KwZOzg6QjastqKkXKfOXO6sE?=
 =?us-ascii?Q?zFF0P1d5IOZ/hq74xzGBxUYISx3701Oxv4BFRCDs7euFWcr1vcFkpppIFLIJ?=
 =?us-ascii?Q?rk8JucP1sOGdUOfyRt7Qa4n4Kumhon6gH4xEKluTuV7NZCNb3Q25yjet+UZG?=
 =?us-ascii?Q?g+FLI/4jnVk3gcNRq2f+6eCpIw8sCtx5C1FKXTHKMZZqSlSBR+AvW0eUbj7l?=
 =?us-ascii?Q?IoMedV+XESjYK14BpShzOXckSk5IQBQ22965963a5I+WxGaEXZ6Vujh1RA4m?=
 =?us-ascii?Q?DfTqaHSVMEHlRfT2PFr0Evct+3ASDCO+jWllzukR/7zarBks88tgQT9cFpLw?=
 =?us-ascii?Q?f9yM7ioyq8zjvsbXxa4qakiVg4gdTNeaiYOBzgwJRaDq7Jq2R6EMz9G+qQDt?=
 =?us-ascii?Q?TF92F5ZSkdu3arwHnAJBzn5kRw3J4d6d/MwTArsqjDTau0piBMn4/E2NpL6a?=
 =?us-ascii?Q?YiPJYnXDshcExZoGOoTHAcqvmBwA7cPjN0AHoEqM8mzskuFpuW5QINK7yS3V?=
 =?us-ascii?Q?ZBakJoWLAPrVgAiwFZo6iM21YEt3amycfARIgHkz2R8haebRdLVm6XoQhlbZ?=
 =?us-ascii?Q?3KROzTVu8gbf7bue0qEFL3Mrvk/M8Rqsf9G8NVZkNZib4srkX96IGJwNaQjM?=
 =?us-ascii?Q?VPUkVBA/TieRCCAwySj3aq89Z+F4WWsoo8AHVKg9HKC0YjO6dl70pqfCh2z/?=
 =?us-ascii?Q?LMY5trTlXRNotbBVkE5I9yPgqNURI97s8TvGXq+zEIiYAc3SeAAyVOBTE2vO?=
 =?us-ascii?Q?k6Z5T8f3keiqcgYJ0R3bEkOBcYr0TJ2d6x/p8S38U8uloOEKVB1KJv/fbipp?=
 =?us-ascii?Q?xM1k3EAf2Yd4MN/iJWjUP5FBppVk57c7PbbgB25lz4vfeFFlMUfLIywijsL7?=
 =?us-ascii?Q?1jZOM2jvcAsGSqwdzPf7UUowCdRTI/hisfL/LERSaymXxfGEXLz7oO5JeP1Y?=
 =?us-ascii?Q?mp5S222q6NhUQqt4RMbYIC4y4M3/QqRSZmWwhHvRbImETdgR2wlqddt9LycM?=
 =?us-ascii?Q?D9mKKcxhdD7F7LPvhwffixD/VmHR1NCF/h3Curjvqu07H6bHv1oU9W9c/Dzv?=
 =?us-ascii?Q?SGMuAeC+WXh7OyUN0B6vgSXBVoII+gQ4Pcawt7gxlYYX0ZM7/MP1QV2tJqP3?=
 =?us-ascii?Q?iEXqXWoFGwy3IN0dsIYRfC850DE4JbBV8uGaJw0PoN5qDC0Xt6rsrqnitWVj?=
 =?us-ascii?Q?Hh0yGZsUjcemquzUbxWJ7nPKVP1OM+8nx6ECCajkQY8qFVnCLetRJ0co+bW4?=
 =?us-ascii?Q?5YWb+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfccc2f-fa60-43df-2cbb-08d9c52bf6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 09:18:06.2784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gj7IS+XZD2vgHdxWtsVPlECsWpFx8RU04N9tMUbEZvQFFwYEDTwbNkbdbJgMGP2c4b+/bHdT2Ru4Qgoc2ZBLcxRXKd6BEK8UpToinyk6EfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8606
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org>=20
Sent: Friday, December 17, 2021 1:27 AM
To: Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>; mka@chromium.org; linux-kernel=
@vger.kernel.org; linux-bluetooth@vger.kernel.org; Hemant Gupta (QUIC) <qui=
c_hemantg@quicinc.com>; linux-arm-msm@vger.kernel.org; quic_bgodavar <quic_=
bgodavar@quicinc.com>; rjliao@codeaurora.org; hbandi@codeaurora.org; abhish=
ekpandit@chromium.org; mcchou@chromium.org; PANICKER HARISH (Temp) (QUIC) <=
quic_pharish@quicinc.com>
Subject: Re: [PATCH v3] Bluetooth: btqca: sequential validation

Hi Sai,

> Added Sequential validation support
> & patch command config
>=20
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
>=20
> v3:
> * removed rlen,rtype
> * Replaced kfree with kfree_skb
>=20
> v2:
> * Added static declaration
> * Addressed wrong indentation
> * Removed EDL_PATCH_CONFIG_CMD_LEN
> *
>=20
> v1:
> *Initial patch
> ---
> drivers/bluetooth/btqca.c | 48=20
> +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  2 ++
> 2 files changed, 50 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c=20
> index be04d74..21830c6 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -141,6 +141,51 @@ static int qca_read_fw_build_info(struct hci_dev *hd=
ev)
> 	return err;
> }
>=20
> +static int qca_send_patch_config_cmd(struct hci_dev *hdev) {
> +	struct sk_buff *skb;
> +	int err =3D 0;
> +	u8 cmd[] =3D {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};

I am going to stop looking at this patch now. You are not able to address r=
eview comments.
[Sai] : i missed to update the comments. sorry for overlooking. I will upda=
te in next patch.
From now on, I am only going to review QCA patches from people that are abl=
e to handle review comments.

Regards

Marcel

