Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468F4B95F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiBQCcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:32:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiBQCci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:32:38 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2094.outbound.protection.outlook.com [40.107.96.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7B15C192;
        Wed, 16 Feb 2022 18:32:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7HlqdUcKYklO8dD2dCg92RGhzbK/C6Yieow+jzfoUyZ6rpqc0CtK5T+vAB2vbqE4QESXgC2aTSALVO4GEzLzNmddpOvUNUPVOtwTHHpLExkZDk4u84IpoCp1K6hGzz8tiyK3CdUTo8xKPrIzLNIMQb7lDeNAvniGN+fJjAxSkdK4xa0U8HCKrvINPCD1iA7VjsO5TttOCeH8qSl63iu/USL3sxQATpXsIXKtili+IbhuEsVzNopV/+M+7fl6qIFONAAGBfT01HpUDTWIYkTUG+zn8Vm0YaYu5l6/c/7km9pTb4rRWO+f526McgUf59lspGTu26lKaScsYr+hl5j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzByQNjLupfr+w2BeTn612ThC0fcwAAaQoMEZgmDT6k=;
 b=aWN5ZMZasGKipBDuXissokPPSoNeFrOR2Tggh+pbHh9opyuCRbiJiDoD9MtnPhgOQFM+VYJSoATgszvxAdsWc/PBa+Nnh2n+/fc0myibUZ6WJ6JQiJJJ1LPbs0PFRMq5rxNFtajciQIE1U/JMOz4XsdxFGAyU7j9q3GxbPQyhlSSIWFJ8UDddyui5QkmQEIUZfU9SN2HnRBtIrQ8sqsrT+xSU+fxFiW5Vjp/iT+amg266aR8xe2HYA3ski1IRIojFm8K8hxL6fTnmk/FkUZFAGNQdtJppgiKKm0/Y6XgHa5rZUAQdteQX+YALmU4mwWcRaKfrmAmq9a8TXl/wHxZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzByQNjLupfr+w2BeTn612ThC0fcwAAaQoMEZgmDT6k=;
 b=mdZe/KoMH9qgSzWaywDK/RmXvD2dTpFDh4cOYozBb8eob7YKDSISon9SNBEW+HtYWYzBqaoYtRRdEU4d61C+dXc2+0hIG3zZCEKKmZMC0vzNm1YW2+wgxOIkxfaB48rJ/Ir6cDuvDuM/YLyQDty6OZJKVNzeDK660UsY7mAtLOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MW4PR01MB6307.prod.exchangelabs.com (2603:10b6:303:74::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Thu, 17 Feb 2022 02:32:19 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7ddf:e242:b5d5:9fe4]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7ddf:e242:b5d5:9fe4%7]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 02:32:19 +0000
Date:   Thu, 17 Feb 2022 10:29:25 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zwang@amperecomputing.com,
        patches@amperecomputing.com, darren@os.amperecomputing.com,
        k-hagio-ab@nec.com, lijiang@redhat.com
Subject: Re: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
Message-ID: <Yg4jhWnfYIGYBLs/@hsj>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
 <20220215164423.GB8458@willie-the-truck>
 <YgzD0ZfZF34u6whJ@hsj>
 <20220216124026.GB9949@willie-the-truck>
 <Yg4dDZGEyRzWcGH1@hsj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg4dDZGEyRzWcGH1@hsj>
