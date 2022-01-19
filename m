Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98864493776
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352643AbiASJiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:38:54 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29658 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235918AbiASJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:38:51 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J4LHL2003759;
        Wed, 19 Jan 2022 04:38:47 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dnw0vcwq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 04:38:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFFYPwShtPcyXsM5v928cOJk6JjOlLyCEXr8oVtZDgLh9VugszaLTwFSzqJSHLBJpzTmwh/xnjGkfwDmJlt4pJHS1U4bZPpVRNTrybaIqBjj6XpNli/rcG3c+GOVD1l/WH++0vVtigJpGSKDBM0BMf1/Qff1+gcbcWHypxJjqrfjO/aHiHaWlFVT+LM4QrQec2PDPHxb1AQpE5RSQPCra1jrrezuLHNvjdQJsOqLd+EdY3ozsdtcxhgtqx+bDSItfkB5htEUcjTYBa55fMs/t5Xs8Bxsl57fnWOf6uU1AW5GEgzwMemL1+NBB0qoX+G1zcFeZHMKmJs+Yo0aPEnGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xztSbkCw4v5bs2IPnUgsK1QbP4DVyh6tbha1p2x3KhU=;
 b=Yo3oCFjXy+P4JB9rBbHNgYuBNc3UaGRg72tJIYhvpRi0Vv2pRuLVPExhbHhR39s4nAm9LZD/Dfb7PVkmVTBQpOe/1xt63aRVWbsm8HadEzYSVMXFCXtHOyFQGQNfSuy8jb5exGGMWTMUGIRc56/ek87PGxANO9dqrJ4FdF4UQfyGCYz5m6xoqCssW+YwlCYhnfbTzDT/rnhg3pD65qohiXI8N5lsx34XL3jkRhJanUhE4sNNIzpmWdasl38xSM3gDH0DYek4YHzZH/QIReb3Qo05xffmkLgx42y1av7wm6VAx1cDNUq37ZZBsTFaJ1frc1SQjW+NxqZk5bVc3zNFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xztSbkCw4v5bs2IPnUgsK1QbP4DVyh6tbha1p2x3KhU=;
 b=I2VWR4cy0HgLJ6NwcDbxXwrL3++6gxaMIXRDaTGxlsgu5f+CjXaykr5cKNqVFyia5SL8gWgO2dTti1i2cnc3OaTPV+02B+WIXRPyo1us/HkDfRll28URd+yjHRsm6glsH54lr0KXp6fgwGyQovg/BMEyPtz6FEY846fSJJvkr+k=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6557.namprd03.prod.outlook.com (2603:10b6:510:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 09:38:45 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%5]) with mapi id 15.20.4844.016; Wed, 19 Jan 2022
 09:38:45 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Pop, Cristian" <Cristian.Pop@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit
 ADC-DAC
Thread-Topic: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit
 ADC-DAC
Thread-Index: AQHYBuEH6Xi3N0MJ30e3Zm8eCa4LKaxlkU8AgASOs1A=
Date:   Wed, 19 Jan 2022 09:38:45 +0000
Message-ID: <PH0PR03MB67860B9234F17970836FB0D499599@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220111115919.14645-1-cristian.pop@analog.com>
        <20220111115919.14645-2-cristian.pop@analog.com>
 <20220116115228.1f7b4728@jic23-huawei>
In-Reply-To: <20220116115228.1f7b4728@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOTYzZGEwYzQtNzkwYi0xMWVjLThiYmItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDk2M2RhMGM1LTc5MGItMTFlYy04YmJiLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjU5OSIgdD0iMTMyODcwNTg3Mj?=
 =?iso-8859-1?Q?I1NTg1NDg1IiBoPSJoUm12endtbGpidEVuVnJudlhackhyNS8zcGs9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJOdDYxWUdBM1lBU3ZsU0F1a1A4aGhLK1ZJQzZRL3lHRURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6185d905-3442-4886-2409-08d9db2f7cbd
