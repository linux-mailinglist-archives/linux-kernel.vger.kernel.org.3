Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003DD5B27CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIHUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIHUgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:36:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C95A9C13;
        Thu,  8 Sep 2022 13:36:16 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 288JMcqZ020755;
        Thu, 8 Sep 2022 13:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LOOAFLC4Y8kU+dsf3RwM9OVgMez0arH11n8DrJAyrdY=;
 b=oF7CqQYSigrPzFD/sc8/EbdZUkfyMK9OVle6gcwUFZCC5cBYreLn+Uw3n55rYGoVVY5R
 gMKrYletCf1lhUuu3wwqY4yn9zHC+kObWBX2xpwg6GGqvJrsOiJuc/rqTJTfZHD+UxBC
 gcxF+wpu/Pl7uWaJdMxRdOi1TRP4J7laT6E= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jfbrud1tg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOYyQyEEi+3SYm4D8oEikHVMGZoMRLFPOEw5PPt9LWz2C3rsXKTgj82SHreoHC0fE5dqlpvdUpkIeEtadaVA0RiV2oMDxTj9dQK9AcWAk5isCT5PzDsWJkMaYqqtn4uQwzpT3vk5dlBJEk5R++hF4doTaPFriRhA4yKONyArjgCANPAhIuTWWdwoKFg3F3a5K2VSyzUA1jKqWWftQmqw7VO8yTZ1399qAYpvuW6tqX5bgwnVLM3lw/vXjbFDDy+PlRrLmNNnagFKXxx/3oXboI2z4B4dNWruWIgp3pObqhlwqd9Yq3ki8UipRwMBaZuqahb5ea1A/kotxMhmAr1oJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOOAFLC4Y8kU+dsf3RwM9OVgMez0arH11n8DrJAyrdY=;
 b=cW2Q5esiiqItroyYeJtSMg2b/BJJ7dEf/bKc34Z6mAqykUgOMyw4Webca4CuZVYyq/st7K2wiSWNgr/xMPfoVvRVQ/ZdYOdhJRO9BOAM4H0F61362wPt/dDsBgms2gmC3dJ5mau06OujeX1LEMICmb/h0CgFuXD8MoKadVlub4eyttIz2haLoKp1ZmhIsSFRF9j/5eV2VuvG6rIkTpHH91NMtRR9tCvY6xVuRq/qLCSy9oLL+s34dut4+F7U4EfRBBfeQ8IknH9AtDN+FTepnhPvjxWgJDrCMgh6maqxvVmQ01Z8pytC1E/Q7St91xTfwynLKLvopAN+laoG/FvaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 8 Sep
 2022 20:36:13 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 20:36:13 +0000
From:   "Jonathan Zhang (Infra)" <jonzhang@fb.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Thread-Topic: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Thread-Index: AQHYvRILPgGvtGLjek2fcCbQeRsbya3VEbGAgADciQCAABBTAIAADJMA
Date:   Thu, 8 Sep 2022 20:36:13 +0000
Message-ID: <14D1BEC2-4921-46AD-B767-3A7E555F6E97@fb.com>
References: <20220831081603.3415-1-rrichter@amd.com>
 <631980ff90319_58016294cc@dwillia2-xfh.jf.intel.com.notmuch>
 <17F02AD3-D68A-4E6A-A549-A47611B335E7@fb.com>
 <631a47b0326e_166f294a7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <631a47b0326e_166f294a7@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|SA1PR15MB4644:EE_
