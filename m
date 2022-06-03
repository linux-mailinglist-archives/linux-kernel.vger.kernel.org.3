Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0F53CCF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbiFCQLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbiFCQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:11:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8732CDC2;
        Fri,  3 Jun 2022 09:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdHamleIBC9GJys8C7SB/gXphv+xG7dlpHX6dLxjsD6m3LpysmTZTvw0P51I4guqBEBv8ed697/Z62y3ejim+PfX9H41vFEWt0i2jk+jzvLWEWLpWa4/2dt7STkNqmU+f8cZupagJ5cPBl7AxVicrSOrdZl2PYEKfLsGcXIdlKRkuVZmpcKtWItA0S9Tqx00vW9bwAH4Nx8EDoUHOgso0CxqqMqjWG3UIUj5iB3s08dEmKy6vd+x+yppZPeYy/bC4EconOfmMgltdZ/OcYWOkZFAYfG0PkMJEWha5H45bbh6ysBUAXGCUOODDFvqg6y+niW1lwDLWXFJ/Jt7T9XJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvyrmZAvtCuY52sCMVCdxwR/M4z2KNn2CB17+ZvpweE=;
 b=LwfmuBWJlCkY3asYrEf9POTO0NNNZtuF7Vj69u4ByRXaTdZalWLt01QhzYghrV/oj+LnAJtiapM81zvjtvo0PU5kShA/8kvQEThXWtBlHU9LH3m7zCxAHiTqbjgJcRz1zr8mjFrD0ZOQSV5CuTgEmfYgQ9YdJOU2yp/7P6AtPDf1916dp7XyBkHy4EZndJNujIR/std+E6cmqJbxjUCU0naQAf/oJkGmJtebQQFCXnxOudJDnc4GaTMmVHq5TYOtH2vH/QtG+ocuGCInPfp0aJI1zyGrwpilVlukkM91ZTL00LwUq0KU9zaHrFjMDMrI2Ndy8Vs0vyLebxyNBa253w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvyrmZAvtCuY52sCMVCdxwR/M4z2KNn2CB17+ZvpweE=;
 b=OAxMfOGdV3ny5U6STgYgf1o3/lyae4hlKsBi2NFZGF0ip5Uy+A5HZ+GCTPk2J0tRHLDARg0oT7p1UMoc2pJPYftf+LavXla7ql37XgVsIFMxOBKMTTDzAKvzuvN8Koyh33ZezIjPLn9IvM4GpatW28vJhyLM0sLBJstKTx/eEAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 SN6PR01MB4909.prod.exchangelabs.com (2603:10b6:805:c4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 16:11:04 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3%3]) with mapi id 15.20.5293.019; Fri, 3 Jun 2022
 16:11:03 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH] hwmon: (xgene) restrict power measurements to admin by
 default
In-Reply-To: <ccaf859b-55bb-ab06-dbe3-9c8350ec5ac6@roeck-us.net>
References: <20220603152116.2269912-1-scott@os.amperecomputing.com>
 <ccaf859b-55bb-ab06-dbe3-9c8350ec5ac6@roeck-us.net>