x-ms-traffictypediagnostic: PH0PR03MB6557:EE_
x-microsoft-antispam-prvs: <PH0PR03MB65576A72929C30359765AFD399599@PH0PR03MB6557.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Mm+USrdV4QfFmI+OWF8pGQ1G1ePMTnnUtDJ/gj88UXnGBaYjy24s7ZQslXtrSI2EhAok/N/etJq8VUIUuYv5wF3hnI5wwr9i64Stpn0QVGaZzoovCol8phLwI+17cD0oS85/WsNb+fXEcBUBHJVBgQprxSM2sU3+zST7WXAnlivpEiUthzYQNoTkU0sw9idPSUzrEvzJ5apUI9K/W+SEjo3tozAbKjZtsTK4J9lAR8Xkb6fajH24283Mk49rRDwAWouYsoLXjY/yaxXl87FTDa4gXIXYCz6ZVZtD9Ez9qvKc91hsRQVFtzY2MLpCJiyD3hlo+vVKP/QBSv+8ms8UmMaLO6Qq/L2M8k+phS4w0BcY+AUUcDv8tj5oI1ryJE05o3aEFl0CF4DJNp3GCAnU0HaqiqbaiOL0HsUsG6KRVif10iDgVL+npasc7uQcHx2Cb3bxwWriGXG9IcXvCJI4aTDUhF2ev2/eilfuCx2lb8812rEeDhkNLYZ2P1QBlDsJdJ7DX/7x/MHqzra/AVg3R0tGrbANwcUKrwosIOZeGfxK4uVfSnSgZwJTURdEm3DqSD8DHeus/JSP1JDyb1LLNw68x+eof7UvL2b3PSoauBAXxD0lvZn3mL1GRJIEnLORrXcNjzXRU26S+VMBb1RpaldtnDtF5Mc6jNUxhujd5ZAS11KGWxhqeqn+6FXKOy272TlBU7K7xCQPTS19XdiIFV02UzYXzQ3Sl3Cwo9RunTbNpGkfoPwL2LATRtB74JcNbY5LzWHJyW3UMTOhlzRFYkU/k7HdmolFLa/0qjnHoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(122000001)(66476007)(966005)(55016003)(76116006)(508600001)(38070700005)(54906003)(110136005)(316002)(38100700002)(6636002)(5660300002)(66446008)(86362001)(64756008)(66556008)(33656002)(52536014)(66946007)(186003)(8676002)(4326008)(8936002)(2906002)(7696005)(53546011)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XWT0RkMTdyMBA87yJ/68KVGVtEyO1Ld4W9BM2Tk5hClqsEsIjzkxusstwe?=
 =?iso-8859-1?Q?J9tzC1Jk6wUUE2VzkY4QAp5kqqtNEnp2U+cMWKPhGXsWexIe8lRehFfqGB?=
 =?iso-8859-1?Q?ckDxwulFYJOYfunBU6b6tT+nF2RmPPz0ZgXFtFC+rbAMUA9MBgHxeAnATH?=
 =?iso-8859-1?Q?HkcymF+XZcXpTktAM0mzbrS8ha6trHAQIK21GruDECn0pH8jty6fAm082+?=
 =?iso-8859-1?Q?wXjjrHtC5L1LA+puDFW9qXunFh48eHv3Zqb4fpWJPcrzFeBqAprpyfg9Xl?=
 =?iso-8859-1?Q?zyllvtjv8IRkL8pnzbHyQucdUSWBcv1gAiuH5SjgBA5Fbb/1Ry4LAS05di?=
 =?iso-8859-1?Q?LA+WBPLdwzdOa6nlN6NnXoXHct0BYJdh2ZnXIiMNc2PtGzUvoGX6CYgMAS?=
 =?iso-8859-1?Q?TqFP5cBMqHPDgavQ1OXDDYkT2JyomqnoH+LH1REWiioVD3EMHCmoOVRb6w?=
 =?iso-8859-1?Q?MGT1sbu4ekOCwHrkSUdjlAR41DdlKzKbZiA4isyYZLBf9KOTYGjsJnKniG?=
 =?iso-8859-1?Q?82uBgayY0cpevXkG04bC6p75aZ7hpc9fwU3WRYNghc8GmEa+NfGo0uYEWY?=
 =?iso-8859-1?Q?XdFq09KzCp354KTtr5njvF4cHrKktA1P05ybxBJj0ebnLiihqRpyrDY5zv?=
 =?iso-8859-1?Q?VrBzSH6cHCJbunhQbP4EFo4Par9Akr1J9IFvIwRNTIAx18THpX56l1eaGu?=
 =?iso-8859-1?Q?XikWPyQkCOMwoiThU7RX7b2O4iqQZ/ldQtRkoj1tfOL181h1kW+yR904oV?=
 =?iso-8859-1?Q?6DcjS4U9ZYgWsUJQVnsZfvtWPEScaQkwV8Uyz6g/6vK2dLcWWmpNO+6xIi?=
 =?iso-8859-1?Q?TsSHXh/NAYPtrE+2tGnPv8oiioQMCLVOg9KEpZAEx0FpaKReQ3EqdED4gx?=
 =?iso-8859-1?Q?I/fzvmbv4rr45oA4sCONkj7TWLejuHD0Ti6DQd9Bke1brJC3j74IvJw8uo?=
 =?iso-8859-1?Q?Md1ea+4+smVMaGaFfAXAgDwPNtnROy+xizcgln6Rwg5/uGmjNeo5KfSYlJ?=
 =?iso-8859-1?Q?H4iueJ4y1zuAAjgI++Wi83YFimZZNyt9B5qT5Cz0xlX1Fw4+3RtP/++VFz?=
 =?iso-8859-1?Q?S4GxVZC4j7kqNH4GejuOG7oDZfese9JlZyb5Q+oE0/n63uL0T/bvcN26Sc?=
 =?iso-8859-1?Q?BPmWEnRUUAt+p1vmhuMzkI6IXuh3TfHE4pNfUhFGPNqSCDh7wRRGRa3hun?=
 =?iso-8859-1?Q?MAUFeAmQDcUhFJnvrEv9Twc59pjrQ/EN6rYlHYY2955cj7zTmgO4gzjYkA?=
 =?iso-8859-1?Q?TAmq/hfuhQ3JFnwxObcEhuLig7rDbmEWMifQhb42yNacm5FnqU285gPCJJ?=
 =?iso-8859-1?Q?f7HOZmlTWju+9draiV2SPa1uydOcmGdKqHpf8J4uiaaOf/laLTJbocnfbN?=
 =?iso-8859-1?Q?+XxBuqNupEpfAAAjJXW1DkN+BIBkUPCpowWCGPpWbKObaf6TvOMVsxKKww?=
 =?iso-8859-1?Q?JaFA4QnIU1eJzb8p/rDt1VFCCqvNZ82PeN2b6H7wa2EhcZ0HVxc3l/SqAW?=
 =?iso-8859-1?Q?a9Rs50i6DJ34kP29QhNzARPojpHNtq8RBJlvlEKwAjNcg7Mnm4Wk9BXfKu?=
 =?iso-8859-1?Q?LVCwM3BB89GFP3eSJokb9UufFk53IXVP41bhDFU/HBmloy4w6KpWK+8CnF?=
 =?iso-8859-1?Q?Q/tW63ndpS9hQ02uN3VmS7R92ZruUwmFqO0HuVwFMsrRjdJ6XQEbZOE/cG?=
 =?iso-8859-1?Q?CmT2mfX18xoPrG8xCi+/p2KGwoKzZdrp0+vfb94S/bs6oPC+F9XBe5kc6K?=
 =?iso-8859-1?Q?Xqu4OX14gb1WWN08w8H0VNvAQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6185d905-3442-4886-2409-08d9db2f7cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 09:38:45.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sv45TOcS6PSpQmzMLQfOLE1aBPWHE89hCmEHlhQXHogeNRwpWRfBNdHZkIJSRIbn8v2WGpNmhFFsRSGLzJ6H7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6557
