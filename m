Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49404511F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiD0PVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiD0PVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:21:16 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1B3EA82
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQa9qSSUGAWNmUSVouDHiqMbdpn+H1vJy0GIMeUBnqBkvo10cGkwV0mrUkoHVlibpoqUNmZ2UbVM3/KbvEQSv8XrHydXD1TGbUgXEPDRSKLWesCDXBREcqU1C2qmjAM8F5ctwzPNrQer2/Act5dkqFDvTzsG1ITESiaDK2clMe5TxQnbBBbTtsbc9Bw1rt4PqJ0BalnDXQrqkVCXyFD3H/i0ihWF3xaKyEG2fcWxzQtE4EUquTlyRQcdZ/iyAAYq56GwYk4vF/DIcU7NOcItiMTzcHXAYXYNYHXdRmtdEuMHW4DsWMNO4WaiOFTQFadWaKt3+rF5hc1WvE9AT/6GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9l3DUokG5uRJ4AJvQUnCor2VC35iCuUAh8fZsmkCHo=;
 b=BgWrY+XpQajNkcOOVzA0B1UcS3mpeBsCU3YRNvj8PbNiC4ksEDdqb8Mu7PBq/Xtm5ny2Tqaz77ipQkXPEZUsH3fjJHwxhJYooQUuZPV48UAjkKXyZWdTR9ukNsXpTTbJaywUvnGOFQg2UMz+FIOJRErumkMJbAB9KnxJXBbxgCXeq3uaGgv012hW6fTqIjoW21ybH3qJzLAkVhMS4yCDCGH4hLWPFJQNgKaOrsYcdSomg0TUrHjK73mB9nkcCcEp4ZbAcLdpHf7mgYvWwwlKX5mLveF9npzJGfC4oK6afe9Rbn8SY+P9TZPybnTQdtSnaK0fEMHQOrisHHayul5oLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9l3DUokG5uRJ4AJvQUnCor2VC35iCuUAh8fZsmkCHo=;
 b=pG33pMRGToChmDVjQgfk4ghP2KtmZ+aB19vxqKFImZucJRems9YuIMTHiW64hjCHwlJPYnkig3zZ9eFkj7M/tamXxiqzDkIglQQg2d7PzOlTw+eGfrlEozmmd66LBxyinTXOtt5pogCBh71KIg7g6L83mE+m05Wh4BZzthXyo6s=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM6PR04MB6471.eurprd04.prod.outlook.com (2603:10a6:20b:ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 15:17:55 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::8ed:49e7:d2e7:c55e]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::8ed:49e7:d2e7:c55e%3]) with mapi id 15.20.5164.031; Wed, 27 Apr 2022
 15:17:55 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: net/dsa/tag_sja1105.c:432 sja1105_rcv() error: uninitialized
 symbol 'vid'.
Thread-Topic: net/dsa/tag_sja1105.c:432 sja1105_rcv() error: uninitialized
 symbol 'vid'.
Thread-Index: AQHYWgZe1/5zkS1Sa0mgh9GfkC0I1K0Dx7wAgAAKY4CAAA3DAA==
Date:   Wed, 27 Apr 2022 15:17:55 +0000
Message-ID: <20220427151754.aosfkepramrgclj5@skbuf>
References: <202204270649.Eun9P40C-lkp@intel.com>
 <20220427135128.la6ifcrs2nmnx4ro@skbuf> <20220427142839.GK2090@kadam>
