Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D04B0309
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiBJCJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:09:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBJCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:07:39 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB4522C77;
        Wed,  9 Feb 2022 18:03:36 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A1YZif025886;
        Thu, 10 Feb 2022 02:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=nK6M3YbKOK89j9Puv+pru4QdL+CPSgw/3fWcICp6zbI=;
 b=JG2V+FXQu/5NM8SzI065+AglRI/e4JCNhl7aDdnT9zUP0yMVkRtZs+WsYMYVfrTHYiLl
 lDFB+W4FAwB42+1udpgj51TcXYqWSnbzNmb7qYaox1zKjKVXkzkTTsn2q3V0yPi7NR6R
 MjGrm8NG32+3TtFe+YKKN3qCsqTjVmtRLjcaMwNf+5pK/rbky1pAUHAmfkX+IxFpwtM1
 p4BAwewuWINQlj6RxrJO4UHWLpvWpMSnpYpJsRF08an8+pO7y1mIdd1yNkeaku6E2auS
 XPAmTTi1HQO5Rvi2fuJ6R49rk5YyNSXuvvtZl0Is7xcuiYjAZyEJfogtt49qtVhPiSJU Cw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e4fyvrfmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 02:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIaPIuPLhgfCvP+WVgLRAiNrdeFmCOfE38GLZnG3SslTTbo2biHP8WCFpK6rGn0BgmUgsCV9M7wiMPC6q+9MDrgp0CEpsoYhYN9tPJVSuUGLNNw1izvJ60U8O2GLlxv/yVMBHlkqOTuAWTWd0EU8mCUO/H1cYRrsuJ68oHUtiqfHr/wmC8mFbeo7Fp7FrkqxG4EYBMgc6k+wFlGyh+BP1K1THgESboHN6XqN8U+tCyCIuVEJ9IUCBJFHNsghnrtDjTNbOuKnUwGzVKgUx+2J/1dx/fvYI8TwIyw+DsgrWSRw7zd24XF30gxsf+w0dSVQLrCObCp7K3UltankEyKMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOB+H3ngmIsaUoNyAFat0vv8yFoDWD4QE9a2dNk5NDg=;
 b=I2QeNqDUC/5BLO3X4FQZ+Oh4YVmdnnkhSMImwOJzq8Sfk+RW+WxG1jcJVQHxCIpM5mhrkn7WUgGE7EC+A7TW4+XHWm2eAPBcBmtZefMbzm40DYuIYvH4hbLyMCaNH8tKyX+CXpDpq4NRXR7oS7Fj0rLZ82jM2Iqvq5MMedBSyUF31YqJLaui8EyRKWrfHsXp0L3jNB0nLz077TkyMAcv2yafolWfV37GpHn3d1OV4/ZprhrYsaAXn6wAfd2dFaUhAl4IKYmuQ/m0AkLtQb1PZ/QjSnmAC8cEUx2KnZbHD6NDjrjcMsZQ6dvg83NBjItYmOpWliD0WeRTh92moTFa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR11MB3008.namprd11.prod.outlook.com (2603:10b6:805:cf::18)
 by DM5PR11MB1948.namprd11.prod.outlook.com (2603:10b6:3:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 02:03:24 +0000
Received: from SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3]) by SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 02:03:24 +0000
Subject: Re: [PATCH] spi: disable chipselect after complete transfer
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ying.xue@windriver.com
References: <20220209100042.22941-1-yun.zhou@windriver.com>
 <YgPEWyEj7lbQJgAn@sirena.org.uk>
