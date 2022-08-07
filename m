Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCF58BA62
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiHGJP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiHGJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:15:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423C60E3;
        Sun,  7 Aug 2022 02:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUA7j4hE90DaxnMYzk1xKXNjw1+cFK5OSf01hdCoSyU0Eg43O1N071qCKmfPB45Mt3FgpYpgm+oIGoRr0t5WYy9Ci8u/24mwkMXqYUqWQWs32Eoo/WE8GxMey1XQtOSvV9k8kYiH2nKYbmzf8eZCyEtHSuovJwYN0PuslS5aMgqkMfM6B8+uGmyxt42NfMNzvSd5Or0EefoJr9ul3wx514YWXqIzQnob/qLofGmsQjIVSWR+Hj9rDU+mm7iRn4+ug0SVij2lMPecv2d90Neclq8O5tz7fnBl8iffFcBThVfz3f5nrYCkF3XJ7EwnhoXe6RrJZa/HhQCAU276HK91bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LFttgBj0rszNtMAg2Rq++5ALosAEiRV5eOuuSLBeZo=;
 b=MknK80/CuWRhb/sOYNLrdI+N/uPHShD1yQSOKqgMf2nqsBYatlJwbD3wmG6m+yXu1BfWoYaUXQRtYnyk+Vx1g1snEa8+DVvDep5oZygRjEDSRpqx+gc75INggD+ArfNaqixstpiQx+xvAIGYl4ZeW7+bTMNoRGf31LvAnIhFRmqGx6DEQ4Cv+BFOUzNTYpKZ1uqzMfNU15KDKyyWT8uMTFCiIwavfBTuPJ2hnm7d/qL8auk8W+o7Sun53f54mM2xjmTdW4xGqr+aKSx4EJEx0OPp0fKReBZFeKfLhmE8MwsV7MSY1r1tHqcdys2Fuj7V3GTgNJ5xfyedW558vM2Tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LFttgBj0rszNtMAg2Rq++5ALosAEiRV5eOuuSLBeZo=;
 b=Fom0wNiHA2AHxDt5bX92p4yO93Qsor1du1gF2eb4md1QWJIN4RoZkF3T3cBi7mIK2Kl6uY2+3kQNn+TB/CERCM6+Y9m4arUYsQhzI1HwaZzFC+VqWpANXt68+H3cgHmYwyw1CZcspbTQ4HoA7dp5+HbHYOP+6vYfuUvpWx/A3wKLX6Hk60F3olcaGBpgXCiMW0ZOFyaSokMCIzWQW9JcCgoRSZskJrxdQBJF5ddZh8d6Ckp+2hXneHj+uzldQc9HGQq7NBNvQRWLgp9S+uug1iVvpcbtvX1wWszWZYaijtVTaNqmB62LOUZsUsV1rBU/0bQuH5D63RIZMGeAXk99AQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sun, 7 Aug
 2022 09:15:22 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Sun, 7 Aug 2022
 09:15:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-fabrics: Fix a typo in an error message
