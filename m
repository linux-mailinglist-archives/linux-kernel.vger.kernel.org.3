Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B468C49696C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiAVCdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:33:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbiAVCdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:33:03 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20M1uYmg023886;
        Sat, 22 Jan 2022 02:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8Er2nLIX/vemuRscbI6fN3Zj5MWD+0AefZo49MXNh9Y=;
 b=oEQR2kPacG5iCXtaTXdKiMeSPBRp6XqkO4dMoAUy4CQ79ceKDAGRzDx1Q6WRXsuM1Tfc
 M6/PLTMBP5kRQgEMiCgeOmd9iqa0M1Nrb/Xo03cdM3gVvgMlOaA9QNOljGDdS6ESK740
 0lLOgXEj9E39veGQVW+PAjivi/oin+RFW0uoVE906lNtGFhbK3PqlvGys+3Z8wKuTkoj
 846xZfuz1wS7IQUbgX82CN+36GySmHQWSHtBx5OGz6WRE5tD4j8tsHSXHY3sf6XtoUZ+
 4izupAiI7YYv3abqO29Cry8/1tpmdRYZw1TBN0hv5zI0GnmCH253GnTiEmCrOcnOxAh5 og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr8q3828s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 02:32:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20M2GMEQ002855;
        Sat, 22 Jan 2022 02:32:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by userp3020.oracle.com with ESMTP id 3dqj0nx8bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 02:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIgDzGQK3Cnzfbvh9HrQopIC9UzrXbK+XF5YuWqBWEC0tJd9ahGx/1dzN+obBeK6RJWQeFe1jad0ZucFyqple9d12wDMIksoDBpzp+QjjTGr6oAIBWaMKLbpkc7VEuf7zD6PMV0v6Pyx5FKy3XnyyBQsy8PI6SCVjQx8ZgaklITiKy9DXYRiMcfAIQZj3+vPy1dIytn4CFLhkyz5r2h8vPvtQq8InANIyW4Xi9bUiFn4HjtL4FTmdno9Q1YR/1jrzek20DEIkMRzSdLeuPGddoE7QrA9afg+uwdHyKMqt/afbT+TGITt9J9MmKaG3mpiw4w8Yl5jCc6f5NclbArO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Er2nLIX/vemuRscbI6fN3Zj5MWD+0AefZo49MXNh9Y=;
 b=MLygd+i4cw8tijtztqnkY+fCOGG5cERY9j07jZwDas7g4SZM/Hin4pY/G3E7Y+mmIZA+cwXeQBBYRlLAOdwBTYwrPJVP08cggagA4mVtORsEuf9nOJX7Nz+jl1AsRAJokdJc0Ud8pYn3jv56Nc1YhwDYFpiwRtgYVQDunfsoAFWburJbN4PnuxEZXSDd957g71n/iQMyFTMx/iuLpjUYmWRSjvn1SBozetNrxefYcMYvPMsThMyaqQrQ7ovHcWku4+DUTe9SoO/MdVkdJHE/35drqyvpFtBfz3XUOe2jRCVmn/dy0AMrmM9C66SKfZroP9Z0vl/Hx5PPa4fh7OAzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Er2nLIX/vemuRscbI6fN3Zj5MWD+0AefZo49MXNh9Y=;
 b=GbK+vzDbyw7B79U5xRbmiQ191ZWwqHHhXz8vx5MMNTQv/qHc09/6sVqf+cV4S2gs4XgzuQxYSQfpC469hfX0PhzQkUxnz1wtvV4l+P3Kq1XiRIAxTQK0P9xsT3rSZhx7Z7wgcZN3kolBiu+sHjHeyPU5OxIbZ+ChEiB/uaYjzI8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 02:32:43 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 02:32:43 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Tsaur, Erwin" <erwin.tsaur@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "bp@alien8.de >> Borislav Petkov" <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Phantom PMEM poison issue
Thread-Topic: Phantom PMEM poison issue
Thread-Index: AQHYDydWdWgzCdPlXk6vesHxVkUTIKxuMvGAgAANDgCAAAUc8IAADUCA
Date:   Sat, 22 Jan 2022 02:32:43 +0000
Message-ID: <0769ec5c-484e-6fc3-56dd-e9c29a3e7154@oracle.com>
References: <1737f707-7743-4898-37d4-03098d7aaa57@oracle.com>
 <0aab10e0-6f1d-d67b-8aef-7e3d18e26544@oracle.com>
 <YetdZBbt0P/QBHDr@agluck-desk2.amr.corp.intel.com>
 <MW3PR11MB4604BF71E4796C3C9AE08508E75C9@MW3PR11MB4604.namprd11.prod.outlook.com>
