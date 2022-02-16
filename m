Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A044B8610
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiBPKlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:41:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiBPKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:41:49 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B092D3A;
        Wed, 16 Feb 2022 02:41:36 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21G9iq7u002789;
        Wed, 16 Feb 2022 02:41:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=AygaQ6JH1CFSPuKgf/NdpVeOZojTaBWRfX9nJn85fMw=;
 b=NrQhrRjoUV7TRYxC961R2mdUtW682rC8E5rloxoRk+p2nDRMMPY5Dc6Y8c0RWnlxmfoF
 IxdPVGaK3TUYy6Mf8AN7CHdaYQIaRAHVHJNAumGCegzn/zOg665gvpfRUfcsxXjejOHY
 ZSMzXzZtKsTO9KIB0dINkeOQQvloxT7AQzNlwYqWEzqrhV6Vsvliz3Cjy/Xkw6F/UZ1F
 rhpubfuCM1cA0pJLzFBMWilcuhylN0CBCWU9x3172JYoJOpyPV7CzEXg/r/sPEZf7I+X
 ptvStAFd1YWv6vZyU6wiz7n0G5W7P3njQKQtOAmTp62SVgywuM01FB0zxQIE4FIlm/qt ag== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e8n1x0d6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 02:41:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOIcXY4gb9AuSjVJV3aKAvd8DvLfBAFVWDsXK5vU7+R4FOA52sPWyGe6TpyFO/6Mz4y08O9iRCcNDhrGafNQBugCBxwoTQ/cPYAQWtyRzDC2o7BKwJ6RGs1bQc3EfVHGpNQPI74oWpLzGQnDPb5MLQ6sVz0U8GQr26rIdYbTj6VXHpL7yu6MLrkApdADSzmo84zmXoFNFpd8B0htIhcRKk7lKYgCFe2vB9llQnX2k5mW/sLXNkFOthHGhQ9s5936D97qfxVAVHK3tCymg8+m7mLEhLSuG7pubDR9ljJ9SfJc3hdpYpAM+FH3Z7kbmi3ZNeUVu+2SxTs6WWus2+799A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AygaQ6JH1CFSPuKgf/NdpVeOZojTaBWRfX9nJn85fMw=;
 b=IIQWO3EFSMfqXMvhd9sVmjJSWAzgI+JZ2Ss0jehbsJByVoVwXH9fOq7+s+BdArxVRG0liIo8xnxBsQ3W7Rfo7OCB1DCtHbyO+jM8TVJYvnC+qOJLsYWJsPTPVeU75CmINh9h1RG4uJV1FFxSnMplGY5NM8ZUPkGdlSbzJyosojJKtu81JtSgW6B7coMm99ievDeV67nYAIDvLHlqOu35Gg7/dQAmCeYzDr4p9SGXV+1SBpGPYYw1tlyENWnkzus4NHlFbYzFaWsICPiPFcZ5Qkb9HvEGgjo+2i7W6C2yRX3tdjVbJ7vxO2Sl109MF/jS6TuYepO6eWDGEzqWHufWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR11MB3008.namprd11.prod.outlook.com (2603:10b6:805:cf::18)
 by BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 10:41:30 +0000
Received: from SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3]) by SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3%5]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 10:41:29 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBzcGk6IGRpc2FibGUgY2hpcHNlbGVj?=
 =?UTF-8?Q?t_after_complete_transfer?=
To:     Mark Brown <broonie@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
 <YgU1+cIlANAkJCAL@sirena.org.uk>
 <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
 <YgVH310gQ1sK6dlr@sirena.org.uk>
 <a5aa6dcf-e3dd-e8ff-edcb-edad96f8ddfe@windriver.com>
 <YgpOzw2rq+vAIPBU@sirena.org.uk>
 <8fd9c3ef-df64-b8ad-de6e-ef86806d53b5@windriver.com>
 <Ygpo9YT9PrQAAIH3@sirena.org.uk>
