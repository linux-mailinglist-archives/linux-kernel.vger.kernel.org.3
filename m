Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B845A2F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbiHZTCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244134AbiHZTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:02:12 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF281AF00;
        Fri, 26 Aug 2022 12:02:07 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QG5lhG017417;
        Fri, 26 Aug 2022 12:01:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=nh1z+17+5kQdYrT2bPqvDsqvBsZi6YR63whwFAf38x8=;
 b=URdAeUplV5duen1/SwdLsN7sd6drBCSRHr4q/CnYS+v2H/3aOC6r+W38dH8CSVIEYV6N
 PtIlPGwsWLB6EfzYA1uYnfOa/WlTd7USTN58RROXxoV10q1l+rptSw26RJNlKAkgUI9Q
 v7TLBHsv4CEfZMbc5IMVKCfphfDGLal2qpwjJi7Dqc10H7/D8FWihTrTSL6J7girrgk9
 a4AMO0mLDeRX531kLvC431wzcZoPnpTINEs3khzqWXFTtpx/lQBdN5+gjVBlQhJUaXBv
 Gy3GJuIKQEDXqb4wYbU71sAxM1cnGroBnbpmcdZRFfEs8NzgsAF+Pw1G5yEcTNmekrct KA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j51wvpevb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:01:50 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2406DC00F3;
        Fri, 26 Aug 2022 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661540510; bh=nh1z+17+5kQdYrT2bPqvDsqvBsZi6YR63whwFAf38x8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JOVIMO4LNVzdsFcq7EA1AIBG+0tt0XfQ2lPHvkFKEYfEx77OqnKlzYy00YRgSYplK
         IjbLrf/NPjY3IAGV9TUBSHWKQBodqV1K5e1Z7xf/pAR7rrmHL1aJaGbFD8Oz3hcTW8
         sxydUcCCaHwBxN0YKN2PTOpYdLYZxaw4qZT/3gICbaQocfOLRAkxIDj+FR7hRuAcOf
         JbCrNPpG52cA/dDaUodzkpkwOWOJU70msWIs/HdxhShmeKFhjqNe02Qew/h96s16Pv
         xqIx+lYExoCqOK4/nA7jLv2E8hVAq0p5acD4/zyr+6eHQ6hfviJPvyeR6H8gFL02w7
         Z6vvycM+4n3KQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id F02B5A0089;
        Fri, 26 Aug 2022 19:01:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3D6E740073;
        Fri, 26 Aug 2022 19:01:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qDbcmS3/";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGt8xLOAj3csNHaxROyijAnOCyRFQLZRayTTLH77iNfNaToWmUpC3g67LxJ/QNNqyhN0YP/35Jg3v4MhcPNi/rldf6EQDTzfQrQ8qwAYPWAskuVGQ14thQhgxofcXTNLfSLW6ZYlPc+SnDo5GargTcvBwQof1GyLmLpLn/GbSzZclb9mDEi0eLs0aJKziBSebyCqTz5xbtQbcgYp26IMnDpW+SexLShOIfB7oYuqv3iB3kvqVU4ZENefocbdWcAYoPDV934B7NDzgdr+vedwWstbf+Pj1ivF+VYFnzrChIsVqdVnu0Hd3iml59Lddek6VvJOMf+dGX64+xOefXIoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh1z+17+5kQdYrT2bPqvDsqvBsZi6YR63whwFAf38x8=;
 b=F6zURz2NqB8I3N2hTAQHadYhg7aPNfFLPDeiBE11DFuT/Th0Z4qsUOKi0MzAg7Aa3gkZATytT/5qU1PErgw2umHOGgOBkqW356dPAXCzrzuxpIMghdtFe737j/nv454BtRW8Rljv4fI+Md1kYSQCKStPKjiRqeZhJ4XYVtcoBYwutfHNIhf0NRGSbh5eZ+lXKWpHprq8o4VgbOuMIJFkSzN8r3whlisWDiJSuup00e8QPT3lWQ939ngrdI/XvwX8hkoUrKjgQ46UprJEeRZuQvcyZax+x9YvzZ2jA30UBIxNKi8QUiiHogf8KqX3xhzFUTEo385Hq8Oo30wvTBz4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh1z+17+5kQdYrT2bPqvDsqvBsZi6YR63whwFAf38x8=;
 b=qDbcmS3/k26BInpVjB5tUOPIcrZPgn42roPRQCIGNRDB6zLF4mJ/U2ZxSjyz5v/uUD0niYo3z+LM435NhjB3/b2cayqmpT1M8WEm7SMALIQzx4WSd5KqAac559DpFWp323wyn+Rr3QvIanZMR8pQrwC1m2glL6/7xEjQoyaUOqs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM5PR1201MB0153.namprd12.prod.outlook.com (2603:10b6:4:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Fri, 26 Aug
 2022 19:01:45 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:01:45 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH v2 16/25] usb: gadget: f_tcm: Update state on data write
