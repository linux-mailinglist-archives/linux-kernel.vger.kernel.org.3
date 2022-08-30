Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579C15A660C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiH3OQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiH3OQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:16:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361456AA33
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661868967; x=1693404967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cAwxd/d3/xgZZrVSknWhmPKMxJT5YjAbg3HZcErs7aY=;
  b=IiX9IjDkpEQqWevSfvdeiorpD7hLVZE6yZfm0QliD5lU5BC2Ey9SXUCG
   Yh00ALchaTZyvcs+Zi1kDFQUtdSdNNHMwGVmJa0/alkTVYG5aXTsnsb9F
   n73ryI/bVFc/OTK9NYiUSqI2LMN5k0Ww8A/gkdhT9QBzgQVGvSmZEHqUM
   7I2u3+CABvolRivsQJtNjkHzYCVXqkcO3JX8qeORy+10YafOVJj80IeQ2
   wje8d3x1cixXjgHStpieMqKcnBRrg4A9qZrqsB4nT8A8XPqMln5wBryDG
   Y9HknCuWdKEGD9scMNKDIYlEwf1szfYvmQ7LGUfUy9PLa1a8YPXh7mzYS
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="174820125"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 07:16:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 07:15:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 07:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odzAZjn0AtE2g21sb2DAzaQuld+DRZBRd3WHZRjIiF2ATIi63wUtwVhe3uv2mvtoxZIJwITsJd25x5qRudLf3hLUexg/h/jBnRIpYXPrZY4AUG8JrZHkbDSGdAhjLTIMyphGl8FiMhqiRN1sERKPFD4SnICu12+VrDW11lcpBlK9Ri+nb5YQPvvf4JwMdust8Rsu1j8SKpiCe/Z1XNlGMKK1+Je8jmh9x4K1+nUqEAa++P96FXcpXGNrjEFeaWHFB4+3HyFwzBp/K87ZRmeXkVD9E4xgExkwxh6IeW613wg178yOA7sqqlnbICM6xpS7vcnysEvh8SpSWwFc/aAwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAwxd/d3/xgZZrVSknWhmPKMxJT5YjAbg3HZcErs7aY=;
 b=ZP0962R9zHjonx/RFXdQiV2SsFykd+awRfeTphZh3Nt+/U6ncGYuPTtveP/C1zS1bLM+gwnBkbjIlcucWUycUJbyvo85a87csDhTCgeqB5EQmCM9yqL4Gfz4neLnJpZsuo45eK/a6hKpbXWRadKwVfhto1QW6RZ7WLqpSvGZMZHFYS9XUSRHS8gfmR/8h5jBdyMMcXZbOZGJs2+9OFQlV0Vx4/HWAkX4PUH2HXTLwgs78xpzDCdl8GgOIicqofkIDLUJCjIWCBP2bZ6YISVDB0Zs204Yow8Y0Ag2gnpBQMfYSTCS8silK/1qpd3S4U2so5PHiykeOdOFQbEqKiNJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAwxd/d3/xgZZrVSknWhmPKMxJT5YjAbg3HZcErs7aY=;
 b=JEGTkNXFYEdwgy/fG2ui/P+DGHgD+PXnVwRS6eDBJn8rmdEf3IwPS185/+e02sSxJtJzC53cTrENPZ9HJLd+oVxV+EihvsOVhIMiLnvgx7m9TregOcbFJhtdNOeHy0Z3auqTizfuQCQu3HnUk39BAm9+EXDhm/piv8OYx/6A9gk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 14:15:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 14:15:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jszhang@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Topic: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Index: AQHYufzf4JJbBuNch02tBI9sTRPCrK3DP5sAgAKut4CAADcFAIABWCIAgAAEioA=
Date:   Tue, 30 Aug 2022 14:15:45 +0000
Message-ID: <d9331af0-58bc-ed3b-10f5-8509795e3198@microchip.com>
References: <20220827095815.698-1-jszhang@kernel.org>
 <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
 <YwzI7VmfFnOvYWgf@xhacker>
 <4037b310-47c4-ca30-d4b6-a284e87da437@microchip.com>
 <Yw4XwsVQBB1HRw04@xhacker>
