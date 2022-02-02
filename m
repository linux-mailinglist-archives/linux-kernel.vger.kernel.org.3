Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728384A76A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbiBBRSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:18:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29128 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232289AbiBBRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:18:49 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HFaf5012326;
        Wed, 2 Feb 2022 17:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=cPyv9vMUvAyLb5mcQu7yT8rb0hXgCvWCndW+Lr7AyCo=;
 b=n9jwFNNJ1Xosdhgdow7w1s3sY2M4AtNomy9EA5ns6jg8iBEFpif/4rB4hdzhTU2QnrXg
 83kKLuiRqXxyPtmZx/W2yhBkAdyxpKCGqOW8qC+83QCDqrRCP2lQe8AkORzqO6DO39ng
 ZSNOGFyKx2X10vfF4MuPxob++H/QqpcvgiDeWSS0xdc0/yLc1klHxBaxuQEXPvu3Az0Q
 IBTxAd7Nb68iIRTJTe3AuX9Z9tWPQOyWu2f6Z9GrvBgA9kp3ZVOnnF2nfVZtlDV8jxyO
 q+XOu72v9zRmXWw0g/KqppK/bVd7rQEmMqVUgoOW1PjufJJCldciTIcilEgZpxzxP4H7 jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wekmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212HHSVW184308;
        Wed, 2 Feb 2022 17:18:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by userp3030.oracle.com with ESMTP id 3dvtq34cy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vnucmrokd8+z5JbMDmFKxttOv0ab9d4mnW2i2oDk2FfrJibPt5MA8r4Z+8vzokSOTmgBaybZOMW7kayzVQOQ0UR67qy38Huesih/xfS/BFyYjhcz+R5EjjMvKGO7Hl/0r3LheiIrf8h65LMtzfHZ76MkfmpgFUePNgfF54aluNVYg1jG21f9Z/m8weg7QPSnCsRK7f1J2N03Hmhdmx0k4/SO6Pe7UR+tS5wf6QOsL29V31heNH0IZS16xuvZQti5VVjOjq7/v0BFVHXON06AjMw8VnbJXaJpKWkAWcHPv6JoTrTVK1bhbxWPRaprn6fnurR/y8GL11J3BDFaCwm2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPyv9vMUvAyLb5mcQu7yT8rb0hXgCvWCndW+Lr7AyCo=;
 b=dOKpxFQ7P/KoWAA9Oy7ASSRKncLXp9Jm2q5iXWDBX2dzUrGokQ+n0SVfhmkHtYmNJy0gt+jhli1SMYe3nSRAL2Rs7qk2aBjloX1OApuUlSTt5ay4stHLJec9fxTtHcTZBWykLne6Zg9TQyH+rdDzBYnrQpH03fwi0nfxMMv0Y4RRH9F/lbNeYKBRqAsJI9PKGgKpbVJy+FAulXaB1IfHqs4E6fjMLm//z+nlpeeeuXTzNl9lJtGZ7KaJxYvKsjuaJNGdKV/q1XwUd3NzJir5AXLgMj+VFg4R99S2+2U8lBHRN+IAkSLxgnr3bOhfYBmHQ27SLna+diCO3GS3XmX8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPyv9vMUvAyLb5mcQu7yT8rb0hXgCvWCndW+Lr7AyCo=;
 b=grxsCqsxuttOxoDCzbeJ2Plckyq9ep9oGm1e8gT7vSrTby2kVYAiyPITjN0F89Ptt9nvBhPyKgEDJD2Wp7VYAV+LfTgQnLZZTr5UTkVo8/bq4WLgmWkVKjTQ3Yo6QRXB/vTVzY1ylyAF/sgGMfwmx7WEpjlwK2BqgMX2J2E94tA=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:18:25 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 17:18:25 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v4 0/4] printk: reduce deadlocks during panic