Thread-Topic: [PATCH v2 16/25] usb: gadget: f_tcm: Update state on data write
Thread-Index: AQHYmw7CMRaxV1Fawku+AY1E5jfX4a3BAx6AgADDT4A=
Date:   Fri, 26 Aug 2022 19:01:44 +0000
Message-ID: <20220826190139.yyc5rjxysfzhtvj5@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <dd9069e0527f2da04b6567fd17b19545646f4348.1658192351.git.Thinh.Nguyen@synopsys.com>
 <Ywh0vQkRLTrSeExk@linutronix.de>
In-Reply-To: <Ywh0vQkRLTrSeExk@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11505b71-eb59-4ca6-8b03-08da87956b80
x-ms-traffictypediagnostic: DM5PR1201MB0153:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fs80s1MMGTbwdGupkox3KgVe3hNvf5NdfbbmbqGj7G4RHRF6onzXK6uaNbg+oY15gqeUugbztct7IaQGtonG9x3s4c+g+tjetAnRguQpXwzbrva5PlMY3WQVN4m3qlHe3Gpwe/T1+xYNyDnfr1Xh/mhL9EUNWnii7wHdVWEIuFDEWmOaLIlHMR4owp+2XnOhq/R5dah2FC4vP8aMYLjvelCWfICf6c2J2y15+aMYhZxkCtjNuemMCWDCryJvLyCvSlXjpyUV4Io4v2LQCfyMrmu4iaYG0SAaZiIMT5pRImba2APp8+THDPrk6+3fnzVSQhE0T8LP6AKDJRh6ISHRzkV5pvFAbsIJ/fJjJA+3Wh+7qv1qgtNe8tsy4FbO8jd4OhCc8T40wISMWa5BonieRvCx0ea4PjuyosXzSn6eE1szDd9Vf92i+7vuSAsY0dHL+ua3qtHLIDipCZzgpBsebrQWr2UqLNSRoxXYdtOaeSQyHOBi4rh4Rj7ChLnW6ZRzjSbxgScl9cJomvpn3Aoa94YMyHSuRhPFc3r4Ju280TqKujV7WYSV/wWqgwKsufBublL4aoNbrR0nP3kgyS8wnnYcY2oLho9eYEd6V5jusgMa/bjx/4FMEGVzUDp5injj6MqNfKqXgWvv3oQDHj3VgQTtN0RMSeKKAnd3bhlq1q+tMdBamuxToNYih4bMO8lOM6JGDZIfO3S27IA57W2nhu5rur9YWyixbm1FIcxP137k4wQtL2wXPW5VGijc4jVRe+hY0SW2rMwoOcjZjUH2Fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(346002)(376002)(76116006)(6506007)(186003)(66946007)(53546011)(15650500001)(478600001)(71200400001)(6486002)(6512007)(1076003)(8676002)(41300700001)(4326008)(66556008)(2616005)(83380400001)(26005)(2906002)(8936002)(5660300002)(64756008)(66446008)(66476007)(54906003)(36756003)(316002)(38100700002)(122000001)(86362001)(6916009)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGpJcERsdlR2ZHh0djdBZ0pYdEZjaUhJTDJsKy9TVkU2S1I4MERRRzR3Sy8x?=
 =?utf-8?B?NEc5SVZENmVQdWtsS0U4SkVsQ0pVdDI1YS9VcElJRWlGQ0lCUThabDB3V0d5?=
 =?utf-8?B?RUVQbHRCUlhrVnJoTnA3enlFR3BmTTFoRWpyOTBmZUJac1N6TkhuQXArM3pw?=
 =?utf-8?B?TFB5aFVPaE80NFNyQXIyRVhycit1MExuNkRCS1pzK2Q4NFZOVW5yZ3N0dGRO?=
 =?utf-8?B?UkxYMEcxVDNZV1VVaE42bzNwR1RZblJLaFVVQkFaU2VoR1FnYStBYk1zUFBK?=
 =?utf-8?B?QWNDc2V5enpZYWI4ZkxpczB1emhoOFhyWTdFMnlYUWRxRWNqVlV0ZU1WL1Bx?=
 =?utf-8?B?eDFwbVR3Wmw2b2srNGkreHVUdnFsK0JNeExON1BhbXFLQUM1WG5QNHFoaEVm?=
 =?utf-8?B?Z2Y1R2thUU4vYWJJcHRIYkF2ZXJlTGhMaXc2L0ZOTnZEUkI1UnN1LzBCVXds?=
 =?utf-8?B?Zzg3TDNSY0JXQ045di84c2dVRUhqeUtWTXNNWlV1Z1BqeTVBdmM0UGFyU09l?=
 =?utf-8?B?aDVYNFJWUkpxUXAxT053MVZKZTc4cmlGRnU0ZGxFYVB5M3lwVXh4S2M0eFVp?=
 =?utf-8?B?MEFPL2JoYit6QzNWQUNpeU5SMUNJMzdpc3dLdDJnYTM4VFE3enNnYk16L0Zt?=
 =?utf-8?B?N1N1dWZNRHVoMkh3MStYU1NRZnR0S0FvTjFoc0psMUJ0UDJ4clJNalFMRFNt?=
 =?utf-8?B?ampKS1luNzQ0cCt3MmN0SzRBYTJmekdZYVFidm1uUEdqTUNUbUZDQWZxMHlV?=
 =?utf-8?B?ZE96VFhLTVhiYk1xYk54OU1lUENsTEh3VGF0eUxNbEJuTFowYzkzc1RBN0Zq?=
 =?utf-8?B?aThDL04vNVFUNzV0VDYwcHJDTzlNL3VHcjVFYXhYdXVYL2hHdjN3T3ZEME1E?=
 =?utf-8?B?b3djV2U2dWdBdlB6V2VqSjc2ZHJ3MHg0K05yRkoxZ2tiSjlqd0VMYXAvS0FX?=
 =?utf-8?B?OTlkcm1jNm1DUk5UUE15TDlQK2c0SFBCaTl4YXhISjNpZ05rbWF0djNodGY0?=
 =?utf-8?B?MUQrcEV6YnNwSHh5TzBPbGNxYnRGaC9RWk1rN01MV3dXY2ZkOXdKRitnZkZ0?=
 =?utf-8?B?STBobTVLR0RpRlpVeFFLZnlWZkZyYzhlMjAvbmhsUmQwcHZQRkpGTm5GZTJE?=
 =?utf-8?B?S01QT1U4b09nM2R6RHBIbUlWYXpRZE5iSU9oeERpNW9zaWQ1TGN3V3FCeHhO?=
 =?utf-8?B?RjRrSXR5cThlZ1JuZnFMU3p0UGxpSSt3bjBidk9xVlB0NE8ydUVaY0diYzZU?=
 =?utf-8?B?Vm04dHZPMXgwSnBiT2tzTUttQTI2dWljY2d0NFRlL3lVYmhMVW85b0k3aTRs?=
 =?utf-8?B?MkE2N05RWGR5Z1h3UHQ5VUFseGlhZkRqdXN2ZVZBYkhQVVk2enhzRysvQVZo?=
 =?utf-8?B?NVBpdklVMEVUZEVxOExWWVlhK0pLTDVqSXZpeDlPdy9DTWc4OVVtNVRhV0Z4?=
 =?utf-8?B?QkpHZWVWVVJ5QWdOZHQ1MzMxOGoyencvMWhOYkhiLy9BQ0hZUWEreERvTXdD?=
 =?utf-8?B?TktPVWQ2RlRUMUNsbThCc0xEYjRLc3dUbXZsQ3ZpNEhLbDIwTVdvZ1dHV0ZD?=
 =?utf-8?B?VjlHckRNWmppYkQ3ZE5iTlJZNlhzZXFFN0ppcWZpVll0NzNsVkN5S0VXVjUx?=
 =?utf-8?B?QnJrK1d5bWV3ckVuN0VtVmVBMisweVVibWJ5aWtzZXlUbHVyb0FsM2lKb0ps?=
 =?utf-8?B?MlhHRjluVm1sMHdkUTB0dWRnZkRBaXhvYzVjMWliQkV5ZS9PbURKYzdQVDBG?=
 =?utf-8?B?VU0wUTM0TnhYOEcxSWRHNUhlNjBwVE04azcreWlNTmJFUmpuTjJkd0VxODFB?=
 =?utf-8?B?WEtRNkMzY0ZyM0diN25EalhtRUo2VFBzM3E2VlltUzFaOFh6U05EYitEamg1?=
 =?utf-8?B?VWNpdlFNMDNXM2ZsendEWWVtVVVmTFBUMktlcmN6WE1tcFdKYWFpZU1HL3dG?=
 =?utf-8?B?TW1JZFk3aTVZSEIycVBDcHV2OGkrUk1UdndTdnc2UjR0d3UwamRsOVlzL3dP?=
 =?utf-8?B?ckJyeVhsOFgwenR5Q3kzSjh0VVE5SGM4Ym9SOXVBbzBPMC9ObnpraW1ybGJY?=
 =?utf-8?B?bVpVeDY3MzdsbUVqeWIzb05Kcno1dUpEdm9Sbmt5bEdGU3U3RGgvdUc4Y1Rz?=
 =?utf-8?Q?IUnvzCzUwnlUocoMUMB4p8XyS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A60AE289D584784C892AE65A532296BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11505b71-eb59-4ca6-8b03-08da87956b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:01:44.9497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YB5sSwVAvKzaHQhV5Fx4U8izyVokZN0lN/TSNLTpEt8BpA/q99+lQMnzlP4gm071znshBZ2NmsktcLGOYZJFLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0153
