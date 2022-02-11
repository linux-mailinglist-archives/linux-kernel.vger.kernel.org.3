Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D64B274F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350623AbiBKNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:41:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBKNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:41:29 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C995;
        Fri, 11 Feb 2022 05:41:27 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21B5Uvec021828;
        Fri, 11 Feb 2022 08:41:25 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e4s82ybms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 08:41:24 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 21BDUo7m017804;
        Fri, 11 Feb 2022 08:41:24 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e4s82ybmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 08:41:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RattEeCGEaZYaGe4kXZux0emgxSaE2vXeXRrdQ2xygKb62oCoXr6msSCDAsm7UQS11Ae7n/5OVlAXk60DANDMxzOMrENCItvreTYZqlM25MaBy3nRYuzzh8wtD+UKW0tEHE4xhmxhiR3HIoOyc87/sujabXFr+A25661IbD+t0jvl3MCMo2jkl6n8Q6UZGp6J4IOffAwXnxyOcRPSTrhDxmj9jtTztx2gAjUaIjmnMP3UxxTYDpo2iUrTyr31j1BRHCMKqhupiDS8Dm9qu+D0eNnt3niZL0/0AbI8QRSFdL+lW1gnlAZ1l6ZArAtNJLgztxl7UIq11pHaWMfmsU06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWm4KOMwyt7qEOZB6CZvt3cQX+1/ev7OfDmhf8KomYg=;
 b=GJfoFyHZq1mRdm06Sb3cx7HYnSoPN1y5p84a4KWrWYtaVKIeQzUdhw8aSDHBsEpqLKf7M56ATOq6kuELejM6P4FIblnBEnQXIwNj8XPBykPucNhewxe/neQ4a3hRBsAL3vBvcfrBi6QCeJBjdoAVra0yYgsTXZD88UjockRJG39JzluzQ6bE1SFirlVsu29yMFHcEe9Tazj21SywbDpA6CmqGR6c60CvYX7L3rM/mZeMhkXBQ6aU4G3T2t16I9LtlIiivdJS23wk++TXIlKnHptiRWal2NN70Cz0/60vs7MGJGbLm9PvRlXHRk6oVc5m4A0SfSuA3/Pn1djZASAilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWm4KOMwyt7qEOZB6CZvt3cQX+1/ev7OfDmhf8KomYg=;
 b=gFtmvEwNfgcYEDh4SBHZdbbHc/87ujh/vTlPMmV59/C/0a02e5jRGC/AEHypx3GW6vg3nu1TcTEAeR+6oeRxymY2U5Q/LSRGVwMSI+bzcZjm+IUbJhg7t4xsD7e8y/EEw31M5j0DkDIARiEnu42ihVrvavoQodDbkzL6VnzDvqs=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BN9PR03MB6074.namprd03.prod.outlook.com (2603:10b6:408:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 13:41:21 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c%6]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 13:41:21 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio:amplifiers:ada4250: add support for ADA4250
Thread-Topic: [PATCH 1/3] iio:amplifiers:ada4250: add support for ADA4250
Thread-Index: AQHYHy1t0gDzcEzsAUqBQJifiYCAZ6yOTF8AgAADS8A=
Date:   Fri, 11 Feb 2022 13:41:21 +0000
Message-ID: <CY4PR03MB3399A93A85A377B11CF57A8F9B309@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220211095057.54979-1-antoniu.miclaus@analog.com>
        <20220211095057.54979-2-antoniu.miclaus@analog.com>
 <20220211124618.00000a70@Huawei.com>
