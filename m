Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC19C571305
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiGLHWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGLHWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:22:38 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F897D68
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657610558; x=1689146558;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BSDb9r1BAJClud1YZbL/8dJYCSgO9HbBCKdV2aSGYA0=;
  b=RgM15RrtfzMRMdsjXbCUlw8WLBJc15slikUTBMWquskV5U4abskr19pZ
   LR6rBpkKwknbJ6XA2kfXLXKNYrul7jHMaDlHgCPKd6qSuWL9j9f9n9neu
   9wdTBaxBqQMgb5Z0Pd3lv/+NvLC9MPQ2H9/j12MtzDsnxgB+QPz2DGjqU
   U8maq7n4tGiVuw0vFwb1PkRk8mkCz7KGIlWYl981KlU8NGNfyVkAH5J5I
   /5g70HAaAjVlTj3zkzcGBSF3aAkbrwiM6thQgngkVNGU0dvuBaDS7WPBt
   d4fPuxNhIVwdlsrPRD0/X5NkN1bxrBBJHYwE9BUfUf5A6CDTk0W2kTctN
   w==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650902400"; 
   d="scan'208";a="206160440"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2022 15:22:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7gtZ7lHVWIpo5v79Wvx4NBveCZQSDt5JBmHdhmCj+StJN7hvDIVkdsDucl11+SJtzlEkrTsPn2QTtO6c9lqfc7H2SuyR5gv46Ks769vM81gZIAcgjUnG5+7X2xjE4ytA6XOARx/3Lq7/c/55siSKHhZgygklBOcdeV9UDsBWsbU4PQW7jCEj3URNyP//K3ngsMI5vKmGsEDF/s6p+W5svnzOde1c7+/r6evwg1WMUGFBwz/ZzUfHU6Shz83m0BXBYbfOCcjx9iJDsxp75nQ2L0JAbwcjKd2EN1fIDsPne11RwYEV1v6J7lk47/d8P7eZjJjVlbzv60izr2yUhXYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSDb9r1BAJClud1YZbL/8dJYCSgO9HbBCKdV2aSGYA0=;
 b=Hy8lOHBbEEHkBnUzNUhjkrOydWebxaLiF2v3IfV3ZJcpusFdEs4IfvYuNyUXvzWlhxMV2HT1p98UpnDDP4xxdGaV5ugf/Y1Z/Yn5lcGkBWSmbnpilZJ8HiNUZbJdVDh1Iqephmf0b8OANZdkWi0rS3jpNyvPBzlwLFyTXOXVMkHxjneW00MsbTL+9Uim6hHn64LeQ9hRns/sFb12TCsv6WGseqN3XQEKazdFRXghPryiG08lr7MFd+BeXW0yL8H/uKBYJberen0PAxngAtovVNuUVY75l8YuYbhYp8yk9h/wZcC2PaVQ/vozjSCqvBqtKNM88+YvIzvo8KQwqaOn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSDb9r1BAJClud1YZbL/8dJYCSgO9HbBCKdV2aSGYA0=;
 b=AOWlM1d3hLithxOICCGXU57CDL4SKzW0nRrLgXG/IAibSd9HaNIiaQ3OsPJBle2s51NghYVqpB5o9+jFG7Pya+UhOHZ9O/3WzJur5Yb/n5RcP1h+pYVp1yDbOGXRBS6fu4XzdPlYzWERqFy0MoTx8LNJl48hjd4qxU6MV1q9kGM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR0401MB3565.namprd04.prod.outlook.com (2603:10b6:803:47::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 07:22:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 07:22:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Greg Kroah-Hartmann <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/1] drivers: mcb: updates for 5.20
Thread-Topic: [PATCH 0/1] drivers: mcb: updates for 5.20
Thread-Index: AQHYlb3uqYFbAOK3ZkWkHdafkClFhQ==
Date:   Tue, 12 Jul 2022 07:22:35 +0000
Message-ID: <PH0PR04MB74162CE8D5A8C500177CFF269B869@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657607743.git.johannes.thumshirn@wdc.com>
 <Ys0dbseAdP4/u76H@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad17473e-a302-4fc5-949e-08da63d74ad4
