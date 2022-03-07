Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15B4D0B13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiCGWab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiCGWa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:30:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A8193FE;
        Mon,  7 Mar 2022 14:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC2DdcL7SJlriOiHV3pAenrACZ6udaO6GkAY/JQ7rZUVoab8wJ9mvC4Cx65hZ44Q5EIt+4qmOguTjR7bFBwS41uPUGo836HEl861vTK5MpPp5QMSfR1H2foMV54nnOUYTdRV6at70K4LRom/VypBOGqOHogzvurFUyOaUIoZsDGzbyx+j8R+jaZlh4MVAPF9iNf09ea3vHyw7NQFlzeBXTpvRmP1ezIuerUDD2kHugLXSTFv5LAhBK5BvO9ixz/qi7ccF+W8oBwedP0qe/G2STl1/VnmNeVI+O73WRse+lSu/Uyl8PXk/O68gCmexwrGakgS6CB6hTYHv+HuEcOmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXwVX0Wb/Ws2rqAPIGgIITm05ZhNc3uLLxXM8/yw1L0=;
 b=dEShK2y7ytgPEd2FYQWt6qwWvvUFqaLWT9SZmYoM92JIl1nZtHx4yuwuAyOJtc+KnZEr+eWHuMO/ul3/3GVmbNj86Fn7Qze+Bz5fbrPvfZBsj4IfNGxVyGcNWIfSIzuNimnUTopu5AMgVX+m9rMAHbXc9c4xmlh/K/wPh8WpKwjlSbXnVT6d4MxhUIor0nsL60odWsGCMvh4CFl4kcxlX0G5X5jK4yHZBkObQ5s0Kzh09m4u5Zm8fCHZZpy4DXcZ6fgzP2rnZTiOySd/6PpebDUJ3Bu3YqcHqTVGrL7mX0clVYlO2J+VG+ctYZypZLG0n9ik5BzxawppyeP4/Un+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXwVX0Wb/Ws2rqAPIGgIITm05ZhNc3uLLxXM8/yw1L0=;
 b=ucVFwPOaY2n/0PFON8pCeBKfNbLX9YNFGB25f7ylD2PvpsGg9ZgKRsAPWliTNCuSnqtRRJkVHR2XmibAcL7Jovwcqn27QJ6YRr7ibXkpU8pHjXAD2LVcnKsp5K12jZHn5tLHOgB7HgbWYgGBNR4lol+Rj8gDjh6/i74dG+Swwc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BN6PR01MB3268.prod.exchangelabs.com (2603:10b6:404:db::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 22:29:27 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5038.017; Mon, 7 Mar 2022
 22:29:27 +0000
Date:   Mon, 7 Mar 2022 14:29:10 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v5 RESEND 0/2] ACPI: Arm Generic Diagnostic Dump and
 Reset device
