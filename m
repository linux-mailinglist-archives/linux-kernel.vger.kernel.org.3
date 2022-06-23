Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6819557A48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiFWM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiFWM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:26:30 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFF33376;
        Thu, 23 Jun 2022 05:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8CitxUIZi8QY2KERGcrDMblGdmijCM3Lb9RPWw9WVJBS33R3qd+CHOL+FuyC97/43xzL/ew057tuKTJk2XoEzCjZd26zNbZXFPOItOYwSvO2CO7ATH/eEf1UIr1pT2cmLs78IKJvzdWC0s/0Pz2dwUyqQXL2NfYfXtr5U5ddq8t4ScH+REaMMup7IBkiB3YewOODqlHiH43kxQbI2ynOpWjlbqnGvy/QVSCyb2kFzOldjG4UcvU6HZndGAMpxeto4uDIAk392oXm9F1NzQZ0Zmb88e1debImzdr5n1UFdqwnHvp4Gd4N5I900T9sfQanntvkpgse3JDILZjAadjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS/uCrixdGhHPbZ2BTSMs51OoDck+uU5PAt65n54jX8=;
 b=YpGFMAXOAz29CeBhjixIBK69XViBBX3YmeF/E/8nahalesoay/gbE1cx7uS3Jt9YvYqYm1NTqDSGxKgNz6EwP/yv48TbyyXmcFq0IdQRt/orIJqZOR16QO/iUwIuHSQkataa/yBa11GDwvo6G0t9RD3BAODqiqJpiAdqShwKyz5qfKrCKjyi20otL21QMe2Z3iPLaj0XYLEBkE7uYlcOnaqxJhJS6ke1pvtPJxXGRWMIqtgIukptfiVDwL+T/9hrtBT5dvaP/bRvD+nCshp+ANi9+WX8pNWg3Mom+A6yOKyv2rMIs0IqoQSQcG4OW+nT44XkDWRpNyTpBUG13rJnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS/uCrixdGhHPbZ2BTSMs51OoDck+uU5PAt65n54jX8=;
 b=ujzy4irfdZ+f3vh5fe4UV9buOkM3ApExOs7fH/hbN73c0T5Q46DoIlC59a8CBk/tfSNbQdziOdDgCjvWPDYpMMkeQa6tc7t5t9j+RfhndwTbdoXfT3X2Ou0N3J4zJzG5Mls1PR1WUjO6NkcnFwRvEkQ1ULOh262agJXn9s8De/TbxaeUtx4w8FhxOno/+tSo0JgIJMGgg/PSczoiW8Jk4SZnZ9tEMOk/a8Oa/ylAEml21tvG/XBftsccoOo9ZR4RjMG7Fz+oI1qBbob6r/ZHN8YF/hqTQVnxVJaO0PoIWw8QQfGNxwuF6SwQ93loQ68vIIvoiaiW0uqMb3Qjy5It2g==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DB6PR1001MB1174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Thu, 23 Jun
 2022 12:26:27 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:281c:a9fb:16f4]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:281c:a9fb:16f4%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 12:26:27 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/9] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Thread-Topic: [PATCH v3 6/9] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Thread-Index: AdiG+4/7kv+FLs4mTtGMPpOtgD9MNg==
