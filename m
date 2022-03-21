Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28394E1EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiCUCCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiCUCC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:02:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2106.outbound.protection.outlook.com [40.92.99.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FA13EA2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYF56w1Q5axFmcmbLIxFa5bkbxGEIu9CPgh6wr+1x+Ko2ePNI/6wtBKSvPeMy+33QVyxxnh7pT/2ggRS7THbuznUE7Odo+ZJBzMLg8qcaK9UhL3rjxCKyhfi8/CQ5SRgyrAI9MKFhiWkLxqSS/3Cv870DhrPq+kAedmq3GU2RsTwex6bz3pqYVPgFtRGmGSLCMNzb1MPlO5JNtGZC3xmd3nnx4YdNeCNHg9CB7RegSOSRYZbNdsDL46teh4QbroC6BsR1gO0VdUflB3xQ7ctvetmQwQ7VZ3mrXC4vPIXV4mzFCYbW+hVotep6nkBrSq2PJdvQXx1nDR7szWaF+X1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YNnk5eQb5BGqqIcbU/vBzIutbU4RVn5NkMGqnqt9A4=;
 b=M+PdQKQjTQp2iNxTynDNel91Cmi7Pjf7UjQGwyLmrivFo8A6oL7yyrj7FCg/c0fAOf4M6rU672gkuSTm//Gc8o048iyQTftEQf7elXYgMV/J+ESHsNTbLRKtbEEhOkJBoULU3qaQuvid5kWx67feHVh+mpBOARznulCFDgSXeLRzblll4UjkyfnBvUs4QNhMXi5q7i2UnFDpiIz5TB1fHnneK2ujKsExmVlhKqRmCbfvKm6Rejc6JUGMw9xpzstux4bx7PH0IP7Zjsd9A1lb/J1ZN6SmPortog9Icm6TbAg33AeAAHxarSVkxbw+UNTfh05JY3GRuTKJsb7tLtgDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YNnk5eQb5BGqqIcbU/vBzIutbU4RVn5NkMGqnqt9A4=;
 b=SrscpTfIuWv2nIBhPeCTINBTvEW9lG6h6uGldKa95an6l35rDpGtGra/W7Zj3Z5xKPtCqY42s2iJCGROT6zLFfbjhjWY1gTKQiboBljvrHfkpRUAmPH6SKz4xq/KV+N6Ftqmm8WzhFkMx2nidMwPkMPLOukf+lNnADGUR7MM8Kt0fMGbdZu7T3nYcHmXey7nCB5d2A9j5RQleEc4AtroDvHi0E8L3o7gagWzYTdPhkf68BtRFFw+KAEKUkVCXcQtkm5t5wL3kibic+mpJ89PLf9czwnBpkNyVbv+qwaA49Vnoqfi24SYcwCF/uloa1xn3LSQSPR8X2viTuAgNgxVVA==
Received: from OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16f::10)
 by TYYP286MB1083.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 02:01:02 +0000
