Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3658BBBB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiHGQBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHGQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:01:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C2C6140
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659888081; x=1691424081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oV2Oy9mdGE3WeKN1nVfDGqfcz+YwRRys8/JrUc+LsPE=;
  b=eKL0U6eEcXP4Z2nh2c+tEbLugIA4gurjhu2NjjaVctmZf9A7e69FjdFi
   CC8/EHYs2W6CdwejGKQYz0j9Tv9APf8iTF09G4QYkFVMC5VL9lku3yB+i
   KgCArivtgelYwr4Kr2NlatVBhQA55yxRE0+iylyTdEl6zxqfXTKhln/DS
   SzBvWR1yHlzR5U6s3mji2uHqek+/ImPkIPBSHK7bSYqFydNqJXpb9aBp/
   U/gm9wnH0TYtD28TYIbiEdXyUrODZx8x+KpgdyQgikLjmNhHzuuxv0xI4
   MCO6/bekpRrr5E1PhskEqca4AYpP8C+EMEowBadEy+i/PUKROw7ktnqXy
   g==;
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="168186066"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Aug 2022 09:01:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 09:01:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 7 Aug 2022 09:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6lHZ3sKxE7r5vupjyL+yMFnm9+X7W0eY0eZLTHCmmLFv56ZodSM7OODICEKiKI9VNPgo1vG3mxTdPEtLfqMrlAwS/QOeujQz+phrOtHZJvb8O/9/MUPT7CKVD7HYC+YBgVPuBBlcVNF5/q+5VTrzkr3IW3dEQt21nMAnJGNzWq1fiX3v1L6+L2VT72sZl1TK6v73LzRQ0OKKBnrb60U7QvcMT+EUexaTyYXRY7j88csZLeqvrzw0UAbezr4FIveOg28O6fS5yWrJ0JTXVxd/Bb3D0cBlHjTcBwM5mZXOzxI5wAugz4+CgJXRP13AqVZZHK819L0nlZpl3tpqNEwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV2Oy9mdGE3WeKN1nVfDGqfcz+YwRRys8/JrUc+LsPE=;
 b=HZeaz9nZ2AsGWtQZ9n3noBD8bSL/qgQkwzR5xGtFhCXnrFXU9C8KPXX+MRYhGj3pFEQMsN29DqHAuuUg1Li7FdHogrKfSytNadx7a2/IBfDU8r7xP6AMcupOfbvmPXmBz7UIn9qu4x36nbc6CN7sfWdS0ZR6iebqP7RbNDcU4s1g+KSdi5dpCk/mqDGmktkSZyJ5jDH+T3tHlaXPjT43UPi0ho1WM4Wwcah39Aq+o50ys9mnmzFVxUT2LJUxSiuJUUJtV+GMIAD4v4HXxeqP+6sfxZ7GJpsgFvpnbtV6B16MJdkmNM0bX2cY5hXC5SJC7m438bL0nkwQ4nLh0rxs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV2Oy9mdGE3WeKN1nVfDGqfcz+YwRRys8/JrUc+LsPE=;
 b=mg2gMkF7S3bFAgVpI9W1S8wYrpB0tjIcLJyZ5Qoe1b1+f99ff/moPDYqPYodld2iKYO+uAt03metUvelNX/M5b1cSpg175Sj2T+OGKVg+gprjdQ4Qu3qy2/mL3nxA1Zpazi9clRCZmCEAcRapZk3ZM4Vukt+ZUI6PI0xFP7q8w4=
Received: from IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 7 Aug
 2022 16:01:16 +0000
Received: from IA1PR11MB6467.namprd11.prod.outlook.com
 ([fe80::6855:a21d:18b0:4d50]) by IA1PR11MB6467.namprd11.prod.outlook.com
 ([fe80::6855:a21d:18b0:4d50%6]) with mapi id 15.20.5504.019; Sun, 7 Aug 2022
 16:01:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <tom@tom-fitzhenry.me.uk>, <p.yadav@ti.com>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2] mtd: spi-nor: siliconkaiser: add support for sk25lp128
Thread-Topic: [PATCH v2] mtd: spi-nor: siliconkaiser: add support for
 sk25lp128
Thread-Index: AQHYnNkKComMZVmO40SH149hyPIBfg==
Date:   Sun, 7 Aug 2022 16:01:16 +0000
Message-ID: <a6c6911d-15e7-56d9-0ced-d3d87c94acf6@microchip.com>
References: <20220603141603.145777-1-tom@tom-fitzhenry.me.uk>
 <dd516981-4d1b-acdc-c468-cbb14d34f68c@microchip.com>
 <8757e6d6-666b-433f-3089-621e7c80cf9e@tom-fitzhenry.me.uk>
