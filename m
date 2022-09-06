Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079805AE624
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiIFLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiIFLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:04:37 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344929FCF;
        Tue,  6 Sep 2022 04:04:35 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285Kn9qa017117;
        Tue, 6 Sep 2022 04:04:33 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jc6epru6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 04:04:33 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286B25wE002588;
        Tue, 6 Sep 2022 04:04:32 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jc6epru6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 04:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUhRqEtjk3nRyxsNDAQEWMGAUu3SVuyUvdsOpZNdJNdM2zAx8aZPUXC1rhGSkEg3cQTO4X4OW9475rTZ8EvA7fwCGVwVdCo4sicPbjrlUX5mZaUNGw79iWUP5WATQ5qTPp8RE7g5jAzNW6VCoMxn+6XIHG1xi15ZwWBw0/oIKwn+pbLxanP1QaUcIjynLy8sDAS0aqrs1FEoE69y30THsixvQUa6dvfrRCQmWq3TthwFIyZX6V32cSsUa0fHTumbLRFyXtLMPKZZum6rgm8c1WsWaEZxhApb4GXjxcImApmcFQKw+3BkDn8R03z6ZB8WuBlaT1f7azPxn8MElp3ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh85AQYDcsGj91zxrD8MBrNh7USTV/D9rip8km7nDqs=;
 b=IwtQeDPVH8OOvXbnBXuAndMqizsG1ixIVmhk5oyQrXxii1+x65YMItDjlMVtjiVb5+MWfgP9Dz4+cAHv6ZBJ/AKDqouNFWGrzJ8/GGIilT83NVQcFClVhvdaCw3G5YEBj3YuY3JiVzjfGPywD4/WD+ry9slICdYEMkKDR6TflIzSWj4uQolMdhW3b6XiKc4jNNY2ICN289FdA+fkgBDw/3jiNP1YT7xh4y7cBGXne6uQqnu1SyoGZfXxH18ct4g66OUHH2GAJbZ2VOzng1lcmlJT1VGuIZoWEanT+UEb+HrK2DtRA4WtZENd8DBMA/nejKJfijNejGDWGH+U+1+msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh85AQYDcsGj91zxrD8MBrNh7USTV/D9rip8km7nDqs=;
 b=SrTUCgT3m5cw6Ztb7YTvx9vonWgtgdKmW57KgdjVrsqkKaLyxRiM8UgqNCAXVQ2tIpTKMo14w9IhK7KPW1RfdT4qYuRbw/4l8z1mUVL6VFypKxg03kTB7t4ipYP5QSSnt3tFG2KaytwhWW7AfeQQlOAigkBjgaJIVuwsOng+fPk=
Received: from DM4PR18MB5220.namprd18.prod.outlook.com (2603:10b6:8:53::16) by
 MW3PR18MB3450.namprd18.prod.outlook.com (2603:10b6:303:5b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.17; Tue, 6 Sep 2022 11:04:28 +0000
Received: from DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::64b2:db89:aab9:bbfd]) by DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::64b2:db89:aab9:bbfd%4]) with mapi id 15.20.5588.011; Tue, 6 Sep 2022
 11:04:28 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Letu Ren <fantasquex@gmail.com>
CC:     Javed Hasan <jhasan@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zheyu Ma <zheyuma97@gmail.com>, Wende Tan <twd2.me@gmail.com>
Subject: RE: [EXT] [PATCH] scsi: qedf: Fix a UAF bug in __qedf_probe
Thread-Topic: [EXT] [PATCH] scsi: qedf: Fix a UAF bug in __qedf_probe
Thread-Index: AQHX173JoyzXmxer+Uu3rvvmwZsxL6xRK+DQgYLTvwCAABFngA==
Date:   Tue, 6 Sep 2022 11:04:28 +0000
Message-ID: <DM4PR18MB52209E449FCBD1209F7ACBE1D27E9@DM4PR18MB5220.namprd18.prod.outlook.com>
References: <20211112120641.16073-1-fantasquex@gmail.com>
 <DM6PR18MB303406C9CF97E2B42CEC63ACD2499@DM6PR18MB3034.namprd18.prod.outlook.com>
 <CAEUwDuD0ZMNqwdi-zkH_s7Gj6SkSJpvrcVzhtMz_1HRrXN=dpA@mail.gmail.com>
