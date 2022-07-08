Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DBB56B48F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiGHIgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiGHIgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:36:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033712615
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657269364; x=1688805364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=96V1pzWt5zTL17W8JQswOgRjxRGoJy0jjzDnUgYg7gg=;
  b=WEyDavBK3LRuZylBzqf0HBoBq5r0pGjXbKlE10vWzIQxX6h5myDd6Grk
   NHuE1nwBJ5mAhtXUEE/sPiudEO1sGuGA+I+NHslV/iikm17YQz7QOQB9G
   gR8nuG/2M86uDPmKdltnd1KpR9mrmyAc5XrJtBVoopz5QWVRzPM2s1xJV
   U/Mv6hdorcCga0CmFhL4enRrN1RFn1DX/2ZgMjAZN/TEH4gOrykjayNqo
   5MF+aA/HOk/AwXCSXPpJQBEPXAIaSSTbDEImxIEipt8HrbmYwiWwhypMK
   rXRSBkyrHHKIpUtd1caHzLRHMI9toWaVHcv7X6dbh+HXQC+tn+V8V8YDO
   g==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="166969663"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 01:36:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 01:36:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 01:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf4FGwi97byC1hgRKM/TNr8tLhM55CmlJII36lr+OZxv8FWncTQzaFKMsD3NXnndB47sbhwUtPhyxuBoEflZ1s15qgoX1KEMvHdwcWBgx19f68d5nOeI4WQ86PQhWLYbbrzQrUDuA763/1hmivM7LJFr3COwTRAGRi3HpSsI/6UidKgV/c+DADIo4fchaV/bq6O0FbnKni5kWDqs5JexZxWl1qcwKk998CSismifk88WgrIfRBjnJSR6zT+6XSKgr1GBBpTbl9n82tcozRsc/MeD94fIF5w2dHEgnLvPf5AenINCovE7T6fmm3b/+UpalZ2hO+GIxgHnpCyAkqwK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96V1pzWt5zTL17W8JQswOgRjxRGoJy0jjzDnUgYg7gg=;
 b=QJhNi7unA3ANP4caVHuuBOyaBpXAnPZ2SWWp02NWzA4R0av/Hu4aaU8KXlTRUlNV6VZlIK0nWFCgivwtph3d58b6kGqJRbsMDSHFWeEO7VHYLZiVyIWnL9/599LZ5ljfCXz0JQ4b5HNNq6Ueq+7ZEYi419Ww/TTkmNL6GAHUUW7aTQxnvwzgve6K7HN82E9pUprtP86K+9hpC69DTfahpGH9/jzL309SeKbnZAK8GlvFgftnHGdTIb9Q+OlBtTBba+gnN+Ov53e9GFLMYhkQ6qjjr/l4D+4xYMKTQRHAj/MmXIVx6scX3KefYkq/hRqvlYbbpyWRBYZQBudFULVzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96V1pzWt5zTL17W8JQswOgRjxRGoJy0jjzDnUgYg7gg=;
 b=FY/n8pmXm60sM9DNuUcTzmLYhJjqVT2fwuZb0RiMCWZA1SLXG+Mlh5DE2lltMBcO9/X60Je0lVpa8uwt8HGMbF7ApzKBU/2xYFIlUjuqe9Vwn8n8sfAdaq0RPRkWey+jT/nPeBFpYFC1RTZvH13YShvEJkLTW/rBFjYcsEnCo0M=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB2829.namprd11.prod.outlook.com (2603:10b6:805:62::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 08:35:57 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:35:57 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <Daire.McNamara@microchip.com>, <Conor.Dooley@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <changbin.du@intel.com>,
        <heiko@sntech.de>, <philipp.tomsich@vrull.eu>, <robh@kernel.org>,
        <maz@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Thread-Topic: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Thread-Index: AQHYkk3HIdduEfI8FU+fdqjoS8H9IK10I72AgAADKgA=
Date:   Fri, 8 Jul 2022 08:35:57 +0000
Message-ID: <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
References: <20220707220436.4105443-1-mail@conchuod.ie>
 <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus>
In-Reply-To: <20220708082443.azoqvuj7afrg7ox7@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f942d8b-6eb4-422f-ab2d-08da60bce115
x-ms-traffictypediagnostic: SN6PR11MB2829:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PwlcGh6aegdSBrMF1er3QAdvU7EqWQ/WiIW28Q2+GQo3qSj+i4uy1xAlyjHTN6kYfdQCU5ZKByV3qaRkexRevG0c9vJtql0nuOHshiwom5qa6BM1QR22kVhVsNkGOCpsmD5TH1cVwuzdwJ8MSczXJaKMehB9XUPevVgbdELV1630CLGYX01oeTtmOquWaDvYclgH93NSDJmTvwXacOwywgbInYQcJgzFsmesY9NEyF2WgFSWJwn3m0IeAIC2ue8gJHpQiVEsOw/EaW24CjudwD7bcNZp0v2L4dpCeUiH8/SxzOff/Pj/WcPgZprob5GbsJL9MlTgrYs/o7IqC77r8bFzyUU52VPCg8F33agQNhvxXQAtIeJf5OPo9fezzaDBBvqFLu3mTvCoGWXmpnlGX060i33GypzZXmXLMujgqNyWtVahjWGXHPcIvG6D1R+orWbXgsDtSiHMj755d7fjyk4UPASS9H6gpwlT5ylzNzbXLAoBH5SSSdiUcfDR7gryp/eB/JcDsfvIPbzXpqNVB4nhzLzbQmjWRDzpIk/yjxYnIUXBi6tot46Umo8hAA5C88af79DJ5vdLQmp22IUrX5HLd6P0jvFuE2ij1vyxnW2ngMTbQjrL7Nzzd2HMDNGTaZdg6hCvz54aVv6rImkJZv2JtZvrGkwf6H1GkgNAs4bNqhAvWh8UInIsK6gF3Umeps1w3vzW7vDEwn8au9hmTV7EwXdNF6DaQhdRhCXsbHPo4VIeQf5q2yMjeCeJtNnVdhZJbE5udyKqWmE1paFQu8wsoosq3z48DvltiUtWt3I81j6nRonc2HLUrG8KuPRABsFNq4e4Zk/Lu3ZelSoNlGMMSG15i4U6m3zL3dxVvFylO4KAt+2iwBwuZf03z0zp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(39860400002)(396003)(376002)(38100700002)(86362001)(122000001)(31686004)(6506007)(6512007)(2906002)(5660300002)(41300700001)(7416002)(36756003)(8936002)(91956017)(478600001)(83380400001)(8676002)(4326008)(6486002)(54906003)(31696002)(76116006)(71200400001)(66946007)(64756008)(186003)(6916009)(38070700005)(316002)(66476007)(2616005)(53546011)(66446008)(26005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkFSYlcvNVAxdjMxbEdidktxTkN4TWN6THJkNnJBMUZtUk5BeXpxbzNmMnRC?=
 =?utf-8?B?KytJTEZxeFhFOHlSMDJ0VDdyclAvUWxRTzBQVlVoNmtBTmt3NDFpL3N3ZENx?=
 =?utf-8?B?U05EVjNEV0xuQWd0alJnb0pQZ1FycGI1UERqU3Q5RWx5MHhoOHBmRkI4RUlW?=
 =?utf-8?B?SVZtYnJmWFdLOWZqemxQcGhnclc2c2xPYVhpMElCS2FpMHZGTlZFR1VSaEI0?=
 =?utf-8?B?T2JYSTZYSEVnR3F6TVpzZHVlazNBQVlZM0NCS0x3aHNGVFVwYVNPREJPRHpt?=
 =?utf-8?B?alh3RVozcHNQNEFMNERBdjZPckZ0eXlTNkFaSFJpcHBuQlZwVm5OQ2lKVWpS?=
 =?utf-8?B?bUVqMEVrRlRESVlBcUFPWlRRZThYMmh5WG9rRGpGdnB5R0VJUVVpbVlkQW95?=
 =?utf-8?B?TFNtM3ZheEl1RkpOUG5sVlI0WjQ5UkNQUzgvMmMvRHFZYlZadExzU0ExQytF?=
 =?utf-8?B?N3RsQ2VrRUc0akZzWnVOQnQ4M0w1a2NKRGlTN2c0OHBrNGh3VUVyRWFrSTc0?=
 =?utf-8?B?cllSSW5WNWJ3czY5NWZnRzhMRTl4aklpVWJRNHh5OHQ5WjMxKzQzRUpnYmY0?=
 =?utf-8?B?d2w4UXF2RjUxT1I0YlVyd1JsMzhYUGgzV0w2TjhwWmRtU1lHQWhyK1V5TXM2?=
 =?utf-8?B?S3VoblZPd1ZhWjc4VHd5bm5tVkwwb21SV1JtREpGOTJJcENLeUtYU1VhY05U?=
 =?utf-8?B?eHVEcnk5YjIxMzd2NFRkdW5GcytycW5nSDlXRXFUTnNwUkg5VC9wUGlKWFRM?=
 =?utf-8?B?b1dwVnlsRVAybXkxemhtNVdUcytSM2pOVzVnZU1TcHJQN05BMXpaSDVHVGY5?=
 =?utf-8?B?ZHFBSXQvcHBaUzhRdUFPMUE5RldhMWk0YUYybVpCdmlLeThZTEFEcjY0VFhF?=
 =?utf-8?B?aTVrM0JsSUZvbFJ3UGltbWt4cHB5aFhKRS9WalFhNFdwTWJ6ajhDMXVxdDJi?=
 =?utf-8?B?NWMrTUlQTFpid0R2bm5LYmdZVnFhR1VsVksydnhlMU9zOEJ5b0RoUC9PSFda?=
 =?utf-8?B?MDNyVDFjeFFmUlVMZXRXQm4rQnpmMytSM3k4d2daTlNmZG1odG9wSkpYRjla?=
 =?utf-8?B?eXl3WldIRWkxM2drUDZxbGx1WFpINm5hN3BKZHZSUVhKYlpMNC9ySEg3UnA5?=
 =?utf-8?B?QTBIN3NKNmprWkM2SWRFSldya1J1UW0yYkNIVFpDWk10RW9BNTBvU2hHd2pm?=
 =?utf-8?B?bVJwRmtLTVZYaFNnV3p5ZitkYld5WjNFK29CM2gxWEM4YytWbjZhdnV2ZXB0?=
 =?utf-8?B?MldhN2M0aXlJZU9qZnd0a2xXSXZWb1p6OXAvQVlQS2g1ZCtDQkdqdzIvZUM2?=
 =?utf-8?B?OE10aCtwSi9aYkUvM2llZzN4SE1JQ1NrSVBTamI2MWhXd0oyaE1KWUg3Qm1t?=
 =?utf-8?B?RkIrcXE4SnNrR3J2cWUyY0dzN0xGYmwyU25FVkhVZ0YraTFXZ1YxZlNMVUVq?=
 =?utf-8?B?R09wWmpHc1ZyQjZpWWZvREVodThLZ2RqS1lhcjllTDFqRHFnb25tRnJ2eXJi?=
 =?utf-8?B?ZHpWQkw4VUlNOEFEc3lWV1JXdWFFaC9YYkxBSjd5UG8ybUc0RGhrWVpUQklR?=
 =?utf-8?B?YU5xdXBUdk16V1VwcGl5WHowVDlKVTYxZ3E1ZXp6QXhUQzFTcms0Q1R2U08y?=
 =?utf-8?B?N05aUndCQ1Evb1pESmZIU0hNMzhtblFjTmJLYXZ0NmYvVWl4Z3dmckJuREJY?=
 =?utf-8?B?Z2tILzkwRERIVi9obElHcW10MVE5djkwY25nb2ZFS3p0QjFPSWVuYWZkNE5D?=
 =?utf-8?B?YmdXWmIvQWRkTDBuajFvd0RWZnpydVVsR0oxaXAyTVJ6cG84MHNlNTY2YjdI?=
 =?utf-8?B?QWNTcjVsaWRxUkxmNkMwNndFbVVnR2dQdU5yMG9MbUtlSjJ6UzNsblFPOEhZ?=
 =?utf-8?B?RHdGRG16N3ZIL0sycE52d2xsMUtOaUVsOGNRZm5vRjhsSXoya1JYSm81U3Z3?=
 =?utf-8?B?OGdvdzF6aVJFa2E1TjVsS2E3OUk0RkZSa2tiYU8wWFFtSnZtR0taSExucFFC?=
 =?utf-8?B?QXZvYk1TUmZFMy9RZWtyNnlucWVJNkN2Y1Q2Wk8rT3Fzc2RlbHQvMG9vOVpP?=
 =?utf-8?B?NGJXbnY0TmxVcWcxNjJ1bUU5RCs5blZDTFJ1N09rZWNnUkcxbDI1bzVwSk9i?=
 =?utf-8?Q?VkW17NImz0QVrrEyTS9H5qTKC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E39649602740874BACDEE76E8103BEF5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f942d8b-6eb4-422f-ab2d-08da60bce115
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 08:35:57.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iy0DG4jNzm43vHkzmOHLUIgxUYNSVzikJBZnTvv5urHoXK8l0GcEKZub7Tw1YfpXH4nHTeB+1FQpKCBaQRl0x68e9wosgiC2wlZZEw4ERsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2829
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDcvMjAyMiAwOToyNCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBPbiBUaHUsIEp1bCAw
NywgMjAyMiBhdCAxMTowNDozNVBNICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+PiBGcm9t
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFJJU0Mt
ViAmIGFybTY0IGJvdGggdXNlIGFuIGFsbW9zdCBpZGVudGljYWwgbWV0aG9kIG9mIGZpbGxpbmcg
aW4NCj4+IGRlZmF1bHQgdmFsZXMgZm9yIGFyY2ggdG9wb2xvZ3kuIENyZWF0ZSBhIHdlYWtseSBk
ZWZpbmVkIGRlZmF1bHQNCj4+IGltcGxlbWVudGF0aW9uIHdpdGggdGhlIGludGVudCBvZiBtaWdy
YXRpbmcgYm90aCBhcmNocyB0byB1c2UgaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ29ub3Ig
RG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJz
L2Jhc2UvYXJjaF90b3BvbG9neS5jICB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4+ICAgaW5j
bHVkZS9saW51eC9hcmNoX3RvcG9sb2d5LmggfCAgMSArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
MjAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvYXJjaF90
b3BvbG9neS5jIGIvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYw0KPj4gaW5kZXggNDQxZTE0
YWMzM2E0Li4wN2U4NGM2YWM1YzIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Jhc2UvYXJjaF90
b3BvbG9neS5jDQo+PiArKysgYi9kcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jDQo+PiBAQCAt
NzY1LDYgKzc2NSwyNSBAQCB2b2lkIHVwZGF0ZV9zaWJsaW5nc19tYXNrcyh1bnNpZ25lZCBpbnQg
Y3B1aWQpDQo+PiAgIAl9DQo+PiAgIH0NCj4+ICAgDQo+PiArdm9pZCBfX3dlYWsgc3RvcmVfY3B1
X3RvcG9sb2d5KHVuc2lnbmVkIGludCBjcHVpZCkNCg0KRG9lcyB1c2luZyBfX3dlYWsgaGVyZSBt
YWtlIHNlbnNlIHRvIHlvdT8NCg0KPiANCj4gSSBwcmVmZXIgdG8gaGF2ZSB0aGlzIGFzIGRlZmF1
bHQgaW1wbGVtZW50YXRpb24uIFNvIGp1c3QgZ2V0IHRoZSByaXNjLXYNCj4gb25lIHB1c2hlZCB0
byB1cHN0cmVhbSBmaXJzdChmb3IgdjUuMjApIGFuZCBnZXQgYWxsIHRoZSBiYWNrcG9ydHMgaWYg
cmVxdWlyZWQuDQo+IE5leHQgY3ljbGUoaS5lLiB2NS4yMSksIHlvdSBjYW4gbW92ZSBib3RoIFJJ
U0MtViBhbmQgYXJtNjQuDQo+IA0KDQpZZWFoLCB0aGF0IHdhcyBteSBpbnRlbnRpb24uIEkgbWVh
bnQgdG8gbGFiZWwgcGF0Y2ggMS80IGFzICJQQVRDSCINCmFuZCAoMiwzLDQpLzQgYXMgUkZDIGJ1
dCBmb3Jnb3QuIEkgdGFsa2VkIHdpdGggUGFsbWVyIGFib3V0IGRvaW5nDQp0aGUgcmlzYy12IGlt
cGwuIGFuZCB0aGVuIG1pZ3JhdGUgYm90aCBvbiBJUkMgJiBoZSBzZWVtZWQgaGFwcHkgd2l0aA0K
aXQuDQoNCklmIHlvdSdyZSBva2F5IHdpdGggcGF0Y2ggMS80LCBJJ2xsIHJlc3VibWl0IGl0IGFz
IGEgc3RhbmRhbG9uZSB2Mi4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCg==
