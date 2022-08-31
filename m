Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB95A7541
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiHaEty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaEtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:49:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCD7AE9E9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddO3FURXXNrFo0ShOFJiGW+Hv1EiDv/W0Jh7OH8Zq+t6KMhkpVsjEHSQ+c/xpi2VJgexj8VQAUqE7KjKv4B9YnZGPme+4NZQNVXK6YTLNFzReO+xFlyKSGMUofRmR2QV0NkN0izb4DbX5bS6KojXiMDiHs/exuR/MSNRWuR7lj6Kb+/tzlT11fI7pLSFgLuOn4MBnAhHcrDCsFLSn3KJrV9FPbRUR7Geys3phVIlKBCxawgjgWdmmdjg4Qyg+OFAPgQVV32I8ku3b4HWemEU6UBFvSpWWEVV16JlH1RtMzb5rbmtvjhY/XjMyTWag0QngWAI7kBMM+rKfS18Lwhvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3EgPCoBIklohm+/iNUEq7HUDBCE7dUs+/lHh1SLxPg=;
 b=XCqSatnJdjijEvsfBsdRopafIzSV9PX5wImO+2MWPjhbJUXY2Aa3rbBinBUjWKCemyQQJVMrtgDo7or/CatvXcI1uYHHQyDgCwrXO0vZ+50/S3ojmr9MWzx8FPMQNNmCyWy2cbCYoPjAm/lS0kr9x6h8dABrZ4Tlm7cpQnU/0zZyM6RKbop719AZPEMAB3GikSUTpYafE9t7RCEk/GFluMmOGGqHf4+jLX1Xh94DlCq0D30+grkybs/60G+LI/6I4Yvx5BMYfIU16llG2eTsvpyFs9vo38IUTRPwysvPL3VoGjt/FoloxLWzYZfMaelI8cP7vdPGF8lrI17UMyTOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3EgPCoBIklohm+/iNUEq7HUDBCE7dUs+/lHh1SLxPg=;
 b=SaSFJYrMOeBWAEUyNvU1PNfNG2Q0v4buSWoIixYi0LD/fLxksisJgnwTnTTUNdXRoGFdZpF6Tfp2T4MbbMYNh1ljuBecdZ2w58ZJynEnCQJciX5cphQKn9Wlq/b3QESq+BhswdbKjQdHYu0Wn3aeeTfXYF9zpMQq52u60Ca37rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BYAPR01MB4997.prod.exchangelabs.com (2603:10b6:a03:7d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Wed, 31 Aug 2022 04:49:38 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a0d7:4912:3c82:b0aa]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a0d7:4912:3c82:b0aa%7]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 04:49:38 +0000
Date:   Tue, 30 Aug 2022 21:46:34 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH 1/1] perf/arm-cmn: Add more bits to child node address
 offset field