Date:   Thu, 23 Jun 2022 12:26:27 +0000
Message-ID: <DB9PR10MB5881188AE33199085DAD1460E0B59@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-06-23T12:26:25Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=c6333cf6-c950-4b6d-b215-3b02556b5786;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83ddfc7-cfa6-4674-9a76-08da55139822
x-ms-traffictypediagnostic: DB6PR1001MB1174:EE_
x-microsoft-antispam-prvs: <DB6PR1001MB1174F4EB076949CCBA603BCDE0B59@DB6PR1001MB1174.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8NW3mfd6xj7cp5jx36kLnumFLVspp203L5Rnoj/9BCxaSdl9948K1g4X1741WRwrprNbRExx7phzSVVfFigKt5orAmH2W8sCcl2FRg/G+cNppNQzPMRtHB/RpxgQZZc2wV0Q14EZxRclYzQQ2QwRB6vQIoyA1cDqBps5bG25c0IbLwOF3HBGJb3mGiiJftVVYKfPUjKTSJLVS9cRwmZtFXzM2nDaMnJtb0QTp9xsabJFLLJnETeC5c9UOgSxpsAx2qE6aWtd00SsVeqr9fWk7C8ZkoC/wJ/Vrn9Evt9VhNVu4fKKvk1S/F9aKS51zQNN2tHOCedH4iCqBX/RSTZdAJiB0LnGCDr5sHjxOuvRIaHvMHYMDBeMm77cU/Z6M25h84v0EQ57qe/+8xQ4J4fiXdDYsWpixc46kIYO1cx2YLA7IpyZf7ibBllXeXYdWX2wGjDustrRus/QYAn1R3GFm+XDUz51RpCoEZk9BKo0Y5dpoUuhEumctpTgyduXqExSo+rPpKdZ5m1x1N7JvOBsf+5Ai+vYSf9fUFWUbXozD385uiD62RJKCUBLZvG4vH2VXrbo0MzLICpSWLqT6YPFTE8KDxAfqWlMXKsPR3wUHmrCpnupWU0VHafalIOs7qsYYnkqif/8a0wx3g6hFKUD1kEaEOu8FouB2BlA3Eaa2qqCV/sqHexLhenWpIteSccpTCvzOntpEopKD0dh/LmbWOjQx+M8YjVXnSntZLHSe3Spnz0Xr3OBq3xo7uQxJMpDOTVrTomfNLmHrHEwFJyKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(52536014)(66476007)(76116006)(26005)(66946007)(64756008)(4744005)(38100700002)(2906002)(66446008)(86362001)(66556008)(38070700005)(5660300002)(4326008)(478600001)(41300700001)(54906003)(82960400001)(9686003)(55236004)(8676002)(6506007)(6916009)(71200400001)(33656002)(316002)(7696005)(186003)(122000001)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IswP5adZQU+dpOpmc9bUWVgRnBcjp5vN5zQ4ViE5Mj8oxFUSZoE8Kpvl7Onm?=
 =?us-ascii?Q?pNYlqNWd4lQTH6+3+PZUr4zek8yI2ffAOo8crfgdk/W/GW+boU8yUQohoEfe?=
 =?us-ascii?Q?oRB8AJOttTLYSQGDnlaOlQ22+Mi9MIRZ08Y7XHicjcARimXCi8YjcuoFRkcd?=
 =?us-ascii?Q?eUafLUFd6SFnklqlxH4IS5C2lrc+N+lP5z91+j3UjMkWm4Txc2ib9xxoCCzq?=
 =?us-ascii?Q?kUGIo5WQR3V6ttZuJC2hG1z5jo3fQ7SETDu67XdD7m98ddvsa3vG6bCGgWq4?=
 =?us-ascii?Q?5aKdbsLR9LwWSzhXeMZp3ku/wB9qH3qZ5vKCDAls/rNKu2kHVejO78aEWITh?=
 =?us-ascii?Q?hUc8tXYPu/2WprW2U+zZ5+OSA/gzKXshTOnfZTdD5kqzni4Jv+NiaRua5Tt0?=
 =?us-ascii?Q?l+FpCAabkfyWw5mJZp9WK9DhajjcbXW6yZkUgvJiIi3FlowoeMDhfLFRlqDQ?=
 =?us-ascii?Q?eoiegXb4y4a0bRgC/7bv6pr8KvT3x86I06QhQwZGPzjTUiHbXzMau6kNbYcQ?=
 =?us-ascii?Q?wAZfLEHZpRwdGADTOSZwOjmfGq9kck97GAV+S8cKylmDZO5TEEK6CJKTIaMs?=
 =?us-ascii?Q?UDLtNNpECd4VxR3SdDTTqbddahDN9K57wbHqPL6axR8XSDxOlKt0ir/MBLBg?=
 =?us-ascii?Q?sS9+lJzzn2/8nteJ7hxixV7mJIhK/w8KYzcH8a/LHC+XnNiDftV4nIMXk+/i?=
 =?us-ascii?Q?kT5NTSwy1n9Q05fLsPoifXNBj1Nz2T3K6Tbrxb028bno/xZBu9LY1dVcFROl?=
 =?us-ascii?Q?Qf69flJvWdUwEplhdULXDhL/Foiq7+fMibqzm31wyL7A45MaIX1mFHjDAB4e?=
 =?us-ascii?Q?9HrN/2L8XB+vjq0UE2ghJJq7KAY5O4UGb9EwLFnu4X1Zzp1uERbmfJ8JifpN?=
 =?us-ascii?Q?Dfu0Fb8EP00/TcHgVYHfV+lS/XFjfDDNB4ltdxsCRhZD5jy0g6m6pQfo5LyG?=
 =?us-ascii?Q?BoRjkiHuuX6JVtjuVqT2LkWS0W6QvgsRCFG0FAjFMFyyO/ZSKnKV5BfSmGQP?=
 =?us-ascii?Q?I1/u25C4eOcKtl5vydzDteUyqiAF8nDdTsD2iD5QeP7EHzasj+EpzqZeDohr?=
 =?us-ascii?Q?A4+yhv8XSECLU/kXxCgTTSpRPY+Id2JXideqfU1GLA0enSwuV354Fraayqeo?=
 =?us-ascii?Q?XOb3INq9stm6wd/7+g+eE42VuRX7uY7l8x8sMOz36j2fUKUAZxgHXA7dAMzy?=
 =?us-ascii?Q?f2vOi1zgcfn1dZhpLwQwXLpuPXfThMIryZRe2uy8wNwaB0rglUzjEf5qTqlP?=
 =?us-ascii?Q?mqkuM/NFWST4q9WZc9NbJnRjJG5Sv2kuBrjEHvJd5DAsFQf5Vxkjq/BjnYDh?=
 =?us-ascii?Q?9j9FFQTyiEZzHkOw+oLj7XZNTKbDD0zMS8f8IKA1++TO5WMCn/sPopU3UF1F?=
 =?us-ascii?Q?WO8ql8yEP+LlNPJ18IinyP8h7QmyqE6HkG4U/r2baHog4IjvOFr6E8AsaQOj?=
 =?us-ascii?Q?zUDO3HcHDXFt4h9VSriTiP/eCse/5gR3BCsoc59PQ8M6+Sa+75QshbE1dzqz?=
 =?us-ascii?Q?2LciHJPVYgsyLxphuXfqjQtpzKeJqbpGuCTPzH5KJDvYJB0SaF4md2u/E444?=
 =?us-ascii?Q?yYa8EzwQkMlS6K6AKnsJj4n5bmVGy3nXBFuCK7unkuAyXHI82qerqBfEWf4W?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d83ddfc7-cfa6-4674-9a76-08da55139822
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 12:26:27.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQnvmrsYRLxZF+Rx77ugKNc43RmvmyyuvEq3d32936aLFpDUf2gTx7soRJtGomSHSpYwYq4V705x+Cej/rEbTHQx0F/aWGgaCmTGwxf/4r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1174
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a bit huge for stable backports, especially given that a huge
> number of the previous stable backports have totally failed and no one
> has submitted new versions.
>=20
> So why is this needed for stable?  Same for all of these in the series...

Given the fact that these are all bug fixes I assumed that these are also
relevant for backporting. Maybe only in the more recent stable releases
if there are issues with the merges.
I do not mind removing the stable kernel reference and keep these changes
only for mainline. So please let me know your preference.
Should I resubmit the patches without stable reference?

Best regards,
Daniel Starke
