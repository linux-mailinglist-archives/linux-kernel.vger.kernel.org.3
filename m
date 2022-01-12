Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06CD48BEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351202AbiALH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:27:33 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:7976 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237408AbiALH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:27:32 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20C3Vucs017992;
        Tue, 11 Jan 2022 23:27:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=WpVlYy0rn1phqjUPC019DX14WoU1NmUgpUn+OLSmvx0=;
 b=bAFlYuGi5KyGptVVoBhJDTvGMulz7oK2PI25oUa+hvUrUwylE7Hkqihc6fOWfs8DH6dx
 ZlQt43TXQ2EvsmXJZgQpe/vXKgWTfwSHkzpCBHbd0f4jEhhIpaHx7Z+5kSCUX8YCW9xk
 K/pbVerdf5eDTXLZbaNZJHfIfVx5Y3Y+GZJmEHsmplx4dV9JinaU+qLH4SID9FCQh/IB
 nkm3nn9s4Aw/bQTo44bPQAxEyxDw6NHT4tfwT6PKwPyRePeLe/LXw3u5+T/GNLp7Rr6J
 Lq4wnTZKlklpgoW5pWZARdZebU8eIzN330Wa3d7dp6WDMjA5FSs90BLlgSNVZErEOibV Hw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dgkxpqbbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 23:27:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL7lAAefOjE8N+18c8386PBnHbpS1aYX125QmVfOYa/uHRQuhkcKCHn9Dlej03KbPFunR1vB9y5UC/3koTDwOT/r5fK3o6Ob/jhOWo0jfr8hLI6sCVprzDofmkvaOAd5eWWbcU2ZXBXi+YacVq5kZwv8jyScexLiFtgamYuyqKXYtyxV7ZibGDS6pp0syTieDPDh9qJ+3r+sbyf/IvKvEkSrAYR4O/eoLJN721rdxXkTtsXV1KTHgpSfrZvHVbb1mR2UO/q7fs1SfWeaRERvmYZbfe46VnRHcl5oQqNQu/I9A7jtmHoG11P4bTAU6L9Cv9nL+lQNMo7PpgPv7t6EuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpVlYy0rn1phqjUPC019DX14WoU1NmUgpUn+OLSmvx0=;
 b=Fo813HRDuWbthT5bpDuAYRdm4y7aeL6CsIu33PpyGXFthGiOXSTzQWvqDm01Q81PRPZFocPvPE36c5d/U9owZuBpWq+E0mauq5srg3fS0cs/Cef00Nq/XHA5VjgSlWjFQzR1jGj6fylhkOVQ1Szpi/+vlCLd6mkpXA/uAOqJ59iCmIDGHimm3PCWD+2U0EWcYvp1kpL1w7LftAsVfUbzp/OgKJ4kQ/N1fItTzioyVeXyKC4TtXx93gmldD49ojMknPe6lpF3F6LlDFoPvCgFqaiK70wvydp9mtWM0ulzKhCNDy3z+LXgct5Am9Q9k5iEhq8m0YsDBBnA4iXT2P7/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpVlYy0rn1phqjUPC019DX14WoU1NmUgpUn+OLSmvx0=;
 b=681qeOc12z1NYcfideO57KCeLkGPa55F9vGNKUgEGmdDSbYsJVT1CP/44nzCP2ZrmptptIPLdic8gmyAR9xwk7DUF1+VmLfnwQcuHQluKhCp5MDcPAhFolW+uJ1qmEqeId77V8KKROrR3nQ+rpn/uyTaN+DKqTX6D3q+jsUEEKg=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by DM6PR07MB6860.namprd07.prod.outlook.com (2603:10b6:5:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 07:27:24 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::c0b7:f4e5:466b:e90a]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::c0b7:f4e5:466b:e90a%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 07:27:24 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: fix cdnsp_decode_trb function to properly
 handle ret value
Thread-Topic: [PATCH] usb: cdnsp: fix cdnsp_decode_trb function to properly
 handle ret value
Thread-Index: AQHYB3XlFt1qio9AKEue/SeG4rHS0axe94wAgAADcaA=
Date:   Wed, 12 Jan 2022 07:27:23 +0000
Message-ID: <BYAPR07MB5381FFF987B0570E8B914871DD529@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20220112053237.14309-1-pawell@gli-login.cadence.com>
 <Yd5+fIlG+vhzBm4T@kroah.com>