Thread-Topic: [PATCH] nvme-fabrics: Fix a typo in an error message
Thread-Index: AQHYqdFje9miRyEgPUSCDX21C2V3ua2jKM2A
Date:   Sun, 7 Aug 2022 09:15:22 +0000
Message-ID: <b6e047eb-a9d9-bc1a-05af-faae41f4dd09@nvidia.com>
References: <9cff69b6e880387a420b848b7248dd6e6ad3739a.1659816888.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9cff69b6e880387a420b848b7248dd6e6ad3739a.1659816888.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c45b7e2-ef55-4e1f-f3fa-08da78555b0e
x-ms-traffictypediagnostic: DM4PR12MB5721:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XH6jHTCZXNC6wYdkt5LHfVThPjqFfOhMqjbQn3BIjE5cfRvxRb9u51l2h5P7c6rMk3uYna841c0AivyXU/0wsO/e0goQn6Xe6g6W3DlQfUS7eEzkDQrqjkqfUa68Q4oJDPZehbW6CBMi6EpOUnVoATyZ6lV3Kfkx4EiMK+UfqH8oZekfHUn6aW+BN6Rjf86bU46CB3ku9jKp0JQYZxZWdvppfJhDp0KWzD0OkQoWeyl4ErhR/er3MwWUriS+dbEcpUBDouquw+pmB+clJp5eYVwuHA03rWKZX6xkRqipH7Kc1MbVCjnqqxsVWtA+go2JanOS5nPWkjix+fBd9iEZJgGl4cpKpi2KckmF67dtdL/WtlzhitVoF/xqyzrgp3iB4EPJxu5o15zSq7PNsXo0lz53SwsvgbbiPs+csk3Lp4Ae3IOOkLUtjbGPX9yzRYs8Jzrr6RzEJumKdu2JDHUItE2pJPwZhZq6ZfCJ9lTl7riPSN8QMfGTvsW4ZVem8IB0f0ltfbJmzbAmNeDM5DWYC4cGmHGzzrczTAOncmlXKpdkxMhkg9kzZu9Y3eSUwEVEq433xVUlYKoDSEc2m5uAIjt5m8pedTvOJyMlY3tYUGSfT2lNWkoQJhMDEP4oIIvcd3UjUYWMe8ywb410iOq+VQL1EERh1mmG0KyfIStgQYNbN2YkSMqxQjY5JOuTHKt9TFbW+iPr8o2eKGLtO32irDvescdHWY9HXza0nKCg/1fJjk1xNF3kLGcv4/A6IAzwmcgQb9r2TnvcXzUHRBwdwG4JePixXQ9Ts8Qlk4+AzEBe7f3GjbVWw5Pavg+Dj3V255DvWD95/ojWyLODmSXtMZjCU6lPStz83Q0rMPGn5i7ow7UlcnKYnS49wA3Srxk5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(6916009)(54906003)(316002)(91956017)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(31696002)(36756003)(38070700005)(38100700002)(8936002)(86362001)(71200400001)(5660300002)(6486002)(6512007)(122000001)(478600001)(2906002)(6506007)(4326008)(53546011)(8676002)(31686004)(558084003)(2616005)(41300700001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTRJUWhRY0QxRjZrMzVUQXVlTVZhTFd0bmszMnZGand6OXZWdFMyUTlNTjVD?=
 =?utf-8?B?TEJQMmhrbklPMjJOY2U4Y3RMNjhod3lQMUZpb3ExNU00MzZ2cXZJekorbFpi?=
 =?utf-8?B?NmhrMlN4OE1xY1RzMUFwMSsvQjRMMHN2NEw1U1Rkb2RCSk9RWWpvTXAvNER4?=
 =?utf-8?B?eGt5MTY5NlBqWndhVnE4OXZPM21vTTZEdW82ckdpSUVtb1AxMDhLVG5weHZL?=
 =?utf-8?B?RlMxNXlsMGxMVnpWTGFDZW42UWdsUmVadGNJeUMyV0NmZCs5OGlPTGlqY0RK?=
 =?utf-8?B?MWRrZUcwazRkaDdDL3FSYWpweE90VW9XekttWUtrSjhNQmttaE8xQktDeDRa?=
 =?utf-8?B?dElIc3pCclozSEYrTm5MdjZVWVd0MjVKRFdwSkdnMWFxdjdPeWw5SDY4VG01?=
 =?utf-8?B?eGloNVlENHMxVWt3dDF2TUo5ekZIMkNlVTEyTjE0Z0N5L0grYSs3MGF5N09m?=
 =?utf-8?B?QTJ4dExNUlRKei9FZFE1dHlXUzBqVCtrY1VwRVVZa0txazVtdVhVNFdTY0tR?=
 =?utf-8?B?RXQzV2tha1hnYURUWG5jU1lvRHMrS1p1aXRsSWFFUFR2VnJFdVVra0d4Vlpp?=
 =?utf-8?B?YzBwNzZWd01hdnZaVWVSUFlBUjFQUjJHNmQvSG5pM1EvS3pacTRkbjhOZ0tq?=
 =?utf-8?B?ZERlNVhzaGF0b01iUTQ3QjN5cmFQaHJMRUFiQTNBV2VLN0tmMXVxMEErd1pF?=
 =?utf-8?B?WUlxeDlPZlN2eStrU0FEam9XbXJmOFRzTTVzUkxJR0JsbHkxdnAvaWhqdnNq?=
 =?utf-8?B?aG1LeU9hOGxMN1lIN1E4RWxadk5HZFBJWFVrcVVUeXd2T2JKaElpdHVZRUNV?=
 =?utf-8?B?bXR3akJZWkZ5bk15bk8vVWZSUXp4RkpBdGRPMklIZUU0ZUU1RTB3czNxbWtB?=
 =?utf-8?B?am1wNlBsNnZVOHh0a0JFNjRaL3VFdHFybjdSNWFHMm9ROENIQ1hqQVg2U2dh?=
 =?utf-8?B?TGJxNTBMZlBHVkdwRGFMejN5VXBMU1d2MUNnUWdSMm1rMHlKR09iWmFTbVdo?=
 =?utf-8?B?SW9wVUgzU1NWeVMrdHNvZkFUbThUMU5DT2Y2VFZ3Zkt6cWJib1VjV29raWhr?=
 =?utf-8?B?aG1YM3ZRc2o5VzZqYWZwQ1RnczFZNVk3U0FTbWVVeXA3OFNrNzJBVWVLczhC?=
 =?utf-8?B?UHFCcnZSM0RJMnpWK3RyR2paUFNwWGo5RTZlNXB1cXAxYUxmb2xkMkVham5Q?=
 =?utf-8?B?MDRsOVczMmN2RkxXOFBnV0owQzVQUXU0UXYrZSt6bHBKV0hTZVVqQy9KZUtV?=
 =?utf-8?B?aDRPNmhEdDR6dFhmelpvUkx3T0Z0TDBScGc1NUFQM3JHVzJDVFl1bnl5V2ho?=
 =?utf-8?B?Smw2dERra1Q5aDJHNWtxZndyVlRrM1NkUXg3NTY3cFhmbHpKMllHdllGUXpL?=
 =?utf-8?B?U3R1R3FUR2VReVZoYXJneHJPSWRpNml0MVRFQmJ6MTRZS2JxMlpTUmdwTDRD?=
 =?utf-8?B?RndZT1dka2dzbVI4azZVODJmaVowTVJGTWlKMmhTUWxETVZqV1orYkhDVVgv?=
 =?utf-8?B?QTNRc2VsZzNSck9rdUhzNXhSeXhKNVBkWisyc2JYNmdGTzB4TFRuLzRKbmxQ?=
 =?utf-8?B?b2wwTnQ1M2lreUdzZHAzbld1dmNPOHlNQzR6WTduSDhaaWYxdS8rV3pBamxT?=
 =?utf-8?B?SytGTjQxY1M4WVBNRFk0WkEwcjJvOVIwNytpRllqSWxZU2xvM1hpdE1Cc1dP?=
 =?utf-8?B?ZXJKaVN6ZG5hZ1BDNmpnL3VSZnZ3QlJiN1E3REJ4SVZ1ekFFd0c5NVBnUnpu?=
 =?utf-8?B?TURiejRiYXRQRkFaZjY4Ky9CVmpSYnFWUUVNYUpiZ0lXUHh2TVh1b3JOdysv?=
 =?utf-8?B?a1FJdDl1RU1MTzUvSE5SMFJjZU54ZUxReTRPeGNyS054THEzUWkxMG4xUUp3?=
 =?utf-8?B?S0V5VE5HRWhTY2hxazQ5M0d1YVgrdkpPVTMyS1JQREJSWG9xT2dnaWlya081?=
 =?utf-8?B?L0hYRUs1YVBVM1dpWUlRZVFOOVIzckJ3UlRrbDZrRmdGNXowWDlDQVlZUGhp?=
 =?utf-8?B?Y2owd0lZcGxlNXIzMnNUaGZXa25XODJENXRaKzdiZklDTnlxZDdibXBXbVVG?=
 =?utf-8?B?VGI3c0lSYjh0ZUNpNDJnYTU4NWhCbklOVThvR0JEUjYwWndtQWZBWk1vejNy?=
 =?utf-8?B?UDhEYzg5M1NyL2tFWGl2TXp1QUNHOFRTdFhlM01HeC9OUy9kalRXakcxZUs5?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8A2C5AFA0F4A642B25485562FFCCA5E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c45b7e2-ef55-4e1f-f3fa-08da78555b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2022 09:15:22.1137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SplXSYghYVsCdOSx8EU0Jz/lAkAa/zaWCj8wz0vdUuKYmG5Pmf7d2QAwuySCFpOJ2fC1ICrqXw0Jw4iBCaOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC82LzIyIDEzOjE1LCBDaHJpc3RvcGhlIEpBSUxMRVQgd3JvdGU6DQo+IEEgJ2MnIGlzIG1p
c3NpbmcuDQo+IHMvZmFicmlzL2ZhYnJpY3MvDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rv
cGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiAtLS0NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==
