Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCD4C810C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiCACaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCACao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:30:44 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D601427DD;
        Mon, 28 Feb 2022 18:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646101805; x=1646706605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TarhwZlDwtTiX4Zdkqz4NXCg9glKMtDyLfwyGEzc2Uc=;
  b=dMd89Eh7bNw/aE60CKkXP1LsQmads38NAQPwyWhA/DZ0C6rMrz1CxbV8
   ytzccn01pFv/ZEwIZKY/CH231i4mEfB7CrgkUrSj9bYn/S9RCF2CnNfgN
   Sy2Y8tdk17cPT0ZMhX2qGzSz5rYfaByUKbyLyTf71TER2mlaRux77amau
   M=;
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 02:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSvtGDQkaUXAtEk6bbA3lUwj9iTfBZ1BzEmzdRZgSz+qrkD2R/39KNS4EKbUDuW8TRoq8CUEX53fGBQ5w6vgbrliRmyPORMjKnWcPbWNN+GslcOHYHB/CqX0kAGCZ/7hTe8QM+AAQGkhm/qrVM5fAHufI+K7IbhRapVl30sYKV7hUr3tVjgeBZpEeyu+cDz4F1oHh/v1dBeO9Ls4Xic+SyVwEFG0qKeK6Gizsx8u2sd8sMTLRyiV+mfOTLAiwRIVx4ePl7vvwWcGv1lzUmXvvf2IapblCa63WOQmJxhx9FkKrPN2fgXBtHt91G47lggB2dxWMoZf8mlQOLHJeFJq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TarhwZlDwtTiX4Zdkqz4NXCg9glKMtDyLfwyGEzc2Uc=;
 b=b6xPMUNEAYAYY9vEKeqywGZE63+jHwHkr6M/DvDbi1pXZ6vOJhCOwIsjfdJ4ssENdQnatTYGoFBWp6+sFSnwjRqPYgH1y5w6JIxVKEzAI02exHwbzaVv5UMytazzMlblpDce9k7Odid7XUyIjDrLbq/dx3VtFD7winWsnzxOvYmlkc073BxIO01O3bCpifOItMkPuIFJoIsX4PrWGa6m6Iw9m4imbrgzypMeo/nNJwx67bHrtEw9moUxgOhBUKmzgv//TeFMikOsS3c8u/Eu2Nku/xSR62pga3qW4VqyGxS5thRmpjsv1ABw3MzZTQeDwE10mVaKj1rqPQYiqxIKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8198.namprd02.prod.outlook.com (2603:10b6:8:4::7) by
 DM8PR02MB8293.namprd02.prod.outlook.com (2603:10b6:8:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Tue, 1 Mar 2022 02:30:00 +0000
Received: from DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c]) by DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 02:30:00 +0000
From:   "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
To:     "mka@chromium.org" <mka@chromium.org>,
        "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "ravisadineni@chromium.org" <ravisadineni@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Subject: =?utf-8?B?UkU6IOWbnuWkjTog5Zue5aSNOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjog?=
 =?utf-8?B?bWlzYzogQWRkIG9uYm9hcmRfdXNiX2h1YiBkcml2ZXI=?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFJlOiBbUEFUQ0ggdjIwIDMvNV0gdXNiOiBtaXNj?=
 =?utf-8?B?OiBBZGQgb25ib2FyZF91c2JfaHViIGRyaXZlcg==?=
Thread-Index: Adgm6oYwULNX5ZnjSBCBUX6aFc31LAAADyHwAFiwVAAAH4sXgAAAiy2AAOBepDAAMTAMgAAAYDMQ
Date:   Tue, 1 Mar 2022 02:30:00 +0000
Message-ID: <DM8PR02MB8198F2BFE9E933CC8F2C148BE3029@DM8PR02MB8198.namprd02.prod.outlook.com>
References: <SA1PR02MB86067ACF0C96F18B7306D208903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <SA1PR02MB860660B6F33011E5A97F7930903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhURQAksLKVuzU36@google.com>
 <SA1PR02MB860602E0AC4D9BD0BC4245B5903C9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhXolQDwIMbTi/O2@kroah.com>
 <DM8PR02MB81988555CA6B66BB3FD5E488E3019@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh0UZUU9/9Hd6Pc1@google.com>
