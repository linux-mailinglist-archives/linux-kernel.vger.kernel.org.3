Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461D855DC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245289AbiF1JlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiF1JlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:41:21 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30061.outbound.protection.outlook.com [40.107.3.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CACC5;
        Tue, 28 Jun 2022 02:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPtWHzYVIfz9L5iu7Ir+LoGgHwzFOp1FiaErmBC1OeTth4X0+2nCYvZJECVEzImAlQMqetW4ZCmlbXomIc9+ohdhYvBFbw5XqlsKfJR5GHm5y0hhYD/hC0tRlAEsbLKrSTQrlfo4U6TsYc3uwAB6hok0DFOiT82j5RjbqYxHozox8JWnkXePzBMDAbdenVPIOLRlzCoWYGXR4oOpQM66GDcnFrOuIO13moKuZ+z8gZdFtAJ3icHb9QR7YizuubNk3Ibdk7TQ/3adGx5xzK1+N+/iiUVNo2JmICR8WxD48u+ZkuOmidPC+UndXgNNpWGTHpNO+93QEjkVqpygpDMe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFKwbG+MsqnDjmgsuWIk8UO06kFTzvXJ0AH/FyVWLXw=;
 b=NlDywStKP95y/A2ntwhwA/pgobiSxCjKcfjlD0D2eFWxb8cxT4d51aNgY4BeMk8Y0oPLXjWEGL+r1vhaQ6Jq3ZP0PO5sfwM8rP+tssRNXZIssnBaaejMtomNppfw7G7Mjr6agyh8bSbDXVdYQxY6RueqzNrKs+4s2aUTB48dpVIYEYCauRXscska20Ba3aZjew+xyuPS5Mnq50QDLeqXGuVv4gMdmEjKWVwon1Odu6cCiFfK7fAgNEjnVZBtLp8+FPE1XEEr/oNV9YTd+fynZx1kFLAeKv7T4V4ZXwBl14YJkOzslnnCdBip2VX3lM7LJyznSLc1D9H7UCPVXQzNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFKwbG+MsqnDjmgsuWIk8UO06kFTzvXJ0AH/FyVWLXw=;
 b=kpyR22QgLv/2FO/AoU7Moo6wmHb9XuR9A2QrUMiYpgxSAWXhRvmVjOhf2aTfC9KlUIakVKDuxuKwUS9SoerVsa/eRaoa5yXAqPHoUXzJEDisExiz22jlpUvX1oNzZB3py+8DoVLbwvqrXY9xKp7kKPQr6HlzQsf8waekT4VaS9YadBLGaITIPWKnsawJmQlLtEvDRIcXPB08mP/hKL5yhTJVOkVtU3pYQs+2B0Q/c2auoqE4VO6XcqZOwjLo+2Ca/yu1xjjTNttqwPTZl9aq42toUQY8waSmps1NxaOi+7Wvs6aPKpP/apKkXLjFyeaSFKBaMJzvhv8mG7vAqncG8g==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS8PR10MB4629.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:336::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 09:41:17 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:281c:a9fb:16f4]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:281c:a9fb:16f4%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 09:41:17 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/9] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Thread-Topic: [PATCH v3 6/9] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Thread-Index: AdiK0xmD7lgBt/OSTs2Jhjzgz+ZBZQ==
