Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B4581164
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiGZKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiGZKoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:44:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BD9201AF;
        Tue, 26 Jul 2022 03:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOcTQF4ETDYEa6X2r7WaSJu71O0epZw2444nuM8oU8do1e+wUJPD0vE9GBRpqJIODxn8WyjEPJnEA4BMWyjAO9Xr6Nlc7NSsD7GFfxpnCsQRbeH6rcLlCwOXi1DknT1L2Cj2+ImZQa/cKBO6RixwZp+OsZiCxxAu7N201lXQWvJcxmKYsfSWCy00jMsWKQX28M9tLwZVXqMqb0Ufn0rLR/8PsaODYl3CenQq7gtfAeOFTF6Eu5SHP7LLnMxm5N30Iwt473k5TCGF8Hmjrd0xNS0qQcwhsFLa4NBb0S1QP2hIyp+IyB4+2v4D5QYEYEbwi+IxxVfpt1DhJEynXnXNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jhnAIm6muWH5DCvARe7meGX8lckoygMf9mbdAc0nM8=;
 b=lHgC5vM0FXt2H207U1PNTyFp/1DBWQqYrXBOovDMADvIvZk/c9vtdNrl+xJwRwW6ZNjLXEc9KTlh33Jpw9VMFKv1V1oRpiV3q0qKKk3kW8D2kiblP48j2GxFanXLIlcDaAB1a6JBLU37OSp0KKeedTFeP1wm0jsXedC7xTJsLSYa8J7UWUylyT/95KBQZjOo8Kd/p7rHp0X+6uSzvZDHAqwC4ETfzH8k11AaxAxVwf7sZ+RaW8U51F02LkBvY8AQBcnTRZyD+11xcjY0E+XHT7ds+oUDNeByfbgRIOhBizw5yfDCHzkNZuekt2xvvlDib5gPKMaTa0jE5CjMKbtMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jhnAIm6muWH5DCvARe7meGX8lckoygMf9mbdAc0nM8=;
 b=O3HnEuEFjiPMXBwPutadRLmMI+YsEUmyRN9dsEpAQilHg1eYvNib0jttSro8wl7aLfJTqCcjXQlDK8+eKKfr2RvP56v3wpnt95h8yw/izyWd5REI7aGLMadYjiu9mgOlsvnhQlAVZzL4110UR0/dYCz7msUyrpHuJ9tUedkS05w=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by BLAPR03MB5540.namprd03.prod.outlook.com (2603:10b6:208:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 10:44:17 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 10:44:17 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marge Yang <Marge.Yang@tw.synaptics.com>
CC:     Derek Cheng <derek.cheng@tw.synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
Subject: Recall: Fix Input: synaptics-rmi4 driver issue
Thread-Topic: Fix Input: synaptics-rmi4 driver issue
Thread-Index: AQHYoNynNRU/zXhYsU2fA/D4o7cKjw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date:   Tue, 26 Jul 2022 10:44:17 +0000
Message-ID: <PH0PR03MB58486D6681B211064AF134A1A3949@PH0PR03MB5848.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ba5008d-df81-4df3-a93e-08da6ef3ca52
x-ms-traffictypediagnostic: BLAPR03MB5540:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFk/0g1mgZDDaZEDbI9z5fQVPCFi65FkxwwBMSGeSvtuKhet7EyQUmDh3GGVEeGV3/ntpXrMAaFlDpZMJc2OB76iNhXZIlHJ2dtSsgOyxarymnAq+9O5YhBaM1fKC5zugAPYTX9wOw/JHqNZ2AL+3vlB1rMeYAXexwytiv6cmAgG8rUIS+ABFdvZYibMOIvaAAQXbVJ4aqtnmSY8ZVjWnhHLycC4I3RYrdNcsaSRdL2BXFfANlilIs0pqC10LVBw6OMty2mkMcuh/oLO4LSzSRxapreexWddOnTOz+aXm3IDYdPWs+CF0XlA+I2J6BHR37/z5jaEI7nt4q33yXa0LI518Dvq32G0yggygHtFiBXkSEr1WUCZ54qzGFnxu2jmhNMiFIwrpE2qaKP4QSi8dXIqj2ftKSA9dvrAqm/tGnZkiVm0LLD7OZ0HzQY4obPzbrFd1LAl8ZldR/OlJW21TpVr5G2tILspsjIl2psgxZ5iCuA4HUAqkQ+1CZznzPRmji7DWmHLMbNP0hHugQPhJIKVgIWvp2QvWL5mG1IljTRu1Iu4XFu66e2To4QEWyjLj39BcWMwBTJFfDgWCI1IdqjecrjVeeixrKVaneFPi2V+1C7ArTBJL+9gcT3cxyAYsuN0vPbO+3MhJZvhmOfb3PzDPj2KsuSDv+c7yH28g8zEfd1Jk3GpJ6dLtDMJIWXSr91TrREESY7H7btsWgtze4dJXrY3X7/+e60DKlfNzBVIGzVZFMz8VE8N7G6c8jtfEtofZ+ohc0PIDxRhP3j7mqoiKbVvxqSjcyg6KbLrRQx+b6r+7m7qW8CujD9sxrzC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39850400004)(366004)(376002)(346002)(38070700005)(86362001)(122000001)(5660300002)(558084003)(33656002)(38100700002)(186003)(83380400001)(107886003)(71200400001)(478600001)(55016003)(316002)(54906003)(110136005)(8936002)(2906002)(6506007)(9686003)(7696005)(26005)(41300700001)(66446008)(8676002)(64756008)(66476007)(76116006)(66946007)(66556008)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zBO5IyLBH1PEgK0D9vLSsf24Tr3gfY1NOYFc5/AGzc9GIlImt65o7DdSCXbK?=
 =?us-ascii?Q?cmEAtEIsiiFi5w0lNXEY+N8VgrOqXj6lkf73xYs9MNo83QrkM2Wx89kdUhmH?=
 =?us-ascii?Q?LAUqodUb1VZKpSfb1G7wkren9HYuBib1KJEQjwlxgvr/fBf+AkJJUhTaZSN9?=
 =?us-ascii?Q?FS5g3BQq8Mmbfyul1BHKnBVOH7PrbFi0ZHLm7JA8c1KatN99jXjS7vlREyLm?=
 =?us-ascii?Q?YC5vF+DQCbi6ziL6Zuizp2LeFVBJ+mZZ7Z3+Rj9pMdeyScsrPbhUVVyisHWM?=
 =?us-ascii?Q?o9okd7A2aSGqS3oPrB84Cfew02kcUfnJegxm7Wg6ScP4wfCPW/wtYocYRu30?=
 =?us-ascii?Q?DqnDUPrYF5eCJuQzAFSwKqclSHgSE7TIRVTbkGTtDN/vj8joke4x4F1fKDhc?=
 =?us-ascii?Q?QDVA7JpMiO2MNT/HMNnR2RcndjYJ3AdR5kMgQMmqw/bwJgAAsweGmy0sGVCk?=
 =?us-ascii?Q?jTAHUwwHH2Kn58ZbNWVgoOMOUJpyTe0IelPGRfKSvSIrgJN4r1Q6P9VPmL0k?=
 =?us-ascii?Q?b4miAPH0yX3kE3X3Yhs+Bc3JC5zVzrQr5ZSnoK8z4yxbbJjWh963/qnM+JNs?=
 =?us-ascii?Q?ycW/w0WWvJl1h3LdZ3naPkp8Irt7VLVdJD/soESIzKFJXzuHzIWTs3mTocGX?=
 =?us-ascii?Q?IxmmoE20wJu41JoX+uF/p2iUkW22koSIxCzaAea0zQ7zWDuoQocXq9et6J6x?=
 =?us-ascii?Q?TZcTuezp7NYOp5FWsyKKR/nZOASw8W+nG0l24mDQvq3S8rQqXeTKWhp/UsoG?=
 =?us-ascii?Q?p2c0Vw3u3G6pL69vOvNgevi9l8jrB+yMDaqQhRuyYVBzfdS4csV7vmUF29Rc?=
 =?us-ascii?Q?7NloZiLv4yOz0rvBHuo9SVq4o1wOLvDX49l3ecoGJMvA4lLwJoLI6zItBWNH?=
 =?us-ascii?Q?iPtmUtp5b/Oz0GojnZdDnAGLIqACiwjDpytXQFahUy/tSCFpxgVmsEI+uZH0?=
 =?us-ascii?Q?oB4iicGPcawn0dfR7BcnwwG+xW1J0lKcAoYVLgDSrptAVZPVCNAwNMEZ38wk?=
 =?us-ascii?Q?0m1xZvMbnEKamH+oS+apQH0gcwwpCe9VD0sqOrtqhIGv5Qq40g6K1LYigT0j?=
 =?us-ascii?Q?rKXtORlZDyT5wiIUya62BZocHIlxp2ZpcZ2qdG2pd9T3IylfuaZ3ZL/glnKw?=
 =?us-ascii?Q?O/y2zr0Qw1DEhViKBwr9GMQZ4E4ouPDURVHxGeK5sCXua/WStystiffTJIsb?=
 =?us-ascii?Q?SV0SZw223wGjyjTC4Xp90TyJwXxrDkfZtU0cYN2OcRvTxvIRocpyze1sgadA?=
 =?us-ascii?Q?Q7BM4uTSVh3MeiNGJQUSZ6AG7P2psEgfrEdbrMZR1U0b+WaHrn1pGTeddwo5?=
 =?us-ascii?Q?AJFCohopwADpRDhPLjSpFKIQOclG05eoVhkOTxm+qLjfIraENkA1FoFCcGbD?=
 =?us-ascii?Q?mWumwRrSCMTLHR1Or1ZZBsIw2PkFnlDP6x+9T3VjkJBlxSzfmvNYEfXkbfAG?=
 =?us-ascii?Q?ImETmrYguF4WhO+GnurPftNSK7lwULzxlBRo/2U8xMpP178tiOLU6DMUZ6c0?=
 =?us-ascii?Q?w//+CwevxYLlqmcqLV/tnlymBWSuPGV+hgoekE10apd2qlpB6u3k3vj2Dib2?=
 =?us-ascii?Q?fxOJ4s1xdINFYO8mweL7gg0B7Bqi2I9I6QvjpbOi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba5008d-df81-4df3-a93e-08da6ef3ca52
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 10:44:17.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lvh4e0CNraoJu3i5ikgpckOGGF+SFnZ9yMXNTlmDLoDBi4uf3EY7b4wJzNHgg9lwtU9uakoel8mr3uNUD9tcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5540
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
