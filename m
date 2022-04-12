Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84A14FDA35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377633AbiDLJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352226AbiDLJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:42:33 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2107.outbound.protection.outlook.com [40.107.24.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF4112774;
        Tue, 12 Apr 2022 01:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asTXfACqkUd1ohD97DEHb9+9SqBe6hy/C3LiYvDZjkiFSTiCHkTVmgRfnEVJbKyhj31hARTRFyOJZVKw0UJLkkCUeB4AxVxv1RCCYnw+HkAeI13hWQ76DHFE1devYi+jT989dzb2IXLGDrm/zZ9F/lzue715Os71h9f4Vn3tXBvDPu8aDPSmJktxqHVAOPuRyapmZwtZw/bGnuuf18lKGcoAsTqssrJfUnLqbRr+qj3HnIhCP27KxoWtO6AY52fyxv+8Kra2usy6CrmhlMYspO9ujFtwt+MXAtzyG4ncmdpHZ44fEO+ceZ4pNQUt80xy4TKXf0y0BBI/MHAribdDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCFh5OvpIFDzmss0i0TadPNamep9tX0nq/9OsQJERe0=;
 b=Qc+Ch/67/dx7iXnXeqECgxSh850+EzC+RrFG1C/5VA1ZTU8UjaTq58Gxwm3spH1yh4722xJR/6hQB6sU17ywmWdx36Bor+1jttqMQ29aviHJcG1jnZKgKJE8hotYRls+EL49A9WuZjvyMZk5YCve/L7k6i57EyQuFpVib40kroDQhjufEvuroAOzkmvys0B3yjNB268PcF7SdfGyA8hfHUvLg2EV1/9ep9ayV6XjYn1KHvgHCbxm95wdU2EXqrhuHsqbNwMBDJkwKfT2i1kiqGqsSYIFuHLDwWVHWJ9B0CPEYCqQVy8VuHIedLDUk5u2ibIruxHAiwI9plnmbW8nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCFh5OvpIFDzmss0i0TadPNamep9tX0nq/9OsQJERe0=;
 b=jyTkeSgtY+aWUVYvb2MBCNaqQ7EYf6tnXx7y7/cszZlGoMXRUzmJ4v2JTDwJeTqXG45PIalCXbkTLB7CdYfahswyIkdxdHBKWr8BL8/DVHOklvwRHfgNzjNOgevoj/biluTVg6fzfRkmQb+UBevxlsaEak9/tXFzzbtezyJFcQM=
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::14)
 by ZRAP278MB0159.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 08:52:14 +0000
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::e9e8:9f72:60fb:764d]) by ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::e9e8:9f72:60fb:764d%3]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 08:52:14 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "linmq006@gmail.com" <linmq006@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: adc: stmpe-adc: Fix wait_for_completion_timeout
 return value check
Thread-Topic: [PATCH v3] iio: adc: stmpe-adc: Fix wait_for_completion_timeout
 return value check
Thread-Index: AQHYTjnPvgXj4ZjaB06Mcc5wVsLuP6zr+MCA
Date:   Tue, 12 Apr 2022 08:52:13 +0000
Message-ID: <adf0c8de5fc7770023acbd2c9aab478b3a9ccf50.camel@toradex.com>
References: <PH0PR03MB6786157EDA63137DF0071D1F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
         <20220412065150.14486-1-linmq006@gmail.com>