X-Proofpoint-ORIG-GUID: Emyb8JeumKfU-KLlMbLdUnJ5edNXMIUH
X-Proofpoint-GUID: Emyb8JeumKfU-KLlMbLdUnJ5edNXMIUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDctMTggMTg6Mjc6NDUgWy0wNzAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IFdoZW4gcHJlcGFyaW5nIHJlcXVlc3QgZm9yIGRhdGEgd3JpdGUgc3RhdGUsIHRoZSBuZXh0IHN0
YXRlIGlzDQo+ID4gVUFTUF9TRU5EX1NUQVRVUy4gV2hlbiBkYXRhIHdyaXRlIGNvbXBsZXRlcywg
dGhlIG5leHQgc3RhdGUgaXMNCj4gPiBVQVNQX1FVRVVFX0NPTU1BTkQuIFdpdGhvdXQgdGhpcyBj
aGFuZ2UsIHRoZSBjb21tYW5kIHdpbGwgdHJhbnNpdGlvbiB0bw0KPiA+IHRoZSB3cm9uZyBzdGF0
ZS4NCj4gDQo+IFdoeSBpcyB0aGlzIG5lZWRlZCBub3csIHdoYXQgaXMgdGhlIG91dGNvbWUgb2Yg
bm90IGhhdmluZyBpdD8NCj4gTXkgcG9pbnQgaXMsIHdhcyB0aGlzIGFsd2F5cyBicm9rZW4sIHdv
cmtlZCBieSBjaGFuY2UgYW5kIGJyb2tlIG92ZXINCj4gdGltZSB3aGlsZSBjb2RlIHdhcyBjaGFu
Z2VkPw0KDQpUaGlzIHBhdGNoIHNob3VsZCd2ZSBiZWVuIHBhcnQgb2YgdGhlIHBhdGNoICJ1c2I6
IGdhZGdldDogZl90Y206IEV4ZWN1dGUNCmNvbW1hbmQgb24gd3JpdGUgY29tcGxldGlvbiIsIGFu
ZCBtYXliZSBJIHNob3VsZCd2ZSBiZWVuIG1vcmUgY2xlYXIgaW4NCnRoZSBjb21tbWl0IG1lc3Nh
Z2UuDQoNClByZXZpb3VzbHksIHRoZSBmX3RjbSBkb2Vzbid0IHRha2UgY2FyZSBvZiB0aGUgY2Fz
ZSB3aGVyZSB0aGUgcXVldWVkDQpkYXRhIGNvdWxkIGZhaWwvYWJvcnRlZC4gSXQgYXR0ZW1wdHMg
dG8gZXhlY3V0ZSB0aGUgY29tbWFuZCBhbnl3YXkuDQoNClRoaXMgY2hhbmdlIGhlcmUgdGFrZXMg
Y2FyZSBvZiBib3RoIHNjZW5hcmlvcy4gSWYgdGhlIHJlcXVlc3QgZmFpbHMsIHRoZQ0KbmV4dCBz
dGF0ZSBpcyB0byBzZW5kIHN0YXR1cywgYW5kIGlmIHRoZSByZXF1ZXN0IGNvbXBsZXRlcyBzdWNj
ZXNzZnVsbHksDQp0aGUgbmV4dCBzdGF0ZSBpcyB0byBxdWV1ZSBhIG5ldyBjb21tYW5kLg0KDQpU
aGFua3MsDQpUaGluaA0KDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBDaGFuZ2VzIGluIHYyOg0K
PiA+ICAtIE1vdmUgYSByZWxhdGVkIGNoYW5nZSBmcm9tIFRBU0sgTUFOQUdFTUVOVCB1cGRhdGlu
ZyBjbWQgc3RhdGUgdG8NCj4gPiAgICBVQVNQX1FVRVVFX0NPTU1BTkQgdG8gaGVyZS4NCj4gPiAN
Cj4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdGNtLmMgfCA0ICsrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX3RjbS5jDQo+ID4gaW5kZXggMWU3ZDI5ZjhhZWNiLi5kNzMxOGM4NGFmOTggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdGNtLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0KPiA+IEBAIC05MzQsNiAr
OTM0LDggQEAgc3RhdGljIHZvaWQgdXNiZ19kYXRhX3dyaXRlX2NtcGwoc3RydWN0IHVzYl9lcCAq
ZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KPiA+ICAJc3RydWN0IHVzYmdfY21kICpjbWQg
PSByZXEtPmNvbnRleHQ7DQo+ID4gIAlzdHJ1Y3Qgc2VfY21kICpzZV9jbWQgPSAmY21kLT5zZV9j
bWQ7DQo+ID4gIA0KPiA+ICsJY21kLT5zdGF0ZSA9IFVBU1BfUVVFVUVfQ09NTUFORDsNCj4gPiAr
DQo+ID4gIAlpZiAocmVxLT5zdGF0dXMgPCAwKSB7DQo+ID4gIAkJcHJfZXJyKCIlcygpIHN0YXRl
ICVkIHRyYW5zZmVyIGZhaWxlZFxuIiwgX19mdW5jX18sIGNtZC0+c3RhdGUpOw0KPiA+ICAJCWdv
dG8gY2xlYW51cDsNCj4gPiBAQCAtOTc2LDYgKzk3OCw4IEBAIHN0YXRpYyBpbnQgdXNiZ19wcmVw
YXJlX3dfcmVxdWVzdChzdHJ1Y3QgdXNiZ19jbWQgKmNtZCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpy
ZXEpDQo+ID4gIAlyZXEtPmNvbXBsZXRlID0gdXNiZ19kYXRhX3dyaXRlX2NtcGw7DQo+ID4gIAly
ZXEtPmxlbmd0aCA9IHNlX2NtZC0+ZGF0YV9sZW5ndGg7DQo+ID4gIAlyZXEtPmNvbnRleHQgPSBj
bWQ7DQo+ID4gKw0KPiA+ICsJY21kLT5zdGF0ZSA9IFVBU1BfU0VORF9TVEFUVVM7DQo+ID4gIAly
ZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gDQo+IFNlYmFzdGlhbg==
