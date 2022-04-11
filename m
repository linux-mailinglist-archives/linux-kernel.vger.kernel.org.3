Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510624FB8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbiDKKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345033AbiDKKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:06:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23ADBE30;
        Mon, 11 Apr 2022 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649671483; x=1681207483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WwhHidLF6MJLH0gR+qLYL6zkUHtD+9xmN0SgIqbLxjw=;
  b=TAYRJiPArTRdfSkjHqmdoQdxYuHWqBSWGi9z30LsWbUmBfNb54bubDBI
   Vk0aH+8RRDBdJWBBfucUXlxL2P8S9PDAB2hJYMm6JNaOBvgaFbIFPEJL4
   hBg3KYGyzpfvus3ma9a8SJZyA2x6pUg/oAlJPB0RW8RatceZgpL4Ys8j7
   fPeJQf8FpZvg9E9bXjgl5wasfvpuuPoySTj+qHtGxVeIi4959TEFiqVqo
   NWe0dnOd4I+dpMdoC5IuShula5cl31i9Rkj41c77Rj0DNNdhIajruRIyG
   HfMN2u+7cu7S9X50W5VlOjn5oqf+W7erfztpBhSpbXVIH+TX80ljC07ZM
   w==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643644800"; 
   d="scan'208";a="196485385"
Received: from mail-bn8nam08lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 18:04:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBLbo51ymn91MEXQ6XnU/HO+aKRKMwcf8iAftlo+e9uOVjtyCE+PXhNAses14kXyOevatRFT2KTllqkDNZdedKx3tDpMlf6sSaXS0KGWRoeAlnVE/cCteIqHNua1OYXnsP/Cm3aC3gkaFaxxKXdrp7WsQm5bRvwOax7wdOQgMP+GuWLbQpnlia4qCEQW0thVluap0Q9DbrhfNnOkbVP0yA1N/UjDR0Jc/QP+ZtR9O6iYvrVD2tR/3kAZmdVBQKKPOCAegG7KuSO06L6Ye2tSlohXN+FxUJMWaTY5w3WLMRGqMQf/6GOUhz8NN4MI255g49bOYq2HqDiI2L78UEClBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwhHidLF6MJLH0gR+qLYL6zkUHtD+9xmN0SgIqbLxjw=;
 b=RKV2v5oGYZm9Umqobuvo8nG3wgsmXNuOXZnJ2XKF+7kGEX2Oh82h2Go4PMdGuCRrXYMZREkGZ0PArHHCic6cK5aR+8jvka2F6Kn4MtZ3wb+J9Mu3bZQhiJZljv62hgIv1h3ex5K0u70z9uJu/nu9Oh1n0Kxgbgz+0B09pUOCpuB3A/yw+GMdaYPTrnAoCGPOdRdv6r/KOBUJZpRQuHL2jpD5HFnVyDotr1BebDBRigVAVWsVC0+hOT/N3x2VXup6egHfzzMa6JJZwV1RJm0bUpcGTq/gfMPqeAnz1XWh7XqRUH7253TNyPqFQUep/be++iT9SAn8mL8XYoKYDh9AmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwhHidLF6MJLH0gR+qLYL6zkUHtD+9xmN0SgIqbLxjw=;
 b=P644eNFQkQjPwVwZaau3PRwf6XOMtHl7C1DgjOfOj63QG2y0aMatcgm5mFKAZc87n5JmczqdLL/wpd2GCZKi6Hm5NJEuzbO6+IE0dkd+wk38d4/MnIYx6uj84s7BAp58cHdQVRV0PNJahc/t8dyCr4OoOvnB952boNKCEbk0t3Q=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN3PR04MB2132.namprd04.prod.outlook.com (2a01:111:e400:7bbe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:04:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::6997:f415:556b:532b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::6997:f415:556b:532b%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 10:04:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jakob.rossler@nokia.com" <jakob.rossler@nokia.com>,
        "sperson@micron.com" <sperson@micron.com>,
        Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v1] mmc-utils: Add General command CMD56 read support
