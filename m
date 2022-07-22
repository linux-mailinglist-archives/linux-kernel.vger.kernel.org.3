Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0157DC18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiGVIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiGVIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:17:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90239DCB5;
        Fri, 22 Jul 2022 01:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqpZVsTsMvPU69kqhG9Y19rdno+7paUNNzah4PwUV1lYjQcIWd4lH7bw1wNlIlLpbOvo4Wil85nfbAegRajVDXLHYc+uJyc0BAVlNvmkXKmo6kGGemA022ZSLXUx60rcp1Bu23ziWavc6WjDZXPrtupbIV5fMCUhhbQP5c6lEEpD+MN6FfRMgn7Vy5SkzK/Mzgnj4BkYx+fkxlckqd5UPZTgWSnO/zQwPv/3DiL8vR8mcv5Qc61BetNvu8R8mdzSObP1ovFSCSQnJG9n+zE8eIpQLf1/6UJW2F+AtG8vFML6VY3px5Nm2WcvkirYqKSr4MBxfAffvFuoJBYjOtT7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jhnAIm6muWH5DCvARe7meGX8lckoygMf9mbdAc0nM8=;
 b=n3mBWvEaRXQIj0nApXdz0agPxlX9B2s0YLVM0NVKjoxMFPdWQb+d3jlLNLm4ul3Jg9g7iY6enzWdOlQ4QO0LS+V079dbPqI7BvkrU22O4t9s53XAGivYaN9dvWvh7NlCy8+pdpjoouNAFIXHcf7wRe1oKQtFYr9ejxkxCKcKtTjGuDl32nc+s2Cvf3IqFogQ60l6ZOK+BtCUA9h7oIe7foDIkRznmnUWuJz7FJ1oMgkGyWPZ03UWj/TFUS331fh4lq2TpX5ZV5sg2YyWD9aNXowv05y61DQF2xU7ElBEbqc9gww3d3f7Nw9taVyymrPvAO5U+0Oh63Ie7VRj6GZBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jhnAIm6muWH5DCvARe7meGX8lckoygMf9mbdAc0nM8=;
 b=NpIJ5ueKFtrpF7Vv/wdEh0H6qzAbEm0cWzm9r6dVCcwSme4INxiam/bvdhU50oFaFeQcHmNLa8mxvMM8JZCWJmszRHsYD7ERgmQ5AbGNEiRbXzJqzSWfBa63PXQblevUUMcLG+2iddZ+BidvZIBgQqS+tOV3srWQwLtpmZus6aE=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by DM4PR03MB5982.namprd03.prod.outlook.com (2603:10b6:5:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:17:04 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%9]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 08:17:04 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marge Yang <Marge.Yang@tw.synaptics.com>