In-Reply-To: <YiIsYzGeeYWPQKsp@lpieralisi>
Message-ID: <alpine.DEB.2.22.394.2203071424290.3354@ubuntu200401>
References: <20220304054003.152319-1-ilkka@os.amperecomputing.com> <YiIsYzGeeYWPQKsp@lpieralisi>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b0f78fa-9c20-44b5-c3b8-08da0089f004
X-MS-TrafficTypeDiagnostic: BN6PR01MB3268:EE_
X-Microsoft-Antispam-PRVS: <BN6PR01MB3268767BE799DDC09548B1579D089@BN6PR01MB3268.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ME9C4ePp0OHwy01TCMZEzVxguktTjVSFgiS89j1GFTkfBx3W/5nlRA4tJ/rw7DwnQDCRzZ56wEE7KTbCbiyfz6WVl9lx+SxV5jOOywvus1tpdFdAdA4O4VHGJSMk+fHTkvm0kbaG3CnkcGW6v+X9+K30ckwFPqqr855sUG8ZEnfvPC+cpJo6xlDfanXaU/DpPSp5SKXHBGkaba7Q7tguci4Wo1USIV9qOD5iWjm9MNgLoqCtd9mGSMs9buBb0LUdNjMavQA5bWi6AlCrQ1Dzl84C0Es2Z0F8BN0Y7J9WHCkfYid83HpiRRfPfuBGLD9oA25mL0QeJ4KoX0C4hausNGdTfm985BbX1Q4xbKfyRwVNdHQJY5jgz2bnBlqIG8aDt/LTRhD1kHxNKNV0/OMjrSNxu1LQM1sXJcbosH5ASQmVCS/rVJ57D/wX3092TGQNxOy8wfjIrIrrdcGu+SxkRf4s076fGHV1jJXcHZYrzZcLS0b6ltyXMxnrigY9KqQltxxmgXYVf+04r9CexKbpUkwCPbDjBVWLwY2JxzZJFId+OnHhJzRtPyt7nP30pIks3f/p7veyzu1Y+CLS1Y9Ogg9RGQE40CQaKu+9y+kLgVsebSU3qnOmFg0fa1JR4+WWlb0fJIObV0KRroPwOzCzpCK1Y9LFcRAJv7ArW1qPheAH1wr984fHl7XnFJ4UZ4//nsq783b/RSA8qE0V9VApReIEvJtQ1B/RFeD03GMgB6teSggxc0aAbvIxkSZdsB9n9HqTh+3MN4QH/W/AHnFnjD9DVFHekcRfqmo1biIWw6bBa9O8qRFzvd2WXo2+a7cS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6506007)(38350700002)(33716001)(38100700002)(52116002)(966005)(2906002)(83380400001)(107886003)(5660300002)(7416002)(316002)(26005)(8936002)(6512007)(9686003)(66556008)(66946007)(6486002)(86362001)(6916009)(186003)(6666004)(4326008)(8676002)(508600001)(66476007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7O4QJs7ntWe1XuWWW3hEEISCby7bAAFh1k6kgIknw76lIi14HQCk1HkVqoxP?=
 =?us-ascii?Q?wIEmIOen+NbHsg9A5kanG5bAzgqdL6mozRuL8ja4JhZXqwVAjN5xwXYyqPf3?=
 =?us-ascii?Q?AgT0Ls4Fezit/kwnW33Jx2jUzqjo/sQgWnuHXyCrlvvw6So8J53V3iCsJ7qO?=
 =?us-ascii?Q?YidEJdTE1DtDE0UJ68nSw4T+llY7+h7S9BZ2cteCeBO6i8M8dIpui5d/oWAB?=
 =?us-ascii?Q?b0azhsdJVxjTr657Dna/Y0GpiQDriWEXq5mfTNOrLUy1DKDcCPN2S82ZkLuJ?=
 =?us-ascii?Q?2HwhY+6bnHT7uisBNRwSTl7s1jfw3aK2uB8a6nuQTQPuc5B2puUngbpXvrY+?=
 =?us-ascii?Q?1dJ5t5CTl2QBHNA75j8N8Q/oLDSMdfzeyoBIGkyVvb7Z2pX/GYxhA1dptbD+?=
 =?us-ascii?Q?SKDiNPxgaEDgWN1EEwN4TAMvPSHWWqr0vEvsrR8CYlWDzIp5yT8W3MWtu6Xt?=
 =?us-ascii?Q?+2AUIgLufaCywba6rgZwsxbNf74NxeuksikEQdh/hEW+b8lW66wyLcbUeaxx?=
 =?us-ascii?Q?BVI3elsRTrXUAG05XHnGAQeXP3BNKI1/tgEYJgcZdkd5FoB7VJGbEeuPtYQg?=
 =?us-ascii?Q?PgGpOYHTQ41eL6CoduEUMLhPhT3j8Y8RI8CrMb521HLa7in0aefVBvUtmbE0?=
 =?us-ascii?Q?+Eqgf15vSpoU6TdCczFSap7U5+n8LNZQmrKV9l/TYUNOlhWE6+WoPXnHEail?=
 =?us-ascii?Q?vR97m2v3e+tY7vJnn7pGQ5APxxBZkNgCHOlNvugI8RFTkQBV8b6kaIpOnitn?=
 =?us-ascii?Q?tsIeSYlwJEJAs8oDbOOwLM+fychp3lw/9sPO4eUgUSavlU2TeqeDjOXl1rNv?=
 =?us-ascii?Q?t5SoxI8UTTOLuxEQQ2scH8Qb1py779OwkVCJowH+UrwOZMmfWAK+WI6uaik3?=
 =?us-ascii?Q?cxiy/dMRLr04nwIrFArdFgH4EDxzBG54EP60K5jMLU9Yeg006x4G8ys2xCEH?=
 =?us-ascii?Q?JCWkXDD179Xx0fTPnLvDa02Z4yPPjjHTDfWjkxAtNWbA+MDksuYF1p156zYf?=
 =?us-ascii?Q?nuk5+/gquj2X/IKoPGxmbEzznDk1HSmkVku33AfWfXESZ/tXYU/2FiYqh6/5?=
 =?us-ascii?Q?Qb+bx9ycsk2i+qZcZAz6No7Q7Qa8fMSuDYFUFJqNcDxpCqBdh3DZZUvFNou2?=
 =?us-ascii?Q?LVTusFWkTxO1XcXwkiyJneIvOHX6PVr297xaV3AB4n31ShP0/ZcYPXNkbuZ3?=
 =?us-ascii?Q?qrqAfSAMpPULx1ieqBUH/Tj7Ne6niWmkJoB9fDEn/F6H/prQ1bkIjCsvfeB6?=
 =?us-ascii?Q?gaZbEe36MVDkzDxbfihoKphFfZSCF6Zg2YURl7jOXd7kgomm1gecYco2rZoO?=
 =?us-ascii?Q?HS3aMEKBDd9D8dRmwY1CoOsytipSgXzQkMVlFI2dklxDqc2namHNBWfjBLGe?=
 =?us-ascii?Q?kFqBgGRiwOyffocQFi6LoAS+zLCWgUQeF2LFb2aaerX8GuzxT1WPIUTQxJGx?=
 =?us-ascii?Q?f8tamX1WQcw4m2ISDGoC7SJjOLCKZ8HRy0gVqj1ss7zJuO63ujCtzjbTzOY5?=
 =?us-ascii?Q?bsTU19kZvXuD9zp+XrKmAvZnr2816E9AOPsE2MFpyltxjgpQ33wVeSMHAk3g?=
 =?us-ascii?Q?G1WUv6SZ/swHZJUm5O8QLCbxtcjYe3Of4vS5HKzHgn5N2s4TjG3fZUGwywEQ?=
 =?us-ascii?Q?wfBevNiVY7soRBJoC2Mv92Xx9WYUnh4LfMxlt+zlk/iWwPCpNSYGMP8oH4Z+?=
 =?us-ascii?Q?0WlrqwhTcaACn+OFp4Hic/iZ3gEUJwXgfqGyutZDYJnVQ8cNWQ7d61yn6FgI?=
 =?us-ascii?Q?6br9IMIeRw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0f78fa-9c20-44b5-c3b8-08da0089f004
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 22:29:26.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkhhtJpLqUbV0yHlqXEQSgPHADzbtZyy/5cQlXV7et0gwUHxsBk7D46z2fv5Y6LbfYQUoEsp9R/AZerzKRE1ERUd7oBV/tFfPHLOp5Wkkz4Cy8Mq1xdC9DGUhR07cPqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB3268
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2022, Lorenzo Pieralisi wrote:
> On Thu, Mar 03, 2022 at 09:40:01PM -0800, Ilkka Koskinen wrote:
>> Hi Lorenzo,
>>
>> Would you prefer this version, which doesn't have platform
>> device/driver any more?
>
> I thought about that and in order to keep consistency it is better to
> keep the platform device model, so please resend the latest version
> platform device based and I will ACK it (hopefully it is not too late
> for v5.18).

