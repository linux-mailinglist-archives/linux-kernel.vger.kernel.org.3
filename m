Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F10523A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiEKQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiEKQom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:44:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D6062BEC;
        Wed, 11 May 2022 09:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/iYryfCQZobEiLtL5gaW/+RN0YbXVlCkUpZP7ImeXfJ+mNuCSamS5i1xbqB5GBPQoJKNxSLcpY1+W6Tkt6ZPa5SmzzC3c5OSIV4+4EUR/FKfuKJ2Hxk7z0TZsBMT9k1DmCZ0/VbAM0m9lyZpBLIm5kTBXf0HKnETTy2/mQGGq+aXEPYr1aHqTmA39a+kuN592O5rKD41s1Dfoi/Ihu7nPLj36DU/tCwpdz0uQxEkwiWRpXyZdCn6qA98xpJE1loKknSf19c9jhZaitv2FffeSlzASz+lAIU50K27MNE7/PUnygfWl38KGpRPWyZ5olzWmqw+bCV+WKptuPGwWIHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRUUG3mYO/3FbKb2+mLaz0l2TPCw8MCB7tPkWXl7yfQ=;
 b=WdWvEqmO2u1m6JrUmAu4vaASX1s1ukz+5OMCEBcO1iJyoenwklof6G/jItXPwWxCqwI6e/hHF0Ps8D4eKobk1LL9q7KuuR7+Ypdqrd8Ew1kiZT+5A7CGWFMX5KRLBDIT88iEtiyxwd39kxXsYyZnHwqyu5J43QqTL60fXB4SLAxXxp/JN9vQRL1ptpFZS/foKs0NRWdJSFNYmyDy6ZUCkeV+qzUpM2AQGxER6pEqa8xzJ87Oj3fBI2AxAsnuGImkwgbI+eW1A9oAetEqqI3bw2DzkkJTsUu+E+2aNbdGPwQSGpenys3JaibazRRV+DILCasSmGJIhpTgtdBIPZ8D6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRUUG3mYO/3FbKb2+mLaz0l2TPCw8MCB7tPkWXl7yfQ=;
 b=TTEvS0RqF6zNa3l8YVapc9zKoTWnMyVdMtaElDcQzjKNatA/L0iP/qPFuRjk/iwHbccUz76E2wrg+abKmLpKmIu4SmSGQ4h1yTcMcxwg55SNIeeWlb5VUpdBQ7aHxcPbrD+r3qyhc3nb3BJaj6PYTWpUMFgjvyYKdlDImXCT6dxPJxmaSRrtnFE2HWcaLHPC4xBZJDIZGQ+0fG0BL4H3mGD+49uXApxvQWyPyibGl3rzJTKWkomFEQU33tptozGbtrXuSS19VdcgJ83/FxRUoGR6D7hCHOWNjruWNL0lZ2eIcsFE9KuBg4S/REUV23QgjEP0xjvfEMlxPqEbEPuskw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 16:44:38 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c%7]) with mapi id 15.20.5227.021; Wed, 11 May 2022
 16:44:38 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: RE: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHYYzu4AtKVUSpJ7k+AnLFkxMXOCq0WR+MAgAAJZ4CAAaSUAIAAAZKAgAFo4YCAAHu4EA==
Date:   Wed, 11 May 2022 16:44:38 +0000
Message-ID: <SJ0PR12MB56760A681243DE07AB7BD73CA0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
 <20220510110742.ievkihggndpms3fn@bogus>
 <20220510111318.GD27557@willie-the-truck>
 <6fcc2358-b029-fa01-cf06-aa040f53cf83@arm.com>