In-Reply-To: <f2ccc321-c892-0e35-3760-1d0ed5b5dbf3@arm.com>
Message-ID: <alpine.DEB.2.22.394.2208302136090.3584@ubuntu200401>
References: <20220808195455.79277-1-ilkka@os.amperecomputing.com> <f2ccc321-c892-0e35-3760-1d0ed5b5dbf3@arm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MWH0EPF00056D0C.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:5) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3341b26-a416-4099-a790-08da8b0c35b3
X-MS-TrafficTypeDiagnostic: BYAPR01MB4997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtiu4OBxWeCuEdYlQmAwo9pQJpnxxZBXDyFFVQ0uL6TSS2gdpDV9ocobPCHcxD1gL4c6DvPlFkdJj8H1Q3w+DsRJZVtkslHeSDp7m6SAIs8ERdYJKNnkriHMk+apD8Aht9pbudxbi+hAj/piS/2euAk/K4+fLbMqGi/U3lXi0UvH6BgeP4Z85N6d06VHK92QYKZLw2ifjQ5sYjX4snKKT88nP7BkF6UoyKo+QtZM9SksvSGXnSfFzZ6ENBl1Vk2wWKE+JKODVwjpSqkEYt1whDTHc22H6UvhUoV0EKkBEytBm4GnxUZOPnFm5i3+j+s/5onbSbmMp2DlhY8dnCfPLt6cYLtwIsxrY+aE7KgbLEmc1R1PA+ZWga+ayZlZWEao5SLVeqNJT595sEr44UPxmK6uERya8sydj4f2l6BdtDkqhOzWs3UNScpi+KwhT2W/17qoUA7xShTBBOvboav4Sfl+p8n0pETmzRrGxKclzorpWMHzSeOL51FPqSfEpkKx9YQmoP6s1DYjEDry8mNMeZep9UBmn/DKKuJPcSXCvmmmeBpMqE8UOZYGoXngH/Luux3Qs6WMQJe2dlZnkP/qMroRqf6E4Y6ZnefralSnt8aKVqpaYnudLmvk/hdtkEg0/oWawg5OuJeYDCDxt+vcrzSiXGzwrj6lyCy8D6/HpDmUGGPSR2n1woks69o/OpfzEsso15vnathR0si9C/qic5NK5Xj4nDzcF/EUL77Nf3mPcSxGN2jf/+KsSNTwejX/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(396003)(376002)(39850400004)(346002)(136003)(83380400001)(86362001)(186003)(38350700002)(38100700002)(5660300002)(8936002)(66556008)(8676002)(4326008)(66476007)(33716001)(66946007)(6666004)(2906002)(6512007)(9686003)(26005)(6486002)(53546011)(316002)(110136005)(478600001)(107886003)(6506007)(41300700001)(52116002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/vYWrFZJbAMlg88Cm/RALcXmOjCYUYVgDfZ3vaBc8kMWUx3kn3Jv0uucFTDV?=
 =?us-ascii?Q?sLIJ8sPjU9pgp3iPalX/zIx7m1yw8T3qB89RgoQizh7pIHq9LRQyT10xzQF2?=
 =?us-ascii?Q?/IMuWp0vOmVvBNA1PMT8OmVRKOf1OGIPABb7uyKpZ/ChnOWrKacSd6vLIi//?=
 =?us-ascii?Q?ilCaeFTo+SDNNiQrC9eVaRDMvWH/lZvcCKKgTTRTeHKlGO/bfzWRK2Hmk3O1?=
 =?us-ascii?Q?/6UcXnpVdM52mybcYbbjuv2iVjZJnsy16rkRFD6VoQmF2BXgRhVRnkbLlj8k?=
 =?us-ascii?Q?2UCHZhLd8bSAqCu1Iw+UEYZloewuJdOK+rxX4/ZiEb6jRVHJld0vscY70y/v?=
 =?us-ascii?Q?x8kIS7EsRElOWT/LVl5GVIo0VEPwifiV7M5ipnfdFcWFY5S3fGsKwIOKYcEM?=
 =?us-ascii?Q?yvN7D7EOOzbVxkrmcJ8DaGM1hzyrP/TCFeezUNbv3ARMehUvP9oyM4+7iG8K?=
 =?us-ascii?Q?FKGKRDx+v8QlJCjUg64UqFtJ0f1U1SMJzj5Hro34nMzk7tQVedEDXznAnFo6?=
 =?us-ascii?Q?Apq8zp6gl+3qbM6BgwWKlFv4jnMNFydSa+zwhYyxXUCBPAzegVM8e+O2V+f9?=
 =?us-ascii?Q?C7NSGI+YphCUbA9FDC10RIt1jOcGWumHYfHB5Epo9MYpBnYHG5cO6oLK+HuE?=
 =?us-ascii?Q?tE2np4/Z5lNrW2FdWYITDIJKoWHhUt5js+tCWwbTN4GrxSqyaqQymiv9G0cY?=
 =?us-ascii?Q?QKeobXX4W0HjKxzBIe8/+u8QXJBBbgolV6PmrgI6dW2HBzf9IcYD8vMwt87o?=
 =?us-ascii?Q?n3dq/VcxefDDxXASfo976jKwzBDLeVoXOJSBvnHniihnD8sVWe64HETeoc7G?=
 =?us-ascii?Q?50rLAnzcMho0hcZtlIfxrAHgyFEJVkXIp27jI9hdSgBjfKgm2H5DQCc8GaqY?=
 =?us-ascii?Q?dsLMv8qwkmUPpAJTlS6wK/6x/9wnN1OvBXLiZ7VuACuvKXoTtI4UOMuUMVkC?=
 =?us-ascii?Q?r717dse9Gvf3jcKMRvEVVZmDXSvpdJQq44oSELAg5rXXtHwGs1xa+zdTgDyt?=
 =?us-ascii?Q?xrdHCoBPUfyMkiBzJR2VAt+xwq+iHtM2dAYzBuzfP516jGzyDvClyzFbwXZU?=
 =?us-ascii?Q?wztY4J7PYgc32ZHdtegpaD4Bey4ezH8cA09QIWiufi919dS+9vgCx8ywNbYI?=
 =?us-ascii?Q?U1JI3wALo10ev0vb2ed7EHo/FrTuviryfzn90KTXJdR+LG/Jcp9Is2sjSsS9?=
 =?us-ascii?Q?mFRvh4i25C4Kr4/tRZOS21JKkTsw1pLwsmzW0L+tVeIxNYP0WaCkxXqYNlUN?=
 =?us-ascii?Q?crl55pded1IUC4RF1a4b9sPqyR1s4Mollm8ybi48b55jwkChxF3y16+QlxCM?=
 =?us-ascii?Q?JXNn/AejvyJpIkPZkq2/sZxMZBhrAQDxvxSXw5mejdmdoEZU54Rv08uFmE4C?=
 =?us-ascii?Q?p1+wHKXiQYZnEu1Z2w3klH09VwpRQuCUnasFH/3HsuPxLZr/9stG6R5Gp3YJ?=
 =?us-ascii?Q?qsaP2WrhQT2NpjSL0nGt+efbO+X+OvouM08udemowXm+9DamyBom2Gsz399W?=
 =?us-ascii?Q?++BZkpbZMxOz4CBAzYMH9Gl+K4yMXJxe9mv5t4yBTk4lB2KJLpdi5z9kAHLy?=
 =?us-ascii?Q?oj4SFWHM6FpQLcXRV6wAP5Ou9+egO1BmtY1NteBMfGYqg/C94OivQeZZHd5M?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3341b26-a416-4099-a790-08da8b0c35b3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:49:38.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oC7g3czpn+4KGqxnDVgzLdK4A0GZy2NAnsArBJ6idJiVZUDZBmUX4PwQlJ/SewgCIKm9QHlhnWsD+SRcOOmaNNYYw+muqpkyXori1g6Ry0EPOdfeW3hjZ2efJYuN05W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4997
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Will,

Would you need something more or could you pick up this patch?

Cheers, Ilkka

On Tue, 9 Aug 2022, Robin Murphy wrote:
> On 2022-08-08 20:54, Ilkka Koskinen wrote:
>> CMN-600 uses bits [27:0] for child node address offset while bits [30:28]
>> are required to be zero.
>> 
>> For CMN-650, the child node address offset field has been increased
>> to include bits [29:0] while leaving only bit 30 set to zero.
>> 
>> Let's include the missing two bits and assume older implementations
>> comply with the spec and set bits [29:28] to 0.
>
> Ah, I don't think it ever even crossed my mind to look for changes here, but 
> of course if the node regions have grown from 16KB to 64KB then it's only 
> natural that offsets grow to match. I expect the CMN-700 config that we 
> tested on internally would have been small enough for this not to make a 
> difference. Thanks for the catch!
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>> 
>> I have tested this patch on CMN-600 and CMN-650.
>> 
>> drivers/perf/arm-cmn.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 80d8309652a4..b80a9b74662b 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -36,7 +36,7 @@
>>   #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
>>   #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
>>   -#define CMN_CHILD_NODE_ADDR		GENMASK(27, 0)
>> +#define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
>>   #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>>     #define CMN_MAX_DIMENSION		12
>
