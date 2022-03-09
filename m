Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56C64D3B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiCIUms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiCIUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:42:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C3CFE4;
        Wed,  9 Mar 2022 12:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytvp7fDhlSfkKm2ldhlVX5WIPm0glqNPphzHPjTnXk5O/MjwPzetXrKd+TrdhhzSJ+9Y/FtAzsQh3+537eohi0u/4fkI8OTMVi4PrrS4Qy/4G4MoSSmtCbLreUu4CKOOzqwwLnDpnAqZA7uM9ldrIzLo3XzCR3I3kaT6CAl4Ogvpra9N0RY9cIlxrYOy4tdi7hqxHc7aJsxNArLVyo3KhVmJOA2FTAW0xgxhOV1w9N28nAsUpGobgp/46KuMDxNkW4MFf3URvyKIoprIEQBrsJ1Ypt7aOIIWQx5ZinA9I7CCtD+dqIb0QvLLAKHihhl9rho92u12pOHVOVAtvm6W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLxDW9snDK6GHihb3M29M0CTvggfn7vKV2FwmTYpt6A=;
 b=Lsy0IU1ijc479CzAEsi44OtDkB7n1a61arVyBWbjkHOctnqws4P9lQDFErxHTH6GTzam8FT+kRagW03DFjvdqWcBMBJbt36jbRt9SfJ/YpQQOvLxKIJTPpK34RpU3FT3Bu49OG65lIpr8uNx+Hqf6A+7KZ7Vu6/telotZ+knaJxbbuNPmPk4bbfiUNsu6/56OdOyos39PeEHxcjgfRGVjv9KvTYfhx2QnraKiEbSeLepxNjKEVQNCZoEZWPrTdi+lUFhi9U0EKp+9a0P4+CMPckbi8LjEpe//koveHz49Jtjs19SgKZz5+vHl/Tx3pdEvG8C62ZXtObzqAJTWHm67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLxDW9snDK6GHihb3M29M0CTvggfn7vKV2FwmTYpt6A=;
 b=AMi3FAThaYJnDtLp7XF2+1Dsu5WZF8tvvq+1ncDDBlrZUYAF69kn9l9m7hQlGsT11G8Pgvz9aLI2Od5BKPKTHm8DtRgOYtWMFhN4hn8qpabQS/oJWlqsTcnn/6FIhvsWUIJ3HdPk7zkb75XPlalz+uPKkNcGsf4iqwYzLgeACfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BN8PR01MB5364.prod.exchangelabs.com (2603:10b6:408:b6::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.20; Wed, 9 Mar 2022 20:41:43 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5038.017; Wed, 9 Mar 2022
 20:41:42 +0000
Date:   Wed, 9 Mar 2022 12:41:27 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        James Morse <james.morse@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: [PATCH v6 1/2] ACPI: tables: Add AGDI to the list of known table
 signatures
In-Reply-To: <CAJZ5v0iY-pV-N7JhuAM4JM99tHVBVnCHj+JyJYpShS4cKA+q_w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2203091234060.4508@ubuntu200401>
References: <20220309020750.65399-1-ilkka@os.amperecomputing.com> <20220309020750.65399-2-ilkka@os.amperecomputing.com> <CAJZ5v0iY-pV-N7JhuAM4JM99tHVBVnCHj+JyJYpShS4cKA+q_w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MWHPR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:300:ef::24) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5177960e-c80d-40fc-29d7-08da020d3822
X-MS-TrafficTypeDiagnostic: BN8PR01MB5364:EE_
X-Microsoft-Antispam-PRVS: <BN8PR01MB53648982F4682D653143B8019D0A9@BN8PR01MB5364.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXqLLZiFtBH1Zv509n65AkiyJVOKwImnjsX08S8bfunTYe5iUW7E1dUAWaE98qWiRGquwEyf01ZZXv8UsqMZ3WF0C/UW1jolY+0VFxpGR/l8bKb1KkixuFDngXh6q5A2klIBUS3GgM5rh9f6sh8z6K7CRbAELobACsUGrobSp07oJaEutfg7O4uuiQ9TA2YB4U79Njn6rY9COqjk+povB57S7nAtKZXvcefyxpkldHbXWCUVzoUcq5GYyiZG8LwWvn7BFwd89Ly5NZMBUUIHeTg6HzEm9h6tLuIKbuTeWu4XOSbaT/VpOugZx32w2o5b5jYLFHgtY15W6xZSlamKqsbXke0UhQQNjl3xjHMCSOnZ3ZHiPN3yQ3lhBR13wmbz+bwyyEU8ke/tW8GdFbNAZXMVIynP8vb5xZlnBK4J7IQb2k8VvD4HBSPqh6b4RTt7eR2x7ywGHcKlilnlUVxo62rzmt+qDbjk/DaJWi3yb9l3w8SMB+SrrFHP9d/B8lKOxzKpa2kVI5Ad/2xA1Rbml4p9Zpz9lEdYbRSzFJsowh5q6V9afSgW2qHlA386Q62wLWyDYxH6HeJpbUW4WKZrAKrZxBMl2nzMlYCUXsk5qEImpxnjsxzxFfYKPzA8hLwd0vHJqkgM2+prNkBicpmCGjldWAFlDMpB3d16owUikbbmxQuxh0/TuGFAamXO3Clwh1cVGFwGxd+BkYTMNEXcQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(26005)(186003)(6512007)(8936002)(6916009)(86362001)(66556008)(66946007)(4326008)(316002)(66476007)(8676002)(107886003)(38100700002)(38350700002)(2906002)(33716001)(83380400001)(5660300002)(7416002)(6666004)(53546011)(52116002)(508600001)(6486002)(6506007)(9686003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sugialWtELGTXDcDkZSCajUeF6NgA6LPYYQKsTtFqxnJp0IAfViz+MosZouP?=
 =?us-ascii?Q?gaf9yQwRpUt6TmOAWypPzVNfUzWxgCUNxgcAws7G73ZziH3fdgIpmVbtO4Sn?=
 =?us-ascii?Q?qT23fuzSixcxHc9nyzHK76lYgxAGjMzBhpErmSE2OusbGH0vAqlXMi3MwCyb?=
 =?us-ascii?Q?pnzBzgQRx8d218NKusLTwbENNHcOnzNvTCSUtbNf6MnzjLxwtD0D8fBLi4Ox?=
 =?us-ascii?Q?3oFYSEGWNIvKl5cTohjSB/5pZGn/a7fhgDwqz8lwxjwLDmJIBbw+KH6XPnPK?=
 =?us-ascii?Q?qnWp0+FIxJYB9TyNje6iIGMo/xXqt3MnejuvHQMK+gmJikln5acfHEhBKH7p?=
 =?us-ascii?Q?2g58g8LjPm0dAF6AUbGFByzzxVndxbMFoa71SE0pbc/VbZjrM6tXWEJtbE+W?=
 =?us-ascii?Q?0iursclG58+9KJD0gl3xLRNTtSTXNnoIK0Tte4gzLoUQA93+tjkJN8aoHO9q?=
 =?us-ascii?Q?kJuRJNpLUCVTdoNRN+TD/v4HaMzJRzAOWYRLdYuISBi3SqiHEoO6jbh2AgmR?=
 =?us-ascii?Q?xeKc5/B3kekmghH3DM/jJBh3+Nd7p+qQ3cWvlc+YFwAdCm/R1KhBt2C25sqg?=
 =?us-ascii?Q?/IxoU3/sDC3kdGP86dsaEriPl46L8pdfAr5yuDplcRSys8o0FIGvRjsyBknh?=
 =?us-ascii?Q?dJMiKp7qF81pcTRFEWeAyO4L0jzgjrgIbJYjub21eE67QPOiba+DggPp1/jY?=
 =?us-ascii?Q?SWGbqbwVjPAAPwRZCIsdRqIDyfo7V3imsRe2z27tOfHqaz5+R3SaSsivkpiR?=
 =?us-ascii?Q?CZycP8AwyEHC0OcRl8A88T9xpjWuX/mlaNNqnwsFG9hC5HzPP1tndh4W+iNC?=
 =?us-ascii?Q?0ic8mRHFNJ/7IMlI/NC+L9GuRalcx5IezM6Cq1dDc+cdbDMRXWkduMrDRfJM?=
 =?us-ascii?Q?NQ2xMxYhcvevG1W1A2gm98cpdKSfJHgLSyLSqzeS/MddX3XAc2+I1P8tgqul?=
 =?us-ascii?Q?L+25+AsfNFyQhBDwocOHelhKGL2NE4uKmKuq+krxfKDb4x3N/NM9Y/FpNa2y?=
 =?us-ascii?Q?1veFk/HblQ5HOkXAyB/cwYv+jGCqTDIFuEasAI8l6z+csyYyuQ9Sw4xi9Im0?=
 =?us-ascii?Q?HPHu5I8ERKTLs80vDXlJhwlQzi/C/a7UIv+1CE+xvtPyO2kiL2ydQmQciAY9?=
 =?us-ascii?Q?botP/2YwWW1EiAOh43q69a9EKwh6kC0VL/Ymo8VBn01iAZT/xGzUpiQDOOW/?=
 =?us-ascii?Q?c4OI3tkFb/3heOCFf5O4di1lCI4xJn1XTlLc9JMXx846xpENUpSjtqtITyEu?=
 =?us-ascii?Q?P2r2dGktNwShuP49lU9VKkjnps8XGLzt/JBAdswi3rKIabT8aMfvHbeAljMv?=
 =?us-ascii?Q?uKwusP7x41yKG6wp0Y/qM5o4k2B8XNWLayjxt22ucHPdJ+V4dJFC69t91OlH?=
 =?us-ascii?Q?B4GFPKQ8WCt1igmhdWSt8r85ngl+Pdg8suNUqnzKJJipGPGUt+v8xIazn2TA?=
 =?us-ascii?Q?Pe79fwDdQIYzRD8dO5ESBZZElgUrpvWyVxn4K9LEQE37vKEG5vLGiQIol7vm?=
 =?us-ascii?Q?fQdgiS2tiTZapNOY62mCUE40DJW36Q4pIvOHJuz09wkumoAir5fqCjJ62k5y?=
 =?us-ascii?Q?0VGGrQFicoQrvF0fZZzTsNOuZM89tu4z8ejirBDQYCb9WqNqVGioeBR2b7LJ?=
 =?us-ascii?Q?8PTJEzrwb9m5t45TQwujOGwYRDjYEpnJuHHrRsRl9l76O8GgnettDhqW/VKP?=
 =?us-ascii?Q?fkMNr8EUHqLfqhNjbzqLVBiraXyhjGK7DjM2oDqdFFvuj0q1AnQB/DfFbSdp?=
 =?us-ascii?Q?Ih+U7B0Hnw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5177960e-c80d-40fc-29d7-08da020d3822
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 20:41:42.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12kGR14icNxWg51KS39POHTo/nS/MGQR2u+FDIUWAyXRsBbCBfPCmuUQjDWdMRz9x7i+LUt6Ah3jy24upP2iu1CvShC/zC9tESJbg6bwaJMeTqBeMH7JGtnbUDFxJh0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5364
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On Wed, 9 Mar 2022, Rafael J. Wysocki wrote:
> On Wed, Mar 9, 2022 at 3:08 AM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
>>
>> Add AGDI to the list of known ACPI table signatures to allow the
>> kernel to recognize it when upgrading tables via initrd.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> ---
>>  drivers/acpi/tables.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 369eb998c3d1..ceee808f7f2a 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -545,7 +545,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>> -       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT };
>> +       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
>>
>>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> I'm noticing that this depends on the linux-next-only commit
> 783dedf41b79ac7a3a68b51cf6f88cbfd6dc3292, so it is probably better if
> I apply it and the other patch in the series can be routed via ARM64.

Sounds good to me, thanks. The other patch needs commit dc4e8c07e9e2 
("ACPI: APEI: explicit init of HEST and GHES in apci_init()") in your 
bleeding edge branch to work but it hasn't been acked yet anyway.

Cheers, Ilkka