In-Reply-To: <Yd5+fIlG+vhzBm4T@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTFkNGMzZTUtNzM3OS0xMWVjLTg3YTgtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDExZDRjM2U2LTczNzktMTFlYy04N2E4LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTU3MDEiIHQ9IjEzMjg2NDQ2MDM3OTU2OTgyMSIgaD0ibHFzQkJzTHFmNGhIWkpZN2lzcTAxZVRvNnBZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0de740e8-b07c-435b-6bf3-08d9d59cfa49
x-ms-traffictypediagnostic: DM6PR07MB6860:EE_
x-microsoft-antispam-prvs: <DM6PR07MB6860610281FAADA0EB47C51BDD529@DM6PR07MB6860.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OmOZU48Do4kxtzNiiE6VlTFOQFxrfkr9tY09DB4fBzADvvy0sTaocoPcAOASJOGvKSRiBoQq9lMhQSNlvBGmS6qRobK0y6Z1+P1AnQxuTupQWkfHXSyI4UfyWl/wKRNmHIAD1xrdq8uBk+u9lkTLD0sxupfJw2VP0DfCHquI/IDszNkaOCxzMrog4n2LSSjKOsdo7EtKp1vlZj5T+7Snv6SaCXP5LUb4/5bB0Ztq2Ksh/PapM0JjfvuXA62rSNiARMBUIEixU3Q9WcAIyPhwDn5vnJ2cvEFRbpH8Tozr8LT9AyUAgUP3kCQlWvY1LYxxhHTw9olipNQQ7SAN4Yc3QXJXBSoLW0QZXh6TR9Y8/OtN6MUG8tZqYrjm5ar2wdADt2J9vPKgYx8YdEAWKg5UiB9zc9iyN/dEDhMBqlKfIvJyQw+Eg9ZmOCu4KQX4IkQdLaZJ/VRLLv+GQdSF9taWFqQSs9Wi5/o9P8xC0/jc7dYBynrN9rBOxYQhovnANzfry5p0zkTiZExtLGQfWqSU8hjRjuwcnt2eDdEwUhvpWKEC35h1aAXtnzhhoMMP3bGk2iPNy6brnEozPGOkSw3+NH+Bk8UCjVuGxU9KvncaC/qfVfut1p4221mXZvuQK/vQdLceogh4AzXocxQ2Ge/OnA6BJR5N3QBGIgn8P9MoniyHO6ZDnp2exioDLUv4bl1CEJjEXnm2EZmxKR3zMWW49CRIDpkp2D4L4csmHhxU3BhPBXsnY4o0m12DN0mGsEyg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(26005)(30864003)(508600001)(122000001)(9686003)(38100700002)(186003)(66946007)(8676002)(8936002)(66556008)(66446008)(4326008)(76116006)(66476007)(64756008)(5660300002)(7696005)(6506007)(33656002)(83380400001)(54906003)(38070700005)(2906002)(52536014)(86362001)(71200400001)(6916009)(55016003)(316002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jeS0KKD5f24kDGwUKTEt6cbxM/YXvixAqTmRhYq4utK783nwN4s34mn4f7EV?=
 =?us-ascii?Q?p296C63J11x/SxPF0yay1Ay5KvFCTr4GSGX0TO3IJiDVca5NBh98lGBeLRpS?=
 =?us-ascii?Q?qJmWVkH1gWOe+9RPY1iMp6/PXc70LjaT3zJN1OlqTck0QVqm9XUGGTotTP0u?=
 =?us-ascii?Q?46xTo/o8A4nn3ip8A538yd7V+2+6LgSXsuXQyeKfzMHqhYHZFuP3YBLMeODx?=
 =?us-ascii?Q?CSQGibmGSTDeR5hX6P1N1ddO3m0shbHV16d4nW9KprGrFohZND+gd4jKLJPQ?=
 =?us-ascii?Q?fm1TSb8cUI8xAcCWEg19tZetEw2J/Dy+m6ZNA5el4m9U6T1iwQ25t4jDWoLj?=
 =?us-ascii?Q?cTjay3Z5NRPwmdwr5u3e1jgZ7XrsdZa1tAOI9fWjbIyaLa7DbxKC+uvgq/EK?=
 =?us-ascii?Q?1NKLXpbkUQ7LdZHw3MchsnK4SKpkVjqCdCFOiB9t2nlUcu9vKrYp3kOn6zD3?=
 =?us-ascii?Q?VGLf/juTcQgNeOO2UpEIR4c4H31ju1X+PhYHPICwU96divL9QyKfmQbDkn44?=
 =?us-ascii?Q?m12CMoKVcugh/RY8NcmLuMh5RM3EIVxprP/Z75BnMKIcxClIpQtbwsbpWzBt?=
 =?us-ascii?Q?KdizJ1zOGNHZdzHExRheFmzK2Up7S3AHHFTcVwy/W8ICkUvIZtdVUvF68/72?=
 =?us-ascii?Q?WmMRQiR93B+pTlcHWJUqaqozP3Gu/TE0hVwK8Wo3RVXE0w+zMvvqtoJYF5qF?=
 =?us-ascii?Q?m0p5IQaZxONc4iRqXjLTeQrbdq0YO5Srkx91aSQDz6qp7XmawL1JRuleNJxm?=
 =?us-ascii?Q?AyKzViKb32zu9m7f0xMQHGAn8lBB1qtgAb3XmisoRNnSOzP7sOOHBCoDx41O?=
 =?us-ascii?Q?3ohxhp0VJFcKGc5q/aG1AVB4lq1GcM+KrjcNalM1AvJbVs77d1e+WCUDFiiT?=
 =?us-ascii?Q?mPbGuKXbqmEpQuOpJuJkXDKxoyTGGyY+rjQSyWM2hv8SvgY9ZmIct+ZD2vFY?=
 =?us-ascii?Q?CnYyTSDPgiPLnbOyYGdbjkYWXb+K0jcBZ7FIyz7kX6uwH3z1HtNcSCMqeWj/?=
 =?us-ascii?Q?SfkDEFZ4Z/o8MlQg7SMy106T4A9oLFdGYSmA6d0vPAhTu5LW3OtyLUXX1Nm5?=
 =?us-ascii?Q?YUAoHPXmG6Y77mal589xXOPipvUU+Mpr+BR5zXdQ9dmdaUmQw/lMrXW7Crc0?=
 =?us-ascii?Q?rFYSFBepa0CCbFx9UjHc/+fuq6UCRYT8j3B1TmSGH31kS2wtKp2BYaduk6oY?=
 =?us-ascii?Q?8o0tGUVrYZ2chPKooRyxnUWZmA5R+vTZGceYhFrCKG0lflCq73I8HQq26Eii?=
 =?us-ascii?Q?Rn8cufD8HQ0Tci79E9ySvj/V8eUn6IzyH86Xb2VLWegXoiCAYKB8dXeHw5BN?=
 =?us-ascii?Q?8dfcQvhfpP3C8fSIrTXaj6TanUNiOwAJNdGsF3WgEN0V55W9K0Dw96u0b11X?=
 =?us-ascii?Q?H5yg2Tr4be0Ye+LpFn0FgMv4dWnWCh9VTW90kmlZoLAB7qdZVuyghciZFo6Q?=
 =?us-ascii?Q?7wiQnJXCgLvZ1n9bfB2wFC9fRj2K6ypkj+/6H9CITIkYVD7U32Trjz0b2nST?=
 =?us-ascii?Q?RA7EvelpfFdEz4Fd2JaPOpsSLkomDackJ7mVH7iLMr3+629s6nK8x88iHCSE?=
 =?us-ascii?Q?NTJcZHXc4aKdG0QrkxWlQ6ttHMCBYqdnoAlRrexoVKCqbIwb4cuo5IefDWgu?=
 =?us-ascii?Q?9yfQmAtBJS71uf3BUg9hEJCGRW7zuBQRoIoTn9CGBJwxTOh4s1xIM6bkMze0?=
 =?us-ascii?Q?VADMGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de740e8-b07c-435b-6bf3-08d9d59cfa49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 07:27:23.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pztCZswG31GtVM8rP+glOajkEdgDHkU8nLnSe1J2jh0Jmr2LCjovORB7m9RdsDPMQmDVsQWYQYgdDLF82DVSEW7QX/3W6BgX6Zg909CP/k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6860
X-Proofpoint-GUID: RRpZ0OkK0MNqMj3t_MMHXb-kTmBRyhPb
X-Proofpoint-ORIG-GUID: RRpZ0OkK0MNqMj3t_MMHXb-kTmBRyhPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_02,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=692 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Wed, Jan 12, 2022 at 06:32:37AM +0100, Pawel Laszczak wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> Variable ret in function cdnsp_decode_trb is initialized but not
>> used. To fix this compiler warning patch adds checking whether the
>> data buffer has not been overflowed.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-debug.h | 305 ++++++++++++++++----------------
>>  1 file changed, 154 insertions(+), 151 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-d=
ebug.h
>> index a8776df2d4e0..f0ca865cce2a 100644
>> --- a/drivers/usb/cdns3/cdnsp-debug.h
>> +++ b/drivers/usb/cdns3/cdnsp-debug.h
>> @@ -182,208 +182,211 @@ static inline const char *cdnsp_decode_trb(char =
*str, size_t size, u32 field0,
>>  	int ep_id =3D TRB_TO_EP_INDEX(field3) - 1;
>>  	int type =3D TRB_FIELD_TO_TYPE(field3);
>>  	unsigned int ep_num;
>> -	int ret =3D 0;
>> +	int ret;
>>  	u32 temp;
>>
>>  	ep_num =3D DIV_ROUND_UP(ep_id, 2);
>>
>>  	switch (type) {
>>  	case TRB_LINK:
>> -		ret +=3D snprintf(str, size,
>> -				"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
>> -				field1, field0, GET_INTR_TARGET(field2),
>> -				cdnsp_trb_type_string(type),
>> -				field3 & TRB_IOC ? 'I' : 'i',
>> -				field3 & TRB_CHAIN ? 'C' : 'c',
>> -				field3 & TRB_TC ? 'T' : 't',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
>> +			       field1, field0, GET_INTR_TARGET(field2),
>> +			       cdnsp_trb_type_string(type),
>> +			       field3 & TRB_IOC ? 'I' : 'i',
>> +			       field3 & TRB_CHAIN ? 'C' : 'c',
>> +			       field3 & TRB_TC ? 'T' : 't',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_TRANSFER:
>>  	case TRB_COMPLETION:
>>  	case TRB_PORT_STATUS:
>>  	case TRB_HC_EVENT:
>> -		ret +=3D snprintf(str, size,
>> -				"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
>> -				" len %ld slot %ld flags %c:%c",
>> -				ep_num, ep_id % 2 ? "out" : "in",
>> -				TRB_TO_EP_INDEX(field3),
>> -				cdnsp_trb_type_string(type), field1, field0,
>> -				cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
>> -				EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
>> -				field3 & EVENT_DATA ? 'E' : 'e',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
>> +			       " len %ld slot %ld flags %c:%c",
>> +			       ep_num, ep_id % 2 ? "out" : "in",
>> +			       TRB_TO_EP_INDEX(field3),
>> +			       cdnsp_trb_type_string(type), field1, field0,
>> +			       cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
>> +			       EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
>> +			       field3 & EVENT_DATA ? 'E' : 'e',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_MFINDEX_WRAP:
>> -		ret +=3D snprintf(str, size, "%s: flags %c",
>> -				cdnsp_trb_type_string(type),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size, "%s: flags %c",
>> +			       cdnsp_trb_type_string(type),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_SETUP:
>> -		ret +=3D snprintf(str, size,
>> -				"type '%s' bRequestType %02x bRequest %02x "
>> -				"wValue %02x%02x wIndex %02x%02x wLength %d "
>> -				"length %ld TD size %ld intr %ld Setup ID %ld "
>> -				"flags %c:%c:%c",
>> -				cdnsp_trb_type_string(type),
>> -				field0 & 0xff,
>> -				(field0 & 0xff00) >> 8,
>> -				(field0 & 0xff000000) >> 24,
>> -				(field0 & 0xff0000) >> 16,
>> -				(field1 & 0xff00) >> 8,
>> -				field1 & 0xff,
>> -				(field1 & 0xff000000) >> 16 |
>> -				(field1 & 0xff0000) >> 16,
>> -				TRB_LEN(field2), GET_TD_SIZE(field2),
>> -				GET_INTR_TARGET(field2),
>> -				TRB_SETUPID_TO_TYPE(field3),
>> -				field3 & TRB_IDT ? 'D' : 'd',
>> -				field3 & TRB_IOC ? 'I' : 'i',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "type '%s' bRequestType %02x bRequest %02x "
>> +			       "wValue %02x%02x wIndex %02x%02x wLength %d "
>> +			       "length %ld TD size %ld intr %ld Setup ID %ld "
>> +			       "flags %c:%c:%c",
>> +			       cdnsp_trb_type_string(type),
>> +			       field0 & 0xff,
>> +			       (field0 & 0xff00) >> 8,
>> +			       (field0 & 0xff000000) >> 24,
>> +			       (field0 & 0xff0000) >> 16,
>> +			       (field1 & 0xff00) >> 8,
>> +			       field1 & 0xff,
>> +			       (field1 & 0xff000000) >> 16 |
>> +			       (field1 & 0xff0000) >> 16,
>> +			       TRB_LEN(field2), GET_TD_SIZE(field2),
>> +			       GET_INTR_TARGET(field2),
>> +			       TRB_SETUPID_TO_TYPE(field3),
>> +			       field3 & TRB_IDT ? 'D' : 'd',
>> +			       field3 & TRB_IOC ? 'I' : 'i',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_DATA:
>> -		ret +=3D snprintf(str, size,
>> -				"type '%s' Buffer %08x%08x length %ld TD size %ld "
>> -				"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
>> -				cdnsp_trb_type_string(type),
>> -				field1, field0, TRB_LEN(field2),
>> -				GET_TD_SIZE(field2),
>> -				GET_INTR_TARGET(field2),
>> -				field3 & TRB_IDT ? 'D' : 'i',
>> -				field3 & TRB_IOC ? 'I' : 'i',
>> -				field3 & TRB_CHAIN ? 'C' : 'c',
>> -				field3 & TRB_NO_SNOOP ? 'S' : 's',
>> -				field3 & TRB_ISP ? 'I' : 'i',
>> -				field3 & TRB_ENT ? 'E' : 'e',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "type '%s' Buffer %08x%08x length %ld TD size %ld "
>> +			       "intr %ld flags %c:%c:%c:%c:%c:%c:%c",
>> +			       cdnsp_trb_type_string(type),
>> +			       field1, field0, TRB_LEN(field2),
>> +			       GET_TD_SIZE(field2),
>> +			       GET_INTR_TARGET(field2),
>> +			       field3 & TRB_IDT ? 'D' : 'i',
>> +			       field3 & TRB_IOC ? 'I' : 'i',
>> +			       field3 & TRB_CHAIN ? 'C' : 'c',
>> +			       field3 & TRB_NO_SNOOP ? 'S' : 's',
>> +			       field3 & TRB_ISP ? 'I' : 'i',
>> +			       field3 & TRB_ENT ? 'E' : 'e',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_STATUS:
>> -		ret +=3D snprintf(str, size,
>> -				"Buffer %08x%08x length %ld TD size %ld intr"
>> -				"%ld type '%s' flags %c:%c:%c:%c",
>> -				field1, field0, TRB_LEN(field2),
>> -				GET_TD_SIZE(field2),
>> -				GET_INTR_TARGET(field2),
>> -				cdnsp_trb_type_string(type),
>> -				field3 & TRB_IOC ? 'I' : 'i',
>> -				field3 & TRB_CHAIN ? 'C' : 'c',
>> -				field3 & TRB_ENT ? 'E' : 'e',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "Buffer %08x%08x length %ld TD size %ld intr"
>> +			       "%ld type '%s' flags %c:%c:%c:%c",
>> +			       field1, field0, TRB_LEN(field2),
>> +			       GET_TD_SIZE(field2),
>> +			       GET_INTR_TARGET(field2),
>> +			       cdnsp_trb_type_string(type),
>> +			       field3 & TRB_IOC ? 'I' : 'i',
>> +			       field3 & TRB_CHAIN ? 'C' : 'c',
>> +			       field3 & TRB_ENT ? 'E' : 'e',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_NORMAL:
>>  	case TRB_ISOC:
>>  	case TRB_EVENT_DATA:
>>  	case TRB_TR_NOOP:
>> -		ret +=3D snprintf(str, size,
>> -				"type '%s' Buffer %08x%08x length %ld "
>> -				"TD size %ld intr %ld "
>> -				"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
>> -				cdnsp_trb_type_string(type),
>> -				field1, field0, TRB_LEN(field2),
>> -				GET_TD_SIZE(field2),
>> -				GET_INTR_TARGET(field2),
>> -				field3 & TRB_BEI ? 'B' : 'b',
>> -				field3 & TRB_IDT ? 'T' : 't',
>> -				field3 & TRB_IOC ? 'I' : 'i',
>> -				field3 & TRB_CHAIN ? 'C' : 'c',
>> -				field3 & TRB_NO_SNOOP ? 'S' : 's',
>> -				field3 & TRB_ISP ? 'I' : 'i',
>> -				field3 & TRB_ENT ? 'E' : 'e',
>> -				field3 & TRB_CYCLE ? 'C' : 'c',
>> -				!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
>> +		ret =3D snprintf(str, size,
>> +			       "type '%s' Buffer %08x%08x length %ld "
>> +			       "TD size %ld intr %ld "
>> +			       "flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
>> +			       cdnsp_trb_type_string(type),
>> +			       field1, field0, TRB_LEN(field2),
>> +			       GET_TD_SIZE(field2),
>> +			       GET_INTR_TARGET(field2),
>> +			       field3 & TRB_BEI ? 'B' : 'b',
>> +			       field3 & TRB_IDT ? 'T' : 't',
>> +			       field3 & TRB_IOC ? 'I' : 'i',
>> +			       field3 & TRB_CHAIN ? 'C' : 'c',
>> +			       field3 & TRB_NO_SNOOP ? 'S' : 's',
>> +			       field3 & TRB_ISP ? 'I' : 'i',
>> +			       field3 & TRB_ENT ? 'E' : 'e',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c',
>> +			       !(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
>>  		break;
>>  	case TRB_CMD_NOOP:
>>  	case TRB_ENABLE_SLOT:
>> -		ret +=3D snprintf(str, size, "%s: flags %c",
>> -				cdnsp_trb_type_string(type),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size, "%s: flags %c",
>> +			       cdnsp_trb_type_string(type),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_DISABLE_SLOT:
>> -		ret +=3D snprintf(str, size, "%s: slot %ld flags %c",
>> -				cdnsp_trb_type_string(type),
>> -				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size, "%s: slot %ld flags %c",
>> +			       cdnsp_trb_type_string(type),
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_ADDR_DEV:
>> -		ret +=3D snprintf(str, size,
>> -				"%s: ctx %08x%08x slot %ld flags %c:%c",
>> -				cdnsp_trb_type_string(type), field1, field0,
>> -				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_BSR ? 'B' : 'b',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "%s: ctx %08x%08x slot %ld flags %c:%c",
>> +			       cdnsp_trb_type_string(type), field1, field0,
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       field3 & TRB_BSR ? 'B' : 'b',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_CONFIG_EP:
>> -		ret +=3D snprintf(str, size,
>> -				"%s: ctx %08x%08x slot %ld flags %c:%c",
>> -				cdnsp_trb_type_string(type), field1, field0,
>> -				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_DC ? 'D' : 'd',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "%s: ctx %08x%08x slot %ld flags %c:%c",
>> +			       cdnsp_trb_type_string(type), field1, field0,
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       field3 & TRB_DC ? 'D' : 'd',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_EVAL_CONTEXT:
>> -		ret +=3D snprintf(str, size,
>> -				"%s: ctx %08x%08x slot %ld flags %c",
>> -				cdnsp_trb_type_string(type), field1, field0,
>> -				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "%s: ctx %08x%08x slot %ld flags %c",
>> +			       cdnsp_trb_type_string(type), field1, field0,
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_RESET_EP:
>>  	case TRB_HALT_ENDPOINT:
>>  	case TRB_FLUSH_ENDPOINT:
>> -		ret +=3D snprintf(str, size,
>> -				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
>> -				cdnsp_trb_type_string(type),
>> -				ep_num, ep_id % 2 ? "out" : "in",
>> -				TRB_TO_EP_INDEX(field3), field1, field0,
>> -				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
>> +			       cdnsp_trb_type_string(type),
>> +			       ep_num, ep_id % 2 ? "out" : "in",
>> +			       TRB_TO_EP_INDEX(field3), field1, field0,
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_STOP_RING:
>> -		ret +=3D snprintf(str, size,
>> -				"%s: ep%d%s(%d) slot %ld sp %d flags %c",
>> -				cdnsp_trb_type_string(type),
>> -				ep_num, ep_id % 2 ? "out" : "in",
>> -				TRB_TO_EP_INDEX(field3),
>> -				TRB_TO_SLOT_ID(field3),
>> -				TRB_TO_SUSPEND_PORT(field3),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "%s: ep%d%s(%d) slot %ld sp %d flags %c",
>> +			       cdnsp_trb_type_string(type),
>> +			       ep_num, ep_id % 2 ? "out" : "in",
>> +			       TRB_TO_EP_INDEX(field3),
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       TRB_TO_SUSPEND_PORT(field3),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_SET_DEQ:
>> -		ret +=3D snprintf(str, size,
>> -				"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
>> -				cdnsp_trb_type_string(type),
>> -				ep_num, ep_id % 2 ? "out" : "in",
>> -				TRB_TO_EP_INDEX(field3), field1, field0,
>> -				TRB_TO_STREAM_ID(field2),
>> -				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size,
>> +			       "%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
>> +			       cdnsp_trb_type_string(type),
>> +			       ep_num, ep_id % 2 ? "out" : "in",
>> +			       TRB_TO_EP_INDEX(field3), field1, field0,
>> +			       TRB_TO_STREAM_ID(field2),
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_RESET_DEV:
>> -		ret +=3D snprintf(str, size, "%s: slot %ld flags %c",
>> -				cdnsp_trb_type_string(type),
>> -				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		ret =3D snprintf(str, size, "%s: slot %ld flags %c",
>> +			       cdnsp_trb_type_string(type),
>> +			       TRB_TO_SLOT_ID(field3),
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	case TRB_ENDPOINT_NRDY:
>> -		temp  =3D TRB_TO_HOST_STREAM(field2);
>> -
>> -		ret +=3D snprintf(str, size,
>> -				"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
>> -				cdnsp_trb_type_string(type),
>> -				ep_num, ep_id % 2 ? "out" : "in",
>> -				TRB_TO_EP_INDEX(field3), temp,
>> -				temp =3D=3D STREAM_PRIME_ACK ? "(PRIME)" : "",
>> -				temp =3D=3D STREAM_REJECTED ? "(REJECTED)" : "",
>> -				TRB_TO_DEV_STREAM(field0),
>> -				field3 & TRB_STAT ? 'S' : 's',
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +		temp =3D TRB_TO_HOST_STREAM(field2);
>> +
>> +		ret =3D snprintf(str, size,
>> +			       "%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
>> +			       cdnsp_trb_type_string(type),
>> +			       ep_num, ep_id % 2 ? "out" : "in",
>> +			       TRB_TO_EP_INDEX(field3), temp,
>> +			       temp =3D=3D STREAM_PRIME_ACK ? "(PRIME)" : "",
>> +			       temp =3D=3D STREAM_REJECTED ? "(REJECTED)" : "",
>> +			       TRB_TO_DEV_STREAM(field0),
>> +			       field3 & TRB_STAT ? 'S' : 's',
>> +			       field3 & TRB_CYCLE ? 'C' : 'c');
>>  		break;
>>  	default:
>> -		ret +=3D snprintf(str, size,
>> -				"type '%s' -> raw %08x %08x %08x %08x",
>> -				cdnsp_trb_type_string(type),
>> -				field0, field1, field2, field3);
>> +		ret =3D snprintf(str, size,
>> +			       "type '%s' -> raw %08x %08x %08x %08x",
>> +			       cdnsp_trb_type_string(type),
>> +			       field0, field1, field2, field3);
>>  	}
>>
>> +	if (ret >=3D size)
>> +		pr_info("CDNSP: buffer overflowed.\n");
>
>"info"?
>
>If the buffer overflows, was it properly truncated?  Or did we just
>crash something else by passing on an overflowed buffer?

Yes, data will be properly truncated. Driver and kernel will not crash.=20
So, I added only information that some debug date may have been truncated.

Thanks,

Pawel Laszczak
