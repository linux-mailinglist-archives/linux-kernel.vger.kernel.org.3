Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911395481CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiFMITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiFMITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:19:43 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00181A05C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISg1r9XGiH072G7HdKmWcaaSkwrTb51+YmXy9i9fT1v/7FwC31hYjzeegxLkdZFXWIeTcHrBD2pYh4s5fhZSs9C6NT4uo35AR+wjC4imGh6/uejdwTQ4mfYHjt6z7HQF211qsnwSzIIBjKDXGjX9av+puVAiXfDSByiEeI0eqacDAW/U4AmuHnMIqh2dSlA/gCvne1slMlB08c2ZVlvJ57hYvR+K7CXxCxCepP9T4z+btpuSVTMeK2QOQDYpiwUpbSkISrc2hMcr+ZraoGgNVgjKx0t8ZW7F/oeFVruSj2Uc1TxDsg1CYZYjjmTmNL41hBVkCfA47yvvgAfVu48QWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9lLiijrs5v7u2hDB3Uh7WJ0+XDPKFb+Jzo1PpZFSbM=;
 b=lfLCw8rdKTgm2cXflQ80x6oal99rM7ou4o9n+men2BlIbAKBrZckNUzys1i8zTtWY+9EdA3mRqAlGGa8Aitlleps5CGVnqCCdy/ZwpxStBzRvWuZnjGsMl6H6V+huQ2a98pE6llp7kB8QF1ejZD1ircz5WPmx4AduJPBJoktwSypzfOqcXlgisuvmV5LrropePy9d003J+PI3NboMeZaRN+/3TFSLPss02WjUgE37i1FnR9TnjD9oieE61A9ZpMy1srjNvczYsKBOSRod01QkaqdYlVuzJrokygXPhb4htQMY3f3ROFJhuy+99pz4XZd8nITKS6DDL03+L4JVdxxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9lLiijrs5v7u2hDB3Uh7WJ0+XDPKFb+Jzo1PpZFSbM=;
 b=JxYaQ/fA/mKLUz6kLVDXHMEMDSG6/ehfTE8fpFivXx4/sQbgZdyxyJE8/3/OJxh8B2DPik2AyR7ZZnsqAXC7ZIAONzjNqmJ2F5KHQsLO3CCShpkRrms5Oyquy+5ISxFhaLpoxgowht9TyD6OQbmmmAjpTYZrGIi7e4qWqD1zbGF6T/jhgiXOfwhh+9DkIaUS89s4MV4sapyqgoBNQg+tSVv48OAfKE/lcuvCOg7msyS6arak0VL2JJIeyASjDkAGsG9CI+kKunzgaA8xVFzbxPGaghERz1DAARblxtVYsYuwIgyQe6DVxlOcy1exjWlHSCanReC7wK/NNJJdeJppYw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM5PR1201MB0044.namprd12.prod.outlook.com (2603:10b6:4:54::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.16; Mon, 13 Jun 2022 08:19:38 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::4c43:6ebe:1190:b398]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::4c43:6ebe:1190:b398%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 08:19:38 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     mst <mst@redhat.com>, eperezma <eperezma@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Subject: RE: [PATCH 1/2] vdpa/mlx5: Update Control VQ callback information
Thread-Topic: [PATCH 1/2] vdpa/mlx5: Update Control VQ callback information
Thread-Index: AQHYfvudovfajcNU50e5XMPZDyUG/q1M/CcAgAACQaA=
Date:   Mon, 13 Jun 2022 08:19:38 +0000
Message-ID: <DM8PR12MB5400D725BCA4784F9D86FA65ABAB9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220613075958.511064-1-elic@nvidia.com>
 <CACGkMEsxgs4DTs3w0Mtwrn26Cpww=_5VuApCKm=tHrTwDmZ0rg@mail.gmail.com>