In-Reply-To: <MW3PR11MB4604BF71E4796C3C9AE08508E75C9@MW3PR11MB4604.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e973eefe-5d13-4a38-ec50-08d9dd4f783b
x-ms-traffictypediagnostic: SA2PR10MB4809:EE_
x-microsoft-antispam-prvs: <SA2PR10MB480971CE97BCB1054DCFC50EF35C9@SA2PR10MB4809.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUsjHAGDkwRgZsiHn3LDVfrQP/bbyTJ1FOaHMJ7TxmDVgV5kcICFaMVJH3U8F7d44PY76C74p3NSkKsMCVelKMhmKvJRQ4fL5482m75HicTQs0OnnIJO6hLRjFmzPeXaLhIiT5XTUeIdcZ9BfMQE6aWJGTKyxB7MrXmirSaOs575ZCMYyReMXLqfiQZFgpzoOGgoZ9ncX5dSvy88gWTuXG0WIOHNGYU4tUjnFJ+M0IiPZ33WJVfNayscZp2h2/MpdqCuA1laLYBkI+MvMmyc9fpimu4FVnWhj/yo8rMZOHiGgXA0G8XKi5VbXdNMqiIDyRArkDlE1QzkPbLW1LXQ9qtSchkcv1VS5A+o/MLpLa/s6I2xQTEdbvqxNsPwHHRLa/Ts0LHSBQ8UtVDuLGhHJR+OWiq2e5q4LH8emADLbiqzBZzuXZJXMKQf1wIpnuOocF8UB7jOdXkKzNSuzE0Ue3Bm6xzvMJ6PTAZ+G6p0TrzQXvn404n5jstMPUlc0Dj8hwTzY+Q51xuHEtWNrhnrhNapcpM2ZhbiXemUAOq9+0jQVrBvM8ACXe9wI3g+obMkdEqhUKbYlK8HlcmFCKz0me5ZQHSDuxRKXJS0tQ+si2iWAMwNvjEj5JZ0O4F7LqfL6E8PrCwdVcVz1DiXbYWibPNqZLfxku4GTodXSiWfcUCtxhOKT+ILfciVPDCcb+uuN5kstU4j1nLt0Iy2IAe4pCbo6OOyr31tKh9gzrfyrV/6u/nRWTCBSvx1QuJ4D/JJrWzIm3iUOc84mStp43WUVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(5660300002)(86362001)(3480700007)(31686004)(53546011)(54906003)(91956017)(4326008)(36756003)(316002)(64756008)(66556008)(31696002)(66946007)(66476007)(76116006)(6506007)(83380400001)(186003)(38070700005)(71200400001)(6512007)(2906002)(8936002)(44832011)(508600001)(6486002)(8676002)(2616005)(122000001)(66446008)(26005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk1KRjFOZjM1VkhJVTVSSEMyd2o5c2xQaEgwZ0pRcDhPK3V0RC8zdGZ1V2JT?=
 =?utf-8?B?azJTczdoeVROREI0SXRkQ0lqNFUvN0dURTV3L3pTMDArVThOdmZxbnhOTFcx?=
 =?utf-8?B?b3RPSUl6Y1NhQ3czN3ZKT2VKUWtuUXlNOVVLaFZPeGs5NFVCcFNzeE11UlZE?=
 =?utf-8?B?UStxV3FXRzJuZjVuQlloVi9PelZuZDNpNUxIMDQrOEZrZ0w5a3hhNWtEc01M?=
 =?utf-8?B?MTFJRGVPK0JucWF1S2kxL093Z1lFQUFuaG1vU285aVFhVXM1SU9EbCtaTEtF?=
 =?utf-8?B?QWhmK2F4UlVPdFFLaGszUnFpYTNib3ViSVJXeHRwM1hsMzVkU2FjTE9DK2Vt?=
 =?utf-8?B?aFZWY1NzcXVycFM5ZEdQQnhSYUpUZVd5d3lSY0YyeHRwVzRSdGgwd2F2Z1BP?=
 =?utf-8?B?MEluMzgyUEtlcmtGSkoyQnZPd0xycm5TZTg5WTNCbzJrVVFjOFJIcC9SaWlo?=
 =?utf-8?B?STB1Tm9jeXYwa1J3eDdWWmFwWFBhSDRib0l3VmdNWnBOMHV0NFplT08rdENZ?=
 =?utf-8?B?M0tVWVQ3TnBVeXg2UStRVFN2dmhNR1Eya0lXRU1laXExNmo1Y25TQ0IrYURL?=
 =?utf-8?B?dkdZYzJzeHgrZ2o3bnBRejN5TE5US2trVldBK3FaTjM2UFI5QnAwSnVtdWNs?=
 =?utf-8?B?WEtxRzJXWGM2WHdZWDRHTVlhTU9oZzlzakZ4NmNmYzFvL2NZZFZIVnUyTVli?=
 =?utf-8?B?YW1EQVB1Z3VUd3FwOWg3NUFFaUM4bkF0QmwrVlowTTI5czZ5bzR1MTRTRC9z?=
 =?utf-8?B?N2tCUjQxTVNzQ0wvTENZd2RaajJIMWtIWDVVSTRucENrcUNHWGh1eWlWRHVN?=
 =?utf-8?B?MXVpV2hHdUdoOXd6Slk2aExORXcxWTUxclJpcVN2UFBjWHRtcGtnalFHV0gw?=
 =?utf-8?B?dERqbWtFMXRvWW4ycGljUkZMd1BaT3RqZmM5Ky8xQ0hXd0pwWUtnT3h1Lzh0?=
 =?utf-8?B?WDZCWjV6TVdjbm5HRVZyckppTkkwRkI2anFlOGIyTTIrTDFBRjFxTTZEcC9h?=
 =?utf-8?B?dUU4TDJqU0FBRVlQc0pXMEFpM3dZWi9iQTZSak9IS1RTYVY0d2k3eTUxM3NV?=
 =?utf-8?B?ZGdNaGt2VGZINGNoWkt6dHE3OEdIcXUrbkhKVTJPYkNDRklLclA2Z1BwbURV?=
 =?utf-8?B?V0hsRHkyd05pS0YzVEFmYWd3OW9DY1hEY09Gb21Ea1A4WTVaZjVaM3NDdno3?=
 =?utf-8?B?RGJKT3dmUGZTT3J6dDlOaEdyWE9xSTJJeGhFN1RSZFdQQUFnT0VndkI2RjFn?=
 =?utf-8?B?SWMzc2plWi9xUFlXUmYxbEczWmtUYksyR2lESzVueXRXYnRoSlkrOWNHSjBz?=
 =?utf-8?B?SHhaLzFwVmdGZHJSY1doTXgrQy9NSURUS2toWTJ5cGlTb1BWaTl5K3VjUXRM?=
 =?utf-8?B?RFhIWXM2UkNvWUw2M1RwV0JKZUNPQWs2YXBQb2l3TmFoNWFzRERobGlIVURI?=
 =?utf-8?B?cW82WU44dExDamc3YnVVeGFqMjRzTzVmblhQSlFaTGxkTlIyWVNFd1VlaG1l?=
 =?utf-8?B?elFJUlNnc2ZCQkNqV2VzMTFjaDBOdmpLZS9NVjRKTGZXOVd3ZVZ1R2ZjdTdn?=
 =?utf-8?B?Q2RGSldEaVozZy85SVNlaDVlTjlxSGVFY3RBcEVCMHhZbVlWZndaaGlwRVc2?=
 =?utf-8?B?c0JHR1J5RXErSDRReHN2NU1pMkVrcHdLKzZVd3dBYlF5QnhiVjRjRGZFRVVX?=
 =?utf-8?B?ak9hN3FnRXREd1ZyeDJqWTVvNGluWDVRVWN6ZW9oRk94V1BiREl2VFI5cFlR?=
 =?utf-8?B?TjZBcitFVkM5MFdWYm4ybkQvYTVWWENyOGJXUmQ2UVVDN0ZEb1ZuUDVZbHNJ?=
 =?utf-8?B?R2lGVWttTFhXQjNUOWtPNVk4aURsamgvM0N5NC9zV1crMjV4YS9DSTd3dFl3?=
 =?utf-8?B?bjMrWUQ5czUySVY1bFA5ckVzM000U05LY05XdTRuZm13L0I3V3FIbHB2b1NU?=
 =?utf-8?B?MDMvakkrMTZ2eGplOGJibTZIeW1Hc0hzd1RQRDd3bVlhaUgzTUs1cTJiSjBR?=
 =?utf-8?B?MWp1S05tcmViNXJSd1V2ZFM4MHdEQkdpemlNT09TZzBqL3B0cFJXclhiREw4?=
 =?utf-8?B?SjM2L0grdUlZcXNpUGVyZ2xIMUVodXdCMGJzbm1FQUxpNkEzVmVLeXV0YWtq?=
 =?utf-8?B?NzB2R1R5bjZ1aGZqeGs1b1RvTFUrU3llQUhBUXFxRTZMTHduSmtpWTZOVFl6?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8839242E6440874F90A44FCB3748DF15@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e973eefe-5d13-4a38-ec50-08d9dd4f783b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 02:32:43.7733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caSPpbS+VA4C+ZL/P39NKXdt+uqSdGhp/JX4C4E9M0HODNE8jkpG7+bhX3nMUzSVj6baXiF6jN4ul/erynkp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201220009
X-Proofpoint-ORIG-GUID: MFvMqCmTgnP32KFrzowmZz-lOItmVx_z
X-Proofpoint-GUID: MFvMqCmTgnP32KFrzowmZz-lOItmVx_z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMS8yMDIyIDU6NTEgUE0sIFRzYXVyLCBFcndpbiB3cm90ZToNCj4gSGkgSmFuZSwNCj4g
DQo+IElzIHBoYW50b20gZXJyb3IsIGFuIHBvaXNvbiB0aGF0IHdhcyBpbmplY3RlZCBhbmQgdGhl
biBjbGVhcmVkLCBidXQgc29tZWhvdyBzaG93cyB1cCBhZ2Fpbj8NCj4gSG93IGlzICJkYXhmcyB0
YWtlcyBhY2F0aW9uIGFuZCBjbGVhcnMgdGhlIHBvaXNvbiIgYnkgZG9pbmcgbWFpbGJveCBvciB3
cml0ZXM/DQo+IEFsc28gaG93IGFyZSB5b3UgZG9pbmcgQVJTPw0KDQpUaGUgcGhhbnRvbSBzaG93
IHVwIGFzIHNvb24gYXMgdGhpcyBjb25zb2xlIG1lc3NhZ2Ugc2hvdyB1cA0KICAgIFtIYXJkd2Fy
ZSBFcnJvcl06IEhhcmR3YXJlIGVycm9yIGZyb20gQVBFSSBHZW5lcmljIEhhcmR3YXJlIEVycm9y
IA0KU291cmNlOiAxDQpmcm9tICdnaGVzJy4NCg0KVGhlIHBvaXNvbnMgd2VyZSBjbGVhciB2aWEg
cG1lbV9jbGVhcl9wb2lzb24oKS4NCg0KQVJTIHdhcyBydW4gYXMNCiAgICJuZGN0bCBzdGFydC1z
Y3J1YjsgbmRjdGwgd2FpdC1zY3J1YiAtcCAzMCINCg0KdGhhbmtzLA0KLWphbmUNCg0KDQo+IA0K
PiBFcndpbg0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjaywg
VG9ueSA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDIxLCAy
MDIyIDU6MjcgUE0NCj4gVG86IGNodSwgamFuZSA8amFuZS5jaHVAb3JhY2xlLmNvbT4NCj4gQ2M6
IFdpbGxpYW1zLCBEYW4gSiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsgYnBAYWxpZW44LmRl
ID4+IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgZGp3b25nQGtlcm5lbC5vcmc7IHdp
bGx5QGluZnJhZGVhZC5vcmc7IG52ZGltbUBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFBoYW50b20gUE1FTSBwb2lzb24gaXNzdWUN
Cj4gDQo+IE9uIFNhdCwgSmFuIDIyLCAyMDIyIGF0IDEyOjQwOjE4QU0gKzAwMDAsIEphbmUgQ2h1
IHdyb3RlOg0KPj4gT24gMS8yMS8yMDIyIDQ6MzEgUE0sIEphbmUgQ2h1IHdyb3RlOg0KPj4+IE9u
IGJhcmVtZXRhbCBJbnRlbCBwbGF0Zm9ybSB3aXRoIERDUE1FTSBpbnN0YWxsZWQgYW5kIGNvbmZp
Z3VyZWQgdG8NCj4+PiBwcm92aXNpb24gZGF4ZnMsIHNheSBhIHBvaXNvbiB3YXMgY29uc3VtZWQg
YnkgYSBsb2FkIGZyb20gYSB1c2VyDQo+Pj4gdGhyZWFkLCBhbmQgdGhlbiBkYXhmcyB0YWtlcyBh
Y3Rpb24gYW5kIGNsZWFycyB0aGUgcG9pc29uLCBjb25maXJtZWQNCj4+PiBieSAibmRjdGwgLU5N
Ii4NCj4+Pg0KPj4+IE5vdywgZGVwZW5kcyBvbiB0aGUgbHVjaywgYWZ0ZXIgc29tZXRpbWUoZnJv
bSBhIGZldyBzZWNvbmRzIHRvIDUrDQo+Pj4gaG91cnMpIHRoZSBnaG9zdCBvZiB0aGUgcHJldmlv
dXMgcG9pc29uIHdpbGwgc3VyZmFjZSwgYW5kIGl0IHRha2VzDQo+Pj4gdW5sb2FkL3JlbG9hZCB0
aGUgbGlibnZkaW1tIGRyaXZlcnMgaW4gb3JkZXIgdG8gZHJpdmUgdGhlIHBoYW50b20NCj4+PiBw
b2lzb24gYXdheSwgY29uZmlybWVkIGJ5IEFSUy4NCj4+Pg0KPj4+IFR1cm5zIG91dCwgdGhlIGlz
c3VlIGlzIHF1aXRlIHJlcHJvZHVjaWJsZSB3aXRoIHRoZSBsYXRlc3Qgc3RhYmxlIExpbnV4Lg0K
Pj4+DQo+Pj4gSGVyZSBpcyB0aGUgcmVsZXZhbnQgY29uc29sZSBtZXNzYWdlIGFmdGVyIGluamVj
dGVkIDggcG9pc29ucyBpbiBvbmUNCj4+PiBwYWdlIHZpYQ0KPj4+ICAgICAgIyBuZGN0bCBpbmpl
Y3QtZXJyb3IgbmFtZXNwYWNlMC4wIC1uIDIgLUIgODIxMA0KPj4NCj4+IFRoZXJlIGlzIGEgY3V0
LW4tcGFzdGUgZXJyb3IsIHRoZSBhYm92ZSBsaW5lIHNob3VsZCBiZQ0KPj4gICAgICIjIG5kY3Rs
IGluamVjdC1lcnJvciBuYW1lc3BhY2UwLjAgLW4gOCAtQiA4MjEwIg0KPiANCj4gWW91IHNheSAi
aW4gb25lIHBhZ2UiIGhlcmUuIFdoYXQgaXMgdGhlIHBhZ2Ugc2l6ZT8NCj4+DQo+PiAtamFuZQ0K
Pj4NCj4+PiB0aGVuLCBjbGVhcmVkIHRoZW0gYWxsLCBhbmQgd2FpdCBmb3IgNSsgaG91cnMsIG5v
dGljZSB0aGUgdGltZSBzdGFtcC4NCj4+PiBCVFcsIHRoZSBzeXN0ZW0gaXMgaWRsZSBvdGhlcndp
c2UuDQo+Pj4NCj4+PiBbIDI0MzkuNzQyMjk2XSBtY2U6IFVuY29ycmVjdGVkIGhhcmR3YXJlIG1l
bW9yeSBlcnJvciBpbiB1c2VyLWFjY2Vzcw0KPj4+IGF0DQo+Pj4gMTg1MDYwMjQwMA0KPj4+IFsg
MjQzOS43NDI0MjBdIE1lbW9yeSBmYWlsdXJlOiAweDE4NTA2MDI6IFNlbmRpbmcgU0lHQlVTIHRv
DQo+Pj4gZnNkYXhfcG9pc29uX3YxOjg0NTcgZHVlIHRvIGhhcmR3YXJlIG1lbW9yeSBjb3JydXB0
aW9uIFsNCj4+PiAyNDM5Ljc2MTg2Nl0gTWVtb3J5IGZhaWx1cmU6IDB4MTg1MDYwMjogcmVjb3Zl
cnkgYWN0aW9uIGZvciBkYXggcGFnZToNCj4+PiBSZWNvdmVyZWQNCj4+PiBbIDI0MzkuNzY5OTQ5
XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZA0KPj4+
IC0xODUwNjAzMDAwIHVuY2FjaGVkLW1pbnVzPC0+d3JpdGUtYmFjayBbIDI0MzkuNzY5OTg0XSB4
ODYvUEFUOg0KPj4+IG1lbXR5cGVfcmVzZXJ2ZSBmYWlsZWQgW21lbSAweDE4NTA2MDIwMDAtMHgx
ODUwNjAyZmZmXSwgdHJhY2sNCj4+PiB1bmNhY2hlZC1taW51cywgcmVxIHVuY2FjaGVkLW1pbnVz
IFsgMjQzOS43Njk5ODVdIENvdWxkIG5vdA0KPj4+IGludmFsaWRhdGUgcGZuPTB4MTg1MDYwMiBm
cm9tIDE6MSBtYXAgWyAyNDQwLjg1NjM1MV0geDg2L1BBVDoNCj4+PiBmc2RheF9wb2lzb25fdjE6
ODQ1NyBmcmVlaW5nIGludmFsaWQgbWVtdHlwZSBbbWVtDQo+Pj4gMHgxODUwNjAyMDAwLTB4MTg1
MDYwMmZmZl0NCj4gDQo+IFRoaXMgZXJyb3IgaXMgcmVwb3J0ZWQgaW4gUEZOPTE4NTA2MDIgKGF0
IG9mZnNldCAweDQwMCA9IDFLKQ0KPiANCj4+Pg0KPj4+IEF0IHRoaXMgcG9pbnQsDQo+Pj4gIyBu
ZGN0bCBsaXN0IC1OTXUgLXIgMA0KPj4+IHsNCj4+PiAgICAgICJkZXYiOiJuYW1lc3BhY2UwLjAi
LA0KPj4+ICAgICAgIm1vZGUiOiJmc2RheCIsDQo+Pj4gICAgICAibWFwIjoiZGV2IiwNCj4+PiAg
ICAgICJzaXplIjoiMTUuNzUgR2lCICgxNi45MSBHQikiLA0KPj4+ICAgICAgInV1aWQiOiIyY2Nj
NTQwYS0zYzdiLTRiOTEtYjg3Yi05ZTg5N2FkMGI5YmIiLA0KPj4+ICAgICAgInNlY3Rvcl9zaXpl
Ijo0MDk2LA0KPj4+ICAgICAgImFsaWduIjoyMDk3MTUyLA0KPj4+ICAgICAgImJsb2NrZGV2Ijoi
cG1lbTAiDQo+Pj4gfQ0KPj4+DQo+Pj4gWzIxMzUxLjk5MjI5Nl0gezJ9W0hhcmR3YXJlIEVycm9y
XTogSGFyZHdhcmUgZXJyb3IgZnJvbSBBUEVJIEdlbmVyaWMNCj4+PiBIYXJkd2FyZSBFcnJvciBT
b3VyY2U6IDEgWzIxMzUyLjAwMTUyOF0gezJ9W0hhcmR3YXJlIEVycm9yXTogZXZlbnQNCj4+PiBz
ZXZlcml0eTogcmVjb3ZlcmFibGUgWzIxMzUyLjAwNzgzOF0gezJ9W0hhcmR3YXJlIEVycm9yXTog
IEVycm9yIDAsDQo+Pj4gdHlwZTogcmVjb3ZlcmFibGUNCj4+PiBbMjEzNTIuMDE0MTU2XSB7Mn1b
SGFyZHdhcmUgRXJyb3JdOiAgIHNlY3Rpb25fdHlwZTogbWVtb3J5IGVycm9yDQo+Pj4gWzIxMzUy
LjAyMDU3Ml0gezJ9W0hhcmR3YXJlIEVycm9yXTogICBwaHlzaWNhbF9hZGRyZXNzOiAweDAwMDAw
MDE4NTA2MDMyMDANCj4gDQo+IFRoaXMgZXJyb3IgaXMgaW4gdGhlIGZvbGxvd2luZyBwYWdlOiBQ
Rk49MTg1MDYwMyAoYXQgb2Zmc2V0IDB4MjAwID0gNTEyYikNCj4gDQo+IElzIHRoYXQgd2hhdCB5
b3UgbWVhbiBieSAicGhhbnRvbSBlcnJvciIgLi4uIGZyb20gYSBkaWZmZXJlbnQgYWRkcmVzcyBm
cm9tIHRob3NlIHRoYXQgd2VyZSBpbmplY3RlZD8NCj4gDQo+IC1Ub255DQo+IA0KDQo=