Sure, I can do that. Just one question, do you still prefer agdi_init() 
getting called from acpi_init() or via device_initcall()?

> Please note before resending it that sdei_event_unregister() requires a
> retry loop since it can return -EINPROGRESS (see sdei_unregister_ghes()).

Thanks for pointing out, I'll fix it.

Cheers, Ilkka


>
> Thanks,
> Lorenzo
>
>>
>> --Ilkka
>>
>>
>> ----
>>
>> Arm Generic Diagnostic Dump and Reset device enables a maintainer to
>> request OS to perform a diagnostic dump and reset a system via SDEI
>> event or an interrupt. This patchset adds support for the SDEI path.
>>
>> I do have a patch to enable the interrupt path as well but I'm holding
>> it back since AGDI table is missing interrupt configuration fields
>> (trigger type etc.).
>>
>> The recently published specification is available at
>> https://developer.arm.com/documentation/den0093/latest
>>
>> The patchset was tested on Ampere Altra/Mt. Jade.
>>
>> The patchset applies on top of
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (9db71e8e3027)
>>
>> I also tested it works on top of Shuai Xue's new patches in bleeding-edge branch (c6f4ba2d2b9a)
>>
>> From v1:
>>      * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
>>      * Changed the ACPICA patch upstreaming order comment in the paragraph above
>>
>> From v2:
>>      * The first patch was split. The most of it was merged to ACPICA project
>>        at first and later ported to linux-acpi
>>        (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first
>>        patch.
>>
>> From v3:
>>      Fixed:
>> 	* Moved header files in alphabetical order and removed unnecessary ones
>>
>> From v4:
>> 	* Platform device/driver stuff removed
>> 	* acpi_agdi_init() call moved from device_initcall to acpi_init()
>> 	* Slightly modified Kconfig text to keep checkpatch happy
>>
>> Ilkka Koskinen (2):
>>   ACPI: tables: Add AGDI to the list of known table signatures
>>   ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset
>>     device
>>
>>  drivers/acpi/arm64/Kconfig  | 10 +++++++
>>  drivers/acpi/arm64/Makefile |  1 +
>>  drivers/acpi/arm64/agdi.c   | 52 +++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/bus.c          |  2 ++
>>  drivers/acpi/tables.c       |  2 +-
>>  include/linux/acpi_agdi.h   | 13 ++++++++++
>>  6 files changed, 79 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/acpi/arm64/agdi.c
>>  create mode 100644 include/linux/acpi_agdi.h
>>
>> --
>> 2.17.1
>>
>