In-Reply-To: <8757e6d6-666b-433f-3089-621e7c80cf9e@tom-fitzhenry.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4271d5c2-da42-43ff-72b9-08da788e0f47
x-ms-traffictypediagnostic: DM4PR11MB5440:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: snmU2jJiyLtrthLiUL3y+SpOjysLwGP8H4amypAGhLtiQJ/Ehtbw09zzhuJFdf6K+tHMGf0mcVOXH7RiYGyJEQgcry7/dQkqr5gP9cBqyuQ8UaTm16C7loKDe0LPq3eLm0KxuLNTTXvJI0VENdOpN64FsJUUnnSOj6TVYCj7z9mEPO9rFNRr6hvOB6B83dWk+/bid8TZ8HWrWcOuz4VDtnm1yYn8KdlKcgCiVr3Lft1b3EvFDvFcWzo8oFRXbfB4xkpmFDf/4lC/kNPxKYSLFsnv0RNMnDWwXHUHCWzLdbRFNBBlqKmMD931T6kHDs53ERgevdQs+DhQes6SqxmVYd/jD7rvQU/zThmvDy4Nrm8EIkMhuZY7rDCKLMTVHScT+mHSkP1w0KwxUg6k/F+9M3RAKk4UwoNsn14KreRqx7ogkNboq+mKoaiQlJeYkneALBIHoNrj2TYA6w5/OJMr1Ri4JZjp91fPRigEcA5cCkwiDsk6YGNZ+iWZHur/yvXPD0VEz+mP1WACbNV3nAqfE9D+lOIAMJ6QvEEQ7GDk2rzsRKsPw9PDwpll8M9B+zbtnjY3bQJv+nX7uu57WjhFc9Z++rKlZtwXXtCnFNPl/g4Gl3+0VmHDUkhwfe1QgxUwC/guwSnaHZq/zd5sKCk0ur+QBJfydwBMfCXjbPgM9pISML8onqCi+mjnbzmF2wWRbFRC4lXxcktWtHhMI6rhqdY20X82JRo1HJKC+SUHmVtWstkS4SlTu5aVw6sA/NiuAvWsojnfl3COHXi5BZU86DgnUJBdKIv7Lxe+BM00MQc8a6Gn6hVyHkDv85z4kGxiI0RbGBr/mPYpjMKHNyBTBxwRSsJquUzXHcSFlvxAuT3CmLkPkbEZlBgK+F6uqZgMzKW0uPmK/dD6vu+bR7PTKr+ly1yVtscvH+O4nBUCh4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6467.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(376002)(39850400004)(136003)(71200400001)(31686004)(5660300002)(26005)(966005)(6486002)(478600001)(41300700001)(31696002)(76116006)(64756008)(8936002)(66946007)(66476007)(66446008)(66556008)(38070700005)(2906002)(4326008)(8676002)(86362001)(110136005)(91956017)(38100700002)(122000001)(6506007)(6512007)(186003)(2616005)(36756003)(53546011)(316002)(54906003)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFZsajU4WTJPMmJiLzdZRFZuZnkzVFJVa1F3Y25UOGVJM2lRT0ZoTnJwekxS?=
 =?utf-8?B?WFNHQms1enlzdk1MMG9xSHVWWG5qWXljU3FUMGE1YVdKdUpMcWRmRkVPTDV0?=
 =?utf-8?B?c1Njandsa3hpaXVqQkNwY2E0bitsME9lQysvNU00UGE2RytGMXpoUkpjbFpE?=
 =?utf-8?B?VW5UQ0xseE1KazVFTHE2NjN3Wm9vZWdzMElDVThEbllRUERha213Y1RPSEVk?=
 =?utf-8?B?bG1CQ0VMZ1MxRVljaGdWTDdLWnd6M3BnbGhXU2JkcFltRXFkOU1OWnBpQmtl?=
 =?utf-8?B?ZGxPY2RJQy82TlFyc1pGRjFFSmxpenM3MVYwUUNNd3VBRGltNG9yMDdPYis1?=
 =?utf-8?B?RzluamdaWEVpYUh6NEhaOWJwV2hUTGZkM3pUUXF4NlJnamxxTGo2U3B2V2dr?=
 =?utf-8?B?WkFQUllYM3ZrN0pMUUFhSnhOUllJUHZtZ0k5Y0plZmRIUGJ6KzkwMzB0U2tv?=
 =?utf-8?B?SWcrTzU5WFZCRm9mVm1MWm44R2lPQjJUMVhnMCtPTnhpZWgxMzVvWWlOMTNy?=
 =?utf-8?B?dWtqeE03R0xKbElmODdhM3hQaUJRUElVUVBaa0VDcGhMWmhTYTlWMU91Q1pN?=
 =?utf-8?B?SDBLOXIwOXlEQzl6UHNlNERMcnNYakUwYVdod1EvWHpBTmJzT1h0RERxSm5r?=
 =?utf-8?B?TXNGWkYvWHpvMHlCZTRoTjQwKzhUZlNnSlpVcmZSSXhESUhmZUdRUXJySmUv?=
 =?utf-8?B?a0RKaG9KQy8ybitHQTV5dldSc1MvUHAwNE56QllNbjdHRzRSdkZ3MHpnR1ZP?=
 =?utf-8?B?OU9FbjJtOFRBR21Ec0RRekVMTFUvWFRJR1BSczV6bEkxR0VQTHJ3S3duWnU4?=
 =?utf-8?B?MXRESk15bUwxeitGbnFaZ25iT1FETmJYc2poeVdHNkYrY0lVSGJEWS9Nejgy?=
 =?utf-8?B?T09xVWZmSjJ0dFZIcEpzOFczQUtFbDlzVTZ1UWt5c2tUVDB2Z0g3bE9lUHV5?=
 =?utf-8?B?Skk5ektLWm54WkozSVhpVDAyMDJFMzdZTTd2aXR6c3ZGMUdHNnhrS284aTJU?=
 =?utf-8?B?UVdTVXI5RWRqZnhSbGFkL2MvdVB5V3JzQkQrR3ZNYzNnT0hENTU0aVdMUWtw?=
 =?utf-8?B?d1c3WFJLZUhja2lvRVllVCszQzJORThpNHdrUGVEcW9ZQ295aFJMQkZGV1dW?=
 =?utf-8?B?SU1uS3J1MEVycitCMndsUkxsZi9WSkl1Z3VhbEtMUVpZbGsvSkNzOTVUbUI3?=
 =?utf-8?B?SUkyMmpkbTQ0b05JS3QzSlRnTFcxMmNyMnFhbVM5OHQrbTRnR3ZnUHNIbjA2?=
 =?utf-8?B?ZkxjSktOeEtNWS9SeXpFYmVOV3lOcVpHdVdDRjlpbCtVWGxvTGZFTXZkMVpm?=
 =?utf-8?B?SHQ5bHdCMThJQ1VJUEh4cVZXV3ErdFcxVldFckZsMlR2VHh6Vnc2Q2lrZjBj?=
 =?utf-8?B?ZFhSUlZ6dVNxMGZ6MkN5TmpjWlQrNDQ4TDhJbWRHY3RNUHpDd1lvdUpJTmZw?=
 =?utf-8?B?MUU1SFRPWVdDckdkcFZhWldnZU8zZi9MYkZUZFJkL2tZbFBjSkxUQlJqVlkv?=
 =?utf-8?B?eHVXMTA2aGxCYkxCMTREUVowZ2NyVzhPblQzZkJmMWdEZ2FJeEh5aGowZWFx?=
 =?utf-8?B?OUlnSkRPT3dHMFB0NkJOWlp3MHVrVmROTmdRQkx1djc0T2VxZkNwVmkzZk9Z?=
 =?utf-8?B?Ty83NWxaNzM4aUxYS3hiTUp3cGJNKzcrdFZ1YU02a0Q1azNpQjFrWmRwNzNP?=
 =?utf-8?B?Z01oMXY5MklhNnlJbTJ2aW8zdytjWTR3dFdtN0lwc05tODdqaE1IRW5yb0tm?=
 =?utf-8?B?WFpjbHRYamNCenEyQk9rRWFvRXZqYUFXZHZmZ1NiMDlsOXI1bWd2MXIrd3Z0?=
 =?utf-8?B?T3dEZ0xDQTJYNnhDZEIrZzMyQkJmQWdkOHIrT1VwTVlEWXJwZ0RTVG1zSHZq?=
 =?utf-8?B?dVNrWTFrUHBjdzc3aFBXeTJYZ3I4VUN1RmU4cjFOcTkrTWo3RnAvUTQwVW9N?=
 =?utf-8?B?ejE2Z05yTGVNa3lrZmZsRTZoMlFqeVhub2NVSGtUTzlqT1ptYXRzWmRIeldI?=
 =?utf-8?B?UGxJaWtXVlFlN3lLdGRLNUx5WlNrQmplQUJ6RTI2K2s3andBWDlDaFUrSmVO?=
 =?utf-8?B?cVVOMEpPM08zL1oxR1RBaURaNi91QTBGUFBVS1dDSGZCZEhCUW4zajM3Situ?=
 =?utf-8?B?cTQyN2hyTnAwZWlWOTlhMDkxSGRZTzZVay9xcEJ5KzZYdEtlVCs5a0JvRDMz?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50DAB35BDC385A46B20DA59CD1BB6581@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6467.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4271d5c2-da42-43ff-72b9-08da788e0f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2022 16:01:16.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6g5T5+gysol6GCs8ZkBMjxGzUL6oAkGrWanJLQ6sih79XuaPWuja69IxfyrQWFNaiYO3JLTonbDHvcW359VruztWXTjMcBBL8Q3iC75xG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC82LzIyIDE4OjIyLCBUb20gRml0emhlbnJ5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIxLzcvMjIgMTg6MDgsIFR1ZG9yLkFtYmFydXNA
bWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IERvZXMgdGhpcyBmbGFzaCBpbXBsZW1lbnQgdGhlIG1h
bnVmYWN0dXJlciBJRCBjb250aW51YXRpb24gY29kZXM/DQo+PiBDYW4geW91IHJlYWQgbW9yZSBi
eXRlcyBvZiBtYW51ZmFjdHVyZXIgSUQgYW5kIGR1bXAgdGhlbT8NCj4gDQo+IEknbSBub3Qgc3Vy
ZSBob3cgdG8gZG8gdGhpcywgYnV0IGZyb20gd2hhdCBJIGNhbiBnYXRoZXIsIGZsYXNoIGNoaXBz
DQo+IHRoYXQgaW1wbGVtZW50IG1hbnVmYWN0dXJlciBJRCBjb250aW51YXRpb24gY29kZXMgcmV0
dXJuID4zIGJ5dGVzIGluDQo+IHJlc3BvbnNlIHRvIFJESUQuIElzIHRoaXMgY29ycmVjdD8NCj4g
DQo+IFRvIGRvIHRoaXMsIGluIHRvb2xzL3NwaS9zcGlkZXhfZmR4LmMgSSBzZXQgYnVmWzBdID0g
MHg5RiwgYW5kIHRoZW4NCj4gZXhlY3V0ZWQgdGhpcyB3aXRoIGEgbGFyZ2UgcmVjdmJ1ZjoNCj4g
DQo+ICQgc3VkbyAuL2Eub3V0IC1tIDYgL2Rldi9zcGlkZXYwLjANCj4gL2Rldi9zcGlkZXYwLjA6
IHNwaSBtb2RlIDB4MCwgOCBiaXRzIHBlciB3b3JkLCAxMDAwMDAwMCBIeiBtYXgNCj4gcmVzcG9u
c2UoIDYswqAgNyk6wqAgMjUgNzAgMTggMjUgNzAgMTgNCg0KaW5kZWVkIGl0IHNlZW1zIHRoZXJl
IGFyZSBubyBjb250aW51YXRpb24gY29kZXMuDQo+IA0KPiBJdCBsb29rcyBsaWtlIHRoZSAzLWJ5
dGUgcmVzcG9uc2UgaGFzIGN5Y2xlZCwgc3VnZ2VzdGluZyB0aGlzIGZsYXNoIGNoaXANCj4gZG9l
cyBub3QgaW1wbGVtZW50IGNvbnRpbnVhdGlvbiBjb2Rlcy4NCj4gDQo+PiBJZiB0aGUgZmxhc2gg
ZG9lcyBub3QgZGVmaW5lIHRoZSBjb250aW51YXRpb24gY29kZXMsIHdlJ2xsIG5lZWQgdG8NCj4+
IGFkZCB0aGlzIGZsYXNoIGluIGEgSUQgY29sbGlzaW9ucyBkcml2ZXIuDQo+IA0KPiBJIHdpbGwg
ZG8gdGhpcyBpbiB2My4NCg0KTm90IHlldCwgcGxlYXNlLiBMb29rcyBsaWtlIHlvdXIgZmxhc2gg
ZG9lcyBub3QgbmVlZCBzb21lIHNwZWNpYWwgaGFuZGxpbmcsDQp5b3UgdXNlZCBqdXN0IHRoZSBT
Tk9SX0lEMy4gSWYgc28sIHRoZW4geW91IHdvbid0IG5lZWQgYSBmbGFzaCBlbnRyeSBhdCBhbGws
DQp3ZSBjYW4gaW5pdCB0aGUgZmxhc2ggc29sZWx5IGJ5IHBhcnNpbmcgU0ZEUC4gU2VlOg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbXRkLzIwMjIwNTEzMTMzNTIwLjM5NDU4MjAtMS1t
aWNoYWVsQHdhbGxlLmNjLw0KDQotLSANCkNoZWVycywNCnRhDQo=
