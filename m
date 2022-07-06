Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F6567B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 02:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGFAvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 20:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFAvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:51:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9883167D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:51:30 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 265JLOnc020694
        for <linux-kernel@vger.kernel.org>; Tue, 5 Jul 2022 17:51:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XXL3PW7Sja+YzZQ1iMAw2L6Icg/0KjHsvh+gN+YAfa8=;
 b=okFyEqgXPqWgSJGUyQvDRysWkfJN/FRaWyTNh1lWbmi1DBIGLlfW3UHSpbdP6oRi80Ow
 +xjcmy8o6jc0J0AVbs2Pq8HmOJeFJNi5BZacr1+vKOMtGFfvi/uPTTWtcH3SGJ1Kx0Th
 F+8neQY2svAZ2rWmcqnz0/YMNGQJFxAnDvs= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h4ucjhukn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 17:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iikQR4y+sGj1AjKF9evReoDjxS2Fut3sjakEWyEYWHvCxh0nUzd0ZYe5JgswXCpPoo2NnTkNNKB5jnydM+vqaieCeI1cWOa7yokQruzd51KdTUNViH7fm02Dlk5OsmCB7nApDotTKW9H9q1y4byeTNZqCP4JmcN2gqutYOkgOi04rJcSLyRTVfQQs4gI/17K4z8CIX6qlnsUccS78YFq1ev1ytsS01JsdalecEJgEYSFqTFGv4K7b6kTlZWOmJgwv+rgyhQq75QAeDGHAv36P1dhjF2kjb2magetKvGPrYCJzuzDHFVA6tP+WrhT3l4Age2GmGt4eitFbi5dfiA32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXL3PW7Sja+YzZQ1iMAw2L6Icg/0KjHsvh+gN+YAfa8=;
 b=BB3dUeeORb0jrfi356wDdBuUA51VFRx+7Gmy4cv5XF62U95qcvuDMZH+pg/6s/t+HV13HiPLCnp9qWSL0ORs9sjhi7lpoquj/S3r2X12AFofltNl+soF4ZmkPHOKy4kkAmwjxaS9AssP8jEzrN+mpMGL6WwIGg2OPFpzRH3lmE/0t0cuSqyGjQr66XbNMs0Ea9PiQyvtPWuVFGnhx7m30W/gE9G/CYFmCaXCgBSRBxogQkzJyh8mHZ1tEnC75zTs2IC7cgDEBf+iwHadbHFXeYElwmYCopXd7XcxCDOlZqyMUPorwvfu3fyDauJngFv6MhHqsVVY8hLGXScBfV/y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB2852.namprd15.prod.outlook.com (2603:10b6:408:8d::10)
 by SA1PR15MB4514.namprd15.prod.outlook.com (2603:10b6:806:199::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 00:51:27 +0000
Received: from BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::e998:a53f:24e7:922d]) by BN8PR15MB2852.namprd15.prod.outlook.com
 ([fe80::e998:a53f:24e7:922d%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 00:51:27 +0000
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "jack@suse.com" <jack@suse.com>, "boris@bur.io" <boris@bur.io>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Modeling wait events with Lockdep
Thread-Topic: Modeling wait events with Lockdep
Thread-Index: AQHYjNXXgmWhrw5qwkm+IQi0oSCTcK1palwAgAchAgA=
Date:   Wed, 6 Jul 2022 00:51:26 +0000
Message-ID: <7ecc0429-fff8-513c-07a1-9aeaeb37fb00@fb.com>
References: <4dc41ba5-f9d4-2d26-fdec-881405029046@fb.com>
 <20220701115928.62kr7lpfs4i4ivrt@quack3.lan>
In-Reply-To: <20220701115928.62kr7lpfs4i4ivrt@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f579fed-9dcc-4c09-7163-08da5ee9a84a
x-ms-traffictypediagnostic: SA1PR15MB4514:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6rf1+5JMjQL2UwUjOYks9ON0+IYKDePMcKpappADkEyKUqIaMxkuoBa4Jho18+alXyRelGss7niWPgcfEVBe+85nJhoUwMaNHOMSs/CtPTBgOj7TzKpovmkPETbIbUgqpwq4UmNf1KpbVxZaF74yhgwdAujF4GDN88mwfXyml7UvDDsY0/b0E908VnreC3OSIYaP+dVYCvH821XYEU06tLdWFYevH4MAMPxRjenTPZD/CmgTM4z0JZaYttq/tiY3EBlE74wG73oA4ntHWW1VCDyk6FHHzdAZQ9GrXI3Rvot8KMbQb/f9JJtcbOJmUi8nn0av08A0D0sD2QQiDEbUMyY+B/0n7UKiR84K8DXU3g6KncEG2o1aGIaqGXfsc+N44ngLcVxvU+b8p1oeESGLCf7X85eIn23c8qVZji4l8qcqeB86IF1OZ2F/f7hdZ2bsUt5X9aRVrF3QAYzgt1p+EiuGW2Ir3A4bG7qdJ2M25PDFyviWatFg6RWLNywCBI05h/gUgf8MoGQ5i2/u8o2TkAYYoWzv1WEOqzU0JiM0xyiOG5k2giEIljZFrYqWgRbcBOvAFEF7Nqxx9LNuvrlWoGuZ9uchUe8psIxJJTrrFAXFcRg/hTTDniS5BQ48mwNnsoi55SHYAWagibupdK4cEzhtOHJKbulWrralL5cpaDenghyxHp5NwJTwKRp2FhhI9aDI1Axh07SPAiOnrcgMiBKZuM4cdEDRCVXlfsPazoeXDeSs0Xagmmxor+79afcx5bBT/+24oClg6s+tFMK9N6Gb22DepSj+uFqGVLMOdLuZlHZ+Cxjqo8BkfEnQLGiEtc9BXsVqOqOALyC/+ONeTI+IAH73JW0t8xZhIMO2cfvlZ6zMFIycV9INAveKoFWz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2852.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6512007)(2616005)(53546011)(86362001)(6506007)(38100700002)(38070700005)(122000001)(31696002)(83380400001)(186003)(71200400001)(91956017)(76116006)(8936002)(64756008)(4326008)(66946007)(66556008)(8676002)(36756003)(2906002)(5660300002)(316002)(31686004)(66446008)(66476007)(6916009)(478600001)(966005)(6486002)(41300700001)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzUwUXhKNXZqZThGbGpQL1VqMlFnZUZJWUFHODNjdGRnYTY1aU5menZkRGVK?=
 =?utf-8?B?bEpLR3lqcEFSaUkzNG9seVFrckdWUStrWng0N01iR3NSUkxFUmRIb2lKVkdY?=
 =?utf-8?B?dGxWcGFMMzd5aTdmcS9MT0NTcjNNV2NTbzg2QVBKU1ZXa0hLSWZZS0FoMkNh?=
 =?utf-8?B?dlIxbGcrZ0NFQWZRZzhwK0ZPcFhDSFBBQ0ltYnBPSjRsMExzWDhKaFhBWFFz?=
 =?utf-8?B?anhISkpLMkY5bzJ1YkFnVWdHL3Y0VlFDRUN6SUNKd1MrZythcGRoYzdDN09r?=
 =?utf-8?B?NlFObUdPVDNYOWp6L1hhRWZtZ3F0QUJGbTZtVnJrZ2xjNFhaaFNkZExLNHE3?=
 =?utf-8?B?WDJDRnZ0ZFdhby9lRTl3bHVSYmVtMExxbTR6VUh6WVpVS1pzWkMzdDlGaTY2?=
 =?utf-8?B?Y2YzL1F6a2tFOE1XNmlHZGh2QTFPeFB1cmRhbWFCNEVmR2pVNEJ3RktzTHpW?=
 =?utf-8?B?SUV5dDlsR3Z6SVZ2bHBMWDJEbVN0dFFuUFZmRDBvblNzK3ZLdXVyeGJCdERx?=
 =?utf-8?B?UXlLL09XRGRZbDUycUR1eWlmYVRWYnJOaHFOTW5COXRIa2xvMzdOMXFHaUls?=
 =?utf-8?B?aUM0c0RQQWR2cEs4UTlLOENKNzZPNGVjWGtOcVMrWm5vcEhzY3Z3OWxiV3Qw?=
 =?utf-8?B?M2I4TXR2L3dCNjdweU5SaS92c09vdHBGSCtsTGZpSU9JamxBd3FjN1ZQODJ0?=
 =?utf-8?B?V2R6ZCtmNm9yTWxHWGlkdzFnK1ozWFBNOGNoaGN6V2FxalQzbDZxZ0YzSTdN?=
 =?utf-8?B?Y1EzZVd3UE5rUmRsVHczRlYydjg2WXBzQTl1UkJKTmsrVmloVTdGeHd3T0kz?=
 =?utf-8?B?TDJFQW9QL1JCZXUxUUplaXgwSTVKck9Da2RTYmwvYTU5OEhGdDdkUlpBcFRJ?=
 =?utf-8?B?VE53Qmx0d05UQmNhWm5YNUFvTXlrckovb21yYW4vVUNxVml1N0E2bnVtVzNT?=
 =?utf-8?B?MXNqamxaUUJPdUlXT21neTZuMC9adThuU1VIWXdsOWNtcnJmQmUzOU1CbXhV?=
 =?utf-8?B?NjMrSzYydzFyTERWMVF2YlF5RlExNnFPT3RSY0x3aitjUmEzSnZIZEEvOENW?=
 =?utf-8?B?SU5uNy83ME1vdUdKVkFvUGFET01PNEUxYThDTUhFLzRkbW1aU0lMYkk0Y3Zm?=
 =?utf-8?B?UmEyamduYnI2TWNMeUpnYnYybzl1dVFwUWFYYzR6RU9SOG5UWjZFOWdrVEhQ?=
 =?utf-8?B?UUM5SDdielkwTFdNMUVyZGRsVytId1ZsL29XYk9aaG9waW1FYVp1VFV3enc3?=
 =?utf-8?B?NmhvMjBuRHhIVjJnZFc3Ymdibis5OVZyeWpXdEtWSDVDenVBUFcrSlVNSGll?=
 =?utf-8?B?amVTL1FmbDdWVFhYb2RTMW5RcGJRRlBLalI4d2I5cm9hM2pJUUdRVTViazlq?=
 =?utf-8?B?LzVMU2dOZE53MDBvSHlGODJaTXo1SE5QTVdWYVh5Tlk5TjgyY05nS1V1T2xp?=
 =?utf-8?B?Q0NsTGNwM2hIamxJMXgvckVESGFZZXdpS3VYNDIyNHNwbkR2WjFNRldNeTUv?=
 =?utf-8?B?QVdIZ0FmdjA4S0hmbEEreWo4R0RTNTR3MUhudVVzdFdqRTQ0UC82K0lleDhq?=
 =?utf-8?B?NXVQRytIdDIxSWtnODV2OTVSZUJVTUQ5UlY5YVh2OTBMakhsdW1XVkNwekxa?=
 =?utf-8?B?WnFMcjFUVDFnc0FHS0gwMmxaUklnb3ZUZ2tTQ1BpcjFNYnVqVkRTRkZwZWx3?=
 =?utf-8?B?L1lrRXAwRXNUZHFSVGdQSHFKNVIzYWdQL3dPNkt4bi9pTVBiU1JSeXVtVkwy?=
 =?utf-8?B?SU9vdVppS2hKMVhwYnZCWXFRVlRVU2dtY2lFMkVUZXhzSy84bGNCeGw4UkhG?=
 =?utf-8?B?cVNnc3BmaU9TUzZvSldkV2xQZUxHNVU1clVvcFoybDRCVTgyeFRyUlNVQ0w2?=
 =?utf-8?B?YWltRG96YlZsN3Mxcnl4eHkvUnlnNGovUEhsWTAxbjBqUnJJMmlzU3RGS29C?=
 =?utf-8?B?YzBhcHZsK244UGprZm1tS2ZBVjFkSTRMZHFDOVE5RldXWU85K3REK2puZ3dI?=
 =?utf-8?B?RHpoTnF0Umwxc3g3clhJWEZLL2NPNEV0aEJ5dkFzcThHQ3dYaTZrTTBEVHJj?=
 =?utf-8?B?SDlyNUI2TlRxOHdUUmhvWVFOc0JqT1dPM2VmK1lJRllaeldhSEJOZDhrVmNP?=
 =?utf-8?B?SG9MTnc3eU13dlA3V1lZK3pUVGptSFVCQnVjdW5QKzJuOUdEK0o2OWpwQldZ?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E40E03C118F9547AF2AE0C721682802@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2852.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f579fed-9dcc-4c09-7163-08da5ee9a84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 00:51:26.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26XD/Op5BXlUFShx+Yh0GtAzOt/mgDtYY/H3ZykspdyelFI4xC66EoVRp67dEzk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4514
X-Proofpoint-GUID: XLsWYQGntx56aUeiDyGPATSRSyvUZBlR
X-Proofpoint-ORIG-GUID: XLsWYQGntx56aUeiDyGPATSRSyvUZBlR
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_20,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xLzIyIDQ6NTkgQU0sIEphbiBLYXJhIHdyb3RlOg0KPiBIZWxsbyENCj4gDQo+IE9uIFRo
dSAzMC0wNi0yMiAyMzowNTowNywgSW9hbm5pcyBBbmdlbGFrb3BvdWxvcyB3cm90ZToNCj4+IEkg
d291bGQgbGlrZSB0byBhc2sgc29tZSBxdWVzdGlvbnMgcmVnYXJkaW5nIG1vZGVsaW5nIHdhaXRp
bmcgZm9yIGV2ZW50cw0KPj4gKGkuZSB0aGUgd2FpdF9ldmVudCkgaW4gTGludXggdXNpbmcgTG9j
a2RlcC4NCj4+IEkgYW0gdHJ5aW5nIHRvIG1vZGVsIHRoZXNlIGV2ZW50cyBpbiBidHJmcyBzaW5j
ZSB0aGVyZSBhcmUgZGVhZGxvY2tzDQo+PiBkZXRlY3RlZCBpbnZvbHZpbmcgd2FpdGluZyBmb3Ig
ZXZlbnRzIGFuZCBMb2NrZGVwIGlzIG5vdCBjdXJyZW50bHkgYWJsZQ0KPj4gdG8gYWRkcmVzcyB0
aGVtIChlLmcuLA0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYnRyZnMvY292ZXIu
MTY1NTE0NzI5Ni5naXQuam9zZWZAdG94aWNwYW5kYS5jb20vKS4NCj4+DQo+PiBJIGFtIHZlcnkg
bmV3IHRvIExvY2tkZXAgc28gSSB3b3VsZCBsaWtlIHRvIGtub3csIHdoYXQgd291bGQgYmUgdGhl
DQo+PiBjb3JyZWN0IHdheSBvZiBpbXBsZW1lbnRpbmcgdGhlc2UgbW9kZWxzIHVzaW5nIExvY2tk
ZXA/DQo+Pg0KPj4gSSBub3RpY2VkIHRoYXQgSkJEMiB1c2VzIGEgcmVhZC13cml0ZSBsb2NrZGVw
IG1hcC4gSXQgdGFrZXMgdGhlIHJlYWQNCj4+IGxvY2tkZXAgbWFwIHdoZW4gaXQgY3JlYXRlcyBh
IHRyYW5zYWN0aW9uIGhhbmRsZSBhbmQgdW5sb2NrcyB0aGUgcmVhZA0KPj4gbG9ja2RlcCBtYXAg
d2hlbiBpdCBmcmVlcyB0aGUgaGFuZGxlLiBBbHNvLCBldmVyeSB0aW1lIHRoZSB0aHJlYWQgaGFz
IHRvDQo+PiB3YWl0IGZvciByZXNvdXJjZXMgKGUuZy4sIHRyYW5zYWN0aW9uIGNyZWRpdHMpIGFu
ZCB0aGUgaGFuZGxlIGlzIG5vdA0KPj4gc3VwcG9zZWQgdG8gYmUgYWxpdmUsIHRoZSB0aHJlYWQg
bG9ja3MgYW5kIHVubG9ja3MgaW1tZWRpYXRlbHkgdGhlIHdyaXRlDQo+PiBsb2NrZGVwIG1hcCBi
ZWZvcmUgdGhlIHdhaXRpbmcgZXZlbnQgKG1heWJlIEkgdW5kZXJzdG9vZCBzb21ldGhpbmcgd3Jv
bmcNCj4+IGhlcmU/KS4NCj4gDQo+IE5vIHRoaXMgaXMgY29ycmVjdC4NCj4gDQo+PiBJcyB0aGlz
IHRoZSBvbmx5IExvY2tkZXAgbW9kZWwgdGhhdCBjYW4gYmUgdXNlZCBmb3IgdGhlc2UNCj4+IHdh
aXRpbmcgZXZlbnRzPw0KPiANCj4gV2UndmUgdXNlZCB0aGlzIG1vZGVsIGJlY2F1c2Ugd2hhdCBq
YmQyIHdpdGggdHJhbnNhY3Rpb24gaGFuZGxlcyBpcyB0aGF0DQo+IGVzc2VudGlhbGx5IGV2ZXJ5
IGV4aXN0aW5nIGpvdXJuYWwgaGFuZGxlIGlzIGEgcmVmZXJlbmNlIHRvIHRoZSBydW5uaW5nDQo+
IHRyYW5zYWN0aW9uIC0gdGhpcyByZWZlcmVuY2UgaXMgbW9kZWxlZCBieSAncmVhZCBhY3F1aXNp
dGlvbicgLSBhbmQNCj4gdHJhbnNhY3Rpb24gY29tbWl0IGFuZCBjb25zZXF1ZW50bHkgcGxhY2Vz
IHdhaXRpbmcgZm9yIG1vcmUgam91cm5hbCBzcGFjZQ0KPiBoYXMgdG8gd2FpdCBmb3IgYWxsIG91
dHN0YW5kaW5nIGhhbmRsZXMgLSB0aGlzIHdhaXQgaXMgbW9kZWxlZCBieSB0aGUNCj4gJ3dyaXRl
IGFjcXVpc2l0aW9uJy4NCj4gDQo+IEJ1dCBjZXJ0YWlubHkgdGhlcmUgYXJlIGRpZmZlcmVudCB3
YWl0LXdha2Ugc2NoZW1lcyB0aGF0IGNvdWxkIGJlIG1vZGVsZWQNCj4gZGlmZmVyZW50bHkgd2l0
aCBsb2NrZGVwLg0KPiANCj4+IEZvciB5b3VyIHJlZmVyZW5jZSwgaGVyZSBhcmUgMiBleGFtcGxl
cyB0aGF0IHdlIGFyZSB0cnlpbmcgdG8gYW5ub3RhdGUNCj4+IHdpdGggTG9ja2RlcCBhbmQgd2Ug
d291bGQgbGlrZSB0byBrbm93IGlmIHdlIGFyZSBvbiB0aGUgY29ycmVjdCB0cmFjay4NCj4+DQo+
PiBJbiB0aGUgZmlyc3QgZXhhbXBsZSBpdCBtYWtlcyBzZW5zZSB0byB1c2UgdGhlIEpCRDIgbW9k
ZWwsIGhvd2V2ZXIgd2UNCj4+IGFyZSBub3Qgc3VyZSBob3cgdG8gYXBwbHkgdGhlIG1vZGVsIGlu
IHRoZSBzZWNvbmQgY2FzZS4gVGhlIGNvbW1lbnRzDQo+PiBpbmRpY2F0ZSBvdXIgY29uY2VybnMu
DQo+Pg0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiBTaW1wbGUgQ2FzZToN
Cj4+DQo+PiBUQQ0KPj4gcndzZW1fYWNxdWlyZV9yZWFkKGxvY2tkZXBfbWFwKTsNCj4+IGNvbmQ9
ZmFsc2UNCj4+IGRvX3dvcmsoKQ0KPj4gY29uZD10cnVlDQo+PiByd3NlbV9yZWxlYXNlX3JlYWQo
bG9ja2RlcF9tYXApOw0KPj4gc2lnbmFsKHcpDQo+Pg0KPj4gVEINCj4+IHJ3c2VtX2FjcXVpcmUo
bG9ja2RlcF9tYXApOw0KPj4gcnN3ZW1fcmVsZWFzZShsb2NrZGVwX21hcCk7DQo+PiB3YWl0X2V2
ZW50KHcsIGNvbmQ9PXRydWUpDQo+Pg0KPj4gQWR2YW5jZWQgQ2FzZToNCj4+DQo+PiBUQQ0KPj4g
cndzZW1fYWNxdWlyZV9yZWFkKGxvY2tkZXBfbWFwKQ0KPj4gY29uZD1mYWxzZQ0KPj4gLy8gZXhp
dHMgd2hpbGUgaG9sZGluZyB0aGUgbG9jaw0KPj4NCj4+IFRCDQo+PiBjb25kPXRydWUNCj4+IHJ3
c2VtX3JlbGVhc2VfcmVhZChsb2NrZGVwX21hcCkgLy8gV2UgZG8gbm90IGtub3cgdGhhdCB3ZSBo
b2xkIHRoZSBsb2NrDQo+PiBzaWduYWwodykNCj4+DQo+PiBUQw0KPj4gcndzZW1fYWNxdWlyZShs
b2NrZGVwX21hcCk7DQo+PiByc3dlbV9yZWxlYXNlKGxvY2tkZXBfbWFwKTsNCj4+IHdhaXRfZXZl
bnQodywgY29uZD09dHJ1ZSkNCj4gDQo+IFNvIHRoaXMgaXMgZGlmZmljdWx0IHRvIHRyYWNrIHdp
dGggbG9ja2RlcCBiZWNhdXNlIGxvY2tkZXAgc3VwcG9ydHMgb25seQ0KPiB0YXNrLWxvY2FsIGxv
Y2tpbmcgc28gd2hlbiAicmVzb3VyY2Ugb3duZXJzaGlwIiBtb3ZlcyBiZXR3ZWVuIHRhc2tzIHRo
aW5ncw0KPiBhcmUgZGlmZmljdWx0IHRvIHRyYWNrLiBIb3cgd2UgdXN1YWxseSBkbyB0aGlzIChl
LmcuIHdlIGRpZCBzb21ldGhpbmcNCj4gc2ltaWxhciBpbiBmcy9haW8uYyB3aGVyZSBmaWxlc3lz
dGVtIGZyZWV6ZSBwcm90ZWN0aW9uIGlzIGFjcXVpcmVkIG9uIElPDQo+IHN1Ym1pc3Npb24gYW5k
IHdlIHJlbGVhc2UgaXQgb24gSU8gY29tcGxldGlvbiBmcm9tIGEgZGlmZmVyZW50IHRhc2sgLw0K
PiBjb250ZXh0KSBpcyB0aGF0IHdlIGRvOg0KPiANCj4gVEENCj4gcndzZW1fYWNxdWlyZV9yZWFk
KGxvY2tkZXBfbWFwKQ0KPiBjb25kPWZhbHNlDQo+IC8vIHB1c2ggdGhpcyBhcyBmYXIgYXMgaXQg
aXMgcmVhc29uYWJseSBwb3NzaWJsZSBpbiBUQSB0byBhbGxvdyBsb2NrZGVwIHRvDQo+IC8vIHRy
YWNrIHdoYXQgbmVlZHMgdG8gYmUgZG9uZSBpbiBUQSB3aGlsZSB3YWl0aW5nIGZvciBUQiB0byBk
byB3b3JrDQo+IHJ3c2VtX3JlbGVhc2VfcmVhZChsb2NrZGVwX21hcCkNCj4gDQo+IFRCDQo+IC8v
IFRlbGwgbG9ja2RlcCBUQiBoYXMgaW5oZXJpdGVkIHRoZSByZXNvdXJjZSwgcHVzaCB0aGlzIGFz
IGVhcmx5IGFzDQo+IC8vIHJlYXNvbmFibHkgcG9zc2libGUgdG8gYWxsb3cgbG9ja2RlcCB0cmFj
ayBtb3N0IGRlcGVuZGVuY2llcw0KPiByd3NlbV9hY3F1aXJlX3JlYWQobG9ja2RlcF9tYXApDQo+
IGNvbmQ9dHJ1ZQ0KPiBzaWduYWwodykNCj4gcndzZW1fcmVsZWFzZV9yZWFkKGxvY2tkZXBfbWFw
KQ0KPiANCj4gSXQgaXMgbm90IHBlcmZlY3QgYW5kIHNvbWUgZGVwZW5kZW5jaWVzIG1heSBiZSBt
aXNzZWQgYnV0IGl0J3MgYmV0dGVyIHRoYW4NCj4gbm90aGluZy4NCj4gDQo+IAkJCQkJCQkJSG9u
emENClRoYW5rIHlvdSBzbyBtdWNoIGZvciB0aGUgY2xhcmlmaWNhdGlvbiBhbmQgeW91ciBpbGx1
c3RyYXRpdmUgZXhhbXBsZSENCg==
