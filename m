Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA0F5A80D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiHaPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHaPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:03:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7CD4BC1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsNXBjO9icOqNHAT9M1L8Fc+YoO49Ihw0kFEwqDQAx+ed3TKLS1sptAw4YoSpAP8457rHvIp7v5nMY3p5C+WaNydDj3W7PQgNndNMVc+9WhxfJRj4ofRE55iA6zme49Rlx+wKAt+GP4IoGMlwZaEIT1xJpjrp9oRmj5baiHEKk7O2GrNGq3Z5iEIukKwIQqhkPdq1ykZzXRk+CD+Bh2S+5fntgGR8DvUxhSGKJaiJ3pplnFaSmsd6QU7zsuc9srVRByNf32UecoBw6jn1n2qrmOg9/rfcxkVbCXxmRmqKI5rNftZ1ajp4/6U6+RyuT1M1tBlr7xcKCI7bAZGOtCBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzDNSiH+nAzQJAWhSY5QbJVBRy4D/HZ7UuuvxW11Rjo=;
 b=IwFqySC2aa46Hk0VLZ5+bbrMC+B2NGncoxOPqLh+qV3kxipBvpyPSKOZ9kr7SLsOvLkUS2xcjMTSrRUvN1/BJvnguu4yti1RsXwMTFWL2LkicS3AzjBW7i1bVLo1mCoPaH2X0mc2OQVe74f+VqNxTW+zueOU3W3vsOXhInhSnhK3wc/tRWlMJrnzqLTzG25ZndpSmclEOcdIB1sdwIlj/kwLFa7J2eiLCZw1sS0bFzFQyvlceWsTiNoyQ2YrPLWvnMlZ5FC/kT9MRtKvxJW72h3lr8DySp2Q8IG5HPn714dv3/SHURj0kySMfdbx6HcTvgr0SqlZE8d1idY9WePlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=hotmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzDNSiH+nAzQJAWhSY5QbJVBRy4D/HZ7UuuvxW11Rjo=;
 b=xvuNekIEhNMIp6tji8v4sqymajaH6yf04Wq+2x6S2XFeGkF2XIpGg2pmJl7PDhUPp/Aeh08QefiB97/BcT9kPzNBIsFc21A6FvduAfCTxBvzuOYsByqeBtWrtdNyqfzGFf5ZYl0DxRc7oZwgumDHw1/2OW//nN09irW3EKE/O33IcTnNNX4Z7gKKznqtYm1y0lngwO81e0WIs3oyzwFAI2HuMCepQkZaz92rhgVf2Je1X81aY2VfW3dfd1Mh/hG7sJVuPiITqY5cR1nRT0H4Hdn+4PFrplgpwHDrcZaLcuFDJaepa3yYFmvsWGIbhIj7FiFyNa/DUeWEEM+OIX1omg==
Received: from DB8PR09CA0015.eurprd09.prod.outlook.com (2603:10a6:10:a0::28)
 by DU0PR10MB5534.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 15:03:24 +0000
Received: from DB5EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::6b) by DB8PR09CA0015.outlook.office365.com
 (2603:10a6:10:a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 15:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT025.mail.protection.outlook.com (10.152.4.240) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 15:03:24 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 17:03:23 +0200
Received: from [139.23.74.152] (139.23.74.152) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 31 Aug 2022 17:03:23 +0200
Message-ID: <6baa55b4-b9d3-d28a-a2df-78e8b2200b00@siemens.com>
Date:   Wed, 31 Aug 2022 17:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] scripts/gdb: fix lx-timerlist for
 HRTIMER_MAX_CLOCK_BASES printing
Content-Language: en-US
To:     <pngliu@hotmail.com>, <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>,
        "Stephen Boyd" <swboyd@chromium.org>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17639886A7064A1E610FB2E3C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYYP286MB17639886A7064A1E610FB2E3C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.74.152]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.474800-8.000000
