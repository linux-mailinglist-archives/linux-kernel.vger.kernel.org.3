Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655E4F21B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiDECQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiDECQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:16:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5276208C27;
        Mon,  4 Apr 2022 18:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYgONN6hoHXuO1oGjcX3SZKhXU8ZSOwalw8kNUzCeHHcKBYSWlwfYxmGQbZ2tH++C8A9rSAzh/pcCtMTjE38RyE+hiypWOLqWZWF6ld5YvfCdqlV8Y3c5imXK12I20QFedW9RpE473u2TZAxwgImwAAQ5yijmjJteOamBrWa/h+fMAnDlCRJp8EyuMvSW2BwM6ObuuN33Ry4ymagbYwev2U+e+UQ5ulCNTehZ7X2xuwnaukhoogXccrcoCKs0CFQ/aLnDoqL6Fnlll4Tp3ZK7bouIlu0OBYiUTsiA6e8aZHuCcyNpYZdM6hYN7w7x1IhNiEY9c/25cmHGFuSfNgW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk7g6hScuADTBDk6Y1XLocjd7G4Wd/ZYh319tQ89F1A=;
 b=V3HtAyhKsMsct6pRaobmWYXvs85e1bLGNmBTaG8C6T3zZSmFZaQ9aZB+fmq34aO++A7wqVeN/vsxjE5D595fFDrsgEy600SEWpC+X0D8dsLxIysCgPAL/fxdTppmW3eg9eOzXBSE5Jf6MqZtFma15Nn6dmAjVcker1+9jg7hBR4O+WyiHQVjYgHR8Zj6Tz4SSi6+XZeP9tXQTVwv3mrbpHa/F8E/EGV940p0016jvS7ycBxD/cPaAnbYqJh/51mF3MBbYirSm9Lme0UzCX8BDqOCU3LkQ8VRyJfbvUR1va31kCmaDWJWvyDWXtb/dYX0GthMfuukuEW8DTn35bGCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk7g6hScuADTBDk6Y1XLocjd7G4Wd/ZYh319tQ89F1A=;
 b=s7NGWZ16YZS7klI9F3T9AH0d6mgvoSayNSU56hUGOroLO8DYXkmYi2GJEKiQfafZbnV4pOg2jfgrCVZxO5AhOUzeNo75osAga9AEqtZGoA1qY9fyJVCuvHCZj+541PuzV6OwFCrKHCWHVLU0Dt1i6+ILJjFk58ezaEmJcERYOM0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 23:53:20 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 23:53:20 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: RE: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Thread-Topic: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Thread-Index: AQHYLrH7kpm3AkPxAE2eIMYLz1fgLqzfJECAgAE1rICAAECigIAABfLg
Date:   Mon, 4 Apr 2022 23:53:20 +0000
Message-ID: <BL1PR12MB5157A4E10393E7812320CEF6E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220303034912.3615390-1-mario.limonciello@amd.com>
 <20220303034912.3615390-2-mario.limonciello@amd.com>
 <a6a17a22-0cde-9c46-0cd7-127be2cd2792@opensource.wdc.com>
 <BL1PR12MB51570E1C17A122179CCB0625E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
 <fa0ade52-5d7b-88ae-5c68-c53c2968b852@opensource.wdc.com>