In-Reply-To: <CACGkMEsxgs4DTs3w0Mtwrn26Cpww=_5VuApCKm=tHrTwDmZ0rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d41f982-eb20-487b-c750-08da4d15754a
x-ms-traffictypediagnostic: DM5PR1201MB0044:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB0044633F88D35F195CCD4F4DABAB9@DM5PR1201MB0044.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSBC8ny4qunkOlGdcQP8t3kr4tg08WkPY4N7dHwi9DXWrnhNt/t3x4wY5n+KbYzzpBEWhexzicJm2aTQVx9E9PyGda683vze5+clZwoGpAhdw0qAvo+sN6YUL52/aGtI9Ojl9x5Gb+9sZikKnlQ5thgsCXOmWIAqFm3OlpUyK/OPN0k1DO86ZXxLtSiuogGlrcaPsXBdO/WWjpA1HCV/L2/tO/APDQfFIBfpdHNo98uoNckNk2lHCXjCAxs9ZvG+859nsF1vPyB79E+b6xQBwrF0GKmwYkuG83UhfNgjwSlaTLPaVEHEYRACBPIgubpsnLl++RIy/L136mw11cNjtJmk5u1Vp+6uJxEVWvi8sSAaubhsgHZteo7mE6rLvI7Jwmqqh1B1LugeqaQeEzpwqXjf1V1Xdchr4xRDW59+g3d9Y0KKN5BA2L7IRY9GmKEiIPHTuQHqNMlmJIqcPP1EtwlXqt2oGk64ZPX18hZVEJTDSbYggjezW3jmfB7I+ZuCE1Mrgmh3ugt2gyjFpHSTKM8aUZQlhDoGXT4q018unRLMU+bg5aUTcE60/vKjOqjR91iVrRKfME+zBdymdsNpBocXmLZjrUqMg1X7rN3ViCgIdz4w4CeGvHwx7PLPs0YtnATBvZp5rlMleaJuXyaMuLF/UetUsYx1gky2uI7D0Q9eCq/psFMNOOuFBQcN/pksw3z7Tq2zT4fipmFl43zW7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(122000001)(9686003)(26005)(71200400001)(186003)(316002)(38070700005)(6916009)(4326008)(64756008)(66476007)(66446008)(8676002)(66556008)(76116006)(83380400001)(54906003)(66946007)(33656002)(86362001)(508600001)(8936002)(55016003)(5660300002)(38100700002)(2906002)(53546011)(52536014)(6506007)(15650500001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDVBWWpHVE95UWJldUVyYTAzNlJURXZZTE1hamVrQmlSSi92THU1Wm9DNUp5?=
 =?utf-8?B?Y05LYkNSV0VrcmpUL0VidGxma0hUdGFETjJFSG83czVDSlE3SjYxTnh1NjBw?=
 =?utf-8?B?Wk4vK3ZlQTRoNmlZRi9qNk5NbE1zRkppamFUTFcyOVBPTzhQankvVk9rK1JI?=
 =?utf-8?B?ays5OEozUEZtM05TeWloWHNuc0FlT2c3MmtqRnhGTzhEbk1vMWxSNHNxS1lo?=
 =?utf-8?B?TXhTR1kyM1cyRkZyZVQ3QmZrQ2ljUWJrVXB3bUUzZWY4K2gvQU9BZ2dIWWJ5?=
 =?utf-8?B?anErS3hycWc2Z2Z2VHUwb2JOS2xudGNka0w5VTBPb3daOUFkbEMzV2IxYW83?=
 =?utf-8?B?OUJWKysxNWtRUFJkLzV2aVowbDN6bUQyaCtsTDJOS1RjWUgyd2NUMmxicklP?=
 =?utf-8?B?bEMyclROc2tWOTNuNkNRbko5aGVJSXY0WmR1bDY3WkMrQk9Fb2V0Mkh4WE1k?=
 =?utf-8?B?YXdEZENMbkpRQ3hmenlVUkNQclBtZkZNSDN1SVFhNWNTYXFNWDkyL0Vhcjl5?=
 =?utf-8?B?OXliWUtjTldBNGVDb0lrOHFyaHRLbFdOdklCUnp1d2RFRjNwOGtkMVBYTW9Y?=
 =?utf-8?B?aHB0aXQ0bjMwQUNRays4Y0djUjRTYXF6VHA0ZVdwU0pCR0NiOGs2SC9NclZH?=
 =?utf-8?B?UXFXT2lQUitkbXpkc3FSaWtoMUFjUzVtN0tyNTV3R1J3aGFSSmdYalkzaFBX?=
 =?utf-8?B?Q2pjTzh3ZnliaTBJNE8za21aNkoxdEl5MnF6TnpsWTk3R1lZZGNXTDJFcjVL?=
 =?utf-8?B?bm1FRmN6Z1ZCOGE2bHBTd0psY1hDT1RydGZYNUR3WEQ0U1gwcE9BamU4b2tY?=
 =?utf-8?B?MWZjcEw5QXplZTh1LzMwRHc0eDd2QkdwTDJyY3JvTW9FOEkyVVNBbnlMMFNU?=
 =?utf-8?B?K3ZoK3F5Ri94blYySTRMVFVlcGdYdWtLNkJ5M2U3MmVReDNzRFUxY0syMm5n?=
 =?utf-8?B?OGREYkRyaXZ0ZTFYR1E5Yk41VEw4WFJYZmovMXozRjZ2ODg1bmFDMUZQQjYr?=
 =?utf-8?B?ZUNxK3BhUDdxMUhBTnpCc0Vwb3pvd3RGYlZRVElVRTVvMWlsRTRaZGNsYmY0?=
 =?utf-8?B?M2FUaTB5U0ZNRzZwM2ErWVBlbmM3Tk14N2x6VzJ0aDFMeEErNFNSVHlhMnpn?=
 =?utf-8?B?OFVQeHNrdGoxdnJQdzRlMnVIMXdRdEUvTU5DY01QRDBqOUtqdGVkeGJwK1FU?=
 =?utf-8?B?R1I2V3djT2JrVWhaRTFhcnJpSDhxMnRjc0dxNWtad3AyQyt2bXpuRFA5K2ho?=
 =?utf-8?B?OGkwVyt4VlErUzJENjZwTERPL0E4VjRPWlZXOFd1OFpSZ1FSaXlyOXVIN1RK?=
 =?utf-8?B?eXdCOGJJc2VPZ3ZhSUMvbGVobXk3dFU0UFQ2VmVJS2JMcWNpRERYL25XZFRn?=
 =?utf-8?B?aFA1NkZhc29wbEVpckQ2a0NtNGhwYUxBeDhQazZMZ2dTeko5dE56SzB0Tjh2?=
 =?utf-8?B?WXZ5b2xTN08xMlVDNXovRUwvU2w1UDlnTFc5RlJodE1KQUVDejRyRlBEbnhK?=
 =?utf-8?B?UGtOREU5Umk4eHVTd2pmaVB6VDZKSzlSbERzbFpNSGozTmwwajdYaXcvNHMx?=
 =?utf-8?B?Q2lnU3lROWE3ZFI5Z01UQUlrTFZmTVFvZlpDdTdyT0hDSmoyb1hsTkZraGVX?=
 =?utf-8?B?K2UyNERXcjdkV1d3bWc2RkdNeTZmNFNzRkhSNmtrcTJacGk5R0ZybURMZzk1?=
 =?utf-8?B?TnhwbmRJUGlNQ1hrTTRMUjN0cVFuTDhQUEQzek9vMHVvbG1iMllTM0paeEJP?=
 =?utf-8?B?NE5teUJIcUVKZy9qRHBNYUZQZHdqa1N6Q05uakg4QWZlQUJVQ21uV25rWlhH?=
 =?utf-8?B?c3NPSEhKUEhEcFV4bFAzb25EYVc5aFdyU0VubmFnYUJKbDM0NHo3Ri9lQWdk?=
 =?utf-8?B?eWpBYkZWUHVwUVJJRzRRN3N0UW91QVFCcVhGbTJkWlc4TEE0UkNBMytHblRT?=
 =?utf-8?B?dmRNNTdFVkZ2aVFqYTBseVFYSG5CNmh6RW4wdS9La05aOWswejQ0cFUyNjIy?=
 =?utf-8?B?RXZ3Vzd0SWd5UTVpSzk4VXJvbG5mazRJTi9mcDB0ZHluODJ3T2VrOVFiWEJY?=
 =?utf-8?B?bDNaWmEzdGZzV0E3eW0rQkpjREFNQzRFUlVmTXVqK1dSblBldjlwQTU5QUlD?=
 =?utf-8?B?YUJjbXN1T2YxeHFrVnlVelQ5OFlvUHBBNkhhbUFqTHllcnhHRnlwRjVTdElD?=
 =?utf-8?B?TWx2emthSWNpOUlpUGQybU9WTTB1L2tOT3J6T0l4TGtUb1BSQzE4RmNrWm9N?=
 =?utf-8?B?K0IvWmwvTGh5cThYN0g0K2dOYTJLL3Q2TXR3Y1dJTGppQmlCMXhnbW5KNWty?=
 =?utf-8?Q?TODoMbk6+/E08sEjHq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d41f982-eb20-487b-c750-08da4d15754a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 08:19:38.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9+b7HND9u/3zIHZ+6Eu7y2tdZVrbZvYd8XPBfEwi+NamUdaJQAHM+0c30k4PMZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0044
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDEzLCAyMDIyIDExOjExIEFN
DQo+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gQ2M6IG1zdCA8bXN0QHJlZGhh
dC5jb20+OyBlcGVyZXptYSA8ZXBlcmV6bWFAcmVkaGF0LmNvbT47IHZpcnR1YWxpemF0aW9uIDx2
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz47IGxpbnV4LQ0KPiBrZXJu
ZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBTaS1XZWkgTGl1IDxzaS13ZWkubGl1
QG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB2ZHBhL21seDU6IFVwZGF0
ZSBDb250cm9sIFZRIGNhbGxiYWNrIGluZm9ybWF0aW9uDQo+IA0KPiBPbiBNb24sIEp1biAxMywg
MjAyMiBhdCA0OjAwIFBNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPiB3cm90ZToNCj4gPg0K
PiA+IFRoZSBjb250cm9sIFZRIHNwZWNpZmljIGluZm9ybWF0aW9uIGlzIHN0b3JlZCBpbiB0aGUg
ZGVkaWNhdGVkIHN0cnVjdA0KPiA+IG1seDVfY29udHJvbF92cS4gV2hlbiB0aGUgY2FsbGJhY2sg
aXMgdXBkYXRlZCB0aHJvdWdoDQo+ID4gbWx4NV92ZHBhX3NldF92cV9jYigpLCBtYWtlIHN1cmUg
dG8gdXBkYXRlIHRoZSBjb250cm9sIFZRIHN0cnVjdC4NCj4gPg0KPiA+IEZpeGVzOiA1MjYyOTEy
ZWYzY2YgKCJ2ZHBhL21seDU6IEFkZCBzdXBwb3J0IGZvciBjb250cm9sIFZRIGFuZCBNQUMgc2V0
dGluZyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDIgKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYw0KPiA+IGluZGV4IDFiNmQ0NmI4NmY4MS4uNzg5YzA3OGZmMWFmIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+IEBAIC0xOTYyLDYgKzE5NjIs
OCBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3ZxX2NiKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTE2IGlkeCwgc3RydWN0IHZkcGFfYw0KPiA+ICAgICAgICAgc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7DQo+ID4NCj4gPiAgICAgICAg
IG5kZXYtPmV2ZW50X2Nic1tpZHhdID0gKmNiOw0KPiA+ICsgICAgICAgaWYgKGlzX2N0cmxfdnFf
aWR4KG12ZGV2LCBpZHgpKQ0KPiA+ICsgICAgICAgICAgICAgICBtdmRldi0+Y3ZxLmV2ZW50X2Ni
ID0gKmNiOw0KPiA+ICB9DQo+ID4NCj4gDQo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tKQ0KPiANCj4gSW4gdGhlIGZ1dHVyZSwgSSB3b25kZXIgaWYgd2UgY2FuIHNp
bXBseSBqdXN0IHVzZSBldmVudF9jYnNbXSBzaW5jZSBpdA0KPiBoYXMgdG9vayBjdnEgaW50byBh
Y2NvdW50Og0KPiANCj4gc3RydWN0IHZkcGFfY2FsbGJhY2sgZXZlbnRfY2JzW01MWDVfTUFYX1NV
UFBPUlRFRF9WUVMgKyAxXTsNCg0KUmlnaHQuIEkgd2lsbCBjaGFuZ2UgdGhpcyBpcyBzb21lIGZ1
dHVyZSBwYXRjaC4NCg0KPiANCj4gVGhhbmtzDQo+IA0KPiA+ICBzdGF0aWMgdm9pZCBtbHg1X2N2
cV9ub3RpZnkoc3RydWN0IHZyaW5naCAqdnJpbmcpDQo+ID4gLS0NCj4gPiAyLjM1LjENCj4gPg0K
DQo=
