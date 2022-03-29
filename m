Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521AD4EA4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiC2Bkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiC2Bka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:40:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EC52FFF8;
        Mon, 28 Mar 2022 18:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5sSuaTBXZ1qjjDRL7NZSEVm486rOlsd7alfQVS1FNnoJ4cpGp+nZHiJcVVNScgYvA01YhGQ/4qqb+RUJJIdou8F6MJdmt8Lz4MAn3bBn3wRRcm881n4syuFvt1/SWKsIKzDcuqBq3brX6EL4SeUxa6hRv+pwIp3faoRcjnhcP4cJEls2EWPeE1zkS39T+T9nBt7IWGna5z7dmLmGLqoWtLPG74jd0EsaJJD1XWOf1hdFbgDEZb3/kuEMFWh5EDQJroJkLEOauZ3IcX3NWC1UU9jprIX33L4zTe0FcLPiFj6tmkNFK9nl5kZ5sENalVJk7J5/GtuRSHRrfXwVUqW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8I+I+Lrphv2JvL8E2BXLJDFUqxC0Nt+42ON9Jx8dAk=;
 b=mLLKQfBRcVM97vGaD4xzNH+kt54gQ9P0dZ0zqbXTj0hmFRfdt61odjN9/82HDDONKiUnQ4V+9LS9OiYzHj08Z4mEc6/GjPiwYY91Ho7AlVY3C3CMyQlR8QhzIkJSVktGPAYm31/wZOpCCVq9ePm85vOWWLFmiRhHrm/JSED7JgLMT0tigfOPQVUvjXR9o7uAoapEm1WiqfYuudxnVW1PlSdOAD4MwIguwtRgbeibZDVd+xDru+sdWVO2RaK2IVZULVhhoAjhuE+2MInksjfh0KC5RwAkSMmMQndyGptcvFc1IobTl5/7xSMRdNSeiy6MmbTupAh3Be+SqSORBgRzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8I+I+Lrphv2JvL8E2BXLJDFUqxC0Nt+42ON9Jx8dAk=;
 b=xUPfM4iMVD3pztpgGCFqVjb/qQV4PgIVDu7GmZDKFvCV4M4ukz2tLNh48owUE3QhTsYaC/ySJnDR1rrhwKD1b/xAm54cBnpgWgtLjA1NN8T9bJ1XlN+0ruko+yhlutxYmG/qZAq+qLPL+5jkTq3TmmbNP8dQKu+K0yu2HAbm2IXgXlIYvF8siRHd33cPYAVleKBBOuu59rLGP1eDOQ5hyQO8J6TGWPaqVzD//vmDKjOZF3x7AguAkcdnOHpn/6k9keqFzO7aZvyvYhjQN8ZDooSijAQxAsAk7skLKGqbhwNuldrXrFDrHpTT2RcwZqxxp1HlXTyoBUSlNHqXidkyqQ==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SEZPR06MB5414.apcprd06.prod.outlook.com (2603:1096:101:65::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Tue, 29 Mar 2022 01:38:42 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 01:38:42 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/2] Enable ast2600-evb KVM
