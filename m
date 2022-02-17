Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CDB4B9D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiBQKpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:45:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiBQKpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:45:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C25294105;
        Thu, 17 Feb 2022 02:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKlkTkzPcQKS91gumc0MPylKH+sRENLYbjdj6Kd7BiuOAZlpJ3zbhYiIhsUpdngCuTdaew+BPtrT6FDUkMyRNa7uLWCBT3VCWrJpUEcsmTbPUHmNyg6x4lgEB6BlTIwTtWHj00prltAmNsMGnRJ3eKGaFZEUp6tquPyk1tzuNyL7ThPaiJHB1aobVYdhFDXL6cJjTovu55+/Qsg/O6H5VixjJXluRI6R/incu7Em4R+0BzhSHGDetgwGqaqhUFxwGN1uQuAgaWU4piMvh/B/w4t0oc3GsVyei/KZs0XtXim/dovWX6c5jEWFpQXcx5VZPRWXVDu2bVjVdkZPggJaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQEKmElfesErMmpzQbzrZ26b7KyTX6t/1T9DXboo1Gw=;
 b=n7QWV8WJrvnA/Z5PJh0yt32u4/Idol7nfedMIdDqxbo9lyxPcY/jusqnYFpSBhbQKm98z/oz52HsBPa1Bk624YXY0qd/D+HPk4JXHWMoxqszWy9G2n6D2bWD9on41FmBpBMtbyWwj1X9QMjJCP3r4GZJo5YajbU8RXUNIKpxpivzy2yv8l5JbiadKlUesSrF9aKtxhA/avKPmDn2uUrF6s0UPDYRPOVzXQAg3+12A5mpUeT0C2Ycs+Mcli1XNcLdlRNbCXaB2bHF2Xlhsh8WamTR1o5yvuzNEaVkzTQ4kb0mdzKEXTCB7dgOZErnn+srsW1WwV5x2w1exEEOCnstmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQEKmElfesErMmpzQbzrZ26b7KyTX6t/1T9DXboo1Gw=;
 b=gZPTKo91rwH3jnG2aJpBSL7/pLirwry610x/3+1XkLUTseKZJUj5FTvayW5aye81t/I4ZJMOdEbiAxQrDw+13nqlWmnOLXXWNbC6KXUUcDIqj0Qz8XRmYPN8h/kHFmzKdP5n1M+2Mq+APTFCarqiC8egKtgQ64v7wnoCPMi/FDHHgLyuhsg3Ud/eo50cnBh8nso3kuCRFud09F1sjA8nv5bcRZrR9WPepDvBNrmV18DpG6qzMzftr4s1vEWSZsFiCVjjPQUq+hCzHi6OVQKZEOmuaObW5UBSOczLcnUUOnwkNx3U/2gLTY8bPOoS8aVjGw4h7yWAUB2lIA3lYf9EDQ==
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by VI1PR10MB3309.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:13b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 10:45:14 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f909:2310:3487:4150]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f909:2310:3487:4150%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 10:45:14 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit
 DV
Thread-Topic: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit
 DV