In-Reply-To: <20220427142839.GK2090@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea8fb2c-c5f4-4a58-e6ed-08da28611b11
x-ms-traffictypediagnostic: AM6PR04MB6471:EE_
x-microsoft-antispam-prvs: <AM6PR04MB647155E4A47563A7827E68E2E0FA9@AM6PR04MB6471.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCj2esYdsMiCUvPkz1p/jeHSr3kc6U4CWRlxDudI7nlPYpReYGgt4H79hVbgR+SmooZhjyzRHOV3uHmJ7eX7Q79SbTfaZ87Dp2k9RSirQNsLHiDqA9/K6x60eYnTEeDIM7e6lhfa+IpoVQP55Vut+lPjmYh5PeGRgcQUb11GXwRxEmtcfZxk/g3zX2yHuLmtHhu5aIlMz2HKQthcjCom0nV26wil2ApjeOCbZ7CO+OftBqva0lhIf9F3X9WbzG97EiWAJGZFVolyHTyTWSDJ4ZBFD8Rcc0DI3EClJRNm0FZu6USx0MLWk7l3poGwBNvKjSDzLNpWPWCQeKtPsM0hTYjxQ0npgfN0k+wPGYfM8oSRBmHHjrlPzQMQ4TlNQqyol6Kx9HMstNOKEA5E3GPU/pd72H2ILVbxazXZ53M83oneoBi6IVT3Lyqao+MuKhnURmvET1CQHzYZOB1WGpiMPXXyW5YpLurmrIeTPJMTldwJRsw3hT8KtwGJfNAfcKjxK5z8idxZBJo8IY8CKdYcg6fq6Pt/EDRGeQwEnB/v8x+bsvQ8MkBTMjYlHk39X/DgJnPGPyNIQaag5UnlsoibdvKNa9B3iMnUoKoWIscVXpfQi3Isf1y61hU3WuXg7sb23gO5/nvKAH/yPSw4mH9LmJFZQgitEna7WVRk5NfDVFniwXvin52BLJv5jXz+5KEvWwnQcOwBXHwKct7E0lG6kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6512007)(4744005)(76116006)(9686003)(54906003)(26005)(6916009)(38070700005)(38100700002)(6506007)(5660300002)(4326008)(66476007)(8676002)(86362001)(66946007)(33716001)(66556008)(66446008)(64756008)(2906002)(122000001)(44832011)(8936002)(316002)(71200400001)(508600001)(186003)(6486002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1gfJS8n8Kvm5oQen26XKMsFARcIcb34rBK+lleRutlN4cB01ZzIsnGFJIPmg?=
 =?us-ascii?Q?d+CRqN0oLKcKHqkLRpzdoZIdRL8G+H9tvCS4nJaULNDykd3oyoKUFCYxf3ia?=
 =?us-ascii?Q?ULodzY1pGxYBlkiPeSbP9oae5VZyl047UdeA4UK0cosfLwiaOGsjG1/N/5T6?=
 =?us-ascii?Q?BeREkDMN0YLpd7NXSRxaVOWIJpyFqhQeyKwxFCZp5plIbPcNKEGjhpd4dFfk?=
 =?us-ascii?Q?HNFl+pHPrD4pBqAeOAd44qoccTSwqrVFW9JHKWWUs9KSIv2j6Tkyhmw3toFt?=
 =?us-ascii?Q?nSWKPVqCHn92ZqwQGhW996NwgMggSd7gFaex3hRGxnMV81qxyRGMTtoB4tpT?=
 =?us-ascii?Q?EVC6qMGl8rFYM/m2U+fntzmr8xumuClYNXO0Ft5ks5UghbESnLnQpz1D3j/G?=
 =?us-ascii?Q?tquNohuro52c0SqCZ2X/VT7aNaRI8rx30lWI+VoxmvxWGOdEAGkIMMsr8KlV?=
 =?us-ascii?Q?z1QGplFsN6vInmW4TjG9MjSzrU4yX/w+Z5YIt6GolqENAUt5Alg4XtRbSveq?=
 =?us-ascii?Q?Qkw99tvwRvQ4Zx7NMtweh3hXTt/X4TmVSJQ8zBNaSxKv7UI1vdvMDJHYw0Ry?=
 =?us-ascii?Q?JZJCbDiVXlcW21srRSnMrka9s0TKFNoOxehD2xG+76lLsIdVxS2NdFrjsIhj?=
 =?us-ascii?Q?yRtrisQltH12JmuEyU2jxqn6fwSxj5xwTmYBTnV9OXNexVWGlfAMMIILZ32m?=
 =?us-ascii?Q?4FFkAq5MWA8XR5W7zcyTECc/VEQNcsmLpPir6TmLCkWaOvzCI8xvHwY1cDXt?=
 =?us-ascii?Q?o77VXeVLW9s1GtUe0/0U8GhzxbbP4AVdLMorFRYXbxmEpjV0HqsOvrnKqmWB?=
 =?us-ascii?Q?/KpjuP8H0Y8+B7NrVHBMv5f41LaL710ymb7BOR/lKgpTJWogU/JQDrnbbneT?=
 =?us-ascii?Q?HLL8P/C94gYpCjt3lisHxK7viFjj0tkAHeQZDI3zIdH+S6N40VyFYnJCAqfl?=
 =?us-ascii?Q?L4B2GtG76bqfi3Vx4usppxCYQ8QAaxucwFm5dFPZ9YcR88Yow42uV+hSQIOh?=
 =?us-ascii?Q?eh968Rr3jnR3PigcBp9D/FGCvd49cmhifCtht/viOOW9YEQxLOhEdEKoDIPa?=
 =?us-ascii?Q?SAoIi0QhIKxDln9fOdvF81xmcFStHLUPO/Ebwf4xdXDNBrGIAXg72itomySy?=
 =?us-ascii?Q?6xZtQPx8ClSC6+syxYLmxcFYeIF46H5pVO3Fn536t4dccpu74F+yhtbxQU2B?=
 =?us-ascii?Q?SKF/DksmlRe7Gb9IJtPFKeA63OOD+jboa4TfigmetMBeN9xWtDxol4fv1A61?=
 =?us-ascii?Q?ls4ppIowi7i9OIcm3e7zHlQZy+Be9p04ZCwMXFK/1RZZw4wqr1JNxxLfzkbt?=
 =?us-ascii?Q?sjvbSeYJPL28jWDrlznC/s0Op8oPDloPwbxYob6SoavdaIk9S85l0E6f5D6s?=
 =?us-ascii?Q?xLOwnA2mlnNk4IYX5zRaW1n69bW8j4DCHxWC8mDXyNmUZbsjw4RbnKUM4aVE?=
 =?us-ascii?Q?sUlPNU2izXn75mNF2zJACBiuSH1wE2Fq0h+AHw0OAkqNr/jtlMiCzBDb3ff5?=
 =?us-ascii?Q?mduB/DXMiazptnfmk9Ez8G17LPYRpgcCSa7jrlp/3nkUim7/yBsj4FfaHxgC?=
 =?us-ascii?Q?Dv+dqv+Z1zKQu3ILAavKUX04jc6fCa4kBw6Kv49nchmTuiVdvck2ZcsjUNEp?=
 =?us-ascii?Q?PZ64ur3DVAWOl0TQp17KlsU5qDvbRVlzlK/LfVHcVnXXjtlpxBM+xTv8n4A3?=
 =?us-ascii?Q?DB2KbGQxgOn25/qo2MOK884w0RR8FGz+M8QiereHVIY0TJMbqPOx1Cvulaj0?=
 =?us-ascii?Q?fFPCJYA6JdqM7EYiPoRRAr6mlJoyHQg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16EE4BF5450B0243A4FF30C665E3240F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea8fb2c-c5f4-4a58-e6ed-08da28611b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 15:17:55.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2p8nIu0an5bTF9dolW+5x6EXWkwNZPnKUHZzBYI4GDUjz6QWUNFM0f3f3Lp+FU2E3Q7RWPtleb5xuIY7baWTNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 05:28:39PM +0300, Dan Carpenter wrote:
> I should probably have wondered why I hadn't emailed you before...  For
> some reason I got confused and thought it was an arch/ thing...
>=20
> My desktop build does cross function analysis so it doesn't print this
> false positive.
>=20
> regards,
> dan carpenter

So I don't need to do anything? Cool.=
