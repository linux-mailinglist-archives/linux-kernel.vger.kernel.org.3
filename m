Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6A5266BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379380AbiEMQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiEMQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:09:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70131.outbound.protection.outlook.com [40.107.7.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8F6C540
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEgUFUfG5S9JF81gzil81Z3P9dGVUfTXOCj5EO3QObxlNX3Zbq1maErXPUExZe6CqEq4T6kNWCUyh2+tWKMZrfo+Ju5LdIPqu3Soi4PiEw+HiFI034kVB7AURqbKV11in5m2jFiNPaiiVEo9jwuQVcFZKb8rG+Fjvos1K85tx48VP6feHktOJc52BqOFmaJZCKUg/2GX2/oWat8EE6vJJEgFUaxczfruQN6hiH24BxNANcymOFOgziGsM1N+1DNnDpTKfyjv2UnQA6uBB05V9WsdxUfQPglls22q9wwsXvdiRH3lsqjtfxtcXbD2O4eG6KI5z7XTlWAi7AmxuZCotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL4EOGafSiArWzeHjTttw0SmsRh0ctJvuIcggITtIIA=;
 b=TbDxEUcYZQC2xYO5L6ZgDS2+hCGd2+bAj8OKtTwdbdntrn4DxCgOrNYvHg9hB4lS9NsfF7E5yS8ndC2PDdj10IG4LBV7Nphzf00cdWt85dSe5s46GY1NOGBCLm5XuvDD+Sy3q1/21RFpiHi8xxvYE5Q2awmz7mlR34m6iSZNyn84ZxAARxf/Al9Ki9j/fqc6ul4zPZjvZasFYXry+6ll+tSNM+ich9QGi+JmK8FTl0EDPs4NO9nuQqrS1GghJA+pSUUoMo11cX+1ySDUm6gPgQvE5s3elZzIJF/sElfPDyi8nyldp5wYd6mu5rySgMH89JJTBRFSz83b5NoBpuNAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL4EOGafSiArWzeHjTttw0SmsRh0ctJvuIcggITtIIA=;
 b=foswN9KC7RuBuaLGrKnJElVc3T/DGEVJ5gfv8lCEav5RE+Yj9I/GmqpbyQzjYWwK5XjSkaxNjc+LW2pfTmgZlZdYSuJOWH5J5Z/DQN9fuPMSeJRBg/X6M9bOzOXMixHoshIkFH1GbTDuWyayc+Gg19B0tjna693gtxra2Ds60LI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by AM9PR07MB8004.eurprd07.prod.outlook.com (2603:10a6:20b:30e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4; Fri, 13 May
 2022 16:09:43 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::1d35:9369:bda:b3a0]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::1d35:9369:bda:b3a0%6]) with mapi id 15.20.5273.005; Fri, 13 May 2022
 16:09:43 +0000
Message-ID: <d59ec4e0-3bce-2b44-1fc5-54a26fe77c7f@nokia.com>
Date:   Fri, 13 May 2022 18:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mtd: spi-nor: Support Dual and Quad Read on Macronix
 mx25u25635f
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20220513094759.44185-1-alexander.sverdlin@nokia.com>
 <34eccc66cc75dd0ffbf8a77780b6f8a7@walle.cc>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <34eccc66cc75dd0ffbf8a77780b6f8a7@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::45) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55eb0835-6d6b-420b-d41b-08da34fafd83
