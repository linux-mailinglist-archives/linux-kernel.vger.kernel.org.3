Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4A50F0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbiDZGXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245061AbiDZGXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:23:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E1FA432;
        Mon, 25 Apr 2022 23:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V27yDkLUD/0qiqufsgYswpOwBb42bCEFcJlgPd3Sl2Xy3QpEU9WFD9wj6XKez+dMjHl+8yVQArZFkfjsQ/TLvoNCXY3UDOmJQ5O0fP6v/DLPX3dRmRBG6e68xA/KrmMM7vowoy0dGlCu3cPhqB64PzBRC/zoOWdSlwvVcJKPW0ppMz10lT9vL8lqOS361q4qS/t+3d9zUCuCC7nsHJjXZ+hInOhCDBgR+b5Kcdf1quby61l5bok23bMi3hBbPPIcsUNbYcB+M7g7Whbf/inic6yQHhJskORTErpX1Ysaq5b/JFBX2zpJyiXYerIZIJXQLGTze0cA623h4+3wWiQ+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6GvL43A/cMO4/OqFEJ/GXhg01b37CuZIDgh3vbCZKQ=;
 b=YqR1Yw4FRDUYixiBPzXFKfCghVMZMyEVDiuNYhkKM9NhhWSGQEOqmp9l3/rxqV9ji4inSZWnH0YjrTtISC4lOMcEbwpfCjpXe972w54JjZH8qtKhhsIu3GW8TGzB5giaUs3n69ySInjifswfUfFkt1rt2LjtU59PZqySwBncdso2DwCCazdQ6876e8VCQ9ssTXFflgXhsWX+rjGjyFtMHFO+s7xy0t2fznQbh54Dgaa4Kggpc44/TFABlKjIWuq4HKxNBG5ePRLSZCVHLXW7OgecPkPe6hzFdffGmoAal5v1GY+em1/OOx0wxFtao3KD8Er54ajUhJPvUCJStCFJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6GvL43A/cMO4/OqFEJ/GXhg01b37CuZIDgh3vbCZKQ=;
 b=qoRAMUypfSbo7MPBDGFmBc+515I9gtAwmto3n9pTNT8xOHUAIJY6GSPwu+S7MsjUcFxYSqvW7sXMP4zNioG4mTM1MKp0xWMxayAyfvY9BWg2AvccbXTdNnSG4OLcL7ZN5MQ6inVwai9RXrPMKAoJs4gSNrFEEDeppBuxGouj3etuo136zJzSf/FnyPl48rh7ea71l3OaNxhyzPE1FEXOMg6uYxNoj44wQG0C+Ljcn/JdzJegLlqJeKl31BevbfsrM14YfbM73V6kvnQmQZoSDfzWdfVpFnf0JPyTEix4DJ9w49lqQb+Wf5x0yb4YmkH8G7UIhxI6+9wlVYUxYTSkVw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB3668.namprd12.prod.outlook.com (2603:10b6:a03:194::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 06:20:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 06:20:19 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yu Kuai <yukuai3@huawei.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] null-blk: save memory footprint for struct nullb_cmd
