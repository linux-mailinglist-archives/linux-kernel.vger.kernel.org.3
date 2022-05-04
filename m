Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B335199B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbiEDIbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiEDIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:31:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3542459B;
        Wed,  4 May 2022 01:27:24 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446Bvbn026498;
        Wed, 4 May 2022 10:27:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=ji5fPpyh966PH/Sa/msRTWFaROoshZ3fcw+0mjl29us=;
 b=CG/Iio8KimpjfklPT0F8zO1fJOOoNSucAiPIxqX26CctYnNmWFfvo5HUDiNgTWVE+ujF
 4iVTP6wzTSIE8QBt6aBaDR+cY0L+2rRlm/MwANRff3aN/Iy+oNo7rXh4rQhcHNOw7h6O
 7HGF5YPRi2KYzDfKebVIsKMGjM5ZG/LgOaUSwVK/yXqh4lCwirVNquckKE2yv2+ePsJv
 VEQ7IUwZRaaFmrsiNpRUZhsqxiMsC/z5+YMb1ZvmGWIFtPQ1fa5K48nc14xsDQ9b3cGO
 AOzVZg5L4fXPVJtV2PPi7YyT3y/hX9AJH3Ze4zN1Tn5Uk55zr09Db0U9B/hvRruqgh0P YA== 
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frt88v2m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 10:27:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWi246phkcUerg7+9A/54ZiQy2wfOjOhyGBLVU22/gH+XY0XDptc/gRvxzY0u0Qywn+KS9jjDjQNe+LDFqjuJ0glceHhad35XJ68RzVTx/KHXDAMhqBMiM61GTFWz/hEMQZ9W8cwwrkZggxuDjL1zeQG7zRYxjVzTpY64gdz3UbVKEtD7hzXsD5qHtAQ3oakCqO2GS2kjowo5abllHTzrutchQcPCPMBUZuOsYwTuwUkuGWqkb+PCQKy+6f1JXtMkPYWgSKLQ1KWbrqcJV7Og0HI5V34UBO4mAmjERAqmjVFT10f7ALC1GPBIXgOcil0jvXAXg2Pm9PSJlIKUpyEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji5fPpyh966PH/Sa/msRTWFaROoshZ3fcw+0mjl29us=;
 b=Q2AakVnYJ+aRoKRW8U37Vx6XYuaPnsV4WoyP2xY0CeNaigZn02G/UoQlPdy6x0zixzPeZSfvUCj4ygyr+EkuOs/879rBIgFZhX6X33Dka7PPztBT2VJM3o+fd5Rfx1lJ4Fh49aBVju56yi0QCEbnFKfg2HBXzZ0x55IlvjpIy3i2yUsExF0dPqCanUICthG3q/XppwEFgITgVYnZl3pD16oCv8AHPE7pbUhX4l9qU2j509OY+V8JFK8/8HLi2O5csPndAS94wvA26gbPxAP40H9KnpqyCv8dxmHGVZnxd73mBsmelQOIO3dgEtDQQ9PJpJccQjF/T94pQG4mCunHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:31d::16)
 by DB8PR10MB3227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 08:27:17 +0000
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc1b:ebb3:f408:8f35]) by AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc1b:ebb3:f408:8f35%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 08:27:17 +0000
From:   Alexandre TORGUE <alexandre.torgue@st.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: Signed-off-by missing for commit in the stm32 tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the stm32 tree
Thread-Index: AQHYXzSqtaGswd88t02XupNhEmArCK0OSBPQgAAOWYCAAAvc8A==
Date:   Wed, 4 May 2022 08:27:17 +0000
Message-ID: <AS8PR10MB47121BA9429673F0729D6DF3EEC39@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
References: <20220504072746.0f59f2d9@canb.auug.org.au>
        <AS8PR10MB4712B3354DACBB8A4F8309C9EEC39@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
 <20220504174151.3bfeeaf8@canb.auug.org.au>
