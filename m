Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D405C5621DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiF3SOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiF3SOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:14:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21542A18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:14:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UHUpUt020594;
        Thu, 30 Jun 2022 18:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e27YmPtAAdLaZlSs7tQam3NrRcqENuYodJjm/CK7ql0=;
 b=CwA8P9q9gzqJW0bnpI6Z3Ik7fDSQK0cJhZQHx6VBa2NkP5NuhzXtsQ1uD7Tc1cC8VsJe
 ou/8q4C7eZ8PJK9xMtl/eZzrI5Czqz6sBY8lc2wovSHccMRny1Ooo7lMiU+VulB61zsf
 s01k3qKzFd0LHN7DbDd8Fe2BqERUJv8y0l6kJZkGMPnQmXc6WHDPvkeYigK2NezsqoBq
 C4W76r89u3e0CmQmJjA8kz4org8MRkCxm4BBWQGKjzl7LDhK7IF94JvTIgikUswQv3IT
 nKP/yWqZYDSPlQsihm5DGYazsrgcq16zrnQfyrpVS8vULXROSx9Je7L1f4yH1aLuLeoJ gA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysn0px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:14:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UI6Ro0034246;
        Thu, 30 Jun 2022 18:14:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt49gcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8xYtcPW1frhU1nMA0yI6sNGKo8L3iCiogl8Sgy0Z9voNhkd+HGLbACM47WXSiH1kbOEx3p1PknDPFEZlrIbZGxBaTqIJ8yJ0RB2dsDifI6A3x6Af01Jc39sMRNVZIFFJ04H/PEkUiZkhC4UWj+4TPIAHByf6BpOlnxGE4bxNysQ5VkztFysAbwX2rINiMbkR31CvbK7sBGD9wcJiRS21sWRFtxZ3GCpwjdjEZqDr0Ivb+8gMo48XB3z+ajxAJirIiN2W9v475z/gm/l3UIAwibW67SsLGptSQE2d4tgrBG5P0FXiBnwwW7UCzm6k27MQh7WGQ87y1eYuwBsPoygJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e27YmPtAAdLaZlSs7tQam3NrRcqENuYodJjm/CK7ql0=;
 b=Q5FFR0tH8VaR4b9fZo3pw6fwlnKGaTICzb6YUHw8xR+o+CFv9zvvbLhvzgthZs9ml+9VX60kVBbXCYS7o535IsClQsoX8XBAv9dy38G47qh/V1eWU63qJ1sseUL++ATFP6fn9nEd2vZSkCY4iJejzW1dp8aVgXdfwoxmIRg+XAEaQ36Iosh/5aDv6xnDKIKMJQTO1RKSdWpJd+WQo4/LRbCWoJHuikMI8ylrYw+wLoBVvi25IzRvxBqjFQtKVVvl/2gTKHxer/0kWRBVbmkK+3NF3T6+730ofjx5HJ4DgR86VpICJpdTOS/ec8XUwUTb37z+qfX1qTcZlQ4fJOsr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e27YmPtAAdLaZlSs7tQam3NrRcqENuYodJjm/CK7ql0=;
 b=p0IyVc5ypFPpyvStBlQK3iSw6DfmVHhpaRi1np89zRU+AV8imcUW6LARsSf5fyBTjy3Wm443ccoKeDZkZZMxqh6VbsjSUX49Hind5hn67SKKkdNiI35VWwKerO1UfE81LIYyz0GifDM3zOlUBRYTWFZZ2hm6NWgXaiRenaSwyN4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN6PR10MB1667.namprd10.prod.outlook.com (2603:10b6:405:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 18:14:19 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20%9]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 18:14:19 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] pmem: fix a name collision
Thread-Topic: [PATCH] pmem: fix a name collision
Thread-Index: AQHYjKojrjx3wgbW9kqQ1gQ/imEzv61oPnmAgAACnwA=
Date:   Thu, 30 Jun 2022 18:14:18 +0000
Message-ID: <84a1d4ee-0eee-22db-df04-03e19cb518c6@oracle.com>
References: <20220630175155.3144222-1-jane.chu@oracle.com>
 <20220630180455.GA17898@lst.de>
