Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5477D5A80CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiHaPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiHaPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:01:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA6E7CB5D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy84KqKVrIfp8YApuIdrxkkQYPoZEZ9SOchUfQyqSal/svCsAD9gn28AhPWRW2JvQnXwHVWnzEf1j5W0vUkJpfv23kjY5vC7OSHEzU3sEOjtwhOSclhBLSEEmMsLolI6y+dFLGeXiuHVy4kw9vAFotl1HolwmV5SlErCYt7/JqRMh3hj3alS0gmiynjQjV9hzs9ZqNzlNW1ts9F3QXa8+WhZmlNMDvP0g8ZcI0rRXM/yH/G3Z+1Botv/m+H7z7WrlbnIDYUgbbK0a6u71sRedhR2ncDL2Aio/8KGykIbAU+2pY1BHOYun5LmhRr2adxnUR9wLOjUytS89mNZN6UPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol66bpqN3hHQgpRk6AkeI65UdBMTinCmZyU78lodpF0=;
 b=lJ723WYbFBRPbZYwWBqRk7gvl5J3VnbPw9NIW2Eg3Gwwx7H1N2jLQOlpPiaSmHSPrwsXk29Uu76oz/GhXJSrntWsUazhm5Ygx7ePdInG+3QOmj2OdFBqrTKY6wVWcrFUOwCf+33HY4OgEMxNC3SvpXSp6ZdPnEbBZTznmRKnXTIhNRpJ0EyRE7VfIZ4QJ7+bUGMNdPrz729dVk97RbCxzx4DMn712gVl8Nksgwwo7hrm9wqrO+P6SjO2ayF1pJQf1wmxM17xY8Hxc7KAN+v9HmbmFM6aED/Te6FA0SNYHReBYzQ6fZ/t79a1mqx5zi+EsJFUY8WHjT4ABPQaIrf6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=hotmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol66bpqN3hHQgpRk6AkeI65UdBMTinCmZyU78lodpF0=;
 b=Ywqbcp25656DssFow/pz/2lAC+7TGnN+79o2UDrVbzHb6arh6gkAMAYKJxgcrGoC9IXsdrFoGi1vzwFIZQKp9uAqVbvxlscUS74llq0s1ZqueMpdeW5rZi4Uv941H7MWX+Twy1GVpkTDQJapulRaK4eeEA8QiLZ2AKfXuuvHMwY7zIwVYsiUaS71uY1k4pALtnYSNMpECvT8K6Vwr2PVC7UIElb3RXGQgOP2heSk69/zxf4vf1bCDCqV/Bg384l4GvKEp9VJ99FGsIoi5eqDMdVU9YPQmN28mmhHsbxMpiBPQhBmIG0ydsUK+9yIokAtVMRP4TbySAuvWkKMUPNqdw==
Received: from DB8PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:10:110::26)
 by VI1PR10MB3181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 15:01:06 +0000
Received: from DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::ad) by DB8PR04CA0016.outlook.office365.com
 (2603:10a6:10:110::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 15:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT074.mail.protection.outlook.com (10.152.5.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 15:01:06 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 17:01:05 +0200
Received: from [139.23.74.152] (139.23.74.152) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 31 Aug 2022 17:01:05 +0200
Message-ID: <07c91a50-bfb0-acc2-f4aa-cb7bf53a3b50@siemens.com>
Date:   Wed, 31 Aug 2022 17:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] scripts/gdb: fix lx-timerlist for Python3
Content-Language: en-US
To:     <pngliu@hotmail.com>, <kbingham@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.74.152]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.687900-8.000000
X-TMASE-MatchedRID: 8xNMUprDHafrOhfRe676R7VjWRIm2MckPWKLA6/g//vx5KZMlKYS/bDm
        wsUzv3A770ULJJwFphoVLffrGn1K/V8/DkpeHmA+vDcKSRapMI5gZ/8TKD+q1/bta0OAYFzyP6T
        ki+9nU38HZBaLwEXlKCzybVqWyY2N5zec49pgZFSkWONs32v2gQTsy5Ctk/aj6GyDR2ZB+cag88
        67bIwmU5QBR+Vr4iFospdaYS9obcQLG8CBpMcXL5GTpe1iiCJq71zr0FZRMbBuHY1mnovlhIcSB
        +DBj8cnDNU3SXYhSV4gBwKKRHe+r+ul/3jhrDaD5wr6nDOytsulc3E0F8YlzVgIWCAbPyCKGWPI
        iDg4seg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.687900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 17F773D209467820942E7CDC16E7FA186EC1D39463F42FE74B9D40F594EC896F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7d27e69-0747-4537-7a9b-08da8b61a19e
