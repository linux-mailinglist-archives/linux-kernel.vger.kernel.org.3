Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21D848AB89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiAKKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:39:02 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:12828 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237556AbiAKKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:39:00 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20B7qql4017732;
        Tue, 11 Jan 2022 02:38:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ZdfyxTPs8eV0x42Gjp24kRxAwrDpXP/Dn35t9Rc0qA4=;
 b=aP7p0xC3Mc0zTO7mG7xkBuzncKxErU+aP2QAkBD+pPXACJc0KgsWiK73oC7hQgHU0+Gk
 gZomYliid41q/TkjNwkWb7VQIi1kv+SA5WFga6Pm3kzjSleF9BhSUfrmjgKIfV0Q37T2
 RwDo91IYm9aCUoOR3HXjZ8EQ1w48BJOSmGU3n9ss1CRYeIcmUOH616hfGSBcWZ1pbkXy
 IHbjvDaIJv6vysENL2wZnBBU8kQsFLTtNzzbGB1dgrPlkMrn4S4ljbrN2xpyEPlKI1sY
 QioQbPQ9RX446hg3EZQkrK0k0/lYzDP8fOdPW9k/mGoe09TOckcPaSECZwQJXTDahNkn zQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dgkxpkq63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 02:38:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSnON9rvRiG/2zKGwT40H9QSsPublT7iBSstdcC8DMJD5kmRqDFn4SpsQfIJn8Jwy8Rgzd7uXZS1DcNYfRI4YVgbFMiECsd4emja1iHigVao4qBvES6jEYzma1M/V5K5O3YPcEKOHfZtoLRtvCXV62eyEDLnxkw0b6BYQn3WQvg8FMYQxwnQB5eOKqWA6EFBNq1WtmruNwEZC7Vv9A0azxuiWJtq/KWWvXXgd+Qo/qCNTMGpt4ATNONB6clN2KVuxu5cCnjyOJPlGaLlatvq0OmHR7kLXATqK8sl+WnwcMXcWx+5VAkYjE32xIPnRwGU5/BuFl+RoU5WycmCWS92/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdfyxTPs8eV0x42Gjp24kRxAwrDpXP/Dn35t9Rc0qA4=;
 b=Mt5EjbOUa2TDDuHvoipxwPp6ttZqoA+qVjhjZm5Q8lGwTSWMkhM1I8/NQ8RBVJePDiAEC10Rvh8ypLL23mT8q/A10++axnowm49C0BGTB7xvEK00p0Y1sqRAaG0GfzQT05PdbzgjAMwTPe/4j4vffPiaNFcdVjLTj1D0NvLsNA0+TTBpjZ0iURHtO3mbH9cHVb+ldL+kSvquYX+auODU/aS7agPsO6EJgnT6yJROKJbjSwrEDQTx6YG0uS2uq61aTEl078sXLvuObnCtcjcNtan4YtZsd4Zmj4FOPZ1LUO3xF6F6wCq8brbcx98kn1JfhcudD9ZrOunn+TptMHp5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdfyxTPs8eV0x42Gjp24kRxAwrDpXP/Dn35t9Rc0qA4=;
 b=0vcxj+66enRBxGQ+aPAdT50y6B7ZtGFRjCAAGFitIod7DlPaLg4NdDawHzX4havF90ibMysjLIdKNIA89AbPblGzjAR385eJj5XYD0iiJQ24Pt2AKny31X10uQdIwbLRlz4wBXT3JLlFTm0OMEnLz1A+V5LN2udkbo4r7T3559Q=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BY5PR07MB7125.namprd07.prod.outlook.com (2603:10b6:a03:1ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 10:38:53 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::c0b7:f4e5:466b:e90a]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::c0b7:f4e5:466b:e90a%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 10:38:53 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: remove not used variables