Date:   Tue, 28 Jun 2022 09:41:17 +0000
Message-ID: <DB9PR10MB58813B83E903F1856FD0CAAAE0B89@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-06-28T09:41:15Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=cbdef815-c8f9-41ae-81b7-f439804e21bf;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a640ea1f-7983-4edb-2101-08da58ea599d
x-ms-traffictypediagnostic: AS8PR10MB4629:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EVQeRSslnMRCA/Kr6noJhTx8yjmR62aKTOcNrffSeE85ZlLXxUYJPlYN3n+sf0iy79sXFbD5turLtqdE5qFRC7hrn/WHeoHY1z3dEf2ilRBUhmnvPcLU8xYrcmupTXwgqi+RQNlXrJmL+HCT3c42SwmvI8u0yqfHs+beMxQRnn6xfrUEdMdMFEOiqGGa2jsNTAUoYngeiOb1qMYaKuZYiryfzNHU//Zjm5jO4zmLlP0PXRE4kXDF6adsVsFM/SAXKhu4VjL0NCti0N8YDrHFH2OCZFzjpbdvM4egMahy+SLvACybNEiivJK219ODCXO05rZ1usjAA6XGRm3U988trwzKVgju+XtkxmHIlx6z27NCsY7eQNkSuL68TmL8f/2RV1cmRQg0pKEASHdjKMv020SPtSh8YoCWuzvEqnzi4At7g+v9eEU/RNTLazkPhtpPBm8p8KT8t132yxHHQcnYUEluEVnz9Ku4YOFY1xK8QTArCb6J+8Rjc/Cnl7Qi7KjoEJtlIsiixxii/9cfBbcCd3Rh00v2tejaUFr5cgxA8E19oC5wimGQM7DB+9yvwh5btJ88gjl1pTbr2NoDVqI6yEaQ2l2C0b/ftWoIWcvCsNRXq9eKynsWIhspHKhzW1CmNu0lnc0irWm5pgg2lRTvfPmNJPi8UR0WiL2vS6st9upyJxMJuFqZ2/1KBh/7beksKjXXSkFqURkVvnIv38FrQzbEQTFs2LnEZdz4ZBI1zBzpq+m51i5x/qUkoOR8vG2p3uAe0zxzmHEY69cRneLxjWedEuaHvht6ettCRAbuNk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(6506007)(2906002)(186003)(122000001)(6916009)(478600001)(7696005)(8936002)(38070700005)(33656002)(86362001)(41300700001)(38100700002)(316002)(54906003)(55016003)(9686003)(5660300002)(66476007)(4326008)(8676002)(26005)(71200400001)(66946007)(52536014)(66446008)(66556008)(82960400001)(76116006)(64756008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CfB3sKrle6MUDtSTvAvqVIzObjavYyPRtMx7Qv3KjZ9FqCy5HjAzlePHy/8H?=
 =?us-ascii?Q?wegyPDwuQRvYZJgIbvudDFd1FxIad9ET0kCbWaVPfGTRLLo7RuwLAV2nnVA9?=
 =?us-ascii?Q?FCqZ3Fr84X0QvNiL/BzjtneWPJRIis+QjhRcEBhP7Fm8ponhb1JWe9oVEoCQ?=
 =?us-ascii?Q?eXZFaAJOfaVmITY4gEtJIphj9jpBJWAxdEggMG7RnyisWQBemXR0dJOH66F+?=
 =?us-ascii?Q?JN9GGKotz10DQJpCAjfzXOKnuizmMe3cKYVqgTtdFbwSO53Er+dsNKhr9Lvc?=
 =?us-ascii?Q?bJAwiDzjUt+t6+qxLYknc1kLCpXbIJyhF/bCN6BKGfDAwlvPReh2PXhoH5M/?=
 =?us-ascii?Q?s3yjESs/nB/7xC76SoHW0s974IHEdVhslrl8oElgsDWlMbzm6D9PDFPW+sMz?=
 =?us-ascii?Q?Aq8dIVP9FMpu1wd0aTeAJSq4srb0pLp243kmTt+KJArkhdhYiCSaQHh4Gsvk?=
 =?us-ascii?Q?94YXqZwZaxuewg8Fv0uqbDmwhJ26VH8Hnk+RcOqOfJN4muZY33jgp4M/pI3g?=
 =?us-ascii?Q?3M7wTxetlhxHM3omxHxk1GvyI+ihmVMGLT1FtvbjNxHae2Gn4iVt3b95x1Dg?=
 =?us-ascii?Q?Ctv9GRIeTOPZ5L9u6v9GslS1VJs4IFvVBWidwxMxcuFuGMFEvWj2F5uKLoVo?=
 =?us-ascii?Q?qrX60BcrZNCLq+IUkGBtrpgl3lwDryAO3HrRHfsEHggnyqSL5DNgPkc/PVmJ?=
 =?us-ascii?Q?GpKOWy4sIn6EhjpsXwTCUNT7dRw00ZhKQWXYhnZM7VbU8SauDw52OJfr/VLS?=
 =?us-ascii?Q?ybbNTcvJ2Y+sL4L4gfpacg3LypVMWxVSJYlx/3jQnm3dnq1Imbr8AxL2ba1K?=
 =?us-ascii?Q?42Rt86hsVvBj1RChBAed9fhx9+CMZdA9g57Fre80t0FZOqnZb4z3vQ1IsPfw?=
 =?us-ascii?Q?9H1AnJ4u7/1xNOjebQ4NLYr6X0dagtrLwqx+czOlZUtG/P88QQ6MlKa4tDtE?=
 =?us-ascii?Q?N0A7XLS4VY1LWejJckYAW51F1oINzNYQLctyeSyv1RshHkm4HbAfSQYo2PhG?=
 =?us-ascii?Q?rpnooTUN4xaVulLxIV2ZeQWBjNsQ7tVAFOQhjygiIJEV1XiE9esb6xPl6lS1?=
 =?us-ascii?Q?ye87fi5rlCquid8lPqpV7duhX58AX++BvaaNKj2gU1zPTITPOjswRw/1mMum?=
 =?us-ascii?Q?LwvFkn+oRqV06Bnpw6pssnT7eA4XHgeAKRTP9lLPNjCKx2QbMsWUvKOzvrP7?=
 =?us-ascii?Q?VuWGlzS/NDMNF6lI1w4QAT334DZtF4XQKOxO8oPsJjgYLXy7nJAakE6UdhVH?=
 =?us-ascii?Q?7bp4v+Jp4GVznDhszQI2z+j8sP3vk6H4peEHgCeN1cpTQTg20Dpg0W8Ifah6?=
 =?us-ascii?Q?A9mszEJl/fSNyaN96hcRPnq57JYXWojpBUnzG3T4O+vMSdhQjGuXycJ53vTP?=
 =?us-ascii?Q?igVXv+m76v6vM5KnAIoSZi7PmOcvOYDX7gTrcc+NU3MXecZIipf8hiYbnci4?=
 =?us-ascii?Q?2EU72HyFEBGWZebPTSG6M4fccoxhNGTOp1nCVGFKNyB8+uAUHxAeNeX7wZF0?=
 =?us-ascii?Q?ZYnF5MHpbUVujSNud5+RrjZ9R+c3OntsrGBbc7d/sxPM371Cf3mgoVK1wY2t?=
 =?us-ascii?Q?BHZrDJrQeYVoaQGGQe0dk0AQT+n4h5DX37gFpMlHWtSAIyFag3XKwBllwUDy?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a640ea1f-7983-4edb-2101-08da58ea599d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 09:41:17.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nedIBTLezOEYSRJZikmY4S7AeuWbbN/Nc5mUKhu/3eiK/Lu5qaPLubX4ipvHz2FNY8XwT2VxND0CYFoq6yz6y31+0pbgzjgyqCuSJGmD0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4629
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please read the stable kernel rules for what is, and is not allowed.
> Generally a patch that does:
>  drivers/tty/n_gsm.c | 410 ++++++++++++++++++++++++++++++--------------
> is not allowed.
>=20
> Please sort by what is stable fixes, and what is not.  Given that you
> don't seem to want to backport patches to older stable kernels when they
> fail to apply, why are any of these needed in stable kernels if the older
> ones are not also going to be merged there?

Indeed, the documentation disallows such big backports as I have just found
out.
Initially, I added the stable backport remark as suggested by you for my
very first patch.
We have split our complete change set in small patches, re-ordered the
changes to submit bug fixes first and documented all changes pedantically.
Supporting all the backports turns out to come with much higher effort as
we have anticipated. We do not have the resources to support this.
For us it is sufficient to keep all our changes on the n_gsm driver in the
mainline branch. Also for all upcoming patches.
We have already done various integration tests with the final version of
the n_gsm driver with Triorail and Funkwerk mobiles. It is part of our
commercial product which has an official approval. The quality and feature
level (3GPP standard conformance) of the n_gsm driver has been
significantly improved by our changes. And we would like to share this with
the community. This would bring the n_gsm driver out of its experimental
state.
Hence, I would like to resubmit this patch series without any stable
backport remark to avoid unmanageable effort.

Best regards,
Daniel Starke
