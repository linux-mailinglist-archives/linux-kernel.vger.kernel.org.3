Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E83949696A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiAVC3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:29:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbiAVC3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:29:51 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20M1VmKL007788;
        Sat, 22 Jan 2022 02:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1JjIS9dA5EonH+ROORc7w9oofkdudYoC4Hf8cEGTiu0=;
 b=kIkf3ZZjWloeLoHv9hkVk3JJy3NyxFnNAQZ1ffyJZVMZxKSudUto08JFd5MdpWeiN4DI
 yLCx814YM/NziYjGBOprxoqfBHrQs23blkMjxzpK2opssl3LRC7d87+MNEUCiADgIxsf
 s2GBB16ufIR9G0/dmBoZOWuQnhHoy9/+c/tn6U+cjfbZxSPpnu6DjVyEEt/Jra+1E1HA
 EZkKRMoovhYOp+uRIGSgkWwl25O1LO9Qs7na7KHB5s3NAveVrgbTO6G7CIc1PPuEdsxr
 jIUVP8yCnLS7l/nuxZI/EPmN8a5QGw/1+DU6A9uKzrrMElFQ305IKsMMi3OHRHB9WfPO Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr8bdg2f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 02:29:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20M2Glq6102417;
        Sat, 22 Jan 2022 02:29:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3dr71s3g62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 02:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrBCSY/hb9FguX2QXYvK5KgLycEWmQk/X6XZFIels1SGzONgSWaELIhaNVX4dCNlb16dv/TIX6pOS5QJRP/BGEuYeEIbaqOl9VFJrhiT28NMX5YBz18xDZEF1JBfXA2Zf173JEm8NqQFOS/FOSnkdFAe2WxEzrtt+JWezdawdZ4yQ06J8CGVDZ7aHvgDDU8LVXOv2W+Dy9WksHwiyD/CyLo32WZIqhHD+cpo2czpfW+JXWazBID9cO/6YlOR9QXoPGrS8e0gFZaJevk9s1pWwUHKbODRsg9JHU840peVn8zFo7WkPnLWbCsM3CKSGulZNf+HWdEViD0lIu1fiWmTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JjIS9dA5EonH+ROORc7w9oofkdudYoC4Hf8cEGTiu0=;
 b=IM83x2MdXDWXfwsbXtOgX74oN62ul3F0nVcf1w+sH/vCCuYbhtnkmWiJNMsRc7sY0Wrlsw4Ri2CBZVRYcPtgevpph5J0YZpGmHCfCrxP7WWYWwzukdowZD57dhfd/5+/t4WqsvSKZAWCGugmtK5xFQGMUQEHUZrQBDRUov0E9omjpCVw69t00sD/Pte2G808ZVBQosJuHerOBSgcDdMkGVpArJjRB5uNXK4hFUZw79pVKm8pDbWfiJox1+3EbjCXJAnlPdOIswIQ145Xx/Hwjcc3KT/XI7oYmXRwk1/OAZl4LB1Sy+jzqjp1L+bVyT81PbU+NCQQqXUxOuEFcqVgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JjIS9dA5EonH+ROORc7w9oofkdudYoC4Hf8cEGTiu0=;
 b=zdd963geXDh+rxCzXRkM4dBn9cyZz7cigzfW6+BnQJEA8vdofvGE/FrGUoIQRaaQXWB+Bst0ojIK74jbI1vRn6DsOYnPqaEh+5altd1QRb5Ts1eVNEHmoQ684HblpJ7HtTDaOeuC0U1JJwMPQHSSzX1P2eoXXtJI+1Q7oYxqvCc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 02:29:17 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 02:29:16 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "bp@alien8.de >> Borislav Petkov" <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Phantom PMEM poison issue
Thread-Topic: Phantom PMEM poison issue
Thread-Index: AQHYDydWdWgzCdPlXk6vesHxVkUTIKxuMvGAgAANDgCAABFmAA==
Date:   Sat, 22 Jan 2022 02:29:16 +0000
Message-ID: <1f480dcc-f4fe-b967-0cfa-35a99d12ec6c@oracle.com>
References: <1737f707-7743-4898-37d4-03098d7aaa57@oracle.com>
 <0aab10e0-6f1d-d67b-8aef-7e3d18e26544@oracle.com>
 <YetdZBbt0P/QBHDr@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <YetdZBbt0P/QBHDr@agluck-desk2.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b0bf54e-ee59-474d-9344-08d9dd4efce0