In-Reply-To: <20220211124618.00000a70@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy00OWFlZWQyMy04YjQwLTExZWMtYWMzOC0xNGFi?=
 =?us-ascii?Q?YzVmM2QzMjhcYW1lLXRlc3RcNDlhZWVkMjQtOGI0MC0xMWVjLWFjMzgtMTRh?=
 =?us-ascii?Q?YmM1ZjNkMzI4Ym9keS50eHQiIHN6PSIxNDk5OSIgdD0iMTMyODkwNjA0Nzg1?=
 =?us-ascii?Q?Mjg2NTUzIiBoPSJ6T0NRU3gzNEpQVGx0VkpNaWhDTm0veExWYWc9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QUNadlRZTVRSL1lBYnpQMDFEQmtJejF2TS9UVU1HUWpQVURBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQVhRL2pqUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de669bd8-89fa-4cdd-6a4f-08d9ed6430a5
x-ms-traffictypediagnostic: BN9PR03MB6074:EE_
x-microsoft-antispam-prvs: <BN9PR03MB6074CA855AA8D452B7E77AFB9B309@BN9PR03MB6074.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxsFs6GmZf8+QhyMgOzG66YjRvpKQftM+xys1/RYwSg7uKBxVIwdvPQBz+F8lONc1EheTbeLPOjQ88Ecinqk0yR1uic7wdSNvreT0JzM1tgQQnf8EdF6R07ldSA/BFGprPv/iNd3J6RjfCyjCpPtItg61JrAyKiemZzo7DA7nONHcjhlo37bSPnJpC6rwCcyQb8BYA2AaT7ZdZwspwkMBHNKq0QwrWztIUV9XPXdIxZBgjmkPozSUGHQK+fxF5I6+yK6u3arI1jBN6hNcWTzKFpc8PmptSPB3AXdNCkUspqLWWXt1WHaRNvRVszXJUJyAvh6WXFucgwc7mXhJCnys5X0/bCoK/nQ3j/KcIHeGEFnzwJi+FQswHFoAyN4UPLMzDG/kEE2+3OLzbWq1K+Vw0+cWRjciSvE5F/hFqZc0ksqMN280kbVn6kGhrE9ZTAAfMCH2191ZPYFzOYqn8kl/vAGvQ0OBrENuRDeJ1ftc6HDgwFRbmapkj6Pqpy3pWDONIGBWYb8+Pnz+yLmBoG8BBH+u/tjA+iXba84PGhA1WTP2iSO/uKT7fgUWR782bDhoPGvzgOjfMMtHkjd2KQK932WjeUkWdbkLpy3Z4g6cFGSi2aLDECTd5t2nElZeZo9MU+JHqekneTlMisgE8BcPn2H2RvARpIgFRs1sTZZgwwKon7PRSfc6V48hMEnpwMiLpzlecVAYW++RVDnvIQk0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(83380400001)(186003)(33656002)(54906003)(316002)(5660300002)(76116006)(508600001)(53546011)(64756008)(66476007)(4326008)(9686003)(38070700005)(66946007)(66446008)(38100700002)(8936002)(2906002)(122000001)(86362001)(7696005)(6506007)(52536014)(8676002)(66556008)(71200400001)(55016003)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6UDZF4AP/hSjaKK0ZT14I5chb8DuQsI/70tq48eTgpd8m8uV53SSk99sbutr?=
 =?us-ascii?Q?yX0XD8e4evaTuYe63eJZsBRfKeniJsY9YraX1ShJ/0ABkRFVi8x33YBSFo9u?=
 =?us-ascii?Q?usfg+cZq1OK12H/qwvSJIjDQUzePvYe54ugzVK61iTQgdtwG+UXKDNh2tz/B?=
 =?us-ascii?Q?6f+kXBun01RsaTYbeihenflFhmU9EedsY4AFrUSMLKRHL952nhy6EWdoocur?=
 =?us-ascii?Q?g3FqQCss3emBPHwrSHvP+G4SiwZMrunuO4nm9hdBU5bNBHy0ONXnRW6OiNiD?=
 =?us-ascii?Q?FETKeW50eRsQQIrVpZfEcIekcWMbSQ5cKGtRnZO2NZjTiL+OwntAQ2X3zO7f?=
 =?us-ascii?Q?ZCGUnrQWA1SREbScx1PiQtWrvfeQo3z6hkxbdYXQZu5WH9n8jGlG5i56FCG0?=
 =?us-ascii?Q?5yeMsccWcb3K714yO6vDG0slEZbUzifhoznclL7IYA+c330IDuV7uZLYoHDT?=
 =?us-ascii?Q?Qqa3MDvEBwrXmzTYValAe9YIfwFFFTd9YdQkdqG6jhf9AsGC99JDN5tva6Tp?=
 =?us-ascii?Q?/V6i7wVLCQ8twnKfFfga9eFN1921LLfIOlBnwT8ZD4j8CXuO5NGJD2463nk5?=
 =?us-ascii?Q?mtm6u84NXtD4uk2cP9poJLnA5gXXztZNB8hfbWqsNEY9WdNfx9pmP4eVDbZu?=
 =?us-ascii?Q?lknv1S6Ar1yX6JLHzLzrO2ZTu0OhF9ubCzbDE7AkUyc7irffQUO+/gGwXkcI?=
 =?us-ascii?Q?7xYF0TSmQ9Gukrp/gIe/LBix721BcqIb9TZw8U7RJs1Jvh+yNXdmjBtPRxVd?=
 =?us-ascii?Q?0lHd8d/olw66d0W8624T4Pclm/UM0/Mal9uThWTuZLkMHQWPANJ4pkUnKZu+?=
 =?us-ascii?Q?mnAOj/oLiiaLBxxpgSqEI6yg+e+r6+0V/xDwwGYQnxzIF9WoMj9ACzgpWW5P?=
 =?us-ascii?Q?6hgogEcuPRiUaAnH8Mdt5GWaTKHywCFGDgsxuCbWx2AbjPeer7tPz4552GLt?=
 =?us-ascii?Q?CVx97v1yrA/0VVhIKNjtuFSYatS7B77ilWtqHmdGYa7QDHvUhUFNHQVdSuEM?=
 =?us-ascii?Q?towUM5dEcElP/IQoAcj6T8rwTb4LrnPE3cAHdWOMbj2a2awAWlCcnb3PhGt9?=
 =?us-ascii?Q?yPOjtpds0jTMCTP2RVWXnWMBwEJKDViMGVGAmlSkze761nz/D6JCVcLRXO5t?=
 =?us-ascii?Q?oeIQ+NDQ9CNhn9xF5RvigM+ZNYM4JXHmk5XuI+ZlImQ8JeS+3ZPlwhF/xQp/?=
 =?us-ascii?Q?u9Rg7VhcryHi8M81majQlcWBOW5A+Lec1L/BWQkDKF5UUeoUdSp8SSY17e1g?=
 =?us-ascii?Q?9HNrTitkBWRBd/C0tZsqy/0ZD69txeMJDR8lu1AayEo4AnOC7EYaozNl8V7T?=
 =?us-ascii?Q?+pXsUwUSl2HDtwBQ3D2SOTRsjxp4fMJKIdircd3z3aA2YU6u2GNXL+aaU3oJ?=
 =?us-ascii?Q?EK0Uwwn2Fj1kDch2GtRZLpTgbjb0/WNAZx8tsG+ZUL/ZqfuA14YfFfdtrVFo?=
 =?us-ascii?Q?H7gkZAh9aVcap2V9xJdMSHOofnTfcUku1EQMAaYLB7AlAqPbMLxmcCjdFCgF?=
 =?us-ascii?Q?mcrjpPo7PUg2m58sqQ5jRHBU/KYPPmRcvDrCkG4A/J8rovuCfslq+a2H7Ole?=
 =?us-ascii?Q?ZwLg/kmDGIwD9kg7/tbASgpUhJ4hfLDEh9P4OF89B2KJHLhYNjVnSHupE15P?=
 =?us-ascii?Q?aoofyq0r2gMuCOnGkDw+d6vPA5mG1e34RY79TI4vcTWzerneE8Iu+Be7StNS?=
 =?us-ascii?Q?W5n0N2r9ZLsmWOU17oy3gradlomFEzdfXUF7fKbmFmgcawOzzXBOLAr6xBoN?=
 =?us-ascii?Q?ChNO7vVQ3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de669bd8-89fa-4cdd-6a4f-08d9ed6430a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 13:41:21.6889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHQyT+hsy37bmUMVS941YfTwmSQMa5mS0nz0EJzlL76eiPWi//Crl5dKZZ/ZAjjObwrusaM+yf64jHp7hygZXOepXmk8u6NXPS+kdPOlNFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6074