In-Reply-To: <Yh0UZUU9/9Hd6Pc1@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9312344e-2b1e-406d-927c-08d9fb2b62d0
x-ms-traffictypediagnostic: DM8PR02MB8293:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM8PR02MB8293287EA34E8C5C891E57B79F029@DM8PR02MB8293.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vn9tMHDeSKb6EmtGpg5nYLrrPnwJ0R1qDpFo6v/lw3oQK27B3fV/yDncnpxNYwNMioHx1pSZexAu9mbrnY5f3A6ybmJWN/YRqIyFtn8QcH1ecO+G10ChyMJmrCgO3nx+CHNj83itkT8YbPKgs/lpRwX1q9cgL33835gL/LU5im6YzxkP6e5itQGPM+01oJ4mvUvabIXaVBG4pgIx7EmkOFteQy19ZlctX+YU5RMdKm2U1wgYQFAm9VjecJfTHjfrMtWqGYFk9IvYYNgp1owA2AxAonwf5DxUoDdDepZRAA23QazRjSOyMqJsLeGhlnQ27WOdmipYd9lnBWdbR2t777nqeo4p/LZRbQwvZu3W2zB2zXlbgMcNuClrcz6sai7re7CQzCn4mh8r0pojy6DFpWJ7MzjVdA6zZ+tVLcXCj6VeEx49Wfla6dUnMOUYWXcYIcSuah18gum4q/t/hv6SwPkI+FRXUvGvoVKqB3dHe9Ez7ZK3XyTNCym8wknip3OHIOolz7ZIr6kEZ3HflAq7HmaW+AHsH+wXEB5NlZhfWqYW42LzkS489tXGLIgxxxIWRZcHXLK30AYpsw8ylIZkYq3svZBcuA/8wwOKSfz5ya5GzZtlWIIK+yqRtDyqZEiz36mHMTtXoSANTc6eO5vJVwqW6r+WPyzraLJH04ttNGbDsdF2V660IBTPeea4BaHkC5DiaLgupjk2PLyvcz/rBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8198.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(38100700002)(2906002)(122000001)(33656002)(86362001)(38070700005)(26005)(4326008)(508600001)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(110136005)(224303003)(316002)(53546011)(7696005)(9686003)(6506007)(54906003)(55016003)(5660300002)(7416002)(71200400001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NllTd29xOVc5VlRoT2VZMW04WFFHRkh1NXgvaCsyaEdkb2pyZkxpeU1nbi9B?=
 =?utf-8?B?UHhxNjFFUFhnalhORzV6SklLcG0zeEcrT3d5MmZxUkQ3UVozeEVHRXplY2Y2?=
 =?utf-8?B?WlU4WDdHS01tOGRwRTVhZmJsWXplSVJ5UENNN3R5YUtQYWNZd0c0V3M1bExt?=
 =?utf-8?B?cWJqS2MxZTBYSjgrSldqRWFiZklxbWF4SU1CUFZBOExzTmRsOTBLanE2ZjJ1?=
 =?utf-8?B?ZmZSZDBTZG5CWGZnTldMVmdWZndaTTJ3YjFkZGNRNnNGQktadXNtcTMySUM5?=
 =?utf-8?B?V2xrSTZrN0Q4NzYwbzkra3k3UEYxNmdPRFhDZWNWb0JjMS9UbDdFYlZYZVJp?=
 =?utf-8?B?ZVN4dlBjNFJmaVhvZzhDbU9nWmFoRzIwK3lrY3JaUGkyVG82MS9xVnU0czhs?=
 =?utf-8?B?cEFZYVlPeXhrOVdYMWlJWncyQ0lHMFJVM3RvdWRpdjhSclByaGw4ZXZVOWd0?=
 =?utf-8?B?UDhwOHhRUTZTNFBEUzh5T01qVU0zSEY1NGVReWF0ZUdlek9KZGtobXk3bkxa?=
 =?utf-8?B?YW9hVlZUVHI5S21PVmo2eFpZNHFyNGZydFp2MFBDclJvTVY1NFduUHU4WXB0?=
 =?utf-8?B?TXNmUHBnRXlITkkzaTg4aysxUytjQWxHZzNYazc3TitEVHZUYU8zSmQzNDNy?=
 =?utf-8?B?eXQzZTgyTTYzL2Q4NGl1amtQTzV0ZTMyV2hMT3FoZlQ5Ynh4b24rMWg5eWpu?=
 =?utf-8?B?OENIYnZyQ0hBSEo1RjN1djdjOVcyVGh4ZS9HbmFwUmhiWWhiUXNxYnhOd2s5?=
 =?utf-8?B?dXRaaVJrNlpjK3J1ZEgraWdLUUdXZDQ3T3RlOThtWkR4bHVlOEJhTWw2K1Nz?=
 =?utf-8?B?SmM5clpOTzZBWCs0UndqU1ZVQ3llcHNnTENHWlYwblcxWEoyTG1vOXZyTFdH?=
 =?utf-8?B?aHYxclcrS29sYjZMV1R1eGRaeG5xNWRKSWEveFcxZTI0YTkwYm5wcEVCZHcv?=
 =?utf-8?B?U0lSV0NmNmFuZVZrWVVsKzVVRjEwbEQ4elZQbVBqdEoxdnJ2NmdZb3N5MmRp?=
 =?utf-8?B?WVVLay94bTJlQWs1K3YxRGJXZUJYSHpvY1cxQlV3bWZ0UWtlWXZoUkVXUDVE?=
 =?utf-8?B?WHFrWnJ1Qk8rK0tabU5qcGgrSFl6MGxOMWJaNlNkSzVLVCt1MTJWb0g5bWJM?=
 =?utf-8?B?U0piS08yQzJsZElQWmpkdGxWV3RES0xvdVFqYkViNTZjMHJ3cHAvZkN5Ulpu?=
 =?utf-8?B?SG9nZTZNRnRHUkpIdktsRkNVekpQdmdwcjBGYmpyTi9BOXB5cG1sVmFpaFNK?=
 =?utf-8?B?M25sVjNnenNFbEpXSlVzRzgrS01reGx6SVlWY1QyelNXbjl3ZkFrS1U1ZjZ6?=
 =?utf-8?B?QzhESnlqT0tUU2F6OG8wenRVbTFGcUEzbkIrSG9pT08wOW1ZdVRnUEQ2OGhP?=
 =?utf-8?B?bnk5V0Zuc2syUGJsVzFKamRhekFjNlplTEtXSnJUSGxpWGxWeTdhR2xuOFhT?=
 =?utf-8?B?NS9TNnRtdGZ3ZjlEdzgxM0ZsaFdJQ0JTMTcva3hTclFoYWpvS2c2TFRXNjZM?=
 =?utf-8?B?UFVvbmRnc2YyaWV5QnBjOEJHNldOb21CdzNXNzBCY2RuK3FXK2Iyc2tHaUd0?=
 =?utf-8?B?dnJSd0s4MUVrWVpGMmw4K3AzOW5ndUlRMXhuTU4xMW5qeGNXWUFQVzBYemNK?=
 =?utf-8?B?ZUtZa2s2bmE2UStXNFVOOTJ0eFdiZU41MjU2VzI5bkVoMGlXT2NSZnhUUmJD?=
 =?utf-8?B?Z0ZIV0RFZmpzdC9idGJlTW1uZEUrTTAxaG1sYi9NTk8xNHg5SEdOSGhqN0I1?=
 =?utf-8?B?NDBOTmUyUGYycTNtM3Vtd3Zxb3dRUFNWVjd5dm5sNUJ3Qlh5djh3ZElWOEdK?=
 =?utf-8?B?US9ZS2pZWGR4cGJaU2NxNEFXYTUxRk1IN2I0MzlaUkh5cWx4a0QrZFNKbnNW?=
 =?utf-8?B?UFhqSUJJSlNsREh1bi9nOVZnZWZwMmxrM2lkWTdtVmdOMW8zbkJQWjJmV2Nn?=
 =?utf-8?B?QWh4UDNGbG55MEdDcnNISk90bUNkSndhS01pUFdWeXh3NFF3U01QeXl1MFVW?=
 =?utf-8?B?SmUrU3hkbzRVWjVodi9zWmlvRkZhS3B5L05KU2lTc1BRTnVUSUw3Y29jaVho?=
 =?utf-8?B?ZTlWWVE0ZlRNSXR5Sno3cXpsNjNWUXNnM1l0ODhLL2RmSE5jaXVKVlNzUGFH?=
 =?utf-8?B?N3hZL3BFVXBxYVFHTGJxaGxQMUFwRHBBd3ZmMUpPdHIxSUQyY3ZhZ29abU0y?=
 =?utf-8?B?OGd4M2I5TWhPTzgyUEZlWGlTWDQ3VzZKd2NiKzJoUWxPWGJ2Y2kxdW42bXNw?=
 =?utf-8?B?ZFFFd2JIL0xaRUcyYlh5NEZQRG9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8198.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9312344e-2b1e-406d-927c-08d9fb2b62d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 02:30:00.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnsPUH8gGAwnFZLFBwLZ9EkXN0mFo+/N3FHB0eTgAGZecZguXi4BWGlKA+OgA1m4jHPsyBSHfLjm29LdsoTI3mrgqi35eq0Re2/NU7bxs8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8293
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBta2FAY2hyb21pdW0ub3JnIDxta2FAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBUdWVz
ZGF5LCBNYXJjaCAxLCAyMDIyIDI6MjkgQU0NCj4gVG86IExpbnl1IFl1YW4gKFFVSUMpIDxxdWlj
X2xpbnl5dWFuQHF1aWNpbmMuY29tPg0KPiBDYzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7
IFRhbyBXYW5nIChDb25zdWx0YW50KSAoUVVJQykNCj4gPHF1aWNfd2F0QHF1aWNpbmMuY29tPjsg
YmFsYmlAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRpYW5kZXJz
QGNocm9taXVtLm9yZzsgZnJvd2FuZC5saXN0QGdtYWlsLmNvbTsgaGFkZXNzQGhhZGVzcy5uZXQ7
DQo+IGtyemtAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
dXNiQHZnZXIua2VybmVsLm9yZzsNCj4gbWF0aGlhcy5ueW1hbkBpbnRlbC5jb207IG1pY2hhbC5z
aW1la0B4aWxpbnguY29tOw0KPiBwZXRlci5jaGVuQGtlcm5lbC5vcmc7IHJhdmlzYWRpbmVuaUBj
aHJvbWl1bS5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gcm9nZXJxQGtlcm5lbC5vcmc7IHN0
ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU7IHN3Ym95ZEBjaHJvbWl1bS5vcmcNCj4gU3ViamVjdDog
UmU6IOWbnuWkjTog5Zue5aSNOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjogbWlzYzogQWRkDQo+
IG9uYm9hcmRfdXNiX2h1YiBkcml2ZXINCj4gDQo+ID4NCj4gPiBIaSBHcmVnIGFuZCBta2EsDQo+
ID4NCj4gPiBMZXQncyBtYWtlIGl0IGNsZWFyIHRoYXQgd2UgYXJlIHRhbGtpbmcgYWJvdXQgb25j
ZSB0aGlzIGRyaXZlciBpcyBhcHByb3ZlZA0KPiBpbnRvIHVzYiB0cmVlLA0KPiA+IElmIHdlIHVz
ZSBkaWZmZXJlbnQgVVNCIEhVQiB3aGljaCBoYXZlIFZJRC9QSUQgbm90IGRlZmluZWQgaW4gdGhp
cyBkcml2ZXIsDQo+ID4gV2UgbmVlZCB0byB1cGRhdGUgdGhpcyBkcml2ZXIuDQo+ID4NCj4gPiBC
dXQgaWYgd2UgZGVmaW5lZCBWSUQvUElEIGluIGRldmljZSB0cmVlKGZvciBhIHNwZWNpZmljIGJv
YXJkLCBtYW51ZmFjdHVyZQ0KPiBzaG91bGQga25vdyBWSUQvUElEIGZyb20gSFVCIGl0IHVzZWQp
LA0KPiA+IGR5bmFtaWMgcGFyc2VkIGJ5IHRoZSBkcml2ZXIsICB0aGVuIHdlIGRvbid0IG5lZWQg
dG8gY2hhbmdlIHRoaXMgZHJpdmVyDQo+IChpbmNyZWFzZSBWSUQvUElEIHRhYmxlKS4NCj4gDQo+
IEFzIHBlciBteSBlYXJsaWVyIHJlcGx5LCB0aGUga2VybmVsL1VTQiBjb3JlIHVzZXMgdGhlIFZJ
RDpQSUQgcmVwb3J0ZWQNCj4gYnkgdGhlIFVTQiBkZXZpY2UsIHRoZSBjb21wYXRpYmxlIHN0cmlu
ZyBpbiB0aGUgZGV2aWNlIHRyZWUgaXMgcHVyZWx5DQo+IGluZm9ybWF0aW9uYWwuIFRoYXQncyBu
b3Qgc29tZXRoaW5nIHRoYXQgY291bGQgYmUgY2hhbmdlZCBieSB0aGlzDQo+IGRyaXZlci4NCkkg
Y2FuJ3QgZnVsbHkgdW5kZXJzdGFuZCB0aGlzIGNvbW1lbnQsICBjb3VsZCB5b3UgcGxlYXNlIHNo
YXJlIHN0ZXAgaWYgd2Ugd2FudCB0byBhZGQgYSBuZXcgSFVCIHN1cHBvcnQsIHdoYXQgc2hvdWxk
IHdlIGRvID8gbm90aGluZyA/DQoNCklmIGRvIG5vdGhpbmcsIGNhbiB3ZSByZW1vdmUgaWRfdGFi
bGUgZnJvbSAgb25ib2FyZF9odWJfdXNiZGV2X2RyaXZlciAgPw0KPiANCj4gQW5kIGV2ZW4gaWYg
dGhlIFZJRDpQSUQgZnJvbSB0aGUgZGV2aWNlIHRyZWUgd2FzIHVzZWQ6IGhvdyBpcyB0aGUNCj4g
a2VybmVsIHN1cHBvc2VkIHRvIGtub3cgdGhhdCB0aGUgb25ib2FyZF9odWIgZHJpdmVyIHNob3Vs
ZCBiZQ0KPiBwcm9iZWQgZm9yIGEgZ2l2ZW4gVklEOlBJRCBmcm9tIHRoZSBkZXZpY2UgdHJlZSwg
d2l0aG91dCBsaXN0aW5nDQo+IHRoZSBWSUQ6UElEIChvciBjb21wYXRpYmxlIHN0cmluZykgaW4g
dGhlIGRyaXZlciAod2hpY2ggaXMgd2hhdA0KPiB5b3Ugc2VlbSB0byBzZWVrIHRvIGF2b2lkKT8N
CkluIG15IG9waW5pb24sIGlmIGl0IG5lZWQgdXBkYXRlIFZJRC9QSUQgdGFibGUgaW4gdGhpcyBk
cml2ZXIgdG8gc3VwcG9ydCBhIG5ldyBIVUIsDQp3ZSBjYW4gcGFyc2UgVklEL1BJRCBmcm9tIGRl
dmljZSB0cmVlIGFuZCBjcmVhdGUgZHluYW1pYyBWSUQvUElEIGVudHJ5IHRvIGlkX3RhYmxlIG9m
IG9uYm9hcmRfaHViX3VzYmRldl9kcml2ZXIuDQoNCkhvcGUgeW91IGNhbiB1bmRlcnN0YW5kIHdo
YXQgSSBzYWlkLg0K