X-MS-TrafficTypeDiagnostic: VI1PR10MB3181:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRmga/5gt9VnQjOBegR37/XQTcGrm6vvjSOWTkakeVfKlKy1fma5PPC+1l1CTvZKFUlgJjveOuEw+6AVCD9fnT/4PbEeRFaFcgEcA1C2VBr1FFE7+QBucp69mz01+EL7AyoswN4h9JZVb+dOGH4n847q6bdhURa3f4ORrNok3j5A8yTt5k46HD3BZ0Pke14kfHmS2LyuX30paP7PbFTfC9XIzl5C48YhvRSz3uhGHtbfMyMxw9zBnGcSL596R79D/E+EOy+lEvHjFKcUwLRTiMyh7WrC99AfNnuqhiK0XLwdEPclhziasItPOUjUdENqNmbEVr8NNl7N25/4xd2F1qfz4ZHrhHcTYZUvz1HNfIFxv3i2UcK7SqFxrVcJHhS+ckgJEl0vO1Jh2yqqoBFLvozS/jwMWzMGMhNqgC5EvSENtEiKvQchkSV2a1e8g7jBooofOahYavW4iAyj39J/1RurFp+LMzX/s//KMLxrSofCKDf2QoCEDtOa4llL67qK2O1cPc32N/crUrcTNIlyCZoyf/wwRht/3SAp3zYbYHZE76qN6yhY/TESicUg7Qyw9s57F7Rz96O4QmE7jcQ8oQikc6z3LvralV3su47q82uRnDERRd+6ET+3IpLd1Q8icMEwi6hGoBtjoqHSRi/E3KABDpV6DOFWVjMTb3SzF73hQ+/AX8blDchbJO5XoCLzC2sl+rOTSbWDT4kJFAJGZTb34sKxmtDVSzl2eNOjA8BRIoVoaGX1OUqEVghRgb7v1pTP4B0a3ZeTog3SAXIAr+/QnMzHYNiiODP8MM4Ik62vo/U0Uu+w/ZKS7G31PeBKemqO04bckFv1w7vJDr894HN8mUDp/Lq+9PXJwPtXFYsZpAlt7E+RshSTwUWe9wQK
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(40470700004)(54906003)(110136005)(6706004)(2906002)(44832011)(356005)(40460700003)(26005)(16576012)(31686004)(36860700001)(36756003)(82310400005)(45080400002)(316002)(478600001)(70586007)(70206006)(8936002)(81166007)(40480700001)(41300700001)(5660300002)(82740400003)(53546011)(336012)(31696002)(86362001)(16526019)(82960400001)(32650700002)(2616005)(8676002)(4326008)(186003)(83380400001)(956004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 15:01:06.5171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d27e69-0747-4537-7a9b-08da8b61a19e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3181
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
> Below incompatibilities between Python2 and Python3 made lx-timerlist
> fail to run under Python3.
> 
> o xrange() is replaced by range() in Python3
> o bytes and str are different types in Python3
> o the return value of Inferior.read_memory() is memoryview object in
>   Python3

Means this only ever worked with Python2? And we now hard-switch it to
Python3? Not voting against this, just confused if it was like this so far.

Jan

> 
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> ---
>  scripts/gdb/linux/timerlist.py | 4 +++-
>  scripts/gdb/linux/utils.py     | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 44e39dc3eb64..8281da068c5b 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -72,7 +72,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
>      ts = cpus.per_cpu(tick_sched_ptr, cpu)
>  
>      text = "cpu: {}\n".format(cpu)
> -    for i in xrange(max_clock_bases):
> +    for i in range(max_clock_bases):
>          text += " clock {}:\n".format(i)
>          text += print_base(cpu_base['clock_base'][i])
>  
> @@ -157,6 +157,8 @@ def pr_cpumask(mask):
>      num_bytes = (nr_cpu_ids + 7) / 8
>      buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
>      buf = binascii.b2a_hex(buf)
> +    if type(buf) is not str:
> +        buf=buf.decode()
>  
>      chunks = []
>      i = num_bytes
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index ff7c1799d588..db59f986c7fd 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -89,7 +89,10 @@ def get_target_endianness():
>  
>  
>  def read_memoryview(inf, start, length):
> -    return memoryview(inf.read_memory(start, length))
> +    m = inf.read_memory(start, length)
> +    if type(m) is memoryview:
> +        return m
> +    return memoryview(m)
>  
>  
>  def read_u16(buffer, offset):

-- 
Siemens AG, Technology
Competence Center Embedded Linux