In-Reply-To: <20220412065150.14486-1-linmq006@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b65bf747-e8c9-437b-5eb5-08da1c61bd5a
x-ms-traffictypediagnostic: ZRAP278MB0159:EE_
x-microsoft-antispam-prvs: <ZRAP278MB0159F3176FCDEA7DAE5692D2F4ED9@ZRAP278MB0159.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHWbXoF5tdXFHh6CAy1Jw+9gLo0UHODJYfCImPK3Xn+WIUx1Wx/SabuL8shmgnHmSkZ4B9qBN/iBqYb3kLdi6AFv2AblvJx+h9cJEDYgtbet37wQ6xyYH5bfuRUCpwLgz50/hKjLjHff0Jv1ou9/hXaGbVWrgzjSTFxBEbgg17JKuVNN41IZUHutNeukR6DUXq8aqcUgMAexg4mKe8siVJ8KxKsrMEzVN8mcCDpDrP7/mHL1zptwri3XT862oA5iTe30jEg7UGEhVEnL8INs+Hh1+cEKl/fsppvWehaA386VBw9uwd3Y4f+zhOUnz5jZGfdgk2w2PMMC0dnVwiSKZmH4nJzpG6YHlA+GEwhi7bGeqWz/8Yh00uzGuzeylUcWjj1itH52dj8wEd73hPwbHfczzI58wmsO+aNsBu2aGL/Bo0T1NR8gDScv77wJIYO8PjmTi+J/7I4fIiGcKvK96vhV9s//fRv4yXjGWDA1+6pi/MwZpRT7msdPxkZkl4hw1tzYk/N+AFGRSX2b6RqHfrW0/CQxOumMur3MgR2Rq01MOhpP0fwWdMBSoZe6xOutrVanKFiqDxCOeX73wRhHzi5Rhec6ArgopjzaZjQykIiKu5C1iuDBzNCAdp80WPxDmlVvIcgZzqllWkqG7ktMb96vNRQQHI5A38NYfW4osyfPGdXS1ZE8+Xyl6I1XQ5O0tFxHCR/Ut8FbsuTVMLdxXMyeVVL92xSFzI84bSk1u+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(39850400004)(136003)(396003)(346002)(366004)(921005)(6512007)(316002)(2906002)(83380400001)(44832011)(508600001)(122000001)(26005)(186003)(38100700002)(2616005)(38070700005)(110136005)(6506007)(8936002)(66446008)(66556008)(8676002)(64756008)(66476007)(5660300002)(66946007)(7416002)(76116006)(86362001)(71200400001)(6486002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWgzZkJQK01Va0E0Qi9LV0UwT1JrdC9TbTBIdjNraVFmS1NsUEIyaTA2Sy9w?=
 =?utf-8?B?aFB1bUhxNHUzUnRFcnNEK2RMdDYzUmZ2alJqUk56amIzVExWbXMrVDlrNmZz?=
 =?utf-8?B?S1hJV1lEeEJ3MlpucTIyVG9ISlZLdEZNSWVSa0dCdGlRRVI2VlpBejhHK05i?=
 =?utf-8?B?U2pBcUxXZ3hFOXQ2ZC80L2MzVUpGWjNxblpjM3ZnT1dTM0I1RTIxbnI4VnNL?=
 =?utf-8?B?bDkwWmRYRDFSekFha2lXb2V6bHVJdDlxOEN5NnM5UVFnbEMrOUpLV2xhN3ky?=
 =?utf-8?B?Y1gxWDhXZjg5MS8vdk9lc1pjUHcwQWlvTW9WVWI4bGN2RU1VQ29UNkRJekpI?=
 =?utf-8?B?SXNXTFZnUEJrOGFCZ1BSdGl4a2xzSlZqT0RQU3FkVERiakZBUGQvcmtGVnR2?=
 =?utf-8?B?dG1FYkd1RkN5V21BSWw0SzBpd1NHcmwzSHFYSjJhNGNVdFlxTWU1S0hPL0lP?=
 =?utf-8?B?YmlyWFhGRC81MFF0SSs3eXliZDB2aXZLMVpoTGhJUVFVekxlcmF1M3VEMEdx?=
 =?utf-8?B?ZnVtQXorVy9zV2JjM0lrUDVwZ01CUVR4WmVMbW9ueXdaTHJMeDFRcEIzMlhv?=
 =?utf-8?B?Y3pZTWd6MVovb24wY05odzdtUzl1ZUZxK1NSZnF3V210M0hYeGI1NnJyajU5?=
 =?utf-8?B?WXFWUllTc0I5ejBOYUNGUlRqWHMvMS8zclRkZjJSalN0UUV0TldGUjdnY1RT?=
 =?utf-8?B?RVRiSHdTRVJ2b3FQQ0VEN3p6ZVBweUxHV2c3UlNvTXlZTC9tdEZlYy91N3JR?=
 =?utf-8?B?Nzd3OWxIVUtaa0lyOGZ4UFlPdGdCbFhnNEhkV3BUS1lWUkxrdEpka0h1V3Na?=
 =?utf-8?B?U1R0cnpIYSs4Y29sOUFCa3AxQnpNRDB5UWtoMFp1NUVPSkVEc2tWdm5DbnJM?=
 =?utf-8?B?TU10eVpIQWxFU2h0UCtLRVlSemNUYk1iMUtyWFZBYUwrRjkyMGh5MUo1TkVu?=
 =?utf-8?B?Uk9JK0Z5NzYwYkFYZk1NekhGVWZKRFZZdEdvSld0Tmd5akhZT2pIaTE2dXQ3?=
 =?utf-8?B?Yk50R08vaXVuU2tFeTZnSVd4eU93YVo4TzNqdnFlbDBTOFUzSmxpTE5sYm10?=
 =?utf-8?B?UVVGbktLa1FmbXVPbzhZZit2NDd2eU02cm43bEl2Ykp6SUU5cDhaT1Rqb0dS?=
 =?utf-8?B?czJxT3FlRWRSNCtMaFhqaUlQZ0dITnMzNHV6dmJ1T0IwUnBMMTloVDByTFFs?=
 =?utf-8?B?SW9PdlZ1ZEdKbFB5T1ZOQUFFY2RhZ1ZwYnZDcndCd2V0NjZnSTVtNHJjQ3Mx?=
 =?utf-8?B?Sy9ST21qQ24yU1J5NUFOUzVPSzJBT2dka20rT3grZFRnZ2M2T3craGJFazla?=
 =?utf-8?B?M0lxMzI2K0JyOXpqMlVRSHhBUmhuU1pVNFUxZldDa3laTG5SRGxNM1RldHJN?=
 =?utf-8?B?NmU3WG55U0g3ZE5OWFBIWkR0R0JHMnNBdERZdEVOYU54N1d1MUpsTTFUclBs?=
 =?utf-8?B?MXZmcVArVEVHbEdPREx0d2J3b2lzdUpWbHFvMG4zQVVzL1lSVnhJdzNoanU2?=
 =?utf-8?B?Tlo0WWtLNHpFbUUyWGhMRG1zZ0JtRVlhSGJDaUpuVXpvOStueGN0Um1YTE9W?=
 =?utf-8?B?emZyY1cwWENMVkZKY2treGI2bys4WHk5TEkwOThuQmNRdUQ4U1VXM1B6YUht?=
 =?utf-8?B?eFJMRy94SU1ldERaMmpRWjZ1SzdnNDdZK3VjTUlYb3UzM0xRREJGYW0xVDB5?=
 =?utf-8?B?d1ZuMmhEQTZvV3FhVC95dVNFYXVmbFJLS2hqdUZwWVRHYXNTOTlXWWpta0do?=
 =?utf-8?B?MkUzUFlvMHpIZHNCdWw1VlE5UDdGMVMyaWdkKzV4MlNhalM1ODJxRVVRRUt3?=
 =?utf-8?B?UCt0SDVJWktTbGRCVFJmcGJkWXRIMDJZVEY4R0o0OHZRN2lzb0d2MEdvSjNJ?=
 =?utf-8?B?WXk4S3ZoSk1VODhDUnpmWS9KcG1yZVhGY2M5U3FFbTdpaUoyUm11SUFRQTRM?=
 =?utf-8?B?UHdnUmZTY1hlZ1VhNmx5K3pIRnVoM1YyWmFVOGwyTTd3ZWw4U2VsUitPVVZu?=
 =?utf-8?B?RHNLS2cxM2hqOFhJaVh2ejRaQTNmWHZ1WVhWaktrTVVsbndZRXZabmRiQVlr?=
 =?utf-8?B?VWpVOUFQcUo5SjZrQ1BNaHo5N2g4bFcycGt3ZzhqZG84ZnlrWkhObE5hUHl6?=
 =?utf-8?B?cmswekNqN3J4eGtHSlZGeEpUaFljZHgralZtZXg3aGp2NWtkSmwwS1JidTRw?=
 =?utf-8?B?S0k0SW5IU21sa1lwajZpMFZzRTBWWHJtTnNsOXpFeHZnV204L1V5amhaSFJo?=
 =?utf-8?B?aTJaMVhJaXRPTHRyK3J3Y25wUE1XUWlxNzFvNUZ4UENxeVV3UGlXTXFPcUdD?=
 =?utf-8?B?bHhOcHVtelBGNTFuVlM4ZUlua2tjVW1NWmRYTEg3bWZQWHN0VXVRS1BoejNJ?=
 =?utf-8?Q?OP8fnanihG8/dD03ujVeALCOo9AdSclBSmOan?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECC589B5B5866B4AB885970B03D20918@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b65bf747-e8c9-437b-5eb5-08da1c61bd5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 08:52:13.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqFUvBKd5qMAwUqMjc6EdTh/rS+ryOZuOZphcRvIieY2UqzOxX40mBN8JmsGhj/3aHWVKuz1VYwRlmsi5d7OD7Hzgl/AzGkEjFSIO/oI+oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDA2OjUxICswMDAwLCBNaWFvcWlhbiBMaW4gd3JvdGU6Cj4g
