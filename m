Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19559704A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiHQN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiHQN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:57:52 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B396775;
        Wed, 17 Aug 2022 06:57:50 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=jLQmj9LiSXMYB/JUeG/48eNjOgDqUgDxI40tUA/WDs2ngBmkoo87cqB7FbNi7sQevcCV5IDHWuyNLn0GyPIxOtPRDMfJEbN48+3gnfi91S8ZueHkFM7qVBd/8PeDjwTVMGDwZgtOBNiAYJNSw4MTXEMi7TLzTESKZpyuFI/HYCFyBZKSbvX/Nl/fdu8aPUsrh2GnxOHNBZS7YGODemNl61WGfkx3nHtH/uzd4ePw7LRBHlpbUCfXCmDvSVHaB9aJDQrCcPq2qPXoyagcyjtRmrVB5vubDrA27Ss7gutS2UsYWnq05B/WJDqSK6MBMbBSRttLpP7QzPRFsS41J6FT4A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/BhSXukoxdcl974gafedzlJyb8XBqg4d9k/5Muycic=;
 b=U9XFGh2k66IHDSt0UBri68QQamX82Hb6elJru69TjHS/S9QPXdo4I88tfvKs9MbjZIVxTLOuzKybY5ehmYzCTOdGX890vuU+/Mvb9xZPPna6QkRGLuU/03qOUHad8neDoyRdMvzfiM+iPEc6yR4WML9/2mRBZVDegwwz99spfG1iqvyd+dKT7Yz6kB2toR1VYiUm4C9dCYXp9jPXFTu5y2xDnPSfAFg6N+/Lb1FWqyVDlsWKvuZV0DHi6Pv5XBcFB4n1gBGWs2nTX9Kk8SmMVE+zrFp0L+e64e9fzMRmZ84TsDmKIArrVXiHDs6eVEbGW0nzPK3AGfCyTTdC2+6lcA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/BhSXukoxdcl974gafedzlJyb8XBqg4d9k/5Muycic=;
 b=oM/fuPBCrXk+8UFOs+EeesgvjRXKCJlaf1BYM+FPSHduYpQMRaIab44lTzUrEY8MiF3Soc7sIVoKcbXz9SdEZf0873hzllFB+cMVobxAQUYk8J25shw9YocD1wW9Kc9TEcJ29+ygAuvFMEI8glvJ2oO6rlwxAW5A4+hZMwsh+Xg=
Received: from FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::22)
 by DU0PR08MB8321.eurprd08.prod.outlook.com (2603:10a6:10:40e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 13:57:46 +0000
Received: from VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::5c) by FR3P281CA0049.outlook.office365.com
 (2603:10a6:d10:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4 via Frontend
 Transport; Wed, 17 Aug 2022 13:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT010.mail.protection.outlook.com (10.152.18.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 13:57:45 +0000
Received: ("Tessian outbound 73dd6a25223d:v123"); Wed, 17 Aug 2022 13:57:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6b98d16142b37057
X-CR-MTA-TID: 64aa7808
Received: from 4fe2c1c443b9.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E873E31B-3A5C-46A8-AEB3-C37A8BC0B7CF.1;
        Wed, 17 Aug 2022 13:57:37 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4fe2c1c443b9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 17 Aug 2022 13:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qoj3Z5bURHcvLrVFEzsK91NRnN1A1uPuzxoDjkpDB5eahvW74oFUBnyEqYUFR+IAOeIhZvOrCdFooJHiLqELBAd0s84ORKqocW2/BVbTAFVLQJl5nkrEbnNA6wFKD8tBOxutusva2vYOvsxSxI/EyExWiMYSk0Do9X9qhw4VndweD2rj3y5NXdBJqRty8vy5SXILgzpDenFR7YWPF3mCIaFvwKSobGzfT6ieniDXxkBTvpFwaqjkAde3EoRhoY9Ig+d2Cr28Qyc2pn7+VwknnvOAaaYJWDQChIMGPEK/R21WEdBq9kIz5bVGub98MUALJO/M0OvGUC5QMs07vDdVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/BhSXukoxdcl974gafedzlJyb8XBqg4d9k/5Muycic=;
 b=Uz1f081g25/uSX6hKDODpbir3LImCFtSHvzgH/9LppdLnm/oAq9UgB489F+6ky2v3xBXPSlVNagGzq3Hz3FJ8yXs8MhWYkLsLPPZ9uUjIEafBQ9OvZiFa+DV+1jZty/ZXkXrxEKL0KoApWqjVg/rFSc24o/NZZJzHPBKnd5xaO9DNjIAUUSeO6GsDTeJqP+Gotyho/NoPffjEG1nDsZxP8OniwXe7wnMYWzW8Yx8hMdmZqdDPEK6SFWSnqVuTBkvLJUd1FRzixNDkt0M5UQrDTOy816hPFvRj/W4pvuwwT83s64ppgSbNpSE43L86Qy6DeErRsaLKqhGU82j/81ifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/BhSXukoxdcl974gafedzlJyb8XBqg4d9k/5Muycic=;
 b=oM/fuPBCrXk+8UFOs+EeesgvjRXKCJlaf1BYM+FPSHduYpQMRaIab44lTzUrEY8MiF3Soc7sIVoKcbXz9SdEZf0873hzllFB+cMVobxAQUYk8J25shw9YocD1wW9Kc9TEcJ29+ygAuvFMEI8glvJ2oO6rlwxAW5A4+hZMwsh+Xg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com (2603:10a6:10:2a2::15)
 by VI1PR0801MB1646.eurprd08.prod.outlook.com (2603:10a6:800:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Wed, 17 Aug
 2022 13:57:32 +0000
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::6cf7:a261:295d:1b8e]) by DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::6cf7:a261:295d:1b8e%6]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 13:57:32 +0000
Date:   Wed, 17 Aug 2022 14:57:23 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Olivier Masse <olivier.masse@nxp.com>
Cc:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>,
        =?utf-8?Q?Cl=C3=A9ment?= Faure <clement.faure@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>