In-Reply-To: <fa0ade52-5d7b-88ae-5c68-c53c2968b852@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-04T23:53:18Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e7d5625c-7900-4705-ae94-0634c3d7a711;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-04T23:53:18Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: e99e7f3d-407c-4200-b2b6-ad8e3e3cec27
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed4369b3-df00-4edc-309b-08da16964bf2
x-ms-traffictypediagnostic: DM6PR12MB4073:EE_
x-microsoft-antispam-prvs: <DM6PR12MB40733018DD83D0645EB6E243E2E59@DM6PR12MB4073.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFPWtb3ZI0KsrzOZNe6w4/ZcTprdR+Y5/NgXxD36wY4muu4orU7901rdHb2ZtaQSq74kfYQBhuRQT18VmstcjUqHx/jfBUJWaZ8y2eAvJ/Gih2b7RM19D8JdCgYh3QNt2mfDXSgXoDGtL+e99Nql4tuPu/Mq97U/NwEW/AtIs4lct7/yUk2/udFZOF2OyCIpDmeS83MMC8RBerRNT2irHWEtw2LH/fbFUuNrvnkNkBCDz4EEyU5tuNyvbYXPVrvo6BdcyxsRJWNU/hIMuERh+wrAlUYAp8gC93qPIM/OTOlPhvapkOlH1aikFwXz9gXje5I+EIrUWy8n0bIJl9RrhONw4kURjbUkOw8cGsvIHwxM0VgodJOlQerJMTNmLE7LL7+481NAgfjcD68LRYeOUeXyuPLOn4/72kG5ITDH1AioO3UWT92p0XuIpBxGBcPAad1WPhEjKefjyrCaDucWPYv+GQi00MTighctQkqL29/wJzDxSxR2WVGu86Q27Fk5jqrdOWSjt8wOaGKHzSex0lx8hve4buBGgYFNCvjuut8Sn8qK48DjSDUn+Kp/05RVMgSPcqLSVq+CkI7dNUXiPXIqHOsuyGUbey55Z5GeqeFhFeGVntpDFq04bxiGkCD1nViVpF2rCZP4n2VbYZA6/9fmhd/MoIF8SbegxTEHUiSToATJTlHEv8w00DYUy86R3xIBFqG1Ym4R3fxQeowAOZCbcy+8SmB4N1Eep8di/dk5zTHeMkM1Q6PvWA4mT7ZA6l/IgXjnusxwEHxkg4VuhFS79t4TLVUkc2KvkL58dVM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(2906002)(8936002)(55016003)(52536014)(33656002)(86362001)(5660300002)(38100700002)(122000001)(38070700005)(54906003)(66476007)(53546011)(7696005)(6506007)(66556008)(6916009)(66946007)(9686003)(64756008)(4326008)(8676002)(66446008)(76116006)(508600001)(186003)(966005)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZ4SURQNGtkQ2loM2w5aGhTdjNQdk9GalNtQndRRTdHMm5MeStKY0J2V3Fl?=
 =?utf-8?B?VkRsZUFnYmRsOTExQ1dPaG1wK0JzU3IwZVNvM0lCQ3l5NzUrR3RxSlhBbi9B?=
 =?utf-8?B?cGJjWUZuNWZjR1lJVXZUdFRZNjNEbCtTNFV4OW92WmNRSS9Cekg1TnFaRTFu?=
 =?utf-8?B?cytxNUM5b3BjZ3F0VTdJOWc4MzRjQTgxdmFXSGIrNEFaL2hqcGhYTVk0dklm?=
 =?utf-8?B?SkF1K3BERFpBWERPaGNmT3gyMStDRUZWK1podDNzbnVTbU5EM3prenJxYWVC?=
 =?utf-8?B?citzWEF0azNPTTN3OVVaMkNFQTdZQnFKa3YzT3ZJYitnUzloL1M1NFNBT1lV?=
 =?utf-8?B?MGEvRlZqVzM0K3pLTFlYN24xdTlYbGk1bndGZjBCcWpTZ2x1RkxzRWJnN1FH?=
 =?utf-8?B?ZlRqRDNKOWlVVTAwcUFoSEMzS20wYzEwUEdCVDl2MjJXSHUxWHA1VWlvazda?=
 =?utf-8?B?enJ1NDJGQmFFbkJOa1RpSVk2Ymc5dFZWLy9DalF2Sy9pczVPYkZPOTFhM0xW?=
 =?utf-8?B?TllMNnoxaER0QmtsdnJOeTFXT3N6aHNYSFRVeEVLS0FCVUJGWFlYTWphL0lw?=
 =?utf-8?B?LzNCWlU4Yk1INjVEL2RIT2tuT3pTVjdzWFFyQ3N3U2QwTktmdFQrRTlobXNp?=
 =?utf-8?B?ZjZTTDNheFg0UGczM3BmdjdIak13NGZ1elpPenpNLy9odDh0MWhwWmE1SGk4?=
 =?utf-8?B?Qi93Wm80SHppR0ZSTXFNT2hSUTFGS0hZenZsU3FyaVYweHROOXNydUxmUE5i?=
 =?utf-8?B?YWc5SVE2NzdsVkVtVXgreUdoQlJyY3czOTNOS3dDV3Z4NlZqckJvd3dHb21Y?=
 =?utf-8?B?OGRiWXlYNXg1ajBQOHhJM1BxeHphZXUwVVBSTUlrTW9YMC9hNXV0eWNhVnhN?=
 =?utf-8?B?eHRXcWNUUitxNFpiWkJLNllvTmVtMmp2YjBhNy9IVGdxbmNzcW9HT245UlMz?=
 =?utf-8?B?Yk1LalgwanBTcGxBOXhHUUtUdlVoSndFWk9KQXd4bmgvRGRadUpMMyt6TnpD?=
 =?utf-8?B?VUY4NGFPTElTU2xKbDBKa3d1R1dlQ0dWNXZjYWZ0dWtDeTUvMDE4U0ZOSXl2?=
 =?utf-8?B?cm5uSDFHSHZjYXNRaDYrbEc0aHVQZVNicktSNW9hSUpMOEVGTFFwM3BVLzFG?=
 =?utf-8?B?TkxCVzg5eVNMRTlaVlN4SDViNitlUTR4MHQ5bWo4bWtUbnFyTDd4c25sSHRh?=
 =?utf-8?B?Um45WEhYdzNsRDM4T2hPdjB3bFpsZUdnejIyVStRVmRnb1FmOW5JRDRFNE55?=
 =?utf-8?B?L2x0dml3cUhwcHpVYTJuMi8ra2pNNUlRZ0I5TG1PZzVtSkZsQlpnQnhMbWlW?=
 =?utf-8?B?cjJpNXZOWXJVUUV1OFZxbTY2N2RtQ1o2STFBQ3JzVkNkN3BzNytBVnRwdHhG?=
 =?utf-8?B?Lzh1YXM1K29ydDZEMlUyQVF4aUJ0Qzl2aGp3aE5oVCtha2hBRjRVSi94SDJZ?=
 =?utf-8?B?cFFucUxkMHVWd250TXEwS3BZWlduSUQ5aUxyVVlkMWpTTm1HQjkxQStPZ0lr?=
 =?utf-8?B?aEN3SVhEOWJCWHY4UTFhbzJ1WmZnSEFER0k0Vm1JU2lkRzRCazJLbzRoZHFC?=
 =?utf-8?B?ZWNBV3dVRndDMk8xTGEzbnIrLzlkS096RzR2c1VtQVJ4aWJOUW00eFN0Q0oy?=
 =?utf-8?B?c1J4MHNZVjZ1cWtKUXU3OUFWTSsrbXlyMlZDVFNONjBXRXFpamxBNnFHcENa?=
 =?utf-8?B?VDRPOWFVNXdwc3FyQ2pqZVlxQk1iQktlWEVZRU9KdlFVdlZFMGN1aVlMOXZC?=
 =?utf-8?B?VTBlc20rR2V4ZVpKTlNtM293T0FUdUpNTFA5UmxIR3E4YWliek9RcUZ6VWV1?=
 =?utf-8?B?VE9uOWJra3c1TTJISnVZWlBCRmZEdVRPZ0hHbitlOE43c1pLSlhTT1dWdkwz?=
 =?utf-8?B?UEMxQldpVCtlZzBiYWZtQm9HRFRkbjF1UjQ5WlNNcXcwdWxNR3l3dTFBeDlX?=
 =?utf-8?B?WTBLWGJ0U3Z4c21MNFRGYjVyaExySGVtSXJpSHR2V2lsaEhnUVVmUzhLeTBR?=
 =?utf-8?B?OGYzM3g2QnZtY3VlNE1Rd2NRcWcwaXM5Y1ZJSlNaaUlhQjc3T3Q4OVNCSStR?=
 =?utf-8?B?YkZrdkx2MW1HYkR3WGNwVEE2Y0RlaDFNMUJlZzRKclFsK2tGeSszVktwVFNQ?=
 =?utf-8?B?ckI3Z0oyZ1UrWUIwSzZCczVYQWVJZHpORXlJQ2poZVZQZFZIcy9rZFR5VXV0?=
 =?utf-8?B?WVJZemFuR2VPRGczbkh5N3d6WmZQczNneXZRVTJDR0w0Wmd6NXBQSnRpeXdH?=
 =?utf-8?B?MWV0ZXdCRXl2dW54cmRhb3NjS09GSWgzcGFDbjUzWjNrUDA3UzVCUVBSS3Rx?=
 =?utf-8?B?dzlTaFBDVVRLeXlqdW5xbWpSWmRCTHp5RTg2enVBcXhkTUNsNVBVbGFNYWEr?=
 =?utf-8?Q?KACypdcjo8n4Dyl0oMs1xBb6Atqd8HpO5HLSxEMgYoCMT?=