Thread-Topic: [PATCH v1] mmc-utils: Add General command CMD56 read support
Thread-Index: AQHYS3IuzGSpa8VMXkGTy5wsoWR50aznRZ5QgAMmboCAABQP4A==
Date:   Mon, 11 Apr 2022 10:04:40 +0000
Message-ID: <DM6PR04MB65758A57DBA5BE8A33578BE9FCEA9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220408174832.303915-1-huobean@gmail.com>
         <DM6PR04MB6575816F943FB2F0D4099CDFFCE89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <9ac83fe9bc33cce4b8691d49bdd155587196a62a.camel@gmail.com>
In-Reply-To: <9ac83fe9bc33cce4b8691d49bdd155587196a62a.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0531c3d7-6079-4a02-a3c7-08da1ba2b16f
x-ms-traffictypediagnostic: BN3PR04MB2132:EE_
x-microsoft-antispam-prvs: <BN3PR04MB2132E5E46345B51A6C5AC1A3FCEA9@BN3PR04MB2132.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /EkoGXCEhOn5ALb1jVnp/Pp0YtBNHdRNfp8zf6lFBC/bPDZbERyIptTnqbCZ/D7fNwMXF10iP0Cz1qcmkaJmUGXSJQ/QkMfZjnjgokdgbajI0z55nbBxB4gN3Xn8DJHakL5ccCj0PelZaSpaxyZ2w4eBV/wcbVyVOo2+apvn8EeqZWbaci5uXqd0PpUVg5VAHsBwI0XO8D4eTXblEkflC8NvZ21L5h8fNnN7idThbRIMMt9QgnIjsOZzUGC7kcUuHzLMquRIzun6vmuw3tnB8OTC69p9D6cvzwASnoGUCEQyjWWOCwDP1qLOr+upBQOFTuSbS6EzrO23QUv/ZlZ2lsqxS2zLnpTI6BxkxZOQqBzyI+Vu40aS2SQJQ7IGOh9MMmqhNewL3CwgksMJP6EyopzdxJeaW0DHJ52vEkPglid3aViXlL3N4z0/vrDITm5Ktnkk/MXVbBDDDUY1aBz6QLX8i9dVbmjxBxgFoSlyrIJdDoZgjLFwHrz1m4VF2Dy7fSKqwJM2q2OFFubSfbl6L16j9i0kZugdxjq9V18URIM1D1OUk83d/sMrVKQnNKq243taorLkUmaXXLpR3Tx9n/NahfnncRd5808fluomQqyHSkfv0V1c4zr7y+bcJFq4SiWC66qQ/KTOhJ5HX3UfAwt6rEt978RkRk4+kFb0GyGS095sGEgPmr5PJ8E2Bab+aTvOAq7hxdgpdmQNxOLzWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(66446008)(64756008)(4744005)(66556008)(66476007)(26005)(186003)(122000001)(54906003)(55016003)(7696005)(6506007)(8676002)(4326008)(2906002)(66946007)(86362001)(71200400001)(82960400001)(5660300002)(76116006)(38070700005)(83380400001)(316002)(33656002)(52536014)(508600001)(110136005)(8936002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE4zenFIYnpCQy9hcDliRGxUL3lUa0cxOTArSGFUS0hvZHhRRDY1RVNKdmV5?=
 =?utf-8?B?c01OV1dsbktxVnZaSjM0NUJnSHlVUFgrQXFZRy9jTE0xVkNDYlZYZVZZbnJu?=
 =?utf-8?B?TlVoaXlNbWdoR0czdmRxNDlRUzM4a1JIdVcxeTV2UDNVSHNKZ1RTKzlZc2l2?=
 =?utf-8?B?Nng5L0xtTlU2dWI1ZXU3NUk5eDhYakpsM3ZhTGpJajV1Z1R1T3QyYmZOS1lF?=
 =?utf-8?B?ZnNPaW45QTdDSk1vcTNaLzZQZFpqaklKQklseWhUQXp0VDJEb21jQUxQRldY?=
 =?utf-8?B?RE5aekJNR09MbWZzOWRWYVJDa3JKRXF5SG5QMEJFTTZSQXlsZStueHVkV1pN?=
 =?utf-8?B?QWV0L3JjM1ZzZXJUTGNLUEwvRGJQbUtpMG5WbGg3V2E5SDhwY3pPNmFFdlhN?=
 =?utf-8?B?N3dRSEJqN0NURHpJbGJGOGtBMWdDS1NIRFZiNzI5Z0w0Ym5rUXdUZmJqUzFU?=
 =?utf-8?B?U2VkU3JoZnFIYjM5UHFPdVBGUG1wK3k0R1FmbE9Rci9XTCtpaE5lak5QN2xs?=
 =?utf-8?B?RnkwWGR5cmVGZW16V3BOWmdvbFoxZTc1UGZLZmtVNERLT09RS0dsa2d2cTJ6?=
 =?utf-8?B?aTBTRUZ5anpzTWV3N2ZrQkVLdURzQWZlRWV1RmcxNWRCU0dGWWJzWlpYOGZ3?=
 =?utf-8?B?UXRvUGJCd3QvN0lSM09aYXhuOWJ4aUJNMjh1anpZZ3JINW5HUEhpUXgzTGNv?=
 =?utf-8?B?N0RiNHh5SXRiZ0Z4WXdnMHRLbHQySnhvZFp0WHNhbkVObEdsY0JVbndKWndF?=
 =?utf-8?B?ZmtzSEZqTkJlWmZtcUdva0ptZVFGUVd6aTZUcjkzT3J4akp2djYzS3NvMzdk?=
 =?utf-8?B?R1hBUEx3MmdtdVRVWDNRYVN3SlJNYXE0dStXbCs3L1cvRGZTOC9NSnBveVRD?=
 =?utf-8?B?TzEvc3JVUEpyMEdGYW5ZL2lWVkk4T3dMaFVSSTcwbFFaQ2FUSkY3SWs0bmVF?=
 =?utf-8?B?eVppeGRLZS8rRlFZWFI3azJ6VVE0STZRdncvenI4NGp4NXliUWtoNERxVG83?=
 =?utf-8?B?RTRvckdmM1FzKzRlZ3hrOSs5Y2ZLWDdQRVN4YTdpbm1xU2tpc29kb3dpZk50?=
 =?utf-8?B?c0JoNXUrTFRFcUtFaEREYWd3WngzWFFDM3hYUjdSbnZ4emJLSmtoU0xBRjI3?=
 =?utf-8?B?V1d0UGh6QUsydTlsYmE5cGZrYmszamRWR2tOVUVjZGtycHpYMC85ajdaNldS?=
 =?utf-8?B?K2sySGtOR3BKellYb3JoNGcrbEhxREE5bk9aVHpZcXpTbXdWVnJiRjBTVkNT?=
 =?utf-8?B?dit0SkpXaFV4M1B6Snlrb0ZqYzF3eThOYnpJdEtpMGxWY1pMeXNQa2pIdFRG?=
 =?utf-8?B?b0RBdjBXY2Z3eThUU0pFdDQ5d2FwNC83YTR2SzRLWDRPdXNsV2VHTG1ydFU2?=
 =?utf-8?B?RFpMSHR0aGN3Lzh5NGNnRVBTWkYxYWVEYVdpMFBBOFRRMGZ4QnBaWTZ0TXVC?=
 =?utf-8?B?a0pvZkNyOUJ6WnBoSWZ4bitPUWpVM0lnK0ZWeUgrTGxsTkFQeW80aExmajdw?=
 =?utf-8?B?ZDZrOW9kcy9aT0t6RzRrNVRwek8rTFJZVGFaRjBGejYrWmtIMXB6VWZkSjU4?=
 =?utf-8?B?Mlk0bmhNRTFwaWgwWW94NFp0d0VDLzJTNndTY2pZMm80VGFldmZBaHZnOVc1?=
 =?utf-8?B?eWo2K29EN0xPemVPQ21Yb3pmelM0L3o0SDdpc0hYZTU0WXp1b3RCd0NJZk5y?=
 =?utf-8?B?empLcUJvSmQ0eU1Lb2E5d2FsUFVmZ1V6SmpjUzB5TDAwK0t3NnhoWTkyYUlO?=
 =?utf-8?B?MDhyaldGUDJHQXBaYlJOZUx6UG9qYnA0cTFLUFVlQnBBUU1TTU9KZFIxZkxY?=
 =?utf-8?B?R3RtNXRDVE5SeU40R0F2WUIzcUZnL1ltUFp4emkzZW5YeDFzM1BOTGZnVlNp?=
 =?utf-8?B?bWlBUFBJMjdGdm11QjB6NnlFMFgwVDVDQXN0N0o0dVl2SjJaNG1WZGVGZ0FN?=
 =?utf-8?B?TVo1ZkkrYmN6T0MrcFF2bWl5UnkyNUVoT0ZWc3o3YlQyODVFbERzRVN0ZjNl?=
 =?utf-8?B?SWpIUERMUUhmT29HMWJHWmptcjlkT2J0OHpSUjRPaVhqbnNXVmc0TTBKT2VN?=
 =?utf-8?B?bzBzVlMyVnJBNHc5U1RVNlNtekRyQXg1ZFZNMUpTeERvY2VjVlBTUEFsUkNH?=
 =?utf-8?B?OStpdWh4bWpJbnJVYU11cVExYVJjZHJaNzJ0V2xpOXFpTXpMUTlUamRYblVE?=
 =?utf-8?B?cjVwcmdoZTJrS1VEeURwMXZtaXFyblJ0U1hKZ1l1b3p2bDJhZFpqQkJZdU44?=
 =?utf-8?B?VWN3V05RNzVNLzVhZ2ZOSXJQMWlWWmV1bWJrWVcvTHlEN3FwbVF3alVjQ2k3?=
 =?utf-8?B?ZUw0UVkrM2VybWFvMlF6QTIxL3NtbVN0UHZDbXUvbFhWZG15d2IrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0531c3d7-6079-4a02-a3c7-08da1ba2b16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 10:04:40.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqnbFEZbBl+REIvWcMPTmogERfe7rwLSk+Y0UjbMmXRcA+sCCb7wY4rcxKjEY/FWIFwzmmh4n/jPUM0FKDl/yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2132
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBTYXQsIDIwMjItMDQtMDkgYXQgMDk6MDMgKzAwMDAsIEF2cmkgQWx0bWFuIHdyb3RlOg0K
PiA+ID4gKyAgICAgICBtZW1zZXQoJmlkYXRhLCAwLCBzaXplb2YoaWRhdGEpKTsNCj4gPiA+ICsg
ICAgICAgaWRhdGEud3JpdGVfZmxhZyA9IDA7DQo+ID4gPiArICAgICAgIGlkYXRhLm9wY29kZSA9
IE1NQ19HRU5fQ01EOw0KPiA+ID4gKyAgICAgICBpZGF0YS5hcmcgPSBhcmc7DQo+ID4gUHJhY3Rp
Y2FsbHkgYXJnIGlzIG5vdCBuZWVkZWQsIGJlY2F1c2UgYml0c1sxLi4zMV0gYXJlIG1lYW5pbmds
ZXNzLg0KPiA+IE1heWJlIGp1c3Qgc2V0OiBpZGF0YS5hcmcgPSAxOw0KPiA+DQo+ID4gVGhhbmtz
LA0KPiA+IEF2cmkNCj4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gDQo+IHlvdSBhcmUgcmln
aHQgYXJnIGlzIG5vdCBuZWVkZWQgYWNjb3JkaW5nIHRvIGVNTUMgc3BlYy4gIEJ1dCBhcyBJIG1l
bnRpb25lZA0KPiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIGZvciB0aGUgdW5pdmVyc2FsIHVzZS4g
d2UgbmVlZCBpdCBmb3IgdGhlIHZlbmRvci0NCj4gc3BlY2lmaWMgYXJnLiBJIHdpbGwgY2hhbmdl
IGl0IHRoYXQgaXRzIGFyZyB3aWxsIGJlIDEgYnkgZGVmYXVsdCBpZiB0aGUgdXNlciBkb2Vzbid0
DQo+IHNwZWNpZmljIGFyZy4NCkFjay4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBLaW5kIHJl
Z2FyZHMsDQo+IEJlYW4NCj4gDQo+IA0KDQo=
