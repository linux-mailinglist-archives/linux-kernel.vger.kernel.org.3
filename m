Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE914F1B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380552AbiDDVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379977AbiDDSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:31:40 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F61DA75;
        Mon,  4 Apr 2022 11:29:40 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234HjwM5030450;
        Mon, 4 Apr 2022 11:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MURoIyQhx23B/+bd+ZMHi6qQ0R/BJaFJ9CZQtuCwtOs=;
 b=Syw6t9C2whxuC/dslmV/UmvSw81RWGu9WJKJk7WiShzbXAeDYv65vc7ue/pHWcF3JFAN
 BExfq8iP7Pi9TNn8OUHN5FhT+nAQzSZgzRh45LutMGc4xp0fy9ScyeZE5soEBJDLjJpe
 1t4iHv/niHQpgbnJJIt3OKzKllMlBun817o= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f827025jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 11:29:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjbI6EkKaH6/HSmZ3U9hThTZj+Ny3MSr0yG29m/s2R8XOFsC4Cw280huO6rQk/b37PT4RERZM3U97hBCbwT6FEgi77NXmNtHQ0vFtx+aJkRBLPOXyGqcIjY/CfAuFIYQ+E5UlrYdVX7tgnvax0CWfl44s/PxAWriolAbwuaJ8uwlEUkPWge1Glph+YKc+J+Yu6AdDwqpYVVNeoXEJVI1hyOT8eIYd3plcKM+ZlYal8aDPaEssUbdM3mBDI6opz65OVr03lkktb90D1dmncelbvbFdQUhJFrombe40zgSrkhStsH5oJxkLCVbbkiJ1tEzKWSEkkJDqzbTlZJSw07v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MURoIyQhx23B/+bd+ZMHi6qQ0R/BJaFJ9CZQtuCwtOs=;
 b=ASJ1EqXE9nRwi/SS1HWBO+JvuL3fjDC6MjwpoMUHbwCZTrzkwbPAMAV5r+s9R8aEift3hlCTjBlOv9NEr0tZPRUZ4Lk8zjsj+fmM+ZbKePXpVs/qewpO1W8tOq1AIgOy/orFw9sC04R3PmNaAIjYv4AKRjSfYSwiBrYfdiVyN1t4zryBbYyj7OCozZ+O6dHEd/xPl3S0Z8v2FTH6Fsdx0xP+4MURr/rRoqAl4XIqgBqsZEWxtc1+zWOku/z7R+D9xKpLivFBjXHd35oH7HC30NemP0tZzC3cspEmf0vFhag8jypmK1O49T8BWxgNa4dwPipe+KDI9r1Zw3XYTitSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by MWHPR15MB1231.namprd15.prod.outlook.com (2603:10b6:320:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:29:11 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::28fa:187e:11eb:4c47]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::28fa:187e:11eb:4c47%7]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:29:11 +0000
Message-ID: <367fe64f-0e57-b264-969a-c7cee6344f05@fb.com>
Date:   Mon, 4 Apr 2022 12:29:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
 <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
 <20220404155924.GA9764@lst.de>
