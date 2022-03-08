Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC844D1D58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348386AbiCHQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiCHQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:37:34 -0500
X-Greylist: delayed 4657 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Mar 2022 08:36:34 PST
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02hn2214.outbound.protection.partner.outlook.cn [139.219.146.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F651319
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:36:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD8r0TXt4Mfc1i/3THAq1MgF7JizxruIf75852e61RMhU7Nmv2ZOutYkDYBP5AsFVAtTQkfggN6hLqF+PG9Vqioxs0VhvOYeO9POiwUiMgoRo5KwEh16E7KMDjWSD65/RybcjEF9abQZPI2MGJ92Cg0Gfr9l7KOyVVFAQWsexbdgYHAvF/b9uh3vSDJGggf3efnRpOmhBMlAyZA8Ps54QKGYpFGsENHxLrBfzpWvbfPYf9H0Opd9u7BFyqni9K8QTgGnnsLDA72I8L4+wDJO98DbtER9sCf16uyIZRzM/hh2FAohtVv4FC5laIQ8NNypdv24NkwL9GfWyeqYJiqcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb5aFSXwNmbBhZW2fevVyV1EKvB+qRpi3YTUG9bsK1A=;
 b=Lok/8C3GESilmdRwR3uRl5lxO802m519JK4ojH+0Mbsk4/NvGLdLtMMOCZY0nij7FQHWAtlIyq07VJ0QdsZRvbfMDRqJ5PEHn0TqM+AfRM7snnf35xS/HjXzkgIrq1k6bDg9vukw7+rlzr+4w33T5ZetS/iRJ9zYVS6WOZhDvHOb0P/6YMGi9HWmtqwsk1AByonWSkdozEE0wzrKI5sv1F7sBxP6tP8iLZ9IgG1CFTcNVbng6UXxXLr3LDkZixJQT48l5+FFC6Icg9kQNG7wjkizUIEb84VhVINzDq6Me8JWAnkA3+e2nYZyFzd3zxL6t74xtSFn4qiNhkJ27zyjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pactors.partner.onmschina.cn; s=selector1-pactors-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb5aFSXwNmbBhZW2fevVyV1EKvB+qRpi3YTUG9bsK1A=;
 b=iZJ6WZ4qcrCUZy6NA5ZdsRn8mMMCxQRTOv526EWZYS3A0aqLLLqWoLgqNVzOnkIrdmLVylVUjPPhhi+EXdrDAI3gZ3okXVZ9hbCPl9j/ynHKX+hQsRoOIzqGSCjBXRRrzjJoac3/RCTw/fLLEZCn8Sp2RDWtw7I2i40WQrkQnc6vthQgfjnaxsGCWVPC0vR1NhzFozFtFTTObDW5NwzUcVF//p3aCcP8sdG36LlKRCjBW1jjL5PrPART6P6kuTd6ildMsueswBHG0ES71A5vbdnX5J/9XAsbeB/4Wb0Ci6BATQhkBZ7Vimw5bSmBH3BCP2CO0GpHmtn44Rtu82H4sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from BJBPR01MB131.CHNPR01.prod.partner.outlook.cn (10.41.59.153) by
 BJBPR01MB083.CHNPR01.prod.partner.outlook.cn (10.41.59.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Tue, 8 Mar 2022 15:03:22 +0000
Received: from BJBPR01MB131.CHNPR01.prod.partner.outlook.cn ([10.41.59.153])
 by BJBPR01MB131.CHNPR01.prod.partner.outlook.cn ([10.41.59.153]) with mapi id
 15.20.4995.031; Tue, 8 Mar 2022 15:03:22 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: You won..
To:     Recipients <wenjuan.zhao@gientech.com>
From:   "Mr. Charles W. Jackson" <wenjuan.zhao@gientech.com>
Date:   Tue, 08 Mar 2022 22:21:13 +0800
Reply-To: charlesjacksonjr265@gmail.com
X-ClientProxiedBy: BJXPR01CA0052.CHNPR01.prod.partner.outlook.cn (10.43.33.19)
 To BJBPR01MB131.CHNPR01.prod.partner.outlook.cn (10.41.59.153)
Message-ID: <BJBPR01MB131DA9606393867811E3DF0F4099@BJBPR01MB131.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9510355c-7d01-4c9b-1e09-08da010eecde
X-MS-TrafficTypeDiagnostic: BJBPR01MB083:EE_
X-Microsoft-Antispam-PRVS: <BJBPR01MB083E955FB0CF9ABCA15C31EF4099@BJBPR01MB083.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gQQqCbvZFhonJSRj/6fh2CG951y8szPkhVc14J07opdcm60JyG99LIt7NP?=
 =?iso-8859-1?Q?iZXsHGFAeQ4U8xR0NdTC192RgdupzHOv4RCHxPbYCsRPrxlqBd+aeMrS4R?=
 =?iso-8859-1?Q?A/L/fe6Aw/x8JWRN8RIgXZnNyht33pR2WQMhwJ/xz4sIct4xzKknGO8XR/?=
 =?iso-8859-1?Q?tpdZCb96SDwzazX545a/Kfqb8ZMG/7k/pG64a3Z0ZoWOWvKYWfB/jeOBuK?=
 =?iso-8859-1?Q?XgpHyW4VaBmCCQEtefZUD51nLjSBwvErjBbb+Th46SWOg7Wah2JP7Qx2HW?=
 =?iso-8859-1?Q?ISVynGJQhUfQxiFPewhj9FBCIYVkls4GlmtmtiR+QE4+rjES/yL5fnpcZI?=
 =?iso-8859-1?Q?Mz9ewkMFgn69XwgInTPki61NRliKwW4wvREehkbeH4Vz2XqbpQqSMlSzq7?=
 =?iso-8859-1?Q?LIof9cbJHz1rlooF+7tQsaPnjgrBm24TgztmsVhrKNbf0rLMF527ICRjCU?=
 =?iso-8859-1?Q?VlKnDOOmGy9YtMyZnaJ48XgZiThhMIUUBIMzd1DD6Wx7x35LR7GJvOo9jN?=
 =?iso-8859-1?Q?VdVTwETGo39gAOJ4TWsY/o8SccgZCYu7tkvIVyXXHmKU13ul7d2hLf7FQh?=
 =?iso-8859-1?Q?bxmcmYBxqzKtioz8+znd60655vyiA/wzBCWo/ZuMuaYqrnz58cepQk4SjU?=
 =?iso-8859-1?Q?GurgkDGS6KwTBZTqIMrYJYbBSbChHx4cJWKrpCssCvNbYcO1S3i2fxeIv2?=
 =?iso-8859-1?Q?qGhiKrnIYtRR658cnfsiZ+SBS3VF8RAh19h+mf7ILZcE8T9apJgHg65E7o?=
 =?iso-8859-1?Q?ji8ufShhPVTyLsmYNFlPsuBoemKxUZ98pGowbsWld3lB+uICDr4/KJn4Mi?=
 =?iso-8859-1?Q?HKGWRPN9U0dPB2iLLt7lBlIHcugWQQD2YujvIbwtSZTPgN9sWelpNPgA/d?=
 =?iso-8859-1?Q?T1R+Xvhn6Tg40hZji6VXQyFQzBVtKWGL6v+KnwdIXqh5t25uaMNbfJHpfM?=
 =?iso-8859-1?Q?/KklGaruzFMToB/lEwlmNmDhjo1fgR0wg8nGiWcYkqVVH24Ut3DgqD1yuR?=
 =?iso-8859-1?Q?sqJhiIxdnuDNoQ0EPxjhlVho+riZMCS8JnLmw5xlH5X8neEcE7qUjnBmHb?=
 =?iso-8859-1?Q?jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BJBPR01MB131.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(966005)(3480700007)(40160700002)(86362001)(8936002)(7416002)(66574015)(4744005)(2906002)(55016003)(5660300002)(6666004)(7696005)(9686003)(186003)(26005)(52116002)(6200100001)(2860700004)(8676002)(7116003)(6862004)(508600001)(38350700002)(38100700002)(66946007)(66556008)(66476007)(83380400001)(40180700001)(33656002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?57DC5ZqPERb9RTRGYhBaVmet++7DkRVtTZTLCLqu1uWql1iiUO6y5Ecjkf?=
 =?iso-8859-1?Q?2EPDesOQTfh1TCXK8WrMsAaGi5Qbl463ei0S2pSVRuAHLOCIV38pLXXwHw?=
 =?iso-8859-1?Q?DPAYr3au1ddr40H55hf7Vjym+sUX+HwY+sG4MMPfx6MztZ7AaBeIWCK0TH?=
 =?iso-8859-1?Q?7gIqCW3amU8G53cXWvjjlQWCr5Jr1VO1s4vTJW8kym5NVj5kZiXBdJQe2E?=
 =?iso-8859-1?Q?F4qqGX05pzIuvjQeSGM1qKUq3NSZIIXI74ZOWDYnBRSxVITEK7XxCq0lgo?=
 =?iso-8859-1?Q?XJdhEd8PgCKnq8p8IF72zr+RmnbKvdxa8GfRjc8+6KS75ikyfhmUvyZpf9?=
 =?iso-8859-1?Q?OAOlB8GE3VfLFAi46AbogRwp9dMK/N9TfVwvlFeekvcXsPT1pxGI4iil5N?=
 =?iso-8859-1?Q?on1mdYbp7475KK9bhBT0ZSEIJzinbGO17Fkc/RoxdtQAEJnao3h7cUE6Gy?=
 =?iso-8859-1?Q?fIpwwSANWQKj+bFV1qz4Oh8hGdQ6nzcnD9uk5q9Z9MzGsSXaUvkYNjbmen?=
 =?iso-8859-1?Q?gPTn9tniVpBzDehN0H7o+c3ZfoXraXPNmgq6wwMXhEf2Q5UOd6u0lFxJHW?=
 =?iso-8859-1?Q?Rw36Ip+fDJYyc2kz8oX2zcB0jzFgomEyGSncNES05xLFqXEpKPHcWsytqG?=
 =?iso-8859-1?Q?6PLDbDtmn7JlY1cbn2OWJKTj9H9my1LA4Dj0oWALEgu5qkwWzf7WcZt5kM?=
 =?iso-8859-1?Q?riQPUklW6hN4AHxm5nbgegLncR5xvR0GTYabkt8VscTrzR/Jkhxxnd3XaE?=
 =?iso-8859-1?Q?e/avi0suoN97UkMjHMoFHE+vKfa7DGrGmxdYW85s+lbZWFbrrOWFNpY5q2?=
 =?iso-8859-1?Q?uh341tgQMtB6EB/aU74lZIIW+EamjmoFeBFKT2DPjWRJVpsv3qwuP/aSc3?=
 =?iso-8859-1?Q?xqs4JkBBXqquCOSaPVa9sBDkD+9/C1vw2sQDvLBRKlWXQQq6NmlSNYWxqb?=
 =?iso-8859-1?Q?8Rdqz5NWTAvbXR68r5sc2WjVd6pQ+Rk0EedvybvjlBqGv841hMvHPqI61c?=
 =?iso-8859-1?Q?lIYWilpWFbW5AMwZlztF3Twol2i40nZhbV4cRRSd4iNVpxbYjUS+JeBe5d?=
 =?iso-8859-1?Q?ZyqCUPakEeZ9wuEivR3uk5sycbb6n00QSl0PyxJZG10pnbI7CQypIfVOSk?=
 =?iso-8859-1?Q?f9qQP59iBL8KzwPQWB5vkZNTc3UIX8eYgbqIpzSTQustSWb4yhzcCYT8X5?=
 =?iso-8859-1?Q?CcvF2gdJPfYFbIfyPP3Z/InF/IypSwxlALfONlNJ9gIbUtOfS9YvE9AMVM?=
 =?iso-8859-1?Q?AAQae1zPxZI7iHclFRNtjzh9wH9B0bqyxLoSZukpgc3oNOzNJ2PuYp1hza?=
 =?iso-8859-1?Q?OlbxaOj4KaVRkpUaM/RDyicFPBT4xtT6T+df3XBwHi5LvHDEJwGYgi/pxh?=
 =?iso-8859-1?Q?geq+5fwnD+suzDq6R0tRao98/OxK2oQXShdlZvz2hdEnp9pPILbmjH641D?=
 =?iso-8859-1?Q?3U5S+RA7UIUigI75MGEyYDF1HMagyaJVFL4SckORW7OJ1Vzmnot2p7Cnp4?=
 =?iso-8859-1?Q?xWYoYF1BEnrVmAUifZw6niNkmJkI+4fUqvYrgrRJWXzvgvQAvNqhlGYmiL?=
 =?iso-8859-1?Q?y/M91FV8j1F0tWlK9gEdE/2SGDQgV72wGdDeKQw5OQ+8AiUTDZDjCoWlRB?=
 =?iso-8859-1?Q?Dz4yCw2MsTDrI8aK4QNFp+7FwjfdNy1lEZ8HNSfAhar+zmeuhW+F8qsw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9510355c-7d01-4c9b-1e09-08da010eecde
X-MS-Exchange-CrossTenant-AuthSource: BJBPR01MB131.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 14:21:24.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4u2KKZWDFmXtGXu7eCD4Eo3cvP5uJyccVa+eJL8rxzHw4MveewTAZe5ZvOBAjkaiaYx+8MGmhQa/SduzWBpg6eT2vAxR8goqj04Id9s5fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJBPR01MB083
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I am Charles W. Jackson Jr, you have a donation of 1,900,000 USD. I =
won the $344 million Powerball lottery on Jun 4 2019, I am donating part of=
 it to five lucky people and Ten Charity organisations. Your email came out=
 victorious. Contact me urgently for claims. To help the world because of t=
he corona virus. Here is the youtube Video https://www.youtube.com/watch?v=
=3D0MUR8QEIMQI
Regards
W. Jackson Jr