X-TMASE-MatchedRID: EhMq+2gclHvrOhfRe676Rzi1Yo44kiaCRDARXWeDxU72b09s2KGDsLd2
        noO4P7rAwvc+tCu+M4yzu34v/cyxLNXLUbWM7gjibOo++6sx6CSluxoAAQHm8j8Ckw9b/GFeTJD
        l9FKHbrmpTkI0HK8zpYhwHj/iDNtwbSL9AN4UjlvH2GckBymgCnNuQ/vAkS6eXmFVlObh0PwMq8
        t1qGggRJsoi2XrUn/JyeMtMD9QOgAGJ4JQFnQmG7ew1twePJJBkXO9a7gpKsT6C0ePs7A07R/88
        i/oAaoswkoC814nTNCx0Ocev7131bO7ttY60eZT0lJJ0TWC7dA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.474800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 939CF33F2A1DEF023003496C79063334A5F46E87A4214BF0CB6D418F40FBED832000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76399693-2f39-45d9-2d60-08da8b61f3df
X-MS-TrafficTypeDiagnostic: DU0PR10MB5534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgdBJfqU8YLDQ9cgzNiptomhYuTBkIiAiphkkk/PCmXhJHK5w1uCt0bPHQRcEFIsDcY4rl0cw4/FsRBlnNwODaT+RmTEaT5Kh2RO7gD+dv7teA2X0NQhN63Nb+hJ/9ROBiJOmHntjoipaR/6kQhkaNzf4bpMaeQH4FKltEZIZ6bZHm9WhK5BEnCbDT+98Nt911y22j3t1RTEnI4TdjWmqR1t9868EHHSEwMNcJr+uFjia5Orj0H0EH5by20lL+firMNYueVvMK6OzYJnn973LVwFkI7+Sk12p9+eN62/wOjpd3mSmr57mzcay3RxTVgsTayHmSW9EG6y4uBg8x4y2ztW95V1IJgRM/y10h88Oi4tBlnaZRLecb7IXAscisGNl9BN0irif/TGW77w+0Xi/Mck3p15Jn8t9rncwvPyTeFfpMT7x2GDFtF385YWiZCkmIvultw17wmVdbNdUk4iT0qLkh282boEalVMip0DourGWMblv8/sG6kW0X0VADZVEB30PT0Y2id3Gq2li8Vd+6ZiDx13y7ilqRzUphmK/Q+R+Vf4PIGNqIEFuLWXTYx6haefIp/HiCzBsFtR44K6oPQVeGP+cVEI532kIZfZBt+KqWyHh2Gl/E5AS3fVWYPG6OO/dVjBZie0v5+7shK2s2lZ2mmobyu7DbfBKzh1f2qzoiNAqfn6svoogqn7/Gn/6psALUA2IssrdBXX9c34nx/UjtKDs+UnPiCO3JLE2Wrrm1pCBL2H+ZdNqVgjHjUpFp5RhWUiALQj88vyw8m3Wxk7poqnO+GGFCoC2Bys7akpXBaoJnfTvukqzgho11U0g5dCUT6FXyHD+Tyc7zvuWj6RoBFew4W68OFb+NBTJ8u0eAncDbFV1F0mZmvXbxNW
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(40470700004)(40460700003)(36860700001)(32650700002)(110136005)(40480700001)(31696002)(356005)(82740400003)(82960400001)(86362001)(41300700001)(4326008)(81166007)(70206006)(70586007)(8676002)(82310400005)(54906003)(478600001)(8936002)(5660300002)(45080400002)(16576012)(2616005)(186003)(316002)(6706004)(336012)(956004)(16526019)(2906002)(53546011)(83380400001)(44832011)(26005)(36756003)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 15:03:24.5186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76399693-2f39-45d9-2d60-08da8b61f3df
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5534
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.22 14:27, pngliu@hotmail.com wrote:
> From: Peng Liu <liupeng17@lenovo.com>
> 
> HRTIMER_MAX_CLOCK_BASES is of enum type hrtimer_base_type. To print
> it as an integer, HRTIMER_MAX_CLOCK_BASES should be converted first.
> 
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
>  scripts/gdb/linux/timerlist.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 8281da068c5b..249f0e804b24 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -188,7 +188,8 @@ class LxTimerList(gdb.Command):
>          max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
>  
>          text = "Timer List Version: gdb scripts\n"
> -        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
> +        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(
> +            max_clock_bases.type.fields()[max_clock_bases].enumval)
>          text += "now at {} nsecs\n".format(ktime_get())
>  
>          for cpu in cpus.each_online_cpu():

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
