Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6E492FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiARV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:28:32 -0500
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:60801
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231853AbiARV2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:28:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f53bmPVyiJ/dcUBX3JNmhCEV16S4OoFA5+dgNyS0AabedhZe4DVsMZxYF4k5ex0YvgzAu93gIdKKtVxq9y/S5pgowLTdEcQ9DL9IQeZptP+I91H+GSrhozs8OHo+VBIcE3YsFYZg/nXkiguLurv+YUcUY0qkogVrvBppd0OxWD5G+n8/YI78kXiW5CFrWshbcOir7YONtxiqxBvU17lrMyz0dMv+weeIPS7RQZPhlyfNk8XCHICN9kFOZsGc0Ur+AxWUO8qBBh6aXh72LwEbSuvw5b54QQYHLYgReRVg6hNsa3rKR9HV0KDZRzryk4l+tLr7xZANBOhxdCYjavm67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cDV/bE1FRbuUuIpmfOXhLyQ0Kvp7jSwUlO4d9L9Hhw=;
 b=brdNTmmXkh8eyq4m8UMX3X1JyO3WLeF997ytcaEyi7aN8EHM3UAONq0phSMgzp9j3bu+Ek2zYczLKRqpErzQJY54ZgYaScV2fhq2XxGKRm7PorVgVvdu+VbKjCgd+7nm1ntKA3WEdoC+np9w2ireN9B8/0qmN3lMUMdymeYJXYolcEFb2N+9SFrAACKPiNz4sQ+wSW22SHfZXeZaBNhRtdqgGC52APdXwtPzoiuPRfewILcatw1/bB+R2AuXmNitoaHB9+9ZJsKd/QiYNTeZM6LCJLnv2Jk3lLaCo7JG0Uc/D+EDrMakoEiH7uCKUGSJa3YLLs0oS1yzt8+zbh2Lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cDV/bE1FRbuUuIpmfOXhLyQ0Kvp7jSwUlO4d9L9Hhw=;
 b=gQjlj+aOHtPUVd5QfFIFLyfomcdK0zJ7Ohci3oYN7AsfI2nI38SDIIcV0m4bhQcBaafViOrNgA23P54nkejc9RCx3pgyLewEAaowm0LpdCBmKulY/kowkI9uHD+cNlqJgOZJUhjPVuFagZHeTgx/MTAFTZepGiFrnx9WmI1WWeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB8207.eurprd04.prod.outlook.com (2603:10a6:102:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 21:28:27 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:28:27 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
        paul.olaru@nxp.com
Subject: [PATCH v2 0/2] SOF: Add compress support implementation
Date:   Tue, 18 Jan 2022 23:27:30 +0200
Message-Id: <20220118212732.281657-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR03CA0063.eurprd03.prod.outlook.com
 (2603:10a6:207:5::21) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb0d8b2b-6635-4acb-1307-08d9dac97738
X-MS-TrafficTypeDiagnostic: PAXPR04MB8207:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB82077830F0656768A6DE86D9B8589@PAXPR04MB8207.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJFlP5LgiJ0SYKq3zRw4eYkfDy61tilIrThewHMDTM9uduZuQuv9g+NlEMxOUPjZ0i54q11+R7oMvTEDyYe8mubZMkiKD4jSgt1+nZ8OBEVa6JIjk3rQCtQ+Xh+U/9nMrKB1sYz5fNsmVmn7sHTnXBUH9G307sRoqd6APQ6V2Ds+A212CrWXRc9dgo5swWI/kGyE+ENDIstrTPXmz1PTZa7eVht/F1ROeFfv32SrmHK9UPcA7QoGjAkM5HAftYeDV5SRF5EvbxJdcG4E1SfRBSWfwlZQ5Dre+r5IEuUE/FKT0D1n6QYtA5nafN4Yf13gmlLCf0HybZ6d2gfc5cPXRmAevlH4OD/6ip61nEyV6f0pO6fWf7zQTtgOoIS2s//BW2j8t/u+WXZ03KNLibuc2bqKhTkoVjnb9k6H8gT00oK/A1q0l4q5aSvMr99sguCazrDTr1+no1b/f6k2jEOm5xljB0QSWSgK5knyY4IR2erx+zCFAbMY5yL42cUhjYRl9s/7iGmvFDaJkTYG0VEgFC+zt6vhKMUB665MArdy2QKUszwB3Fp4aoGjdLoKy4w694SlvJjlM9h/UZipcZLUg3pzap0gU2yrjIizlbxAuz1Rr1I2i6nXbssjwSrKGRJy53lbwHc2mtUP+9KCg0SAzZu0QpswXwFWgT/YQK9tbNZTPC/Vl9nfJUK33nn8gpA3H8dwGaYj5M7spqCj5e8zcNJxZDMvwWN8q6Y7EWhVzwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(52116002)(38100700002)(5660300002)(86362001)(8936002)(508600001)(6506007)(66946007)(1076003)(2616005)(6512007)(66476007)(316002)(6486002)(186003)(44832011)(66556008)(2906002)(4326008)(83380400001)(8676002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkdMNUgrWmI4eEN1TU9SWjVVRzNWb3ZmckZJVHFXOVNGNWhEZ3pDMTZSTnVm?=
 =?utf-8?B?WStidWVZVjBwdktSbHMrL0JHNVZVV3pkZEp3TVc5cHJCTzA2NVBPRnJVbXZn?=
 =?utf-8?B?dWNzMTdkVGxrRE1rL3Z1cTJLNzlOL3Bmb2d1Y0lEVk9CSC9QajczR2RFMWs5?=
 =?utf-8?B?NGxoVG1wWi9za1dBazJEUFJXQWdLUWhiOXJHVUNDZ2lDSVY1dm1OdnpCMkh1?=
 =?utf-8?B?MVBaR2FJVlgvQ0JSNDFHWGxWVGhHK2ZuSjZER29BRGxpajhLR0ZKNThVaHRj?=
 =?utf-8?B?TTZtWk1YNmhXSUFTalFEaS9rNjVZZ2ljWDgrQWx3Zlp6MCtIRTNmblBtNHhV?=
 =?utf-8?B?amFReWpPcUVjbm4xK2RDY0lQdmhyamRzNUlhY2g5OGxDZUZoSHRUbXc4QkUx?=
 =?utf-8?B?ektuME95MXFQS1kwUy9NODN6OEl1OHk0V2VDWi8zUDkxWWJ4Nm9xMEhyNmxz?=
 =?utf-8?B?VXRPdTdVZWxGelZxTGk3NXR0Y2IxMGVITHVPMG5nWXlQa1pCTWx6NFA1SkV4?=
 =?utf-8?B?TWhjQXkyM0l3UXVYdkpPWER1bHRWWHB1YVJCN2g4UE0vcWlvT2g4VXdyTy9l?=
 =?utf-8?B?eGpwdyt4SjBSdzdxeUVRR0ErczZ3Wlh5Q2VzbnJaRGpOWk55RmFrcWVWMEZj?=
 =?utf-8?B?Y04ySHNXZUZOZ2s0NXFNL1dVSTNMRXVBYk1laVY4aHFlVE8velN6NkFpN2NM?=
 =?utf-8?B?b1Z5Y3JTN213ZUpxUm1vd0I1NGs4V0loNk0zVHljSEJWRHhYTW9MWDlIN3dM?=
 =?utf-8?B?UEpIL1l5cWxRWk1tTUN6TUpENmR2NlkyS1hlL21UNnRGYXhva2d3L2tzSkEv?=
 =?utf-8?B?dm1Eb2xjT0xUb2FEVGt3VTRIaEhhM2ZLTHJJeHFuSWtuMVR6cVBFdnFkSnFE?=
 =?utf-8?B?Q1hwaGxidTN0R0tTRzJ5dUsyWk5KR08yVUdBeDI5TmVOUFl0Y2tjQ0pGbjZU?=
 =?utf-8?B?SmIzdXZuQTM0V2ljU24yY284QXJmVUNnNEVmOUM1TUhjTUlGeHczSUsvS3Bh?=
 =?utf-8?B?ZFdvWU53NFV3ZUcva0FwdnJiM3ZtU0RqWWI0S0VhNmlzT3NQeHI5eDNZR0Ev?=
 =?utf-8?B?S00zT3JCVkpqTkFscjVCVkFPL1NzTVVxMEZpOEU1dE1ISzlkbUFVUFFhcEU0?=
 =?utf-8?B?VGUxeHQzWE1qUEVRYTF4bEw1TjRJRGpra0g2aHY1dGNNejBERWhWcjNHaDBu?=
 =?utf-8?B?bjVzcVp6Z3RIWjg1bmozeUE4bFMwcVZUS0NtdDdNNUQ1alJvbm9Wd3E2V0J4?=
 =?utf-8?B?aytvZGVOd0wvTjZkMWRNQVlkQlNMU1BPcGsyYnEzb05BUnI4SFdzSXhXaURB?=
 =?utf-8?B?c0k5dU1vREdZUDVRd1hhVHhINmNQamlPcC9GeUc1V1l4Y2dYdU12R2w2TEZa?=
 =?utf-8?B?Zms2QXNNdkxmYlY5WGN1VHgvNVhlcnRrZzd6WFNZMXFlbS80endGUkhOKy9I?=
 =?utf-8?B?ems4dzdGQmlUYmdkMXdISUsvUkVWaThKbVRxWU41NGtGMVF1bytnM1ZqUnc4?=
 =?utf-8?B?emE2U1l2UFVCekZPU2ZYSm9YZHdxcVZSTThuNG16WDlUd0s4Tm8yVlNVUkpu?=
 =?utf-8?B?OWRtbVloUVNRVURva243YjZLZE9LVmozcHRHRys0QldMUk5EMXN2UlFGM25U?=
 =?utf-8?B?aXlyNGxjcnRhVW5XVFpJVUxxd0E0dFRsaGNFZlBmcEJvU21uVlVrM3VEQlJw?=
 =?utf-8?B?cVFVWW9RaVhHUmg1M0J6MGx0K3IrWmZvd1ArdkVTNms3YjR4YjdSRW1nS2lx?=
 =?utf-8?B?MS9pYVEvaSt0UmNjU0xEbTVFQXdkZ2ZETjdrcnlGK0l6bWgrdWhWWmpHVWhu?=
 =?utf-8?B?bmlvdzdnelVacEtiZ1ZqS2lXNDhPNUN3OXRGOGdmbUV4ZGJSbXJmT2c5aDlH?=
 =?utf-8?B?enVHTWVVZVNnbTAvSncvTHFjNWRrQUhVeEdrRHAxNTF0SnQ4TUtRT1ZlRlEr?=
 =?utf-8?B?ZzVkc3JoWlFHdVZKeUdnNm15RlNobmhONkQwbktmemNzZm5kbFRUR0pWb2Fl?=
 =?utf-8?B?Um5XdDhUeURsRFpiRlJHNWptUm43dW1iM1dxWWVESDlKKzdDWkdDc2xVTGdM?=
 =?utf-8?B?T0RiczVSY24vZEo3NHJ4YzNOY2Z6Ukdrb2F1Q040ZGJJZ2luVTN5a3B2NjBt?=
 =?utf-8?B?V0psRVJnYkh4SlVhVng0VnR4aXVWTjR3S1pFNDdzbGU5M2lIR2w1SzMvN0lk?=
 =?utf-8?B?WFBmLzNHVkhrZ1JYdkUxVkxMbzFIU0wxRm1Sb2N2MkViNWxkbVB3OGVtcEdX?=
 =?utf-8?Q?DbTjUYm9HrAhuYeu+gEQRDcEOJQshbQRm9AmdiTyCA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0d8b2b-6635-4acb-1307-08d9dac97738
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:28:27.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTZTAd2SyGUij5/Tc/FbQVsh3sInwD9mMBcdcUOB4jjYfV9LZxEwxiiO7ZNJx61h0L9hmPkFKuxyM/ToEmk3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series adds compress operations support. This is tested with
SOF (codec_adapter component enabled) and i.MX8/8X/8M boards.

Changes since v1:
(https://lore.kernel.org/lkml/20220113161341.371345-1-daniel.baluta@oss.nxp.com/T/)

- Addressed review from Cezary and Pierre
- fixed layout of declaration blocks to be more consistent
- avoid using rtd and runtime simultaneously inside a function (always
  used rtd and crtd)
- check return code for create_page_table
- completely remove sof_compr_stream and use snd_compr_tstmap instead to
  keep compress stream related info.·
- add get_caps and get_codec_caps implementations (in patch 2) 

Daniel Baluta (1):
  ASoC: SOF: compr: Add compress ops implementation

Paul Olaru (1):
  ASoC: SOF: compress: Implement get_caps and get_codec_caps

 sound/soc/sof/compress.c | 347 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 345 insertions(+), 2 deletions(-)

-- 
2.27.0