From:   Jens Axboe <axboe@fb.com>
In-Reply-To: <20220404155924.GA9764@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:910:5e::34) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa109fd4-a04d-4747-658a-08da16690363
X-MS-TrafficTypeDiagnostic: MWHPR15MB1231:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB12318B8A90D24338BED0D711C0E59@MWHPR15MB1231.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qL7/ej1vYftXPBg77esv4AHOTXZESGITDBDzWejncXSNLiNJ2NUyGQ9UJXZtG7DCY0/amCTSkFXIwGUddsJQU/4BuWtGJMJ1YDBO0NLhCrPCx6BtgYihy724jH/0+B0paJH4Hpj25hJApUvJMaO1nSZtom+wkQ1YApis0EjF9YyYHwCRbxJ5PFiErL51N7r6YKzCBQqJCNyQ8H6gm9R/LVYaHTssbssikUtDTT4CykIe9Y6pIwoBOATS1115bDwQG0vCFjO0axYYOZ2H5RYccT8m6dIDEIh59kOyJoIg5HXDVqo+Zhy3JcCM8LTvvrGnXrOnUYq2UWJLLm6dEIlXGgkd9LmNMWnypuJuLJm6N3fDY6Y2L7HcM7KEwjhAEnhGNBoErOMLK2JCvskWLgxt7skggda2nOx6evne88GtRPrQl0rnxdry1nXFW2jIU51mqKRQeWdD9QNriQCnG+OiCSKWpYhXNFIYJKiT1WRp2/arjPpPF9ku3y2DqnZqFocf2qbxUiCWLskkWcan+Nbs8ynZJvfzNzIeek4EjkQYS4UEO28Up7ENe1CRJ3JWTSyhixk3+VJidECHLJzSD9k5Ek7doSuglzYQjhuPv0ZjrsaaJr6U0w0JXn5mRH+Qnbu8mGCrHMG3XYgbCF8xsOF6QFYtilZnU2osQ0Y3iIOvYnnUDuaUe6GsBEQOUeDM9wOODsWWV3lHvjYGkLb5DqJXJPyQwFLDeZqjN50NwB9UC8cXQ+Np5tdYVn2tZgHQfkBBmD7xoLZc5skXWR9BWVQw1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(47660400002)(6486002)(53546011)(508600001)(4326008)(66476007)(6506007)(8676002)(7416002)(66946007)(66556008)(4744005)(83380400001)(31696002)(54906003)(2906002)(2616005)(86362001)(38100700002)(31686004)(8936002)(36756003)(110136005)(316002)(186003)(26005)(6512007)(6666004)(5660300002)(46800400005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVUcFVPZjc0K1RpVDRRS3R2Tnk1YlQzWVJtZ0NPVnFKUFBjaFVFaE9mSUNi?=
 =?utf-8?B?WGZvN01BMGtFRjBkd1JVdkdQeWExaUE0d215Qm1DUWFyQllFMHJIZTR6aHJm?=
 =?utf-8?B?ak5XME9RR0hjbGNSeFAyb2IvdmJFRFY2MEsxNVZsUUU3aElMRW5uWXBXd29y?=
 =?utf-8?B?T1VYMzQxU2RZODBzL1hQdzNIZk9iRHZDUEJlWEJLTEJRU1V2NWxaWWd0U2th?=
 =?utf-8?B?eTlxTW9BekZEbXQrbUkrS25ENjdxamxjK2dGTlVzQ29uZ1k0NUpGMmlXK3Nn?=
 =?utf-8?B?a1ZUSmQ0bWZrWUkyT1BLZXhjN2pYR0JnMTVqKy9qSWxrVlpYZi9UNHRLd2ho?=
 =?utf-8?B?MVZPRG11QzJiSlFqVTdzUHRZZnNENVFjd1dyV1pNVzJEZXN3NGx2NkR6VkVq?=
 =?utf-8?B?WGQ0RWlYT0JDUEl5azNqY1lGR1k0QzhESjdLMkJlckRMYzNSbnhZcU1sNWZv?=
 =?utf-8?B?UEpibW9YUWsxQjBkd1lKdWpuS2lINWQzS29PcWRKVTlhQVRSckswWE1GMkwz?=
 =?utf-8?B?N1JIMEhkMCs0TzVxUEU3WmlJWWg4YmVxWXNnSzNpRHQxTzV6eXpLdThGMXhx?=
 =?utf-8?B?OHptenlob0xIa2l2WU9LOG96UGhwSTJsRERYcWRVM3F4eEhoam4yZG9MdzJm?=
 =?utf-8?B?Qmwwblc1bDRPekFlVk9vd3NrVUdKV0tCaDRNSC9GdisyZ0NyUkNYem4wWGww?=
 =?utf-8?B?WVgvL1RGcHg2ZHoxcXVXTnVjQzdPaERjNTl0eTMwRDdLcHp5ellDYXptbWJJ?=
 =?utf-8?B?dWdyN0huMk94dldCQ2VpSGU0c0grckpqbEN3ZU1UQm5DNW4wb2F1d1ZRa3dx?=
 =?utf-8?B?aW1hWTJOZWVCZzJ5aGhhRXEzS1RFajdraHFWRktCc1VjTWpKSk01ZXlMVmVu?=
 =?utf-8?B?UURzd09yOXRqcWN3dHhRWHd4SHlpMVM3STF0aUNrRUpaZHhxRW1vNUpuZTBv?=
 =?utf-8?B?djY3Ynh5SFpGdlg0cjdsQnlFTmRaWGhDdEhiL080K2ZXckVRWDdHZWJKSjU0?=
 =?utf-8?B?bDVydldVRmpYVEVsOGRWaHB2aFRXdEFqWFFMOGlhVTB6NEpDamZEL1VuMHhv?=
 =?utf-8?B?ckJpZmZ6RUh3cy9YOVQxTkhWUGVZaDU3WC9OOEgwTVZ4b3BZQ1VZbHIxUTdK?=
 =?utf-8?B?eEd0L1ZVOWthMVVhS3Y2bWpyQ2Y0RVoyRlNKN3lTaCtDbjlyVzRndHM3a0Q5?=
 =?utf-8?B?MGdtWW1UTFVUUGp6NXI5NG54YmphYzBreXRvTVZUWEJvTGFQNzVCcDhKaEdQ?=
 =?utf-8?B?STMxU2tHZ1luTEs0UG04SzRUN2cwOWY3UWFFSy9nckNuNlRqeXJrMllqZzdx?=
 =?utf-8?B?Q2NzMmlVZ2ZLbGxrcDBkVlRKeDlJenIwcFB2QmtQNnZuN1JKeFd2MExwUTFt?=
 =?utf-8?B?NXBrOUpzTnN4NXFlc29MMmxKczEvbEUvNDBETVFzT3ppTkRNYjNzQnJWMWlY?=
 =?utf-8?B?VE9pT3hyV3ZERFNyWDBybmllZlZybEJjUGVEc2tJbEYwSzloZXgwY2tYV3BS?=
 =?utf-8?B?YWVNMDNEU2d2VWtuaUhUQnFWSUhXNGJ4UWxDNFRLc0lja2ZzdEp4bERyV0VE?=
 =?utf-8?B?enUrcE5JL2FrSW5tT1hubG5sLzZYanFlVExuYnd3MU1Fb3h5b1JnUENUQk9U?=
 =?utf-8?B?dVdmNTFsNmtBcDZONWlaUUVUQmVsbmhvMDlDbTRnL3V0Uk5scXdabjh1Q1BC?=
 =?utf-8?B?WmdxV0kzM3FLTEk0R2ZONnhQNGd1S2RyVXM0ajQrTlRYUkQyTTZQYWxXTEhn?=
 =?utf-8?B?cWpCWVJIV05tVzQ0R3BLV2lmTi9kWlhDd2duL3Nha0diN3B3SWxQMTBVUVN1?=
 =?utf-8?B?TUR5dXRoNXovTjQzdklNRkpyWDBZc3lvc0I3UFI2b25rcFlpeE9OM091bDJZ?=
 =?utf-8?B?Umw4cEJLWGc1eGgzenlJeGlhbnd3UDVUa3lFaFRmY2dGUzdzZ2hQUlpSL1hM?=
 =?utf-8?B?QXFpVGxqZGVnOTJUNWdrMW8wNGl1NDVDTUc3MWI1emhWNFUxQU9VTitrTktG?=
 =?utf-8?B?dmZxcmdvcDJ5Sit6Q3d3TDUrOGNHb1Y3OU9JZFpDSXRKRjF5eEl6VXhTU05j?=
 =?utf-8?B?R2NCbDRtZlZ2SWRvTE9oemNGUlB4Ky9lWHdBTnExUyt5SWUrRkZ6cUVmYjFJ?=
 =?utf-8?B?WTNQejZpTkZYRGRRNWtkaExBTytTVkxPcGxSMHpNQ2FPZURGWGkvRFB5LzA3?=
 =?utf-8?B?R0tXOEdmak9IMHZpSW1YQ1grMXBaMFlESG1RaXRvdkZaaUVrbVpkdjhYOFhk?=
 =?utf-8?B?bGE3OWVOOGNIQXhsMU82UU1NUmUrempidDJMT01veUNwU0NLMHdMMVY2MTkr?=
 =?utf-8?B?UG92OWxHRmhNVHFJaFdMdmNkVDE5TmxWU09Wdm1vUGYzS0N1SHpkZz09?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa109fd4-a04d-4747-658a-08da16690363
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 18:29:11.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKyNv2ud3fBG3IZ7MFRm1bDlXrHlTg5epCxzj6j6+HwDlvDPWDKeAZvg1hY6qji6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1231
X-Proofpoint-ORIG-GUID: ezGfk3q64oJIw73xfL8NJtJNgSX6lKXP
X-Proofpoint-GUID: ezGfk3q64oJIw73xfL8NJtJNgSX6lKXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 9:59 AM, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 12:57:33AM +0900, Hector Martin wrote:
>> The kernel hard limit is 100-character lines, not 80-character lines.
>> Maintainers for existing drivers are certainly free to stick to 80 chars
>> if they like it that way, but I don't see why we should still be
>> enforcing that for new code. See bdc48fa11e46.
> 
> Because 100 is completely utterly unreadable if is not for individual
> lines like strings, and that is actually how Linus stated it in
> CodingStyle.
> 
> Your code as-is is completely unreadable and will not go into
> drivers/nvme/ in that form.

Please reconsider how you phrase these objections. Saying the code is
"completely unreadable" because it's _1_ character over your hard limit
is just nonsense, and not a very productive way to deal with this.

-- 
Jens Axboe

