Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836A54873BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiAGHow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:44:52 -0500
Received: from mail-eopbgr80109.outbound.protection.outlook.com ([40.107.8.109]:43209
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345073AbiAGHou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:44:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O76FNLLfPnX05rnwCU0nKSd4P1l+qY/YDFzdlv1TEihNoJ7+UioizGlcGNGIW4dJSiMzYaIg8S6bLgI++uwU13wIFtUem/ivnjdD0rkd5wQmU1+5LeCT146gSFhGfSmf62ekD4nYcxSQdR7ZMqaSjozvZhpSySjNdfVdoSnQ4hL3qWxlI1OspBsIU1IdOVBciVkU5z6uugw9N8OFk1GIt5MPQxUFw13r/PGugq+cuXA0J58Aa6ErRwkSE9gNsuqccse+z/tInHRIy2Y+edGDX/MnCYFLvEEgvXsaATj81w1UY7Y1l6suB9uKXC87TuZBbWq8PVWRb1lk86CzTMjAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/crk+PWLMfdNlqPssDFY9cxSKpEaJ1HkFaU5vyjtNQQ=;
 b=Ci3cESI6/FOJ5al0CqHf8nH/si9heVdK538FFfBM01+cRBkfkjsTxpWPp6BpWpibTQj8Bb4aKhuT8A9+fuvjK5PPBC3ywxRlQIZBQm+8T72yk1IqhDmD7TPhpLOiM2kgmFcSOyL+ivlS5PEqI7Gz3D++ies/+Sy4Tnbtqa1N4SLkwsosn2SHz2XJGPxpEBDKh5eGJ6dCq1vrqJF77N23POfzAn2rPpHtG7ChG/A5Cbvan1ARMMs+DY8P9fkx6gZLBqlvT4gxR03nJFyrNOxSy4Hv/kE4XyBdPRT4exINF1FieXXspgxKzl5ngP/jcQVDqc9/dRbsegY2aBUJr1rugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/crk+PWLMfdNlqPssDFY9cxSKpEaJ1HkFaU5vyjtNQQ=;
 b=SKPnzBiR9uwf+589xCFIABhcZiZS54URpKKDv5aiEmfZiKWPLWhLTkRHOzLOQLlLjh1uDWzB+2/mzpISjB5AZuUlU+1qjRIiL9FWD2LlHspOTkNZaScaFMXn1Ol9dsP559cBTlaZotTgMuncVxhcqn0ttwJpe/E3uUc/QoSH3bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3674.eurprd02.prod.outlook.com (2603:10a6:5:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 07:44:48 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:44:48 +0000
Message-ID: <a9a970fc-63f9-5ab9-4983-fba5b01bebe2@axentia.se>
Date:   Fri, 7 Jan 2022 08:44:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 4/4] mux: Fix struct mux_state kernel-doc comment
Organization: Axentia Technologies AB
In-Reply-To: <bd26e410-b2c4-888c-9bef-efc26146e366@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0368.eurprd05.prod.outlook.com
 (2603:10a6:7:94::27) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69cfc527-664c-4b7e-5c20-08d9d1b194a6
X-MS-TrafficTypeDiagnostic: DB7PR02MB3674:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB36747C3739ADCF6231EC3D7EBC4D9@DB7PR02MB3674.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8BbhrUKJZggTlwdCNTT28uqXawLkFkEgNLlVoYIwoC68VnSQNY1lpLv8sZvq0ZbQpxZvQWBniQvczPWlgnLLDOkvTZUEnnNrx99ko8fLtKhkGjHPV99xME6ypKEb6Q2lS3ae4fhu/ARfsDhmyBreYGD3DGAyw6R2zzHLr8uI1nwa1g+UCifRSoct58hMA7hSDDxzY3qzqhcxmXbe8NRmRZLC6XsaqfQanpSbkPwgTvGwsTZ9WA2ZlaqwIWPN0IxpDuEBlQ3a87lz+dAKAxEfms3YCb6qddYZ5j5kgaijpTZcvC4LqppcYpw+wX4RfnFhxdOWa93Y/GmmJuAnA/zlg1f4+di7bEnZM2CDIOYIGjELBATlt6Q80I4UqhXVY9rfZDSkEnrfkZ1BVyIplaFTCTofu1NJp5n1B89nWDhDe5vla+b1mhspL9KJVPo25b7i0D0egw8jt1qKDJhx2nHHsRkBNNvcP8P+f7F2GjG3/MkzFU/S9iqhjFJHTcGb0ldx2POYQYQUGEeN1fCoLVSi2XQ//ivkNB07wE/GKAqu8lxR/9wwOkjg+SeMqqQBd5tV6NqR5FdbLha0PJNM2vfkX7N6gacfVqlofrmSaIvnuh9T+9hnb3UgPm5XrpENpmzppMM+iFKFL1nG+vZt7gEK5l/uzGwP2rZyCYHtu08eIBcIht3dfDsax7d4U79VT6k88USscAuiPHCw2sMN69jVwGQkIDarYCkSJuTq6O1wS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(366004)(39830400003)(31696002)(6916009)(4744005)(36756003)(6506007)(6486002)(2616005)(31686004)(66476007)(66946007)(86362001)(4326008)(66556008)(54906003)(36916002)(508600001)(8676002)(6512007)(186003)(26005)(38100700002)(6666004)(8936002)(316002)(5660300002)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpDMzd4aW40M2VwSHlPejM5UUgwQ01jZk93WThJcTNpNWtsaWZVakZkOXoz?=
 =?utf-8?B?TGlWSTBGYklReDBWM3NJU3p1SjlSQjE2Q0pLb3cvRXprUEt3c0xvK2pwanBK?=
 =?utf-8?B?S3krc3pUZFB4UWtEcytzRWoyQkFvWi9LUzFyZ0tmOUJrbHZvVkhzMDBTYUUr?=
 =?utf-8?B?MTRGd0VtVTF3WnZ6TU9uT1RyRWpvc3JkRlRBaTQrbSt4cy94WFN5aENlT0g2?=
 =?utf-8?B?WGRobmJaUkFqM2J5b0RyWVJMWHR6V2tEb0F3d1JBRWhSTXJYa2RZZ3ZQeitK?=
 =?utf-8?B?SlVEc2V1VklKWmhBT2RUeGpVRzhETXUyZWxOL09IZHlLcUw5MkZiNVNRRlkv?=
 =?utf-8?B?MXkvTVVadzlTS1VvN1ZsTHVyK2tGVjZleW13elRnN0VOYm5jcnRWRE5XYzdo?=
 =?utf-8?B?bFpwSnNKdFdNQ0ZzaXM0Vngxall1OFhaZ3NoUUM2a1QyQTl6N0haZWk2N2Ro?=
 =?utf-8?B?T1RTbFd1dE11dFVhKytJdmYyZGo5dWJwaTU3ZFN4bVpidVkwV2M0N1NFay9Q?=
 =?utf-8?B?dE9TM1I4SHB6UldYU1RicVJpUlJhaklZejFPRXFxS3JkbFdZdzZIekNpMGMr?=
 =?utf-8?B?R3R3QUJlOHBhWGh4UzgvM2Y3Lzg3QlE0VVdBRE80N1kxZDVicEY2V1d1TEJ5?=
 =?utf-8?B?cU5nUVFQSWFqU0xMVmVIY1MyWVNpOHEyeHhadS9tZVg1cHV5MHN1c1dISS82?=
 =?utf-8?B?ZTNmUm1ZMHVMbnh4VEdKVVF4c2Q5bUpkQjVoUkU1R0MrTUlOWnc2RkdKZUo4?=
 =?utf-8?B?bFJFQXZnc2VFSUVpSXRNN0ZIdDZqWkhlUlRYMFdYMVcvRnpFSmp0ajJwcFVn?=
 =?utf-8?B?cjNCdkhNVXh2SFVPQmpyeFdyZE5ER2djSmtjdDFmNUVJK0ZVSFZBdHhwcm1Z?=
 =?utf-8?B?cHJ6SHFGRjFxVC9nYUpONmQxVW9vOExJc1VvR3U0UmlKangrKzU0Y0t5akht?=
 =?utf-8?B?MkJrUkNQVVBvc2YzUk80bVo2WXRCZEZnQ0tNdUcxeWw2NmNYVmd3TlZCOXJy?=
 =?utf-8?B?anl0TWt4b0xRZ053cTBvbCtrbFlsazhwYlFuM3hCSDlYa0NlZDZTZXMzVWxU?=
 =?utf-8?B?N2hwTmVFOWhxT0g4NkdqWktRT3BsVmdSMlNTMGx4M0Q0ZVJRaG9UcW5aMzVi?=
 =?utf-8?B?b05zOGJvamd5M285S0Z4OVNRRzZHdmdKcit4ZWJjdkZCQUl5ZmJXQkpMZS9I?=
 =?utf-8?B?b3VXaVNmQnJYOTh2dmQ2VSs5Q2YzUzlZWUNPeWNyOEU3eGNpMWhYeFlieGlK?=
 =?utf-8?B?cDBOdDlwSFlzN1hkV2JuQ0JkZU1KUy9QejhlYVdOU08zbEkzSzFRSFV2Z2Zi?=
 =?utf-8?B?WnBleTQwZlIyWW5iYnpvT0orckdkcDFhVTNUYUlGZmtNM2RqbitDdDBkaVp6?=
 =?utf-8?B?QWJHQUorOWpoeEpnR1lucitQWXZuakZUbHpqV0p2aGFyWnJtTXl2QThHVnNO?=
 =?utf-8?B?MVY4M1U3RU5yV2pyRnhnRTNubUJHa3RXOUFuYjFJOHZkMmJPMUFkQWhBeGJr?=
 =?utf-8?B?Q1RHOVJ2a2NVWVozYlNWSjdKM1AvbSsvUDRaKzdUQk0xRmZqS3Z2SzkxMkpo?=
 =?utf-8?B?dVRSUUJJaS9oTjAzdDdEYVRUbmZoSFdvVE9zemgwNlcvdDYrdVpDU1hTZ3N1?=
 =?utf-8?B?S3p4U2hWM0lsd2MvOE93R2hXQlZicVNmVEtnbWEzYU85U2JUYUg2YStLVkN6?=
 =?utf-8?B?dGdScmxXc1J3cHhFc05Lc3JydGxlcUFwRlJNSnNtR0tQVS91UG84aHJ4d1Zm?=
 =?utf-8?B?TjVJeUsyYjViNWMxWVBzRkx3Vjh6V0JCLzZPTVVoTzV2NmgwNm15YUFKQ2xk?=
 =?utf-8?B?S2daYXI0alRHdWE4VVloMnJkSDdJc0xsRTl0dHR3NWR3S243NDV4dmU0SjVR?=
 =?utf-8?B?NUJtN2pCSVlncVJBT0ZDUFNkU2xXbjhrazNBa2oxZk5Md3RaWmNoakw2QzUw?=
 =?utf-8?B?djhrSXpZU3A1YzVKVndmYjRTcnVyZjFGUlh4YkVMcUk1RkI5UVpkOFJkeVB0?=
 =?utf-8?B?QkFpZk15MGNsUTlEZnRiaVFIcWVNYXJQdWZRbkNzZ3BHMWpUdkt3Q2ZBN1Z1?=
 =?utf-8?B?anNvZzI2Rk5pTnlIMTBIOFJ6VDNzUElZc05pTFlJM0U1SVRRN2F0dm1WODFn?=
 =?utf-8?Q?+bYg=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cfc527-664c-4b7e-5c20-08d9d1b194a6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:44:48.4545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSwzxGPgH/aX7FP2AH1M1MlWWn/nKnFrS18NydbEjV1oeNm0YTM2lVQTwSiuZ/2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

A warning is reported because a colon was dropped, it is found by running
scripts/kernel-doc, which is caused by using 'make W=1'.
drivers/mux/core.c:44: warning: Function parameter or member 'state' not
described in 'mux_state'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 1a76a536d4b1..49bedbe6316c 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -33,7 +33,7 @@
  * struct mux_state -	Represents a mux controller state specific to a given
  *			consumer.
  * @mux:		Pointer to a mux controller.
- * @state		State of the mux to be selected.
+ * @state:		State of the mux to be selected.
  *
  * This structure is specific to the consumer that acquires it and has
  * information specific to that consumer.
-- 
2.20.1

