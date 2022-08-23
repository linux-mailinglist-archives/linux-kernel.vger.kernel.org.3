Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF659E767
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbiHWQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbiHWQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:32:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A40E76;
        Tue, 23 Aug 2022 07:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot8/bSF3mK5kBA8JL1acUhn1DOxFaRX7IVZm76JaF7PYgHzo/p3HvnyWXvTuATAPNJXjCkEV2NW2aaaDL7GPqhxBy/yKNgR61fodbq6B/LX1oZml86J5Rd63ewKrDeSQmW5QB7D28JRdbH6yhgaoAXUUO/PzJgWuLx2J1HBW46qUvolZJ46U4x5ImX354HIx29fdHg4snsWZcWlHaR/qtMJV8tZyxeKCyue1TSDB6ig7kBDTL7da05G8we8VlPzQQ2Yqo1fw5dRk9nBCvXXY9oY1n2XpAZcNJX2RUo1kdFemXkyYz6vuYR6EoLnhhGrCw2AXs2Iu9zgC6kcosS9TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o5PaWFKJS+Ht0shq5s39zUmRCVvwZPhv3ULPwGsQ4w=;
 b=OURH8wsqLZvIlUWs1DkRlboDjCJ/2rURDsHahbzU8GcAiEgBh3qo4COZA3YKTbpLQbkZYvXCtrD3sWVMrrun2sa+DwYUtcYX/oL6fQCLoqtAXXCCX1psAUIPK04+g/LgSQA186u1bj1j00ei0ATZZrvCFwo7IDPfo8EumD4SHuziM52YT9+3sJcwKiUUCy+2rhknhUu6sXFypqdL3LdygfmjH977JJ9xPUrgW/41R4mtj5bVupubN2ULg4az4D83+9yHzPrBMT72xpgwLcfLBfwDL2g9aW1vREm9zw6ktMcz6f2wNktoqp/kVGA2CT5dAYY3kdbjDchU7ExwtNuc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o5PaWFKJS+Ht0shq5s39zUmRCVvwZPhv3ULPwGsQ4w=;
 b=FzLmhLgr3V0fDR98S373AuZb1fUABP0W5N2JgQBzAaf2G6zxdv/PIxhQMMYyY+E+44JEneL7FtCaopV5k5mI5k4wUq1tmX6EAChuYFR59FQKSSvGb9/Ly/kFuQFi5fqP3ukE1H5HTfAnBWLIs/Bjbi3Nz4N7BROgTvpV5GHp3upDzRVX3Rd2ZTc4JE9a0M6MFutqpifQIUUYFW4xUbX8gcGiCtciZohbNCZMb7GQi6MgepTFDiTvuJ8oRklxyMsJMOFrByutqE8OJdjhFKfl06rmbgVGuhY6yG7fGBY22bl3eNPXFWzZMleq+MsZpCwWa6XC8grHQPibJpy8D9AaYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB4893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 14:55:01 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 14:55:01 +0000
Date:   Tue, 23 Aug 2022 16:54:59 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Subject: Re: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220823165459.143e1c30@md1za8fc.ad001.siemens.net>
In-Reply-To: <YwToilxquEZGqzQD@smile.fi.intel.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
        <20220823102344.17624-2-henning.schild@siemens.com>
        <YwToilxquEZGqzQD@smile.fi.intel.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::14) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66311a3a-f1e0-4587-1270-08da851774c0
