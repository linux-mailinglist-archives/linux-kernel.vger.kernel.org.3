Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087BE570D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiGKV6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiGKV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:58:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC010BA;
        Mon, 11 Jul 2022 14:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elB2iiX+xm6hg1/ElZRE6Msx2p7b6LlUmDEEuub0HB93iuu1WY9QVUwwOb/GQ3bwGCLARl1cqgMGq5/quzaGjG47/9qSdFMVLfHDHKA8UHm2KDWnglNHzw0fIQAXM/fFVykDFv5oXf8HwUqbAGV42f21/2ZE91IcqzAsdwo3wniwnbjtW2YYrMcVwFTVTvHLQw0juva7z3fODjcklZDaozwuYmLjEOSqXqQjKOBXKpkSe5HdhP8vgPLCkRfqUkSJzTo/L5Hg0rwVazy5y/CkKHQcCxRScCI6rHM+4Mz5iwSPQf9XD5C2ZDfW8/RGy6FtSOPCwn+XAgyq4KuIYH81fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvmHtpdv9EGjoDJcHXyHi1eZZR+xPg382m51e1CqpN4=;
 b=dcCfga4aYHM2LFwIj8mzZmQCjqxolGR9q0FDiIZFrDm/Nixb4ylGiGFVFQoC9y3f7sO60gbZrZhm/e6hsh+r/fmPGhjXEChIXKSxoRi1fegVPf9zxop3PLIUTiZpvo+mdZtmf5oqJcnyYBbg85kbtyfKImgODQq1XYS/IOYv3/HQafqZ86iu/wB8/x0gUlCu6Tbnzy1QcxDqPLmmVBKowl6k84Ujn88FZLjhLmyUWvh+g3ReeLHG7uay27LPSG0Riqvbg9gCiYZErg+bxKotNggLqUf2FEpsRS5p5gceEJqEj5Fv6heC5L3hioF02MgOVLSXo5pF3O1kZUwTYdOJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvmHtpdv9EGjoDJcHXyHi1eZZR+xPg382m51e1CqpN4=;
 b=hHOxPrEAYtccSwSdlAjE+Q+mYmTfAzdklEh1An2eZLK+tlwsIEGKgRoO4Ci16DLgLFLYBiHvmO+wg4yU++CNEaFSrXb/dHmtpi+BEe9FOtH+WsV4k5P2k1bDqkbf59IDilFflknfpG+Az805CdUXevUD9q47/xxM5rgp91neC6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AM0PR04MB5683.eurprd04.prod.outlook.com (2603:10a6:208:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 21:58:44 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907%3]) with mapi id 15.20.5417.025; Mon, 11 Jul 2022
 21:58:44 +0000
Date:   Mon, 11 Jul 2022 16:58:38 -0500
From:   Han Xu <han.xu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     haibo.chen@nxp.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH] MAINTAINERS: change the NXP FSPI driver maintainer.
Message-ID: <20220711215822.7ity2647z2hwecdv@umbrella>
References: <20220711160802.4938-1-han.xu@nxp.com>
 <YsxkjTbXkWr/jMzS@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsxkjTbXkWr/jMzS@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37670353-b581-4296-aeb1-08da63888628
