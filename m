Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE9473DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhLNHmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:42:08 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:44698 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhLNHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:42:07 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE7f8DE014387;
        Tue, 14 Dec 2021 07:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=WeOzXlXjN2lJhj8bga8LAEyS62N8hvIFVYlxx8WC5K0=;
 b=HUo9xCGyiqvAnOa04EXf9bsiY+AfuA32WMP+gNCJmU3YQxp0qWNjSJ8yj9QQWeA8eqgM
 grRWgQhuu5pzHXiIo3bVQ9O4Cdi4bAjyf5grI78ayM22QooHPNz/SDio6WBLXbW5tX/G
 cpOUw+3lAOL0ieocb1cEPGGQthye8R/PXH/7eN6OxoOtGAw8zsp+PIoXNzIzYly9Ot8Q
 g2etZUDojXZk/8nSzLgekALatDOA4u3mWtb7N/fvgCiCbGq1DXFZTZplc+fAG9+VwTcY
 FxFzYZ3j2dP91YBLQPHl/DZzve5bK3YH4Qkj9JXUR1QQKeHClUPrVJuvQvrNHiBdS7j1 Ow== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cxjt104cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 07:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQsR+eDUOGs/Gi7EDnJl4TYaZsPYvC+HY/ZHdfAKf1pm9wLe2YPhNyZpHQ6nBng+2R1D7wBdFsBS6dl1Jw6onOgNCwtlnq4arjO/j77wjyBgnd5oMgDlYEep8zlz8G5crn+oaj5qbPaRDL5F1WEKHRT4zkUU9ZnyyXBnQExCqOflA5p7qHw5vd0Ns5S4CZ3oR9i8xZTGBmpcjUhtcC2dbSb/kbEsVwmPBdQjPAuezCU9B75BtVE74RPppodAhm60eQVwP3kZmaUSKGaGW+oGXTCgYpdyNNlRW2ENSdAHMx4w4n0h748wv0++auNlDpp5frpYnsDPoBm3Yx58XJAvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeOzXlXjN2lJhj8bga8LAEyS62N8hvIFVYlxx8WC5K0=;
 b=AAz1G6pQDGnBv9VQy65Y6/k/5owr/XEvhURwRBp5XxZuQ3OiSw4CjSHv7xJoN8x13w92U8QHViT93DtTcm3Oi99a5roylYGbNuBpVW112JUQrxyduTnN1dIlEss1ju9fBgNkQhi3lE60zD0XETtqz7hlrHiVy419VlEF9gTB1lvF4mObmXVYY22huXDauTk5+3IkAxqKGNVtvrJIJATluAZK6HlsMS9H01EWyN9vzsCcqRVx9ICd6P2tydrfPPPKUtBBOE5/6+MlTG2HLWbC1NVDuGTXCrjym8UOK8xu1ifCAOQtks+no+3rcjKLX+kN7ytWD3G+VIINKnGjMfVWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 14 Dec
 2021 07:42:01 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:42:01 +0000
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
 <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <2c9f2f34-9dab-4f1b-bc10-48212fb70335@windriver.com>
 <CAFA6WYPfjGqY6GJqLmrhU7CBjBTEYZzuCptHLJe2aEGUM_kOBA@mail.gmail.com>
 <3c130368-6933-55cf-eb05-431f326c5be8@windriver.com>
 <CAFA6WYNh6WmkeZFCOPJpu69ypyWc7itMBdhTg3yqnH0MbOhFcQ@mail.gmail.com>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <745233d9-81a2-df65-657d-efd7d45e658f@windriver.com>