x-ms-traffictypediagnostic: DM6PR10MB4298:EE_
x-microsoft-antispam-prvs: <DM6PR10MB429859F55756336E6A41FA41F35C9@DM6PR10MB4298.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xs3OTot2tFNLXkMXroOJJ19UPB6sPkG6oFiVqbSx1nRm7ZPj/0yI6EDLfiYYENB0942JIOia1ufwsjIzgKN7lEVDiLsWrgXUE1zCQ5QbbboKzpm17hp6j7WxMr8DK2De4breDriMl/jY/QhTNNp5ApCpUuw0GEJ45pZtC3gG+P9Vc9sZoCES7OspO/qKgyJQA2AqP+bwXTE4eUwQ1BuRe2ckGZItDuArypzmfVEt78tXrbFrd3IRvuYgJRz/evRQKfA2c3zwya+lKrgdsBL+aP/hjPBoATKYK8t7dQkyaFPiTsu7SK4czkQj+WMJ0w1nOrNjBKWVAjC5/2OtlSzP2sS5eYnj92apgBslETw9vnwbQQc8lKATAOzAWIpplOOr3mKZAySIkcJHWvuHQOFZTaS+sSwmJVcMYvRqXeMoyiEh+Sggl6Wc98b0OJaGuqz+Rlxlu2gqteXBvX68NYnyNM6ZpYDWeyXQSMsTUnlvD5FOjmkN3v1ke2sTurV3S7yD98TlcshjasSQBt1Wu8a6QoL7jrJjCX8iiZMqCIdEbkmiVO0ZfDfcxvCHcx1xD/mvyKAP0jr0kOZ3G/z6BfhoWtK5Y1+icfchjmb+IuCPWrEPHu2O9BEsrbEn/BNXmVw3F73WmTxyVoiYB4K+7H6LvriRSaMqCgCsXophDDWSHkR+9zkTnLbC8EHRzw5NEwJMqGnYJpksaI6tetPBsIRtiLcmH1VnT+HFf6n4RKLmUlIqGM9r9KVrVM+iGJxPwGdSQU5As7UEXjHj7q3SWsM8Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(186003)(6506007)(6512007)(3480700007)(8676002)(2616005)(8936002)(44832011)(53546011)(31686004)(38100700002)(64756008)(31696002)(86362001)(4326008)(38070700005)(122000001)(2906002)(71200400001)(6916009)(6486002)(91956017)(316002)(66946007)(5660300002)(66446008)(508600001)(83380400001)(76116006)(66556008)(66476007)(54906003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjhTK0ViYWd5dlg3STB0V3RCSnJidWNGZFVUVDF4elIwdk0yMmhpRStXRlUy?=
 =?utf-8?B?SkxYbTlGcllvVXZkY3pMSDBSSS93b2Jwcm92Y3ZOVUFmWTlicVlKdDBJMGRl?=
 =?utf-8?B?VlB1YXcxelNMbk0zWlRyZ3N6MTNqOTZ5QVlpMWJaRDFZTkozSC9QUk5MbXN5?=
 =?utf-8?B?N0pUQmdQMUt6SmIvOE5waHIzbEZhOU9WN3hWVG9xemZUVCtJaGU4dTZKWTg5?=
 =?utf-8?B?MGxXd21KZ3hidXVJM1ZGYUpWY0JOK1hCY1lBa05VL2VNS3NlaXBIM0QyYnZX?=
 =?utf-8?B?L3JxMC9kN1l1cXByb1A4L0N3OVZrUnh4ZlB4NEU1Tm9mMytha0U4VjIzdnBT?=
 =?utf-8?B?WFhYZDFPK05uNnpzRWFHU1h6SXZJem1ZWGlZZmpmOGlFVmNwUHdySzZNQnhr?=
 =?utf-8?B?Y1NSeXFsTjVyQjBzT0pjOHovaklwOVVYMXFyUXVLUllqd2RRMG15VXV1OUZ2?=
 =?utf-8?B?cGk2SHQrNU1CakNDMHk5Nm40MHJ2VUpwYjU0eTc2aitCK0JENXFOdE10VzhO?=
 =?utf-8?B?YzJoTGJXUXBEQk5TY0F1RTFWd1R3OUVDVnlUQkU3U3IvMU5NSldmZmg1Wm5F?=
 =?utf-8?B?K1V0L2lHYUhzUzZoR2NWTExjWnVPeWNib1RkdXVxWjlWejg2enNiUW9kT0VZ?=
 =?utf-8?B?ZEtvSis3T3M0TjVIc2FObzRLbnpoZ2tCSEwwS0FqZ3ZuaDdhQ0ZUYVMzcUJE?=
 =?utf-8?B?Q0ptU3hZWjhDdGg0ZDlLQ1FqOGZMK0hOc1RxZVlaVHFnRktvVllyY2FWL0hr?=
 =?utf-8?B?dk96VUUvRVBOdFNUaGsreG1jWlBEWXppcWY1NlRiY1dOS3ltVDF1eFFRUkFW?=
 =?utf-8?B?ZktkWUpJRkxRK21FWEhGL3RjTnZVcUxyZjc5K1RvSmJhcnc1UHNqcEVLc204?=
 =?utf-8?B?V2t1MHNZbjQ2djhKblNXd3NndjA4T0lUYWE5b0FHU2F5N25BTksvTEY4UTNv?=
 =?utf-8?B?TVhaelZxaFh1Q0tKYUd4enNLVElSRTUvVzY1T1RCT21COVNTUmdmMlpNbXNl?=
 =?utf-8?B?VElPNjM0emxpRStuYVVYNW5sdkNoVk1zQ095TmhsakZRbzhlZmtaTzhjSktq?=
 =?utf-8?B?ekR0cGEvNFF4aktFZWV2V3pSQndZMnlrWnZmOFhScXpJMnc4WWVzT2tuSEFV?=
 =?utf-8?B?RzBwN2hsSHZBMG84UmdQN0psejBhUTB5U2oxdDMzVzFsNU9vSmkwcDRtWUg0?=
 =?utf-8?B?VWVtYjFtYlh3ZXRPMHlNKzQzZVk4cG1KbStNejlaNkswNHBtR3VsYkZ1SjhU?=
 =?utf-8?B?aW5ZQUNCTnl1RE55b1Z2YXE5amg1bEVQYkxzb3k3UHVrK1dYZlRwUXdIaUV4?=
 =?utf-8?B?KzRqaG95RnRRbWErVXNsTEJESTFTT29YaGl4RlhJR0p5NmZyaFNOUW1raTNw?=
 =?utf-8?B?OWdTbVNXWFErUG1UQUdIaEhvRlg2dU56YU1OSjdrTEgwblV6SUE0OHZoY0d3?=
 =?utf-8?B?T09CdGc2bHN3WkFwcnZEZ0ZjckVaTWhxWHlOdU9UU1VZTWFjKzgvMUczWXEy?=
 =?utf-8?B?UWhYR05CYTY0UWN5ZGhZVDNjMVE5ekRUUjRRM29md1p2dmYzdkIvRFdwWHQ1?=
 =?utf-8?B?VWdadWZiMzFQQ3kxcUk3NlA2MnRhamZaU0Y1aTltSThEclcyeWNFeG55YnRP?=
 =?utf-8?B?MTNzNUFFR2hNV3gzckVobTIvaE9CeWhSUk5aZ0VOb0dIZnR3dCtINkl3cUJH?=
 =?utf-8?B?SjU0UkxHcnFiMFVNOXN2bkZESTJXSjZVSWk3L1NBUUhTemg2QVlPU05sdkxJ?=
 =?utf-8?B?N2wxZlRnbUJnT2dvOFhSRjBVbHNrcHdxTHRGN0gwT0YrYllCZ1l4S0lPM3ZM?=
 =?utf-8?B?WXpkMThvRTBxRkdtc1p6cWkwYlZXamQ3TWRQQU5UNHFDb0V0V2liYmNpQmpC?=
 =?utf-8?B?VjcyU21JbzVGSmZyYmtRcmtSUHRVOGRQUkRDMzVRdlp6THM2STQ3U2hOSVBl?=
 =?utf-8?B?S3MvVUU1QStTcHhsa0pBQXp1UVIvZHkyTkcyUnNhM04ySG5BakM4cEhWNisw?=
 =?utf-8?B?Tk1VYjlwbnhhbW9YcDNGbW5LTzlTdEttdk5NS3VQMW1VRlZyYk1nOUQxeFE3?=
 =?utf-8?B?MjJ3d3plZXB3ZjhyOUtpNHVGNmtGYTd5QUJ3LzVUYWJpMHNlak1mN1RxSFk5?=
 =?utf-8?B?ZE04NklxODRpTnMyYkdKVDdJdXJlT2hnZWk1U1E3U1VmS1NNajBSdDIwbGxU?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <648CA84EBECD3E41AA1B7D4F7A07EEFF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0bf54e-ee59-474d-9344-08d9dd4efce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 02:29:16.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJcm11jPbfPWkeufeTBh5tsj3hGH2htzgowptuKDs/OjOvj/XdZDdZLlm/YqW/dm5IydMc4bmcFJzdjl93E+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201220009
X-Proofpoint-ORIG-GUID: wN4LmmWdk6h5sjvTEaxsREHEtUMBQLU-
X-Proofpoint-GUID: wN4LmmWdk6h5sjvTEaxsREHEtUMBQLU-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMS8yMDIyIDU6MjcgUE0sIEx1Y2ssIFRvbnkgd3JvdGU6DQo+IE9uIFNhdCwgSmFuIDIy
LCAyMDIyIGF0IDEyOjQwOjE4QU0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4gT24gMS8yMS8y
MDIyIDQ6MzEgUE0sIEphbmUgQ2h1IHdyb3RlOg0KPj4+IE9uIGJhcmVtZXRhbCBJbnRlbCBwbGF0
Zm9ybSB3aXRoIERDUE1FTSBpbnN0YWxsZWQgYW5kIGNvbmZpZ3VyZWQgdG8NCj4+PiBwcm92aXNp
b24gZGF4ZnMsIHNheSBhIHBvaXNvbiB3YXMgY29uc3VtZWQgYnkgYSBsb2FkIGZyb20gYSB1c2Vy
IHRocmVhZCwNCj4+PiBhbmQgdGhlbiBkYXhmcyB0YWtlcyBhY3Rpb24gYW5kIGNsZWFycyB0aGUg
cG9pc29uLCBjb25maXJtZWQgYnkgIm5kY3RsDQo+Pj4gLU5NIi4NCj4+Pg0KPj4+IE5vdywgZGVw
ZW5kcyBvbiB0aGUgbHVjaywgYWZ0ZXIgc29tZXRpbWUoZnJvbSBhIGZldyBzZWNvbmRzIHRvIDUr
IGhvdXJzKQ0KPj4+IHRoZSBnaG9zdCBvZiB0aGUgcHJldmlvdXMgcG9pc29uIHdpbGwgc3VyZmFj
ZSwgYW5kIGl0IHRha2VzDQo+Pj4gdW5sb2FkL3JlbG9hZCB0aGUgbGlibnZkaW1tIGRyaXZlcnMg
aW4gb3JkZXIgdG8gZHJpdmUgdGhlIHBoYW50b20gcG9pc29uDQo+Pj4gYXdheSwgY29uZmlybWVk
IGJ5IEFSUy4NCj4+Pg0KPj4+IFR1cm5zIG91dCwgdGhlIGlzc3VlIGlzIHF1aXRlIHJlcHJvZHVj
aWJsZSB3aXRoIHRoZSBsYXRlc3Qgc3RhYmxlIExpbnV4Lg0KPj4+DQo+Pj4gSGVyZSBpcyB0aGUg
cmVsZXZhbnQgY29uc29sZSBtZXNzYWdlIGFmdGVyIGluamVjdGVkIDggcG9pc29ucyBpbiBvbmUN
Cj4+PiBwYWdlIHZpYQ0KPj4+ICAgICAgIyBuZGN0bCBpbmplY3QtZXJyb3IgbmFtZXNwYWNlMC4w
IC1uIDIgLUIgODIxMA0KPj4NCj4+IFRoZXJlIGlzIGEgY3V0LW4tcGFzdGUgZXJyb3IsIHRoZSBh
Ym92ZSBsaW5lIHNob3VsZCBiZQ0KPj4gICAgICIjIG5kY3RsIGluamVjdC1lcnJvciBuYW1lc3Bh
Y2UwLjAgLW4gOCAtQiA4MjEwIg0KPiANCj4gWW91IHNheSAiaW4gb25lIHBhZ2UiIGhlcmUuIFdo
YXQgaXMgdGhlIHBhZ2Ugc2l6ZT8NCg0KVGhlIHBhZ2Ugc2l6ZSBpcyA0SywgdGhlIHNpemUgb2Yg
YmFzZSBwYWdlIG9uIHg4Ni4NCkkgc2FpZCAib25lIHBhZ2UiLCBhcyA4IChwb2lzb25zKSAqIDI1
NkIgPSAyS2lCLCBvbmx5IGhhbGYgcGFnZS4NCg0KPj4NCj4+IC1qYW5lDQo+Pg0KPj4+IHRoZW4s
IGNsZWFyZWQgdGhlbSBhbGwsIGFuZCB3YWl0IGZvciA1KyBob3Vycywgbm90aWNlIHRoZSB0aW1l
IHN0YW1wLg0KPj4+IEJUVywgdGhlIHN5c3RlbSBpcyBpZGxlIG90aGVyd2lzZS4NCj4+Pg0KPj4+
IFsgMjQzOS43NDIyOTZdIG1jZTogVW5jb3JyZWN0ZWQgaGFyZHdhcmUgbWVtb3J5IGVycm9yIGlu
IHVzZXItYWNjZXNzIGF0DQo+Pj4gMTg1MDYwMjQwMA0KPj4+IFsgMjQzOS43NDI0MjBdIE1lbW9y
eSBmYWlsdXJlOiAweDE4NTA2MDI6IFNlbmRpbmcgU0lHQlVTIHRvDQo+Pj4gZnNkYXhfcG9pc29u
X3YxOjg0NTcgZHVlIHRvIGhhcmR3YXJlIG1lbW9yeSBjb3JydXB0aW9uDQo+Pj4gWyAyNDM5Ljc2
MTg2Nl0gTWVtb3J5IGZhaWx1cmU6IDB4MTg1MDYwMjogcmVjb3ZlcnkgYWN0aW9uIGZvciBkYXgg
cGFnZToNCj4+PiBSZWNvdmVyZWQNCj4+PiBbIDI0MzkuNzY5OTQ5XSBtY2U6IFtIYXJkd2FyZSBF
cnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZA0KPj4+IC0xODUwNjAzMDAwIHVuY2Fj
aGVkLW1pbnVzPC0+d3JpdGUtYmFjaw0KPj4+IFsgMjQzOS43Njk5ODRdIHg4Ni9QQVQ6IG1lbXR5
cGVfcmVzZXJ2ZSBmYWlsZWQgW21lbQ0KPj4+IDB4MTg1MDYwMjAwMC0weDE4NTA2MDJmZmZdLCB0
cmFjayB1bmNhY2hlZC1taW51cywgcmVxIHVuY2FjaGVkLW1pbnVzDQo+Pj4gWyAyNDM5Ljc2OTk4
NV0gQ291bGQgbm90IGludmFsaWRhdGUgcGZuPTB4MTg1MDYwMiBmcm9tIDE6MSBtYXANCj4+PiBb
IDI0NDAuODU2MzUxXSB4ODYvUEFUOiBmc2RheF9wb2lzb25fdjE6ODQ1NyBmcmVlaW5nIGludmFs
aWQgbWVtdHlwZQ0KPj4+IFttZW0gMHgxODUwNjAyMDAwLTB4MTg1MDYwMmZmZl0NCj4gDQo+IFRo
aXMgZXJyb3IgaXMgcmVwb3J0ZWQgaW4gUEZOPTE4NTA2MDIgKGF0IG9mZnNldCAweDQwMCA9IDFL
KQ0KDQp5ZXMuDQo+IA0KPj4+DQo+Pj4gQXQgdGhpcyBwb2ludCwNCj4+PiAjIG5kY3RsIGxpc3Qg
LU5NdSAtciAwDQo+Pj4gew0KPj4+ICAgICAgImRldiI6Im5hbWVzcGFjZTAuMCIsDQo+Pj4gICAg
ICAibW9kZSI6ImZzZGF4IiwNCj4+PiAgICAgICJtYXAiOiJkZXYiLA0KPj4+ICAgICAgInNpemUi
OiIxNS43NSBHaUIgKDE2LjkxIEdCKSIsDQo+Pj4gICAgICAidXVpZCI6IjJjY2M1NDBhLTNjN2It
NGI5MS1iODdiLTllODk3YWQwYjliYiIsDQo+Pj4gICAgICAic2VjdG9yX3NpemUiOjQwOTYsDQo+
Pj4gICAgICAiYWxpZ24iOjIwOTcxNTIsDQo+Pj4gICAgICAiYmxvY2tkZXYiOiJwbWVtMCINCj4+
PiB9DQo+Pj4NCj4+PiBbMjEzNTEuOTkyMjk2XSB7Mn1bSGFyZHdhcmUgRXJyb3JdOiBIYXJkd2Fy
ZSBlcnJvciBmcm9tIEFQRUkgR2VuZXJpYw0KPj4+IEhhcmR3YXJlIEVycm9yIFNvdXJjZTogMQ0K
Pj4+IFsyMTM1Mi4wMDE1MjhdIHsyfVtIYXJkd2FyZSBFcnJvcl06IGV2ZW50IHNldmVyaXR5OiBy
ZWNvdmVyYWJsZQ0KPj4+IFsyMTM1Mi4wMDc4MzhdIHsyfVtIYXJkd2FyZSBFcnJvcl06ICBFcnJv
ciAwLCB0eXBlOiByZWNvdmVyYWJsZQ0KPj4+IFsyMTM1Mi4wMTQxNTZdIHsyfVtIYXJkd2FyZSBF
cnJvcl06ICAgc2VjdGlvbl90eXBlOiBtZW1vcnkgZXJyb3INCj4+PiBbMjEzNTIuMDIwNTcyXSB7
Mn1bSGFyZHdhcmUgRXJyb3JdOiAgIHBoeXNpY2FsX2FkZHJlc3M6IDB4MDAwMDAwMTg1MDYwMzIw
MA0KPiANCj4gVGhpcyBlcnJvciBpcyBpbiB0aGUgZm9sbG93aW5nIHBhZ2U6IFBGTj0xODUwNjAz
IChhdCBvZmZzZXQgMHgyMDAgPSA1MTJiKQ0KPiANCg0KSSBzZWUsIHRoaXMgaXMgdGhlIG5leHQg
cGFnZS4uLiB0aGUgaXNzdWUgaXMgcmVwcm9kdWNpYmxlIHdpdGgNCmEgc2luZ2xlIHBvaXNvbiBp
bmplY3Rpb24uDQoNCj4gSXMgdGhhdCB3aGF0IHlvdSBtZWFuIGJ5ICJwaGFudG9tIGVycm9yIiAu
Li4gZnJvbSBhIGRpZmZlcmVudA0KPiBhZGRyZXNzIGZyb20gdGhvc2UgdGhhdCB3ZXJlIGluamVj
dGVkPw0KDQpBbGwgOCBwb2lzb25zIHdlcmUgY2xlYXJlZCBieSB0aGUgZHJpdmVyIHZpYSBEU00s
IGFuZCB2ZXJpZmllZA0KYnkgIm5kY3RsIC1OTXUgLXIgMCIsIHRoYXQgY292ZXJzIGV2ZXJ5IHBh
Z2UgaW4gdGhlIDE2R2lCIC9kZXYvcG1lbS4NCg0KSXQncyBwaGFudG9tIGJlY2F1c2UgdW5sb2Fk
LT5yZWxvYWQgbGlibnZkaW1tLCBmb2xsb3dlZCBieSBhIGZ1bGwgQVJTDQpzY2FuIGNvbmZpcm1z
IHRoZSBwb2lzb24gaXNuJ3QgdGhlcmUsIGhlbmNlIHBoYW50b20uDQoNCnRoYW5rcywNCi1qYW5l
DQoNCj4gDQo+IC1Ub255DQoNCg==