Received: from OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e505:230d:4122:cd2a]) by OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e505:230d:4122:cd2a%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 02:01:02 +0000
From:   Cui Alan <AlanCui4080@outlook.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How can I post my patch to others
Thread-Topic: How can I post my patch to others
Thread-Index: Adg8xy6diPuA5dDSQlWeVWPHyWF58Q==
Date:   Mon, 21 Mar 2022 02:01:02 +0000
Message-ID: <OSZP286MB2078A6845CBAE9AC43F7E70BAD169@OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [n77C+Fjp3ZIJMYHLojKaEdIuzyFv5PznFOuOoUulh8qYy8ps1csozvtZC+Iej1DxvpgIPCB+Sik=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bd189c1-a366-48fc-73c1-08da0adea6a4
x-ms-traffictypediagnostic: TYYP286MB1083:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n1HPpejn8sOF0usqTP7YYbsvtOInnlm2S4iEPYM9bB8uKvRVrq2N/wLtkejeINk0iyxhqAhsTaNNNHKx+Pw3NwfCcZ/GJzP14zJtmEuSS7kYgivbV2LbrqYx9WGcmt4xU2mGbkJbB0la9KPRkJJXAIwvQaDKCsie26eUOcFMKRH/az8+l5YX3Hx3JObuj+astaQV+shm07egb3PaIn7MhwfAWdsl4fZqbs6k8L9lq5Pe8DGADhYdScwBGmsNasdxE09fVV7S0LGUkS2d+uH81xsuk5G5et8e0hDpVnVWLBoP5h13dK6I9AVLhegwOmPRfxc+KAGa8+s/0EynJ67NN+tyjPTaMaHmgZZtUe2Bes9aIhsN+EsQBj68NUpPGBuVboSsKSRK0gXPwtd9ck6MzoFY8BX1FL+b6N90K/tX5MxROx40oJdPBrXpOPU+AHt5hKZFo3GJWwij/flMeoirBXPzVLZQr/eYwu0FLXi0agFAbGt24rrZdT+1yfW5lqk/F1RvRQySlQ+HjROvTrc33tkJVl1bUIcZ1+NtlNEkr22CSo1pgKRJjpD/wbAEwKDu7GO7q23uiLreiqdaMdjHjw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5mNhIinztpZfwQmUHwCwZLTrtyyEMzqtE0brNie63k+M1eH1gw1w1nNTMWTy?=
 =?us-ascii?Q?e12f0e5oMNCJ4b9aesOAM0N2v41Bh5m3zONf7ITS6+SUPHIFNxlFgcDcdG2p?=
 =?us-ascii?Q?NDKbVNi8pZFB9TsZ3m4chyioNaWjHnt1guZhbvhQ8CdDXOwdi3X59Oyoeysk?=
 =?us-ascii?Q?3BqMCgidpjXDTkLE7yZT9YZmtshNaeh2j+NsG4wumEr25ofGRBRlmUNFU+j7?=
 =?us-ascii?Q?QdarqFw6aZZRzJTOv+bhEdDWskouMf/jsuW6dJBv8di4uFz6yzH+qlgmAa2I?=
 =?us-ascii?Q?IkIjwAFcD7Ud4wRoqIki3wC/CUE9mDv/DKy0TTExrX2EB7flYGN2XSOwZO8g?=
 =?us-ascii?Q?hYFSR+VnnjbtCmEPrYNwX834DUezVUJgrYatZpd6mbvTa7PQT13M/8wRqGm+?=
 =?us-ascii?Q?SH2paIchhpmWBSdL/Y/HPJcWXJ4ku4xmqJapEUUeLIzGwyUrMnA+sr9uzmcw?=
 =?us-ascii?Q?cdNxnmTDL7en4Aqal6mKai0/BwCg13ARCapFoql7WlM20ucFBzR5Mic3Fz3I?=
 =?us-ascii?Q?xSUwSEuzKrpEUJ4c4/bkZFfvAq3w0XC+hrBA4j470ql31Oa9y0yiLNmo1JAC?=
 =?us-ascii?Q?+ub3g3DH+8boK35ywudGXZdErEW00r5kZ+agXJZfStpETQTPGebPXTaG/ehf?=
 =?us-ascii?Q?KUetA45NUrA9+igKhcr4dyRm3xbEQk/7LzJshE2oF3XHGNkdDp0gUqNzZZkA?=
 =?us-ascii?Q?2bzMj5IzGLHXslIda8RZ/R6+j3Iakt7QM7xcvhTSTcOkZPnYSOeV6OxEMBq+?=
 =?us-ascii?Q?pDed5VdZwatU7qu37pCtYA1bzZIUbNlvlqDm8psfSj3rvsfqx/yhRgMoqpH4?=
 =?us-ascii?Q?LZ+i/SeTXvuMgQU8vTJxAeBnns/XnGiS20q/8xjmimIPlLdrT87P6jFHAdxM?=
 =?us-ascii?Q?2MXjJjepcJW8ggdGJL/L8EKeQnTYuSgFqvKMhJ8AHSMCB0oejK/WUy3I9DDC?=
 =?us-ascii?Q?WNoEr1G0y/WzdtwH0RLbo1piPLxpGJ4A8vhky7kYdeIznU8jEgVlzAdtf0G4?=
 =?us-ascii?Q?GfnGSDKFWDSic/5g+oOxuCFKBtMlZk6Dn2UJxe3QoV3IlfTb5cY1l58E3ln9?=
 =?us-ascii?Q?i/ZkT7Tb/qqdqeyFUvyVAlJ9UZVDZq9ADd9Kouuv4oMtUHpZuJ6Wqy+wr9im?=
 =?us-ascii?Q?akc4x1IK9ncpHaG5z+jsPASsEGs4TZzPk2QwT5Qncto86bN9/aC6+RrBz+8t?=
 =?us-ascii?Q?V59R1qfhT7BhelarfSGlAclteJ7owgdbqn/uiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd189c1-a366-48fc-73c1-08da0adea6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 02:01:02.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1083
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collaborators,

I'm going to post a patch, but I still don't know whatever can I simply pos=
t the PATCH to others in the "linux-kernel" mailing list. It's said that I =
can do that to make PATCH examined by others. I don't want to pollute the m=
ain list.

I didn't subscribe the "linux-kernel" mailing list, so I'd rather get an Cc=
.

Sincerely,
a.
