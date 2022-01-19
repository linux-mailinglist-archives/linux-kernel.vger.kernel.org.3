Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4CB49359A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352100AbiASHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:40:58 -0500
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:39073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352090AbiASHk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:40:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpDDy9W1fqMb+vsDvNif1UDxGICMw02zChb76FtDa2gLWpUPwx6Aay9bGfDhJHRvUui1z6jy214xjlH7weKfgGFQ7Qf3G38KXeWOaDkyKE0zLnIoDtGelPI+YaEBkFPJStmhc41pUdXBP7FtBXvwT3K34W5F0v3RYBFxwj7f4AtP6TNpJPi8ICEn6Pvb+plckCQOuNY66hMy3tjipkRA2nELU7WGVQckCjLae9+4nGwlxj6fzqNgJzK6SRYPafTev3ktp9av6MeoIL12KuChFaVdhxx8F3F6Sr8dL+QQ62gjD23Jb+MB8PYUq93olO6RIbjmpJl5wirYM/TccBX0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=474ZF393MrexCAVXqzAhg7YJ+PpyqcMAjZXTr9SpUpU=;
 b=ZkvVDQ5kr5kf2XxtWNGPOFfMqAxrmj/RMijVJd6mJo0Lc6Rv9tRtBUxsPa4wuMJwM6MpOrzyepLwfS1YUN+G7s1FBtVf9mKPhF3weDu2qCUwCCjxrPKEESyhgpJhSagePKtW0vkqylP2cSS6cZl86rKF3D68e9ChP7ue9yeoPjKPvKTsTb2+eMJ4Se/SfqpESsip3qNXUrNTRxWWKsJBphtD8yz+Cjd84zkODIOl45a2b58Am7r3THjQo04w3LkXr5MpUc7MFpSBrMa3GNWRye+2eSEiMhm2t4/qC2a1culgg3utQY45kXS/ZI0FOOHYy9I6otYhJ4cm5TF87JpqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=474ZF393MrexCAVXqzAhg7YJ+PpyqcMAjZXTr9SpUpU=;
 b=bYoNvVF9xzk9wCujzXLL+yekvM1duesdh2V2L2kXji2Vpdye5Qq2cgNyumJwmcekzdSzLDwTJ12g4hcotW6bapE9TWBzxSxiePIHyJ69wji3lCXu5vPFYODCacYOxe7Cp+ivhCcFT5RIaFjXOJfmRS99bU4Zb62n6sc6ipXedON94CxBHiiJ9oCUmBGiGEVDquZe91Cf1xxGxBtOzRg9hqnCGhUgbUYZcf+PDOmekVDvZHmGxKsKDkWZfiGuTpt+oECM5ztC6TaSdFsgXkjY6y9S+9zHRZbs68rOip+kPupdJQR6BmLLF73UdaCVVpia9LJiVE8J16N3m27Fx7xH0w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Wed, 19 Jan 2022 07:40:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 07:40:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     kernel test robot <lkp@intel.com>, Hannes Reinecke <hare@suse.de>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-fabrics: fix returnvar.cocci warnings
Thread-Topic: [PATCH] nvme-fabrics: fix returnvar.cocci warnings
Thread-Index: AQHYDE1yWYpxv46oiUmIvgxBvu0IPKxp9yqA
Date:   Wed, 19 Jan 2022 07:40:53 +0000
Message-ID: <f489e490-6a10-9c45-eed5-4061cb8c0b7d@nvidia.com>
References: <202201181710.TjfwKXN9-lkp@intel.com>
 <20220118092531.GA25410@95126676e75f>