X-Proofpoint-GUID: pINuHG0TiqObIoWaLbia6FEiUpBUl490
X-Proofpoint-ORIG-GUID: 6Quul8lUszABH8yA8I_HJlcV0qW6xU2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_04,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110076
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, February 11, 2022 2:46 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: jic23@kernel.org; robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] iio:amplifiers:ada4250: add support for ADA4250
>=20
> [External]
>=20
> On Fri, 11 Feb 2022 11:50:55 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADA4250 is an instrumentation amplifier with SPI/pin-strap
> > progammable gains that is optimized for ultra-low power systems.
> > With a minimum supply voltage of 1.7V, 26uA of quiescent current,
> > a shutdown mode, a sleep mode, and a fast wake up settling time,
> > ADA4250 can be power cycled on a battery powered system for even
> > futher savings.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Hi Antoniu,
>=20
> Just to check, this sort of amplifier is normally not used as
> an analog front end?  If it were we'd want to deal with it
> being a consumer of the ADC channels similar to our other AFE drivers.
> If that's a possible usecase we might want to consider how to support
> that if relevant to a particular configuration.
>=20
> I don't understand what the two channels are.  Could you give us
> some more description?
>=20
> Thanks,
>=20
> Jonathan

Hello Jonathan,

This is a basic amplifier part, that receives a voltage as input and applie=
s a gain/offset to it.