Date:   Tue, 14 Dec 2021 15:41:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAFA6WYNh6WmkeZFCOPJpu69ypyWc7itMBdhTg3yqnH0MbOhFcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19e9cfe0-4ff1-475e-db33-08d9bed5370c
X-MS-TrafficTypeDiagnostic: PH0PR11MB5831:
X-Microsoft-Antispam-PRVS: <PH0PR11MB583122686805F04FDDF8002195759@PH0PR11MB5831.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9unrYwTLzDMaWmK9R7m60QqICd4q6o3epSHbgxq4iH1/FAc9DEIcCFPU6eTR29EAg/5CvzPAE1yrqxu39splBKAjvlk/hFJ5SSU1LaSrTmCWLyCa0mK+Nh6sEqtltoOdfH+L2nVDVm8qO4qsbNGn1eU/jw/7gU2qyTbjFNwkaMq5KPge7ubd0IcWKGeaRkIua3GBcsFiXDc/dyqJf8GjI8Za+NomaJ5BvDy0TgmFFBpzYuk3uFGgV3XlsrwoVGaT1YeOIRcC6RrYNzUwm+tfHEK0HW8YzxzWuMFG53CwoOsl0wKAzwvjtb+Kf6Jjq8TZbXsVDwBYxnNiCt48pU8bTvqdOkKiYycv29HgY1Va0vhPXuyI5TDFFQaYk+BGv7Tnd0V2lt76ZgBSDNLTHFkbAL7NI+xmOkGbJyIJR7cE5QegKhWxhpnXD1g3qxLjHT9nckmTtlz7c5NWj3o8Sjt4QDI7syttnEZoy4iLzw6SX+7fqrCNX8Wu9wfKh5kucdhI7+izeJkhLnr/9AMcaFv8rETaNTDMG37KCtQJSG5fBjeLU5zDgneHIRVyiZ35f7zK6WQI6qD2fHsSkXXH2oMQ+FoAPbftflaB6gJSShigxmoppovd8bzfknjUsVT22GZkcIa1btACpHdIoWu7CBK6t4OPVS8/rztrSG4W1ZmggpFxPmJPBpZpHnxggQotBtc2VGqz5mG9NcFv0WhUu7gfbA0onsUhwdZ0R1E1Ld/SMG9c3P1MaS4QghdOO/MXw4X6+kYtQ5uf/+HdN3dELJO1+T4CuQvLq2lGlATs+cq5BXR8vzMKHbUMncLqDf4J172PD5Ilpc7EV1sTXNbfY3jX6fZByIwilS1hHiiXpxVKKxCRTBB5/VqVfL/YBw7nXA+57kN5NRpeuqbx6M2tLq+haoeIgHh28dR8Dp5Po2v1og=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(2616005)(6512007)(36756003)(6666004)(2906002)(966005)(508600001)(38350700002)(4326008)(53546011)(83380400001)(31696002)(186003)(26005)(316002)(86362001)(6506007)(8676002)(5660300002)(6916009)(54906003)(8936002)(66946007)(31686004)(38100700002)(6486002)(52116002)(66476007)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZPTmZzeWJ5NU5DOGtMejNPMUZacTl3ZjJEdTFuMUI2OUJPQm9XN1E3NFls?=
 =?utf-8?B?QWEzR25oTURxcmVSelNDaEZaSlp4OWFLODB0SkZwakpoMllJalpHZVEwazNk?=
 =?utf-8?B?OHJuRWc3ZEZBT3NCK0R6ckNWUmJ4OFJYaFpjN3kxQjBXZStTenBhM2JQK1JD?=
 =?utf-8?B?ZHBzcm1OM2twWElBa0JPdFJ5S0hPNGh6WmxXb1BMdFNIcnpvMnZuajMxbk1t?=
 =?utf-8?B?aFBjWTdheFMydVJjaUNnb3BRanpmc3QvdjJnMjhCamd3STk2c084OXdJWlNW?=
 =?utf-8?B?UlBPM0JqUDhyMDg0aXZnaGUvWVZTVVdOdzVEM3ZFQnZzRmNKa29TN29FTno3?=
 =?utf-8?B?b25HcWs3YytjRzgvRmpsdGdBdEkrbTZRMGV5VjJIOFJCbzE1Z1RzVmZpNC9o?=
 =?utf-8?B?RXh2cSt4eXcxam5HY1A2cjlaNUMrTDZlVGhLUmF0WlIyNlpqLzl1ZTdPMFM4?=
 =?utf-8?B?a3VmOWFDWTVtUkdLNmpBMjVScnduck9OZFNQcWMwZ215VXVTN0FDRzJCUTc5?=
 =?utf-8?B?VTkyNWJ6cmhWS2Z6RUNKdDZlN09pT09qRkpxd0RMT2MxSlU3dFowZmZkS0l2?=
 =?utf-8?B?bllrcTRza05YU3hneE9la0pLT29OWitMak9yMEU1TytCTUkxaWlxUy9yNDBx?=
 =?utf-8?B?V3d0YWh4TlNHYzUrSVJLTVRXTW1GazMwelZWUjErbmtUU2dSQUs3UUpiL0ND?=
 =?utf-8?B?ZE5SS1Z6cG80alpDSXJ2bXdkU0swdzZHb1hWMkxMdlQ1V24xL0tTMDgxcVpM?=
 =?utf-8?B?aDhxTnB2WkdDTE9DS3kzQWdZR1J2NjMzMUg0ZVJaMjFjOEFoZVZNSGlCRXNy?=
 =?utf-8?B?YkRTeUNPb2tsRTNReklHUjBzbDEzbXdEbm04MURXM0R0MFNvaVhhMVd4Y3d3?=
 =?utf-8?B?dm5WaVVCdHZtYWRrZkZqQnpqRWlNcWx1a1MrZXlCNUZnQTJ3b01maitNVW1P?=
 =?utf-8?B?SFFESGt1M0pnTjI3VEtWditLcG9WckpJWTJQUTNGM3lEUEo1QUlRb251K2tO?=
 =?utf-8?B?WlY5ZlJoZXpiOGExcEx3dzRmM0hnR3hSWnhDbGZvQTd4VHhiVTRJWDVqYi9P?=
 =?utf-8?B?L1NUTzdacGpRdEtzVnJ6RXRSWDNOeERSQTJNL2ZkeGtFS2N3V0pCNGRyUXVY?=
 =?utf-8?B?UEc5NmRXT05RbnVhUXhtWEZKWU1PSk1SVDNBZStzMkkxd2N6cE96Vkw2cm9N?=
 =?utf-8?B?Rlk0dWhoMnh6R2tlL1dzZVY4SW5JZmM3djNGMUw4QWZtUGtWWTZvWDYvMXp1?=
 =?utf-8?B?L0x0YlZHSFBzQWtwQWZ6TUVRMThqdXRvUElEYXVxMVNiSllpZWhSbVUyczda?=
 =?utf-8?B?amVpaUpBTUxGVkFCRWVjN21HdHI5eERrcHBRMjl0QUFUNGp5Y0ZPT0JpUm11?=
 =?utf-8?B?Sm5TbmVQL3gxRkd6Ym1vWVJSamt2QlpFRkdTcnlKMEF0VXpnaHFuRFhtaWYr?=
 =?utf-8?B?a0F2b1hUVUcvMjVyM2NJRVhNOGRKU2trRDJYb1JNZFBXMDJvbEkwWGcrUzR4?=
 =?utf-8?B?K1NCTHRqN04yYnZaQXN3Q2NZYnFaSEZZcWw2ZHFrK21MUEZOUHJyVExjbVdQ?=
 =?utf-8?B?T1YwOGlIVkN3eWIxdlQzTlZYcWFBRGUzRW5yUEYxSjNFdlVYSEJQMmdha1BD?=
 =?utf-8?B?R1AxVzZKN2xIMTBaZUZGQlpRaUY0dmJodUJSaTBvYVZpbWY0ejQrRUgvNVUv?=
 =?utf-8?B?Y1NReUVuTVYzWElvTitTUVdtRi9jZE00UTB0UTR2R0NIUW80a1U4ak0zK2px?=
 =?utf-8?B?TWJneUF1SEFsNm9JS0R5MmZxSWxVNHlKUzY0UnhCMzhScDk4d3lPMVhoalBF?=
 =?utf-8?B?RVV2QXpwWHcvUlZ1MnpRcVdPT1d1cUdKc0dXT3dLOGo4cncvQVhuaXk5R1Zh?=
 =?utf-8?B?K05TR3Z0WllwaGNReW1nMmxtYWdobHNSazFOZmN0UGhmSUkxYktMcmVNTVZQ?=
 =?utf-8?B?U05OTk8rbmRUT1k5UHg1NytwYVBuRkVLSFJ5MDA3UktIQ0F5dkVHZU9TQmVw?=
 =?utf-8?B?WWdxbFN3OUV4ZjlreHBEOHE3MzFlazFpWTNtWlpzRE1za25Qd1J3cjkrUHNh?=
 =?utf-8?B?aFVESXd4cjI2Uk5lZTBEQzhqN2lKS21wd3Q1NVdCb1RNVy93WUwvdDFoME5s?=
 =?utf-8?B?cnV6cDE0OVNXUmc2OFdJbWorL0EyS0RUYlNUQ0lpVzhGeWhDTG5qYURHVGk1?=
 =?utf-8?B?ZFJScURITGMwcFM3NE5tQ1NzcmdSWEk1TDRBL09lMTBMUWNGUmxqZ0hvWnVk?=
 =?utf-8?Q?3MMvfzsdSc9RLHHv/vpByoUXl0LEBZJ3fL1EhxchUo=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e9cfe0-4ff1-475e-db33-08d9bed5370c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 07:42:01.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t23xgUPJ8iWr+OpdctGj8q2+McJjKrDvSFasEZYBLjV+TTEiJ2ACiVyzV/Mlj4KnR4nJA4YB12wfhbQA/sSwC4rfAeCnJYjJF3r3EKBxLxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