Thread-Topic: [PATCH] null-blk: save memory footprint for struct nullb_cmd
Thread-Index: AQHYWRJfc6q9UMjEXESR9nddsnwuda0BuUKA
Date:   Tue, 26 Apr 2022 06:20:19 +0000
Message-ID: <3662c725-a919-443a-9ab8-dc536cb5c03b@nvidia.com>
References: <20220426022133.3999006-1-yukuai3@huawei.com>
In-Reply-To: <20220426022133.3999006-1-yukuai3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d31eb8cd-af42-4417-033f-08da274cd69c
x-ms-traffictypediagnostic: BY5PR12MB3668:EE_
x-microsoft-antispam-prvs: <BY5PR12MB36686390C781FBCDBBCC67CBA3FB9@BY5PR12MB3668.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9nR23tPeNHsHxdlNFImiMXzCcou5w51sdOUxB+TLXh3mPuhetShgpRqM/hRP2wOhDUVOEBkpKc5gfjy9vrR6+sXw0AdRSPk1NsW0Oi4k0ADk57jfJAz4t+IY31uH5K+sxVAaRX1o3yXRa29uaEL+760QVfUeYzACpalHlZ+sgeZI7OPgiH2oJvwVl4GK8S8Dhsvliw7lEmgSU7vcNiMc4buZ75fk6TzFxEdW2raS5ofgOAGUKi3LOkvkkA/pBdpQTdGfg1CWvFogjDGQkyq5zYr2taZEx0fmYBLX+pR1sTW6QExbktj67mOohKdtbC/9EXwkULd8NrdVFP9GeTMjNhCNfQGfvEu8ETb9a9pbIvDYXmF0tg8RzF+HzSLtNE4lJ7tKrVPEG6uDtA1czajYjIWCrt8IK3Tu/lFAgZBygS8FyCf6oBcJnZAIiNJbyd5JoJhEPXWUQsT2USCDuUawzsTUB/eoyS7ot/sMou9e4GZQjq9Ech6tELOl1oNzpglbfB3RMrgsHq5V7Qp5sU12tAtZQ08pUHFoJeOHbHebII/CbCMqoOTeRg6qI0gKqU3mChvtiUWUkzC9JqNieYmo31kIhfnCEA54NeOF7ooX6hrNTDqJ0uRTsO18Y/fY/oj6hfZ0QGckXD0BxKp7EK4/4YVmeL2jTy5IDl+OKBJvSSGpzwB2DRgT8XxLrTc5sKZsGl7qfXVGevEbv2SwWymkvCLU7ebLZ5prjVNavVKW+pRSacOJVyD5KlE0aMRLxHttUQkp4Rd4nljPy84wW5Epg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(5660300002)(122000001)(36756003)(38070700005)(66446008)(2906002)(316002)(2616005)(4744005)(38100700002)(6916009)(31686004)(4326008)(8676002)(66946007)(91956017)(66476007)(76116006)(66556008)(186003)(64756008)(86362001)(53546011)(31696002)(6512007)(71200400001)(8936002)(6486002)(508600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3l2V2J0czBOeWNpZ1k3YUFvV1I1dHNST0I5NklLS3lSSi9Kb09CNUh4aDFj?=
 =?utf-8?B?elBmQzVHMlJKeGczUkJ3d1ZWVk9MYW9COUxlQmE2NHJpL052WWhYNkdiNkx4?=
 =?utf-8?B?OWtqcGFBU245ZS8wWWVSSEFuZld4WmVzR1NpZk5ndE11Mmx5ck1OYjl0bmVs?=
 =?utf-8?B?dkJFM2d0Q2dRc2lSdTlGY0FBMlZBdHdzRHFoVnhxV2RaZm1KM1dVbzIrQWc4?=
 =?utf-8?B?RkxGVVNpQUxyL2R4REoxZVlEQmpzK2VLOE1tVVZPZSs4Vmdvb1liM1FxNXFy?=
 =?utf-8?B?UCtjMURCQlVVSkFqNnVCYWx1Ry9VVXFTUWtSSnRpTXY3NDlLdVJkTjEyT091?=
 =?utf-8?B?TTlrZDZQbWI1WGx6MmptRXJ1S1dsa0E0S1kxMG0vSDFSNlNkV2lnQXlKWUhC?=
 =?utf-8?B?RnJMTmhoVUw4ck53UmZ6dVZRRC9EREhCbEFXQzhzOUhJbUZrYWFQLzNMNHV1?=
 =?utf-8?B?dlh6OHFHTi9wTUQvL1NwZ2l6NWZmT1BaRUZXdk93RXhGM2FKNlF6OXpTeXJx?=
 =?utf-8?B?ZTlkanIyOUNiUVFJcjNUOFlEWjMrRmxSdFhqN0lEd0NUVy9vazdnY0pHUGNs?=
 =?utf-8?B?eThwUGVuQURaLzJsMzJNbVorLzFJMXZ0UEh3b3M1RDkrRG1XV3hIL1FUQnRJ?=
 =?utf-8?B?aS9QdFM3OUVTWUd0SjR4L0gxaEdxZ1Z5cXRNaEhwMEUxWFEyNDd4aW56U0lo?=
 =?utf-8?B?RDBmblI2d2htZ1BzdHg2b24wZDc0M1Y3dFdTcjhsTWRHdEZsRnZkRFRaWVlC?=
 =?utf-8?B?dEFTL08ybG9DbUhmU3RkTUZFNXlaSVVrNG9QY08vOUE0S2dHZjBlN3k1b2hL?=
 =?utf-8?B?ZjVxUGlsOWZheUQwQzdSZkwvamp2bjlXQTQzWE9EVnRPdHlxc2EramY0cno2?=
 =?utf-8?B?M1A4Vy9QQlROOHFMMUtsNnYzQnFjdzZ6NTZRR2Qxa0RjcGVtcWgyYVNNUkQz?=
 =?utf-8?B?MjZJdUJLb2IvYmtqQXlPSkRjUnZLajlJYjdEZ21ISnRNam40QVZZS1k0RWQ4?=
 =?utf-8?B?M25ISEp3dzM4Vi95WnA3YXc2M2dlOUE5c0dma250WUtCeCtWeVN1cjAyN1ow?=
 =?utf-8?B?ZVIrZVJrUFBSb1hJMDRacU0wYnRNbmxEMTBwS0NPclFza2FPNTdkUGpCUnA5?=
 =?utf-8?B?RkkxRjZXWDAxdkJpNkQ5SG0rUVYraVljUFlRU0JUMmpteGQrS2FUNEJ5ZjRI?=
 =?utf-8?B?ZHk1ZDVoKzRFT0gxRTUrRHZ2ZmdpOEs4bXAwM0ZmNmtPNVhiTG8xOGIzcUFs?=
 =?utf-8?B?b0RCUkFPZXRXNzJ1U0RMYjFvZDFPenZ0U1BhQzFJdkJueUpuMy8wSXJjUVh6?=
 =?utf-8?B?K0pZMHpXMU53b0lQbTRYMjBOVlVjSjRKdW1Ya0RSN1lkTER0RlVqNFJ4c05k?=
 =?utf-8?B?ZkMzVkd6UVJVRnNNdjYxRFhHZlZaaWJrcWpLR0FNZGJDVzVtdmRxUFBsRzhy?=
 =?utf-8?B?T2o3UVVsUmh6WGl2Z0VhMWNyS2Z0bHZDb0dPQjBOQ1NOditCVnlZRy9Ra2lU?=
 =?utf-8?B?OGtLdDdGbzV1VjZ5OUFETG4rYjBGbk1pNGxwMExtYlVJWTFZbUUwQUNrRlcy?=
 =?utf-8?B?a2pFM2taYUkzcjFiTStINTJHeTBveDB0bUlMczRYV2docy85VXJaUXlLTlpK?=
 =?utf-8?B?N0srRkpRUGNzWUZTOUpJcytISGNINzhheUJLRkRmRkNJQkVtVXdrRElEKzUz?=
 =?utf-8?B?eEVSL3lPN1ZMZ0NsVzFMTkJQOUFSeEI0ekRJblB4akxDTXhMeityTU9wV0xw?=
 =?utf-8?B?UjBraktUbWxwVFV0bk9aQmhIdnZEWHFLNUVJckgrS1ZOS0lKVU11NGdpUnhx?=
 =?utf-8?B?T2haMTFBdnFqdE5XYVhHbXlDTFFXb1FEMXZ0c2xQcGtVblNTTUQwbjhpck0z?=
 =?utf-8?B?bzZHMFJrdHllWFAvVU1RY21GTnd5YW5mN05MMExjYjBJL3ZDODI0NFNaMDlL?=
 =?utf-8?B?R0VoK3dsQjFtRDM5aFYzeGVESGxVRXBrN2ZEV0pHeXRDVXJjNmNrZUhDaDdK?=
 =?utf-8?B?U2N2NkVyMEZTRXdieVlkRG1Ea3VQRjhIWXQ5OGZCdFpxVTlFcmVVWDJaemo0?=
 =?utf-8?B?c1Fyc1dJTk1ta2VZUVBNQmhkUktsVmUvbE9VbnRwY3crb0FZeVNCKzI0Zkw2?=
 =?utf-8?B?Mm40eUc0dFh0cXZLMHZORjJQeUx6eVN1UjFlVG9SWEZRRFhtVEVvdlNDdFlD?=
 =?utf-8?B?K3JLRTdvQW90QmpIUzh3Zk1SNDdaT05MYnRqS2JYNHljVFNMVnVYSFUzaXd4?=
 =?utf-8?B?UmU3WlBpdXkwanJZREtOWkgvL212N0krRjgxbm9zenI4dlNLQWtodmlsc0xh?=
 =?utf-8?B?ZVdvRS9pdGs5WWFRTUQxaHVoM0dtejMvQVhVbUJlRmtOc0JuU0hJOEJheWlm?=
 =?utf-8?Q?3EcnGL7DKaV9UvfvSQ3MHeRwDsVxu/QIej40qfjtXBqFG?=
x-ms-exchange-antispam-messagedata-1: MFpWTHkfKQujpQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <07D3DCD14D575343AA02B3D670EBF5D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31eb8cd-af42-4417-033f-08da274cd69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 06:20:19.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkxXsmrBBBFft2KgkKhJbjcmJlGGwrIBz4HrFuQgv9iOmy6NlYqGnwmTUCdISpYi2Oo8oxwknVVNDtIrAqcFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3668
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNS8yMiAxOToyMSwgWXUgS3VhaSB3cm90ZToNCj4gVG90YWwgMTYgYnl0ZXMgY2FuIGJl
IHNhdmVkIGluIHR3byB3YXlzOg0KPiANCj4gMSkgVGhlIGZpZWxkICdiaW8nIHdpbGwgb25seSBi
ZSB1c2VkIGluIGJpbyBiYXNlZCBtb2RlLCBhbmQgdGhlIGZpZWxkDQo+ICAgICAncnEnIHdpbGwg
b25seSBiZSB1c2VkIGluIG1xIG1vZGUuIFNpbmNlIHRoZXkgd29uJ3QgYmUgdXNlZCBpbiB0aGUN
Cj4gICAgIHNhbWUgdGltZSwgZGVjbGFyZSBhIHVuaW9uIGZvciB0aGVtLg0KPiAyKSBUaGUgZmll
bGQgJ2Jvb2wgZmFrZV90aW1lb3V0JyBjYW4gYmUgcGxhY2VkIGluIHRoZSBob2xlIGFmdGVyIHRo
ZQ0KPiAgICAgZmllbGQgJ2Vycm9yJy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1IEt1YWkgPHl1
a3VhaTNAaHVhd2VpLmNvbT4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
