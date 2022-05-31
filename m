Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D396539150
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbiEaNDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:03:01 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30057.outbound.protection.outlook.com [40.107.3.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5AF68
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:02:59 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=IL/qU8ZR0KZ/hLxNWrYv6FURhVfgxl/32jzvAnXxM39fU3fW8XuDOp2YDdSL5/9Q+v3fuVm9OIK15MtNkX0kdRuWdn1IGEWAS0hM93kxV8nSzQEr1n9DhZU3P3Lvv7jbNXPuYhTGdITFwZ7EPa4TyLa/rQA4UM2CA5xq63mjhuA92zovvWTNlubXRjOs7giMbNrxUfrNMkDnTSdt+cOltQA5h59kAzjQ2F9Y80mzti1zXWHfPV7nU1aYZZQHp2QVmMazcfvoyD3dM1KPzP72GKU/gnAHC5wE4JDYK3//iCuzATwi77C1CN1eDAVyuASop3cbF3w4ME6yUxj8YsJjXw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxN8g6vZAgeLggjyZRR3esJmQZyJpIdlesnAaVxiPzA=;
 b=UEQCtGfI111ksuBJ9N04mW36xI6wlclmkr3zXOQX6msHliIIYfyABIvo7R7NjlJO2Uy+VsnaN3uwI3p1K9sOGlqrckpbOLtvVxEslsvbHwWXlq3wSFvmH+cu6f7S3IW//+t+gVva8Z9g5iFwHfERXeG2PMcQL6DtfaY8+Yc92rYNFnQKD/Jk7asp1U2mebwxlLsy9FBCX3pOC+wB87WokbQd7ABNfFH3frjhdFeFO2GO35A7S0pP5qNbTzPb819OJOOQarmM0IIJE4jp6cf9nNcScmlRnbb0dg6x42f+z+j7rEXFjaE2WerjvX2/hLYgIlESFrLWZ+Z5H42RNMTkaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxN8g6vZAgeLggjyZRR3esJmQZyJpIdlesnAaVxiPzA=;
 b=Gyky6rtPoWz3vutSslOKuqvn3ddRIZGGig5UzST9DdXa5qzSeXligJBd99sXQ7XsA2h13/S46cCYdBiM1vdUshjN5Z9czfAdK4a16nV9DKt2RgAWnx0dSXgDU5eYnwQ3MZulsDkacamN75qqMRFlyySgnllMuVaKksrrBHRwZ3k=
Received: from AS8PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:20b:311::16)
 by DB6PR0802MB2391.eurprd08.prod.outlook.com (2603:10a6:4:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 13:02:57 +0000
Received: from VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::d5) by AS8PR05CA0011.outlook.office365.com
 (2603:10a6:20b:311::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Tue, 31 May 2022 13:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT027.mail.protection.outlook.com (10.152.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 13:02:56 +0000
Received: ("Tessian outbound 5b5a41c043d3:v120"); Tue, 31 May 2022 13:02:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 70e8103b23c9d5f8
X-CR-MTA-TID: 64aa7808
Received: from f69cff49ce0b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 56FC36B0-E15F-4EE3-9D23-9F8E275699EF.1;
        Tue, 31 May 2022 13:02:49 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f69cff49ce0b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 31 May 2022 13:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpyaH++EQ1GcjzKxwcb493ahz0FSphsO34rSemBmlX/9P4QatL+3j39R/YiOMutkYWc4uo3wJViEHX7yXT7qrantqx1dJXoSOzywF+KcKfWR9QS74FCaFj0s0jtMJnIzzDDKDV4dJG5pd65LqDdLJOI8ejSHjFLLVxuF2fyw/TeLnWVon0PJUyJMW4n+77kUb4aBL+5qbQ9kZSQ2O5u98OGZQD/rbR/xroIf5/rJ7d17MaIoyFlav0v5VViaCfqwDq8lu8j4Sv5iQwAG1YyumTA0M5Vj9sF6ZzXMn1nGLbew4PqRm/5SckecwzIDvLp2EUJUO3Rna6NTDkRi/abJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxN8g6vZAgeLggjyZRR3esJmQZyJpIdlesnAaVxiPzA=;
 b=R3htAGEqbbpdggGN+oFltS2FsbFm1DqIEEcjnKvaE9CqFXErTYFLxo/gYF7dSU1YTbvvMi3C2r3K44rBsAGqnL9cqjgR1IN9CtEjTw88t5aFVG55Evsgd9e1sr5O2uT4yVQYLMAby4DNSqrbFqnCEVRkmgUA7IXufxk/a7DcJJsAmoW+dm/ZPKl4xQ+KOvC/Siqn1fW6LOwfCTWkoeuY8626NzIlhlu5UkjcHLN3EITNGpE3Jy1ThaA5KTsD43klwHwlyhzvvGRA+MjVFcT4i5RHC8v5ELt3JGxti+jHBb4LDmLNtKXPyJiHiTcNSTzUsgxNVBYFyaEw/rY0KKIzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxN8g6vZAgeLggjyZRR3esJmQZyJpIdlesnAaVxiPzA=;
 b=Gyky6rtPoWz3vutSslOKuqvn3ddRIZGGig5UzST9DdXa5qzSeXligJBd99sXQ7XsA2h13/S46cCYdBiM1vdUshjN5Z9czfAdK4a16nV9DKt2RgAWnx0dSXgDU5eYnwQ3MZulsDkacamN75qqMRFlyySgnllMuVaKksrrBHRwZ3k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DBBPR08MB6073.eurprd08.prod.outlook.com (2603:10a6:10:1f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 13:02:47 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::9ccc:fe7c:19e5:bfa6]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::9ccc:fe7c:19e5:bfa6%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 13:02:46 +0000
Date:   Tue, 31 May 2022 14:02:32 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Arnaud =?utf-8?Q?Pana=C3=AFotis?= <arnaud.panaiotis@gmx.fr>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, y2038@lists.linaro.org,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: with daemon.c after y2038 on 32-bits Kernel
Message-ID: <YpYR6E9MWJObVtN6@arm.com>
References: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
 <CAK8P3a3m5E2-w4sewEnb4WK68T1wduChR6eSUzsaWPicYhKPHQ@mail.gmail.com>
 <4b83ea18-e106-e7ec-d1d9-daa74aeaf990@linaro.org>
 <cbde441f-b172-2a01-606d-0f97681a59fb@gmx.fr>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbde441f-b172-2a01-606d-0f97681a59fb@gmx.fr>
X-ClientProxiedBy: LO4P123CA0285.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::20) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 378ccd0a-c790-4cff-f1c6-08da4305e1cb
X-MS-TrafficTypeDiagnostic: DBBPR08MB6073:EE_|VE1EUR03FT027:EE_|DB6PR0802MB2391:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2391322AAA844AFB1DCAE376EDDC9@DB6PR0802MB2391.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TAkYD7X8mQmfMAEuJxrxoocZlonssCct+Z3kdcvO4Y7WFfZ3tZZhMJYG7dOIOhY8eUlIUt6/DRVt6+m9Hq7vxfSBWtPuNRzs9xYrKvpQVH4KtOsSEJqLjCZoxR/7j/F/Fn2F/r5cYBvXptJz7KDACywmW3x66iBycecshIJiSe272M1ywiA5xw27/cjrHiEblxioKPg2I+XBeUCJjWN9R3h4LmPMiIw4FAcdnJXB+nQSofHXVKTI8ynawafMhtAlIF84T+R2hFArVfpUNJBNn1z1X3B1hoVhh089Mqw5XgZtvMfchX1wzwwNj0Ied1naZCl4kHNfxId4713o7AAUpaIHNonhWd9XlRkf0gl+4kgkXHL8bAzR1AlG+HVRNKXzZ8q21Jc6nNba/CqWV2rq/zno/8pdFeJfLuiOj7phQOXwj/NHjtrB6hxMDVCxPYo3TUm4wYn7BEq/DJ8hWnKqLfiWL4tCqOASCRUmAhGpYDVV5SAah9G+6OAVWNLS4LJtAQJ+TgzbSqGT5octcWh92YkqS2Tm87zuIFm2UAw5xZkf51hK0NO5/tUZf9noLXTcbj/nwMFMcvC69SqPeV3k07Hhj507/9UlHu8NuxlSh8ZkPiYHigFc6ZWoDqA82fpws6Jv0K789G70BhTjuqKddA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(86362001)(6506007)(6666004)(2906002)(316002)(6916009)(4326008)(38100700002)(66946007)(66556008)(66476007)(36756003)(8676002)(6486002)(54906003)(8936002)(4744005)(44832011)(186003)(6512007)(2616005)(508600001)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6073
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6fb5976-63df-4d56-2ea5-08da4305dbbf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IVL5GCSWeI73jcSoxU6ZJHo2D2OssDjhDNcx5o82WwLz8hY5RApEyT3Wv5K7daqq4ztHPE6uM2obUBOgfbc8oJvZonUyKiOavvQMowxQKMu1inUfC3nBd0IJCokx7DsADmlhVBAehkQZ4/LHNGLcdzrwe9vx7/f6hQ1jiz0e3s7gK3g8LNbCT4qkIpPBb5ykuxPjEmgsUoGyoqUcyLJuANlL/ujkIz3IqYkF0TSPUyxXMNq/gmVhPh64atzTpZfHO1nPNL6M6Ea+zUDKQwb/oQycZZUT+S0PKk7NkmRJc+9x0Ne0hx/mEGIPq+pMevQ2xZzhQMt9++Y0S/S93sgrwe98u77q1Ja0aD15RCYSyWV55bSLiZ1L2WCIUOyi0rfIz57xKoDvnOHFC3AK4oPKxWV2FGUsmT4/BooKzkYkCfPSgMmBzK2+QG3fRK9WcEJ43SgqpKsAoGbmPRv024lw45wm0SidLzBuBucPYsYGgti1NapAHBu9Zg/1NjmLEmHdQLsTcIHcFrAx23901EYo3R9OMmFc9HYr8oErV06NHbAKRRq9+hAJPhIrRmH9M3pEdwkvMDDs4d/plTQi3aBKW6zbjTvWrpMi3C0q9p/pNGL1RrigKC0XnoB6igQPY7+ABbQakCAWLtgaeQRlYYCa6jCnioVkFj0VC2rff7rvSTczYmvHzqH6APj2wnzbFY5
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(316002)(6486002)(36756003)(508600001)(186003)(81166007)(2616005)(336012)(86362001)(54906003)(40460700003)(36860700001)(26005)(47076005)(8676002)(4744005)(82310400005)(8936002)(4326008)(6862004)(83380400001)(5660300002)(6506007)(6512007)(44832011)(6666004)(70586007)(2906002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 13:02:56.7389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378ccd0a-c790-4cff-f1c6-08da4305e1cb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2391
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/31/2022 14:16, Arnaud Panaïotis via Libc-alpha wrote:
> > > > If I'm reading this correctly, daemon() internally uses the time32
> > > > version of 'stat', which fails for files with out-of-range timestamps.
> > > > Are you able to rebuild the ssh binary (or your entire distro, if that's
> > > > easier) against musl-1.2.x instead of glibc to see if the same thing
> > > > happens there?
> 
> Musl did not worked previously for me, not sure for openssh only within
> Buildroot.

did you have a specific issue with musl?

it is supposed to work with buildroot and
has 64bit time_t support out of the box.