In-Reply-To: <20220504174151.3bfeeaf8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2022-05-04T08:24:18Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=13057233-3626-4a9f-a193-4f50e0d97372;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_enabled: true
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_setdate: 2022-05-04T08:27:14Z
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_method: Standard
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_name: 23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_siteid: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_actionid: 5d73d25f-80d8-4e5a-a865-9ed509f44167
msip_label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8cc2b61-4a37-49b5-6887-08da2da7e65e
x-ms-traffictypediagnostic: DB8PR10MB3227:EE_
x-microsoft-antispam-prvs: <DB8PR10MB3227C9CA18D85A5A9E2E90C4EEC39@DB8PR10MB3227.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpK4cMxtJXSkY669B6O5/oPAajzSI043wgl3HDNwYo8BaFyb3wj7Q5Xq4yMBryl/bKz8YjIgorEMUG00ZKbiD0g5UcUye+1cWpfdgHnPyUn2A0NqmJH+jEqpWFSw0thuOYOqy05r40+OuSBtMZ4e3S9u4wbVA+AppNr7iwb1EPeE0ODTduDvUf8lSad/9RuxWQWrHHaBF4EyrBJoWmJOTQEZgsdOHXxIO2oXzO6iDZhgEmN0G5IRksSiaPdlhJsOeW1SLhi0SQ34w8I5ZlvgS3U3yTzVZY8/aOn5UQlqnj7nMvEDamUZj4ciI0ETNKcwxYeYEtO1Ht7Ha1IIHfQqh4baYkFoeALJnS+k+fdhE8+7N1AuX+vSUxWhG2tjtze49Km2pr2QHsA8qmMB6rLb3i0QcgK0J/QW5IEebbWjojqevzuoe37pGHTvfHOQl8HtaKdOXQBgAdKR2vzinLB9KtSiyQbPC1dokcEagfu561pGP3/sePSsTBN306CVdPzkbOebQB5sGKI6DBIwFU/fHxaUsrB9aotW+TFThVFDzJz70EwWDyoFufrGXOViICfBqhjlhk6OZjGX0du52BdcXxtJDKeEnR0jf7/dIpoEiNMyEq+lVGxDDHlL+IL1eZXxWMXcdHbac/TfT8xtlGRbX0ayHbT+PluUlz00TT8JQxA1/BGShRgF9fLmvF8CIKtQ18UUpoybse5UwBF1NXjrSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(54906003)(6916009)(38100700002)(38070700005)(5660300002)(122000001)(8936002)(7696005)(86362001)(52536014)(508600001)(316002)(186003)(26005)(6506007)(53546011)(55236004)(33656002)(83380400001)(66946007)(9686003)(76116006)(2906002)(66476007)(64756008)(66556008)(66446008)(8676002)(4326008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cThDbHRydjRpeXFaajNsRnZjTlNXL1UxNllQa2RtalY4d0xOU29JSkZoalhZ?=
 =?utf-8?B?ZzBoMElST3VoOEdlUFpsQ0FOZjNMK081WFl0S1I2Nmd2TUN0aUlaeU0xN1lL?=
 =?utf-8?B?dmx6MkM2Yk1BalNpZFcvVGFOSXd3TEhucHNzNmtoS2UvWkc2N28xNmtvYy85?=
 =?utf-8?B?Z2hTb1M1ZitoRlhEbDRUWjNqREdTS21TSWgwd2N3NXVTeHU0b3lZcFhaM0ZK?=
 =?utf-8?B?dmp0QmtteUFGU0E0U1R5SGdWbDc2Ni9nZ1I3Zm4vcWNibjJjNlpPZFgxUmZ4?=
 =?utf-8?B?OGJ6QjhHYm5BT1laMHhPZkRBZ1R5ZHljSFlRN2o0QkVaMWdWREIyVW9YSG1Q?=
 =?utf-8?B?bVVRWFBHVW5KWXVuL0NoaVVzajlORklsM3ZwUGV6eU5rZ1EwSEMrNXorV2Nn?=
 =?utf-8?B?ejE2aXZKUlE3T2RrMmVSQ1hYZThOZktCSThhTURSL2RIK3QxRHorSkd4Tm02?=
 =?utf-8?B?aWJzMDhGQnIzUVRjOFhWQkRtU29uYVFPelQrTU1IQVhMRzFoTzR3Yk1VSW9a?=
 =?utf-8?B?bWtzVCtFcGVIcWJwdG83cm9nNVVuZFFzdE9kb21JcDhlaTZ4M252dDVmaTFY?=
 =?utf-8?B?M3BhSzFPZEUydUdINDE5QUhrd2pwVU12d3g4RkZ5TWRva2JXdWp1bWxZWUI5?=
 =?utf-8?B?TlMyZEFGa3ArNVhGanQ2dnRDN0pqNktFV0h2SjZPdFVoWUdYN3dNQnY2cVg3?=
 =?utf-8?B?a0w0QXRmSGlJT2RXQy9OclZQeXJrU2Q5d0cveGtsNnNsdHhneGNUenNTeGxW?=
 =?utf-8?B?dE51VGU2bG5yS0wyVWNXQUd6V0xBVEdGNmE5Kzd5Y0RtNWpad3prRndYVW9Y?=
 =?utf-8?B?OEg2M2s1ZndkWGVSSjRybnhqdDdsKzQ4d0FrcVhHa2VjY2JQbkpHRXdGeUo3?=
 =?utf-8?B?V1VTTHp6ODRxT0VaeS8xYUhvaXhQUXp4VjcrOUQ2U2ZNUngrc3l1N0pjbkJ2?=
 =?utf-8?B?SUFNREJyeUVUS1NJUlJDQldDVll6cHVPTHUyZGZ6cWRNemt5aklhSEQ3RnF3?=
 =?utf-8?B?K0ptczViYkUwQTU0bktBTDdtR1BIUCtyYlFCL2JLRlU0NEtMTVZZWWxRa0lp?=
 =?utf-8?B?QUU3UmJKL1pvakVjZ2xBTTh4QW9uSWt6RDVZaWg0NHRWei93eDJnUjNiVXpa?=
 =?utf-8?B?VDl1ejUrUzdGbzlLTWFZTzVyMFdjUThkT1gyK3NHaFBuS092LzBXelUyZ2pK?=
 =?utf-8?B?YTR1ZnRTeXphT2NtSVZnS3gxcnhUZWFXaXlVTTc3Tk9UcnRBVU9BdVUyUlp3?=
 =?utf-8?B?eEdlWnNjMXIzUDVEMVF4VHpNT2lvcnorUW9KZHNmSUZpRWUwUSt3dm5ERkFO?=
 =?utf-8?B?RDNyWGpDLzFNSHVrWVdOWUlUbzY0c2E1d0Z1NUNwWGFkK2thU2hRdGo2SmdZ?=
 =?utf-8?B?M0pQdVNlVTJqaVJXaVNlczYreTlWYXY0OHM1aDlWQ3hNcmpzczZxTGJDancr?=
 =?utf-8?B?SGpwY3JCS2F2MnBUNC9HeGlaUlhOSEdZY1Q3SzArbTFwZjJSdGxCVGZZeldN?=
 =?utf-8?B?Y0dxcjh6U3lBYlZxOUFxZHlvVEFSd3N1bGZUZEppSjlYK2JFSmt4cDJRLzFJ?=
 =?utf-8?B?MHJORS9WaTFkeGk4ZFBOblkrbFZ0bUV2ZDQ4ZTZWSHRQZEVlU2tkeCtQdUxK?=
 =?utf-8?B?N2NUc0ZrYkVnam5zWXdTS3Bvd3hIOEt0Y0lUblF4K05HbFFIcXBDdjRIbVJj?=
 =?utf-8?B?cXRFQTZVR2ZRSmorS2pMUGFaekx4cFg0anhlOVVieWY1MXJhKy9kUEo3OGg2?=
 =?utf-8?B?dVFUeFIva01oU2NTSTloVWtnZEJTRk9mallMOVEzRHFsQnpUczN5aHhrUXhz?=
 =?utf-8?B?aHBYS1dVTm92OUpVYmsxZHR0S25kOUtuanhxMGJoTHk5MkFPSjhyTXVkcE9O?=
 =?utf-8?B?RTRQNHJEbElwYkdkaVdDWVIzN3ZBUDMyNFhEeXkxd0xOZUpCemNCUjlVN1ZO?=
 =?utf-8?B?UHA1RDlDdlo2TDNoaHMvZTJpdkVIY3Z1WHpEb1l5MmVVSVVjK2FMcFJDL21i?=
 =?utf-8?B?YjNyVXF2UEtocjM1ZXRwUGJIZTA0czk0cERQbEJmL2NIVTU0UmV1QS9kR1Zz?=
 =?utf-8?B?bFFjVXpOWTk3Kzc3ZHR4bkpDUmpQcUFTTkd6aXhkMWlINzVoYklQd2d3eDZk?=
 =?utf-8?B?Q2hyb2lYV1NsTkRrakNDMmlyVHdXVlh0Tm9TdmV6TExTekVTYUtQTGlkTkhU?=
 =?utf-8?B?ZGZPZDJ3S2hLNE9nTFI5OGxnaEtMazRhYnBlNEhzSzdMQW1DNjltWUptbnBq?=
 =?utf-8?B?cXFvN05Kcm9Wdko2SEZrdVZqK2lLZnNlMmFiWGUyVFpYUFRaWDJ5WmJHb0VI?=
 =?utf-8?B?SkN0cTlZeTVhTXhrS1RLeWgxUndhS3FpTXo4dEhWUUlYV3BMV0cwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cc2b61-4a37-49b5-6887-08da2da7e65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 08:27:17.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy7CSGLY5HhnC0MgJt0x/bi82QZpZtjx4z1Guif4StYW9FSSzXwUaL/y/mugklXG+C1+iNL+116ziDvmYvfbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3227
X-Proofpoint-ORIG-GUID: RVeZNAGjY1HfHkwLYXj_DvFHR5DM5wmQ
X-Proofpoint-GUID: RVeZNAGjY1HfHkwLYXj_DvFHR5DM5wmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_02,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RlcGhlbg0KDQoNClNUIFJlc3RyaWN0ZWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXkgNCwgMjAyMiA5OjQyIEFNDQo+IFRvOiBBbGV4YW5kcmUgVE9SR1VF
IDxhbGV4YW5kcmUudG9yZ3VlQHN0LmNvbT4NCj4gQ2M6IExpbnV4IEtlcm5lbCBNYWlsaW5nIExp
c3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCANCj4gTmV4dCBNYWlsaW5n
IExpc3QgPGxpbnV4LW5leHRAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogbGludXgt
bmV4dDogU2lnbmVkLW9mZi1ieSBtaXNzaW5nIGZvciBjb21taXQgaW4gdGhlIHN0bTMyIA0KPiB0
cmVlDQo+IA0KPiBIaSBBbGV4YW5kcmUsDQo+IA0KPiBPbiBXZWQsIDQgTWF5IDIwMjIgMDc6Mjg6
NTMgKzAwMDAgQWxleGFuZHJlIFRPUkdVRSANCj4gPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEFjdHVhbGx5IHRoaXMgcGF0Y2ggaGFzIGJlZW4gYWxyZWFkeSBtZXJn
ZWQgaW4gUm9iIHRyZWUuIEkganVzdCANCj4gPiBjaGVycnktcGljayBpdCBpbiBteSB0cmVlIHRv
IGF2b2lkIGEgbWVyZ2UgY29uZmxpY3QgbGF0ZXIgZm9yIG90aGVyIA0KPiA+IG1haW50YWluZXJz
LiBTbyBJIGRpZG4ndCBhZGQgbXkgIlNpZ25lZC1vZmYtYnkiLg0KPiANCj4gWW91IHNob3VsZCBh
ZGQgYSBTT0IgZm9yIGV2ZXJ5IHBhdGNoIHlvdSBhZGQgdG8geW91ciBwdWJsaXNoZWQgdHJlZS4N
Cj4gVGhhdCBpbmNsdWRlcyBjaGVycnktcGlja2VkIGNvbW1pdHMgZnJvbSBvdGhlciB0cmVlcy4N
Cj4NCg0KT2sgSSBhZGQgaXQgbm93IGFuZCB1cGRhdGUgdGhlIHN0bTMyLW5leHQgYnJhbmNoLg0K
DQo+IEJ5IHRoZSB3YXksIG1vc3QgbWFpbnRhaW5lcnMgKGFuZCBMaW51cyBhbmQgSSkgYXJlIHBy
ZXR0eSBhZGVwdCBhdCANCj4gc29ydGluZyBvdXQgbWVyZ2UgY29uZmxpY3RzICh1bmxlc3MgdGhl
eSBhcmUgcmVhbGx5IGNvbXBsZXgsIG9yIA0KPiBjb3Vyc2UsIGluIHdoaWNoIGNhc2UgeW91IHNo
b3VsZCBwcm9iYWJseSBoYXZlIGNyZWF0ZWQgYSBicmFuY2ggaW4gb25lIA0KPiBmbyB0aGUgdHJl
ZXMgY29udGFpbmluZyB0aGUgY29uZmxpY3RpbmcgY29tbWl0cyBmcm9tIHRoYXQgdHJlZSBhbmQg
DQo+IHRoZW4gbWVyZ2UgdGhhdCBicmFuY2ggaW50byB0aGUgYm90aCB0cmVlcyAtIGFuZCwgb2Yg
Y291cnNlLCBub3RlZCB3aGF0IGlzIGhhcHBlbmluZyBpbiB0aGUgbWVyZ2UgY29tbWl0cykuDQo+
IC0tDQoNCkkgaGF2ZSBubyBkb3VidCB0aGF0IHlvdSBjb3VsZCBoYXZlIGZpeGVkIGl0IPCfmIou
IEl0IHdhcyBhbHNvIGVhc2llciBmb3IgbWUgdG8gYWRkIG15IGNoYW5nZXMgb24gdG9wIG9mIGl0
Lg0KDQpDaGVlcnMNCkFsZXggDQoNCg0KPiBDaGVlcnMsDQo+IFN0ZXBoZW4gUm90aHdlbGwNCg==