X-MS-TrafficTypeDiagnostic: AM0PR04MB5683:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7lhTb0Eus0htSHpapHfoWYHW68M3nJwSlVSbrfRbAMnPJ8ttsFWZy0LS8KyYAgDBgXWUQRqmYcjmjwrV/nUsxw8dT2ShPB+/MCSdiy+S4kSeTb0XWTZl2dzWI0GNYGIm/X0R18FZ18LmCycrtiBJG+NXU/2LjbfIUr/gK54cNK/M1iQiJs+noWwYqWT0D/Crbq3WutsabGcfcz+nkGE4u6t7k1OCcMUgHKqo3dg5iH0eG7+zTrTCSiq4SsDnVLHfAwSYXkmgbEapv1DooZeyfZg+0/jJEH+IJ30/UZrwGkGPH9evMBIVAgXr7kTkGNkztA7ge0YvXwYZTxCl9pb4jG4eWo63bAzaGbRDUVmhfPBtbwhUqsajFv5rart5HMrqt4ccW0UkIu7ZpXm6zeWPh9HAhO7KtiVqkF31WXSpSTd4A3e9Hqn+XYZuxpvy7i2BVkNDTBj9HLbhApdhUAly2bzXEaHi7VsYofjBu9ItS6V7R06KUfap912gxKTLzvRtpMMR+92YRbM/Kh9ttCDMwLP1Tn5VAx39ybc6eJcnmpQ2iMXt7teyZNNKNfcXPgjdEwx3hgfDosYujWsnxesv0itgbxocNCddX9kwwfGGZJ5f14oOlRcO2riDw4rLvdJsmRNstPBKDlyrmY8L8NQ5pJdi+tihyWcKeL98qsp7y6OJTgG/0ZlKY0UvNnzaE9gcqI782hG5J1IJzyUEVMJ7iqyoT9xiEVev0TB8x9eS2xKLjkB330fKxjB5He8ufB/0uWRmmGSNsEf3o+Hsh3OtUBCZwXdFz+FkJKtGkpwjm53k5RlTM80HlPWSrKO2TnS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(39860400002)(366004)(346002)(136003)(376002)(38350700002)(38100700002)(5660300002)(83380400001)(1076003)(186003)(8936002)(44832011)(4744005)(478600001)(86362001)(66476007)(33716001)(8676002)(2906002)(66556008)(6666004)(41300700001)(66946007)(6506007)(52116002)(4326008)(9686003)(6916009)(6512007)(26005)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g74TtorlUKP3PxfHWWmc2RhVV4du0noDHv1hWpzYL+L4MVK3pBc6+UmWJUVi?=
 =?us-ascii?Q?yzpkdFDzcfsSbdietXl9mmuTVmz46CKwwPwnZ0G2in6K97iDcBgBbyAC4/Yi?=
 =?us-ascii?Q?FXogbh9ww+xCFqeN1MxlEPhMSuI1F/2VOyY2ZKq0Z5cw+q/gpeIA4Y6mbtJd?=
 =?us-ascii?Q?6AOKKtJwK0hnmDqg4y2QNMJ/uLDM8gkSVwYdX6tcG9JHuZXvCeI7qvDQ6SiP?=
 =?us-ascii?Q?uioX2DTtHFlszbj4nnketpfVa95kpKY5IiXvhGGKPfIdcYXKMOHfaa1Wa2lm?=
 =?us-ascii?Q?EoyfLNEgAIV8c8RdHdDgtpBdwMMY9n6ygpiPWdHq7soNbWjLPNbeVc7y3SzF?=
 =?us-ascii?Q?RnZU6CBjaF0ptzHilKXRlvr2bMBKJdYmzGK/5nVxsoILsKqnU7WmE1eXOgns?=
 =?us-ascii?Q?RZy5sB+yX0cAQbjjAxRpBZpR9BG1KSCsOpTYts3V0hvBnV2NSHarLdavFhEU?=
 =?us-ascii?Q?bmPuCclF1uMHO4lo+Sr0/vtmLKIe3zP7JvjbPR0rrRoRIVUAtjwlhxvS8J94?=
 =?us-ascii?Q?SpyddVNVWerrnZ3YwBflq2jEbrjnIxzeMPetj8Xc4RZMgkFOlC/0kteIMTIA?=
 =?us-ascii?Q?MFLXye3e4B1TebckGeBHN8P2gNLkc0g8XSTCWfT4+/JUJadWv/z2RO9rc4KP?=
 =?us-ascii?Q?K076ufLqFiu9o59BMS6KLfzNwqQDr0JxW0S6cV4cBOXUU7qeQbhCTYcLlJL+?=
 =?us-ascii?Q?XDqJRQYi4UPZCh8pk7Fr8RU6fHm/1BJ3Wy/yEblM7tW2XP1R+3FAzMOvRvrh?=
 =?us-ascii?Q?z103mJsF0GwgHZj+iPPuhIVn2U5f1CkEcMC0KIhyX/iYnxUZwwlFtpHuOGeM?=
 =?us-ascii?Q?u4TT1L0ZuWn04FUOMEpJQ556o6K72fwD2VykulcC8Wo6OAiFMInrrWyLq4sP?=
 =?us-ascii?Q?BZBrvLtSerwLSfoVP9lDGbAC39i+zNqtvieZI4o88HOG4y5t5Rbr5KQCgJy0?=
 =?us-ascii?Q?8lJHe6qRZ9S1R3CcXQnVOE3afWj1Aq1gNNeEh70txq2BkBz1/tCzJ1jxzimv?=
 =?us-ascii?Q?pJuVQ14ClWemzx3ImTiC0O+cr5LCknEsCEeW/VT73JSlDcovMwWbo78Ni23x?=
 =?us-ascii?Q?W1k5hr9bl+rGn/PyNVZMPTrbQivgQGl7eVlNPJXArsYujtXAb6uK7UfnTykM?=
 =?us-ascii?Q?wlEoBWMTu1yH7UCdZldz95CaxdDKqugWRXaK0d4mlQhrU0ojclbLT1KcwSbn?=
 =?us-ascii?Q?GOUaABmU9/KNgUjFGKZJoZsKiF5cvifSWqqT5OvRqF0Xxev+UPuzC1Q/4iRy?=
 =?us-ascii?Q?0XyhJf3u/SeBlPC9HpWyxWBlLDHtitdIKHwD0y3MBzNNyECW566ipD1218fY?=
 =?us-ascii?Q?gojUcrjiloR4UOhAxRm3FCIX0rycN/GQf6Y0V1mwEUXQrEP3SqYsr7xOF/N5?=
 =?us-ascii?Q?uoQm50jXaIf/QoNDmHhL+v4n5kMI2vUItnAow8tqt394bBGAE8ins6JGAXSI?=
 =?us-ascii?Q?2lUYqY/FT5tqbUTtftJGlAaUBZdHviHEf/omMDStPPe7lAWxrqxJVSqFMwZb?=
 =?us-ascii?Q?3xw+DNM0Cg+qPfD3nXXZ8YQOB2/smblBRfXiS03d6+mZEyXJc0JNGMvXe7bG?=
 =?us-ascii?Q?XRxaWsKCAEoqCCqaSKMpWy0MFaN9U8m5Ak+CdLa4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37670353-b581-4296-aeb1-08da63888628
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:58:44.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIkXqv7KaODqS0NxUgCN75mTXZuBGJHDq4wJwg07IypIGJ4HNHHRVzk8zGka/zta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/11 06:57PM, Mark Brown wrote:
> On Mon, Jul 11, 2022 at 11:08:02AM -0500, Han Xu wrote:
> > Haibo Chen and me will take over the NXP FSPI driver maintainer role.
> 
> Copying in Ashish just to make sure he's seen this.

Ashish doesn't work for NXP any more.

> 
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > ---
> >  MAINTAINERS | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 83fbc0bad264..070ff36c0a7e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14266,7 +14266,8 @@ S:	Maintained
> >  F:	drivers/net/phy/nxp-c45-tja11xx.c
> >  
> >  NXP FSPI DRIVER
> > -M:	Ashish Kumar <ashish.kumar@nxp.com>
> > +M:	Han Xu <han.xu@nxp.com>
> > +M:	Haibo Chen <haibo.chen@nxp.com>
> >  R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
> >  L:	linux-spi@vger.kernel.org
> >  S:	Maintained
> > -- 
> > 2.17.1
> > 