In-Reply-To: <CAEUwDuD0ZMNqwdi-zkH_s7Gj6SkSJpvrcVzhtMz_1HRrXN=dpA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e53af7d6-e2f1-4541-f8ca-08da8ff79190
x-ms-traffictypediagnostic: MW3PR18MB3450:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0W1iVkbz6DcuYbP4p2ci2pS1A5TrLUHzj01VoycoX/EeQmUDg6uv+dNJ6DzWRGRAjGg8S2/uOGgopfq1jiwqNLi/KXVeiUuITC1Za0voEWZ1HZTYdNo/FmQnXayc0U6so+pS35srU9mGczVKc1/eOaLXu1Z1sOSexSzT5N811MVZaaKcMBS9k2nCNH/SJzhUZxMS+e9Sp8nvw9y2r0cFPXl3DrVnao2zBQT+bzYsBwtG8UUyn8oP1M1CY1eQVXUSQoVdHWpxPQhoOnFlv30NXFVTunQMO5LW/bHKx/Dq2O71QZC4zVNZAwJYHrSszAcngwK1CfQrBY5LhjUO+naNu/UQJG3E/DKSNZwYzstZEX082vhdXImAM8r5vW35yhS8+lc9nfwhTw7Xg/sD5FF3yIK72jQu0ngrCdo3T7hSnTDQ0sarS7FlftTUKhIXs5nroCDriiQkkrPstOzQOsR/A8ZnLlaJZh0Sn4jsrMsJIsc4eb9sGXxv9yHx00673KbbUgv+El6nTtfkUuh9z1TeIXyTR0/epPhcKFBMP2rVrB9WDy074TKwPJGZGh242oxocKSZVcWBxMi+8pvKxjXD5BPLqTYnnVXCvkkHeWKArlmUh4fVK6F+2U4hdjdFhR5ScNivhjH/7tBBKtQUSkeQswEr4QoeRMEhn00fTIi+27IiCULV7mwxJ1wiFMjZ99KHvFqJ1kzkS4gGZ6mnzY+gQ3z6N/y5LAYvv3gRjLKchlNi2pqiXdZCYgTLDIZvJjFzVS+bJ0UdP7JxB0Lq8KgQLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB5220.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(52536014)(186003)(9686003)(4744005)(2906002)(8936002)(5660300002)(55016003)(83380400001)(86362001)(33656002)(53546011)(6506007)(478600001)(71200400001)(7696005)(41300700001)(122000001)(38100700002)(6916009)(38070700005)(76116006)(66946007)(66556008)(66476007)(4326008)(8676002)(64756008)(66446008)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBhWUxiSFNTNWNsYTRkdlI1aGJBSDRjRXBKY1dyNlpXU3JKbHM3MmJrenZm?=
 =?utf-8?B?SWRKTWZmRTZWSjdHWFBLOUtNTVZDeDhJMW9TODl4WWpla1pTMk8wdThGR0xv?=
 =?utf-8?B?ckJaaVRHMWhCVkkxRUJnS3NndlpCYXJyVXJLWTZobG4zNkNQMjZpRUpzL012?=
 =?utf-8?B?MHBWWVlONFFneFpPT1U1d29ZYnQ0K2d0dVd4ZE14YkhSemJPdUtIU2xtdG1q?=
 =?utf-8?B?M3FrdG1ldCtPSTA4MmZCQXRJb09OVlAvb0QvUUpsTE13OHNENzJuY1FPRVhC?=
 =?utf-8?B?d3p4YWlvODhSa0dzTE0vT3J6THB3aHNEbFpLOTVoK3MveEl4UzVGYnhBdGN6?=
 =?utf-8?B?YkZ6QlBIYlp0eDlKZ3pMMzI0V25hZDFYQUlTeWhjRXlKQ0NIZ0tYTWNNends?=
 =?utf-8?B?SnAzMTZZekFjRlZEMjdja3EyUkhyWFAyaUZWVmcvNFpQV0c5bjljTTU3SVk2?=
 =?utf-8?B?UDVSVDlqNXdJMmFrQmdxdGUreE1aWGVhWFl3SWdlaW9YQVZDU0RzV0tmTVdk?=
 =?utf-8?B?QkdhMjBxWHdxdkQ0YUc2U3NNVDJ2d0JVZkZJNC9tTjNHNDNwSGJwb3oxc2hK?=
 =?utf-8?B?a1ppMmoxM3RMMG5XZTVreEFxelo3R3pCOGpnSWNhOUlCR0V5Q1BBdTJRVUdZ?=
 =?utf-8?B?eVBoWjZiT1BxVTUwdjRORkxySXpxdmF5eStYa3JnMDlXU1hpTnlncHZUcXI3?=
 =?utf-8?B?TEl0NmJPRnBxZTE0NUVEUy9yRlpjTVV2b2EvcmJDV09FcGNIdDE0a1pqdGNB?=
 =?utf-8?B?UnhTQkp0U05pWmcyOXdNVDlGMitFckxiZTRvRHYzMmVqQUVwcXdHVFl5eERQ?=
 =?utf-8?B?eENFcXBqVkVQdUZUUkF5TlZNUFpka0JEVXhYRXlkNTNqMXUxM0RvRUJDNjI2?=
 =?utf-8?B?cXhBd3hsMkxqMTQvRCttalVzUnJUMWdOMjgycGpaTnpGazV6VG5SSzM3cWtS?=
 =?utf-8?B?TDFWOUNoc3lzaWVSRGxOY2YyMmZaZUoxM2J6UnZaUTBUemZrb1lPc3ZHTk9O?=
 =?utf-8?B?S0RCYWpXZEJMTGMxOHhiL2VMOTROY1E1K1F0dTJxUU9EZkFRajB4UFFLS2lp?=
 =?utf-8?B?dVBuc011VXlsZTNFVitvWkhtekpldG12K2Rmb3hYQlVZWmR5bGYzanBKN1gz?=
 =?utf-8?B?Um1LUjdOUi9KNEh6c1ZpU1RLSTlvc0x4b1k5clFFOTFEZnpuZExaODA3aEZR?=
 =?utf-8?B?RE5GeE80aE13SEdoTEFHWDBDZ0dVdmZOTnFtM3orWjJTOGZxSUYzL2wzWWlX?=
 =?utf-8?B?WTlHWDBNRmFUY2NUdlZsSkdKdlQyLzFsbm9aNmtuL2VGcjlDTGpSNDFkZm5n?=
 =?utf-8?B?SWsxR0lZWXZUYVpFUHNpbS9pbWRVK05rU0xWZm41ZW9oR2Y2c1I5eXNBazI5?=
 =?utf-8?B?cUhKalM0NmlKVWc1VnpHVzZXTmt4c0NMbmFKRUFNbnJDN056enNDNXlISU5W?=
 =?utf-8?B?K3Fpd0g3dEVIdG5sREh0ZDVSN1FjRjJ6aC9wMGcrbnY0VVZWNkQ0NnhCeCtp?=
 =?utf-8?B?L3doclpFMWZvWGJyellVQ3RiejV1L09tMnRFRVNURzVhV1lQakc4UEZkZzdw?=
 =?utf-8?B?L3dYN3JCTkYwSUFiRFpMVllId2RHU3ZBQ2dJZVlUOWJRTW5QY3dwUmF1YVJQ?=
 =?utf-8?B?UVhaZmkyOWtMWk9GV2ZxdVpnMXI4ZGszZTFpQUh3azhtRzVTeFQ5M1dHVmxv?=
 =?utf-8?B?ajRNbzRKY09CSkY3QzIzaC9qakNvUTg4QXYybytjODU5dk1lUHh6Sk5pN0Ru?=
 =?utf-8?B?OVpERVIyaTVFeXZLcHlkMG1ncXR2a3E0T2Z3R09PN1VtSDFoSmlVV3c2TDFB?=
 =?utf-8?B?UlQ0djFGQ3NlL1NyUXdOaXNsZmdzcHg0ZDNzUWxUMEV6Q2VGbmx0TU9CM2hy?=
 =?utf-8?B?R3lOQ0x2bjhBdEQzS09sUVpESXk1NjE4UDAyaWFzZC9QckZZZG5nU3IrTGh2?=
 =?utf-8?B?OGNZbGtGSDhlYlFES2J2K2VHZW1PWXp4ZElmcGxvVmx3OE1MUC9YaktSa0Yz?=
 =?utf-8?B?RkVxQnF1UTNFME5pRUVLdk9uWlNCYzZRYTRCQ0lDTUlKTzJHMHJETmtTWFp6?=
 =?utf-8?B?QlJhckVUa0QwaGpKWHVjcWZrY1I1SFAxNnhHWEdCRk5jNXVtTXpVMVRCdXpp?=
 =?utf-8?B?ckc1V3BuMW1xRFd2K3dIUWZtc1oyQTRrOXl2TTQvOUk3TG1HaDBCdHRkZFl5?=
 =?utf-8?Q?CvTzQtEkeHEC0C07oNkGuhjWia8jOxleU5cyLui9NmmF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5220.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53af7d6-e2f1-4541-f8ca-08da8ff79190
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 11:04:28.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDmea1bFcNvT+0zBdwJUoKNfbuLAyehtdFR0gyyX0nGEFl5/enjrNeD3QIf3favJ5bVZ8PqHxBRk0rgp/GGk4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3450
X-Proofpoint-ORIG-GUID: uzTQscbpQhkB9V1nX3ZH4q33b0qcrmH0
X-Proofpoint-GUID: xRQILxpibPo2N4_32wLj2PblLckKDN8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_05,2022-09-06_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGV0dSBSZW4sDQpJIGhhdmUgYWxyZWFkeSBhY2stZWQgdGhpcyBwYXRjaCwgc28gbm90aGlu
ZyB0byBiZSBkb25lIGZyb20gbXkgc2lkZS4NCg0KSGkgTWFydGluLA0KSSBoYXZlIGFjay1lZCB0
aGlzIHBhdGNoLCBraW5kbHkgcHVsbCBpdC4NCg0KVGhhbmtzLA0KfnNhdXJhdg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExldHUgUmVuIDxmYW50YXNxdWV4QGdtYWls
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDYsIDIwMjIgMzozMSBQTQ0KPiBUbzog
U2F1cmF2IEthc2h5YXAgPHNrYXNoeWFwQG1hcnZlbGwuY29tPg0KPiBDYzogSmF2ZWQgSGFzYW4g
PGpoYXNhbkBtYXJ2ZWxsLmNvbT47IGplamJAbGludXguaWJtLmNvbTsNCj4gbWFydGluLnBldGVy
c2VuQG9yYWNsZS5jb207IEdSLVFMb2dpYy1TdG9yYWdlLVVwc3RyZWFtIDxHUi1RTG9naWMtDQo+
IFN0b3JhZ2UtVXBzdHJlYW1AbWFydmVsbC5jb20+OyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpoZXl1IE1hIDx6aGV5dW1hOTdA
Z21haWwuY29tPjsgV2VuZGUgVGFuDQo+IDx0d2QyLm1lQGdtYWlsLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtFWFRdIFtQQVRDSF0gc2NzaTogcWVkZjogRml4IGEgVUFGIGJ1ZyBpbiBfX3FlZGZfcHJv
YmUNCj4gDQo+IEhpIFNhdXJhdiwNCj4gDQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+ID4N
Cj4gPiBBY2tlZC1ieTogU2F1cmF2IEthc2h5YXAgPHNrYXNoeWFwQG1hcnZlbGwuY29tPg0KPiAN
Cj4gDQo+IFRoaXMgaXMgYSBmcmllbmRseSByZW1pbmRlci4gSSB3b25kZXIgdGhlIHJldmlldyBw
cm9ncmVzcyBvZiB0aGlzDQo+IHBhdGNoLiBBbG1vc3QgYSB5ZWFyIGhhcyBwYXNzZWQgc2luY2Ug
SSBzdWJtaXR0ZWQgdGhlIHBhdGNoLiBBbmQgd2UNCj4gaGF2ZSB0ZXN0ZWQgcWVkZiBvbiBMaW51
eCA2LjAtcmMwLiBUaGlzIFVBRiBwcm9ibGVtIHN0aWxsIGV4aXN0cy4gSWYNCj4gdGhlcmUncyBh
bnl0aGluZyBJIGNhbiBkbyB0byBoZWxwIHdpdGggdGhpcyBpc3N1ZSBwbGVhc2UgbGV0IG1lIGtu
b3cuDQo+IEknbSB3aWxsaW5nIHRvIGhlbHAuDQo+IA0KPiBMZXR1IFJlbg0K