x-ms-office365-filtering-correlation-id: 09a3c9fe-72d9-4ea4-8216-08da91d9c56e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yPu7kcTnuEdiO6ukyBg5+ugYhTdUV2X0Pxzj9djiVt1HGdfSCiJUO9OmihwxRhf8mAwdXCFLmnKM1fsguyrJl3g2iNM2eeIPbdUSAuwYcujw+Cw46/3hI/mCNvD82jtUsYHtuVYVN5TJAPJp8CUGD8lLJZACE+cY0bfWt3GTb6WkTLLUG8xrwrLSXvdqSCONGGQE5p8Rw5B8R9fl4GpYNjMRe2cT6xCfo2GeOPSabV3T+FnjIxGN22kpSlIoRKE/Gtu93GFiMmi6GPX/xYSmraQWc/3Wmys0oaJNnaQFPWL0GeuiuTGKIckoeDWqRqT5Ptukte+IdIdctGn1Gy4NbXLakY2WrqHJNcB9C5AGYA78ltRCRBc8ApOuD82J+28PwHg9AAMKIPrqrKVae6qwpfw4BAVeXvzhdAQR3eKm37N/zawiH76zcCBi88krS97SKT9ufTiCAnie78gzGVD0s48L0U767xWv5PjkFlGJdqijKfH1xG7V/sFW5O8fKjL38pbIqXjC/TY+5wkiq+zbJAHX+mLUTLoVbbu8EDjDJScXG8BdFX10OYLSs+M9Fd1hV/19zWRg/57lIeZOCpymsKPRFiArWqkQo0ba9maH4YURfUd4QykdA7iuI+uTVlJ1m8lbKeRQvpl7BUlnGX8DRfMGdleHb0+IjOxjbede2oTIaCWBcJvgrhT0F26ih1avkzBYfg0+/JaC319aMPXADGrYrWF6yBpy/PK9hW3sUUrg+J8Qa161Iz5xGnU9iz+mECjO51VuRSEvsziaUJhuZDNqYb3WWXZz9v8WNfeYiE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(122000001)(38100700002)(76116006)(8676002)(4326008)(316002)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(33656002)(36756003)(86362001)(38070700005)(2616005)(83380400001)(478600001)(6506007)(6512007)(53546011)(41300700001)(71200400001)(6486002)(54906003)(6916009)(2906002)(7416002)(186003)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RStic0gya21mTGNEa3QyczJFTGUrbkFQb2pxR3kxQmw0MFdMVCtpN0R6d2pN?=
 =?utf-8?B?QlIybWhzdEpjLzhjaWtNeUpDRjhRUUF3b0QwSVZybDU1dklaSXRPSjBHOEta?=
 =?utf-8?B?WURuWGxqMDE1SVRuekx1WHovTnZEUE1saFFTNGJ2N2V3ODlRTVBnZ1dxNE44?=
 =?utf-8?B?b0hIU0N6YkFtMkVLcGdndzB2dnY2VlpwK1BRQkFxSGRWQ0N3aGUvMXVJdkJT?=
 =?utf-8?B?U0I5a1VIcEZpdFNuNS9FUjVETklKdlZRRFRHVmR6a1kxdmRIMVNYeWZnV1l1?=
 =?utf-8?B?czduVVFqK1NaSVAwazRVQ01DeG83Qzl2WFJtaWFvMWY0dC8wS0FMWGNDckRC?=
 =?utf-8?B?U0MvSmdaNmZDVDJLcXRoSlltRmwwQUNhWVc3UHpNL3d6Rlk3Vmlnb0U4Zkg4?=
 =?utf-8?B?SXNKM1VFWUpodlpPTHlnVXFFSXZMeHU1NnJRcjE0Kzl3MGJNMzZDMDFmYnFm?=
 =?utf-8?B?bzV4MWRyU0hObHRySTZYUnNLSUxFOGhra3Q5NUNKMmFYaVZKS2hQOU1ydFZP?=
 =?utf-8?B?YnFnaEV6bEU5Nm1YMWZqTklpbWN3aVFiVVdEVmExQWpPNHZnSVZ1cjdiSERO?=
 =?utf-8?B?S0xreHRmdk9Uem93L3hxcnVMNjZCNkJ5YUU1ZWZvNlJXZVZHa3hqTWtzTEZS?=
 =?utf-8?B?eWVGRERHMS8ralFEL3oyTDQ1M0YzMGN2Y3NjUi9Lc3o5dERRWUM0d003SFZ3?=
 =?utf-8?B?aUJ4UTVyQk5lSURRbkh1QlFjM20rRG9sZTl1OXJuOHdISWZQV1JOTWxXcTJP?=
 =?utf-8?B?WGRTbVA0aWRwN3h6azcvWkZBN1RGZCtEbjBjLzZhbHZoa2pQTy9ZZkRxY1M1?=
 =?utf-8?B?M2R2Q1RRQ00xbFJTV0ZHenFaVWY3V2hBeWpsbGhEYWROYkxaaDlScE9zS2sv?=
 =?utf-8?B?aWluTWZpL1pSczdRbjRZQTN5SStZcTVKUFdRNlR6UktxTGRIWnFLbTJRdkNk?=
 =?utf-8?B?QVoyc2dxVGkvR1gzRUlVTlhnVEF4ankrWjZTMHZGTmJDS0ZFVTBwQlpqWEE2?=
 =?utf-8?B?YUFnWDh5dDUzS1NWcFlGelZEWDNRU2d0cHpYZGpCSXUvODJsSm9SWldsWGpI?=
 =?utf-8?B?dm1KZk9sUzhxSWpvcVpieDNGVDFIL0hIZDdVKzkzc3MwbVJvWGVYdElxWnJT?=
 =?utf-8?B?dERodHhZdnFkWjd4c0pmRXhXNGtnT2o3SU5lOTAzUTJ0bmJuOGx6Y3dvQnJn?=
 =?utf-8?B?TXhBUnFvRFNxT01VdTV0YUlJL2hVWEJmY1N6QW9RQVVyNHhQVVFpblJjdGJM?=
 =?utf-8?B?TFN1c0JkN0ZqWVh1bS90K2lLVUxmNzZFUHdrNjgvdjFjUkhqd2RJU0pYNG8z?=
 =?utf-8?B?ME8zdFMzdTUxUDRCdGcyaVZORjdYRHpma3lFelV3QVNzUXNLbnNUWEFPdHVq?=
 =?utf-8?B?aStFbGI1cVBwaVNUN0NJTmNLQ0Z1V1hlcVVINFY5aDEvSk1kMEZIelU1MlpE?=
 =?utf-8?B?L2cwWEF0cDZGcUtQNzdyNm10RmY1VFV4WkpWb3ZOWXFmd3AyV1luUjVlVkV4?=
 =?utf-8?B?ckw2MjREdi9BUlRUL2d0ZUZucVhWUmxDMVo0WFo0dUp6Njg4bzdZa3IvaERJ?=
 =?utf-8?B?VUROQVBvN2ttdG5xQUowakhYTlc2M0Q3U01tbEdnbXdPTHl3ZytSQS81SUwz?=
 =?utf-8?B?a2M2QkgzYVhRaEthcU5mYmpobktvN3RhM3UvaG16MklvWFpQZ0w1MVVSbHl1?=
 =?utf-8?B?NU9NVSthSFBMSEhDRE9rNWE5N1ZKWm4zdiszRXNJVHZ2S2ppaHg5OHZ0Smxi?=
 =?utf-8?B?dDRYOWZSMlk2R1lLUTlJeG4vZFBMV21uVkFsK0lZOGZ4ZjcvRkltU2IxSEl2?=
 =?utf-8?B?aHRZem9qczVUbXV5UHl2TTlvNUlVOThnZk5NaG56UENrenZhMVBGaEtKcGkv?=
 =?utf-8?B?REcwak9aV0U2aFdISXZvNkNpNjZ5cll0dFpwNnB4SlBTMytreSttK1ZEaERR?=
 =?utf-8?B?YWdRSko1bGxSaXlQbFJFMjBSanNJNlpTQkF0SDhsaDFUQUNRbXozbk02OTF3?=
 =?utf-8?B?cEl6TEhwOGg0Z0Mrc21vamZad0V3QjF0NFhXeEk0NEJhblRYWVd3VGs4Unc4?=
 =?utf-8?B?cDBVZWhTcGlvbE52ZHgrUkxNaHN6cHBXVEFtSHBlN3YrUXZtczcwN1BZQyt2?=
 =?utf-8?B?MWtXam1BMDgvd3pRQUlFUmVzendYMDhHbnMrSnZjYlVUaWU2Z1c0dDYycEVO?=
 =?utf-8?Q?2UwIRNz4V4lpz18+fVEdYX0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E2108DAAC46D94997204D99A8BF7726@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a3c9fe-72d9-4ea4-8216-08da91d9c56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 20:36:13.2474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tN+bm9qxKNNYyIQu9bqKMe760WcjENGi/l0c2fJWf+UBbPg0TnX1bSsRok8UtYkn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-Proofpoint-ORIG-GUID: SVWStoYbafDpE0lPNyTlK_wPsCQn2T4E