From:   Yun Zhou <yun.zhou@windriver.com>
Message-ID: <07aca74d-c74e-c2a3-b8eb-bdcf9ed21a55@windriver.com>
Date:   Thu, 10 Feb 2022 10:03:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YgPEWyEj7lbQJgAn@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To SN6PR11MB3008.namprd11.prod.outlook.com
 (2603:10b6:805:cf::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af93c26c-496f-429a-2f48-08d9ec398519
X-MS-TrafficTypeDiagnostic: DM5PR11MB1948:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB194838BF596A6BA609597FA39F2F9@DM5PR11MB1948.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5mtsEp+7/LyfbjNvt8p0fn4A4csALYf+yr1VaRsFPquE4fkEwPfUmo48ezNtFfi8X1+oMVm2PiR4DjSF6VfPiZCk/olcAmjLAzC/ifbEa4BTy4aK7lrxkwMVf+M1NKKoUe2V2X8PmH5uxyXLI9ls80SDDY3nGndIIU1NewkwUW81PlwhDr9rz+V9HKc8RtBhT7WYKoxvYwCefyZI/h22WU1gHStZABj4T6B+Q448fIUKL0f9Fg6KDyecIVfjsAvGt7oOMajGHFPCR02PKUJsY5UOWWi1PCVnMWEWD9DOKSffmQv54SyBMZmNQh7dhCi0OGC4PBlGw9tYtYJZ+1rbBB9vJqA/WKdELHQT1KyBOclZ/lMXvJTSZOlEGzqM77AY++95xqFWKgYqmVpJpAXR3jiizp6BKDkiq1y8huEd16bGqHk7qUl2w5WKaNUgnW9ttxXVZqO1ur2li+fZW79CoEiye26xyaHCSSUFEhrhlQL0OobTZXJJUeOfhuJkXgd2onhpM3j0WswbU8Ec9nZjlwPqNv8NU/rdw2MjtlzeB8eXVEk2zz18+0aICzMfdIQN3alkQN36Ah+PB7D+2YP09cil6o9bVdJwtVetHeCS7C6tJqgkc+1GEbxNIZkVcFcKNGZ8gfRPDsie9yAlRLPpmg9N3zir+IU5R06hwWuw3yarj5BdT/DCdVbIuqpm9a5zaa4+TgYAwEXViiEd13Sk0jXNcYE4XDptbV10VMjlrymRf1qFEndJLRN2UjiUyE+6XfoliDp5RIMs9qElpKQJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(107886003)(66556008)(44832011)(6512007)(66946007)(36756003)(4326008)(8936002)(2616005)(66476007)(5660300002)(8676002)(6506007)(38350700002)(186003)(26005)(2906002)(6486002)(31696002)(6916009)(508600001)(31686004)(316002)(6666004)(83380400001)(52116002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?+x7DVJOl84aeBgRmd6/kSWA1bl86OQ5raOb5UxD1sLWeitx81VGCyspc?=
 =?Windows-1252?Q?gVruFtdyXi+/y1ytcGWuAiEfsx/w0E0AdIxAQVLai4huxI4hd6NQe73b?=
 =?Windows-1252?Q?CpY/4ZtXZ3mkimO5jcrW2ZXgdoSyIQp0/lUh8U+5q4bWyGCYL/B4cE1Q?=
 =?Windows-1252?Q?elakDyCcJI6AYeLexBovvXhpH0csyfDD22fam97pw07Twi6RNKklWJl+?=
 =?Windows-1252?Q?kOQvUWbPv6Cf41mreiBGL7O34roeQBgtGpuH3iKMMA3XOfUz6daptKMD?=
 =?Windows-1252?Q?F/iMI17+y4+mUDWSEcQHkDaxJNR5W989S8i/EuOfPush3DrFR1oYC3gN?=
 =?Windows-1252?Q?+503BwW2YYayjJ1qotLIS+nv975WYQJCp+NrlrCm2PYUYVwwbtdfLZHx?=
 =?Windows-1252?Q?tK/i+IoGa5wkt2WNBtj56FHuqo2F6Zwii0d1jG/Mdv44QI8WOyPG2D75?=
 =?Windows-1252?Q?z24x+zoEtv8ei0ClS2vloLKUQAOrI6ObeJ89plFW8Cetu2MlJai6z7Ku?=
 =?Windows-1252?Q?6Jvy3mu65rgbw+meNLslWYRBPVdfVTKMqc0rVXuXT1UfyOTgi0t8+AI4?=
 =?Windows-1252?Q?reGUWWIeR0finj8zmGBY8XHOIO7am2wT3GjZcNI80cKVx1VxgUkWGHZn?=
 =?Windows-1252?Q?tIuboU4KHDjMz+SXYk7j3QgCG+r2sedrLzkjELZcWe7t17LHb3ypJBvK?=
 =?Windows-1252?Q?/oKPe5fReOvNYNA5O205JO3BWY5DgZGfxWzlHbBSYSRq9Z3VVNQQ/5dD?=
 =?Windows-1252?Q?9APZDjo0I1vUB9l5eAgwiPCWMwpYt47SrVnUzyRn8Xn3Gqe+VhFl67Ky?=
 =?Windows-1252?Q?wFdrOVEb5frP2EkcPrA6aZJ5U63cdYZcRJownR5WjLcz4wuX1xqrPXWt?=
 =?Windows-1252?Q?AWIjKYucYH5cjT3bjGSKSJaxNyXpNzcRUo7QTUcw+WQAUE0T2hcz/smV?=
 =?Windows-1252?Q?EBViLijLB14abbToPqgsXU/yYxRdqUTcYcEony9aHBXMIfXUDcihBq88?=
 =?Windows-1252?Q?Ka3qCM0vUhRFTT/ssyxId9tEv+fjvbn/bBzm7/N7TCTpeUv1rOR3pG4y?=
 =?Windows-1252?Q?ZcwvgGSL9QPVVs9eSEbpnW002jEXoJlfO1kvaUn+3pjiGmxZGGTyUupF?=
 =?Windows-1252?Q?ZiOWpdSb32rT6qA0huAmYWZQ8oHyTxXiaM0UaCm/h4ico05iSxJpaaqn?=
 =?Windows-1252?Q?sXqYiPJ9nQ8tlCZ0h+SqRmhdO3J3exZ2uWJbHjA82VbAYP+FikOkmJgB?=
 =?Windows-1252?Q?Dw6NNc29xOli3+4aqnr8JpYKyeNFin4pRjydU+wLhXLaVDjWvfPGUQsC?=
 =?Windows-1252?Q?36VD9/E+9qoGiOR5IRcOwh82DmAUvRPf6BcGFVXY/98JvuqJHIYHBzTL?=
 =?Windows-1252?Q?eioCQgLtsL5cwK+EfN+nc+PBkt2gWpafyuZLpSq65nRrCmtgbK1LhvNr?=
 =?Windows-1252?Q?XacNROdszuOIpJXT7HwYdVoiWkFOnSTGtpYqsb1Bp9UhO/c5sWfg/3Ad?=
 =?Windows-1252?Q?pyuwgPaQGkiJGmns7mqEglY5HolMnetTqHbn3go6/SIYGxB8eg8eQQN5?=
 =?Windows-1252?Q?qLSw8kLTteqYDwMBGclVUQ8OptmqXLujuawQE3ckpybPMyaz5UChcGsG?=
 =?Windows-1252?Q?zdfz0BvwXH5DYIxoMsuHmZGTz/bQP0aOVZkdXTXVMNALN4HOYlecZ4vu?=
 =?Windows-1252?Q?HmWEO10b5QE/TsbRDKoBP/5J1GLU3sjcHFvAQpC4O/elzf8qbKdrG2Dz?=
 =?Windows-1252?Q?p7KKlgKsLtFN6bjQN2M=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af93c26c-496f-429a-2f48-08d9ec398519
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 02:03:24.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKMTYVvclF/L2fZu5nOFr6KrEM3X4sawG9n8ZHphLIMdagO/vsNQUh/QRuoLB5wnIFMxbwu2ktLE25pC5wDi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1948
X-Proofpoint-GUID: mFTj6VOh5QLiLBexP9mx3uBBeZAsJrte
X-Proofpoint-ORIG-GUID: mFTj6VOh5QLiLBexP9mx3uBBeZAsJrte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=746 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100010
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brown,

Nice to get feedback from you!

In current source code of spi_transfer_one_message(),

1420     bool keep_cs = false;

1488         if (xfer->cs_change) {
1489             if (list_is_last(&xfer->transfer_list,
1490                      &msg->transfers)) {
1491                 keep_cs = true;
1492             } else {
1493                 spi_set_cs(msg->spi, false, false);
1494                 _spi_transfer_cs_change_delay(msg, xfer);
1495                 spi_set_cs(msg->spi, true, false);
1496             }
1497         }

1502 out:
1503     if (ret != 0 || !keep_cs)
1504         spi_set_cs(msg->spi, false, false);

if the last xfer->cs_change is true, keep_cs will be true, and it will 
not call spi_set_cs() to set CS to false. Do you mean to keep CS enabled 
in this case?

On 2/9/22 9:40 PM, Mark Brown wrote:
> On Wed, Feb 09, 2022 at 06:00:42PM +0800, Yun Zhou wrote:
>> If there are 2 slaves or more on a spi bus, e.g. A and B, we processed a
>> transfer to A, the CS will be selected for A whose 'last_cs_enable' will
>> be recorded to true at the same time. Then we processed a transfer to B,
>> the CS will be switched to B. And then if we transmit data to A again, it
>> will not enable CS back to A because 'last_cs_enable' is true.
>> In addition, if CS is not disabled, Some controllers in automatic
>> transmission state will receive unpredictable data, such as Cadence SPI
>> controller.
> This sounds like you've got an issue with mixing devices with and
> without CS_HIGH - that is probably broken but...
>
>>   out:
>> -	if (ret != 0 || !keep_cs)
>> -		spi_set_cs(msg->spi, false, false);
>> +	spi_set_cs(msg->spi, false, false);
> ...this will obviously break cs_change support, clearly that's not OK.
> The last_cs_high should be moved to the device.

I do not think it will break cs_change support. In my understanding, 
cs_change indicates whether or not change CS after an xfer completed. 
But at present if the last xfer->cs_change is true, we will not change 
CS to disabled state. Is this the result we want? I'm confused.

I look forward to your help and explanation.

Regards,

Yun

