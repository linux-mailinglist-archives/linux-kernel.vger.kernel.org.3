Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97565B2809
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIHU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIHU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:59:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F4B2F393;
        Thu,  8 Sep 2022 13:59:50 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288JKowj013866;
        Thu, 8 Sep 2022 13:59:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=/ov0hpkGH0iQUt8lw1xJ4uAlUDHxJxwgzlFGc+3aa4s=;
 b=OBPCyFN9bSjIdYMh+tK1M04OFn8/JtOWPWguu84HdSZMKVhFqyMTfmNqhhDEvgtWHvvZ
 7twNqdf/y81x51oXz6ZcPsr+8Kv11HAUh0gswCONhywrGGRhmezTVAxS4PxFkk9yUbw+
 H68qfq55AXoSxI6PmPhYK+5ma7wZQ6Mo1TA= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfhthb6y4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTviiS9eB56EdEliNeixBN7PngGwpZl+X5q9UFMF19Ar9eF45Xlg15e+TkK5ULNZ5v0MGrplyWgDytsjbLzqEFdupJo9yw/EBuFqQ9EBrW8eJyIQstS9KFg78x4tVFlr3d8gvz8Qwzyc+6NsWH5dKd7TTwzFuQJSTA62KeVwqFbobXDerVzkOJfNz640VLfavBoHcZCz2HjQiBy2VyMPk/ugUfUyhTxe+hb2Nt38lnPYrTH3Cjb+/hVXhWR7jB3LYFVuDX62IpoAjbhlSq3AM7axn1CcqkToKg9sR/8fCjcZgW35kpMxEa6D1ElvjV6/c6vS3T7fawN5wQQCjKV4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ov0hpkGH0iQUt8lw1xJ4uAlUDHxJxwgzlFGc+3aa4s=;
 b=i0tsSnvEpzHlKPXDlIZI47hP3yAtF67C8iEpLw8KlUhGdo474HQGhA9JLsR7dCWcQAINouKKmjM+gnDW0W/I837DN91eUqwd+mK2vXNsTF3xf0jNZ6ACTQ7IXUOQxPZAeAOHmbtubLorFZRe3zJ8gZ0FJoOZg189sGb1IE36+5lrB+SraFQ2bqI7fTLdi+LS6Ve6HkDi/HREedubH+tIugI5cULlWsMWMBHhJdpgVSfaFBerhbVPoB+rotkUlLrXA7bkfr87RoZ+tSXq3aRu9c7RJAc3gMIkUQb7iaOc4ALgUG8NzQS93quRA2ozXFC0W6ycZqwLuS6KfmplCAoDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by DM6PR15MB2284.namprd15.prod.outlook.com (2603:10b6:5:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 20:59:38 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 20:59:36 +0000
From:   "Jonathan Zhang (Infra)" <jonzhang@fb.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Prakash Chauhan <hpc@fb.com>, Chris Petersen <cpetersen@fb.com>
Subject: Re: [PATCH 11/15] cxl/acpi: Extract the host's component register
 base address from RCRB
Thread-Topic: [PATCH 11/15] cxl/acpi: Extract the host's component register
 base address from RCRB
Thread-Index: AQHYvRJCrG4ieCHAYEOkF3tp+JZJhK3WEakA
Date:   Thu, 8 Sep 2022 20:59:36 +0000
Message-ID: <9E6742FC-BC9F-40E4-8812-7E34BC5C08CC@fb.com>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-12-rrichter@amd.com>
In-Reply-To: <20220831081603.3415-12-rrichter@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|DM6PR15MB2284:EE_
x-ms-office365-filtering-correlation-id: c85ad719-3459-427e-dbc6-08da91dd0a1a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eul9C3DcEYGumEswJhfZwUG1nQW3i8SMTkum2TxWOC1otAtp0ivFlVfrQXzWKfrKgJ03pNeLQGTTkQZUQe5IMmqgJjAOWkz2Mxf8OHVX+0qTP18UifVwfzHzITbrqn1gGZPrcAEnAgOtQRpY5AGJ8x6atHUAeGZel0YC5Y9TUGM+D3yAU+hyZjNoFVYVG4C2sTgXDzQ57wfyA5W7UI9SOz6spQhWfB4HOiSUFmwJIHKGD7Wy5HyS44woqCQWrQkgQwF1/Jm5bKOE+bXLnL3czfJsf2RRzAdp6xOVPwDD5EtItTXPMMXNeYrTJRPyiE6L+SbY0chqASA/5UlXlruHCpumSd1GR4eDLdoT5lvaAI1LIwG1HmY4j39Zk+RXOKtIZ2gZ0I6DSo3I7p1+Pjs1Gqev2Go2pWs1r4WUSUgTpiqhhgTp7bt9ZotUA57NLC0ipPmJbDItPFNEdMh146jSGdmoLVkiCNYe3SbWk56K7Kup+TMQjLBoNk5dgPQEyGpyu0mwEsi3U8G819YueFxqVqNMrBMXhxF3KGCsc6RJePuYIhPyC2z6aXCLKej7gm6qrE10MtKSkF/jyDdQIzc26y9w/Kg3BK5oz4Trd2wjJA24NgqZSmaYGyNNa4CXWHNvFpeeKA1rJ/+IbeCl7w/Oi9XZlYWjikKV9evyklJw2qEWesH66APl+Cz226j6SQm+C6uZWSmVhELg27sY6y14HIoCdKN3EV8ZTkfDaAvL504E27/Rok9o8dkMLuuV5TK5CYl6gx02SM90NlrZuJUj0RxZrhk95wZ9QHdcC1S1W2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(33656002)(86362001)(38100700002)(2906002)(122000001)(8936002)(7416002)(5660300002)(38070700005)(66476007)(66556008)(41300700001)(76116006)(66946007)(478600001)(6512007)(6506007)(6486002)(8676002)(83380400001)(91956017)(66446008)(64756008)(4326008)(186003)(71200400001)(54906003)(6916009)(2616005)(53546011)(36756003)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvNKPddpQDB6xkUgsuhr3FVzWANuMyphpkz3tgxCI8aCt8/F+lB596K9ifxw?=
 =?us-ascii?Q?Fri4jQHovY8mleUyQT1oX1R5ITTe0RGLEWdS1/h548SDu7o1MTrGjwXD+ofy?=
 =?us-ascii?Q?TFNySx0LEYwfu6snQyRk8Xmkhqs2iUZ+8ZPoqwdYM0JegxVszvwhSeHAzzAE?=
 =?us-ascii?Q?I1P1roOcpVBzI1rY2xJAAuB5O6jNy4OlkZjCUKUffgjF6184oM+XsHpg0vp6?=
 =?us-ascii?Q?lJP+ZGIKCoyPDcKSDk2eQ6YrK7Ks7xkjEA69nwbl1GgbEDfumFYOOtCNw1my?=
 =?us-ascii?Q?dLHncn+g8ku9Z5ymFJWascjVBWvE24ukRD9NzyUD6JHqaThPC6jVQhuBKtBa?=
 =?us-ascii?Q?TjLkx5U1aghMQevANbJlM2BbBMQlzz2e8mnYy5imHVv2U0yKi5mEg8fSHyT/?=
 =?us-ascii?Q?6r97J1Jhp1dFIijfH5qZwFauyjzXDhGUnzn/T/kj5Z7Y9lz6P/gbq8YBOrnJ?=
 =?us-ascii?Q?J8b+7JGVlMZvF8Mw3EAXLLDR7EYYBSD6qKX4GflzXEuigCx8aJIuE1qheGQw?=
 =?us-ascii?Q?Ydvy1PJ/NItbdYjrvyVvDdR1hhPlwmRYDKt/nDPtqU+PfyNyLt4zKeFdmOEq?=
 =?us-ascii?Q?V75iGjr3oMXQKFSE7KX6QhZabxOLHHjkH7hQZXMaMb3cjdJzjUaqagnyuwNm?=
 =?us-ascii?Q?D2jgxk4kAtHxG76W+rWfVdjb0dt3vNJl3tHOtuV7WOUHJ53ra69dYVsLKDmX?=
 =?us-ascii?Q?hz8kJzbL8db0j83ieZ7KAFXK6VynsQBhyoru8XP4+vOAfPxyCZoqu1Ytu214?=
 =?us-ascii?Q?mF/3MXSPKEomySdrpqqY61G2zWPBqW3Uxo2u32XUnaPhAesx32l0FTp3oR2I?=
 =?us-ascii?Q?e8pg+rX1krGZc3pbY1MZDj8vFvylcn7UJu2sVaAOCA+pMQ3FJbjm1fVoBkB8?=
 =?us-ascii?Q?wSTE2AHoZ9XwZp5czUIeoaRq6kez/yZe1Wk7ZjAfeGrc/toUj1w7TDFIOZkU?=
 =?us-ascii?Q?wPsG+ZLkdeC6dfrYXdfLLtdo5cKUdw19F7PF+QhmjwP0McBAWfZiXalh8edh?=
 =?us-ascii?Q?YHWwUYeRW0WdWeDjdwDOxxDKzu4WVAT9MdPHq67SN9rlRK+lcF8OmOA+pq9x?=
 =?us-ascii?Q?WnAQjsvlDFIajemGhucwX4GmsqMuz7VEvgLs4ob4PJoOwpbob92TOAi8yIda?=
 =?us-ascii?Q?Pw4MdLyrNGdNtq1IwUilDOttRCgrBECs3jfvm8hU/4i9S1Yh4u3h70ltVBd7?=
 =?us-ascii?Q?WLJV4zeAs0c8ynQobhBJyTN1gIoR4x9G39Ng/qxcv+XrKNWwZ3zVtZ3Ow9/N?=
 =?us-ascii?Q?KQXrIp4BMuRk9BlWCsXwSti4dq9UxqC7Exw+MS+gFeOXSLsv73VkyHXtIvkh?=
 =?us-ascii?Q?Y2BAkQ3rNdW5gRXGvmYj+Ho+E1ylG4h31Iu1nTRZTvER0mf9eCUQQ1ZH6kAC?=
 =?us-ascii?Q?EVe+3AHfS6lWB5m/heSAeg8/IMY5OaaKkWKTbh9hhM93HRGBM/lKuFPEvZjy?=
 =?us-ascii?Q?vwdQPDgI2YqmiCf0NxsOPdWbybiihAu83vazdaffOhpDUM7mt4uSl4kU/hOv?=
 =?us-ascii?Q?zwWZr2vUp/YBlZUhgur+PxtQQRwMNcQ29464LpaUzMJP93tvA4nLGqfIBnmw?=
 =?us-ascii?Q?Y13iTFAnGvIJ2xizWBbj4tTrgb9IMdN+Fo/fW6XkxVU8anCOCYyx2uvdlPyE?=
 =?us-ascii?Q?T+EBND0920JeBPAr9Cyt2Bs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DA96C0129CB00468BB6522FCE257028@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ad719-3459-427e-dbc6-08da91dd0a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 20:59:36.9209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H14pNGw57kf2v48NqmbgxI0mPAUJub0k23J7T4ugCoey1bEgKnHU7CMwSqdIsnck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2284
X-Proofpoint-GUID: Emp0pLkmW6ZQ9lhBaE5SBL0RDUJg2rqf
X-Proofpoint-ORIG-GUID: Emp0pLkmW6ZQ9lhBaE5SBL0RDUJg2rqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 31, 2022, at 1:15 AM, Robert Richter <rrichter@amd.com> wrote:
> 
> A downstream port must be connected to a component register block.
> Determine its base address from the RCRB.
> 
> The implementation is analog to how cxl_setup_regs() is implemented
> for CXL VH mode. A struct cxl_component_reg_map is filled in, mapped
> and probed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> drivers/cxl/acpi.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 439df9df2741..88bbd2bb61fc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -401,12 +401,84 @@ static resource_size_t cxl_get_rcrb(u32 uid)
> 	return ctx.chbcr;
> }
> 
> +static resource_size_t cxl_get_component_reg_phys(resource_size_t rcrb)
> +{
> +	resource_size_t component_reg_phys;
> +	u32 bar0, bar1;
> +	void *addr;
> +
> +	/*
> +	 * RCRB's BAR[0..1] point to component block containing CXL subsystem
> +	 * component registers.
> +	 * CXL 8.2.4 - Component Register Layout Definition.
> +	 *
> +	 * Also, RCRB accesses must use MMIO readl()/readq() to guarantee
> +	 * 32/64-bit access.
> +	 * CXL 8.2.2 - CXL 1.1 Upstream and Downstream Port Subsystem Component
> +	 * Registers
> +	 */
> +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +	iounmap(addr);
> +
> +	/* sanity check */
> +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> +		return CXL_RESOURCE_NONE;
> +
> +	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
> +	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +		component_reg_phys |= ((u64)bar1) << 32;
> +
> +	if (!component_reg_phys)
> +		return CXL_RESOURCE_NONE;
> +
> +	/*
> +	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
> +	 * Upstream Port RCRBs).
> +	 */
> +	if (component_reg_phys & (SZ_8K - 1))
> +		return CXL_RESOURCE_NONE;
> +
> +	return component_reg_phys;
> +}
> +
> +static int cxl_setup_component_reg(struct device *parent,
> +				   resource_size_t component_reg_phys)
> +{
> +	struct cxl_component_reg_map comp_map;
> +	void __iomem *base;
> +
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -EINVAL;
> +
> +	base = ioremap(component_reg_phys, SZ_64K);
> +	if (!base) {
> +		dev_err(parent, "failed to map registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	cxl_probe_component_regs(parent, base, &comp_map);
> +	iounmap(base);
> +
> +	if (!comp_map.hdm_decoder.valid) {
> +		dev_err(parent, "HDM decoder registers not found\n");
> +		return -ENXIO;
> +	}
> +
> +	dev_dbg(parent, "Set up component registers\n");
> +
> +	return 0;
> +}
> +
> static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> {
> 	struct pci_host_bridge *host = NULL;
> 	struct acpi_device *adev;
> 	unsigned long long uid = ~0;
> 	resource_size_t rcrb;
> +	resource_size_t component_reg_phys;
> +	int rc;
> 
> 	while ((host = cxl_find_next_rch(host)) != NULL) {
> 		adev = ACPI_COMPANION(&host->dev);
> @@ -425,10 +497,18 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> 
> 		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
> 
> +		component_reg_phys = cxl_get_component_reg_phys(rcrb);
> +		rc = cxl_setup_component_reg(&host->dev, component_reg_phys);

cxl_setup_component_reg() calls cxl_probe_component_regs() which depends on the existence
of HDM decoder capability register. Such register does not exist when the device is in RCRB
mode, attached to a RCH.

> +		if (rc)
> +			goto fail;
> +
> 		dev_info(&host->dev, "host supports CXL\n");
> 	}
> 
> 	return 0;
> +fail:
> +	dev_err(&host->dev, "failed to initialize CXL host: %d\n", rc);
> +	return rc;
> }
> 
> static struct lock_class_key cxl_root_key;
> -- 
> 2.30.2
> 
> 