x-ms-traffictypediagnostic: SN4PR0401MB3565:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xfz5ZFeMfRmA0B8TZ7CpmKUCgkkLEWActKiwhIgq52pQEXyrVEI22xV3IMewaj03ai5sfuAkoEVJG+ObTAwjJvC80eNtAC03c7tjKDZ58tAf0zUppZ7Nn/OPKTS6BF3a8LaqIkZiDlBtbZoc3jbXp1O+oxf1tyg3qdC0XxmSpXVF6VZzAM8UeUc+sfm3ZvDxKkCQ94OV+lX8IYBy60PP8wleOY3KUG+1JUpa8KuazVTPrrI0C0jkfTH49QM2UCHkYytEz0kQp+c5H+VpAdg3XBFqnPuzfiCjZeBivnZUlyWbYb7t9/a7tJj7SsdHkz28c3Cf9iujq6yIODPVe60iWKgRwZm9W9ZzMXYhDpgNbwXO61HJ/3+uU9pQwIu3ckyOfFvIJxiMk7Hld6eT9LAdhhBe7vRFBLNoBM7eVIshQgK3LgTvZ0E6F2Oe+q7JoToN+/EnPozIxfEIrMsyj5bk77iA7zixMwvXfYw5MBMHANhh1jaw1kCG5P3VAEG2iOt80q2SC0nXIS8lcm/fsF0rMmEnkzpLrPpIzUHeCeyQYMjDjNBa2SoFrRGcuaQLvfNhcTkuzhlwJOyyliXz+Kyl3tx+7SCItGzYVuSplT8j7oEL3xBTLUTJ335zDxKRay3C2tmdgX3vZJMpCUHAPctigIXIpb3w8LRE9J6Q94LC9/+eqIiM9WDibx3mNlcLiLKtMc/clWlNWeSfZGSzs05cdk1JGfHt0NFDvKYMUg0Gv2gx95XBgP+zZohPeCXIUgP3c1oybhxLuBkqXWvevUi6AMZBMw/dLw0oTl+dO19MDMKViCHYMX4ghcNyhIZapaiU25YQ8Ubw07dtQKLOS24B7y3mk9Xl3Rhs9vbl+DekvI0TDyIBAu2GN2HSTwYHQm75iPXENRfkfOiN6qXy/hL2Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66946007)(186003)(6506007)(478600001)(66556008)(7696005)(4326008)(9686003)(41300700001)(53546011)(66446008)(82960400001)(38100700002)(83380400001)(38070700005)(8936002)(84970400001)(966005)(55016003)(5660300002)(122000001)(91956017)(64756008)(15650500001)(33656002)(2906002)(71200400001)(6916009)(76116006)(86362001)(54906003)(8676002)(66476007)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckxMcktibU9ZRUxtaHI3aXBqVXhwZlFqcThWbEQ5ZzU4ZHphK1ZrNnlxUFpT?=
 =?utf-8?B?bWV2TkE4dmpvSE9uKzBheHBITVNaeGsxMndNbnYyMk45Y2pwYXhKYVRvTFpB?=
 =?utf-8?B?VmswNDFrOFVtYzVuTUg5bnVmL09UQ2NBc2NhZFZlWDF5MDVBTklyVkxId2VI?=
 =?utf-8?B?SGlpd1cwQjdFNjk3ZFhtZ1VFM1orNi94eXIrZG9qaHJXMHdmcFcvb2lZVHBV?=
 =?utf-8?B?WTdPYk5XbHlaNWVxL2NKM2VGRUFHUXpMVjIwT1U5KzFJcFNjcWRyMlNTSzhB?=
 =?utf-8?B?TkFid0ZFcFRNSFgwRFllUHJwVUhEckxBYS9OVXB3dU5GNzdMQzVaclBaSTJ5?=
 =?utf-8?B?ejlnbmZGa09XZWJoUDRXcFZTMWxUV1Zzajd4YVpuaG9JcTV5dXU0TUhUWlV3?=
 =?utf-8?B?ZWNSaXpKbDd5TkRvQmM5MFZOTUVxYWhpTDJVa0dyUFh4c0M3ZjZSZHJvREdX?=
 =?utf-8?B?QVQ1c2tIMzVkNEJTdEZ0ZDJiZkVteUl1OGkyMDZrcXkxTXJpbDBDVndnYmRI?=
 =?utf-8?B?SkJ1THd2VmpCUUZiLzNGQWw1QXlyOVhBQXVBOEE1S201eU9vc04waFIwM0NN?=
 =?utf-8?B?c3dvOVZuRWVvQXRJWVpFK2dZR0xsajV0cXhIUlhOMjFJRU1zOWhlUlpRK29F?=
 =?utf-8?B?dzZuQTBQSVZSTGtlK3gxNlVNZHd5NkxtUTBIN1hGSC9qMzlaNTRaM2RCVUla?=
 =?utf-8?B?emtQVGNJZ0NuMVlVWUlYYVc3NmJsanpGUmJVekRVOE1Od0FVUHN2OGFCb296?=
 =?utf-8?B?WlNHV2lLb0pmRzFkSklIQkNIUzZxY0w3SHRsQ1hQNCt4MTA1SFh4bkcyeDM4?=
 =?utf-8?B?RklPL0M0SUhPcGowWm5Pa3dnaWlEY283Q2lYRm9SaER5VXJ5NXA2OHJUcEZD?=
 =?utf-8?B?MjdyNHFPTzl6RFNmTnVWS3BSa3QrcTZ5QkR6UmdsL2VoaDV0bXhRSzFhdlBX?=
 =?utf-8?B?OFg5N3B3eTVlWkJ0ZWFOU1ZpYjVqb1N3cWVCQTMwc0RCQkpjSElkRjczWGh6?=
 =?utf-8?B?dGJRbGtlM1pocjlFYnc3aG1nK29PY1JCREZYcGRCQ0ZyNzhoTFBCaXNPSm1w?=
 =?utf-8?B?cjlQRE5XalAwL05xQ1o4N0VRM3ZXTGRwN0JZZ2tTMmNCVVZCNXBXVndjcTQr?=
 =?utf-8?B?SnlUVjJqVGRhakwzSlo4cStWRHBDUktFN0RtUWNlZlpBZnBHR1lMRUZGSXM2?=
 =?utf-8?B?emo5bzJwcW45ODhxdllCNUdLaVNHbUgrNFNEcER1WlJZMnhmRUxhcmJUT2xr?=
 =?utf-8?B?bFFOdVV1djNWcFdkUmVHOFM2RGorRkRsd1AyV0ZTL3BkUkJkNGZSTDNTQU82?=
 =?utf-8?B?Nm5nUWNNT1FkSjM1blNPWmNoc1B1d2QrSm50OEc3NUx1d1pRQzRMWWM4L2lz?=
 =?utf-8?B?L3RmaXdQQk52c2poZHNSdTV5dkZBc0ViWFA0SjNzcWFhRHNJUUYzc25TU3Ba?=
 =?utf-8?B?R21PRktLYzhCMDlrL1VBVjl2dFREbXFhSkV6dXlEaUJKeEJHQlFkMCt4bytK?=
 =?utf-8?B?K05VQ1RYc3NBdFNZSExYS211Sk5PZERtZXFIMzVlSnZPOFRnVlV2N3R6Rjhu?=
 =?utf-8?B?Wi9hcGg1b0lHMVhZZ0hPaHFwMGVMSlB4MHFnWWIrT2Q1amg2SVM3U1hrYitT?=
 =?utf-8?B?RkI2S05qeGJrUnNGbndBQlRLN05FRVlxQTEwT3RUTVlzV2VzdCtLM1FvQkVP?=
 =?utf-8?B?dHV3RnNmR2tUeC9rS1d6TjFheDBNcUFlU0ZFNTRjcitHT041NWFSa2V6TkZD?=
 =?utf-8?B?VkVJQTBzcUhrS0xPUVNTb2x3SkM2bEI2K1dsZitsK2dHcm9rcU5xSDAyOEli?=
 =?utf-8?B?VGlmYWxMVjM4UzlxVUIvWDFwUkFkUG9NL0REMFlXcTNzSy9KMGFqTUlmYVBv?=
 =?utf-8?B?RVpocXNIV3B5M0N2azhEcjJZTSszcWZoMS9FMUdMclFPcmdjM25JR0R4WDlV?=
 =?utf-8?B?cVVqeDViWEV0b3o3TFhxaEl1NzAxbDVXLzFOU2lENVBLQVRDZmhWMzJwelRj?=
 =?utf-8?B?K1l4VDlRVlh4OU10U0FmQWxrNFhBUWp3dDVvdDZLUk02NTM4VUNlNlNxZnhQ?=
 =?utf-8?B?bG1SQVY2YStRQmZpSkNCUW1zK1h5LzFuSDBHSHUyYis0bklVbXF1aithcGpq?=
 =?utf-8?B?UjdGY1JGYXR1d0VBZmRkYXU3K3lCdVd3Q2h4MDNXZHRNaG5kRmlUSjFuU21L?=
 =?utf-8?B?TDFKL25MamdhNVRpNGtOY1QyRm8renNMdXM4dWF0UlQvMDVKM1JHNkdCQUhk?=
 =?utf-8?Q?FAEHWMoaXfC8CHngCoZYupKYc7QNkownNxCGfX2kxU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad17473e-a302-4fc5-949e-08da63d74ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 07:22:35.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3ia4caCf+acQs9zEsO2wbArjUdg7f/oloUkAcxOR/wCUuWnvd1AWZCkNQd8ED7tQAPpICJDH0xDIAavXK9fN/9/Fas57vOYRlmDBTvVzgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDcuMjIgMDk6MDYsIEdyZWcgS3JvYWgtSGFydG1hbm4gd3JvdGU6Cj4gT24gTW9uLCBK