d2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCkgcmV0dXJucyB1bnNpZ25lZCBsb25nIG5vdCBs
b25nLgo+IGl0IHJldHVybnMgMCBpZiB0aW1lZCBvdXQsIGFuZCBwb3NpdGl2ZSBpZiBjb21wbGV0
ZWQuCj4gVGhlIGNoZWNrIGZvciA8PSAwIGlzIGFtYmlndW91cyBhbmQgc2hvdWxkIGJlID09IDAg
aGVyZQo+IGluZGljYXRpbmcgdGltZW91dCB3aGljaCBpcyB0aGUgb25seSBlcnJvciBjYXNlCj4g
Cj4gRml4ZXM6IGU4MTNkZGU2ZjgzMyAoImlpbzogc3RtcGUtYWRjOiBVc2UKPiB3YWl0X2Zvcl9j
b21wbGV0aW9uX3RpbWVvdXQiKQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9xaWFuIExpbiA8bGlubXEw
MDZAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5z
Y2hlbmtlckB0b3JhZGV4LmNvbT4KCj4gLS0tCj4gY2hhbmdlcyBpbiB2MjoKPiAtIEZpeCBzYW1l
IGlzc3VlIGluIHN0bXBlX3JlYWRfdGVtcC4KPiAtLS0KPiBjaGFuZ2VzIGluIHYzOgo+IC0gdXBk
YXRlIHRoZSBwYXRjaCBzdWJqZWN0Lgo+IC0tLQo+IMKgZHJpdmVycy9paW8vYWRjL3N0bXBlLWFk
Yy5jIHwgOCArKysrLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5j
IGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jCj4gaW5kZXggZDJkNDA1Mzg4NDk5Li44M2Uw
YWM0NDY3Y2EgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jCj4gKysr
IGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jCj4gQEAgLTYxLDcgKzYxLDcgQEAgc3RydWN0
IHN0bXBlX2FkYyB7Cj4gwqBzdGF0aWMgaW50IHN0bXBlX3JlYWRfdm9sdGFnZShzdHJ1Y3Qgc3Rt
cGVfYWRjICppbmZvLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGlp
b19jaGFuX3NwZWMgY29uc3QgKmNoYW4sIGludCAqdmFsKQo+IMKgewo+IC3CoMKgwqDCoMKgwqDC
oGxvbmcgcmV0Owo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgcmV0Owo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmluZm8tPmxvY2spOwo+IMKgCj4gQEAgLTc5LDcgKzc5
LDcgQEAgc3RhdGljIGludCBzdG1wZV9yZWFkX3ZvbHRhZ2Uoc3RydWN0IHN0bXBlX2FkYwo+ICpp
bmZvLAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGlt
ZW91dCgmaW5mby0+Y29tcGxldGlvbiwKPiBTVE1QRV9BRENfVElNRU9VVCk7Cj4gwqAKPiAtwqDC
oMKgwqDCoMKgwqBpZiAocmV0IDw9IDApIHsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0ID09IDAp
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0bXBlX3JlZ193cml0ZShpbmZv
LT5zdG1wZSwgU1RNUEVfUkVHX0FEQ19JTlRfU1RBLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBTVE1QRV9BRENfQ0goaW5m
by0+Y2hhbm5lbCkpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5s
b2NrKCZpbmZvLT5sb2NrKTsKPiBAQCAtOTYsNyArOTYsNyBAQCBzdGF0aWMgaW50IHN0bXBlX3Jl
YWRfdm9sdGFnZShzdHJ1Y3Qgc3RtcGVfYWRjCj4gKmluZm8sCj4gwqBzdGF0aWMgaW50IHN0bXBl
X3JlYWRfdGVtcChzdHJ1Y3Qgc3RtcGVfYWRjICppbmZvLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4sIGludCAqdmFsKQo+
IMKgewo+IC3CoMKgwqDCoMKgwqDCoGxvbmcgcmV0Owo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVk
IGxvbmcgcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmluZm8tPmxvY2sp
Owo+IMKgCj4gQEAgLTExNCw3ICsxMTQsNyBAQCBzdGF0aWMgaW50IHN0bXBlX3JlYWRfdGVtcChz
dHJ1Y3Qgc3RtcGVfYWRjICppbmZvLAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHdhaXRf
Zm9yX2NvbXBsZXRpb25fdGltZW91dCgmaW5mby0+Y29tcGxldGlvbiwKPiBTVE1QRV9BRENfVElN
RU9VVCk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBpZiAocmV0IDw9IDApIHsKPiArwqDCoMKgwqDC
oMKgwqBpZiAocmV0ID09IDApIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11
dGV4X3VubG9jaygmaW5mby0+bG9jayk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVUSU1FRE9VVDsKPiDCoMKgwqDCoMKgwqDCoMKgfQoK
