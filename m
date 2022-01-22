Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807974968C1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiAVAbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:31:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28074 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbiAVAba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:31:30 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LKPvdY031049;
        Sat, 22 Jan 2022 00:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Qw/4K/gi7tGSx38/OuukpZKi8u3/Vrgqanp9G7TekD0=;
 b=Z4HH2/raATbH5PHPLOqjiD9c04rAzuKyw9quJcf+QnKeTMqHgZTqpfTBJXHC+kYaBne3
 C1swnyImW2bSUkTPeZgRTWKtbEfm9s6739Gk8zdRTcCHIi7HDb7BNJEMNxTVGUBeLw5F
 nqFTfK3Awx8o0CsrssSkR6PryEC1T6JZOB890e4u2dDxlPnNJ8Bl6/cZBCpO/+SXJIZm
 xuyQ6FfpM+mkfYnsQpLk8uOJKQa7ziHaAgDDMpXM4tlgMymENls0SUsnw4iOnUxqoFtm
 4vEcg+IuVYstJPyF5gwJZlqEqFAkcfOr6JI+CWu8/xioHRzNZU7MldEnRxvvY+9DmKbf mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhycjwq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 00:31:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20M0H3NF178742;
        Sat, 22 Jan 2022 00:31:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by aserp3030.oracle.com with ESMTP id 3dqj06rbvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 00:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7jgeK23IBkt2cyFtcCCzBG+SWoPOU4f8c/aACmzq0SStl/8URfE0t/kexYEqb22j5HYlNOK8knsaq/B3HAGBO9pFngDROwDQa96L0ZXMFH3CTrZYQVlt0W9LT5fFZX+rnm/Y4p25bn8u0bTMBh45wrEl6XvUUfDQbYX9Y0mjFUyFvg/CDppOfqzPfX4bLMHqIyHV/PvaDC6CEVW8KDMMwovNWZWKMj3IGT9QIcbonBhPSIQif592f3vaqHEKZXuOcomHR+dJZqtNkyNzBZgx6NTCM1t5QMa1kSVatRQBMOd2Jyhn3cPno9kPyXhAQRiCgThHq63uejrrvusV0aoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw/4K/gi7tGSx38/OuukpZKi8u3/Vrgqanp9G7TekD0=;
 b=Si/YpKGrDg6w65dMN90XSCuylQ9si8LAtv/kSzIWLF4N1kIRIXOowiAKW1kX3Nna9odsjRkSQIF5LbTJtB9kewhVac9q5L6oan7dTplLm4WHUhzU0T0ig7MzEdiSfvJzkkfqBMDvC0mCWNguqxfjQenyiZ/4kzx3BIY7fgyduBjnATO/1aCUCuvPdwxRnvHbU1daMRMJsIW95Z0tyk1MGkz6KEnm97a5iGntgBckOuNHdG7L1sf8GoE2iz8XKXsv/fzTo3L+sRdPRlGs8xwJtl4Ws4Ic0GGAzXrLyMJ+Q/plHA5qgaFE2FLRI5dYM9pdcM6dUzhNA3l5aD6+QxzmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw/4K/gi7tGSx38/OuukpZKi8u3/Vrgqanp9G7TekD0=;
 b=gGFwY0yL6Y3j7AOvuLRRkjLC1Q+Z7WWhmymLY1Foda03ZsM21Ea9vaTJnU6gXR6TtwkKuD/SLh1qGxPYjvav3inDtWXIc+elVSPGvhaEcN9sdq01xhxoPiSTLZPPSLNSYcaPQJ86FNOocI80m9XlQYoDUqtvY5FbH+KK+vfUfqs=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MN2PR10MB3614.namprd10.prod.outlook.com (2603:10b6:208:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 00:31:04 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 00:31:04 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "bp@alien8.de >> Borislav Petkov" <bp@alien8.de>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Phantom PMEM poison issue
Thread-Topic: Phantom PMEM poison issue
Thread-Index: AQHYDydWdWgzCdPlXk6vesHxVkUTIA==
Date:   Sat, 22 Jan 2022 00:31:04 +0000
Message-ID: <1737f707-7743-4898-37d4-03098d7aaa57@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac465a8f-e658-43cc-94fa-08d9dd3e795a
x-ms-traffictypediagnostic: MN2PR10MB3614:EE_
x-microsoft-antispam-prvs: <MN2PR10MB361490D5B9E38802C169996CF35C9@MN2PR10MB3614.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 29+vA6GK+0cOYeo9lLYyYNbzypN2qzJDj/EGARpyIGJPT+r4afeLNp364rlAkNpxiwWSybZqTGwcOefX3urqwHmHimNTb7duCVEL6GV8LMqhv2FXv4hfrkcAgshcik9pmpi0cVLHNfDgh4GbaB/6Ny7/6MIJBecdLjKJY2QQM1pmXsxx0QYinKs34f6Y5iDOvFbsQQfJTqwDN1AIknIDMEKE7TDFVWjn18JKeJTowKnQYAR6WVIlseZh63naqBbqKNeXRdzrBG1e63bKZaFrHjXq9NAw6e4sZ1z+Ae2fyCxuClGrlF+nYh/wpS2JPdBstRSO+3NViYCIEm/Aweq5V5VvzbwLejoJs8GQ9nG1A2OnmZYhOhXpAEuCDEA553OMH0/fhbMGiIfBsvLSb0F0gaaWES6bK5zTFrMV3JZee+3E2vAY3S/6Pju3+WORxLp5D+l5Mgxl/l5MdFlof33pI8gQlbPGyiGMLloFiPVuoGmIDB1LpJBeLx/WvL6Tp0pluBsfOU5M8E+F/0YppxH66iNrxGuXniiLorJ2D441EhYIzKIS5GoLW/i28NMx4C+clj1+IfqhQ26q+qhZY/JmtAjpm5H1RxgtL5riaYmV1nbgFN+9KzUskJqpgve8Q/Ks0nfeGQqD1e+phJ1ht+jkH6DN5OXuXxCBKP6mb79TTM4a2KFm77tmtj6O4Y/p6FXT7UaCQtkbzQ3XmFtUNa2bwVIO0rtBb/OfMkM9Ib1jbvnQ8VyXRv7HEZ9sppoxC9kt5Wv+kwVAAxUAkgkdNksQtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(186003)(38100700002)(31686004)(508600001)(66556008)(66946007)(66446008)(76116006)(122000001)(66476007)(64756008)(91956017)(4326008)(83380400001)(44832011)(26005)(86362001)(6486002)(3480700007)(38070700005)(2906002)(6506007)(36756003)(6512007)(8936002)(110136005)(31696002)(54906003)(19627235002)(71200400001)(8676002)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEpJL3lYK0FkYTFxTjRmamhlZHdOOGVNdDlUVEpJanJBYTZHa1M2NkFrNVk2?=
 =?utf-8?B?YTZVUnBRekxKZEhnTG5ySEtVR2N3TmNBT3lCMDd6aXh6WlRBQ21IbFR6VTBa?=
 =?utf-8?B?bnVjNEJpekZ3ZEpHSXRsMGZpR2ZVRDloY1pWc0dGUmRJY25RR2ZnVHQ3d2lk?=
 =?utf-8?B?K3JiN29rTSs2SHlhbldETWw4ZktxOVdlcWgzdGM3QnhtQk5UajA5VGV0N1pZ?=
 =?utf-8?B?YkRXTEhIR0FCamR5UjhIbkZXeURHdUxYZ3NNRlFXRmdkWXNtNk9LdDhFYlRS?=
 =?utf-8?B?c2xGS0wzMmZJTGpCTFBLK2c0dzdNcitDQTdsL2pML2ozb2Zaa3dzbEhCUDhl?=
 =?utf-8?B?T1V1RVVCdXpHMDlOanh6ZUh2Zm9VSmE2WVNVc0c2WlBndkRRaWhGdXN1Zm9q?=
 =?utf-8?B?eUVwSEhTcWxVTE9KbGtlM3hzRGREWlJUVmN5cDYvSkRpRVp4b3MxZUw1THZa?=
 =?utf-8?B?WW1HWmdlRDNtalY2Qm9aWnBGa2pDWXp6SytvOTdSSm10QzVPdkNVekFuUzJl?=
 =?utf-8?B?YXoyb09uOU1peWFqYlZvWlFBTzJtZ2IzRXNqaldUZlZrZkRFdDlpbkpvb1RR?=
 =?utf-8?B?NFFNTUQzSnZscWwvbVRrR1l3L3FXcnF6Y2kyNWZHSTh4a3BKbzJKc0cyQW5h?=
 =?utf-8?B?Z1RHNGMyV3djKytEVjZQaEMrM0tCZ3pqTS8vdHVFU0FSYlZmMWR1Y0ZUZy9E?=
 =?utf-8?B?SGQwY3hBM3d5UEN6SHlZVCtWbWpPNTZ0Nmg1YWtrUFB3Ymx2V3hZVGFQdVFW?=
 =?utf-8?B?UjlzeERhSkVUOWJqQ1RMMm1Rd0QxbDhtUVRBWG5HdjNOckVSZ0tVNVBYY2tN?=
 =?utf-8?B?ZmtnYmYvZ29IR2xRZjB0WUFhSXJPVnFpdUhKK0RIUW51QW9wTUhCSnEveFZQ?=
 =?utf-8?B?QnFtZXByZXpCUFN1Y1plTG5QTW81MmwxTm9WS3kvY0oxUk1FNTU4dTA2bHNX?=
 =?utf-8?B?enB0eVN6ME5GT2JjTytlY1lMaHg3akNScTQzUmMvcFJzZlF3UTNiU1dPMTdR?=
 =?utf-8?B?RTA3ZSs3NmFnd0tQZlBVUXFlVlRGVVRnUS9aQXp6R0o0aW5ZOU1yRi9PNnlP?=
 =?utf-8?B?RHlmNmNyLzFPT0FXRkNUQ2wxbXNPVktKZzkwRVRUOXdFemcrT0RMU3ArME91?=
 =?utf-8?B?K3hJNk04SEc5WmszdGlFS3RuTnRFQlprUzFsZUt2bGRuN3lveUkvZ0p1UmRO?=
 =?utf-8?B?YWI2cEl5eTJhZUFySVVzekFxcGZjMjZWNmNrUkhhUko3L0xRMVBNMGxjM09n?=
 =?utf-8?B?cDZwM1Z0KzIxOEFtVFJNYUlENU5EVlVWTE9MSGZQZk9BeXp1bWtmbzRkVlVB?=
 =?utf-8?B?bVRoMjBKbmhTeHl1Z3l0OWwwSXV5QU5XR2VvdllIdnRsbGZLcUhtaGp5TTNj?=
 =?utf-8?B?VE5Vb3BpSFIxVTFaL0FoK1BZNkkvSzY2TlB3K25wMGg1cEN3eG9mTktUSUpq?=
 =?utf-8?B?Q2ZaR2RNS3h4MFhZOVNlUWs2aW1JR0hIOWZFcThlQ1FDbEQ0NnZaV0duRCt0?=
 =?utf-8?B?L0xObnY1R1lVZHB1cGlEbExVV2Z4V2ovdXg1cFBzZWg0b2x2TnNEMCtGTTVP?=
 =?utf-8?B?YmJIdjdGKzk4YWpRMTZSV2pSek0remt2VjRkaWVpSjB0djliblN4aTVrbDFi?=
 =?utf-8?B?Wnordk9McnIvNjAxSEkxd08vdVpFT0FuMC9EMGx5cnEyLzhudm9EV01ZMXRM?=
 =?utf-8?B?amFiVFZFVENiMThXck9VWE03VnFheTJxMjErVG1LY1lnQndPL0xtQWtYaVhs?=
 =?utf-8?B?NGdUNis0Z0dOTnU2S1hBSVhuS20xYWpPWkVFSGRzWlhpVHozcElsNnpxZ2o0?=
 =?utf-8?B?NlpOcjJHRzNINVdrMWVINWtuc1EyakI5Tm5UMWNOV2xQM2JZU2lEdURwWXlp?=
 =?utf-8?B?WWlZUjlDZjZHWVhVQjhtTGRDTVlXMTgwNFZ6VmY1ZnMyalpyQWtFUzZvVTRP?=
 =?utf-8?B?TmhqLzh6bWJhOVpSaXpzbmwzR3RSbStzQVZCMGJIaVpBZVoweURpS3pSY2lE?=
 =?utf-8?B?aGRrREEvaU8zZGFjcTZuOTVGR1pYTFVwTkw4SVlvVVUyamd3bEt3SlJJd1N4?=
 =?utf-8?B?d1I0RldPcUVWSE1abWFsM1FHUE9ydzZZTDBLMERuVUZxWXVHdld5T0IyZllt?=
 =?utf-8?B?dHVUbk9pYzdabzhqZ2FxWDZnZFlLWUJheWJ5Z042a0hTNTBhdjRQSHVLYVk5?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE6477DEB1122439AA5DD84D0032EC7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac465a8f-e658-43cc-94fa-08d9dd3e795a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 00:31:04.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1hAz83PhLFh1O6lWhKb4c3RQfUsMBdI6xVVCh8UAd4Zbwnd6H4tTGwpFFw9ddZXLhfukfhzqgnjzEh9zBeSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3614
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201220000
X-Proofpoint-ORIG-GUID: zAM7uncsTTIr4XHSmuQKa01XwTUKUTSW
X-Proofpoint-GUID: zAM7uncsTTIr4XHSmuQKa01XwTUKUTSW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gYmFyZW1ldGFsIEludGVsIHBsYXRmb3JtIHdpdGggRENQTUVNIGluc3RhbGxlZCBhbmQgY29u
ZmlndXJlZCB0byANCnByb3Zpc2lvbiBkYXhmcywgc2F5IGEgcG9pc29uIHdhcyBjb25zdW1lZCBi
eSBhIGxvYWQgZnJvbSBhIHVzZXIgdGhyZWFkLCANCmFuZCB0aGVuIGRheGZzIHRha2VzIGFjdGlv
biBhbmQgY2xlYXJzIHRoZSBwb2lzb24sIGNvbmZpcm1lZCBieSAibmRjdGwgDQotTk0iLg0KDQpO
b3csIGRlcGVuZHMgb24gdGhlIGx1Y2ssIGFmdGVyIHNvbWV0aW1lKGZyb20gYSBmZXcgc2Vjb25k
cyB0byA1KyBob3VycykgDQp0aGUgZ2hvc3Qgb2YgdGhlIHByZXZpb3VzIHBvaXNvbiB3aWxsIHN1
cmZhY2UsIGFuZCBpdCB0YWtlcyANCnVubG9hZC9yZWxvYWQgdGhlIGxpYm52ZGltbSBkcml2ZXJz
IGluIG9yZGVyIHRvIGRyaXZlIHRoZSBwaGFudG9tIHBvaXNvbiANCmF3YXksIGNvbmZpcm1lZCBi
eSBBUlMuDQoNClR1cm5zIG91dCwgdGhlIGlzc3VlIGlzIHF1aXRlIHJlcHJvZHVjaWJsZSB3aXRo
IHRoZSBsYXRlc3Qgc3RhYmxlIExpbnV4Lg0KDQpIZXJlIGlzIHRoZSByZWxldmFudCBjb25zb2xl
IG1lc3NhZ2UgYWZ0ZXIgaW5qZWN0ZWQgOCBwb2lzb25zIGluIG9uZSANCnBhZ2UgdmlhDQogICAj
IG5kY3RsIGluamVjdC1lcnJvciBuYW1lc3BhY2UwLjAgLW4gMiAtQiA4MjEwDQp0aGVuLCBjbGVh
cmVkIHRoZW0gYWxsLCBhbmQgd2FpdCBmb3IgNSsgaG91cnMsIG5vdGljZSB0aGUgdGltZSBzdGFt
cC4gDQpCVFcsIHRoZSBzeXN0ZW0gaXMgaWRsZSBvdGhlcndpc2UuDQoNClsgMjQzOS43NDIyOTZd
IG1jZTogVW5jb3JyZWN0ZWQgaGFyZHdhcmUgbWVtb3J5IGVycm9yIGluIHVzZXItYWNjZXNzIGF0
IA0KMTg1MDYwMjQwMA0KWyAyNDM5Ljc0MjQyMF0gTWVtb3J5IGZhaWx1cmU6IDB4MTg1MDYwMjog
U2VuZGluZyBTSUdCVVMgdG8gDQpmc2RheF9wb2lzb25fdjE6ODQ1NyBkdWUgdG8gaGFyZHdhcmUg
bWVtb3J5IGNvcnJ1cHRpb24NClsgMjQzOS43NjE4NjZdIE1lbW9yeSBmYWlsdXJlOiAweDE4NTA2
MDI6IHJlY292ZXJ5IGFjdGlvbiBmb3IgZGF4IHBhZ2U6IA0KUmVjb3ZlcmVkDQpbIDI0MzkuNzY5
OTQ5XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxvZ2dlZA0K
LTE4NTA2MDMwMDAgdW5jYWNoZWQtbWludXM8LT53cml0ZS1iYWNrDQpbIDI0MzkuNzY5OTg0XSB4
ODYvUEFUOiBtZW10eXBlX3Jlc2VydmUgZmFpbGVkIFttZW0gDQoweDE4NTA2MDIwMDAtMHgxODUw
NjAyZmZmXSwgdHJhY2sgdW5jYWNoZWQtbWludXMsIHJlcSB1bmNhY2hlZC1taW51cw0KWyAyNDM5
Ljc2OTk4NV0gQ291bGQgbm90IGludmFsaWRhdGUgcGZuPTB4MTg1MDYwMiBmcm9tIDE6MSBtYXAN
ClsgMjQ0MC44NTYzNTFdIHg4Ni9QQVQ6IGZzZGF4X3BvaXNvbl92MTo4NDU3IGZyZWVpbmcgaW52
YWxpZCBtZW10eXBlIA0KW21lbSAweDE4NTA2MDIwMDAtMHgxODUwNjAyZmZmXQ0KDQpBdCB0aGlz
IHBvaW50LA0KIyBuZGN0bCBsaXN0IC1OTXUgLXIgMA0Kew0KICAgImRldiI6Im5hbWVzcGFjZTAu
MCIsDQogICAibW9kZSI6ImZzZGF4IiwNCiAgICJtYXAiOiJkZXYiLA0KICAgInNpemUiOiIxNS43
NSBHaUIgKDE2LjkxIEdCKSIsDQogICAidXVpZCI6IjJjY2M1NDBhLTNjN2ItNGI5MS1iODdiLTll
ODk3YWQwYjliYiIsDQogICAic2VjdG9yX3NpemUiOjQwOTYsDQogICAiYWxpZ24iOjIwOTcxNTIs
DQogICAiYmxvY2tkZXYiOiJwbWVtMCINCn0NCg0KWzIxMzUxLjk5MjI5Nl0gezJ9W0hhcmR3YXJl
IEVycm9yXTogSGFyZHdhcmUgZXJyb3IgZnJvbSBBUEVJIEdlbmVyaWMgDQpIYXJkd2FyZSBFcnJv
ciBTb3VyY2U6IDENClsyMTM1Mi4wMDE1MjhdIHsyfVtIYXJkd2FyZSBFcnJvcl06IGV2ZW50IHNl
dmVyaXR5OiByZWNvdmVyYWJsZQ0KWzIxMzUyLjAwNzgzOF0gezJ9W0hhcmR3YXJlIEVycm9yXTog
IEVycm9yIDAsIHR5cGU6IHJlY292ZXJhYmxlDQpbMjEzNTIuMDE0MTU2XSB7Mn1bSGFyZHdhcmUg
RXJyb3JdOiAgIHNlY3Rpb25fdHlwZTogbWVtb3J5IGVycm9yDQpbMjEzNTIuMDIwNTcyXSB7Mn1b
SGFyZHdhcmUgRXJyb3JdOiAgIHBoeXNpY2FsX2FkZHJlc3M6IDB4MDAwMDAwMTg1MDYwMzIwMA0K
WzIxMzUyLjAyNzk1OF0gezJ9W0hhcmR3YXJlIEVycm9yXTogICBwaHlzaWNhbF9hZGRyZXNzX21h
c2s6IA0KMHhmZmZmZmZmZmZmZmZmZjAwDQpbMjEzNTIuMDM1ODI3XSB7Mn1bSGFyZHdhcmUgRXJy
b3JdOiAgIG5vZGU6IDAgbW9kdWxlOiAxDQpbMjEzNTIuMDQxNDY2XSB7Mn1bSGFyZHdhcmUgRXJy
b3JdOiAgIERJTU0gbG9jYXRpb246IC9TWVMvTUIvUDAgRDYNClsyMTM1Mi4wNDgyNzddIE1lbW9y
eSBmYWlsdXJlOiAweDE4NTA2MDM6IHJlY292ZXJ5IGFjdGlvbiBmb3IgZGF4IHBhZ2U6IA0KUmVj
b3ZlcmVkDQpbMjEzNTIuMDU2MzQ2XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hl
Y2sgZXZlbnRzIGxvZ2dlZA0KWzIxMzUyLjA1Njg5MF0gRURBQyBza3ggTUMwOiBIQU5ETElORyBN
Q0UgTUVNT1JZIEVSUk9SDQpbMjEzNTIuMDU2ODkyXSBFREFDIHNreCBNQzA6IENQVSAwOiBNYWNo
aW5lIENoZWNrIEV2ZW50OiAweDAgQmFuayAyNTU6IA0KMHhiYzAwMDAwMDAwMDAwMDlmDQpbMjEz
NTIuMDU2ODk0XSBFREFDIHNreCBNQzA6IFRTQyAweDANClsyMTM1Mi4wNTY4OTVdIEVEQUMgc2t4
IE1DMDogQUREUiAweDE4NTA2MDMyMDANClsyMTM1Mi4wNTY4OTddIEVEQUMgc2t4IE1DMDogTUlT
QyAweDhjDQpbMjEzNTIuMDU2ODk4XSBFREFDIHNreCBNQzA6IFBST0NFU1NPUiAwOjB4NTA2NTYg
VElNRSAxNjQyNzU4MjQzIFNPQ0tFVCANCjAgQVBJQyAweDANClsyMTM1Mi4wNTY5MDldIEVEQUMg
TUMwOiAxIFVFIG1lbW9yeSByZWFkIGVycm9yIG9uIA0KQ1BVX1NyY0lEIzBfTUMjMF9DaGFuIzBf
RElNTSMxIChjaGFubmVsOjAgc2xvdDoxIHBhZ2U6MHgxODUwNjAzIA0Kb2Zmc2V0OjB4MjAwIGdy
YWluOjMyIC0gIGVycl9jb2RlOjB4MDAwMDoweDAwOWYgWy4uXQ0KDQpBbmQgbm93LA0KDQojIG5k
Y3RsIGxpc3QgLU5NdSAtciAwDQp7DQogICAiZGV2IjoibmFtZXNwYWNlMC4wIiwNCiAgICJtb2Rl
IjoiZnNkYXgiLA0KICAgIm1hcCI6ImRldiIsDQogICAic2l6ZSI6IjE1Ljc1IEdpQiAoMTYuOTEg
R0IpIiwNCiAgICJ1dWlkIjoiMmNjYzU0MGEtM2M3Yi00YjkxLWI4N2ItOWU4OTdhZDBiOWJiIiwN
CiAgICJzZWN0b3Jfc2l6ZSI6NDA5NiwNCiAgICJhbGlnbiI6MjA5NzE1MiwNCiAgICJibG9ja2Rl
diI6InBtZW0wIiwNCiAgICJiYWRibG9ja19jb3VudCI6MSwNCiAgICJiYWRibG9ja3MiOlsNCiAg
ICAgew0KICAgICAgICJvZmZzZXQiOjgyMTcsDQogICAgICAgImxlbmd0aCI6MSwNCiAgICAgICAi
ZGltbXMiOlsNCiAgICAgICAgICJubWVtMCINCiAgICAgICBdDQogICAgIH0NCiAgIF0NCn0NCg0K
QWNjb3JkaW5nIHRvIG15IGxpbWl0ZWQgcmVzZWFyY2gsIHdoZW4gZ2hlc19wcm9jX2luX2lycSgp
IGlzIGZpcmVkIHRvIA0KcmVwb3J0IGEgZGVsYXllZCBVRSBhbmQgaXQgY2FsbHMgbWVtb3J5X2Zh
aWx1cmUoKSB0byB0YWtlIHRoZSBwYWdlIG91dCANCmFuZCBjYXVzZXMgZHJpdmVyIHRvIHJlY29y
ZCBhIGJhZGJsb2NrIHJlY29yZCwgYW5kIHRoYXQncyBob3cgdGhlIA0KcGhhbnRvbSBwb2lzb24g
YXBwZWFyZWQuDQoNCk5vdGUsIDEgcGhhbnRvbSBwb2lzb24gZm9yIDggaW5qZWN0ZWQgcG9pc29u
cywgc28sIG5vdCBhbiBhY2N1cmF0ZSANCnBoYW50b20gcmVwcmVzZW50YXRpb24uDQoNCkJ1dCB0
aGF0IGFzaWRlLCBpdCBzZWVtcyB0aGF0IHRoZSBHSEVTIG1lY2hhbmlzbSBhbmQgdGhlIHN5bmNo
cm9ub3VzIE1DRSANCmhhbmRsaW5nIGlzIHRvdGFsbHkgYXQgb2RkcyB3aXRoIGVhY2ggb3RoZXIs
IGFuZCB0aGF0IGNhbm5vdCBiZSBjb3JyZWN0Lg0KDQpXaGF0IGlzIHRoZSByaWdodCB0aGluZyB0
byBkbyB0byBmaXggdGhlIGlzc3VlPyBTaG91bGQgbWVtb3J5X2ZhaWx1cmUgDQpoYW5kbGVyIHNl
Y29uZC1ndWVzcyB0aGUgR0hFUyByZXBvcnQ/ICBTaG91bGQgdGhlIHN5bmNocm9ub3VzIE1DRSAN
CmhhbmRsaW5nIG1lY2hhbmlzbSBtYW5hZ2UgdG8gdGVsbCB0aGUgZmlybXdhcmUgdGhhdCBzby1h
bmQtc28gbWVtb3J5IFVFIA0KaGFzIGJlZW4gY2xlYXJlZCBhbmQgaGVuY2UgY2xlYXIgdGhlIHJl
Y29yZCBpbiBmaXJtd2FyZT8gIE90aGVyIGlkZWFzPw0KDQoNClRoYW5rcyENCi1qYW5lDQo=