x-ms-exchange-antispam-messagedata-1: LV3hqMYOD++clg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4369b3-df00-4edc-309b-08da16964bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 23:53:20.0947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5yKn/Du4xgfKYmLyTvRvjhfdATHZiSVirBMffY0+zPYz2/bChbvVKJ4NbsC6AZJVoJfE3GLCsWpoSzg8/mUbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMu
Y29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDQsIDIwMjIgMTg6MzENCj4gVG86IExpbW9uY2ll
bGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IG9wZW4gbGlzdDpM
SUJBVEEgU1VCU1lTVEVNIChTZXJpYWwgYW5kIFBhcmFsbGVsIEFUQSBkcml2ZXJzKSA8bGludXgt
DQo+IGlkZUB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+Ow0KPiBoZGVnb2VkZUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMi8yXSBhdGE6IGFoY2k6IFByb3RlY3QgdXNlcnMgZnJvbSBzZXR0aW5nIHBvbGljaWVzIHRo
ZWlyDQo+IGRyaXZlcyBkb24ndCBzdXBwb3J0DQo+IA0KPiBPbiA0LzUvMjIgMDQ6MzksIExpbW9u
Y2llbGxvLCBNYXJpbyB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiA+DQo+
ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBEYW1p
ZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+DQo+ID4+IFNlbnQ6
IFN1bmRheSwgQXByaWwgMywgMjAyMiAyMDoxMQ0KPiA+PiBUbzogTGltb25jaWVsbG8sIE1hcmlv
IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+PiBDYzogb3BlbiBsaXN0OkxJQkFUQSBT
VUJTWVNURU0gKFNlcmlhbCBhbmQgUGFyYWxsZWwgQVRBIGRyaXZlcnMpIDxsaW51eC0NCj4gPj4g
aWRlQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz47DQo+ID4+IGhkZWdvZWRlQHJlZGhhdC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAyLzJdIGF0YTogYWhjaTogUHJvdGVjdCB1c2VycyBmcm9tIHNldHRpbmcgcG9saWNpZXMN
Cj4gdGhlaXINCj4gPj4gZHJpdmVzIGRvbid0IHN1cHBvcnQNCj4gPj4NCj4gPj4gT24gMy8zLzIy
IDEyOjQ5LCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPj4+IEFzIHRoZSBkZWZhdWx0IGxv
dyBwb3dlciBwb2xpY3kgYXBwbGllcyB0byBtb3JlIGNoaXBzZXRzIGFuZCBkcml2ZXMsIGl0J3MN
Cj4gPj4+IGltcG9ydGFudCB0byBtYWtlIHN1cmUgdGhhdCBkcml2ZXMgYWN0dWFsbHkgc3VwcG9y
dCB0aGUgcG9saWN5IHRoYXQgYSB1c2VyDQo+ID4+PiBzZWxlY3RlZCBpbiB0aGVpciBrZXJuZWwg
Y29uZmlndXJhdGlvbi4NCj4gPj4+DQo+ID4+PiBJZiB0aGUgZHJpdmUgZG9lc24ndCBzdXBwb3J0
IHNsdW1iZXIsIGRvbid0IGxldCB0aGUgZGVmYXVsdCBwb2xpY2llcw0KPiA+Pj4gZGVwZW5kZW50
IHVwb24gc2x1bWJlciAoYG1pbl9wb3dlcmAgb3IgYG1pbl9wb3dlcl93aXRoX3BhcnRpYWxgKQ0K
PiBhZmZlY3QNCj4gPj4gdGhlDQo+ID4+PiBkaXNrLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYt
Ynk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+Pg0K
PiA+PiBNYXJpbywNCj4gPj4NCj4gPj4gQ2FuIHlvdSByZXNlbmQgYSByZWJhc2VkIHZlcnNpb24g
b2YgdGhpcywgb24gdG9wIG9mIGxpYmF0YSBmb3ItNS4xOSBicmFuY2gNCj4gPw0KPiA+DQo+ID4N
Cj4gPiBPSy4NCj4gPg0KPiA+Pg0KPiA+Pj4gLS0tDQo+ID4+PiBDaGFuZ2VzIGZyb20gdjEtPnYy
Og0KPiA+Pj4gKiBNb3ZlIGRlZXBlciBpbnRvIGNvZGVwYXRocw0KPiA+Pj4gKiBSZXNldCB0byBN
RURfUE9XRVIgcmF0aGVyIHRoYW4gaWdub3JlDQo+ID4+PiAgIGRyaXZlcnMvYXRhL2xpYmF0YS1z
YXRhLmMgfCAxMSArKysrKysrKysrKw0KPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9saWJhdGEtc2F0
YS5jIGIvZHJpdmVycy9hdGEvbGliYXRhLXNhdGEuYw0KPiA+Pj4gaW5kZXggMDcxMTU4YzBjNDRj
Li4wZGMwMzg4OGM2MmIgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2F0YS9saWJhdGEtc2F0
YS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2F0YS9saWJhdGEtc2F0YS5jDQo+ID4+PiBAQCAtMTMs
NiArMTMsNyBAQA0KPiA+Pj4gICAjaW5jbHVkZSA8c2NzaS9zY3NpX2RldmljZS5oPg0KPiA+Pj4g
ICAjaW5jbHVkZSA8bGludXgvbGliYXRhLmg+DQo+ID4+Pg0KPiA+Pj4gKyNpbmNsdWRlICJhaGNp
LmgiDQo+ID4+PiAgICNpbmNsdWRlICJsaWJhdGEuaCINCj4gPj4+ICAgI2luY2x1ZGUgImxpYmF0
YS10cmFuc3BvcnQuaCINCj4gPj4+DQo+ID4+PiBAQCAtMzY4LDEwICszNjksMjAgQEAgaW50IHNh
dGFfbGlua19zY3JfbHBtKHN0cnVjdCBhdGFfbGluayAqbGluaywNCj4gZW51bQ0KPiA+PiBhdGFf
bHBtX3BvbGljeSBwb2xpY3ksDQo+ID4+PiAgIAkJICAgICAgYm9vbCBzcG1fd2FrZXVwKQ0KPiA+
Pj4gICB7DQo+ID4+PiAgIAlzdHJ1Y3QgYXRhX2VoX2NvbnRleHQgKmVoYyA9ICZsaW5rLT5laF9j
b250ZXh0Ow0KPiA+Pj4gKwlzdHJ1Y3QgYXRhX3BvcnQgKmFwID0gbGluay0+YXA7DQo+ID4+PiAr
CXN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqaHByaXY7DQo+ID4+PiAgIAlib29sIHdva2VuX3VwID0g
ZmFsc2U7DQo+ID4+PiAgIAl1MzIgc2NvbnRyb2w7DQo+ID4+PiAgIAlpbnQgcmM7DQo+ID4+Pg0K
PiA+Pj4gKwlocHJpdiA9IGFwLT5ob3N0LT5wcml2YXRlX2RhdGE7DQo+ID4+PiArCWlmIChwb2xp
Y3kgPj0gQVRBX0xQTV9NSU5fUE9XRVJfV0lUSF9QQVJUSUFMICYmDQo+ID4+PiArCSAgIShocHJp
di0+Y2FwICYgSE9TVF9DQVBfU1NDKSkgew0KPiA+Pj4gKwkJZGV2X3dhcm4oYXAtPmhvc3QtPmRl
diwNCj4gPj4+ICsJCQkiVGhpcyBkcml2ZSBkb2Vzbid0IHN1cHBvcnQgc2x1bWJlcjsgcmVzdHRp
bmcgcG9saWN5IHRvDQo+ID4+IE1FRF9QT1dFUlxuIik7DQo+ID4+DQo+ID4+IFR5cG8gaGVyZTog
cy9yZXN0dGluZy9yZXNldHRpbmcuIEFsc28sIHMvZG9lc24ndC9kb2VzIG5vdC4NCj4gPj4NCj4g
Pj4+ICsJCXBvbGljeSA9IEFUQV9MUE1fTUVEX1BPV0VSOw0KPiA+Pg0KPiA+PiBIZXJlLCBzaG91
bGRuJ3Qgd2UgdXNlIHRoZSBkZWZhdWx0IHBvbGljeSBkZWZpbmVkIGJ5DQo+ID4+IENPTkZJR19T
QVRBX0xQTV9QT0xJQ1kgPw0KPiA+DQo+ID4gSWYgdGhleSBzZXQgaXQgdG9vIGFnZ3Jlc3NpdmVs
eSB3ZSBzdGlsbCBkb24ndCB3YW50IHRvIGhvbm9yIGl0IGlmIHRoZSBkcml2ZQ0KPiA+IGNhbid0
IGRvIHNsdW1iZXIgSSB3b3VsZCBleHBlY3QuDQo+IA0KPiBUcnVlLiBCdXQgaWYgdGhlIGRlZmF1
bHQgaXMgc2V0IHRvIGEgaGlnaGVyIHBlcmZvcm1hbmNlIG1vZGUsIHdlIHNob3VsZA0KPiBub3Qg
ZmFsbCBiYWNrIHRvIHRoZSBtZWQtcG93ZXIgbW9kZS4NCj4gDQo+IFdlIHNob3VsZCBlaXRoZXIg
KDEpIGZhbGxiYWNrIHRvIHRoZSBjbG9zZXN0IGhpZ2hlciBwZXJmb3JtYW5jZSBwb2xpY3kNCj4g
c3VwcG9ydGVkLCBvciAoMikgbm90IGNoYW5nZSB0aGUgY3VycmVudCBwb2xpY3kgYXQgYWxsLiBu
byA/DQo+IA0KPiBTZWUgd2hhdCBhaGNpX3VwZGF0ZV9pbml0aWFsX2xwbV9wb2xpY3koKSBkb2Vz
IHRvIGNoZWNrIHRoZSBwb3NzaWJsZQ0KPiAiaW5pdGlhbCIgKHRoZSBkZWZhdWx0ID8pIHBvbGlj
eS4NCg0KT0sgLSB0YWtlIGEgbG9vayB3aGF0IEkgZGlkIGluIHRoZSByZXN1Ym1pc3Npb246DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA0MDQxOTQ1MTAuOTIwNi0yLW1hcmlvLmxp
bW9uY2llbGxvQGFtZC5jb20vDQoNCj4gDQo+IA0KPiANCj4gPg0KPiA+Pg0KPiA+Pj4gKwl9DQo+
ID4+PiArDQo+ID4+PiAgIAlyYyA9IHNhdGFfc2NyX3JlYWQobGluaywgU0NSX0NPTlRST0wsICZz
Y29udHJvbCk7DQo+ID4+PiAgIAlpZiAocmMpDQo+ID4+PiAgIAkJcmV0dXJuIHJjOw0KPiA+Pg0K
PiA+Pg0KPiA+PiAtLQ0KPiA+PiBEYW1pZW4gTGUgTW9hbA0KPiA+PiBXZXN0ZXJuIERpZ2l0YWwg
UmVzZWFyY2gNCj4gDQo+IA0KPiAtLQ0KPiBEYW1pZW4gTGUgTW9hbA0KPiBXZXN0ZXJuIERpZ2l0
YWwgUmVzZWFyY2gNCg==