X-ClientProxiedBy: CH2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:610:58::33) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52615af5-2348-43d9-a1e0-08d9f1bdb771
X-MS-TrafficTypeDiagnostic: MW4PR01MB6307:EE_
X-Microsoft-Antispam-PRVS: <MW4PR01MB63075DBBE1084A8BEFD65AA8ED369@MW4PR01MB6307.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FuOEo/Ku/borLGwKST7BlnUwKMqUMyoI9tqrxPgsjA8kfaUt1GMG8p8fuohW7iVYIkhj/Z/zce8MYtHIevd0OVO9tJeqD38rwZNoPas4iCSSq8+JSqwCLLN179h8YEjoFIoUb6ds3eA6ts5Be7YN22EBAGJyzwBxVBEl19WnvkETRnGTOhXT7giOavrlsY+YxB8ynK/9uklkSVXZK8fcGmb6oDFkCDIfiEGFNVrSyIEMjNHKgtRqiL+uOTKDMqw0VwhyC5lvStiwjikYKYaP9RRBoVZBsMI6RfkmSMyReGS87saPxovGgeyHKBhE5bnvuBTPqBhKK5sxV8I3y2qWxgzZWUL+VM+/zSOPysZMjiQhZ8yMFiJ0b742GZBAl51KJLYKz4TDm2QISbmotCxF6XFx8Kd7rZFOi9X/oRK1VlmPyyBXVhyQiKfxAzk7Zyed9QSz2fmRYwlnfYF4II2IpeLLMeu2zKKjxFaBDDaDn8sFpVs0i1z2qke5yIovhsbguiiFfCH+WX3rlavXJ3T6px1iSUIBa44HKI3Zj1/XZVJifLkTzrNcYjKmVIHzBBXs87B/RaVVWcxJIT2Id8R7OLtRt/UPL4jD0eSY9/Nf7oHZzn3n3L7+JDRsG3eSHjIs/u0c5buG+KB0mpOx9O5YZ8BmFFV5E/Cn5AYCVjXrYO7/tbBB7zThYJXoE0zmpRxAhMzx91AG7l3zD/TN9kikxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(4744005)(4326008)(8936002)(66556008)(5660300002)(7416002)(66946007)(8676002)(66476007)(83380400001)(6486002)(26005)(38350700002)(6916009)(316002)(38100700002)(52116002)(186003)(6666004)(33716001)(6512007)(9686003)(2906002)(6506007)(86362001)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aV9apwh90EBNkS+LZHJjC320ImCqRid7YuO5mxlJHd+HS56o3ZFFgB4HrtfG?=
 =?us-ascii?Q?NIudzOtauizHbZcvCX+hsFfCLvuGovZxE5rkcVYPmt6CSnlIU6f81by8hjwf?=
 =?us-ascii?Q?LdVnwO5tQn12z3b2PVb6BALXBBCwtV8bSd9FOGwkK/ZpDTa05Czaa46i2Ov2?=
 =?us-ascii?Q?S7zDzzCUPcwj/aYMhTLwKAwQTNN+zBApdmCD36+4k0697+bl9Tul099guYMW?=
 =?us-ascii?Q?uzhV9gkMwCuKm/OTnEcjwqrHlgFknuPV19dHQR3xoMx79ggss8FHAsamb2C7?=
 =?us-ascii?Q?2rCK/Duk9vnZfWKyKw0ApBFslqqf1pwRFNlOlDuW5nmJxqa0HfqC3U+anJVM?=
 =?us-ascii?Q?feU/oDNWTfp2r+EbOZ59wg06xIJGpf2ce74mvQxOmG3YQ3cQVMZALIQ5lSx8?=
 =?us-ascii?Q?vM+4PCIgE4ioxpwUUyGixU0Lx0NoAzRBM1+QG7npp2Y1Vtua9mMyjxT1H3EH?=
 =?us-ascii?Q?qyVHpDL9hx97OpmCPuQkiY1DYgLyUiqKOyqY4/qIxoId2rT2a6UwLoZ9x/TG?=
 =?us-ascii?Q?1nQyXNtwZPEUBMULKo+MxKY6EezQu+IT5Oh9hY+auKkKwmEvlmpOHMaMiTp8?=
 =?us-ascii?Q?1YmV15rYATXWZsFmqs2EhQJ27h/P9A4/uXL737Zdlx3I++LaWvvujZ7wG/9y?=
 =?us-ascii?Q?+EYBGDfwT8hqs9ud54hKTNb9WZPsItXf8crTPz3GRMpZEghhGhRodHW7G+Pe?=
 =?us-ascii?Q?S93Z89G68RIWxQFNEv39KiGaEzr3MewZqJUWX5z0p/LRYK1owjUiHMTi1MAs?=
 =?us-ascii?Q?v4fNYutezdqPsSZCE13bnnO4rqoEgSmS2ovQfmnL4g6zBRvGytM9CKTlRJRJ?=
 =?us-ascii?Q?WGccXmh/jzIgK7jUqVks7i89y/EiWLytMr10b8HrvD9AOmsiyN1sEAQBQ78p?=
 =?us-ascii?Q?KV0wAlyf/37oC3U/Hcwjh6bpMYz1bHhTXxBrWV5rM53RCKbSUgmBqbyuKVs/?=
 =?us-ascii?Q?F7LbovJBsRQiYqZiKn3XESTU1CcCrrnF6291Vd0izdUFXwmVAr4DcHsPNe8M?=
 =?us-ascii?Q?TX1z8Bq6kFz5zuyQftZvH/0W3v9/9xvknWCo38ni3md4Rmvu8208qcHMOp5b?=
 =?us-ascii?Q?e659kt6RSVbLA6Vco+LzdfxtjLDEYUNzZ/36ZTHHWrrv8Z+aBoe1ZrRbIirq?=
 =?us-ascii?Q?tTEZZ2cuLcNMPRcClfX31CTnX7PZZkSZxjydX1BczxU3ySpXNT4BAqRbGX15?=
 =?us-ascii?Q?qKKMGbukjqYUc2BYb097ZKLluBA17jCTvKpMeL9ixsqdidcPl8esVMFYZn2k?=
 =?us-ascii?Q?99LSBh/gZFI+WxPn+6NWwolFR5H/2U6L50ESlUtoryj8vOb5ZycYhfXOXstA?=
 =?us-ascii?Q?aadkVJy94MPHZGIdLhhTY9lvE01XWhj7Czh6QgWtdqAN+DOR5HMloWVTKcef?=
 =?us-ascii?Q?TJAQXWUU4Wx6q3a56hDta0T5una4wlLFr75bfHiP3lriQxjcaaxt6oK6kJDi?=
 =?us-ascii?Q?RkQcJB32yCjj0QFxR1yw04azb5HKfjVvpUF3TZjWA5IYM9Uc2XhQW2w60/CZ?=
 =?us-ascii?Q?YCWpSzdwyI3b8iigKMMBK/muraYRhepwGXtE3y/aaEMTeG8BcADjBlkmcODa?=
 =?us-ascii?Q?uD2Lz/soaHY8BB/DhqNm3HzKJDGHXeMEnsuVZmqP35Fv0RQz9aI4kIMGABuC?=
 =?us-ascii?Q?62fnf4B/189MRJRSJ1TcpB3AxhjGmJaVfS9mz7uFQni3u3e/xcHu02mU7RUw?=
 =?us-ascii?Q?MGcG5lo7RVJzP82XNKaMnBRDLuXbtYZAMeq7StgLsj1N2ymwL3VlXiarqX2t?=
 =?us-ascii?Q?e8PPv4tHJw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52615af5-2348-43d9-a1e0-08d9f1bdb771
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 02:32:18.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL6nDod9zYAQfigdWqeoiHEp1dTtfJJk5hseRERi2Onqzr2JZV2cLkXKT5Vjvwy6t32QgiFSj8iOfFCaiZvwyX+zR/Ig+h7Fv6SvKrf1kjSHUhinUkHjsIcCMwfNFzR0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6307
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:02:03AM +0000, Huang Shijie wrote:
> > Thanks for digging up all of the kernel memory map changes and taking the
> > time to explain the macros. However, all I'm really after is something in
> > the commit message of the patch which explains what is broken without this
> This kernel patch does not break anything.
I mean this kernel patch is not a bugfix, it is just make the ARM64 ecosystem
(including the Crash) a little better..

The Crash can just parse out the MODULES/VMALLOC/VMALLOC ranges from the vmcore file,
no need to calculate them in a very _hard_ way. 

Thanks
Huang Shijie