Thread-Topic: [PATCH v3 0/2] Enable ast2600-evb KVM
Thread-Index: AdhCSKNsviNagc20SGm1dk/H7s7zYQ==
Date:   Tue, 29 Mar 2022 01:38:41 +0000
Message-ID: <SG2PR06MB2315A39490DD5282FC6CF2ABE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa99a85a-4a51-4a32-3c51-08da1124db4e
x-ms-traffictypediagnostic: SEZPR06MB5414:EE_
x-microsoft-antispam-prvs: <SEZPR06MB5414A0B880840B53A6858A70E61E9@SEZPR06MB5414.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: orTJW9Q2Wu9H27FMV2S+QMq8N3cKNsp0App0Y3f10pusZYNaHfsahtoSswv+cdSbzHlA9yvsNFIUzdmv877KDHDphIe3dpVxl/faSBm6qyqjc1x+hGVJFPdQxGw1jBcozLcvADgFi4Rx7yFGcI0OAE0Sf+unUWCbHudn+SSZJBGvLa2JnqYnsZC1C3rTIKhosBBVgNCYYuiFXqxZvFpfuZHbzdkVpH4J9urAUFz2j8BXqovCtJj+e8gyC7AoIE0e/BPF+SQrwFv9HpJKGazNllPrFfYEOXHx+mHU9o7DhWOJF1P36xIt0xv6zfGM2jjti8PNIBeg2RICoeJKJrRL/vGnldvP/YT7Yg13nF5Fc4aLIYpQmjuVsZAB+E8U4GbOCAwPz+VqqkbxCXHsHF9JusIW2B1pAgOb8/LhZY7U8t6jZD+HL2yLb7QE9dyFtsZKaf5zfkKUb4WKSceEORCq/lq55gN6K9ANXGoOgETWdiz2JgwPf5Bi/buUM/ZzRW9MnJvyZSCfUV1y+Wd/mkaK0gWpYJfLIerAVVfwRUwXET2jf2XfdOgvUGgCfgw4BuWnLVuxmLQV6gqzHBXWK3POk9jX7h/imUjeEUY6xORbEyK87DvBkW5ZuzoV1AmQpiUGdSG+4cK7SOD5iRZhMGUx9/uzZiGoCJ1WCkhaFaRq8vOy/9dvA+LI14up4Pq2xIUpi0X/l6wcb7c2UnslIc+jeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(136003)(376002)(346002)(396003)(366004)(5660300002)(38100700002)(86362001)(316002)(4744005)(8936002)(38070700005)(33656002)(122000001)(52536014)(2906002)(4326008)(508600001)(186003)(107886003)(71200400001)(26005)(9686003)(6506007)(110136005)(7696005)(66946007)(55016003)(76116006)(66476007)(64756008)(66446008)(66556008)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VC32yxnnPqxLGKQmmBBrAv8MC63iGlr6S9POmlQbocNIYhEussMxvMynSn2a?=
 =?us-ascii?Q?4qfTnAQ1MYZpgvjUv8yjne6hOjMKpLS6K2l/MuV8jZsGdfZu80FT7+bDLwwh?=
 =?us-ascii?Q?gNKZaix7IvWvv7OnjI+xcv//1vCVAOPxlDmryq1x79upgPDeBIcj1mKSKg4+?=
 =?us-ascii?Q?Sm8u00kHXmbuH9AchcAEqUaw+cLdxE2lqKCaJD5xkmLz8TDtFF/+ECOWmuj6?=
 =?us-ascii?Q?XdZc77KCaYLIgJQWJS4j+o6vTMLSpUNxFv24MdCaEee/G2LkZfXEVx5shB4T?=
 =?us-ascii?Q?9f2L2ZZgSVrlBBJZnBNHjUVcEhQ6vxCjKaHC7eUl8zw5nTVWx/eVrzP8YWUh?=
 =?us-ascii?Q?El64E0SGB3Bp6SkV3V32cTbLeFuqiXLXBXxPFFI4ZnRHybLPcCNf2rfj6FBB?=
 =?us-ascii?Q?k9Kctn9vW2vRKEqU8u466ZxHPGqiikxKAgu1KHMfANTGcBEib34JbRTOPU4Y?=
 =?us-ascii?Q?Inv0LQ3r5J/SkNMQbTIeG1QBdcE1Bc5Zrzkuk0fl/9ZrbyN6nsc5lpZedCwg?=
 =?us-ascii?Q?8YHEVO16LK2Vzg70G0lpYMaONtTmlRuasgf0l206R84a9qW7Nofwifxc4ila?=
 =?us-ascii?Q?Jk+UFde7smH4vIxCTQqOUHTm+3kPESu6NQSWL3MWw5pB1bqlsacNLsZxgyJX?=
 =?us-ascii?Q?8HvEG3+WJNjJO7ThKHd/kXrqRDaHy/L3DkgGIQ7bN4dvbjRwsnI7V0kdccsS?=
 =?us-ascii?Q?lQ6YHtubfh5xOoF1b7+dCBDFFPTs+M6wY62RWbCzOlbBGjNVfWFayL560Vcq?=
 =?us-ascii?Q?nHULKhSTr91EoY3qhvFKdw7RWLyq5ChjGcyc7IbLnKbLyU22VeFV7T7QhZ9E?=
 =?us-ascii?Q?VtSBAi1QNDG6OlsR1AjVVKGWAU2GhAQbXJ2q7ZmEf8mP5TEGvMHFoUsP3E3m?=
 =?us-ascii?Q?yviQOLKpZVh4hloFl+88cdnLLE5GKeYOXcmhCe0XOWUighUTCrXYAKmhnniP?=
 =?us-ascii?Q?JUWBQSJgQId1Wf6BMPE0dSwVj+ji2eBqKJMAY7/GoM2FlbkraRvmDLzKZUun?=
 =?us-ascii?Q?bN09SWUeEVRrRsMnhODxHjhnRzMCFOY9yZAarbIdom1OXuIR2PKvojbcz9mF?=
 =?us-ascii?Q?4Qx9o+VMAw1hVOdSFxzbSmfOJOkJYmtoSCWULuNe9L2N4/NRwroi0C5pRV2R?=
 =?us-ascii?Q?KhxyX4YW5pzmkgZJuU80OUaBIKkYF3CFZJw3biz0YVI6ls5baqgB6VJVwA44?=
 =?us-ascii?Q?XfyrY5gWYTqkWo89q/tqA5aZUmnlsCui9jcaUtWDzF5kRB05lIObIXquQM87?=
 =?us-ascii?Q?XY6rCvWBfbNego3nHaJf3ddCXcPA/tXxIs4dG4p/YsTmpltUmjdnoMMBnrCD?=
 =?us-ascii?Q?O6y1BVMq1ITnjo7VRz9HjIm+Td8YP9Ava4Ro1mwvxk1GGoBPcuVUxtN5XzRd?=
 =?us-ascii?Q?mefPWfmecIoReCnkZH8Gz0EbIH5EtXhzAoIChSYyvlAaQazCpTD4iXbT4Vqn?=
 =?us-ascii?Q?KuZquOFIVygW/REpeKm3PwAjrt82C26B+ZFgPvtaDLu6LX9ATboIL2OP903T?=
 =?us-ascii?Q?Vqz0VkNIGWRWlUUN/OC+5wXcwoTin3XYwKxO8lPwXWSDwSCNJjFnbBi+MXh9?=
 =?us-ascii?Q?XQkkNf31JwBn1q4gHlx4K++1mH+lLgq0eD9hkVJR+YnfK7mY4ywHyz3Oa2WC?=
 =?us-ascii?Q?xlTYZ+K89R3aDkJQwHp9ygEoJRc/ImcQ2u2vO3gRnvJDty89gVI/HZAc5O0D?=
 =?us-ascii?Q?cIZhLJPws2xsPwLG+8cqg61f2lbZa5Z6FogP6/XhlQojC4qP3/ILYecHEb0x?=
 =?us-ascii?Q?UUkvCcM5m+gDb5zuHCBJx+jc/+gyHYA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa99a85a-4a51-4a32-3c51-08da1124db4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 01:38:41.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhWXIASnbsQNMML+lepBKD9ACSxHjgm+DDtOauMh+IyBbdvSjHJe21PwmUy3tkhISTJIrDtJ9n1xjD/c8wmQCZMpiysUfrKt/FQkihcvOeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v2:
1. Add video engine node back which was removed by commit 645afe7 unintenti=
onally.

Change since v1:
1. Remove video engine node which was added by commit bcee389.
2. Remove reset definition because the reset is handled by clk-ast2600 driv=
er currently.

Howard Chiu (2):
  ARM: dts: aspeed: Add video engine
  ARM: dts: aspeed: ast2600-evb: Support KVM

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 39 +++++++++++++++++++-----
 arch/arm/boot/dts/aspeed-g6.dtsi         | 10 ++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

--=20
2.25.1