From:   Yun Zhou <yun.zhou@windriver.com>
Message-ID: <111c2102-5782-2740-65b0-47b0e5194ce9@windriver.com>
Date:   Wed, 16 Feb 2022 18:41:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <Ygpo9YT9PrQAAIH3@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To SN6PR11MB3008.namprd11.prod.outlook.com
 (2603:10b6:805:cf::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e83db7-b0b4-443b-3881-08d9f138e401
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB259986723DCE043D31DFBE9B9F359@BYAPR11MB2599.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2o2Kv7KdvuEbI6MHSOE6FdWMaY3uXDEYensRSPxikSl3JYUbM8LMuxYvfWK6uicMKYOqHyJde+/AzgtdFrgzpk6gYIJI1k+sYU1U8GY3NujSeI+dvueeobWEqiQGU0zRm5m2bGcS0AX3K8s9PzoVPoNEl39+Ss56GY0LzwYbYoPhApja+c/L+nUlpXOi7k79wNYqPT5AWGUH4tklYN+by84Q5YpZzFtKcl846Aq0KNaa0PeI7W6B1onIyc/yHbE4xAOrMoVUAXo1pMI0M7qKHVJF3MqOcU4FuCfmvrT38P+dqhMjP+JQQItrUW6MbQeo9v/SvonRJBKArPjLc3ohFdhJyho1edU2QrLrCxjGY1hcur2nwhXTUjUpddUD/1arh8PGP7oEs1GpfsBfu00FYsEKblfI0vEHnoDucC4mSb2RHG7G/uXTySxSiw97Of07kuZcMX/hw1Tb9JDz/Dfm0mNanALbYbtcgh+ENIi8ZDzO4prjoO3pZyVXsPafWCxRNCP6QfMIigllDD8NK/qW8lACYuSKnvx9BR0ufGoK8pCrRFSU2k+2h8h9IY0L7HfMp9rNnZ5vigSMWx+XUco0XaD1HTHfWMOBmD0wtp2WSUG7I/TW38hylTMD9Ut3zQ1Bp8szEGlncsZosNXr7gT4zvoDH/SQt7fFHZvDGWjWS1RgY9MJaCNCPdFYQa8UINvgOJdFIaoTUd4lliPFQJxICpARuo70DvSeB4Q5P+kfC3LsRN8OYR5jVhoHhdXBl9Ic
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(38350700002)(2906002)(38100700002)(36756003)(44832011)(5660300002)(224303003)(8936002)(52116002)(86362001)(6506007)(6666004)(31696002)(53546011)(2616005)(508600001)(186003)(66476007)(66556008)(66946007)(26005)(54906003)(6916009)(6512007)(316002)(6486002)(83380400001)(107886003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?6jsIujm3NcxS2NAhpE6JUwyWpKLsrAlLwFE/e+BwTZjT0XCPhnnQ6fp8?=
 =?Windows-1252?Q?T+aikbMN/5zxvR16Iak5bM4pEI8w45JnFXr8Nh3hdUUi33v+9cuhCwck?=
 =?Windows-1252?Q?KVzAOFsuW82Ol5grvc4ckjGxLNy9ZnB1yiVBxzcAskO8vrlWlrhfbEy3?=
 =?Windows-1252?Q?jLIlPBvrceoRWvKwPF0F3v7JqYaMB1clfM34ZvpEm8DkOHRytrGzL/7F?=
 =?Windows-1252?Q?YWDyln6vkau/K0Yg1I/SH063y0A7/V+gzPoUjv0MX6YSHE5/Gu5Pq+GA?=
 =?Windows-1252?Q?BCGd6OXhNoZCpZQ9x2F9CSX8uVCEuwJpoNngaobXlPr54Dy6GgDebRxz?=
 =?Windows-1252?Q?yy9e6+9foNi9PX9HKgEawFCetPSCubftdyZczg1U7P5dmtg2LDmr7Jte?=
 =?Windows-1252?Q?JDw/WX79rXZRYttTJXaB4zOKTcaIbTAAWGSngHjw5o9pgAUCL9O2LD/c?=
 =?Windows-1252?Q?Se7OXmLBN6G9/ZRD535Bl8lPcbA2lcoIqSMbGuk+XwcJlJiy8Zflu9JA?=
 =?Windows-1252?Q?2RCKsKBkt8WwsYagOiuQoV+32GV3VDPxTZyxpopWTTlGlLM8q0IVA7Sz?=
 =?Windows-1252?Q?gNfIxF0nc0TzzE+wQQnDAvXLYXt5uah1WNfzJAfX1sbBwgJWR7vyT+bn?=
 =?Windows-1252?Q?ybCKDmDjGVqVSZT9+LhmJnHbElSeY28++uppYF8eVACTqokpIlxKpdF/?=
 =?Windows-1252?Q?r1Oqs50HYDFmHUVEvDGrMwB9VgoNEvc4aI0vvdGjLHjdPMhIgLVrmtfG?=
 =?Windows-1252?Q?jjGke670qfsCDXhHO3nq+owRhc9a1MoRP1yJlFFLkOktaqxCM6eyBcsp?=
 =?Windows-1252?Q?0ecWeLwKlvtm4NeNyORl8WzrJkWQHOn0KMVA5fx+VFZ4MPUBT5je17lV?=
 =?Windows-1252?Q?T4pteRimW0LbIEOc1uhLJ7b2rjo2x83+HmgF1xkkIOsx6njbehPgTXuQ?=
 =?Windows-1252?Q?blPVd7BfEMFFk3c39mJymNJ8RQJ0Q4qulwrFLSpLy8O90+3MU88g8mno?=
 =?Windows-1252?Q?UH9tULbj3p/8tMEbb2VTlHq7nRJ05aS6ZnWDvnMWdvviR16u+kSP1pIU?=
 =?Windows-1252?Q?BAyvdJEbgeXEyNr+iXbBWS+JKyXsgBVcdhsJ1p4MelUGwZtOI5JWmNPo?=
 =?Windows-1252?Q?JZJkL9ZH1OqyFjfd1++Tajb64IqHqUjzydTtBjY5tssamiY8x7lzMpNj?=
 =?Windows-1252?Q?T2SVI2hk8DZHwrj7gaY8fUDDBsFYy+zJ28O6K9xcGVaIG1qfmSZv+um8?=
 =?Windows-1252?Q?zQykPzbFGPpJptkr4nq3wd9pcqsRSwbPgPRN7AgPv8ogx4fpZaQSBPv/?=
 =?Windows-1252?Q?ZFHrp9tRBWA6B2msp2jmbgAFN1IldOFJeudB8xQeiv+peqnZ0fpS6KtP?=
 =?Windows-1252?Q?W1SgyOmFLw57mWByYuJ1EeFau81yDJZDPtP34csZl4VHmgTvTbvSRXXQ?=
 =?Windows-1252?Q?Ygl1IgO34YG/y5i0HfzmhWUPqf94mDoF7p0pcO/ikdbZCEk57D9Vammg?=
 =?Windows-1252?Q?XUN7dCO6/ndVXAwl+SL2ePd+wOti8gbfObGXnfajBlQ986SYNODwb45Y?=
 =?Windows-1252?Q?5SLstjJGs8Fw4D9JVFdZ0xhjRm9bDA1P8zxE3cafFduZoyuxYnPJj9dU?=
 =?Windows-1252?Q?tyneeoRWNGlkZW8Ge+bv80+z8FQQsOPCAi9gicfdJxczEH3xDdUna9Ad?=
 =?Windows-1252?Q?5HFh5pQzMS1RTswJZ4NgvJdHHGyU6AmUW2BcUDbDiwa1LFSTpjJJjfL/?=
 =?Windows-1252?Q?ipUD3DRM26oEvSU5Vkk=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e83db7-b0b4-443b-3881-08d9f138e401
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:41:29.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zsZUwazruuymQoCnFclCGFg4vL+T8M2mtZp6dULXkXteuT6pm7mbaUmVdhKu1kwV6XZxwv6W6MU+02978nq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2599
X-Proofpoint-ORIG-GUID: odhgMBUgXAj1Z8jn6T9I8LGrw1239BL3
X-Proofpoint-GUID: odhgMBUgXAj1Z8jn6T9I8LGrw1239BL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_04,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/22 10:36 PM, Mark Brown wrote:
> On Mon, Feb 14, 2022 at 10:20:21PM +0800, Yun Zhou wrote:
> 
>> I can't see from anywhere that when cs_change is true, we must keep CS
>> active. If an individual controller needs to keep CS active after the whole
>> message transmission complete, I think we should set cs_change to false
>> rather than true, because cs_change means to change CS, not keep CS,
>> otherwise let us rename cs_change to cs_keep.
> 
> *sigh*  Please also look back at how this has historically been handled,
> this is not new behaviour.
 From the first commit(8ae12a0d85987dc13) for spi subsystem, we can see 
that:
   - An spi_message is a sequence of of protocol operations, executed
     as one atomic sequence.  SPI driver controls include:

       + when bidirectional reads and writes start ... by how its
         sequence of spi_transfer requests is arranged;

       + optionally defining short delays after transfers ... using
         the spi_transfer.delay_usecs setting;

       + whether the chipselect becomes inactive after a transfer and
         any delay ... by using the spi_transfer.cs_change flag; 
 


       + hinting whether the next message is likely to go to this same
         device ... using the spi_transfer.cs_change flag on the last
         transfer in that atomic group, and potentially saving costs
         for chip deselect and select operations
When we want chipselect to become inactive after a transfer completes,
should cs_change be true or false? Although it is not stated here, I 
think it is obviously true, otherwise we should call it cs_keep not 
cs_change.

> I'm not saying that this is the greatest API
> ever or that it'd be done this way if it were new but that doesn't mean
> we can just randomly change the interface and potentially disrupt users.
> Whatever else is going on the current behaviour is intentional.
> 
Although the logic dealing with cs_change in spi_transfer_one_message() 
has existed a long time and nobody reports issue on it, that doesn't 
mean it is correct. I think the main reason is, cs_change is only used 
to change chipselect inactive in the middle of message, and nobody set 
it at the end of message. Even if the cs_change of the end of message is 
set to true, probably there is no impact before 
d347b4aaa1a042ea528e385d9070b74c77a14321, since no matter the chipselect 
is active or inactive, we will set it to active before a new message. 
Even if meet an issue, most of users think it is the incorrect usage 
himself, and then the issue can be solved easily by clearing cs_change 
of the end of message.
So there are several reasons why we must correct it:
1. We cannot accept an API with the name opposite to its actual performance.
2. The wrong cs_change and the lax last_cs_enable have caused serious bug.
3. My patch only affects the last transfer only when cs_change is true. 
I can't think of anyone who will set a flag to complete operations with 
opposite semantics.