X-Proofpoint-ORIG-GUID: knayKxp5dsKErl79DkjAUZpNmvKMjckK
X-Proofpoint-GUID: knayKxp5dsKErl79DkjAUZpNmvKMjckK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, January 16, 2022 12:52 PM
> To: Pop, Cristian <Cristian.Pop@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-gpio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org
> Subject: Re: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one
> bit ADC-DAC
>=20
> [External]
>=20
> On Tue, 11 Jan 2022 13:59:19 +0200
> Cristian Pop <cristian.pop@analog.com> wrote:
>=20
> > This allows remote reading and writing of the GPIOs. This is useful in
> > application that run on another PC, at system level, where multiple
> iio
> > devices and GPIO devices are integrated together.
> Hi Cristian,
>=20
> So I fully understand why this can be useful, but it is a software only
> construction so I'm not convinced that it makes sense to necessarily
> configure it via device tree.   A better fit may well be configfs.
> (note I always meant to add configfs controls for iio_hwmon but
> haven't
> found the time to do it yet...)
>=20
> As it currently stands, doing only polled / sysfs reads this driver doesn=
't
> do enough to justify its existence. You could just do all this in
> userspace
> using the existing gpio interfaces.  So to be useful I'd expect it to
> at least do triggered buffer capture.
>=20
> When we have talked about handling digital signals int he past we
> discussed
> whether the IIO channel description would also benefit from tighter
> packing
> than the current minimum of a byte per channel.  Perhaps we don't

That reminded me about this series [1] Alex tried to upstream. It's slightl=
y
related and this was all about supporting buffered channels with less than
8 bits (IIRC). I didn't went through the all thread but I remember you had =
some
"questions" about the whole thing. That series is something that I definite=
ly want
to revive at some point (might be that I just need to change things in ADI =
kernel)
to stop having these custom patches in our tree.

> technically
> 'need' it here but if we do add it in future it will be hard to retrofit =
into
> this driver without big userspace ABI changes (i.e. breaking all existing
> users).

I think this is the perfect opportunity to add support for it (either with =
the series
I mentioned or something else) if we ever really want to have this in IIO.=
=20


[1]: https://lore.kernel.org/linux-iio/20200424051818.6408-1-alexandru.arde=
lean@analog.com/
- Nuno S=E1
=20