Date:   Wed,  2 Feb 2022 09:18:17 -0800
Message-Id: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6923948c-08a7-4c3f-d453-08d9e6700582
X-MS-TrafficTypeDiagnostic: DM6PR10MB4236:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4236EEB412C35A3C9F0D3A97DB279@DM6PR10MB4236.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQw4uHW2YUUb+rIqzeCGQv1xrB83OhSuxGVQrFb3xpsO8zOauEUxskXhdBadan82Qn4GCbFHMkuZxW2oi6e/5T+dLlGmVR/59p7J1/Q3JRvDHTEt2tmO5nossR+qiWerdZsknWTFRT7Qq45iot03x3IhAtCKtL1zpzNLTMTW047qq95NH0NQDK12AhbUJnJRuFps3xjRb0czTetEGNPraFvDA6QljGFQEx+jHFACgkPrpOchwPHnhjlCCecQX26cz0b9SVfQyzDIcQLksLMou7m5kfxoXhXEFv498IHDJ/tEf4Dz16Sg91mrIvBK94nm8aQb2H39ng4vqc4tfrzF6HMrd6WMh442WPjmnXLurvV2TN27HWYdpTKHkV4hvLlKQ704E7CIP1dw0zm+r4z/ilRUudc5Hj6FewlZyZTjbMqLhZQDf40Iouq67QuaP6RjNvYNP+BTaynSSwzopIL4AO2/EdmtZl2/7dRcIRtZ6LRlIKHuUuuOasDhP8fEkWyglKfe0wN2BMthBduDoj2MjR91/KA03iTyy/FT2XEA9twRc2xX3aBEuH31A7L+da3GAptNtL05kT/LyBz95kJSOvmcHVbyfQVaH3iOhK8Yw8UAwQesPgE05GMIlLSM64+U4W5A5hSPNEBgox9CORFqhYzdhFeBoyooePTNg5nL/WVNVCNxhHat8pw4po/DBmdR3CxG5ZaFzbCtrWFNcMsf0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(186003)(26005)(6486002)(83380400001)(2616005)(36756003)(2906002)(103116003)(5660300002)(86362001)(54906003)(6512007)(52116002)(66946007)(66476007)(38350700002)(110136005)(38100700002)(66556008)(6506007)(508600001)(6666004)(4326008)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nKMws4f5Z116jhcudT2+fiBIKByhDr5h7EWNBh+aUc5sWD+HIfl5jk6y1VYs?=
 =?us-ascii?Q?51FBmp4xICbCH/12w/yigt67cJn7e2/amLu8BV6UTbOXNiEWUGqU55xDkh0G?=
 =?us-ascii?Q?zvwWi5dBXraQsra8hVJ40yIoOc2OAi4OIwX9yS5beLaQUc28aarau7ADCvFi?=
 =?us-ascii?Q?YuVgffZ9RRxHM4JYpdEEdLPHmDWYgtudBYCSujMswh6RZsgcuCmElueZra3d?=
 =?us-ascii?Q?rHxO/kiGz3grBWINFQh4fY2ihVXfOvO6N6zeyx1FSl9LG7lreV7GU6SmLfvL?=
 =?us-ascii?Q?rVA2hV3bAElgRLSG7BDM9Gch7Iv7INDO9i3trS8gePWgPua9kWYNh0o5lOug?=
 =?us-ascii?Q?391PbO9sTqhbtjlsH9x5aODhx9z+qkCTXPnBgO7Wk5VHObaWvWlen8n9QAKb?=
 =?us-ascii?Q?AOVWyIiDOKdFy8q49QS2GdbxpyASd/373xQ1PF65ACU+ZijYvO6hgsEuXDW+?=
 =?us-ascii?Q?C0QMcZPu6YiuHZHMFkfh30S6tN6jOIPiNaYLuBgG1APeJmNstX+2xSgm+b57?=
 =?us-ascii?Q?BibCHmOdlEVqt88mOxqZRceJRoolzywRVVsHsOJs2WHrilZb/XeyyqbwfK2h?=
 =?us-ascii?Q?ZhZso80rNg/j63tVEK7WYFnqJa6f68B3kr+swav+JmGOiUpRvd7gSOaixeOB?=
 =?us-ascii?Q?ui4FZp7JjtAHfMufC2wiOkxsGBajfFvSOydLdB5/Mpi2Qg8NqWI7o8VtysM9?=
 =?us-ascii?Q?naLLJzp88VRteM6/Tg8A8nR9g00qQiczDh/bUYblkAAZmyHnkKzAAKNL1EwE?=
 =?us-ascii?Q?M2HZpY38KGvwybkBwYjwhKU9G8a/J59zPO7BZe3ehWAVlquRMcQe93jkFi4T?=
 =?us-ascii?Q?d+lWkOu6b+rk2ZceKt/trnim5HGnhQRQDnnRzJ12O26dQL5iCQKxoksBunUA?=
 =?us-ascii?Q?rzCoahv3jY0i15Gtn6m35Gob71pyz2pHOvG0Jdksma/jua2/BEdpy9JL5oqE?=
 =?us-ascii?Q?hQcWkVW/Kiz84CFuyQhC+Ml+0bc2iqh2BFPAGXk2Gpbu3boH3JlHY3nUTPmV?=
 =?us-ascii?Q?rUFCjErmMaEZBq6u9lRtqJGa7iMGE0cWNSUlULnRYxmxCDwzsCGvt8CiYDFt?=
 =?us-ascii?Q?5Tm5ZQFOvV5ZD8MOs5UgdMLZH8K8snHRPuEBPmNK/7DndQ/yhIO+8Ti4Q1ro?=
 =?us-ascii?Q?qM9aWuiiDarNHHqxQAKjcMRXfH9f5D/met2zb7hFIx/CgItGCFffKfrQ0646?=
 =?us-ascii?Q?sWb/1qaZPyBUET4zMuNYEsnwG5vnjrD9kDTTRFnYLUqsgcQ/GrVZ/0q6ZnkN?=
 =?us-ascii?Q?/6Fx9Ch6qz37H39L/TqyQJhKKeslfL3hK89aGCFtXgsllEVvMmUy2I8sr09k?=
 =?us-ascii?Q?Yk1zD1NY9QA2S8zLEDeYUaUgTukrPodcIYlBJUyAvbe5skV2mbK3L43EiPKh?=
 =?us-ascii?Q?KsEyWcwH6CgmPEguNJhqtZHIO2UfpaPUa4TY56j/QrPYnHjB4pQiOUSwfqQY?=
 =?us-ascii?Q?HVppbL8ODhPQM0P0ww5kc43HEYmd73QD5fon2JNuoKCfHWEYcfv7vm7W4Vmh?=
 =?us-ascii?Q?07lWi6QkuLX16CJy8LVorMhjy7WIDD6Ow4ItoAefMyvq59lNvYxHz9A7R0jS?=
 =?us-ascii?Q?79gkZEENtogP4UD9t1UGZGVauA6kWG4EKmzUkLhFxjqU8X/VGroq7fB+CDbO?=
 =?us-ascii?Q?2205OS0Jsfm/7+0tAyvj+j8CiuwzeyjhAHhItIJPNWfbipoxyuYzDvg2W2ay?=
 =?us-ascii?Q?ZhGuJQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6923948c-08a7-4c3f-d453-08d9e6700582
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:18:25.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0qAbQ//8Ndkdc8V4lG4Lh/kI+hmgNddlupG5iFxlpa7TCPRl9f4n1B3dzooHTLny/O7ZJGziRT6EBJcMVv9drwdJtQa7WWiLEXJMhWy4s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020097
X-Proofpoint-ORIG-GUID: X_07Ee2ILLyEyxOzFXIRVYUa9PvFcU7m
X-Proofpoint-GUID: X_07Ee2ILLyEyxOzFXIRVYUa9PvFcU7m
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a caller writes heavily to the kernel log (e.g. writing to
/dev/kmsg in a loop) while another panics, there's currently a high
likelihood of a deadlock (see patch 2 for the full description of this
deadlock).