Subject: Re: [EXT] Re: [PATCH 1/3] dma-buf: heaps: add Linaro secure dmabuf
 heap support
Message-ID: <20220817135723.rf567ocaba2k5smf@000377403353>
References: <20220805135330.970-1-olivier.masse@nxp.com>
 <20220805135330.970-2-olivier.masse@nxp.com>
 <20220805154139.2qkqxwklufjpsfdx@000377403353>
 <7e61668164f8bf02f6c4ee166e85abc42b5ee958.camel@nxp.com>
 <20220812163922.v7sf3havi5dpgi5u@000377403353>
 <de46324d8fa8fb6a8dda4641e531d30842410744.camel@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de46324d8fa8fb6a8dda4641e531d30842410744.camel@nxp.com>
X-ClientProxiedBy: SN6PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:805:f2::34) To DB9PR08MB6812.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::15)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8cc9cd24-83f2-4e22-062a-08da8058765d
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1646:EE_|VE1EUR03FT010:EE_|DU0PR08MB8321:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZAl5ZGQIfIFAci38uP/Z0RfX3D15XQddyg/AraW7SisUf13/fGuK8E9Dj6RD7i7JeOUHPeucDwiAVSHC7pbMME0jfptXfH6F15oCYRp3CymKq5K6MDY3bJ8UyEjYav8ATrE0Lt9fgLIMI1AAZdDPdVbOxILCTTxe9+i7LmKvXrXIhXVDOOBaH4Oj9/cLUi76w3EJEc8NH+tSdfdELX0mXc4Bj2GNkpMOEgpZSgXGeV0jzSj1Xwrd/L1aUlNdVBPcxQv/094zPQtGP1OnFojTxkYFbykBk7fctXfUb8DpcK3qtVXk3dCIHxLIiLWoOaFZSMyIGJpNhicbld5jhNiC7joKtqSNE/C4QnNxqhCLK7TJ0K945LOtMKjUnRH83QsFIkV3Y8wSxIUIQimVfpLkFpJNi4yQEFSML/zoXyFLzJneOIV9xWHB+v+5CLleGA5Y+lMFuiTGvRhT3Jy2ghJ7H/1erbDvnKiIgtX8RqVU2kbYsaa1mBoEsE5PeD4GJZ2TU0UcK8iU/0/Ec9A5O3ZUg0iUdKhuHYJ/QB0sHmWmpHv6BVGVRSKNQ/hHMFLVkiwDAcun66xFrjpLf5p1o2xewmZDCn5g9v5C6B+ZP+l9sWxJdSDCmo9DoZngpo9e5ieY81/qJiEVlss8txBA7aLshlsy67PF7z+PyKQdZu0sTlx+bh3G0kgty8FfMRW44ZBz23T5qevsTzuFHRru0QVKR8TFpVbY1iAvg6KKnHJ6kLioR2xBSaCl6aK8Fh2yKKoWZuXBfyr3KndpsIir8upXMJiuUpDGkr8tZXJJ1/SYGEGqFfaktSCt5XXqCvzUgIS3
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6812.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(86362001)(26005)(966005)(6506007)(186003)(9686003)(38100700002)(1076003)(6512007)(45080400002)(6916009)(66946007)(8676002)(66556008)(316002)(33716001)(66476007)(5660300002)(8936002)(41300700001)(6666004)(54906003)(4326008)(44832011)(2906002)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1646
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6dcd3ad1-94d9-4561-7a8b-08da80586e20
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eitKZ6DoduOzBR1JSQXU3EVtPinPMh5GWWT/T6QJJK9+uqiJw74OY0MmE75j/LEktjNVi7Jv7aRHTheBwAl9RuU1VXarhkR5eiiJXUYfRtGjKQud2ycyquKH8mfrezGun5q/Ld0BvJ1Nd5Yvr2Li2iMpOmJCwLXZZBipvCoAIXtkYNu9fB37RynyjEC3BTfFf2XCZwwDC14cULyFtUpfV9UsItWoVS33ybXvWm0zew/ttTE9zh+FhMoc41rZ6bdxu/zHr9cnMIei24lVPCGRysVTk0lqa/TX4XGIMU/rtYwgT4iwBWxVXdnA2SmX41j/A+EEcm9ZHhSnhCKx4+w75bhL4s9ys8294lEL2fVEBSvcz3Usng80dIjuM2iSaaXXCXbVYg6qVipndcfM+tyZNtkCaXL3oVGfrEec44Rsau8dA4Up++dGxM8o26tKwG9H4yBC6Gg/t5CsBWQKmoUm3pL/fvWrZTCF+zMrMdOHB34XlHeUI9jJxY9nJXo/7fRap95jrvI0ZyQDEgAbvNLvOV9QzTYPNcZd7ADw2wMBVh5yPCSOgFw+dcRXYWytkNHL21N/aqnfbvY7VoPoClqe+XS4aCkeVvPo5KdZSiqRRQgQfxuTjq/msGb2U/ZtWSEbko1jRdLsTZ1NDiqRjxU0qPNEdijJTeq3IL5Z1hKjDh44Fl4fYZoidBb2eGSaK5/xAokkEwrD980FeIwH2hTRg2f+2z/LN93ML7NjdgdoC4AfNfXjiXcDUr7rn6JssDrBoI6cQa2NGnBkvQTBnIHzRD7x3yolLMRI4sBnV7aCllJbvTQhxhnzhVwF1p6uPhgqRqt9duE/1qpc62saFUPN0Uekstr05KZrq+PpWfV1nsJQb5+0iY+7ygRmzsQuM4B
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(376002)(396003)(136003)(39860400002)(46966006)(40470700004)(36840700001)(5660300002)(40460700003)(450100002)(478600001)(44832011)(40480700001)(356005)(107886003)(316002)(45080400002)(6666004)(54906003)(41300700001)(70586007)(70206006)(6486002)(966005)(2906002)(8936002)(6862004)(4326008)(8676002)(1076003)(186003)(9686003)(6512007)(6506007)(86362001)(26005)(82310400005)(81166007)(47076005)(336012)(83380400001)(33716001)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 13:57:45.5824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc9cd24-83f2-4e22-062a-08da8058765d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8321
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:20:50AM +0000, Olivier Masse wrote:
> On ven., 2022-08-12 at 17:39 +0100, Brian Starkey wrote:
> > On Mon, Aug 08, 2022 at 02:39:53PM +0000, Olivier Masse wrote:
> > > On ven., 2022-08-05 at 16:41 +0100, Brian Starkey wrote:
> > > > On Fri, Aug 05, 2022 at 03:53:28PM +0200, Olivier Masse wrote:

.. snip

> > > > > +
> > > > > +static struct sg_table *secure_heap_map_dma_buf(struct
> > > > > dma_buf_attachment *attachment,
> > > > > +                                             enum
> > > > > dma_data_direction direction)
> > > > > +{
> > > > > +     struct secure_heap_attachment *a = attachment->priv;
> > > > > +
> > > > > +     return a->table;
> > > > 
> > > > I think you still need to implement mapping and unmapping using
> > > > the
> > > > DMA APIs. For example devices might be behind IOMMUs and the
> > > > buffer
> > > > will need mapping into the IOMMU.
> > > 
> > > Devices that will need access to the buffer must be in secure.
> > > The tee driver will only need the scatter-list table to get dma
> > > address
> > > and len. Mapping will be done in the TEE.
> > > Please find tee_shm_register_fd in the following commit
> > > 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Flinaro-swg%2Flinux%2Fcommit%2F41e21e5c405530590dc2dd10b2a8dbe64589840f&amp;data=05%7C01%7Colivier.masse%40nxp.com%7C6b3d47f1e15c41a8cf7108da7c813ef6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637959191795668899%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=OKZhaNevD5dj7Wjm6zbZlij0mPA9XYyio1NAN3VjTVM%3D&amp;reserved=0
> > > 
> > > This patch need to be up-streamed as well.
> > > 
> > 
> > Interesting, that's not how the devices I've worked on operated.
> > 
> > Are you saying that you have to have a display controller driver
> > running in the TEE to display one of these buffers?
> 
> In fact the display controller is managing 3 plans : UI, PiP and
> video. The video plan is protected in secure as you can see on slide
> 11:
> https://static.linaro.org/connect/san19/presentations/san19-107.pdf
> 
> The DCSS (display controller) is able to read from the protected secure
> heap and composition result is send directly to the HDMI/HDCP port.

But it sounds like the DCSS driver is running in non-trusted Linux?

> 
> 
> >  If everything
> > needs to be in the TEE, then why even have these buffers allocated
> > by non-secure Linux at all?
> 
> The TEE is only doing decryption using the HW Crypto Accelerator
> (CAAM).
> The CAAM will read from a non protected encrypted buffer to write clear
> content to a secure buffer allocated with DMABUF and mapped in secure
> by OPTEE OS.
> 
> > 
> > I would have expected there to be HW enforcement of buffer access,
> > but for the display driver to be in non-secure Linux. That's how
> > TZMP1 works: 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fstatic.linaro.org%2Fconnect%2Fhkg18%2Fpresentations%2Fhkg18-408.pdf&amp;data=05%7C01%7Colivier.masse%40nxp.com%7C6b3d47f1e15c41a8cf7108da7c813ef6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637959191795668899%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=XVpI93dXYu%2BGswLE8dcYboq%2FAWzSJn9j9LMlngpr238%3D&amp;reserved=0
> > 
> > Looking at this SDP presentation, that also seems to be the case
> > there: 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fstatic.linaro.org%2Fconnect%2Fsan19%2Fpresentations%2Fsan19-107.pdf&amp;data=05%7C01%7Colivier.masse%40nxp.com%7C6b3d47f1e15c41a8cf7108da7c813ef6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637959191795668899%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=5Ec61NC1f0UQU%2F3BEURZQhEBrZ%2FuvJ1vaoSN4ChMn%2Bw%3D&amp;reserved=0
> > 
> 
> Indeed, TZMP1 is similar to our implementation.
> 
> > Based on those presentations, I think this heap should be
> > implementing
> > map_dma_buf in the "normal" way, using the DMA API to map the buffer
> > to the device. It's up to the TEE and HW firewall to prevent access
> > to those mappings from non-secure devices.
> 
> In fact, our devices (VPU and DCSS) do not need any mapping, but only
> the physical address of buffers which need to be contiguous.

That's not how dma-buf or the DMA APIs work though - you should use
dma_map_sgtable and let the DMA API take care of whether a mapping
is needed or not.

> The VPU decoder, run by the CPU, read video meta data from a non
> protected buffer and send physical memory address of encoded buffer to
> the VPU HW.
> As well, the DCSS get physical address of contiguous decoded video
> buffer to do the composition.
> 

Can you share the DCSS side of this? Maybe that will help to clear it
up.

Thanks,
-Brian

> > 
> > My understanding is:
> > 
> > * The memory region should never be mapped or accessed from the host
> >   CPU. This is not a security requirement - the CPU will be denied
> >   access by whatever hardware is enforcing security - but any CPU
> >   accesses will fail, so there is no point in ever having a CPU
> >   mapping.
> 
> agree with that.
> 
> > * The allocated buffers _should_ be mapped to devices via
> > map_dma_buf.
> >   Again the HW enforcement will prevent access from devices which
> >   aren't permitted access, but for example a display controller
> >   may be allowed to read the secure buffer, composite it with other
> >   buffers, and display it on the screen.
> 
> yes, in could be done for a more generic implementation.
> 
> > 
> > Am I wrong? Even if SDP doesn't work this way, I think we should make
> > the heap as generic as possible so that it can work with different
> > secure video implementations.
> > 
> > > 
> > > > 
> > 
> > .. snip
> 
> alright, I get your point
> 
> > 
> > > > > +
> > > > > +RESERVEDMEM_OF_DECLARE(secure_heap, "linaro,secure-heap",
> > > > > rmem_secure_heap_setup);
> > > > 
> > > > Is there anything linaro-specific about this? Could it be
> > > > linux,secure-heap?
> > > 
> > > for now, it's specific to Linaro OPTEE OS.
> > > but in a more generic way, it could be
> > > linux,unmapped-heap ?
> > 
> > If these buffers can never be mapped, not to the CPU nor to devices,
> > then actually I don't see why it should be a dma-buf heap at all.
> > 
> > If this is just an interface to associate some identifier (in this
> > case an fd) with a region of physical address space, then why is it
> > useful to pretend that it's a dma-buf, if none of the dma-buf
> > operations actually do anything?
> 
> in our previous implementation, we were using unmapped ION buffer to be
> able to send an opaque fd to the TEE driver which could then be mapped
> in secure by OPTEE.
> Transitioning from ION to DMABUF heaps, our retaining option was to
> create a new heap type.
> 
> 
> Best regards,
> Olivier
> 