Thread-Topic: [PATCH] usb: cdnsp: remove not used variables
Thread-Index: AQHYBsmd7ay/0pnSSk+3KxumqEbpjaxdiS4AgAASnDA=
Date:   Tue, 11 Jan 2022 10:38:53 +0000
Message-ID: <BYAPR07MB53811E109250D3D9C6447847DD519@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20220111085934.44844-1-pawell@gli-login.cadence.com>
 <Yd1KBiRB/ByZ2Kx1@kroah.com>
In-Reply-To: <Yd1KBiRB/ByZ2Kx1@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTlhZTYxMDAtNzJjYS0xMWVjLTg3YTgtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGE5YWU2MTAxLTcyY2EtMTFlYy04N2E4LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMjg1NyIgdD0iMTMyODYzNzExMzA4MDM1MjUxIiBoPSJrSVRPczA2U3V6Z0xObmJzZVc2eVpoendSbDQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d33a059e-f78e-46cc-c604-08d9d4ee9012
x-ms-traffictypediagnostic: BY5PR07MB7125:EE_
x-microsoft-antispam-prvs: <BY5PR07MB7125FF66A1FAA59C3E89E531DD519@BY5PR07MB7125.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MADCaxwvky2/GFI3EKo5lw+zglhQ+UAEVqFvlLpBk+CIiXqNQE2X2rLs1tB4YrP9ukurI3ZUH6G9Pflhkaia22OYRnEnjy41L494hEn6sUHbqx/DbspZO3zuRi0rzaaucHyzFJZrgBLChfrSk61d+IhwpfF1FBS/+MM461/0hGVSnu4ZVKHb021i1HwB5orUsOOzrgZsfSd2HRVKkiFs5D5WscOCZHs5KSjxxWz7fn7ak6iAsjVnFrN6RVUasZw5m2GgRzMg5LlX8TBHzNdKfdHMrl6dpazHGgg6+YsSgQsOkpXBbNk9Og7T6gGyDls2FOjTGkxcquR6xlbe5brxcm1ORxmhn47G0feDxr1MIlPk+l14+UecYCpbsD3/XZtu8KQ6T5LKHrFVx2IIp/bfeOvnqDnTb4sWVuQC++oNVOpXz5nV51r0o1oX/1X7phdw9E0L+RIJT036C4AwVw9O2NIJOCBCDfvanBqRqVFux4rCBiq2ccd0jN0vG2/wSlCrvuD5DWuu0EHyJ+6X5KnxMJIctBR4x2jhGQrC2gBYirPF3+dYrOI+Vqm1AaeQ4X5oxKbNHcqyOaBBPY/B1Vrv2N/NxbQSqApsMFd4RSpBZARMlt/UXQHHemaNoQwmEqe3G7k8mdGH3ekYbe2Uk9G7cStWrDt4L2Psx9WuFr4o+1EKhu4XYYxAH0LTjN+f4b9327DZ4TJqUiVG2gwXyJE86KtADcdT9OWQ0Njzufq2sDJ49jaZ3JUiHnaA068c2i3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(66476007)(4326008)(26005)(8936002)(83380400001)(316002)(76116006)(5660300002)(64756008)(38100700002)(66446008)(6916009)(122000001)(66946007)(54906003)(66556008)(71200400001)(186003)(9686003)(38070700005)(8676002)(86362001)(6506007)(7696005)(2906002)(33656002)(52536014)(55016003)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mLyB5uguuLwW+xYxfF+KKEo6IwcefYG3jsyhaMG2XopTM6Of7JUPmUtTBqAL?=
 =?us-ascii?Q?d/o1w9sEJ85IbJZ7q/WMuppzSPmTGjKPi3dsJE98SyGcfBm6sMJe9TrVM9Ae?=
 =?us-ascii?Q?RoHTpM3nVqMLOWWjJ8h9nbT+ghTf98dHZbBPl6RtYG0nEAMWALLvQKfTuOiP?=
 =?us-ascii?Q?fLVypRy1cqOijNzD31FkRY6SBDCoEFTI6nc71a37oGfYu6+Uj1u72Pa4ZP67?=
 =?us-ascii?Q?Csheth11vGkwWPFyBscZNuED4JLNQ9yDBdG5S3N54DaE5Uo/HqEEkY/Uz5/n?=
 =?us-ascii?Q?b4rvkvoIbkabMnEKo4+bqdehPsXnY46MwOUX2gg8GrLsMLsCqb7h/hKUPpcn?=
 =?us-ascii?Q?mTZ8qdgwXBLtaqDwfYnPAddcc4EWtyWI9O9LkvKIdMWMJYbjYbXe8qA2FgCF?=
 =?us-ascii?Q?hhZcKVIJWC2SOvTu6myhld3RXEUsvqZQRRz66bQYRFwpmkTVYwl1VmIkyjrr?=
 =?us-ascii?Q?1jmflhd98ft9TSlwc2T/NVICpEQTLXpGqFMFMF2jiMN9BkmXAxuoFaXsFqWR?=
 =?us-ascii?Q?quyf0IiiqgX1rsstkaDdWPillSf9oIxTuKrA5kr6ntctp1rGN0vXzYKJYdPs?=
 =?us-ascii?Q?2twAw7mLA+LwncpyzPK5YdPpKoxWPZnbJy8ScxczaQ7GGJ5NXewN4OXpPPkY?=
 =?us-ascii?Q?NmCcEkSQI2Mr7aSRByCyVHuz3XfCeSxt6rZwE1tE/dxYqYhN+mNMdC+Ivz45?=
 =?us-ascii?Q?p1ODjPB3ZiIuiqwlnng+Tt0e9yKsa+vdvJ7lzutZv3MOF0TskMU2F3QusZ+J?=
 =?us-ascii?Q?cUPUcAFgvYznpYf+Tu+Jmi36BcG17ffKjT6oI1w0HNJ7P4UpOsRT/rYUzpVB?=
 =?us-ascii?Q?N7PzPK9hmxa8jcY3AC/hd86RsIIcQNLC/Ni72G4QbLh+LqipmOKEdVodkFkN?=
 =?us-ascii?Q?+QQoo0/6N+i1jPvjIqLpnx6yNjGTf39h2qmto04gE7C6jQQ46qILJfC4PXOw?=
 =?us-ascii?Q?k5J11rsJXj7nlKtodCum2QhyvSOSDF/zvI8waUA8b/Ks4uXL8uzdYi4LLONs?=
 =?us-ascii?Q?Oaiq0McYw80XD57flZYRRy8cMNmi7Po0ffinAQZ1o38P6+lL96MsClEmGsGd?=
 =?us-ascii?Q?2h/q+fXN1f7UIJbby2mlYs3Pv0P52Qh7wjy0TpZU18T/IIchEdmvUbjHUwyW?=
 =?us-ascii?Q?kIDFIO1/P39i409BQbEhs4PIr+40X65H10w4eta0KisJd8RL9I815UF58HRw?=
 =?us-ascii?Q?55nC27gRdEwTBmHWA5NQSlI+kmKB2d8IHO7ccxeAvnqYFkEMMHLJgW4Pk9fK?=
 =?us-ascii?Q?Qlq2Swag3jIQsmTT5VdLkD4pctXXYoQlj4/HDxiiIlYFFXhVqjNHaqyM89j1?=
 =?us-ascii?Q?6wfMFx6vnBUloUPNTG0oTdAZWM0sDP+7DbdjXiQuYjEcpUkvVQuRpaG5PY0w?=
 =?us-ascii?Q?Jm+53QosZuiuMKTHmG5vIfzLEeNW0jkR4jpCb5pZuhHuovhw0Iiq4vVdJ3p0?=
 =?us-ascii?Q?onQUF0SLfMR0+F/XX/TwaCOW0bkVnsyV5hoHclZPDqr85DKJcC1ruRZI9aNB?=
 =?us-ascii?Q?zHmApi+v9AGVVm7hBmpMdYwF/JSZhsrwH2eWrrjGGKM16f5Aym76ISpjpShd?=
 =?us-ascii?Q?FLLacM9g6wziRg9iPQKV/NhmvoHTgiezSzHIoDLHd/WACqZXooJOB0/3s/pN?=
 =?us-ascii?Q?RqQqMYCD3oL16EIa9Wtu7PW3WHPwYlXsO73r/MOTq/Q8EfMMtWWKIOd95rBU?=
 =?us-ascii?Q?um7/Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33a059e-f78e-46cc-c604-08d9d4ee9012
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 10:38:53.3309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6wZ8ccDX6akH2NC56vYCdwgGVO3TPUAU7vF20GbL/K1ZnGZ/sVZbm+qP2Pyme6Pwn5dBpciOm6TiFKKI2qwnv56/Y4WUZwnHPc/U66ZhuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7125
X-Proofpoint-GUID: V4wyNwqygZbXLp9IzVAfLKB2OX1IOVwL
X-Proofpoint-ORIG-GUID: V4wyNwqygZbXLp9IzVAfLKB2OX1IOVwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=939 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Tue, Jan 11, 2022 at 09:59:34AM +0100, Pawel Laszczak wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> Patch removes not used variables:
>>  - ret from cdnsp_decode_trb function
>>  - temp_64 from cdnsp_run function
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-debug.h  | 287 +++++++++++++++----------------
>>  drivers/usb/cdns3/cdnsp-gadget.c |   3 -
>>  2 files changed, 138 insertions(+), 152 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-d=
ebug.h
>> index a8776df2d4e0..29f3cf7ddbaa 100644
>> --- a/drivers/usb/cdns3/cdnsp-debug.h
>> +++ b/drivers/usb/cdns3/cdnsp-debug.h
>> @@ -182,206 +182,195 @@ static inline const char *cdnsp_decode_trb(char =
*str, size_t size, u32 field0,
>>  	int ep_id =3D TRB_TO_EP_INDEX(field3) - 1;
>>  	int type =3D TRB_FIELD_TO_TYPE(field3);
>>  	unsigned int ep_num;
>> -	int ret =3D 0;
>
>Please fix this function to properly handle the ret value, as I think it
>should be checked, right?

I think that it is not needed. Function is used only in one place in trace =
point in TP_printk. The buffer is
big enough (500 bytes) to accommodate whole string.  In this form function =
can be directly used in
TP_printk. If we will use ret instead of string as return type, then driver=
 will need to format this string before
calling trace point function and pass this ass parameter.  This solution wi=
ll have impact for code size and
performance even if we disable tracing

>
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -1243,12 +1243,9 @@ static int cdnsp_run(struct cdnsp_device *pdev,
>>  		     enum usb_device_speed speed)
>>  {
>>  	u32 fs_speed =3D 0;
>> -	u64 temp_64;
>>  	u32 temp;
>>  	int ret;
>>
>> -	temp_64 =3D cdnsp_read_64(&pdev->ir_set->erst_dequeue);
>> -	temp_64 &=3D ~ERST_PTR_MASK;
>>  	temp =3D readl(&pdev->ir_set->irq_control);
>>  	temp &=3D ~IMOD_INTERVAL_MASK;
>>  	temp |=3D ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
>> --
>> 2.25.1
>>
>
>A separate patch for this.
>
>Also, are you SURE this is ok to do?  Did you check it on the hardware
>that a read is not needed here for it to work properly?
>
>This type of "warning" is horrible for dealing with hardware devices,
>always treat it as incorrect unless you can prove otherwise.
>

Yes, I've tested it. I think that it was used in some printk and by mistake=
 has not been removed.=20

The warning was reported by Intel kernel test robot and fix are very simple=
. Patch is little bigger
because some code had to be reformatted. =20

Do I really need to send this as two separate patches

thanks,

Pawel Laszczak