X-MS-TrafficTypeDiagnostic: AM9PR07MB8004:EE_
X-Microsoft-Antispam-PRVS: <AM9PR07MB8004878527233589E81ACE2788CA9@AM9PR07MB8004.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iRbXRqt7chIaR/OfiRypxMiWapIw38cKECgKHa9lYY/vVFFlSb37tusXtSt1rtjMuc6ylxVMf08B6KnzqJgm7ba/0GENxwexVw6mH+jTR4cqQ3hQ52CTEyRG4z/hL6Lm4ufAMF8PC/NasJ0SOgFG8K4Pdj3tQVztz0kyL+B6peb2PiPPDK/URdP4WUDFwTj/Jhmup2B8yxTZZH7GOykVgD7Tsvg8v+tw+YeXgdyXe2eA8JwRgYRtUkIFCwWFiQGVAmDAbGnSZyvTvWr6ewQM1pAUniNH1JEr8BSwVT2YbivZvpN9hrFT0/VCqBbStZD88WsNL9xS3sREJSdTYJ0wjMIpTivC4SEi5W0E90y4fsSpsyQSTXuO1xJ++b8pKvT6jjMixRc7BiBB6jgVp49yLDfN5IRHNFFmCgw5FOmYmrxb86ie/CzOJTL5FF2jzyjhaVfuqqakj7aw8IP8qevSyNIEAcysFwPAplFIZkheFkf75yggWViV1irY++62TV1YNtsv56LcBVgbebV5FpZ9+hVr8y4tTqL2e24bxqqG//Dssq2mLeKXlU2EHRz1I1rRTuiVSSEinOnhAEwl8wkqTy/eUYNOOzkfGC7VxSLk0kSL8tNhSgRMBa30uEsDy+rEBDogfPzpqJq3F/H2r1VmiCx0T8r4NYtPZ3dnf5cDXzKWARnFFgwwDuT9XyZlrLWCJq8T7T+0S68Sqn4Sb8fuVrq7Ft4BosKU06j9n1CKURxTg48kisITUQB14yOJ8q5RMkEnG7v5dK0ftCuVlm20W2k87k89C4B+5CeKkDYtcAXwD/p2oGbQviyXw3l8aub8eTHYR/4UC8wtjRlfeK3fB3KBbB84JqZiswTWXz5iNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(26005)(6512007)(2616005)(6506007)(52116002)(6666004)(5660300002)(8936002)(2906002)(31686004)(44832011)(36756003)(66556008)(66946007)(54906003)(508600001)(82960400001)(86362001)(31696002)(66476007)(6486002)(966005)(8676002)(4326008)(316002)(186003)(38100700002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUQ3aEZJR1QxMU9yaFRkL1BpcTJYVHdmRGxmWnJ4a3RwOU1pSWZUaGk1VG8r?=
 =?utf-8?B?QTkwclBXaDNUNm5WenRHdEdCRjBnVFdPMGQ0WVdWcFllanh0NGV5WTVRaW5Y?=
 =?utf-8?B?WTNyQzFJMUVkV1ZETlFaQUcxOW1saklja3kzVFFYUE5oNjNUa1l6K1BzL3Zk?=
 =?utf-8?B?VXFBZVAwemVNdDNZRmIyV0xMckNVcXFTaFpMMTF3TVB5UFFtYlhyMkFtMEgz?=
 =?utf-8?B?TnFjZDY0Mnl5OW9kM1VNSWdqL0xlK1grTVF2RDM5WkFDR1QvdFFwWFJndnB5?=
 =?utf-8?B?TFFjNDRHWFNzYjlNdGE5bThJZ0xIRW1QWlBBSXV1bnArMXhpbWpMdFlBU0JF?=
 =?utf-8?B?SXBCSHQrdWpKNHBjMUhqbmx2Uy9uSC85Uk1kdy94MmUvQjlxTlA3cUtMaktm?=
 =?utf-8?B?bVk4RUtEZWRGTmpZSUcvRytacGZWaHNFeXM1WFBFZlpxN2VQMWJSQ3c1ODJm?=
 =?utf-8?B?QjlGOUdGZzVwQzN1UGZsbS80Nno0WVRZRUpiMWd2M3pyYkNQd2U0UGlRR2dp?=
 =?utf-8?B?Y0F5UFN6OVY2a2JnSGJGTFpqWk5DVDRmOEtwRWhCSFkxM2w5OXhXdVQ3YUhN?=
 =?utf-8?B?R3Jpbk1zM1lLcS91YzNHVmxBL2NUajlyRkxHaXR3SmZhOGN4ck1RZVd4aDF0?=
 =?utf-8?B?a0RJK1Y5RHBMRDJ5M0hLUmZZM2dlWVpNaHJ2SzFlUk01cFhNK2pyVGQvL3dG?=
 =?utf-8?B?Z3JYdDFtaDEzL3VCdVYvcGJwaDYwVXBUZC90bzFlWDNMQWMzMXQxRUZ0UUVw?=
 =?utf-8?B?ODN3UjZ3dmF3UVFlTFF2UTNzdUQwMDJMNVJQclpNd3JONml3aFBlTitjVFgz?=
 =?utf-8?B?UE1UL0s1cXRVOEh6MXorTTZ0YjR1eXB2ZmdqcjFCL3RuY0lGUUZWdERsVUFH?=
 =?utf-8?B?b0pQck5YNWpwZW1EMDRBTGFtbU9FcG9oQkFCSDNwdG4rTjhRRmVVaUlPNXoz?=
 =?utf-8?B?NVBKRE5QVmlqaTc3U2JXcGl4SThPc1JMOEVpbCthdmlpenFxS3paemZOWnlX?=
 =?utf-8?B?aStLem5CbVlRZGVuM1p6WHNQK0dadTI2ellYeCszNndIUCt5blNsWWVUZkRY?=
 =?utf-8?B?SGhTUlk2RFliajRHOHBrNDcycmZzeXRHUVNNNFNUTlBOLytpWjM3aExPYTlI?=
 =?utf-8?B?amdlWFlnRGF0eER6SWVHcmZkZnBmcmdxcjhvbG9OSjFZV3AxMGwrNkJjR2Ry?=
 =?utf-8?B?dDhUbENadzc0MlRxVElVQmwzUkU2bmE1bWVOR2RnS3lzVUJoblJRbnoyb3B4?=
 =?utf-8?B?aWx4YmNPS1VQRHRsZTJ6RXJDZVVOTU5kM2xOQVdtVjR6MDRZZHk4S0YrTS9Y?=
 =?utf-8?B?S1VOeTBKWENNdXRpR3hOc1JLandaQnhrS3QrVGxnZDBZTHRCYlNtNmRBVnNB?=
 =?utf-8?B?WEdJMVdKME5IZkVKWCszS3pYdS9pZVF0c2NWcVhvaG04MGlORzRRdzIwZklE?=
 =?utf-8?B?MTlxMFBiSjY1dHdGTUtjVDc5bStFWFRXcFgvQk1tN0x6b25reCtKalJwYUFO?=
 =?utf-8?B?NksxMW9DRkE2MWJkd1cycHU4Zk04SUlFajFjbWMvaUhYTi9QYTZ3b3plK01D?=
 =?utf-8?B?NEZZQmJ4ZURCSEhkdWJWNTB0NnNWaGZON3kvZDdPbG4wdEZ1eG1wL0xjUTU2?=
 =?utf-8?B?VHRzbzhMVDk5b3k4c282OEFHVkFoMzZTK0h6MERTanJpMjZRMTdVWlYyTUYz?=
 =?utf-8?B?Y0lXdWk5TG5QYzRFMU5vTjBtaXNwcmp6WkJ3d0FZTG5NVElHaDBqNjBpa0xG?=
 =?utf-8?B?alRxSU83NFQ3dXVzMkIrVTBJSThJdktTZ2dYeUk1UDlkRzZ0aUdpdmNUdG5M?=
 =?utf-8?B?V1hpTnBOVm9MOUFJQUZvS01NbGlqRWFLQzhSN1dqQW84akVybVlxNnBMRGpB?=
 =?utf-8?B?OWpyUUtYQmFMR0VBaHZxOVprMkRINGhJdHZlcm9MQTFraGZ6bFczMDQvZmhI?=
 =?utf-8?B?cVhqUW5MS2lKQlBURWU3d2I0a3AxVldDR3B3RElTQkZuS08xbGVsakgwc3RG?=
 =?utf-8?B?azBRby9PVWhtUkhhVExNOERWNkNkWmIyQ1RZTmIxbVJzZlY1MzlDZTRCQjFP?=
 =?utf-8?B?YU1hLzFxcDJHd0tSdFZDKzdsdndmc216WlJHckZYM01qcHNaT1NYbElzeFho?=
 =?utf-8?B?M1h0bFNHcWJEK0dWT1cwY2RHZ0lxdzNMRDQySUtWaGttVmhubmdEb1NqUVMx?=
 =?utf-8?B?cWQwQjRjMFB6WmhrdTdzQVNNaU5YZkcwaktYVGdWL3pXcC9OYW1aY1Q3eTc5?=
 =?utf-8?B?L3lUMVA5L09sNHNub28wTjAwZTFBQ3c3bC9MQ0ZUMi8wZGJycGJKbzJCMGhT?=
 =?utf-8?B?WFA0N3pEQnptU0orNnpQVlgwUURVendkMTFJMk5raXR4blpDV0JqajlXTjFW?=
 =?utf-8?Q?laMmO0z7b5gYbY5Q=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eb0835-6d6b-420b-d41b-08da34fafd83
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8658.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 16:09:43.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8PlMpoE7Z+jt2yGHSW8ro5aqVjgO4b1EoMPuP/CVgUftvxIJSivFM/YNAeB0km45g+E+pgolKg6tyyxhPg1m7S9FrsKOU6LXlOqoGe2csc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB8004
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