I initially added a single IIO voltage channel having all the below attribu=
tes.
But the gain has no measurement unit (V/V), as specified in `hwgain_table[]=
` comment.
Same for the current bias setting (see `calibbias_table` comment).

Also I wanted to somehow emphasize that the scaling applies only to the off=
set value
which is passed in uV so we can avoid floating point computations.
The output offset raw value is computed based on the input voltage value se=
t by the user.
Depending on that value, and the current bias setting, a table of values/eq=
uations is provided
in the documentation that establishes the VLSB/range values that need to be=
 written in the=20
afferent registers (the entire computation is done in the `set_offset` func=
tion).
=20
Regards,
Antoniu
>=20
> > ---
> >  drivers/iio/amplifiers/Kconfig   |  11 +
> >  drivers/iio/amplifiers/Makefile  |   1 +
> >  drivers/iio/amplifiers/ada4250.c | 388
> +++++++++++++++++++++++++++++++
> >  3 files changed, 400 insertions(+)
> >  create mode 100644 drivers/iio/amplifiers/ada4250.c
> >
> > diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kc=
onfig
> > index 5eb1357a9c78..98612e01d9d4 100644
> > --- a/drivers/iio/amplifiers/Kconfig
> > +++ b/drivers/iio/amplifiers/Kconfig
> > @@ -23,6 +23,17 @@ config AD8366
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad8366.
> >
> > +config ADA4250
> > +	tristate "Analog Devices ADA4250 Instrumentation Amplifier"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for Analog Devices ADA4250
> > +	  SPI Amplifier's support. The driver provides direct access via
> > +          sysfs.
>=20
> Odd spacing.
>=20
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ada4250.
> > +
> >  config HMC425
> >  	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
> >  	depends on GPIOLIB
> > diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/M=
akefile
> > index cb551d82f56b..2126331129cf 100644
> > --- a/drivers/iio/amplifiers/Makefile
> > +++ b/drivers/iio/amplifiers/Makefile
> > @@ -5,4 +5,5 @@
> >
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_AD8366) +=3D ad8366.o
> > +obj-$(CONFIG_ADA4250) +=3D ada4250.o
> >  obj-$(CONFIG_HMC425) +=3D hmc425a.o
> > diff --git a/drivers/iio/amplifiers/ada4250.c
> b/drivers/iio/amplifiers/ada4250.c
> > new file mode 100644
> > index 000000000000..10725f6c2751
> > --- /dev/null
> > +++ b/drivers/iio/amplifiers/ada4250.c
> > @@ -0,0 +1,388 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ADA4250 driver
> > + *
> > + * Copyright 2022 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +/* ADA4250 Register Map */
> > +#define ADA4250_REG_GAIN_MUX        0x00
> > +#define ADA4250_REG_REFBUF_EN       0x01
> > +#define ADA4250_REG_RESET           0x02
> > +#define ADA4250_REG_SNSR_CAL_VAL    0x04
> > +#define ADA4250_REG_SNSR_CAL_CNFG   0x05
> > +#define ADA4250_REG_DIE_REV         0x18
> > +#define ADA4250_REG_CHIP_ID         0x19
> > +
> > +/* ADA4250_REG_GAIN_MUX Map */
> > +#define ADA4250_GAIN_MUX_MSK        GENMASK(2, 0)
> > +
> > +/* ADA4250_REG_REFBUF Map */
> > +#define ADA4250_REFBUF_MSK          BIT(0)
> > +
> > +/* ADA4250_REG_RESET Map */
> > +#define ADA4250_RESET_MSK           BIT(0)
> > +
> > +/* ADA4250_REG_SNSR_CAL_VAL Map */
> > +#define ADA4250_SNSR_CAL_VAL_MSK    GENMASK(7, 0)
> > +
> > +/* ADA4250_REG_SNSR_CAL_CNFG Bit Definition */
> > +#define ADA4250_BIAS_SET_MSK        GENMASK(3, 2)
> > +#define ADA4250_RANGE_SET_MSK       GENMASK(1, 0)
> > +
> > +/* Miscellaneous definitions */
> > +#define ADA4250_CHIP_ID             0x4250
> > +#define ADA4250_RANGE1              0
> > +#define	ADA4250_RANGE4              3
> > +
> > +/* ADA4250 current bias set */
> > +enum ada4250_current_bias {
> > +	ADA4250_BIAS_DISABLED,
> > +	ADA4250_BIAS_BANDGAP,
> > +	ADA4250_BIAS_AVDD,
> > +};
> > +
> > +struct ada4250_state {
> > +	struct spi_device	*spi;
> > +	struct regmap		*regmap;
> > +	struct regulator	*reg;
> > +	/* Protect against concurrent accesses to the device and data
> content */
> > +	struct mutex		lock;
> > +	u8			bias;
> > +	u8			gain;
> > +	int			offset_uv;
> > +	bool			refbuf_en;
> > +};
> > +
> > +/* ADA4250 Current Bias Source Settings: Disabled, Bandgap Reference,
> AVDD */
> > +static const int calibbias_table[] =3D {0, 1, 2};
> > +
> > +/* ADA4250 Gain (V/V) values: 1, 2, 4, 8, 16, 32, 64, 128 */
> > +static const int hwgain_table[] =3D {0, 1, 2, 3, 4, 5, 6, 7};
> > +
> > +static const struct regmap_config ada4250_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.read_flag_mask =3D BIT(7),
> > +	.max_register =3D 0x1A,
> > +};
> > +
> > +static int ada4250_set_offset_uv(struct iio_dev *indio_dev,
> > +				 const struct iio_chan_spec *chan,
> > +				 int offset_uv)
> > +{
> > +	struct ada4250_state *st =3D iio_priv(indio_dev);
> > +
> > +	int i, ret, x[8], max_vos, min_vos, voltage_v, vlsb =3D 0;
> > +	u8 offset_raw, range =3D ADA4250_RANGE1;
> > +	u32 lsb_coeff[6] =3D {1333, 2301, 4283, 8289, 16311, 31599};
> > +
> > +	if (st->bias =3D=3D 0 || st->bias =3D=3D 3)
> > +		return -EINVAL;
> > +
> > +	voltage_v =3D regulator_get_voltage(st->reg);
> > +	voltage_v =3D DIV_ROUND_CLOSEST(voltage_v, 1000000);
> > +
> > +	if (st->bias =3D=3D ADA4250_BIAS_AVDD)
> > +		x[0] =3D voltage_v;
> > +	else
> > +		x[0] =3D 5;
> > +
> > +	x[1] =3D 126 * (x[0] - 1);
> > +
> > +	for (i =3D 0; i < 6; i++)
> > +		x[i + 2] =3D DIV_ROUND_CLOSEST(x[1] * 1000, lsb_coeff[i]);
> > +
> > +	if (st->gain =3D=3D 0)
> > +		return -EINVAL;
> > +
> > +	/* Compute Range and VLSB for the Sensor Offset Calibration */
> > +	for (i =3D ADA4250_RANGE1; i <=3D ADA4250_RANGE4; i++) {
> > +		max_vos =3D x[st->gain] *  127 * ((1 << (i + 1)) - 1);
> > +		min_vos =3D -1 * max_vos;
> > +		if (offset_uv > min_vos && offset_uv < max_vos) {
> > +			range =3D i;
> > +			vlsb =3D x[st->gain] * ((1 << (i + 1)) - 1);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (vlsb <=3D 0)
> > +		return -EINVAL;
> > +
> > +	offset_raw =3D DIV_ROUND_CLOSEST(abs(offset_uv), vlsb);
> > +
> > +	mutex_lock(&st->lock);
> > +	ret =3D regmap_update_bits(st->regmap,
> ADA4250_REG_SNSR_CAL_CNFG,
> > +				 ADA4250_RANGE_SET_MSK,
> > +				 FIELD_PREP(ADA4250_RANGE_SET_MSK,
> range));
> > +	if (ret)
> > +		goto exit;
> > +
> > +	st->offset_uv =3D offset_raw * vlsb;
> > +
> > +	if (offset_uv < 0) {
> > +		offset_raw |=3D 1 << 8;
> > +		st->offset_uv *=3D (-1);
> > +	}
> > +
> > +	ret =3D regmap_write(st->regmap, ADA4250_REG_SNSR_CAL_VAL,
> offset_raw);
> > +
> > +exit:
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ada4250_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long info)
> > +{
> > +	struct ada4250_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > +		ret =3D regmap_read(st->regmap, ADA4250_REG_GAIN_MUX,
> val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*val =3D st->offset_uv;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		ret =3D regmap_read(st->regmap,
> ADA4250_REG_SNSR_CAL_CNFG, val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val =3D FIELD_GET(ADA4250_BIAS_SET_MSK, *val);
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val =3D 1;
> > +		*val2 =3D 1000000;
> > +
> > +		return IIO_VAL_FRACTIONAL;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ada4250_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long info)
> > +{
> > +	struct ada4250_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > +		ret =3D regmap_write(st->regmap, ADA4250_REG_GAIN_MUX,
> > +				   FIELD_PREP(ADA4250_GAIN_MUX_MSK,
> val));
> > +		if (ret)
> > +			return ret;
> > +
> > +		st->gain =3D val;
> > +
> > +		return ret;
> > +	case IIO_CHAN_INFO_OFFSET:
>=20
> Given no DS, please provide some more info on what the channels are to
> help evaluate if this is the appropriate interface.
>=20
> > +		return ada4250_set_offset_uv(indio_dev, chan, val);
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		ret =3D regmap_update_bits(st->regmap,
> ADA4250_REG_SNSR_CAL_CNFG,
> > +					 ADA4250_BIAS_SET_MSK,
> > +
> FIELD_PREP(ADA4250_BIAS_SET_MSK, val));
> > +		if (ret)
> > +			return ret;
> > +
> > +		st->bias =3D val;
> > +
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ada4250_read_avail(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      const int **vals, int *type, int *length,
> > +			      long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		*vals =3D calibbias_table;
> > +		*type =3D IIO_VAL_INT;
> > +		*length =3D ARRAY_SIZE(calibbias_table);
> > +
> > +		return IIO_AVAIL_LIST;
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > +		*vals =3D hwgain_table;
> > +		*type =3D IIO_VAL_INT;
> > +		*length =3D ARRAY_SIZE(hwgain_table);
> > +
> > +		return IIO_AVAIL_LIST;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ada4250_reg_access(struct iio_dev *indio_dev,
> > +			      unsigned int reg,
> > +			      unsigned int write_val,
> > +			      unsigned int *read_val)
> > +{
> > +	struct ada4250_state *st =3D iio_priv(indio_dev);
> > +
> > +	if (read_val)
> > +		return regmap_read(st->regmap, reg, read_val);
> > +	else
> > +		return regmap_write(st->regmap, reg, write_val);
> > +}
> > +
> > +static const struct iio_info ada4250_info =3D {
> > +	.read_raw =3D ada4250_read_raw,
> > +	.write_raw =3D ada4250_write_raw,
> > +	.read_avail =3D &ada4250_read_avail,
> > +	.debugfs_reg_access =3D &ada4250_reg_access,
> > +};
> > +
> > +static const struct iio_chan_spec ada4250_channels[] =3D {
> > +	{
> > +		.type =3D IIO_ALTVOLTAGE,
>=20
> For a device like this, I'd argue it's not 'necessarily' an alternating
> voltage so type should probably be just voltage.  Obviously if there
> is something about the amplifier architecture that means it won't carry
> DC then it's a different matter.
>=20
> > +		.output =3D 1,
> > +		.indexed =3D 1,
> > +		.channel =3D 0,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +		.info_mask_separate_available =3D
> BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > +
> 	BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > +	},
> > +	{
> > +		.type =3D IIO_VOLTAGE,
>=20
> Given we have no datasheet, what's this?  Add a comment.
>=20
> > +		.output =3D 1,
> > +		.indexed =3D 1,
> > +		.channel =3D 0,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_OFFSET) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
>=20
> This is unusual as I'm not sure what meaning an offset and scale have
> with out a raw value.
>=20
> > +	},
> > +};
> > +
> > +static void ada4250_reg_disable(void *data)
> > +{
> > +	regulator_disable(data);
> > +}
> > +
> > +static int ada4250_init(struct ada4250_state *st)
> > +{
> > +	int ret;
> > +	u16 chip_id;
> > +	u8 data[2];
> > +	struct spi_device *spi =3D st->spi;
> > +
> > +	st->refbuf_en =3D device_property_read_bool(&spi->dev, "adi,refbuf-
> enable");
> > +
> > +	st->reg =3D devm_regulator_get(&spi->dev, "avdd");
> > +	if (IS_ERR(st->reg))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> > +				     "failed to get the AVDD voltage\n");
> > +
> > +	ret =3D regulator_enable(st->reg);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to enable specified AVDD
> supply\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev, ada4250_reg_disable,
> st->reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(st->regmap, ADA4250_REG_RESET,
> > +			   FIELD_PREP(ADA4250_RESET_MSK, 1));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, data,
> 2);
> I think our current position is that regmap_bulk_* accesses should use
> DMA safe buffers (on SPI anyway) as it's possible the implementation may
> required that and it isn't documented as not requiring it.
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	chip_id =3D (data[1] << 8) | data[0];
>=20
> Endian conversion.  Firstly make data the appropriate type then use
> the appropriate endian conversion function.
>=20
> > +
> > +	if (chip_id !=3D ADA4250_CHIP_ID) {
> > +		dev_err(&spi->dev, "Invalid chip ID.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return regmap_write(st->regmap, ADA4250_REG_REFBUF_EN,
> > +			    FIELD_PREP(ADA4250_REFBUF_MSK, st-
> >refbuf_en));
> > +}
> > +
>=20