dWwgMTEsIDIwMjIgYXQgMTE6NTA6MDdQTSAtMDcwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Ogo+PiBIaSBHcmVnLAo+Pgo+PiBIZXJlJ3Mgb25lIHBhdGNoIGZvciBkcml2ZXJzL21jYiBhaW1l
ZCBhdCA1LjIwLiBJdCdzIGEgc2ltcGxlIGNoYW5nZSBmcm9tCj4+IGlkYV9zaW1wbGVfZ2V0KCkv
aWRhX3NpbXBsZV9yZW1vdmUoKSB0byBpZGFfYWxsb2MoKSBhbmQgaWRhX2ZyZWUoKSBmcm9tIGtl
bGl1Lgo+IAo+IEknbGwgdGFrZSB0aGlzLCBidXQgeW91IG5lZWQgdG8gZml4IHVwIHlvdXIgZW1h
aWwgaW5mcmFzdHJ1Y3R1cmUsIGl0IGlzCj4gc2VuZGluZyBvdXQgYmFkIERLSU0gc2lnbmF0dXJl
cywgd2hpY2ggZG8gbm90IG1ha2UgbWUgdGhlIG1vc3QKPiBjb21mb3J0YWJsZSB0YWtpbmcsIGFz
IGFueW9uZSBjb3VsZCBiZSBzcG9vZmluZyB5b3VyIGFkZHJlc3M6Cj4gCj4gTG9va2luZyB1cCBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzQ4MDY3NmJlZTk3MGRhMTZiZjFmYTg1NjUyNzcyNDAw
MTQzOTViYTMuMTY1NzYwNzc0My5naXQuam9oYW5uZXMudGh1bXNoaXJuJTQwd2RjLmNvbQo+IEdy
YWJiaW5nIHRocmVhZCBmcm9tIGxvcmUua2VybmVsLm9yZy9hbGwvNDgwNjc2YmVlOTcwZGExNmJm
MWZhODU2NTI3NzI0MDAxNDM5NWJhMy4xNjU3NjA3NzQzLmdpdC5qb2hhbm5lcy50aHVtc2hpcm4l
NDB3ZGMuY29tL3QubWJveC5nego+IEFuYWx5emluZyAyIG1lc3NhZ2VzIGluIHRoZSB0aHJlYWQK
PiBDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50
Li4uCj4gLS0tCj4gICDinJcgW1BBVENIIDEvMV0gZHJpdmVyczogbWNiOiBkaXJlY3RseSB1c2Ug
aWRhX2FsbG9jKCkvZnJlZSgpCj4gICAtLS0KPiAgIOKclyBCQURTSUc6IERLSU0vd2RjLmNvbQo+
IC0tLQo+IFRvdGFsIHBhdGNoZXM6IDEKPiAtLS0KPiAKPiBDYW4geW91IHBsZWFzZSB3b3JrIHdp
dGggeW91ciBlbWFpbCBhZG1pbnMgdG8gZml4IHRoaXMgdXA/CgpUaGFua3MsIG5vdCBhZ2Fpbi4g
SSdsbCB3b3JrIHdpdGggb3V0IElUIHRvIGdldCB0aGlzIGZpeGVkLgo=