Date:   Fri, 03 Jun 2022 09:11:01 -0700
Message-ID: <86leud917u.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:610:e4::32) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3c577ee-36f0-4b1d-f507-08da457ba83d
X-MS-TrafficTypeDiagnostic: SN6PR01MB4909:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB49094B6879C7C54264586D9686A19@SN6PR01MB4909.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWWIqPQyk6HLpZ8BeM4LgIBjSqHFlxV2x095s5mlk8rSOWiJ4aMlJ+6LErdG+Ey0lAqh6yLvfG4FAAcMaaJDYLFs82WJOXdB9rN8od/JzDiixRMw66A446SGLHkjzz6gh9q5paB2zmlEKhF1Gzx8vZ1VVJf0C7LKz6Jx/tu3meg9xiGGHyNYVClxkqn8gFcQdEvUZWy6Ps5+xtExlVT9KGBY5IC95ydPYzo2GojJsahNxbecJbg12FujBlR98BA5S5BWicWzMNBi5Yphdd3UCbCWsNjrBLzty/tMQtm4Qu6IItnNdMRxiqBOOloocQnCWl6MSIcaikHFwcaTH8iXVLlghNlxpwiOh1IPYtJso9YY0yTbRi1OOx1TexVA97ececFAr90AT7MW7IPO1K8c2o++zLoG7htN0t7xCr2Yr2GEJo5AmtXLJx20jiIA1mVWM66BV32FDieQnKVXSx7ualDBGQhmMWGpsoQNkYy1Wxb/+XSKO4jNBGm6X4v652OabF2aN57vG8d3xjavL3theGQQDeqzLu9SvlMAUcnuWk0F4UhY0b1NelG1ESdUfKFHASUEPilhupZAFB+iUErDA/y0NiZFFNqdbU8Cnw43D9kJMKIjfVcNPD4/mzvSUr0ckK7Z9GONFWEWiXdImmmwepIUDIDAIeIX0bSnAI6Czpgq6cM6Oh4BvOQSePPI1dYfDQOJ08dRFbHqyZVEKcrssA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8676002)(54906003)(8936002)(4326008)(107886003)(186003)(5660300002)(83380400001)(38100700002)(38350700002)(66946007)(66556008)(2906002)(6506007)(316002)(6512007)(9686003)(508600001)(26005)(6486002)(53546011)(52116002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sa7vBKQDqs7ORtn0M6qmDxa7hICMXCdVX3rC7SEmLPj4o5BrR1C1nSyJqh46?=
 =?us-ascii?Q?poi2gsLmUAoU6+RdB9jYoTVSy2RuK8WtVwWx8UyBGCDAl2vpEY0boDBsjJ2e?=
 =?us-ascii?Q?pxWeex4Y7AwAbU6//7QlhCHXmf/jGqmHmc+v4H7d+6H6rkR5bZFPBiTh52J+?=
 =?us-ascii?Q?Z5AISM2yXKLCpo4qQkzYNywdoVJxQo1E4HaILPb+v3GJmociKOlkYPveuKJZ?=
 =?us-ascii?Q?z5aF+TjlrOLBnHoeeSABTpTgmUgr/mz0BFkj+xVRqQJ/5E4TE9ArIvpOTDii?=
 =?us-ascii?Q?X0hrrpJCeOFrRq4VHaOzHxtIcBlCG2/J3PYsh/SXYQmiBlHNOW3U0XcQTYce?=
 =?us-ascii?Q?OGx5hieX6kNf/EWlPkAVlL3r5/Fkvdgsr+2XjPoCs2eRAHyO0fK3r/tDeKMZ?=
 =?us-ascii?Q?UGdX6X0dHQp16cuSm/l92thLNzCo7R09GZJXWP0us2j/IJkhDbHPQrJKeiJR?=
 =?us-ascii?Q?EIV9touEbbyQu7Lv0dKWnx0s2yit1fJQN1EidU/vz28CK3+8cXY6ah+Wwe92?=
 =?us-ascii?Q?GFgVKKAqOKn5dsZ5rnA2aF+/lZ3lIruNjOory6JWPT3KS5aCZzotN+LlnKMA?=
 =?us-ascii?Q?6q+LYTgKWVj3eONsktkqgjtT95dzaHErQ4sckC6gqGrIpz/WcaPoN0rCnWB4?=
 =?us-ascii?Q?U3Aiy+jvjexRMP2jYhQLq1rUEghb661sDt6Mx4tbxLBBtX0DZa8xCK6jdGn4?=
 =?us-ascii?Q?Kfp2AYoFLG1dNJXjA6MjMbkHbyF+ZfqlYMA4hx7PDCRcQ33bVwbRFTLifEnC?=
 =?us-ascii?Q?ZGPsSbsa6m/Wj5SDPpPFNdT1+6Kc5drs/mwFNIQigEHUuPWTsfQGVkyMBHCw?=
 =?us-ascii?Q?ZSOtDlTyVXn4VhOJKgyibBApkkFKRFsr9hntWWcI2nLwwfRDqlxBk2geiALa?=
 =?us-ascii?Q?YDTODoRwJOZxJaIPlrrYEjaGOS9zl2NBxYPtdIK8PINtGtnRcueAOTaEh7nU?=
 =?us-ascii?Q?XRKOoy3zCwaNNGVL/QPBdWlPFN2foC/c2jpd+ajK8/sZZI0etnbo67I9aCk+?=
 =?us-ascii?Q?DcBeuRWs0zGwMXG2c0MEvSlCgM+kAhBKT/Wmf0nJBqzcyM/sq19rKCCYF46V?=
 =?us-ascii?Q?cxxNx7Ky8OgiJHt0UMfawl7v2rQZQv7W2WCTTqnCIN+JkZvFgfwpJOezIFZv?=
 =?us-ascii?Q?Dtm5Bc99eB/CNa5Osqsp/LWcZTCECna5iDqEeL9DS1pNsRWkqhHgGeBW8Hqr?=
 =?us-ascii?Q?fYYG9/eTAbOLcMEgVSH1ISa/FNOCvVl3fpDK/hUe1HCld0m6NxsZIwE6qwMV?=
 =?us-ascii?Q?4xTFHvK5XnlMihPlk6ZxUBspghxJ+gmOlE92QKXZqQ1kXJAREp+GjT7xZdEo?=
 =?us-ascii?Q?cYB9PiRp+8VxRq6+s/94TzSW7q62XQOw/MGZ6CVJqvovL+UtN4FXesey6Mjz?=
 =?us-ascii?Q?/xWM+uwg+Neo3NhnZh598LmlNBKx0HXVTiuyM6HaGuE6YzUVag7x6iPFs8sI?=
 =?us-ascii?Q?LHZTAZO1R8C5V1Wo0RsYqLi6zyzyPk2p3N6DuByeBmfZZUIVGhTutNjPp0o6?=
 =?us-ascii?Q?wrVToUl7SxLCI2EvofvmElww/tiN0K9IaiJufq44TjUArAsC+mo4aiVFGyDO?=
 =?us-ascii?Q?eKC8PDzVkblEHUkWhD75OGWtUlsLVJHsQQ4gbzoKj3ccNEdm9XKFk6DQNhB4?=
 =?us-ascii?Q?VDCqLUzECc73tCdBB5WL31rBsYyjr2JGG50KWw2hQkW3i9o5UjAg89XTMrBk?=
 =?us-ascii?Q?ngHCQa1EwcD7Kd4PNHkLsrKDGVlXwxplpEHTOwZLf2uX8JvPdwzvedvG0HFx?=
 =?us-ascii?Q?SuP1e3QRdHqSDSHcaSEmzCBEqzG0Bb/xfq9+Ln96USpA/XwvNcmJ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c577ee-36f0-4b1d-f507-08da457ba83d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 16:11:03.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDG5yBJsPM/zFieutccLnY6ZCWG3l4VF8TV/nw+HqHxEyEa4hZXejFrwUOEeLgMTg1epA7iu6wOrOieBBCcSRau0W83K3pOHON2RDHm7dHRpL0ZwwODQj+5LG2Gfh/kC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4909
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 6/3/22 08:21, D Scott Phillips wrote:
>> Access to power information can be used to infer the instructions being run
>> and possibly even data being processed on a cpu[1]. Restrict access to
>> power information to administrator users by default. (Cf. a similar
>> powercap change[2].)
>> 
>> [1]: Lipp, Moritz, et al. "PLATYPUS: software-based power side-channel
>>       attacks on x86." 2021 IEEE Symposium on Security and Privacy (SP).
>>       IEEE, 2021.
>> [2]: commit 949dd0104c49 ("powercap: restrict energy meter to root access")
>> 
>> Fixes: ed42cfa881e1 ("hwmon: Add xgene hwmon driver")
>> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/hwmon/xgene-hwmon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
>> index 5cde837bfd09..6ad1daf2d354 100644
>> --- a/drivers/hwmon/xgene-hwmon.c
>> +++ b/drivers/hwmon/xgene-hwmon.c
>> @@ -397,9 +397,9 @@ static DEVICE_ATTR_RO(temp1_label);
>>   static DEVICE_ATTR_RO(temp1_input);
>>   static DEVICE_ATTR_RO(temp1_critical_alarm);
>>   static DEVICE_ATTR_RO(power1_label);
>> -static DEVICE_ATTR_RO(power1_input);
>> +static DEVICE_ATTR_ADMIN_RO(power1_input);
>>   static DEVICE_ATTR_RO(power2_label);
>> -static DEVICE_ATTR_RO(power2_input);
>> +static DEVICE_ATTR_ADMIN_RO(power2_input);
>>   
>>   static struct attribute *xgene_hwmon_attrs[] = {
>>   	&dev_attr_temp1_label.attr,
>
>
> NACK. The hwmon ABI expects world read access. Either find a workaround
> by making the measurements less accurate, or drop the driver. Also see
> commit 9049572fb145 ("hwmon: Remove amd_energy driver"), "Attribute access"
> in Documentation/hwmon/sysfs-interface.rst, and [1].

Ah, I see, thanks for pointing that out, I had missed that. I'm not
confident that the randomization approach can provide robustness against
this attack, so I'll follow up with a patch to drop the driver. Cheers,

Scott