In-Reply-To: <Yw4XwsVQBB1HRw04@xhacker>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4470b8d7-a144-4c8c-f841-08da8a922185
x-ms-traffictypediagnostic: PH0PR11MB5190:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q4bPcvJ3oQtVnZz61dtzVoyuXse6qebO3CWqULoeRFjYirBzpzjzUuHXIp3EpTHFYTdA00ce0wWpjuPhmPNqeNp4ruN2IQzzVhmTpBzINTuHk0TpTDL9rQaxpPzw9okiAxGl6hkkKKsmNQIcrZDpGTzRurCZE/TPaOi8/2sK9noFSUJTKKDC45BpgacCzPcC/dVQF3jLWzFJzsAlF+20uzpW8nxUsT73GYt8GqRLJZVd9EYD97op13KnXI/ny2ANpee0NNL2q0aTrlzDh9WTnhIGeJ3K/Y0pZIh8NHmwAKFuNmewDrhV75Xrud5tu7H0zpG646dUlwhWZ9Kd7nqZR8dm3G586d0/gE36SHzzW4mBgTZWT3Bw6879OJ1Kvtm17rma0QM8Jt732b3VpUCsWq/zxy4UcM65AN1VtCYDZk48GejH1IuIJ2xxVH8vYkv4A7qRfArSZZzB5Ml9Sr/b+wWEA2O0W5d4D94WPD0n6hXYqBo9FH7npnQEbeatEodt0YNaU4jNL/Yxs17hvkh00NjJMgZwA03qDslg7XVgK9K3dzY3dOdisUM0z5mBv9inob3LcgtxE6MzCsBQob1fYG/P3DW//77NGmv7zeIL/HHSp4hsWpoRKzfFtQ7993GTKb+woLIi2JOlSxFj3jAIv3s1AAUZlcLMV7caiCaIbhfwgee+rN3eWLkq/luZ6EOrBYQKEN70fMntXaEhVElsVHtsckiKqttbFBRZ+OoKsN+UPwTPyc3XjVjtxY/biCpXbTVsuNGXKjcAvuAhe3iafh5qlIDKAVgRjsCkxRWAgotiRbr6rsZFkJOzFpEixUdTdVcsICzDC8n5tJdfZK0HVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(396003)(366004)(38100700002)(6512007)(26005)(86362001)(122000001)(478600001)(5660300002)(8936002)(41300700001)(31696002)(38070700005)(8676002)(4326008)(31686004)(71200400001)(2906002)(64756008)(66946007)(76116006)(66446008)(6486002)(6506007)(54906003)(66556008)(53546011)(66476007)(316002)(2616005)(91956017)(83380400001)(110136005)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmVwVzdsdWlZWUhIQ050ZFB6TFNrdWpuWGFmV2w5NDRIanBzb0pxVWVLamV5?=
 =?utf-8?B?RWRxN3Riamg1V1lROGo2V01jV25Fb3ZZVWY5N2FEem9IYTk0cUFrTkZRUVZD?=
 =?utf-8?B?SDRXMEUwMlY3dGFzR1Z2Y1VWVXRPK2h1T042VXhpUUx4SHVmSWRDdEJWcVdl?=
 =?utf-8?B?SEpuejVJWWVDcHVCMHJYd1RqTEtSUGZ3V3NYR0hteE0xdndSNWs4dmpDTHpW?=
 =?utf-8?B?cVRvRlo1UXBLNmZIbk9vTXMzRHoyN0xvcTdZV0xmY3JQSDJ4dWpOZ3FCbmZY?=
 =?utf-8?B?c1dVTmM0UmY1MGZ2Y2p4QjZ0amdpeHFSNlAxV25WT1ZnbkIwNktmZVVlakxS?=
 =?utf-8?B?VEFOTFllVGJNeGpCUlZvUzlzOUVwcDAwNk93bnc4d09mUE5JRGVKQ0NNRUY0?=
 =?utf-8?B?UW0zckV5WUVaaDhSS3ZPNG9FSmRteC9UWmtSaXJsc3lwbnFFMWtIeERyYWQv?=
 =?utf-8?B?UnV3TC93bGdQTTVPaEtQSTZGUGxvMEdWdE43dnlOcjhGbW53ZFZHUzZUL1hK?=
 =?utf-8?B?ZTNlS2R2YUhLTkVueUlxdFU2SHprWmpjamVNRURleXFXd3o1SXo5Q2tuZFJj?=
 =?utf-8?B?NlRtWUFEdXVyZ1c0a285bndQbUZUWmU0YVpFRHZRekJ1TXQwMmRQN3Z0V3pW?=
 =?utf-8?B?SkVyU3RGUE5uTEJsU3hYb2dWYWZKaHMvOGlLSlN2UWZhQWlqeG0rZWpKeFdI?=
 =?utf-8?B?TXFMWGJpZFFUeWpHeE5FNHRxOGpuNnAwamtvaCtmNE56dnpaVERDL3F5TG1a?=
 =?utf-8?B?Wm41Ly9keUZyN2VybGVOdDZiS0lrMEs5c2tUUnhiQ2J6ek5GNW5iU0JxdlR0?=
 =?utf-8?B?Z01uVzhHdytJMy92UVNRTnh0WnBsZmhtTlRwUmFCTXNreTJ4cHIzY0lhTzZI?=
 =?utf-8?B?Nm95Z1kwM0FMQTFyMFZVa3ROUHVIalhFdTg5RkJFdjJhK0tLKzRpSnZpdVBZ?=
 =?utf-8?B?Nm44M1hzYXFibnQ3ZkVoMThOVnJha2hDYmhMVFRUSGRjUTI2Mlg2YzBhU3pV?=
 =?utf-8?B?MlFMcUlQOVphK1p0dUVld25nU2Z0cmdhQll1QjFUQWlIODJIR1FLTzFmWkw0?=
 =?utf-8?B?ODVTdkFwZkN3ZHlwMU55em9PbDdsb256d3ZtMnIzVDZ1R3lPakUwUlM1bG80?=
 =?utf-8?B?SUthKy8vR1crZ0NIYk9PRWRGQzZCWWxacU1SbXd4eUU4NmIwWldGc1p3TmpC?=
 =?utf-8?B?Y0htUlluLzliQTVxWmRwZGFFVFh5M0R0OUp3TEVrNy9yV0llLzZZZ2N1ZTNV?=
 =?utf-8?B?QStzS3drbEVyY3lRbGpMZk9FWUlsWmdGQzVYVTRMZWF6NnVNaVA2amlHNFVs?=
 =?utf-8?B?T1U5S0VlWG80LzVmUFpobWFnc2kxMlNndHptbDF3TDlVdWlwdGNPL0JhNmc2?=
 =?utf-8?B?cStNZXpGSmRNSDdRQnFaZ2dvZ3VVTGxLZHMyTHpud0I1bU4yOGtsbE93aGlq?=
 =?utf-8?B?b1pYUHpVK0p2SWE5cGdFSDJncVVLZFVXb2FMaGxibkZ6MDd0RHdpcldiTDJh?=
 =?utf-8?B?dTJUT24yaG1sN2FxQmxRdm8wbUU2VXgrU3pEKzBwQVZnVDI5aGxYTmY0bmwy?=
 =?utf-8?B?NGlpYTc0T045bkhjYzBwYzJyNVlMd1BNcVE0OFdqUWR3ZTMyYkNEOG1rdURH?=
 =?utf-8?B?bDg1aXhYeHQ4MnRZZ0hCRXFUcnE2WmRpTkg1bFJ0aVlKcC94WHFxMFFVcjVa?=
 =?utf-8?B?Z2pLNDdSemQ3WlpueDl5dUJHUWNhNTF2ZkY1bkRqbVVQa3BLd3VJMjlJN2Z1?=
 =?utf-8?B?VlhTeWxYZGI4QnNncFQya21MOTNUYjJEa0tEbkFCSTVOYXNCVTk3UWpkMUZ2?=
 =?utf-8?B?QWdSY1UrSzlXSm16UzBBNHI0cjQ1RGJtRFZVUGxxTC80dWgxekUzbHRiNW5Q?=
 =?utf-8?B?NVdNMnBSdUhQWE1MSkk4U1pwSmZ5bTlaTXhOTVVOT0lJWkhqc0dvMDdxcEFt?=
 =?utf-8?B?eFJWMEZWaWpMZFhQS2lYQUF4RjRkTllFaWFuUmE1eDRLY3Y0bCsrRUJsSHRO?=
 =?utf-8?B?NDBuZ1dJZFJWVVpod00yUEcvUkg1K1l2QUo2MTAvaWNjaW9GWERtUnkzRnU0?=
 =?utf-8?B?b3RTdk5ndGNhZnVmZlVhbnkvVmw0Ny8wQ1NwbkZaTzNqTmJ0TnVnd0N2ZWNS?=
 =?utf-8?B?NVZ0bjlQRFBzTkh6c1BObWhSajhUdXpjRi9sNnlldmxNSzA3dHNZRkJFcXBB?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BBD5DF88B7CFF4AAB7F93CB61C6F949@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4470b8d7-a144-4c8c-f841-08da8a922185
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 14:15:45.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRVvR3lk2IUOgzf26ri7gFxuN6BEE0KbrH5i9gm3ReO0/dLMv5EpZnTmP9K0HLi/CnocR4LrEvyLEcQv7WCeAAzF74MTSI8YzVoz4/4vLi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxNDo1OSwgSmlzaGVuZyBaaGFuZyB3cm90ZToNCj4gT24gTW9uLCBBdWcg
MjksIDIwMjIgYXQgMDU6Mjc6NDhQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+PiBPbiAyOS8wOC8yMDIyIDE1OjEwLCBKaXNoZW5nIFpoYW5nIHdyb3RlOg0KPj4+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gU2F0LCBBdWcg
MjcsIDIwMjIgYXQgMDk6MTM6MDNQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+Pj4+IEhleSBKaXNoZW5nLA0KPj4+DQo+Pj4gSGkgQ29ub3IsDQo+Pj4NCj4+Pj4g
T24gMjcvMDgvMjAyMiAxMDo1OCwgSmlzaGVuZyBaaGFuZyB3cm90ZToNCj4+Pj4+IEkgaGF2ZSBh
IFNpcGVlZCBMaWNoZWUgUlYgZG9jayBib2FyZCB3aGljaCBvbmx5IGhhcyA1MTJNQiBERFIsIHNv
DQo+Pj4+PiBtZW1vcnkgb3B0aW1pemF0aW9ucyBzdWNoIGFzIHN3YXAgb24genJhbSBhcmUgaGVs
cGZ1bC4gQXMgaXMgc2Vlbg0KPj4+Pj4gaW4gY29tbWl0IGQwNjM3YzUwNWY4YSAoImFybTY0OiBl
bmFibGUgVEhQX1NXQVAgZm9yIGFybTY0IikgYW5kDQo+Pj4+PiBjb21taXQgYmQ0YzgyYzIyYzM2
N2UgKCJtbSwgVEhQLCBzd2FwOiBkZWxheSBzcGxpdHRpbmcgVEhQIGFmdGVyDQo+Pj4+PiBzd2Fw
cGVkIG91dCIpLCBUSFBfU1dBUCBjYW4gaW1wcm92ZSB0aGUgc3dhcCB0aHJvdWdocHV0IHNpZ25p
ZmljYW50bHkuDQo+Pj4+Pg0KPj4+Pj4gRW5hYmxlIFRIUF9TV0FQIGZvciBSVjY0LCB0ZXN0aW5n
IHRoZSBtaWNyby1iZW5jaG1hcmsgd2hpY2ggaXMNCj4+Pj4+IGludHJvZHVjZWQgYnkgY29tbWl0
IGQwNjM3YzUwNWY4YSAoImFybTY0OiBlbmFibGUgVEhQX1NXQVAgZm9yIGFybTY0IikNCj4+Pj4+
IHNob3dzIGJlbG93IG51bWJlcnMgb24gdGhlIExpY2hlZSBSViBkb2NrIGJvYXJkOg0KPj4+Pj4N
Cj4+Pj4+IHRocCBzd3AgdGhyb3VnaHB1dCB3L28gcGF0Y2g6IDY2OTA4IGJ5dGVzL21zIChtZWFu
IG9mIDEwIHRlc3RzKQ0KPj4+Pj4gdGhwIHN3cCB0aHJvdWdocHV0IHcvIHBhdGNoOiAzMjI2Mzgg
Ynl0ZXMvbXMgKG1lYW4gb2YgMTAgdGVzdHMpDQo+Pj4+DQo+Pj4+IEkga25vdyB0aGUgb3JpZ2lu
YWwgY29tbWl0IG1lc3NhZ2UgY29udGFpbnMgdGhpcywgYnV0IGl0J3MgYSBsaXR0bGUNCj4+Pj4g
b2RkLiBJZiB0aGUgcGF0Y2ggL2VuYWJsZXMvIFRIUCB0aGVuIGhvdyB3b3VsZCB0aGVyZSBiZSBU
SFAgc3dhcA0KPj4+PiBwcmlvciB0byB0aGUgcGF0Y2g/DQo+Pj4NCj4+PiBobW0sIGl0J3Mgc3dh
cCBJJ2xsIHNlbmQgYSB2MyB0byBjb3JyZWN0IHRoZSBkZXNjcmlwdGlvbi4NCj4+Pg0KPj4+Pg0K
Pj4+Pj4NCj4+Pj4+IEltcHJvdmVkIGJ5IDM4MiUhDQo+Pj4+DQo+Pj4+IEkgY291bGQgbm90IHJl
cGxpY2F0ZSB0aGUgYWZ0ZXIgbnVtYmVycyBvbiBteSBuZXpoYSwgc28gSSBzdXNwZWN0DQo+Pj4+
IEkgYW0gbWlzc2luZyBzb21ldGhpbmcgaW4gbXkgY29uZmlnL3NldHVwLiB6c3dhcCBpcyBlbmFi
bGVkIGFuZCBpcw0KPj4+DQo+Pj4gc3dhcCBvbiB6cmFtIHJhdGhlciB0aGFuIHpzd2FwIDspDQo+
Pg0KPj4gSSB0aGluayBJIHRyaWVkIGFib3V0IDMwIGRpZmZlcmVudCBjb25maWcgdmFyaWF0aW9u
cywgaW5pdGlhbGx5IG5vdA0KPj4gdXNpbmcgenN3YXAgYW5kIGxhdGVyIHVzaW5nIGl0Lg0KPj4g
TXkgenJhbWN0bCBsb29rcyBsaWtlIHNvIChhbHRob3VnaCBJIGRpZCB0cnkgenN0ZCB0b28pIGFm
dGVyIHJ1bm5pbmcNCj4+IHRoZSBkZW1vIGFwcGxpY2F0aW9uIGZyb20gdGhhdCBjb21taXQ6DQo+
Pg0KPj4gTkFNRSAgICAgICBBTEdPUklUSE0gRElTS1NJWkUgREFUQSBDT01QUiBUT1RBTCBTVFJF
QU1TIE1PVU5UUE9JTlQNCj4+IC9kZXYvenJhbTAgbHpvLXJsZSAgICAgICAyNDFNICAyMk0gIDgu
NE0gIDkuMU0gICAgICAgMSBbU1dBUF0NCj4+DQo+PiBJIGFtIHVzaW5nIHRoZSBkZWZhdWx0IHJp
c2N2IGRlZmNvbmZpZyArIHRoZSBmb2xsb3dpbmc6DQo+PiBDT05GSUdfWlJBTT15DQo+PiBDT05G
SUdfQ1JZUFRPX0RFRkxBVEU9eQ0KPj4gQ09ORklHX0NSWVBUT19MWk89eQ0KPj4gQ09ORklHX0NS
WVBUT19aU1REPXkNCj4+IENPTkZJR19aUkFNX01FTU9SWV9UUkFDS0lORz15DQo+PiBDT05GSUdf
VFJBTlNQQVJFTlRfSFVHRVBBR0U9eQ0KPj4gQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFX01B
RFZJU0U9eQ0KPj4gQ09ORklHX1RIUF9TV0FQPXkNCj4+DQo+PiBBbSBJIGp1c3QgbWlzc2luZyBz
b21ldGhpbmcgb2J2aW91cyBoZXJlPw0KPiANCj4gc2ltaWxhciBjb25maWcgb3B0aW9ucyBoZXJl
LiB3aGF0J3MgeW91ciByb290ZnM/IElzIHlvdXIgYm9hcmQgYnVzeQ0KPiB3aXRoIHNvbWV0aGlu
Zz8gSSB1c2VkIGEgbWluaW1hbCByb290ZnMgYnVpbHQgZnJvbSBidWlsZHJvb3QuDQo+IGNhbiB5
b3UgcGx6IHNob3cgeW91ciBudW1iZXJzIHcvIGFuZCB3L28gdGhlIHBhdGNoPw0KDQpJIHdhcyB1
c2luZyBmZWRvcmEgZm9yIHRoZSB0ZXN0aW5nLCBkb3dubG9hZGVkIGRpcmVjdGx5IGZyb20NCmtv
amkuIE15IGJlZm9yZS9hZnRlciBudW1iZXJzIHZhcmllZCwgYnV0IHdlcmUgYXJvdW5kIDgwLDAw
MA0KYnl0ZXMvbXMgbW9zdCBvZiB0aGUgdGltZS4NCg0KSWYgSSBpbmNyZWFzZWQgdGhlIHNpemUg
dG8gNTAwICogMTAyNCAqIDEwMjQgSSBnb3QgYXJvdW5kIDEzMGsuDQoNCkJlZm9yZS9hZnRlciB0
aGUgcGF0Y2gsIHRoZSBudW1iZXJzIGRpZCBub3QgcmVhbGx5IGNoYW5nZSwgYnV0DQp0aGluZ3Mg
ZGlkIGZsdWN0dWF0ZSBxdWl0ZSB3aWxkbHkgLSBmcm9tIGFib3V0IDUwayB0byA5MGsgdXNpbmcN
CnRoZSA0MDAgc2l6ZS4NCg0KPiANCj4gSSBhbHNvIHRyaWVkIHRoZSBzaW1wbGUgYmVuY2htYXJr
IG9uIHFlbXUoanVzdCBmb3IgcmVmZXJlbmNlLCBzaW5jZQ0KPiBJIGhhdmUgbm8gb3RoZXIgcmlz
Y3YgYm9hcmRzIGV4Y2VwdCB0aGUgbGljaGVlIFJWIGRvY2sgYm9hcmQpOg0KPiBzd3Agb3V0IHcv
byBwYXRjaDogMzAwNjYgYnl0ZXMvbXMgKG1lYW4gb2YgMTAgdGVzdHMpDQo+IHN3cCBvdXQgdy8g
cGF0Y2g6IDEzMDA1NSBieXRlcy9tcyAobWVhbiBvZiAxMCB0ZXN0cykNCj4gc28gaW1wcm92ZWQg
YnkgMzMyLjclIA0KDQpJJ2xsIGdpdmUgUUVNVSBhIGdvIHNvIDopDQo=