In-Reply-To: <6fcc2358-b029-fa01-cf06-aa040f53cf83@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61ea60d2-6be0-4c2a-8ebe-08da336d89f8
x-ms-traffictypediagnostic: MN2PR12MB3934:EE_
x-microsoft-antispam-prvs: <MN2PR12MB39348C50096850F6C8267730A0C89@MN2PR12MB3934.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9UhlEK8qalGigfr9UhYjG0roIi6jY4C9BGWlLqVZfDhtNjef3spF9LHsrKBNncBm1Cb6YXgvW6FfCzBn9JGxGQgGJUrqHIDCpY7e1Tfxf/eSYeJApf8SYqqpF7uuGhxrHRyw1fa/AmVEToTC3GPrWMPwUrfbGs/BmRCk3BSMhJB2uO4VCS3LDjsSisnA+zwLjXkVrMN8MLTq+0yZLpIU6kDDYHwNV12t+QXTcNtCdLBQ1BrkiShh4VjofwKn4qVV9lkR5m7fMAqx8sFc2rsECv5JVTXCaMS5hwoVU8smcXtdfinFGwhRXII35LdC9vspFYznVV3kMG9voAioN4zYu/QeglA3ZbF6B4Pi0H++Col/7cwMw5HwiXGx4BDWslBsocCsrgy6URtKvU83ALGBa57O8S1RKVGHdx5fasLzR28fhjmeV7Mbjvs5qFCS3rlOfKFC1SXHj0qPOcQ6X/TXe7qedLQkpbd9xlIWucAgEiqp11ACwGy4x2MHPAg6OeC0ftFLftNqG0Zm+SMTJsjADLmdmn73tBOAW8eHVR0P5hbl8rHEUzQkLWY0zB8tlcjVKSUpgh0kZ09SSVz5w2RFN6RZI6XUgBQ3IW2JJ2lVQFv4JUDc7dTgg6/UYRGldkH+zJxzl0vt+l+2JLabx38Y75xtlGJkmbPKSweVULEmPXihhDDN/j3b4RsFZCh0QVgGEtCe7xNJP44N9IjNlg0eA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(8936002)(5660300002)(508600001)(38100700002)(33656002)(83380400001)(7416002)(71200400001)(6506007)(86362001)(53546011)(9686003)(26005)(2906002)(186003)(55016003)(7696005)(316002)(122000001)(110136005)(54906003)(64756008)(66476007)(4326008)(38070700005)(66556008)(76116006)(66946007)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3QxV0l2Z0FSbEEwdTlzbHJodVZyUnlablJ5dmkxc3E3SWNYTUtkdHdDdEp6?=
 =?utf-8?B?TU5FMFBDYkVGbHpkSmd5Z09DRWtTN0dXakl0SHd4LzlNUDRWeDdIRUlwSUZo?=
 =?utf-8?B?aUZhb0VWVFZvK2xtNHhUNkNMNEtERzdOOTNNTEQrZGhDQXlXSlJGZkNpY1hk?=
 =?utf-8?B?b0xGOTBRajlyWmlLdEdqVDl5ZWhPZ01XUHp0R1pJRk0wOGd5K003MVFVTzd4?=
 =?utf-8?B?bndQNzlzWVI0b014NzJIMkRYZUJXeGhEL3dwQXNmWDIwSUdsVXh4Nyt0d0tv?=
 =?utf-8?B?WXNjcEp3UXpYVkVObExVN1BTbHZFcTZ6WC9ETjk2OC84emVZY1Z4V1Y1WWsr?=
 =?utf-8?B?aWIwZkRVU3RIbGtsRE9aS3Rnb0RtZk1YN1dNRkRvUzFOaWlmdmJFNDlkRCtk?=
 =?utf-8?B?bUhzOW5uSGc3QUVOWEFTa1J4MW1JNFluaDkyei9mT1FreHQ3UU1URzFIc2ZD?=
 =?utf-8?B?VGMyU05RN1Y3RzJHaUpKRE5kSTlkeGpXRmtMQXJVUVg5ZUZZQVUzdGlndUFk?=
 =?utf-8?B?TXJBK3RveW9xV0s5WHQ5YnpNSWhpR1MrbU8ydkJSOXRyS2pVL3hSRS85WlJ0?=
 =?utf-8?B?TklJd2ZKQUE1Rk9oUXk5aUxmUDJOR3dEQWhoOWUvMkU4ODRyVFVyK3g3ZnRH?=
 =?utf-8?B?c29QK1lETEE3blUrZlRNR2lGb0VFVnl5TENiNy9QK1BnSjNoSE5tMmd2TDhJ?=
 =?utf-8?B?SXNkSHkrU1BUZWc1OEdPOWIzTW9SUTNsTjNRYjduN2VjSTc5YXJ5Nis5U0l3?=
 =?utf-8?B?SHEvT0o0SHJHQ2dpMTcvcHN0YUIwMFd1bjN6TUxtWWUvbXFDdTZPVExBc2NG?=
 =?utf-8?B?VWgrUFQ2TE9nbXRZUnlsOHY3a2ZFVGZ2T0JkWFZUczRKRDJhRFRxSUtRcE53?=
 =?utf-8?B?bG5JU3oxTWk2UCtDcmZ5eU1QYlpySUJyQVBSTXd6VzJkUEtzMnJvd0VrRlFQ?=
 =?utf-8?B?aUNGcVRueG1sRlErUGZZQjhqWTN0YkxVcEdnaldneXQ5Sk5HbDVIWTR6UEZk?=
 =?utf-8?B?NG52eFNsZU9OakJ0NHFQN3A1NWRkbVRYbXBvT3ZhTG0rMk4zWmVOdkZNaVhP?=
 =?utf-8?B?YVNKT2hSZ2dyWngvYkpvb3NrQUwvb2FqL3NmYi9oNVdnelRWYVhhaHkzd2l3?=
 =?utf-8?B?SnlUVC9nUDV6N1pBbTlDcnRrL05Mb1VXeWhYSFpua01HZE9Tb05YUi9PWXZz?=
 =?utf-8?B?K1FyNG56R1dlYWJ4Ujc1MGlLYWp1QzIwdDhBd0ZqQTdjZnphanJoZ2J4cmlE?=
 =?utf-8?B?UWpiaVZsRjlFcFhQMHdCaFNxaWlFdVkydmYvV0JGUHVyVitXcjc4cVBEL3Ey?=
 =?utf-8?B?S2kyTnlPalExSVh2ckczY1lXQ3Y2MjhacUxKajk5VmlUS0hKVUlOTE4rSFNt?=
 =?utf-8?B?SXhJaEdOQmJhYkNIQ1JtQ2dDTW9ZRUNZelJrd1RHaE9BSURuUFIrWjZtYWQ5?=
 =?utf-8?B?ZFV6RG9SZkNGaUdodWpIUFpTRmpnb01tNXFnZXVpSU1DbC9aOThZeEZkWktY?=
 =?utf-8?B?OXB2MElTc2V4R0szL2pRZXdaZnhhUk5HQW9xd3ZtYUUzQS9zekIyRHFsTnpk?=
 =?utf-8?B?RG5QakovQm9JOGZNZkRsSmNmbzFzWHpJMmY4cmNrVkZLTjlyVmZ2RmRvWnlE?=
 =?utf-8?B?b2d6SGpMR3FmQUVzaURwV2tqajcyZWdWVVRrYzVzNXlyNUhHbkloM1grbzBl?=
 =?utf-8?B?cVozWXFnOFNxcVJ2b1pRMVAzT2tCSTN3cVFSUmN3L2lXN2ZJMktuYnFDanli?=
 =?utf-8?B?RXlTUmRUVUxubzNFTlZUOE1BZDJ0TnJac2ZuOXpsMnhsWXdZNzhXSG5OVk01?=
 =?utf-8?B?d2RSY2hqWjByNTdHYi90bC9QaHNEOG1HeGxoTzZlMTNUaFdSR295WlN1TVg3?=
 =?utf-8?B?Qk1lNEZKZmFud0FiYmlsak5pMjB2ajBoMTZJcXhlT2JhNXBGcjNNd3RnNFgr?=
 =?utf-8?B?U2hMSHMwY2JkNWEvbmZjMGNDZjN6dHp3Vk1Pbkk1RFBEYzlmV3BsMGNjNmdk?=
 =?utf-8?B?aXcwdXhXSVpHd1hDTDZuY0ptM0QrYW9uVlBFSllKNmZ1a3dBaXhIcHpqMWVk?=
 =?utf-8?B?dWllMHp5QnVDS3dWM3dLdkgwVG5HWGJEdk5XN3NjWElmM0w5VWtpYlU0cXBY?=
 =?utf-8?B?THlNQTFJMlZTendLNmxKdHBJVE1ya0ZsUXlDQS8rNGlBMmVlVGNQR0Z2aFRU?=
 =?utf-8?B?ZElDNnQvNUpiRE9Xc3ZUWGNXOXdHc2N4OXROdEk4L0RYQUNrYVExbG9xQWNs?=
 =?utf-8?B?Y3FrbVBRNVYrMU95Y09mK2o1VWZ2c2ZKTEJ3SDl4eVVqNmpVTWExNmJkL1BV?=
 =?utf-8?B?ODBKNkhhamZJWUFoZGl2VlhtTFNVRUhzZkQwdGxkUUtHTlZCMDMxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ea60d2-6be0-4c2a-8ebe-08da336d89f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 16:44:38.5097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3klnz1fLO3HHUAMXV/HtuJIRlQbcYtZ8KNtAkaeMWw8dQpMPDOEUP2IDqpbS4cD3THOzkGK8pHlThMMhUElx3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3V6dWtpIEsgUG91bG9z
ZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTEsIDIw
MjIgMzo0NSBBTQ0KPiBUbzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IFN1ZGVlcCBI
b2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQo+IENjOiBCZXNhciBXaWNha3Nvbm8gPGJ3aWNh
a3Nvbm9AbnZpZGlhLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnOw0K
PiB0aGFudS5yYW5nYXJhamFuQGFybS5jb207IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbTsgVGhp
ZXJyeSBSZWRpbmcNCj4gPHRyZWRpbmdAbnZpZGlhLmNvbT47IEpvbmF0aGFuIEh1bnRlciA8am9u
YXRoYW5oQG52aWRpYS5jb20+OyBWaWtyYW0NCj4gU2V0aGkgPHZzZXRoaUBudmlkaWEuY29tPjsg
TWF0aGlldSBQb2lyaWVyIDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwLzJdIHBlcmY6IEFSTSBDb3JlU2lnaHQgUE1VIHN1cHBvcnQNCj4gDQo+IEV4
dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
IA0KPiANCj4gT24gMTAvMDUvMjAyMiAxMjoxMywgV2lsbCBEZWFjb24gd3JvdGU6DQo+ID4gT24g
VHVlLCBNYXkgMTAsIDIwMjIgYXQgMTI6MDc6NDJQTSArMDEwMCwgU3VkZWVwIEhvbGxhIHdyb3Rl
Og0KPiA+PiBPbiBNb24sIE1heSAwOSwgMjAyMiBhdCAxMTowMjoyM0FNICswMTAwLCBTdXp1a2kg
SyBQb3Vsb3NlIHdyb3RlOg0KPiA+Pj4gQ2M6IE1pa2UgV2lsbGlhbXMsIE1hdGhpZXUgUG9pcmll
cg0KPiA+Pj4gT24gMDkvMDUvMjAyMiAxMDoyOCwgV2lsbCBEZWFjb24gd3JvdGU6DQo+ID4+Pj4g
T24gU3VuLCBNYXkgMDgsIDIwMjIgYXQgMDc6Mjg6MDhQTSAtMDUwMCwgQmVzYXIgV2ljYWtzb25v
IHdyb3RlOg0KPiA+Pj4+PiAgICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAg
ICAgICAgICAgfCAgICAxICsNCj4gPj4+Pj4gICAgZHJpdmVycy9wZXJmL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgMiArDQo+ID4+Pj4+ICAgIGRyaXZlcnMvcGVyZi9NYWtl
ZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+Pj4+PiAgICBkcml2ZXJz
L3BlcmYvY29yZXNpZ2h0X3BtdS9LY29uZmlnICAgICAgICAgICAgfCAgIDEwICsNCj4gPj4+Pj4g
ICAgZHJpdmVycy9wZXJmL2NvcmVzaWdodF9wbXUvTWFrZWZpbGUgICAgICAgICAgIHwgICAgNyAr
DQo+ID4+Pj4+ICAgIC4uLi9wZXJmL2NvcmVzaWdodF9wbXUvYXJtX2NvcmVzaWdodF9wbXUuYyAg
ICB8IDEzMTcNCj4gKysrKysrKysrKysrKysrKysNCj4gPj4+Pj4gICAgLi4uL3BlcmYvY29yZXNp
Z2h0X3BtdS9hcm1fY29yZXNpZ2h0X3BtdS5oICAgIHwgIDE0NyArKw0KPiA+Pj4+PiAgICAuLi4v
Y29yZXNpZ2h0X3BtdS9hcm1fY29yZXNpZ2h0X3BtdV9udmlkaWEuYyAgfCAgMzAwICsrKysNCj4g
Pj4+Pj4gICAgLi4uL2NvcmVzaWdodF9wbXUvYXJtX2NvcmVzaWdodF9wbXVfbnZpZGlhLmggIHwg
ICAxNyArDQo+ID4+Pj4+ICAgIDkgZmlsZXMgY2hhbmdlZCwgMTgwMiBpbnNlcnRpb25zKCspDQo+
ID4+Pj4NCj4gPj4+PiBIb3cgZG9lcyB0aGlzIGludGVyYWN0IHdpdGggYWxsIHRoZSBzdHVmZiB3
ZSBoYXZlIHVuZGVyDQo+ID4+Pj4gZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0Lz8NCj4gPj4+
DQo+ID4+PiBBYnNvbHV0ZWx5IHplcm8sIGV4Y2VwdCBmb3IgdGhlIG5hbWUuIFRoZSBzdGFuZGFy
ZA0KPiA+Pj4gaXMgbmFtZWQgIkNvcmVTaWdodCBQTVUiIHdoaWNoIGlzIGEgYml0IHVuZm9ydHVu
YXRlLA0KPiA+Pj4gZ2l2ZW4gdGhlIG9ubHkgbGluaywgQUZBSVUsIHdpdGggdGhlICJDb3JlU2ln
aHQiIGFyY2hpdGVjdHVyZQ0KPiA+Pj4gaXMgdGhlIExvY2sgQWNjZXNzIFJlZ2lzdGVyKExBUiku
IEZvciByZWZlcmVuY2UsIHRoZQ0KPiA+Pj4gZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0LyBp
cyBwdXJlbHkgIkNvcmVTaWdodCIgc2VsZi1ob3N0ZWQNCj4gPj4+IHRyYWNpbmcgYW5kIHRoZSBQ
TVUgaXMgY2FsbGVkICJjc19ldG0iIChleHBhbmRzIHRvIGNvcmVzaWdodCBldG0pLg0KPiA+Pj4g
T3RoZXJ3aXNlIHRoZSBzdGFuZGFyZCBkb2Vzbid0IGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0aCB3
aGF0DQo+ID4+PiBleGlzdHMgYWxyZWFkeSBpbiB0aGUga2VybmVsLg0KPiA+DQo+ID4gVGhhdCdz
Li4uIGEgcG9vciBuYW1pbmcgY2hvaWNlISBCdXQgZ29vZCwgaWYgaXQncyBlbnRpcmVseSBzZXBh
cmF0ZSB0aGVuIEkNCj4gPiBkb24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0IHRoYXQuIEp1c3Qgd2Fu
dGVkIHRvIG1ha2Ugc3VyZSB3ZSdyZSBub3QgZ29pbmcNCj4gdG8NCj4gPiBnZXQgdGFuZ2xlZCB1
cCBpbiB0aGluZ3MgbGlrZSBST00gdGFibGVzIGFuZCBDb3Jlc2lnaHQgcG93ZXIgZG9tYWlucyBm
b3INCj4gPiB0aGVzZSB0aGluZ3MuDQo+ID4NCj4gPj4+IE9uZSBwb3RlbnRpYWwgcmVjb21tZW5k
YXRpb24gZm9yIHRoZSBuYW1lIGlzLCAiQXJtIFBNVSIgIChUaGUgQUNQSQ0KPiB0YWJsZSBpcw0K
PiA+Pj4gbmFtZWQgQXJtIFBNVSBUYWJsZSkuIEJ1dCB0aGVuIHRoYXQgY291bGQgYmUgY2xhc2hp
bmcgd2l0aCB0aGUNCj4gYXJtdjhfcG11DQo+ID4+PiA6LSguDQo+ID4+Pg0KPiA+Pj4gU29tZSBv
ZiB0aGUgb3RoZXIgb3B0aW9ucyBhcmUgOg0KPiA+Pj4NCj4gPj4+ICJBcm0gR2VuZXJpYyBQTVUi
DQo+ID4+PiAiQXJtIFVuY29yZSBQTVUiDQo+ID4+DQo+ID4+IEkgd2Fzbid0IHN1cmUgb24gdGhp
cyBpZiB0aGVyZSBpcyBhbnkgcmVzdHJpY3Rpb24gb24gdXNhZ2Ugb2YgdGhpcyBvbiBBcm0NCj4g
Pj4gYW5kIGhlbmNlIGRpZG4ndCBtYWtlIHRoZSBzdWdnZXN0aW9uLiBCdXQgaWYgYWxsb3dlZCwg
dGhpcyB3b3VsZCBiZSBteQ0KPiA+PiBjaG9pY2UgdG9vLg0KPiA+DQo+ID4gV2UnZCB0YWtlbiB0
byBjYWxsaW5nIHRoZW0gIlN5c3RlbSIgUE1VUyBpbiB0aGUgcGFzdCwgc28gbWF5YmUganVzdCBz
dGljaw0KPiA+IHdpdGggdGhhdD8gSSB0aGluayAiVW5jb3JlIiBpcyBJbnRlbCB0ZXJtaW5vbG9n
eSBzbyBpdCdzIHByb2JhYmx5IGJlc3QgdG8NCj4gDQo+IEkgdGhvdWdodCBhYm91dCB0aGF0LCBi
dXQgdGhlcmUgYXJlIHNvbWUgSVBzIG5hbWVkICJTeXN0ZW0gUHJvZmlsZXJzIg0KPiAoZS5nLiwg
b24gSnVubyBib2FyZCkgd2hpY2ggY291bGQgYmUgZWFzaWx5IGNvbmZ1c2VkLiBCdXQgSSBob3Bl
IHRoZWlyDQo+IHBvcHVsYXRpb24gaW4gdGhlIG5hbWUgc3BhY2UgaXMgbXVjaCBsZXNzLiBTbywg
SSBhbSBoYXBweSB3aXRoIHRoYXQNCj4gY2hvaWNlLiBUaGUgb25seSBvdGhlciBjb25jZXJuIGlz
LCBpdCBkb2Vzbid0IGluZGljYXRlIGl0IHN1cHBvcnRzIFBNVXMNCj4gdGhhdCBhcmUgY29tcGxp
YW50IHRvIGEgZ2l2ZW4gQXJtIFN0YW5kYXJkLiBpLmUuLCBwZW9wbGUgY291bGQgdGhpbmsgb2YN
Cj4gdGhpcyBhcyBhICJzaW5nbGUgdHlwZSIgb2YgUE1VLg0KPiBTbywgSSBhbSB3b25kZXJpbmcg
aWYgc29tZXRoaW5nIGxpa2UgIkFybSBTdGFuZGFyZCBQTVUiIG1ha2VzIGFueSBzZW5zZSA/DQo+
IA0KPiBBbHNvLCBJIGhvcGUgdGhlIGRyaXZlcnMgd291bGQgY2hvb3NlIGEgbmFtZSBpbmRpY2F0
aW5nIHRoZSAidHlwZSIgIC0NCj4gPHZlbmRvcj5fPHR5cGU+X3BtdSAoZS5nLiwgbnZpZGlhX3Bj
aWVfcG11LCBhcm1fc21tdXYzX3BtdSBldGMpDQo+IHdoaWxlDQo+IHJlZ2lzdGVyaW5nIHRoZWly
IFBNVS4gVGhhdCB3YXkgaXQgaXMgY2xlYXJlciBmb3IgdGhlIFBNVSB3aGlsZSB0aGUNCj4gYmFz
ZSBkZXZpY2UgY291bGQgYmUgYXJtX3N5c3RlbV9wbXVfMCBldGMuDQoNCkZyb20gdGhlIG90aGVy
IFBNVSBkcml2ZXJzLCB0aGUgcmVnaXN0ZXJlZCBuYW1lIG1heSBoYXZlIGFkZGl0aW9uYWwgcHJv
cGVydGllcw0Kc3BlY2lmaWMgdG8gdGhlIGltcGxlbWVudGF0aW9uLCBlLmcuIHNvY2tldCwgY2x1
c3RlciBpZCwgaW5zdGFuY2UgbnVtYmVyLCBtZW1vcnkNCmFkZHJlc3MsIGNhY2hlIGxldmVsLiBT
aW5jZSB0aGlzIGlzIGEgc2hhcmVkIGRyaXZlciwgbXkgaW5pdGlhbCB0aG91Z2h0IGlzIHRvIHJl
Z2lzdGVyDQphIGRlZmF1bHQgYXJtX2NvcmVzaWdodF9wbXU8QVBNVCBub2RlIGlkPiBuYW1pbmcg
Zm9ybWF0IGZvciBjb25zaXN0ZW5jeSBhbmQNCiJpZGVudGlmaWVyIiBzeXNmcyBub2RlIHRvIGRp
c3Rpbmd1aXNoIHRoZSBQTVVzLiBJZiBhbiBpbXBsZW1lbnRhdGlvbiBuZWVkcyB0bw0KZXhwb3Nl
IG1vcmUgZGV0YWlscyBhYm91dCB0aGUgUE1VLCBpdCBjYW4gYmUgY29tbXVuaWNhdGVkIHZpYSBh
ZGRpdGlvbmFsDQpzeXNmcyBhdHRyaWJ1dGVzLg0KDQpSZWdhcmRzLA0KQmVzYXINCg==