In-Reply-To: <20220118092531.GA25410@95126676e75f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bccd86b-5020-42f3-76dd-08d9db1f0602
x-ms-traffictypediagnostic: DM5PR12MB1644:EE_
x-microsoft-antispam-prvs: <DM5PR12MB16446B3ECA97551FB3954956A3599@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:269;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLKbypvkssnwIeLHRWwnqEFancJFiV0aqeTlEnOQGZl1iIhjn/LAPXWbq9MYTYTemLvp33bVUJMDFfe29cGZGUjCFYLq+mx81tubgIjMeQwJCQGppY/JsT2G5IsJFDufWn2gKrtfIVm8Po6rQc+Y6/nDN8mRTgwt7iREaZB+1LUxenAOBzDqdwA4bHnvgNOVrV+uD4BVE/uGJWh9XzgvFLgkDXKwNdUvA1zP/EpaKPTbIdPakAmJjXR6PzehGydZ8MGV/LwwOrZwWBGUxA8KsUyJhvL/+N/HAE5vlfvfTKgLQAIObXxTlK3AWzZ2A7AaLnh5uD/ziB9MiKu3MstYBaHePOnM7T1ORPzsx81jR9fbHd1J3QGjp8rlFyJQRJGm3z4LljLvK0yAkVXS4lXb+9fAUuCycb1SVKQ7k8bF6AwuUwqkBdr3TmZD/EsLdICahD2VOOLddFpQqntpBprLmDDWFEg3aIaUrwMBzjclABMGM2R4mAxbuyKVwQETrpoDZCF0hJaO6I8HVlsBfdf9l/HDu7yAe8GPTIkp5YHUQ2CdGcgGobp3oKkoVQdmAWaAxeBi7Gs84Huvhrfs9LBhbOAURVBNzffXG4DaxjEdoafj1vXzj6+se6gTyvyYOl4l0CzP20l5ezRYZMFhdyyXebxTJ04gJxx5rq/D7KC8F55j7GH2kKyjq1gUMpu5bY7K8BjdgRzsmikY5mQjhRj2vaf5c0KMl1ZysRYXHtYGvLjdnabmd2Fis+gpKcLlaacj6JFHyhy3ithYTYPN/WLsXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(64756008)(54906003)(38100700002)(71200400001)(66476007)(2906002)(66556008)(110136005)(66946007)(66446008)(38070700005)(316002)(31686004)(122000001)(2616005)(6512007)(4744005)(508600001)(53546011)(6486002)(4326008)(91956017)(5660300002)(186003)(36756003)(31696002)(6506007)(76116006)(86362001)(8676002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3AzcWdjRUVFc01ObFpjREN3aHdkcUIvcUJqVEp5NjhRejV5MGcxazFVRG9p?=
 =?utf-8?B?SEM4QzR5RDAyck9FSVpMWjBtMEVsNGs1cmQ1M3RwMzJkdDhRcldlSnFhMmVs?=
 =?utf-8?B?anR4U0VXdVhxcXRWWUxxSHcxakR1cHEycmJkdGVMNlNpSGhiZ1VzbkE4V1pB?=
 =?utf-8?B?d0Z3bHE4TmV6THlaSThmV21QK2tyenlUVEtwRmFFVERZek5HRlhXTGJ6aEI1?=
 =?utf-8?B?bWZ2UjQxaktQZ3lQREwzaXlDdHBQNm5ubG9Ubk9CeXU3eFBBOC9uWVpJb29r?=
 =?utf-8?B?V3I0KzQyWEpYSDhzK1JkeU5WdUdOam5JV24vaTBXWWp5UEZ5RTFuWVkzYVFw?=
 =?utf-8?B?Z0dJZ3k1QU9DR0hEVU1ndDlXWE5QZ0lzSmRuNDFYcitSUGpsL1E3R2hheC8y?=
 =?utf-8?B?K2kxQjU4QmZVY0oxSlducFVUUnpROWhudEZOL2pIMUdYcFJmSjV3RFZ3VzdN?=
 =?utf-8?B?S3dyeGQ5blN1NXVZOG9IMFFvZEd6d3A2TTN0M2FYV2J0bForWHJSeWNYcVVn?=
 =?utf-8?B?eVNjb3QyT0ViNDJSWnRJdU85MDdLUVZpVzliQXBMQ0IrZHprdDBPclpPL1ZP?=
 =?utf-8?B?R1NWSlhFZXZWMnFIS0Y1TiszQWxuNnBDVkVRU3RGNjdxcGpFOGZnWVhQaHVN?=
 =?utf-8?B?OXlaZHpOQU9QTlBWYmVRcHFaM0orZWU0Tk42NTUvT2NRKzA5Z1BYaW9yd01T?=
 =?utf-8?B?M2ZqU25Tell3ZmVyRDcwZWV5SmFDSU1EblV2QTdyS0JEUEU2dnlIb2hiMXor?=
 =?utf-8?B?eFVNVzErZUZnQi83WDl0WHV1SXc0cHFwQWg4a0FFY2I0OHNGaWhOV05oRXY2?=
 =?utf-8?B?QktPZ01MWW5taG5SNnB3ZlFnOE56VlVyOHRoWjBDZUlpaUZpKzhwZGRHVGpv?=
 =?utf-8?B?WWlKODJLN1IzUDVQdnFEbXZ3WHVMc015enZvTjA5R1lVN0ovWmtib3A1dGJx?=
 =?utf-8?B?bFA3QkxxOCtORWFjUEVlOWVrK2ZDdUY5ZWRoUUlwL2g4MS9rK0tiYjV3RVR6?=
 =?utf-8?B?TzBVeGY3TnNEK25hUzRSZGhrMjJrbWc1VndRa2lLeHFzZVNrRDg1VlltdWRT?=
 =?utf-8?B?SUtjZEZoZVIvTkFTeUdOYUg3eW9uQVdqczVrY3lxV25rd1p1anlIV1gzdHRF?=
 =?utf-8?B?anRHUGs5blE1OWdDY2wvS0h1K3hNdG91ZlhVK21lRmY5SFZoSXBFZy9PSHFF?=
 =?utf-8?B?Mm9QdklnbkdUZzJUZXdWaEFqT1BXZExyWW5pWGMvZVoyVTBTbFBFTUIvM29Z?=
 =?utf-8?B?WkZrUjF4Y2RVamljVjE3ekVSbW9lU1FTQXZaMGlabjVOQklXaGZPT1U1UGcy?=
 =?utf-8?B?T3BHSmtxcnY3M3hHTjI0eGtEZUZFWlBxWE9RYVdEdDV6a01rdTJzOEJsQ3o5?=
 =?utf-8?B?eEJxSGxqaFRvWW5WalFlb0VVcE1qcml5Nng2bDZ3WjA5aU9BZ0t1ZlpwT3VL?=
 =?utf-8?B?RVVJWVJxS1hyb3lhZFoxdFRGeWN6dUFRcGtUTzRrYm9jWUxyYnFzSWNrUGRk?=
 =?utf-8?B?ak5wditpdlMzejh5SkZjS0V2bzAyeUIrOHZHTXNWU1JiU0xJQmdVZ29MM29o?=
 =?utf-8?B?QUx2YS9sZkx1R1lqeW4rMUhSYW54QXh5S0Z3NWN4c2FhM3h4RGwrZEFBYnlP?=
 =?utf-8?B?M0NXbFZjWU9tQWVPZnhCR3VxdzlFRWVjREY0Q3Fwb0F4WWxUSDRXd0tqUEpM?=
 =?utf-8?B?UXdaZS9URGJobkpzbVE2VkZnRi9xbW41QVVCOHloU0dYcGM0ZEtLTUNnMGVC?=
 =?utf-8?B?cWJFemlVbk14ZXh3TkNVZmVaZlRQSit2OEZReEFhMU14dGxLQXNzR3ZtemxM?=
 =?utf-8?B?VHg4ejNqN1NuYUIvS3NNVXQ5UGZCdkRJSlptU3I1NXdPSGpieGEzT3kzcG1o?=
 =?utf-8?B?cHhVb2ZBYktOU05NaUlVYUlNbGl3SHhOdlZHK0ZLV2RhdkpvM2xMRE5kekl1?=
 =?utf-8?B?RFBjWTN4UXZZUkZGOG83OXkram13cU9QcWl5U2QyWDJ0RnB1ZElIcytEQ3dr?=
 =?utf-8?B?bDJ4WkpMMkxrNHE0WUZ2UFFPcHZIak9mclZ0c2U1Um5SWGtOYWVGY3lvTXFK?=
 =?utf-8?B?b2FHVjc2MkZONXNmbVRJUk5IcFhjUHBTOW1ndXlEcG5leDllaDZsOG1LZnU0?=
 =?utf-8?B?V01UeTFUVTVNcFF2YkNzRVF0OWpiTVowZ3FkM0FqR1B0RXNGZ1gyYmtqSEJD?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A24ED33BF3ECD842B10D67ACF0E6F11F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bccd86b-5020-42f3-76dd-08d9db1f0602
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 07:40:53.9836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7A4bGrSQUm4nahyyI3fSpZKhdu4ochu1U3Ck8thq78tMUg0DvrqHaboE1UfvYFGpFhYOKcPDSrTKQI4aQt5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xOC8yMiAxOjI1IEFNLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToNCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBGcm9tOiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IGRyaXZlcnMv
bnZtZS9ob3N0L2ZhYnJpY3MuYzoxMDk1OjUtODogVW5uZWVkZWQgdmFyaWFibGU6ICJyZXQiLiBS
ZXR1cm4gIjAiIG9uIGxpbmUgMTEwOQ0KPiANCj4gDQo+ICAgUmVtb3ZlIHVubmVlZGVkIHZhcmlh
YmxlIHVzZWQgdG8gc3RvcmUgcmV0dXJuIHZhbHVlLg0KPiANCj4gR2VuZXJhdGVkIGJ5OiBzY3Jp
cHRzL2NvY2NpbmVsbGUvbWlzYy9yZXR1cm52YXIuY29jY2kNCj4gDQo+IEZpeGVzOiBmMThlZTNk
OTg4MTUgKCJudm1lLWZhYnJpY3M6IHByaW50IG91dCB2YWxpZCBhcmd1bWVudHMgd2hlbiByZWFk
aW5nIGZyb20gL2Rldi9udm1lLWZhYnJpY3MiKQ0KPiBDQzogSGFubmVzIFJlaW5lY2tlIDxoYXJl
QHN1c2UuZGU+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+
IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0K