In-Reply-To: <20220630180455.GA17898@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2c6da01-c9ec-44ad-421b-08da5ac4599f
x-ms-traffictypediagnostic: BN6PR10MB1667:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GW5i19n9ljx5vYoKFMH5JbxWOA5+uxmr1HDwUAe6kao5L7+6cGuK+ErZxg1x7kW2EdH0MGfBWdOC2o8Dbwc5ZpPeOqPuZzQAuW+YbMkiHEZep0c9LtGQInKCLDBQ4dASPBdGaLkg2c8Kl4oNljnq5ds+w/naTvFysAbTCzYmofW+KOHv13aT8qBVKVk3nN/szWG6ldwlYLZMpKzpk0Rz45opBKmXMBkn/wfpZgLGlx5tiBj2UvUl791KZPTr9/uUhVozm7X1UY8qFfV9WUunaYxmKJMROSYiT/674P/hM4VgfBfx95tYZcJMOXby7SVWSmPUUNPBCc5L0nT9tuKWjKvMHHwuDaQEEO3hX9cjurfjrgWyGoPUoV/gJhZ0TQFYCQ0BPUkOlXy5qxK7Bqb91XxmXXm+RxLjHTgwKFR3do7nu88hhrurhCERICeAE0sP4AVb3B/ImqelFAJPwMOwn4y5pHMwRd0jVCeQkY9Se1EpUGahjytWjWGbjosIAWFV1QNhW86ysEtuadaII6BIF8Hgz3l+zVCl5xy6FFotwjL6ZaVv9ZsXYWpDt8WLSs9ODqF8AdJm3cVZdb0Xe4s38qZDkVIt7yYS0ZiPgoV4T63yfwPb4czqIRPumPQq87YBWv5S2pAByn9ENdUwPoxcTzYvvrhN/yKBf99A9aAkHx5O57kE2WDhCyAT2TqC4dC4zAZo+0rE3XVuOyAMaU1LZcsrQlQ1YxPMF4gtG9ZQhVQmAaqdJAppghpv1k+8xHQh3RSYvGb4Z0uXC/MCedNQe74XNvSj39ib+uHvDNVwRiXKtZiwjS3H5bgvJeryFPSk2gNXmjDcNTkD6m2DQyPy08T/EP/g+KMZ6HnEa/LgyX2FDQdw/Wxa5FBZV0iv6hhD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(39860400002)(346002)(31696002)(86362001)(6506007)(54906003)(41300700001)(5660300002)(44832011)(478600001)(71200400001)(2906002)(4744005)(66476007)(8676002)(38070700005)(64756008)(4326008)(2616005)(53546011)(66946007)(31686004)(6916009)(36756003)(6512007)(76116006)(38100700002)(6486002)(316002)(186003)(26005)(66556008)(122000001)(8936002)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0wrQnMvUXpmeDNVMUlJbGRKdjNiK0gybzVjckloaWNLWUk2YTZ0cWtoSTF1?=
 =?utf-8?B?TERIWVZUN2VwRXhnNG5CVFI0eWN3NWlYdXV1ODB0MHV5cXJjRnRWK1pnVmRE?=
 =?utf-8?B?OWJYTXdvc3NMQklOR0tBa1VWTFJkWS9CNGFZeGRaMUpPT0wvWTNjN3R0aEZG?=
 =?utf-8?B?R3lrcTZiS3pUK1U5U2orZ3NyMkIzVmN3OW1BQTZ4T1I2bE5Pb3ZHZk9GZTF3?=
 =?utf-8?B?YmwwU3kxc2ZPUk05RExFY2xram5CU1ZCbE9oV0RwZGkrWThKTG1rRWNFK1Jk?=
 =?utf-8?B?NnJhOVFkUXJYbUROMUtKSW9FUlZqSmdCeFJpVjZ0cnlHWUhLRS8rcHBWdnlm?=
 =?utf-8?B?T3haai9xL2ltRmw1NGhCaEFUK21WQzhRdlRGdmJscU1NU2Z1S1VQRFJDcnNL?=
 =?utf-8?B?UUZDU3dKbm4xWExzMEZzenp5OFVZQ1NpMS9pQU1oR0xHUnFZNDBqZDlsM0o5?=
 =?utf-8?B?ZElVSlNHanRtV0xKZlkvUm9lVlJjUWZDUUdUNnBMQ0ppeExOWG9SQUxlN2ZW?=
 =?utf-8?B?aXNtN21aRkFCc09xSE5lV2x3KzY4MWhnNFRkWTF4dnF5SEZ0dnZuVjI5aitm?=
 =?utf-8?B?VEc2akJWV2s0TmZ3dEdjMk5ia2lHNm9xSWpjbkZFMjNtMnVMTGxkSHd1aDJs?=
 =?utf-8?B?dHJXRlErVkdlN20rVVpBNVVETWZIcy8wb3gyUVJGUmVFZDFXZnlIWk1OMSti?=
 =?utf-8?B?d1k4TWtZNzR4c0xsL3d2c05mNFNOdzBtYWJQQzZOa242MUdvYlA3S0xYNGND?=
 =?utf-8?B?LzdHbXdWc3FYTmlLTFNSRTloSXR6dlEwTDljSXdtYWlKNkVkdCtsS2oxNStV?=
 =?utf-8?B?NTVmU25yc1VSeitnaDlscmhxeFNOcnQxcS9rV1NaTDZ5WGMwU3dQc2ZGKzdE?=
 =?utf-8?B?NkVZZjNUNG9vb1podVRjREl0VmhVeEF1WWZmNmNOSHNxb2Q1UDNhWEhReDFQ?=
 =?utf-8?B?U2pKOFVnQVBzQ3djQi9ERjdzazVNU3NTaU05REpmSUVuSnlMd1FMRlpXZmdZ?=
 =?utf-8?B?bExEVjU0OVpmMFBRTUpoZmxoYmR3WDRDVzZyYlFpdXZPTE1WcGMxd3NDRzl2?=
 =?utf-8?B?WHFmYzFmdGN1WkUweG43Vy9YcDNtcHlqOEx3NnNqUG9PNUhLV1lmRXk1cExz?=
 =?utf-8?B?NDc2U2VXNktFbHRUU2ZKRkdySHVYbEtETXUxVHBPR0RaNm1GQm4xcE84MzBy?=
 =?utf-8?B?RlhXeXh1RUlCcXhRRDE0Q2QrcUxzTVlQckNkWGc5dThGa2hPd3FzMlI4VDlE?=
 =?utf-8?B?L0hHdDBYaEdLYmtnSHBTMFV1ZExEYTkrcnBGd0ZXWGoxcWU5ajh4Sy9lZXBT?=
 =?utf-8?B?YkZEbFV2T09jZXZZY3ZrRDlWMGhPZUhHYklDTlRHVnBYajZZd0NXazhnd28y?=
 =?utf-8?B?d0taOG9iUUJNK2JHcURWNmNaOXBrUmw5L0RKVERZbXQzeTZUTzdRbHJ2MUMr?=
 =?utf-8?B?MVcyb2xqUFVpWFBmcTlQWnJnRXRlK1B6clllSTNYSFA3S25MektCcnY1NWg2?=
 =?utf-8?B?S0hYcm1zWE13bW8vMjA1SkVzaStGTWtLbjRyLzNxWC9xYm5QY3VoZ1Bhcnc4?=
 =?utf-8?B?ZWRTL3ZPL0k3Wm1UYzgrSVVPQ21MOVl0bTNwanIwd1dMU0JoZmJURWt3SjNR?=
 =?utf-8?B?SCtaT2cyaWdMQ0xaTkw5cFBiT205K04xQkdaVVJ5d3M5MnRrM05ZaEpPb3gv?=
 =?utf-8?B?Zk0xci9VNDZVaDNyQVl5djVSZVI5dmFyK3lyZjFZTXRXRDZyc2FkeTFXcnVS?=
 =?utf-8?B?cWNMclFjVkpZOGFPRlVTbWxSYVRnU29tTDFGTnhuRWlsajlyN1E5RXYxSWow?=
 =?utf-8?B?NHlyWlVoZWdGM000TUg3SnIxTHlpQXd6OUU2WXlaWEQ2Qno2bkpDNkF1a1JX?=
 =?utf-8?B?ZEgyc0xjRHVseElyUUUrdFZPbmNneVZYMnArSTRtbVNjL1BqYmJwYnFjMTdu?=
 =?utf-8?B?b2w0Ui92TTFYLzFJOW55cUl6NmIranhuL1luMFhqYmN3dTRCU0tmYm9XTEdt?=
 =?utf-8?B?Y0pHRnh6NkNrd0Jzc1ZPSjRIK1lMdHBZbldjWnVnUmt0MHpremhVM1J6ZW5T?=
 =?utf-8?B?Rmk2ZGlldUxkUjJTRzFsamJkZmtJOTkvVE5CSWVGaEtRS2VXcitLb056NlhK?=
 =?utf-8?Q?gyiY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <236CCDC8A0B17A488E59FF8CFD293DA2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c6da01-c9ec-44ad-421b-08da5ac4599f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 18:14:18.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5woWY+CxCXB3WlA5Yj7IWGJekZUiy02hIanayiQJeLDIHmmrcWA3BJgkWnVE+9hRAnK7Hrwz+HnB//eZ357ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1667
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300071
X-Proofpoint-ORIG-GUID: F965ISq54khfY4H4xWTyKM7lBbq5e_jO
X-Proofpoint-GUID: F965ISq54khfY4H4xWTyKM7lBbq5e_jO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8zMC8yMDIyIDExOjA0IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1
LCBKdW4gMzAsIDIwMjIgYXQgMTE6NTE6NTVBTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiAt
c3RhdGljIHBoeXNfYWRkcl90IHRvX3BoeXMoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLCBwaHlz
X2FkZHJfdCBvZmZzZXQpDQo+PiArc3RhdGljIHBoeXNfYWRkcl90IF90b19waHlzKHN0cnVjdCBw
bWVtX2RldmljZSAqcG1lbSwgcGh5c19hZGRyX3Qgb2Zmc2V0KQ0KPiANCj4gSSdkIHJhdGhlciBj
YWxsIHRoaXMgcG1lbV90b19waHlzIGFzIHRoYXQgaXMgYSBtdWNoIG5pY2VyIG5hbWUuDQoNCk9r
YXksIHRoYW5rcyENCg0KLWphbmUNCg==