X-Proofpoint-GUID: d1ENb9fwn4Z3HNQ_NEHN0STwxcX-sIEe
X-Proofpoint-ORIG-GUID: d1ENb9fwn4Z3HNQ_NEHN0STwxcX-sIEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_02,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/21 3:29 PM, Sumit Garg wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Tue, 14 Dec 2021 at 12:41, wangxiaolei <xiaolei.wang@windriver.com> wrote:
>>
>> On 12/13/21 5:04 PM, Sumit Garg wrote:
>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>
>>> On Mon, 13 Dec 2021 at 14:25, wangxiaolei <xiaolei.wang@windriver.com> wrote:
>>>> On 12/10/21 5:38 PM, Sumit Garg wrote:
>>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>>>
>>>>> On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
>>>>>> +CC Jens, Etienne
>>>>>>
>>>>>> On 12/10/21 06:00, Sumit Garg wrote:
>>>>>>> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Sumit Garg <sumit.garg@linaro.org>
>>>>>>>> Sent: Thursday, December 9, 2021 7:41 PM
>>>>>>>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
>>>>>>>> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
>>>>>>>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
>>>>>>>>
>>>>>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>>>>>>
>>>>>>>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>>>>>>>>> We observed the following kmemleak report:
>>>>>>>>> unreferenced object 0xffff000007904500 (size 128):
>>>>>>>>>      comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>>>>>>>>>      hex dump (first 32 bytes):
>>>>>>>>>        00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>>>>>>>>>        60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>>>>>>>>>      backtrace:
>>>>>>>>>        [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>>>>>>>>>        [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>>>>>>>>>        [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>>>>>>>>>        [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>>>>>>>>>        [<00000000c35884da>] optee_open_session+0x128/0x1ec
>>>>>>>>>        [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>>>>>>>>>        [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>>>>>>>>>        [<000000003df18bf1>] optee_probe+0x674/0x6cc
>>>>>>>>>        [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>>>>>>>>>        [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>>>>>>>>>        [<000000002f04c865>] driver_probe_device+0x58/0xc0
>>>>>>>>>        [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>>>>>>>>>        [<00000000c835f0df>] __driver_attach+0x84/0x124
>>>>>>>>>        [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>>>>>>>>>        [<000000001735e8a8>] driver_attach+0x24/0x30
>>>>>>>>>        [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>>>>>>>>>
>>>>>>>>> This is not a memory leak because we pass the share memory pointer to
>>>>>>>>> secure world and would get it from secure world before releasing it.
>>>>>>>>> How about if it's actually a memory leak caused by the secure world?
>>>>>>>>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
>>>>>>>>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
>>>>>>>> Hi sumit,
>>>>>>>>
>>>>>>>> You mean we need to check whether there is a real memleak,
>>>>>>>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
>>>>>>>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
>>>>>>> Yes. AFAICT, optee-os should allocate shared memory to communicate
>>>>>>> with tee-supplicant. So once the communication is done, the underlying
>>>>>>> shared memory should be freed. I can't think of any scenario where
>>>>>>> optee-os should keep hold-off shared memory indefinitely.
>>>>>> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
>>>>>> the config file [1] and the commit which introduced this config [2].
>>>>> Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
>>>>> RPC shared memory remains allocated. I guess that is done primarily
>>>>> for performance reasons.
>>>>>
>>>>> But still it doesn't feel appropriate that we term all RPC shm
>>>>> allocations as not leaking memory as we might miss obvious ones.
>>>>>
>>>>> Xiaolei,
>>>>>
>>>>> Can you once test with CFG_PREALLOC_RPC_CACHE=n while compiling
>>>>> optee-os and see if the observed memory leak disappears or not?
>>>>>
>>>>> -Sumit
>>>> Hi sumit
>>>>
>>>>
>>>> The version I am using has not increased the CFG_PREALLOC_RPC_CACHE
>>>>
>>>> switch, I checked out to the latest version, but because of the need for
>>>>
>>>> additional patches for the imx8 platform, I still have no way to test the
>>>>
>>>> CFG_PREALLOC_RPC_CACHE=n situation
>>>>
>>> Can you just try to backport this [1] patch to your imx8 optee-os tree and test?
>>>
>>> [1] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>> Hi sumit
>>
>> I upgraded optee-os from version 3.2.0 to 3.13.0, and the kernel did not
>> detect this problem.
> Can you check if CFG_TEE_CORE_EMBED_INTERNAL_TESTS is enabled in
> optee-os version 3.13.0? As we would require atleast one RPC prealloc
> SHM invocation from OP-TEE for kmemleak to detect the problem.


Hi

CFG_TEE_CORE_EMBED_INTERNAL_TESTS is enabled
,I can see the "*.o" files compiled from the core/pta/tests directory

thanks
xiaolei


>
> -Sumit
>
>> I have not set CFG_PREALLOC_RPC_CACHE to n. This should be a problem
>> that occurs when compatible
>>
>> with lower versions.
>>
>>
>> thanks
>>
>> xiaolei
>>
>>> -Sumit
>>>
>>>> thanks
>>>>
>>>> xiaolei
>>>>
>>>>>> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
>>>>>> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>>>>>>
>>>>>> --
>>>>>> Jerome
