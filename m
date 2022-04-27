Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66D511F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiD0PXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiD0PXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:23:04 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B909E6340
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651072790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0HmCa3q7/ABxkrA4uhaBp7q0mGa0et9jxpWWz85PL4=;
        b=fXImioSsq4gdAksbdbZkqurEjn6XJF77Z+bNhIfLdqo2+34mjxtZ/ZBIFbizJbbq6f9W6L
        TXKf9xvXDdw83eoWG4uqfdPVz6qeFzxMlj2fXyihny+CrnUO6DTSe+sF4UkkSGX+xPNVTw
        uvtf6mmMsseloTmajlMaidwR4QflVtU=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-wclqofKZObOmoUQEM5325g-1; Wed, 27 Apr 2022 17:19:48 +0200
X-MC-Unique: wclqofKZObOmoUQEM5325g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YISKl6+M+AQrhKKp69eQ/qFSddpQfYky0ma7HhrtC7AvtXQchor5ELLqUmtFYdtXjPPjS+9YHjhEX+wY5TJwkIrfXz7NjDaE1cek5tb65CVvgiCwTHym8cB3kllfQF0mdDbv5Gw6wfbrsD0fGx1/X7YnRuo9pAVBw0svqsqJOG+P6g+xkMCOZozfhdwAUm1ofpRDHPYzaMRvIsRvPTfoBV8XxOBhRwLcmvzMrIdqEAwAPxOd55mfckUbRIN9B4S/EKM33bLWM21C85iaWYFBOKadEaHG5qduVYkWTxQAHORBa1pXVZqBzMt1Ifki+aqH+rTsqidcRDTPF33IFOO+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0HmCa3q7/ABxkrA4uhaBp7q0mGa0et9jxpWWz85PL4=;
 b=BMSrKXNhsAklMduutVhWl5XQCZOoMeNp8fI1Kke0WvL3aB1mDQvC6qL1ey6zNmW7HL8hm4KjTfRcZ6C65ITo/fVW3fDu+aCX8cOtuPKpwLKabTJ8uT8MLK0/OOmaQwL8P/OSbLHREUUiHyM4YI15d7oTjswXPi3CwFTd05iekrf1PJHwkYSAeE6UV+KzLygPOB6zf3N1lfOOI/bzbhM9xi+RforN2JgmL9cZJBUgv7sZZW57t7YdsEMNac35f4rrSFK3vrb5qXJZqJ6b8mUFOFYaCWBIYjzPN2S7QujxVI1DvScnkO8hvCkbskAAA4ENgkNJzCl3HtsIwJQeu8WuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18)
 by AM4PR0401MB2289.eurprd04.prod.outlook.com (2603:10a6:200:4f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 15:19:46 +0000
Received: from DBBPR04MB7721.eurprd04.prod.outlook.com
 ([fe80::4df6:5685:b25d:93f1]) by DBBPR04MB7721.eurprd04.prod.outlook.com
 ([fe80::4df6:5685:b25d:93f1%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 15:19:46 +0000
From:   Jean Delvare <JDelvare@suse.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PING^6][PATCH 0/2] firmware: dmi: Avoid (some) empty names in
 kernel log
Thread-Topic: [PING^6][PATCH 0/2] firmware: dmi: Avoid (some) empty names in
 kernel log
Thread-Index: AQHYVOwP6bT6tjvyuE6mIS62RsNwZa0DsKIAgAA5+gA=
Date:   Wed, 27 Apr 2022 15:19:46 +0000
Message-ID: <d74f3f4b26c5620d726f0eebe4b0d14d923bea2b.camel@suse.com>
References: <alpine.DEB.2.21.2201020127140.56863@angie.orcam.me.uk>
         <alpine.DEB.2.21.2204202019380.9383@angie.orcam.me.uk>
         <alpine.DEB.2.21.2204271211090.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204271211090.9383@angie.orcam.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7afdcf3-33ed-4182-9921-08da28615d4f
x-ms-traffictypediagnostic: AM4PR0401MB2289:EE_
x-microsoft-antispam-prvs: <AM4PR0401MB2289339A9C1AE1E990A7B751A2FA9@AM4PR0401MB2289.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pJ4K0aFN6ZGaFXP8FdeY4XULf2g075AY7JOvMnvF+rWEIaeBPEhqrAZ5bdHn+TZ+qK2lyluQXAMSw4464tCzNpmsDScpqMHjTshKFvE/P+uCu9AMAf3yhS5JuvNNbO0G3SuMc9syHGwz/2+TQJu9x0q5ZZ3lrd/T7bSQRmYbx1R/FwfRpoG3MGqaQOaUmwXaF6c33RHX75wFmEft6n0CCIesTTaMlouqBGGsEGYML0Sf9ZLn01qyqvFUNeHkiWXPZ/pnwAZ0c35GF/+1Q88tb8sU3PkFxUbHOH5DMx+fCVJ9gyPSWyp+9Usjjk0SMEYaUo2toX9X8DPnZ1iJ3q8/ZqkeZcSqtIxpbTIzzU4wT5HsAZIKHDBEzaXbbAZC4LGz4+r7iWrwo4cBJ9wYsjzrUo+RVZ5YXq/EwDhV4xIODGI6rRil7PMMLOH6yge++fiOseHvyKPBuUgjtbPs9YhtJjlottnIjZPMRDJKyYFgl1drjCl9MK418P+1NJ4EVZq/62IjpvGdfLSve1gaHlx4Dj6RHURX/lVaWCSRg3KMxCqj4K/VRJmI5tcyJDIgFqDpCI9wMKFPJAtpAabg32PcMjGURtmA0YdhfYJ+dBu57lOvQCyw3+0UfpxZmlXboJZAWYH1L4/EGvay07rfkB93kUI5myZKLsUw3yvIo8bT8vHmpNId+jN5zZEbAvxMGii/vyOUgjWwThWfToEzoTauSTSVa2babsIWuIF5shqtio=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7721.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(76116006)(66556008)(66946007)(36756003)(316002)(91956017)(2906002)(186003)(66476007)(8676002)(4326008)(66446008)(64756008)(110136005)(8936002)(2616005)(71200400001)(86362001)(6486002)(508600001)(38070700005)(38100700002)(6512007)(6506007)(122000001)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW81SFR4Z2VvNGhDQmdIK3hjN05hS3J3ZndETkFuTkExS203RFgzSjlmQm5q?=
 =?utf-8?B?UmtsdnNJUkJSZHVJN2hOWmtMZGpXUVdRczI0TjdYY3NrZUZUTEZqdEx5T2Ux?=
 =?utf-8?B?eUF4Q2hERFNkVTRHekNURFpQemZKaFBUUU1DM05kTmtiNGZ2YUxBS3dFaGR2?=
 =?utf-8?B?R2JLN0F6aUZwWThFaktpVGxBVG9wdWxlVnFqVnJ2bWdzWjA4NjNzWCtzK2lh?=
 =?utf-8?B?YVZ1azRoOFRqeHVSRGFtWU9lMVFSc2lwODBzZmZzbm5OKzZmenFKOHJlOWFu?=
 =?utf-8?B?a1Y4OWEvWjZJNHFTUmhuOVVBdGlqakZQV3BpTS9VY2JJelU4MzN3L0VSTVI0?=
 =?utf-8?B?WWhhOWJFUitQWUlrTCsrU09PcHUrMS9ORDhxbUJnYlhWYjBPOHJ0Ty92c2I2?=
 =?utf-8?B?Wm41RjJTZWlJc3pVanVxc3ZodHp0ekh1TzdQMGJ6cmcyb1VvQ2hOaGtSbW5w?=
 =?utf-8?B?M1VaWTRnU0VDV3g2a3EyaGJ0T2tEV1E4Wi81V2xJQ2wrbngycVVJZGpwRE5t?=
 =?utf-8?B?ampoSU9GS2dldVhZSEVNcUR2Z0lTS0o2eURxS0dHRmxnT0VKSzBsZUt5TTNk?=
 =?utf-8?B?a1ZOZVZhODBtcnZFbytiZFFQeENvTm05bUw3YkdjRXkwaHEzcS92bFl0dDNL?=
 =?utf-8?B?VTlIejY5SHlrWGQyKzVJQkY2UVRWS1JUa3B0REFKbWoxdmJQUXlCa0U2M2ky?=
 =?utf-8?B?emMwU25NZUl1dFI1VFJEZHVYYnVhWjY5cmwwSlpzQlcrRmRYd084SSt0YlZs?=
 =?utf-8?B?OEVRZmdJY1RNSUV5NDZwQ3g4Qk9hUTBqdUk5M3VwS2F6YVpCVXlyNld4S0VY?=
 =?utf-8?B?RlFuMXdvQjI4SmtQY1FEVk9iL0p3RWZMZWNIL2RMaVpkNHczV2dRRjNOYUxy?=
 =?utf-8?B?OGlzQlhmNmdJM1pBRk12eEVIV2xORGF3K0JZM3RObVQ3b2JlY0NTMnhjdmJ1?=
 =?utf-8?B?QkE3NGphNnlkdkh6VVZJZFNCcElGT1ROL3UzYXFhSng3L0dIT05LZkdQbnQ5?=
 =?utf-8?B?Z3A3NHhTamZpTStML0t4c2Jzd1cyY2VsL01yZFl6a3RCVEtUb043OGw2NS9G?=
 =?utf-8?B?My9xdG1DVGYyZWtxbkN5UFhJNEd4ZVpNaVc5ZEY0R2ZPc0Q0YnUrV0cyTzlh?=
 =?utf-8?B?bEZrZTBWbHhqcmNoSzBSSytGdkhZbUtsMnpWMlVNQXBRek5aNFhXSVRUQTg5?=
 =?utf-8?B?MlI2WHMvNlVWcnNhckRZS1htU0xOTGtnZWIzTURacVk0dmovM1VKbzhPcUtE?=
 =?utf-8?B?ZWVFK0wxVVdhVWJ2WFhnc3ZsYXZnQzJpV0NuTGhKcFJvZVpKekt4a1UxQk1Q?=
 =?utf-8?B?V2xocmVtSXB5MEFjaFBUK3FtSWtNenBGOERqTklLUjFPOUhMbURYdnhLRThE?=
 =?utf-8?B?STAzN2NQN2lPZTNRYWpRb2haSlEwQkFuZjhBdHJtN1g2SWloZGtpUjR4Mk1z?=
 =?utf-8?B?ZEJGT2NkcjN5MkppWmFra2xud0xYNmhvOXBTZDZRYUxGYXQ1MEMySDNnZ0VB?=
 =?utf-8?B?dkdVaDlIcEpWYmpxSVJIcExxYlZ2Qi8wL0VGVFBPZUJNeStoVythNnZwZUo5?=
 =?utf-8?B?bm01bGowR2RvSVliYXBVZXFrYnlVSlVjUDBQVUxDZExFWGdmaEFteGlwVTMr?=
 =?utf-8?B?N1liV2RFR2VvczZ3ZFRVWkdGMzVWZEFMRlR3TTlFVkYzV2VYbHNmTW9mNEdO?=
 =?utf-8?B?ejRHZ09YbjBodGZ6UzdtMDVndVhIbG1PQk8zZnNKamVLdG9XOVprTVF1TmNB?=
 =?utf-8?B?cEYrdFIxanF4cDkvK2dsQ01TODRlVVd4Y3Axc3NuZUhRTGNBYTIzc015Mi9N?=
 =?utf-8?B?RG1kU0ZIaG51S01mU3owRlRHZGdjZXd2MGRhN2RjaVdsSmRJNVl4d1VtSTlR?=
 =?utf-8?B?L3lrVzY2UGpBNmZoQTN4WDl6V3htemFPRzN5bnErTnR5ZERGT3lIOVpvR0xq?=
 =?utf-8?B?dmlSdW1hL0J5elJ2TE14MlphWXRvMkl1ZEUzYmtSdkx0dThCZHd6a1VNR1c2?=
 =?utf-8?B?NlBBNjdOdWtkVFZaNVF4em0rcWp2ZzM5a09VYlQvR3ZjRDBHN201Y201ZS8x?=
 =?utf-8?B?Rk1MeDRVR1MveDIyRC9kTzNIQmNJVDlOMnI3Ykx3aEhtNFozOG02ZVZYVjh3?=
 =?utf-8?B?clp1S3prTk9NN0oyRlphcW9md2IzYUpzK2ZsYjRmMXFsTkxhK1M1SE91TTIx?=
 =?utf-8?B?Z210ZDBNRVVhL1BqSWJGa0lxangwWHlCWmsxTlNadzlzOUJQdUVrZEUvN01l?=
 =?utf-8?B?aEhvMEloYUlSa01VUDJzR09hRFI3aFMzRjFldG5McEd0ekhzRmQwMlRKMXJY?=
 =?utf-8?B?VmhqZXRoTDBrMDRIOTRzWXl0UDlGOEE4MVk3QUVGTDRQbDJvSW9LbzhoV2sz?=
 =?utf-8?Q?nYUWSYGnCywt9vvO6MhBCqXwxEamKlk7BPYRi3uKsUN2c?=
x-ms-exchange-antispam-messagedata-1: Ryyb7K7Y3zxszA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <25C73309B7E277459F1CFFAC517FF5F8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7721.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7afdcf3-33ed-4182-9921-08da28615d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 15:19:46.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afw5w7HmfxhrXLt2vyysmtXzEeNKNtlmB8w0cKgo8+9a8q605Tmfz3Q45saWN0bnfN3vQlfs7Yspt+ZqxxhoZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2289
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFjaWVqLA0KDQo+ICBJIGRvbid0IGtub3cgaWYgSmVhbiBtZWFucyB0byBjb250aW51ZSBt
YWludGFpbmluZyB0aGUgRE1JIHN1YnN5c3RlbSwgYnV0IA0KPiBlaXRoZXIgd2F5IGl0IGxvb2tz
IHRvIG1lIGxpa2UgYSBzdGFsZW1hdGUuICBJIGRvbid0IGZlZWwgbGlrZSBpdCdzIGEgc2V0IA0K
PiBvZiBjaGFuZ2VzIHRoYXQgcmVxdWlyZXMgYSBsb3Qgb2YgY29uc2lkZXJhdGlvbiwgdGhlIHNp
dHVhdGlvbiBpcyBJTU8gDQo+IHF1aXRlIHN0cmFpZ2h0Zm9yd2FyZCBoZXJlIGFuZCB0aGUgcmVz
dWx0IGEgY2xlYXIgaW1wcm92ZW1lbnQuDQoNCklmIHlvdSBnZW51aW5lbHkgdGhpbmsgdGhhdCBr
ZXJuZWwgcGF0Y2hlcyBzaG91bGQgYmUgYXBwbGllZCB3aXRob3V0DQpiZWluZyByZXZpZXdlZCBi
ZWNhdXNlIHRoZXkgYXJlICJxdWl0ZSBzdHJhaWdodGZvcndhcmQgYW5kIHRoZSByZXN1bHQNCmlz
IGEgY2xlYXIgaW1wcm92ZW1lbnQiIHRoZW4gSSBhZHZpc2UgeW91IHJlZnJhaW4gZnJvbSB0b3Vj
aGluZyBrZXJuZWwNCmNvZGUgYXQgYWxsLg0KDQpKZWFuIGlzIGJ1c3kgZG9pbmcgdGhpbmdzIHRo
YXQgbWF0dGVyIGluIG90aGVyIGFyZWFzLCB0aGluZ3Mgd2hpY2gNCnN1cnByaXNpbmdseSBhcmUg
YWx3YXlzIG1vcmUgaW1wb3J0YW50IHRoYW4gYWRkaW5nIGNvZGUgdG8gdGhlIGtlcm5lbA0KdG8g
ZXNzZW50aWFsbHkgc2xpZ2h0bHkgaW1wcm92ZSB0aGUgZm9ybWF0IG9mIGFuIGluZm9ybWF0aXZl
IGxpbmUgaW4NCnRoZSBib290IGxvZyBvZiBhIDIwLXllYXIgb2xkIHN5c3RlbXMgd2l0aCBjcmFw
cHkgRE1JIGRhdGEuDQoNCklmIHlvdSB0aGluayB0aGlzIGlzIHRoZSBiZXN0IHVzZSBvZiB5b3Vy
IG93biB0aW1lIHRoZW4geW91IGNhbiBrZWVwDQpwaW5naW5nIG1lIGV2ZXJ5IG90aGVyIHdlZWsg
Zm9yIGFub3RoZXIgeWVhciwgYnV0IHRoYXQncyBub3QgZ29pbmcgdG8NCmNoYW5nZSBteSBwcmlv
cml0aWVzLiBJJ2xsIGV2ZW50dWFsbHkgZ2V0IHRvIHlvdXIgcGF0Y2hlcyB3aGVuIEkgaGF2ZQ0K
bGVzcyBvbiBteSBwbGF0ZSwgcmVnYXJkbGVzcy4NCg0KPiAgQ2FuIHlvdSB0aGVyZWZvcmUgcGxl
YXNlIGFkdmlzZSB3aG8gY2FuIHJldmlldyB0aGlzIHBhdGNoIHNlcmllcyAoSSBjYW4gDQo+IHJl
LXJlcG9zdCBpZiBuZWVkZWQpIG9yIG90aGVyd2lzZSBob3cgdG8gcHJvY2VlZCB3aXRoIHRoaXMg
c3VibWlzc2lvbj8NCg0KQW5kIG5vLCBib3RoZXJpbmcgTGludXMgdG8gc29sdmUgdGhhdCBraW5k
IG9mIHNpdHVhdGlvbiBpcyBOT1QgaG93DQp0aGluZ3Mgd29yay4gWW91ciBwYXRjaGVzIGhhdmUg
YmVlbiBwb3N0ZWQgcHVibGljbHkgc2V2ZXJhbCB0aW1lcywNCnBpbmdlZCB3YXkgdG9vIG1hbnkg
dGltZXMgYWxyZWFkeSwgeWV0IG5vYm9keSBoYXMgc2hvd24gYW55IGludGVyZXN0IGluDQp0aGVt
LiBNYXliZSB0aGlzIG1lYW5zIHNvbWV0aGluZy4NCg0KLS0gDQpKZWFuIERlbHZhcmUNClNVU0Ug
TDMgU3VwcG9ydA0K