>> According to datasheet both Dual and Quad Read is supported. The read test
>> shows x3.8 speed gain.
> 
> Does it have SFDP? Try adding PARSE_SFDP instead of the
> NO_SFDP_FLAGS.

Some issues with its SFDP were known:
https://patchwork.ozlabs.org/project/linux-mtd/patch/1492068234-9509-1-git-send-email-dev@kresin.me/
 
> Please post an SFDP dump of this flash [1].

>xxd -p /sys/bus/spi/devices/spi0.0/sfdp
53464450060102ff00060110300000ffc2000104100100ff84000102c000
00ffffffffffffffffffffffffffffffffffe520fbffffffff0f44eb086b
083b04bbfeffffffffff00ffffff44eb0c200f5210d800ff8749b50082d2
04d24403673830b030b0f7bdd55c4a9e29fff050f985ffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff7f8fffff215cdcffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffff002050169df9c06485cbffffffffffff

>md5sum /sys/bus/spi/devices/spi0.0/sfdp
bc360997e729ce1f77f1ff728621d94f /sys/bus/spi/devices/spi0.0/sfdp

>cat /sys/bus/spi/devices/spi0.0/jedec_id
c22539

>cat /sys/bus/spi/devices/spi0.0/partname
mx25u25635f

>cat /sys/bus/spi/devices/spi0.0/manufacturer
macronix

-- 
Best regards,
Alexander Sverdlin.