Thread-Index: Adgj6sm0fdOjTCg/QgK8Vejl3021pg==
Date:   Thu, 17 Feb 2022 10:45:14 +0000
Message-ID: <AM4PR1001MB1378023FB7411DD0E6A18CD3E0369@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05e419f5-4e9a-4ff6-d20b-08d9f2029466
x-ms-traffictypediagnostic: VI1PR10MB3309:EE_
x-microsoft-antispam-prvs: <VI1PR10MB33092F0151A068AF2FD21E14E0369@VI1PR10MB3309.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SvMJGayQrKD8nhLaMMbvy26t0u+LBSZ/7DjyOeVqQlZ6uw0w0WH1w8iwL0eNofuw6An0ISe7IczZExQLBhLkbE1/qedIywDJ3Y1aXtxbFqz94CaD4Wt72RioINdxrgU4bH1KsJOfgZRH6j0VuYSXAxnuazBKZW1kVHYsKZz5n0JYIk6Rr8MNuCtYszW9JrxzJ2ePY1UgHvJn7Terw9AYV8OHmq1t7fNyJLXkHQiliPl7LrMKpDW1h8B8toKrg0ELGo/nCg3jSsvBZVrIz8eeWwp/fcpUBXAXzpfeKPqN2K+OZM8klLuAMxkTdjNMIuDQcqnAninyZZCQuJz1qqqV+2Mhl5hbwy6PJ4wB6MA8CYxKcoSUKb7FDmKd0rQ37igpypNz3uVtfIcz6ZVlV9H8wljNDud7UK2b3l7OeUvmUomJhiMy9Jq2BKeGW9CTnnwPOKgPqGb/Ha5qT8ZGkHrn/WjyzObuhqfp05UgTFaNZi5UzUuJugqbO80uBw1flnLo34xWfG+JGc7/BA6Zj5cALl0YCqIz2Odx6PC8L3HfT4698Bd3DTN0zynjxoey/y74jDkQ4lOxhrIogWwPsOm/4KBMagy7Syfa6LQBwfgMaAL1ZFsY59BcgsNIUWxgCSeSkOh1l0JgvUmQck89/4pF5KGoSsncG7cy47lhnzimlOx9U19/uP5CIBATHy+6EDzQ5lg7SXBknfNB/Q5AoCE/7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(66556008)(66476007)(66446008)(76116006)(316002)(33656002)(8936002)(54906003)(64756008)(71200400001)(8676002)(6916009)(6506007)(7696005)(4326008)(66946007)(508600001)(86362001)(55016003)(186003)(26005)(9686003)(38100700002)(55236004)(5660300002)(4744005)(38070700005)(122000001)(82960400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG10UkRsTkhaemFtM0JkOTJ5aW1CbFdGSFBqc0oybTk4eGY4T1VUNVpJWENh?=
 =?utf-8?B?c1c4eHMwL1R1eW1nNEwwdlNRUWFkb2J4eVZ6eHp5aVp4TnlXV3QxSzlJeitP?=
 =?utf-8?B?U1N3SURneWluMXJKOW1VL08weEI4ZzBzT1JVODZwNEwzY05MMzV3c0FIQTZJ?=
 =?utf-8?B?cThSWXZEYnZaWlZSM3VwOW85b2tZQ1NHSUdnM0VMK3dacEtENWxvaXhWWVFV?=
 =?utf-8?B?R1MzWjc5YkV3b3d6dVNkcE5ac0ZBVTVOYUpZMVNtYzVRRXZwZzdScmNzdGpZ?=
 =?utf-8?B?VnE0M3pXSXJJYmkvbGtWd2pMN0FtZFl0TnJJN3NIb3RRaWxjeGRibkEyM1BW?=
 =?utf-8?B?YVVKTFVaemJCc3RpWmhLSmpEeWQ3Qzh1Q1dkZDViZ2RMWGRwRk9SenBqWmdR?=
 =?utf-8?B?bDFBWlRFdHN4ZXZmVGFSUzVaQm9oMERrTzYzZlFlWWxWWjRFczg0clNyMS9U?=
 =?utf-8?B?NnJsT054QjcwdVNOWWFiVXRmL3VkWGZNazFFVEU3OFNYdi9lTUE0a3pSWE45?=
 =?utf-8?B?QWJWbEs2dFhaZ0RLZ3JlcFZkSndPN2ZKUkwxQ0dlWGtIS1ViTklESFRwYmVv?=
 =?utf-8?B?ZGQ2Y2NLbndQZDB2KzVGWXVEb3hYQTVtMEtyZUlxS0hYNTVOZkhLbWdOMGRF?=
 =?utf-8?B?YkU2OUlnUUIwQ2dFNUtKeUdyVVowYkYrWmZoZ1daS0kvSXR6OEdINDJkK3dJ?=
 =?utf-8?B?dnMydFkxenBIM0FuUURBRkV3YUVTc2JFSndYY0VuVEp1UlJ4RlU2di9IdG1j?=
 =?utf-8?B?WHpiU2hxQ2JXYkpXeTJKajNRaDlMOTRWTUg0OHlhVVkwa2ZZQzFXOWx6eGhp?=
 =?utf-8?B?ckZZQVZnMUx6dkVGYzZXeTFDN1ppSEoxbVVCR2t3RDFyWGtITW1uKy9Ha1BF?=
 =?utf-8?B?SzhRcitGNFpycUR5RG94T0pwVFJwR0l1UTg5SjNjcXllMHZhM1R3bDBoRUFv?=
 =?utf-8?B?OStRWEhXemZzZ2hxYWtBRW1EeFZIcnFlN0lPVUsxVmpLejBkTGszMG5qTGEx?=
 =?utf-8?B?blJZLzFMd20zMWN3YS93ZS9lT0Vybkl1YmhYdEFxbjZ3NnRENWRlbTNmK0tP?=
 =?utf-8?B?UmFWYWFYaVJkdWlza1BwYXJFdVZmSEtSRm5hVzJDaHROY2MzLzR4U1FHaXZh?=
 =?utf-8?B?TElQRlNQODh5SHJQTHFCZjdLZWpNR1FRNCsvbjJUdThDY1JPTUMwTjNPOUo3?=
 =?utf-8?B?SjFlRUIra3dlZlNEdS9kd1lWZUJTeFFNVHB0VW1mOFpUcjBGU1dibzg2LzM3?=
 =?utf-8?B?dE0yWlNVWmtxTW5scDZ0amlkNlZVS1lONWoyVDY4SjYxajcxQnQwYVYwK1Fi?=
 =?utf-8?B?NHcvS2FSbWpwVWt6V0FVUld2SFN5b3U0clhuVVRYU3NLOW12WGFiUzBOdkdk?=
 =?utf-8?B?RE13bWVEK1ZTVnpjakpmTk82eWZKUzdjbkgzN0NIRFBKUjNvekkrN3FYMTJh?=
 =?utf-8?B?UDRPdmlrbm5NQy91RFp5NUozSTVPUHUvOTlsNnU2NEtCOFNxeXJKemRwd3I3?=
 =?utf-8?B?c2JmSXNqcXZRb0gxK0JDTnlsNkpjb3JVSmcrTHArNFIwZjRRTlJQSFN0d3ZT?=
 =?utf-8?B?QjFVbFdFdkxDNFc1WjVBeFB3MzRKNzhCOUM3b1IrQ294OTJDM0I1MXdGQ1kz?=
 =?utf-8?B?TUZlNTgwNXYyYkpQS3I1L2h6T1BFVzNDb3dHbEpUcHhKU2xxV1RWSkhJT2kw?=
 =?utf-8?B?blFQU3JQTGdicmlneEJPRDBDNGRVMjNSVDJDL1RrVExzNVFuRUIzTUlyczBM?=
 =?utf-8?B?YkNadm1wOVFRTFhUZXZOemtObjdPUkJZL2xtMkt0SFYzYWZWR3VvMm82QlpG?=
 =?utf-8?B?OTg4aHg3bWJxVWNYNU9OMDk1YlphSzFhZHJxRDlhOXNJSWs3dEFiSHpiVWhC?=
 =?utf-8?B?ZWdNQmpjUnQ4Wi9DdU5IWXc5OXk0SkZoTWpGdE9OS0VOMVVPUSt3Z1N3TFAx?=
 =?utf-8?B?MVNpZ3BHSDJQT21kK1A4aExwZCsxbjBWeHgxR0hoaUsxckdCZm9mWkczcGZY?=
 =?utf-8?B?TXczTTJhdTIwd1dxVzBsZzE1a0NSTS9oMTJMR3NtNUUxS3owdWpoS240UjVG?=
 =?utf-8?B?QVJpeUdCcDQ1K3dINGVzWUNxYURya2hWc0UxMlh0VGV4L3VKckx5cnAwUk91?=
 =?utf-8?B?ZjZWeGpDMU5uQlZscjVHUkJVQkY4L2VhVC85eXNiaEs3N2ZvRUdzRjFSUVR4?=
 =?utf-8?B?b3k5dUNZcjdqbk5oQXlVSGU4K0FteTFsd1R5UWg1M1ZyTHlLLzgxR3NMNGFn?=
 =?utf-8?B?Nnh2YjdXbnBxSTdqU1I1c1lUbllBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e419f5-4e9a-4ff6-d20b-08d9f2029466
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 10:45:14.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZSXMn80mAbjL9FzdV/txI+Lzi82A/TqyZAclaIiAoax/VFT9tS5regsvh5vWUrU0w6a3UZ8DK1CCwHYKmUrHHjD04fR/t+WnmsdHSp0Ll0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3309
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBbGwgb2YgdGhlc2UgYXJlIHBhdGNoIDEvMSwgd2hpY2ggaXMgb2RkIDooDQo+IA0KPiBQbGVh
c2UgcmVudW1iZXIgdGhlbSBwcm9wZXJseSBhbmQgcmVzZW5kLg0KDQpBbGwgdGhlc2UgcGF0Y2hl
cyBhcmUgYmFzZWQgb24gdGhlIGN1cnJlbnQgdmVyc2lvbiBvZiB0dHktbmV4dCBhbmQgYXJlDQpj
b21wbGV0ZWx5IGluZGVwZW5kZW50IGZyb20gZWFjaCBvdGhlci4gVGhlIG9ubHkgY29tbW9uIHBh
cnQgaXMgdGhlIGZpbGUNCnRoZXkgYXBwbHkgdG8uIFRoZXJlZm9yZSwgdGhpcyBpcyBub3QgYSBw
YXRjaCBzZXJpZXMuIFdvdWxkIHlvdSBzdGlsbA0Kc3VnZ2VzdCB0byBhcHBseSBhIGRpZmZlcmVu
dCBudW1iZXJpbmc/DQoNCldpdGggYmVzdCByZWdhcmRzLA0KRGFuaWVsIFN0YXJrZQ0K