X-MS-TrafficTypeDiagnostic: DB9PR10MB4893:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QvVvKu+Ewk8jq8H/Z7d+wh6ZO1fRtf0DAz0Ft3hFMB+pWRdqkWePBC/I+HcDPb8aXjl4Q5Vm9jmT8LoifCAQegr7WtDO2Q89x3UPSlNqa+A4D+CGEm0SBpAUj4fasi4VEAuHhHhOBzVlkgizkYvsWZgK+rj24rZuAapUlDA/uPIRWoaIwkSB1PeUC5XZpNcGf65Vyi9BCT9zmA+la5tMD2JnJHalSvjCpkOqPMV76xGcTb5cg+LRVbLB5Pu1rhF3PaU5XvrbGagyMsNtpfU71bZW7hzv0LvHHIkkC2mCHtP03y0WYRFNUe123SCmfoGin0ii+iLL79VcnxeCPL5VMX34PqRWwru8LcWRX+6okzpVxiHEkh7HZcUTNj9ZOR1N/l0yDNL1lziiEZUeA4HP8UZ1X4AEWvJjZ0SadNVt8A2lPkARx2pkgZ0NP4fzuGizVkK8GaUsnMljNt0EVJrZl9uuAhWhRbDSBXhB69EztxeoSF5Batd0dcZbtqfqOPHRR0ciIw9uymOAFplqA/E3Py09ceaNwETRtkwUy2APDSLbvI+p//ufaLYXDYgi7Xfk0VNd6DNxGCac8xQmYw7DBp7PixuTADQsLIZs4/bYFF5dQZxgcNVIm5oxSWwFvRxENbSpumTqPLdYqzg0+I9hozF/dDulomQNtRPdrF1chWmhbvnxEf+zZYz/4HsYq5jh8Eh9rYADqpSiYVzDGFsuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(186003)(1076003)(86362001)(38100700002)(82960400001)(8936002)(44832011)(7416002)(5660300002)(6506007)(4326008)(8676002)(66946007)(66556008)(66476007)(2906002)(6486002)(478600001)(41300700001)(6916009)(6512007)(9686003)(54906003)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OxFldHDRoUN4QaU48JE2L49Z4I8U4o22vzGhnwc/PsL4/Iaw3Uc9MDR1Hl5M?=
 =?us-ascii?Q?23xRNnTx8Y2qwkSTMlfCQTfM49Ta6TOW+Ak0R8FXqYXnfD0B49LZSU2O4Q6R?=
 =?us-ascii?Q?zhPp+fSnO3DU5QhYsU65C0OdQKEEjDF8G/UNpj+fxH9Nucg/6txwSPRF0YyC?=
 =?us-ascii?Q?9RPrrmky8bK5UWPtL3osmIS6Dnpe01ITP8Sb84KmAEJ0PbIUdws3OMk/A9bd?=
 =?us-ascii?Q?jfEiHo23r9kSvtgFk59xNqYcc+uy9fNsHHlz1e7viAEpMQ6kmftrrzpXRE00?=
 =?us-ascii?Q?Mki3mNX0n1OSQOsD4GKnLA5RDA+AT0WkhlA9t7YwSm+l6yP8xx1a8S3pqLgU?=
 =?us-ascii?Q?HUbKbd/uRqOe8sPc5gd419kKgOy3lBq61dQGXa7FgUmNSZpfDfedArZjiCMa?=
 =?us-ascii?Q?9EbkXnMWWE/m5uzJPrtlGWnNiLIIJTc70wIprWs+yDYQo9DxBdI7bLRrVDhB?=
 =?us-ascii?Q?DbkfnrYc0GXmywhmlh2s+W5g+G+twthYMCs+uQW/OvXhdoZMca0JyLHeVRC/?=
 =?us-ascii?Q?3EtfiCNSeDFgXx4L/cxyJpUE7nTkKsP1FdVwDaBFL/X7bhUiBloh6+Ilky2S?=
 =?us-ascii?Q?TWdNSOqY1pp5oOzw/Idrs6ymfGfou4vkNm0NI6jFTqDZyhTMREupZ7O98ORq?=
 =?us-ascii?Q?4ABtdY2eIqTv8WGvl9nj6cVWhRILfuSUSY7WowblDB3skYV3cdOF01bwev3F?=
 =?us-ascii?Q?X+ge4Yf63xhBc14DFxIRa9BRGPG710rG1WOPvM7R/A/g9enubBbgmQqZ8iDN?=
 =?us-ascii?Q?UcefKNZNEeMdFcQxWwl0m6jsXHm+B3LbLegAzgkDuBkC+GxynqGZ3V8RuWgv?=
 =?us-ascii?Q?s1Zp59/lca5BpkWDCmPd7+LqzqrDAlG8oPdSh5fEqt1yR/574evclSBuqHX7?=
 =?us-ascii?Q?OjkYHMIyX0bcc9MnQmPZTnEwMbK/FuY9h3hcVE7fjIwyoKAVBy3nWysYsIyK?=
 =?us-ascii?Q?yuqxJZUO6EfzAy4pMOCpSR33RfNdy5/KJFLfTAqNbp+yeMNWFjjRJ+sLPERR?=
 =?us-ascii?Q?JRZY/13QbIaevjBfs4gfwzk0dHMOKUEw+RWzn3nztASybgENTXmcei7vt5Gh?=
 =?us-ascii?Q?B0n7uTJVrkzoRxZ1G3VCfPPdf+C3JXZvmQQZBMLKQymnSCp152GkEeWXtFFS?=
 =?us-ascii?Q?N0wwWYVRKTKhpkZAJt499eVi0NfDPoPAxqX5mW5RNoRxfYSX3f28iZ5r5NTL?=
 =?us-ascii?Q?32PVFG6RbrUGPhNi6q0M98jFbNsuYKqopQqmEEyUo7uqwV2KTExgRaGXNSpp?=
 =?us-ascii?Q?KtqO9NN9p9ZEYtMnAM5OcMZM0tAWT1to7uXCMRuWoh+hgptZ2Wr3rw8ybLl1?=
 =?us-ascii?Q?6CF5ZH8SqTpMDjCVaQKn76+MVCJIalTX63+uIOGEio/1pUairZmpIF2vnIha?=
 =?us-ascii?Q?qSrht5xqKApAkNpZmfT8l94ERAPg6tkrBhwIuAQHMCK3nHhulXnVyLCtRCgW?=
 =?us-ascii?Q?ZaMRivtKtC7LKSVi6n6x1LTFknq8Amn2z6o6MFo204BGNy1mH985q7VqW7od?=
 =?us-ascii?Q?M/O+a41bXCqhOQykuvsTzlk28zpadspO/OGrarEz93jLPT6h7pgk27o4el2E?=
 =?us-ascii?Q?5aenf1ZiF1D5o2/lBGodR0rGDHcHbxLfFuPypyC9tB6SE4tgPBBALOq6NVyW?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66311a3a-f1e0-4587-1270-08da851774c0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 14:55:01.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shnGgd11l3aFL1nipn9zmxsR3b9ZH60Q5GLK+B/Js5Fx7B04+5ejS77cTk0hifHL0OY0dg5FGBvnpXTCUR9iJZ6BtrC0DX12jBHSM+bOJuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 23 Aug 2022 17:47:38 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Tue, Aug 23, 2022 at 12:23:40PM +0200, Henning Schild wrote:
> > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> > very similar to the ones from Fintek. In other subsystems they also
> > share drivers and are called a family of drivers.
> > 
> > For the GPIO subsystem the only difference is that the direction
> > bit is reversed and that there is only one data bit per pin. On the
> > SuperIO level the logical device is another one.
> > 
> > On a chip level we do not have a manufacturer ID to check and also
> > no revision.  
> 
> ...
> 
> > - * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882,
> > F71889 and F81866
> > + * GPIO driver for Fintek and Nuvoton Super-I/O chips  
> 
> I'm not sure it's good idea to drop it from here. It means reader has
> to get this info in a hard way.
> 
> ...

Let us see what others say. I wanted to keep this in line with what
Kconfig says and the oneliner in the Kconfig was getting pretty
longish. Hence i decided to shorten that. Other drivers also seem to
not list all the possible chips in many places, it is all maint effort
when a new chips is added and the list is in like 5 places.

> > +#define gpio_dir_invert(type)	((type) == nct6116d)
> > +#define gpio_data_single(type)	((type) == nct6116d)  
> 
> What's prevents us to add a proper prefix to these? I don't like the
> idea of them having "gpio" prefix.
> 
> ...
> 
> > +		pr_info(DRVNAME ": Unsupported device 0x%04x\n",
> > devid);
> > +			pr_debug(DRVNAME ": Not a Fintek device at
> > 0x%08x\n", addr);
> > +	pr_info(DRVNAME ": Found %s at %#x\n",
> > +		pr_info(DRVNAME ":   revision %d\n",  
> 
> Can we, please, utilize pr_fmt()?
> 
> > +			(int)superio_inb(addr,
> > SIO_FINTEK_DEVREV));  
> 
> Explicit casting in printf() means wrong specifier in 99% of cases.
> 

For all the other comments i will wait for a second opinion. I
specifically did not change existing code for more than the functional
changes needed. And a bit of checkpatch.pl fixing.
Beautification could be done on the way but would only cause
inconsistency. That driver is what it is, if someone wants to overhaul
the style ... that should be another patch. One likely not coming from
me.

Henning
