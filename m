Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328EB562669
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiF3XFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiF3XFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:05:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573553EFE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:05:11 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25UJRHvg005913
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:05:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fCS711RjHubzJMQ7hQCmYSc6ZO/PfmD8iLBXNgRcd8Q=;
 b=mGKyYPYyUQSe9p32i1JjebuuKZUJibX03it8YVeNoijPPziplKQPk9OA08+FN9qe8Aj7
 fYR+7KfIoDTzeszUNyx8NoEEMpOAJYbXlDLtKGMbv2kMSrxQgdL5IXIMjmMsxUVRaDAI
 l5sEyn630DhxMNkAV6ILnjW3oeyR1/btPFo= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h195a5h8w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:05:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c49eBOtX+AfjKSJxjxhfG1OaAERnDSawRE0/BpGrxg8VIjHVumbHNQ6nUf5AXj2UOjcrHwaLOjwGnKo2sbDNubOr5PB1B6KR1ndBegXPOGVSuI+S5Vc3iLioEMNQRLQf0wI+7GRsai6bZnOQPqEzP70SGS4+izbuc4tznr55x92SzfNTAap4ukdlstXte25HV5c9Ys6LAYJJ6axjsnlcCnkHvfZobTwfeB1rhBI9i8EYoN5f8bBZ68TN5V1236irJJg6n/MrcNdQjUTc/tawdJEh4WTcBlnlITOUYg2kjNqHsEksOQULq7Bq/NAi7BpY6iPJ6wM35fa66UcZBpKFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCS711RjHubzJMQ7hQCmYSc6ZO/PfmD8iLBXNgRcd8Q=;
 b=BMhzUAbh5ncEpnjjaojja/TGFWAxpEg45NpvGSalU9MOcuh8MeTP2WkVHJWenXTmNhLTkNe6k04Bgb+esK6Qbtnwjo3NbMGEJ1LJ8JDhDXC5KlecWNgH+v5pL4V006O8cNDu4jDdfEvWxfnAqY4I0okaXsZnVcMe8S5zgoBnn6EQCKHPmfWH7aNYDz/xH/kjzY9uiiLPdqfU9V88DD+sbXiUczWd0P3U2jx9o9SR8EXqFz6zXyHifYNpqhMujoQjYNCtN/6frDS7TL1udo3IXlhw3JsTX4PJknBHAB0eQ9OTm8GLDsokjIk5H5UDny7yjRlXO7HvvaooB2aaKwFSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB2852.namprd15.prod.outlook.com (2603:10b6:408:8d::10)
 by CO1PR15MB5068.namprd15.prod.outlook.com (2603:10b6:303:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 23:05:07 +0000
Received: from BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::e998:a53f:24e7:922d]) by BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::e998:a53f:24e7:922d%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 23:05:07 +0000
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "jack@suse.com" <jack@suse.com>
CC:     "boris@bur.io" <boris@bur.io>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Modeling wait events with Lockdep
Thread-Topic: Modeling wait events with Lockdep
Thread-Index: AQHYjNXXgmWhrw5qwkm+IQi0oSCTcA==
Date:   Thu, 30 Jun 2022 23:05:07 +0000
Message-ID: <4dc41ba5-f9d4-2d26-fdec-881405029046@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da558ba3-b5fa-4e2a-4081-08da5aecf9df
x-ms-traffictypediagnostic: CO1PR15MB5068:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIB4E31uok1p0Hk2EjPNBq0kBgh9tB3u++wHEISDwd67Ckf5Gbab+aH0ru9OS9AjpLwsFSpti1sdGrusyyCdj3eotK8AEXgNLX1l33jKbkZwxhVQpxI11USMg+Lz/m/E6JxUhkBoyT9PQTCA2NAHIXH2oGkUxvJgndL7VjJwc0TSmrbeexEjgVh4dlvj56UhnkyZormghqBGkmmc2ugWzi2Cc+/giNxNoBGdNc1LKZjwDVLNtGBwkxCY7lyAPtdBnKsbOAiTn6KMBVtUSZ7rA/OwaEEHJl5l0so8SM6zkzFetCvrlCRUXtIpFvck9uesEDvEhUwmrcAvCCkji1YMj01R18/YrRfhopUDnLirOj1vU9eRtrkXhRv3vU9QGfGlqybt3QKGlz1nygIMeb9cg9R0WLUWFe695QgCkVFnjII9xNXIAjqV8Ep5BxN0PWuAfaIHkGwVEbUJxV/XTRHZNc1GB/WATyn3P8NYC1eXXQsBfYWfErZo2fNqzaLf/HYE0JmbZOfcB4pBIM5DKZA29CuauWm2G00inik74QdFEo/Qrt2HFKBcjKc5rLmT1L4sZe70vQyIlthKQHXHFLuU9G9SmLqDuhwKaMxzDfYJbPXLMYhUrf9zgHo5fEjipsIKPVOM0A10Cg/99gnsbQVijnMSk52Bp/eM2YlW2xLn/pruD7oGrh1rhrapVf4FSCKsKbBj0ioTt11RaRbKJ+dWtW4hM6K0LWuZMXZMnRuGT8qXrmgQdVBNH94JjJD135xCVsTxhbRn+AiPBry+AQ+qFzdyF4iXOa9rgVqhASUieYF6R1qlFdaAMkY9LUHvW+8sjsXf8HLZkO0A+NijgMojodbeydaKflgT1B3Qcf9/Mccd7QGi92Ve1YZDJtn+Tr0l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2852.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(6506007)(26005)(8936002)(6512007)(5660300002)(122000001)(8676002)(76116006)(64756008)(66476007)(38070700005)(91956017)(66446008)(66946007)(110136005)(66556008)(4326008)(71200400001)(86362001)(966005)(6486002)(316002)(31696002)(54906003)(478600001)(31686004)(186003)(36756003)(83380400001)(2616005)(38100700002)(41300700001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlY0UVVES0NMQ2Voa0VLVXVEZ0pmVWFCc05RSkQ3bGRhZHNSRTFxZGRGV1Nv?=
 =?utf-8?B?a0N2Q2RQZHFBczNBdlhvdDdMOVJKK2NPelNOQWFCQzJKMUp0aWpDa0ViN2F5?=
 =?utf-8?B?dFB2WUZReDBwMENzTGo3MVVNTUUvUmhmaHdLT0ZTYmd4STJlOWxwc2dmRVR2?=
 =?utf-8?B?aEM1S1c5NFZLSERrcnN1eS9XbTBzVVdnZWZqQm5yRlB4SHFlOThvWUI0MnMw?=
 =?utf-8?B?WE1jYzhqUTBWYS9yZE9xUy9rK24wTnR2dzVkZXdaaHA3aDhxOUJRb3lzd09q?=
 =?utf-8?B?cUpYcGFiQjY5dW1IcVRyUGw2c2xES1kxME1PNENybzZpRjFrdXZtZFZWM0s2?=
 =?utf-8?B?enlmck1kcGl2bk9iSHNMQlY0dWdTcllib214Q2VXaWdOV2JOejlVOWVwWkFV?=
 =?utf-8?B?aFVVYWJRZ1ExQ2dNT1JmTmJyWHIwdzF3TytnZ1pydzRVdVhPakpUSEhzWDA0?=
 =?utf-8?B?czFjUjhyYVdWeFUzNkhEdmpGTWF0OERsOFhZbEpNZ2RyNVRHUndVeTZzY08y?=
 =?utf-8?B?THpERU80Q2lNWndXUllUNHNEdkJ3cDlKWHF1YVNYM3plWk0zci9EU2FIL1Yr?=
 =?utf-8?B?V2VnZk1xYnpUSU1QQWJRemFKN0dDYXduSzVoclRXWHBGUTEzY0dSRU5maWpY?=
 =?utf-8?B?d1NKRGQyK2lnbTVOUkZLK1VXNG9pRmVIOW51OVI5WmRUL1lCK3ZmWE9STW8w?=
 =?utf-8?B?L3lHdmlaM2poaEs4QXNZQnBpMDZwWmNuWmtyVklCc2lFOFRkYzNYSzd3OFl2?=
 =?utf-8?B?YmtMV0ZtY0lvb3MxNDluMFF1dWI1MCtBVHNxMjZwc2dmU3dTb3RoL054VVRU?=
 =?utf-8?B?ZU9EWnpPMFBvZDVERnFPWFhCT3laQ3ZQZnpVZUxtM2lNOGNtUnIwbEJ2dWVi?=
 =?utf-8?B?OVFLQjBMUDFkcVdrSjlrSHNWNGk0YUNlcmk1aHVPenZRdW1HWklwRXQ3MXUx?=
 =?utf-8?B?UGFmK09CZkNsZjhla0hnWkpCdUhWNDdMc1FXYy9qMzd6eVhTUlk3WThpVytD?=
 =?utf-8?B?bG1YR21KS2I0VkJhQ2VoaVJwc29DMFlLVXp0TTdFdktLTGlPRkhGeGFLWU5t?=
 =?utf-8?B?ZFUxWjNSbWJjRG41S3A0ZUtNNkVlbElKdFc4bjNkaFJBWTEvOFVaMENwVXNk?=
 =?utf-8?B?bm0wWnU3c0ZISUNpcHJaWGpabzZDV2hXN1NiNGl5VGdLcjN0bXg2RW1tRHda?=
 =?utf-8?B?TDUxZGY3SVlRRmZ4WHRJaDZtWS9iM0l2ZFpOa09QZzhJbWpzOUJhUlJuT3BT?=
 =?utf-8?B?UUdWNE1YdFczNnN6aUd3RjdVSzQ4cXZMZmRBWE5qVzk4Skw0N0kzMVVJUno0?=
 =?utf-8?B?V3ByaUR5Q1NqUkhlbkNJUTdEYTBzbUlrUVBweS9BR1ByUHYwclFkQ25ibFlN?=
 =?utf-8?B?MmZEN2xaUVhtTjdpL0RiSzdlQ2ZuV3RYdjAzd3lDV3ZLZG9oTFdBUWp6anFV?=
 =?utf-8?B?a1FTck1nR09Udm9qaVVVeG9RRVJaYkNrNk15VVBwMmRaRmZFeU10VUE0dkJT?=
 =?utf-8?B?eDJYZk5rdkFLeXgvVGErbm91VmhFM2ZBM1lOaWYwZ3dyNjFYMHNLU1Rhc2tN?=
 =?utf-8?B?b214Z2FsNlo3VmVzQTdGQzNzR2U2cnRMRXVxRDhVNWJ2bVhFRTY5c1pXUnhD?=
 =?utf-8?B?YVhmaWJ0MGJwT1NieGlBSGhZV2F6OTJsNmJENDloa1g0MTBnVHhhVTlKRFB2?=
 =?utf-8?B?TVJSTFVzTVBTZm5Cbk55Um9GQ3EwV2Z5N3pYMlpFWFRSWnFycU9WSjE4bEtO?=
 =?utf-8?B?bHZSc2FzSVo1ZGp1aGtoY0xlVzdlY1ZiQyt5SkV2RlhpOG00R3E3Y2s2dXdQ?=
 =?utf-8?B?TVpxTmFMSGhHSjNwc2swdGY2T0dVKzQvMDY4M3Bhci9ienRVRGxPd2trYmxu?=
 =?utf-8?B?cndSUGI2Q2NYZVI2RjBkYWExNDVEbXpicXBoaTJEOUllL1JhV1NJdWt6aFFQ?=
 =?utf-8?B?WHZXQlZQZlIyVlphcEJCRkFTcnVLRk1BVXBGKzh3OGJpVmVRQ1VtOXV6a2Nv?=
 =?utf-8?B?VlUza3dCNHp0Y3lwK2RualR0T3RnOVBkdU1IZFFFUmVaT0pQancwT3hiSkEr?=
 =?utf-8?B?Q0c2M2p5aXZ4eEtKeTZ5d0dRcm8rSmpSTDg2bloxUDNleEZkcVNVNjZpdXU0?=
 =?utf-8?Q?7oqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9CE09E9A7D9794C9C72ED9077766403@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2852.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da558ba3-b5fa-4e2a-4081-08da5aecf9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 23:05:07.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGfZQELjHCv2M1uvkFW61dpYBkdYhZhPMGraXBhmJlstZOasCI1voAWBeO+KXvES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5068
X-Proofpoint-GUID: _GNFn-chul9U9wHMUc2iaoFl1qeSuHha
X-Proofpoint-ORIG-GUID: _GNFn-chul9U9wHMUc2iaoFl1qeSuHha
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_15,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkkgd291bGQgbGlrZSB0byBhc2sgc29tZSBxdWVzdGlvbnMgcmVnYXJkaW5nIG1v
ZGVsaW5nIHdhaXRpbmcgZm9yIGV2ZW50cyANCihpLmUgdGhlIHdhaXRfZXZlbnQpIGluIExpbnV4
IHVzaW5nIExvY2tkZXAuDQpJIGFtIHRyeWluZyB0byBtb2RlbCB0aGVzZSBldmVudHMgaW4gYnRy
ZnMgc2luY2UgdGhlcmUgYXJlIGRlYWRsb2NrcyANCmRldGVjdGVkIGludm9sdmluZyB3YWl0aW5n
IGZvciBldmVudHMgYW5kIExvY2tkZXAgaXMgbm90IGN1cnJlbnRseSBhYmxlIA0KdG8gYWRkcmVz
cyB0aGVtIChlLmcuLCANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzL2NvdmVy
LjE2NTUxNDcyOTYuZ2l0Lmpvc2VmQHRveGljcGFuZGEuY29tLykuDQoNCkkgYW0gdmVyeSBuZXcg
dG8gTG9ja2RlcCBzbyBJIHdvdWxkIGxpa2UgdG8ga25vdywgd2hhdCB3b3VsZCBiZSB0aGUgDQpj
b3JyZWN0IHdheSBvZiBpbXBsZW1lbnRpbmcgdGhlc2UgbW9kZWxzIHVzaW5nIExvY2tkZXA/DQpJ
IG5vdGljZWQgdGhhdCBKQkQyIHVzZXMgYSByZWFkLXdyaXRlIGxvY2tkZXAgbWFwLiBJdCB0YWtl
cyB0aGUgcmVhZCANCmxvY2tkZXAgbWFwIHdoZW4gaXQgY3JlYXRlcyBhIHRyYW5zYWN0aW9uIGhh
bmRsZSBhbmQgdW5sb2NrcyB0aGUgcmVhZCANCmxvY2tkZXAgbWFwIHdoZW4gaXQgZnJlZXMgdGhl
IGhhbmRsZS4gQWxzbywgZXZlcnkgdGltZSB0aGUgdGhyZWFkIGhhcyB0byANCndhaXQgZm9yIHJl
c291cmNlcyAoZS5nLiwgdHJhbnNhY3Rpb24gY3JlZGl0cykgYW5kIHRoZSBoYW5kbGUgaXMgbm90
IA0Kc3VwcG9zZWQgdG8gYmUgYWxpdmUsIHRoZSB0aHJlYWQgbG9ja3MgYW5kIHVubG9ja3MgaW1t
ZWRpYXRlbHkgdGhlIHdyaXRlIA0KbG9ja2RlcCBtYXAgYmVmb3JlIHRoZSB3YWl0aW5nIGV2ZW50
IChtYXliZSBJIHVuZGVyc3Rvb2Qgc29tZXRoaW5nIHdyb25nIA0KaGVyZT8pLiBJcyB0aGlzIHRo
ZSBvbmx5IExvY2tkZXAgbW9kZWwgdGhhdCBjYW4gYmUgdXNlZCBmb3IgdGhlc2UgDQp3YWl0aW5n
IGV2ZW50cz8NCg0KRm9yIHlvdXIgcmVmZXJlbmNlLCBoZXJlIGFyZSAyIGV4YW1wbGVzIHRoYXQg
d2UgYXJlIHRyeWluZyB0byBhbm5vdGF0ZSANCndpdGggTG9ja2RlcCBhbmQgd2Ugd291bGQgbGlr
ZSB0byBrbm93IGlmIHdlIGFyZSBvbiB0aGUgY29ycmVjdCB0cmFjay4NCg0KSW4gdGhlIGZpcnN0
IGV4YW1wbGUgaXQgbWFrZXMgc2Vuc2UgdG8gdXNlIHRoZSBKQkQyIG1vZGVsLCBob3dldmVyIHdl
IA0KYXJlIG5vdCBzdXJlIGhvdyB0byBhcHBseSB0aGUgbW9kZWwgaW4gdGhlIHNlY29uZCBjYXNl
LiBUaGUgY29tbWVudHMgDQppbmRpY2F0ZSBvdXIgY29uY2VybnMuDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KU2ltcGxlIENhc2U6DQoNClRBDQpyd3NlbV9hY3F1aXJlX3JlYWQo
bG9ja2RlcF9tYXApOw0KY29uZD1mYWxzZQ0KZG9fd29yaygpDQpjb25kPXRydWUNCnJ3c2VtX3Jl
bGVhc2VfcmVhZChsb2NrZGVwX21hcCk7DQpzaWduYWwodykNCg0KVEINCnJ3c2VtX2FjcXVpcmUo
bG9ja2RlcF9tYXApOw0KcnN3ZW1fcmVsZWFzZShsb2NrZGVwX21hcCk7DQp3YWl0X2V2ZW50KHcs
IGNvbmQ9PXRydWUpDQoNCkFkdmFuY2VkIENhc2U6DQoNClRBDQpyd3NlbV9hY3F1aXJlX3JlYWQo
bG9ja2RlcF9tYXApDQpjb25kPWZhbHNlDQovLyBleGl0cyB3aGlsZSBob2xkaW5nIHRoZSBsb2Nr
DQoNClRCDQpjb25kPXRydWUNCnJ3c2VtX3JlbGVhc2VfcmVhZChsb2NrZGVwX21hcCkgLy8gV2Ug
ZG8gbm90IGtub3cgdGhhdCB3ZSBob2xkIHRoZSBsb2NrDQpzaWduYWwodykNCg0KVEMNCnJ3c2Vt
X2FjcXVpcmUobG9ja2RlcF9tYXApOw0KcnN3ZW1fcmVsZWFzZShsb2NrZGVwX21hcCk7DQp3YWl0
X2V2ZW50KHcsIGNvbmQ9PXRydWUpDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
DQpJIGFtIGF3YXJlIHRoYXQgREVQVCAoRGVwZW5kZW5jeSBUcmFja2VyKSB3aGljaCB0YXJnZXRz
IHdhaXRpbmcgZm9yIA0KZXZlbnRzIGluIExpbnV4IGlzIHVuZGVyIGRldmVsb3BtZW50Lg0KSG93
ZXZlciwgSSBuZWVkIHRvIGltcGxlbWVudCB0aGVzZSBMb2NrZGVwIG1vZGVscyB0byBhaWQgdGhl
IGJ0cmZzIA0KZGV2ZWxvcGVycyB0byBjYXRjaCBleGlzdGluZyBkZWFkbG9ja3MgdW50aWwgREVQ
VCBpcyBtYXR1cmUgZW5vdWdoIHRvIGJlIA0KdXNlZC4NCg0KVGhhbmtzLA0KSW9hbm5pcw0K