The principle fix is to disable the optimistic spin once panic_cpu is
set, so the panic CPU doesn't spin waiting for a halted CPU to hand over
the console_sem.

However, this exposed us to a livelock situation, where the panic CPU
holds the console_sem, and another CPU could fill up the log buffer
faster than the consoles could drain it, preventing the panic from
progressing and halting the other CPUs. To avoid this, patch 3 adds a
mechanism to suppress printk (from non-panic-CPU) during panic, if we
reach a threshold of dropped messages.

A major goal with all of these patches is to try to decrease the
likelihood that another CPU is holding the console_sem when we halt it
in panic(). This reduces the odds of needing to break locks and
potentially encountering further deadlocks with the console drivers.

To test, I use the following script, kmsg_panic.sh:

    #!/bin/bash
    date
    # 991 chars (based on log buffer size):
    chars="$(printf 'a%.0s' {1..991})"
    while :; do
        echo $chars > /dev/kmsg
    done &
    echo c > /proc/sysrq-trigger &
    date
    exit

I defined a hang as any time the system did not reboot to a login prompt
on the serial console within 60 seconds. Here are the statistics on
hangs using this script, before and after the patch.

before:  776 hangs / 1484 trials - 52.3%
after :    0 hangs /  15k trials -  0.0%

v4: Moved panic_in_progress() out of #define CONFIG_PRINTK
v3:
    Some mild style changes, none of which affect testing (which has run
    continuously and is now over 15 thousand trials without a hang!)
v2:
    Each patch has minor updates from code reviews. I've re-done testing
    and updated the above statistics. Exact changes are in each patch.


Stephen Brennan (4):
  printk: Add panic_in_progress helper
  printk: disable optimistic spin during panic
  printk: Avoid livelock with heavy printk during panic
  printk: Drop console_sem during panic

 kernel/printk/printk.c | 55 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

-- 
2.30.2

