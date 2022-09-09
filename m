Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBC5B2CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIIDQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIIDQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:16:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2087.outbound.protection.outlook.com [40.92.18.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBF76765;
        Thu,  8 Sep 2022 20:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHUHokLv9xKOqOomgSBpzshKnuOhTyS4gDPgznry/KxH4tkVZYZ+g8pcBHJoluAmxYIYMLDz/2Gs031VwSbY1XiDvsJW+8dm4WO1F/ofStydIe7H51PELGx9ljNfZRvn68KEtPLEGfURH47TG2034Gl+kjfktAY8flJYl8gvIdctThHGshbc4BoR9CCCbvZpWrLZVHunm8FJq9zMyj+xGjWSfcFpKhUylJcZfYzOuM9fEL8gZ7ht4oQzF/ZoQFOVjmx2fLdX1q/fb9OZxpGoeF4U/AEkEpVIALvCftHFjdsnyErDuN9nM4vrP3eipE7UT82PYmi6gwy0o0Iy5AfOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL4sHSm/W05X/Avt/kTOc9FewpxBHCTJ3Sq1t+LYul0=;
 b=jrc++ytDcm+pE4/rGLXUKikTELWBmhQ3QLlHPrnfQx+S6GM+6/StUla1GDEsIVNkWB2JL71JUuZugD/cC4ib0lhUfwZgK0sEGILjiHi3VBRicUyx0F4fbiH1YBWp4JJqa+jPDJgFeP2tc9IUwdmruV+iOSa7fQfYgA5hW19zKRmwCBkT65YQrV2nuNM2LgqMzavPdI7jWen8XBnVRw22QDzHjUjdKtChJtqTr6LkVZI8RjCFX23sm5pKrOiW0g9UdZ0mMUbHqfFrQIQcCzwJdVJQ3B+qUQomsasCQ0Cd20FX8Hw2CzSRxwoRZ0fGAqsE5BmpRYcDbQN7b2PBs7vtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL4sHSm/W05X/Avt/kTOc9FewpxBHCTJ3Sq1t+LYul0=;
 b=fJ2LbOWv1azSCFS5QT5MCe8xR5EXW/jC2wZn3/MoQ3GwqYfz0te+jeluLmpK+LcQdz7MXZviZf5Fps+fJNrQVk5abrE/TULgR/o9pnVWMrJzzCxPdthV6ci9XKhaPQG/XDfnykoJZgW03VHH3vOrqqeu1viBXzYalLpuU5EAFEyBPsmxwef1JzVzZRykzhHxzcc6bhjanIPOX79TQC6nkb7eGZTdKdotBNHbe+X3F9De0fvgrxY98IdsPvYpKwaARfoYv90loZYVTQ1M7s7alMv7dajIUVnnwnBFgEjq1XsPQL8JhSVz48yPRPxytTTqqFC+uqw9Pv3gAAgY8sPfwg==
Received: from SJ0PR20MB4337.namprd20.prod.outlook.com (2603:10b6:a03:427::7)
 by BLAPR20MB3891.namprd20.prod.outlook.com (2603:10b6:208:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 03:16:18 +0000
Received: from SJ0PR20MB4337.namprd20.prod.outlook.com
 ([fe80::89f6:e10e:9818:dec2]) by SJ0PR20MB4337.namprd20.prod.outlook.com
 ([fe80::89f6:e10e:9818:dec2%4]) with mapi id 15.20.5588.012; Fri, 9 Sep 2022
 03:16:18 +0000
From:   Whye <whye314@outlook.com>
To:     alexs@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Whye <whye314@outlook.com>
Subject: [PATCH] docs: zh_CN: fix several inapproriate terms
Date:   Thu,  8 Sep 2022 20:14:41 -0700
Message-ID: <SJ0PR20MB433769C4E2C73207CC9B1F15E9439@SJ0PR20MB4337.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [7iDfGQmIbdCx7JhgX6hSHVE02SAxogkC]
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 SJ0PR20MB4337.namprd20.prod.outlook.com (2603:10b6:a03:427::7)
X-Microsoft-Original-Message-ID: <20220909031441.10279-1-whye314@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcb8e846-c4c8-48f5-35b1-08da9211a838
X-MS-Exchange-SLBlob-MailProps: Vs63Iqe4sQmUGc2aw5Rr59ZipGL5DAU/gnrmf+wl+O+gtRqrZuG2HF0chRv28k3ge1uqcuZoccpRMmiFHc+tadjXwa6FbeG8oSVA583uKKqdD8nPYQuNFAmpYadXifDk1M4A4LUHvvO23N0i8l/4fskCmR7RGHonEQcPAAq+0RDSTzQfVcWRM28A2pvJS4VFkqnO8lUaxDB8saxX/v/eIsqefKWQS8iFWeykytaokDi0g0HFR4L3hh57sGn0nvj+yrM3Abp7eF55SueoY+usHh+e40PVgIykkCgHne7rHoE7DKRy3pDmYNc0zNqhldMELcGr+e9lutPcHdM43TCOMNPWdpPC7GURrsgChexgRgG6hFpZw6nzrLf7n2fs7iN0jbhfw9UnBARsA55mb8NdnbI8nyGRWgwibXFRLf5Zrtoqz9LSs8rH7mID6peTFL7isIKKbyU0v8zUn3YfPm0CdrErXhawQ9vK1ppDFxLX2+Ah/Ka5+iEWfccKFPpJLuo+7I3l9FnDEg/LZBTQhK84vLjBHDuCdf4XH4r16ataQrqOybdq80KkT0Fqh9g5mIb/ciTK6LiRuQrTokLh4xkvfkwFgfh84F1IVC9vpNU6bTuBheFD3NIigwkpWSWyfKVEjg4mdZHXrgs6aI5tsziVsufx8GYvtWH0DvhNUlajH/i8zCkYBpWV52NOSBom3GLICGZ7m7plNIIwvN70JuV7CTgZnWnmet7M7F+9dJVciis=
X-MS-TrafficTypeDiagnostic: BLAPR20MB3891:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRDho/mzoU2Q5VOUYkB/10q4BGqRjp5HXn0mG7ZhfJbFoebrJo6qV1aS0vzaPgePTpEd2ThTFN/ieyntZZBF9oNYxE9eEY8CiDwMSd0ZOOxsOyIcMpXSPefvIdINCwYpB0NTk9cxLll7Zd6tdVSXQ10KgmqrYlRC8u5WYaxfO31rmQWS8gmwyWIlltXcwC4oe/nGGPoChtiZBk3IqvtJVnfG75PMEfRIVVf6lCDsTAIqa2bBzKHMTbXoMZlQ8aK2+DmzYnrlckgCqgIenQW/T79XlF7RWVrwNtUXrMiF8lJmytoqYi7SYjQr1m2XZosAHwXJpGrqvm3eF0ZttdQ/R2MbQ8iy/864S5JGnJX57ilULaoP2Qb/jscvLI+MsjzCncKrXw5kZQ1aaxxgHOZHCogk6BOyfCIiRz1HEmzlZZ8TwsDS9ohCAKVO3BhxOHgUQQSBtG/9oLe9OYfHnhu+prRtaMznoQ1HRvbJDCphjCu8TakP6ICZYZDUsP+bPRUE/kmVyB1T7QriisnHlbGD27E49QtoYvjPSI113SNssxZyibIeRCc8EFSFwWjSithUZBHxlBVFEl5ctrXJgdYbf4GkDRbAIS3DHyUZuE43AVVSIItNg13frAVvGp7dg1J/FC6a72NNbSN+H6MSmMH7QA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3M1anR0M2lOUXloclhUVk1NYXRmQ2pmWUZuRlpkYmpQSmVXT2Y0S1NPYTRz?=
 =?utf-8?B?THVhMkpCclVTSmRBdDR4OGxwSjhXYUorNGt6Ymx5REw0N1RRaVZuWGNNU0RK?=
 =?utf-8?B?UjIyOWhjVHhVODJHYUF4TzhQc2QvMTZGQ2NJVkpGTVcyZUVBbUNmUGM3RUNn?=
 =?utf-8?B?MGlyRmZEeDlDbnBXK2lvMy91aXNLVldJckowNmRzNlltRGl5UFNQdmlFNWZP?=
 =?utf-8?B?Wjh2amhSUzJzdmZCUVBWeWR4cDNzY09SUzhjcTEvZW5CNTJuaUJERlY1bkZP?=
 =?utf-8?B?TXNzYU9VcFRPVk9pRFpuUHllZ2tTMTZBTVVObmN5ZEFkbUwrMGl4WUtXMkR5?=
 =?utf-8?B?M0dlRDNENVhhQW9mT2V0UGdLU2tNc08rZHMxSmpkcFNzRU9lYWNNT2FoMVpO?=
 =?utf-8?B?V242c2thUGhSYm14czFKTDNjdTdvYmdMUm5BajZwMGxsK1lsZnpaOTFRMm9V?=
 =?utf-8?B?V0QxcnB3NkJYYjlzVmY5aHZaUU9EMFUwTVpFSGFGNFZrdFpENUZVWDcydytp?=
 =?utf-8?B?eVZKK0ZITS9OL0pRcmJqUCtod0JkMEdrMXBpWnBTZG8xVUJzZmxMTnZUeG1z?=
 =?utf-8?B?N0VmbFYxZjJ2WW1GSnR4NnppL1hmM1JNSWhVdWo5YlhXL0xPdlFneU1GdUZO?=
 =?utf-8?B?TWVabFE5YW5zaloyQU95T1FFRlB6YjZodjlVRVFIRUhuenY3R2JLMUtXTHNx?=
 =?utf-8?B?b2dRSzNvOFd0RFBzR2ZvdXl4bEgwbEpaSDQwc1BjMUJuMUQzUjJmNmQ0VCtt?=
 =?utf-8?B?SUFGbFMxUW8yMUlacllhTWdLK2c4c0tBZkxYejB5SWIvSm5QaEtIOFVicExt?=
 =?utf-8?B?N1MraFB0cGtaZmtxcStxajVSWmlxY2dFL0RzcGc2SytUMGxiMlJTRWdIVjZ2?=
 =?utf-8?B?Szcwa2RwdXhwZG9lUzg4dzZtQVFTdnYyeEd3c2Q2dE1EUnZnYm53Q0NEZC96?=
 =?utf-8?B?WnZlbmNvV1RtYTdUdFd1V2RFcWlDaE4xd1JuRkdlVzFSUXJCdThDQjRJUTZn?=
 =?utf-8?B?WE4vRjduRDFaOEJsVU5QM0RzTmVaUG1HemkrWktWL1AxOHU3UlJVWWpqVzMy?=
 =?utf-8?B?R0pxYXZhVzFrN2tmNk1LdnhSaXRIbFRvL09qellmMjhPUkpuOXdTcUVLTWxo?=
 =?utf-8?B?UTlvYzhZMDhSYTZtT2NWM0QzUWNleTVOdXlqcXhWVmQ4Znh5Ull2ME04dlpi?=
 =?utf-8?B?TldDUE4zeFdxK3NGenk5bDhhZkErS1R3UlJGUjJlcmx5QkdNUFkzdVNVVS9B?=
 =?utf-8?B?aTFXRlBYWHFrc0Y2SjZrWFNGRjZ0RzM2Q1ZSV3VWMGhEaGdydkk1RWJhR05X?=
 =?utf-8?B?c0ZOWnlFWU04R3IvelRraE9WdEhvZzlaaG4yaE1RN2dWRGhWcU5TbmtkWHdo?=
 =?utf-8?B?M0paOUowdUh4Q3NkLzFPbzVFdzJFR21BTkRFcEQ4eGRTTUM4V2htcXl0NjM3?=
 =?utf-8?B?eDlzZmh1TDdnZlJ2R2tGWUFyOVdmZVhCc0RMSWxTdDhLNDU5OExFTlRaZXBO?=
 =?utf-8?B?Ty8wVW90UmFNbzh1VSsyT3FpZDg4Z3AxeUpRTUFPanpSNUplNmkyU0piUnZU?=
 =?utf-8?B?RENRVWN6S1ZlVFNqQnFXdHMxSzRlUWxEdlRpTU8veDVvdy9ZMTNRamVnWVQz?=
 =?utf-8?B?cFJpZlBVbXYrdWdSRVpkSUd2VjI5bWRkSkJWcTJXSmd3OUlhRXFQc0xvR0Q1?=
 =?utf-8?B?U3hHZER5d0hGYTJ0eVdvb3FqZm0vd1UzUHNTRnBpQ0FFalp6cXh6VWdRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb8e846-c4c8-48f5-35b1-08da9211a838
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB4337.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 03:16:18.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR20MB3891
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct several inapproriate terms amd marks

Signed-off-by: Whye <whye314@outlook.com>
---
 Documentation/translations/zh_CN/process/1.Intro.rst   | 2 +-
 Documentation/translations/zh_CN/process/2.Process.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/1.Intro.rst b/Documentation/translations/zh_CN/process/1.Intro.rst
index 4f9284cbe33b..5b02e74ada72 100644
--- a/Documentation/translations/zh_CN/process/1.Intro.rst
+++ b/Documentation/translations/zh_CN/process/1.Intro.rst
@@ -185,7 +185,7 @@ Andrew Morton, Andrew Price, Tsugikazu Shibata 和 Jochen Voß 。
 所有贡献给内核的代码都必须是合法的免费软件。因此，不接受匿名（或化名）贡献
 者的代码。所有贡献者都需要在他们的代码上“sign off（签发）”，声明代码可以
 在GPL下与内核一起分发。无法提供未被其所有者许可为免费软件的代码，或可能为
-内核造成版权相关问题的代码（例如，由缺乏适当保护的反向工程工作派生的代码）
+内核造成版权相关问题的代码（例如，由缺乏适当保护的逆向工程工作派生的代码）
 不能被接受。
 
 有关版权问题的提问在Linux开发邮件列表中很常见。这样的问题通常会得到不少答案，
diff --git a/Documentation/translations/zh_CN/process/2.Process.rst b/Documentation/translations/zh_CN/process/2.Process.rst
index 4a6ed0219494..044e998b29aa 100644
--- a/Documentation/translations/zh_CN/process/2.Process.rst
+++ b/Documentation/translations/zh_CN/process/2.Process.rst
@@ -327,7 +327,7 @@ redhat.com/mailman/listinfo。
   子系统开发人员的最佳场所。
 
 最后一点——找到正确的邮件列表——是开发人员常出错的地方。在linux-kernel上
-提出与网络相关的问题的人几乎肯定会收到一个礼貌的建议，转到netdev列表上提出，
+提出与网络相关的问题的人几乎肯定会收到一个礼貌的建议：转到netdev列表上提出，
 因为这是大多数网络开发人员经常出现的列表。还有其他列表可用于scsi、video4linux、
 ide、filesystem等子系统。查找邮件列表的最佳位置是与内核源代码一起打包的
 MAINTAINERS文件。
@@ -338,7 +338,7 @@ MAINTAINERS文件。
 关于如何开始内核开发过程的问题很常见——个人和公司皆然。同样常见的是失误，这
 使得关系的开始比本应的更困难。
 
-公司通常希望聘请知名的开发人员来启动开发团队。实际上，这是一种有效的技术。
+公司通常希望聘请知名的开发人员来启动开发团队。实际上，这是一种有效的方式。
 但它也往往是昂贵的，而且对增加有经验的内核开发人员的数量没有多大帮助。考
 虑到时间投入，可以让内部开发人员加快Linux内核的开发速度。利用这段时间可以
 让雇主拥有一批既了解内核又了解公司的开发人员，还可以帮助培训其他人。从中期
-- 
2.25.1