CC:     Derek Cheng <derek.cheng@tw.synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
Subject: Recall: Fix Input: synaptics-rmi4 driver issue
Thread-Topic: Fix Input: synaptics-rmi4 driver issue
Thread-Index: AQHYnaNtPZmydhe1m0+bMV/QF2HXsw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 51
X-FaxNumberOfPages: 0
Date:   Fri, 22 Jul 2022 08:17:04 +0000
Message-ID: <PH0PR03MB584874189F457844457177BAA3909@PH0PR03MB5848.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81c0422e-3781-4258-9793-08da6bba8f95
x-ms-traffictypediagnostic: DM4PR03MB5982:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QPtTyUs6SlbE2zvjwvNMFdi4kT61mvFM1BZXrI7Q+hXEgn0wSLh09QVhpo/sjB/CywguoLfbAhqK+HQkVfVIK7eW/eH968FpTd3jThftTxknM2fqfVtPZx3cP3wCHg5J8mRxIgyxr9hGGNPwlF9M1tRxM+N+j/2To9UOdrx89pOzhx+vNDY7H8SMVvHGZFVlFRh0dWr4c2cbqaOGhV0z/6553uUfPpSuV/9EycKQP+8FHqIlT1DGLAvOUYnGOgzp5l9uOJI0SI+X656yVcJsrgkBG4URFqJ1jYanE78WDvyI4nlyuy8A+xlBWSC9GZv6A3AEtE6gcVFv5ZLt6ityT7pKNi6sKLMDqJgOkl0yR5p/IVbL9DVl+nx8s/gZNPpo89BawlXPrfcTbjJGdCLPJblWESKjR4Jv2haztlTz9G+a0+OkEqZP44++ejv7TTdw5+MuzGKKPc11Gutk/D6SAg6T84rWYNYeWEIol9xTq3XIMKj/XchE80cqdiPrFN9Ab/u+f8d30WjrpYmOAPQ9y8455rvwEc6uQEeuN671dN31RdDT7r6p27VI7pTNC1uIG1lA3OrF3Nd5tt/uAg+MMaMWLYJLgq1DBFrq7qzcuvqNiNrOPHcELGyMuliLlHTjV+hEvQbkwMwyR+/fcqWtmnJPkqAI8bOoEmKoORglvAFuyAIPEJc8jB0iggpatklnk/cEKEGYsrpZ5HEUBHVVJyHEotuuJSH3KSHYy+1687wiGT8PDlUsahC2VP8qS4B3IssTuTCB06GfixDQQyUFTzIvD9jVWOPmVSjn1svTOXonvE2tw3qUtAbJWpMzUH1u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(376002)(136003)(366004)(71200400001)(5660300002)(52536014)(38100700002)(38070700005)(122000001)(2906002)(558084003)(8936002)(4326008)(33656002)(316002)(83380400001)(86362001)(66446008)(66556008)(110136005)(64756008)(66946007)(66476007)(8676002)(186003)(54906003)(7696005)(41300700001)(9686003)(26005)(478600001)(76116006)(6506007)(55016003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZlYEXfS0eR9evjRbi8pXvjIRnusKyPXBUkNguEWrNT4t70C3VWkqWqYzExcr?=
 =?us-ascii?Q?yvmmr0Rhedpr1v9GzuD7gnRrSLq6uQ9C9YvRFCi5I57J/uqPblQWIXC0ZOQg?=
 =?us-ascii?Q?UU5/Keiqn3fD+Sc6P9YmU+NZX0QxCrVEank5wVAE8EoSIHS4CxNKgpQ8MVDJ?=
 =?us-ascii?Q?o630rntRicuJhPYkQ6zPsSaICdpXuEADDp9TiqgGSSBusn6Iu/uW9OFbq2Rl?=
 =?us-ascii?Q?4+7jw9HyO8wFUgc+gYBW94cp/vg6KsS0icaRqctrpf2WZ9QRM1LgHGcJegAc?=
 =?us-ascii?Q?F6KpYTQ5z6owCVKOJWvLQEKljg0NyMeWujWJndlquIfS7itkD6iKWMRPZdxy?=
 =?us-ascii?Q?koSXEDhM1KBnO7jCNFcmZzL2wtAa7mtkbZGGB4V7z2DuR63/osXMX9Jh5bN8?=
 =?us-ascii?Q?gxhcCU73T03IWKJrbuKb9YoDN3DQDKBe3Lw4U6Nn9fcUgXwqTV6tMRu7RmFA?=
 =?us-ascii?Q?pjdP2RHn+YEagcFHzvvwXckLwLSNFc8CdZgjPnTUfkLXZbxw0GVQTlmM1P6L?=
 =?us-ascii?Q?DOsOZ9MUUXB10IMpiziKZ7ZYQ8HsMtRPaYIgIdIf45r5aAqsn0o0XBxrBMSo?=
 =?us-ascii?Q?BXPaZS7PTYfeAADXrYg6pynYsUqSx/oayugeLRXG149UaxqsP515VXcZDRzM?=
 =?us-ascii?Q?BxDcPCtFtiopd/XmKHCEMXzr0VRUhPAxv4L/0njpsCxKwd1R59WYkbPSswyc?=
 =?us-ascii?Q?Fhon1FLk9qSTwZSl2XO26nV7l4JAvxvQ86BNfSmx/DN5KhYQP55Aw1aH3vxd?=
 =?us-ascii?Q?FKP3rzd9rQhfmmd8R+BpoFjE0MXsjfrHaEQkNmhTGgSagG3HykQQUFHdOVb3?=
 =?us-ascii?Q?QXPB3dMps5HdDscC+kA17SIkdvBKM4cR6I4caFx9PhwmbJCCFRQECK4hZxtK?=
 =?us-ascii?Q?C5hmJQUnCI4GbVr46glAoDBeBc2dEvRf9SKG2V3j9zeShfiAQz5+ckmV0ob4?=
 =?us-ascii?Q?7S641AyIsSZd5qdJDIAic8Qd2tLlAYiXeq8oCmY9wsGvjvAtlBQnZAJpAS39?=
 =?us-ascii?Q?cpQiEmZmDkr+nkmkWY+WFU5cF4nLPpAQRRvel2Tn4JJl8n1U1b+gG480GXED?=
 =?us-ascii?Q?mcg8lORzefd9Xs8gacNtkuNMFNiPEOudLZ3K89Wr4HRZPp08maTA+ivmHHth?=
 =?us-ascii?Q?sXpmQowCQagGgVVwV0DPva+loOUyUIaS8WHlN7PMkiAdzJV6d79xoORYaG8Z?=
 =?us-ascii?Q?1AxO/zAowb26z/abYy2aXSsvUuFf6TxQwCuhBOvzyE2gKS9mamZgMh1p43Ln?=
 =?us-ascii?Q?xMMHg5VWP09jpzgMF5BH73TbJsEirbZhbvpLe1X60G9vpKnydSDxta05FncG?=
 =?us-ascii?Q?OFXe0qUUUhfu+6A4XC9f7ajvrZOE+3ZauSMBn2PrdkfLzvMPjT0cU3EBw9iy?=
 =?us-ascii?Q?YPwtHHvrHndh++dLljrbaoBQBuWSAhkcyftj4d3dtD4CB6wkP36oiHFwl7Xj?=
 =?us-ascii?Q?CO70G43XfN7cM0iqfMtqgS45QNXFLONmMEKaTzoEct+VBBzJj6uJ+NC9MXvd?=
 =?us-ascii?Q?q7QkTfi44m0hhMRc8t0wEXST2SU4B5ffvpdSMDbBBfJi7Z8LhkxQukfNYz3h?=
 =?us-ascii?Q?gPQgcfedo8SB39cW1oWYLHd8h/4EXDbYlPazU5XN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c0422e-3781-4258-9793-08da6bba8f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 08:17:04.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EP5xBjPyeRQU/XqY9Uj/YuuVRNpt7GNET+m2AYjFlZzkAbakDn322Gbvclox7YpGDdRVd3Vc8wMHD2E8eyPNJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marge Yang would like to recall the message, "Fix Input: synaptics-rmi4 dri=
ver issue".=