X-Proofpoint-GUID: SVWStoYbafDpE0lPNyTlK_wPsCQn2T4E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDgsIDIwMjIsIGF0IDEyOjUxIFBNLCBEYW4gV2lsbGlhbXMgPGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIFRoaXMgTWVz
c2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0K
PiBKb25hdGhhbiBaaGFuZyAoSW5mcmEpIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBTZXAgNywg
MjAyMiwgYXQgMTA6NDMgUE0sIERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29t
PiB3cm90ZToNCj4+PiANCj4+PiBBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiBnZXR0aW5nIHRv
IHRoaXMgSSBoYWQgaG9wZWQgdG8gYmUgYWJsZSB0bw0KPj4+IGZpbmlzaCB1cCBzb21lIG90aGVy
IERBWCB3b3JrIHRvIGZvY3VzIG9uIHRoaXMsIGJ1dCB0aW1lIGlzIGdldHRpbmcNCj4+PiBzaG9y
dCBzbyBJIHdpbGwgbmVlZCB0byBkbyBib3RoIGluIHBhcmFsbGVsLg0KPj4+IA0KPj4+IFJvYmVy
dCBSaWNodGVyIHdyb3RlOg0KPj4+PiBJbiBSZXN0cmljdGVkIENYTCBEZXZpY2UgKFJDRCkgbW9k
ZSAoZm9ybWVybHkgcmVmZXJyZWQgdG8gYXMgQ1hMIDEuMSkNCj4+Pj4gdGhlIFBDSWUgZW51bWVy
YXRpb24gaGllcmFyY2h5IGlzIGRpZmZlcmVudCBmcm9tIENYTCBWSCBFbnVtZXJhdGlvbg0KPj4+
PiAoZm9ybWVybHkgcmVmZXJyZWQgdG8gYXMgMi4wLCBmb3IgYm90aCBtb2RlcyBzZWUgQ1hMIHNw
ZWMgMy4wOiA5LjExDQo+Pj4+IGFuZCA5LjEyLCBbMV0pLiBUaGlzIHNlcmllcyBhZGRzIHN1cHBv
cnQgZm9yIFJDRCBtb2RlLiBJdCBpbXBsZW1lbnRzDQo+Pj4+IHRoZSBkZXRlY3Rpb24gb2YgUmVz
dHJpY3RlZCBDWEwgSG9zdHMgKFJDSHMpIGFuZCBpdHMgY29ycmVzcG9uZGluZw0KPj4+PiBSZXN0
cmljdGVkIENYTCBEZXZpY2VzIChSQ0RzKS4gSXQgZG9lcyB0aGUgbmVjZXNzYXJ5IGVudW1lcmF0
aW9uIG9mDQo+Pj4+IHBvcnRzIGFuZCBjb25uZWN0cyB0aGUgZW5kcG9pbnRzLiBXaXRoIGFsbCB0
aGUgcGx1bWJpbmcgYW4gUkNIL1JDRA0KPj4+PiBwYWlyIGlzIHJlZ2lzdGVyZWQgYXQgdGhlIExp
bnV4IENYTCBidXMgYW5kIGJlY29tZXMgdmlzaWJsZSBpbiBzeXNmcw0KPj4+PiBpbiB0aGUgc2Ft
ZSB3YXkgYXMgQ1hMIFZIIGhvc3RzIGFuZCBkZXZpY2VzIGRvIGFscmVhZHkuIFJDRHMgYXJlDQo+
Pj4+IGJyb3VnaHQgdXAgYXMgQ1hMIGVuZHBvaW50cyBhbmQgYm91bmQgdG8gc3Vic2VxdWVudCBk
cml2ZXJzIHN1Y2ggYXMNCj4+Pj4gY3hsX21lbS4NCj4+Pj4gDQo+Pj4+IEZvciBDWEwgVkggdGhl
IGhvc3QgZHJpdmVyIChjeGxfYWNwaSkgc3RhcnRzIGhvc3QgYnJpZGdlIGRpc2NvdmVyeQ0KPj4+
PiBvbmNlIHRoZSBBQ1BJMDAxNyBDWEwgcm9vdCBkZXZpY2UgaXMgZGV0ZWN0ZWQgYW5kIHRoZW4g
c2VhcmNoZXMgZm9yDQo+Pj4+IEFDUEkwMDE2IGhvc3QgYnJpZGdlcyB0byBlbmFibGUgQ1hMLiBJ
biBSQ0QgbW9kZSBhbiBBQ1BJMDAxNyBkZXZpY2UNCj4+Pj4gbWlnaHQgbm90IG5lY2Vzc2FyaWx5
IGV4aXN0IA0KPj4+IA0KPj4+IFRoYXQncyBhIGJyb2tlbiBCSU9TIGFzIGZhciBhcyBJIGNhbiBz
ZWUuIE5vIEFDUEkwMDE3ID09IG5vIE9TIENYTA0KPj4+IHNlcnZpY2VzIGFuZCB0aGUgQ1hMIGFz
cGVjdHMgb2YgdGhlIGRldmljZSBuZWVkIHRvIGJlIDEwMCUgbWFuYWdlZCBieQ0KPj4+IHRoZSBC
SU9TLiBZb3UgY2FuIHN0aWxsIHJ1biB0aGUgY3hsX3BjaSBkcml2ZXIgaW4gdGhhdCBjYXNlIGZv
ciBtYWlsYm94DQo+Pj4gb3BlcmF0aW9uLCBidXQgZXJyb3IgaGFuZGxpbmcgbXVzdCBiZSBmaXJt
d2FyZS1maXJzdCB3aXRob3V0IEFDUEkwMDE3Lg0KPj4gRmlybXdhcmUtZmlyc3Qgb3IgT1MtZmly
c3QgYXBwbGllcyB0byBDWEwgcHJvdG9jb2wgZXJyb3IgaGFuZGxpbmcuIEZvciBDWEwgDQo+PiBt
ZW1vcnkgZXJyb3IgaGFuZGxpbmcsIHRoZSBkZXZpY2UgZ2VuZXJhdGVzIGEgRFJBTSBlcnJvciBy
ZWNvcmQsIHRoZSBPUw0KPj4gcGFyc2VzIHN1Y2ggcmVjb3JkIGFuZCBhY3QgYWNjb3JkaW5nbHku
IEFjY29yZGluZyB0byBDWEwgc3BlYyAoc2VjdGlvbg0KPj4gOC4yLjkuMi4xLjIgRFJBTSBFdmVu
dCBSZWNvcmQpLCBEUEEgYnV0IG5vdCBIUEEgaXMgaW4gc3VjaCByZWNvcmQuIFRoZSBPUw0KPj4g
bmVlZHMgdG8gdHJhbnNsYXRlIHN1Y2ggRFBBIGludG8gSFBBIHRvIGFjdCBvbi4gSSBhbSB0YWtp
bmcgdGhpcyBhcyBhbiBleGFtcGxlDQo+PiB0byBzaG93IHRoYXQgT1MgQ1hMIHNlcnZpY2VzIGlz
IG5lZWRlZC4NCj4+IEluc3RlYWQgb2YgdXNpbmcgQUNQSTAwMTYgdG8gdGVsbCB3aGV0aGVyIHRo
ZSBzeXN0ZW0gaXMgdW5kZXIgUkNIIG1vZGUsDQo+PiBJIHN1cHBvc2Ugb25lIHdheSBpcyB0byBj
aGVjayDigJxDWEwgdmVyc2lvbuKAnSBmaWVsZCBvZiBDSEJTIHN0cnVjdHVyZSBpbiBDRURUPw0K
PiANCj4gVW5sZXNzIHRoZSBPUyBoYXMgbmVnb3RpYXRlZCBDWEwgX09TQyB0aGUgQklPUyBvd25z
IHRoZSBldmVudCByZXRyaWV2YWwNCj4gYW5kIHRyYW5zbGF0aW5nIGl0IGZyb20gRFBBIHRvIEhQ
QS4gSSBkbyB3YW50IHRvIGFkZCBPUyBDWEwgc2VydmljZXMgdG8NCj4gTGludXgsIGJ1dCBvbmx5
IGluIHRoZSBjYXNlIHdoZW4gdGhlIEJJT1MgaXMgYWN0aXZlbHkgZW5hYmxpbmcgT1MgbmF0aXZl
DQo+IGFkZHJlc3MgdHJhbnNsYXRpb24gd2hpY2ggaW5jbHVkZXMgcG9wdWxhdGluZyBBQ1BJMDAx
NywgQ0ZNV1MsIGFuZA0KPiBkZXZpY2VzIHdpdGggdGhlIEhETSBkZWNvZGVyIGNhcGFiaWxpdHkg
cmVnaXN0ZXJzIGluc3RlYWQgb2YgRFZTRUMgcmFuZ2UNCj4gcmVnaXN0ZXJzLiBFdmVyeXRoaW5n
IGVsc2UgaXMgZWFybHktZ2VuIENYTCB0aGF0IGlzIDEwMCUgQklPUyBzdXBwb3J0ZWQsDQo+IHNp
bWlsYXIgdG8gRERSIHdoZXJlIGEgZHJpdmVyIGlzIG5vdCBleHBlY3RlZC4NCg0KDQpJdCBtYWtl
cyBzZW5zZSB0aGF0IHRoZSBCSU9TIGFuZCBPUyBuZWVkIHRvIG5lZ290aWF0ZSBDWEwgX09TQyBz
byB0aGF0IE9TDQp3b3VsZCB0YWtlIGNhcmUgb2YgYWRkcmVzcyB0cmFuc2xhdGlvbi4gVGhhdCBi
ZWluZyBzYWlkLCBvbmx5IERWU0VDIHJhbmdlIA0KcmVnaXN0ZXIgKGJ1dCBub3QgSERNIGRlY29k
ZXIgY2FwYWJpbGl0eSByZWdpc3RlcikgaXMgYXZhaWxhYmxlIHdoZW4gdGhlIGRldmljZSBpcyBp
bg0KUkNSQiBtb2RlIChzZWN0aW9uIDkuMTEuOCBmaWd1cmUgOS03KSBhdHRhY2hlZCB0byBhIFJD
SC4gVGhpcyB0eXBlIG9mDQpjb25maWd1cmF0aW9uIG5lZWRzIHRvIGJlIHN1cHBvcnRlZCB3aXRo
IE9TIENYTCBzZXJ2aWNlLg0KDQo=
